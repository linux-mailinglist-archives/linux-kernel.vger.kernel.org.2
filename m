Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0742F3907C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhEYRew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:34:52 -0400
Received: from foss.arm.com ([217.140.110.172]:33014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhEYReq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:34:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 921CB168F;
        Tue, 25 May 2021 10:33:15 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CCBF3F73B;
        Tue, 25 May 2021 10:33:14 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH v2 00/10] irqchip/irq-gic: Optimize masking by leveraging EOImode=1
Date:   Tue, 25 May 2021 18:32:45 +0100
Message-Id: <20210525173255.620606-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

This is the spiritual successor to [1], which was over 6 years ago (!).

Revisions
=========

RFCv1 -> RFCv2
++++++++++++++

o Rebased against latest tip/irq/core
o Applied cleanups suggested by Thomas

o Collected some performance results

Background
==========

GIC mechanics
+++++++++++++

There are three IRQ operations:
o Acknowledge. This gives us the IRQ number that interrupted us, and also
  - raises the running priority of the CPU interface to that of the IRQ
  - sets the active bit of the IRQ
o Priority Drop. This "clears" the running priority.
o Deactivate. This clears the active bit of the IRQ.

o The CPU interface has a running priority value. No interrupt of lower or
  equal priority will be signaled to the CPU attached to that interface. On
  Linux, we only have two priority values: pNMIs at highest priority, and
  everything else at the other priority.
o Most GIC interrupts have an "active" bit. This bit is set on Acknowledge
  and cleared on Deactivate. A given interrupt cannot be re-signaled to a
  CPU if it has its active bit set (i.e. if it "fires" again while it's
  being handled).

EOImode fun
+++++++++++

In EOImode=0, Priority Drop and Deactivate are undissociable. The
(simplified) interrupt handling flow is as follows: 

  <~IRQ>
    Acknowledge
    Priority Drop + Deactivate
    <interrupts can once again be signaled, once interrupts are re-enabled>

With EOImode=1, we can invoke each operation individually. This gives us:

  <~IRQ>
    Acknowledge
    Priority Drop
    <*other* interrupts can be signaled from here, once interrupts are re-enabled>
    Deactivate
    <*this* interrupt can be signaled again>

What this means is that with EOImode=1, any interrupt is kept "masked" by
its active bit between Priority Drop and Deactivate.

Threaded IRQs and ONESHOT
=========================

ONESHOT threaded IRQs must remain masked between the main handler and the
threaded handler. Right now we do this using the conventional irq_mask()
operations, which looks like this: 

 <irq handler>
   Acknowledge
   Priority Drop   
   irq_mask()
   Deactivate

 <threaded handler>
   irq_unmask()

However, masking for the GICs means poking the distributor, and there's no
sysreg for that - it's an MMIO access. We've seen above that our IRQ
handling can give us masking "for free", and this is what this patch set is
all about. It turns the above handling into:

  <irq handler>
    Acknowledge
    Priority Drop

  <threaded handler>
    Deactivate

No irq_mask() => fewer MMIO accesses => happier users (or so I've been
told). This is especially relevant to PREEMPT_RT which forces threaded
IRQs.
    
Functional testing
==================

GICv2
+++++

I've tested this on my Juno with forced irqthreads. This makes the pl011
IRQ into a threaded ONESHOT IRQ, so I spammed my keyboard into the console
and verified via ftrace that there were no irq_mask() / irq_unmask()
involved.

GICv3
+++++

I've tested this on my Ampere eMAG, which uncovered "fun" interactions with
the MSI domains. Did the same trick as the Juno with the pl011.

pNMIs cause said eMAG to freeze, but that's true even without my patches. I
did try them out under QEMU+KVM and that looked fine, although that means I
only got to test EOImode=0. I'll try to dig into this when I get some more
cycles.

Performance impact
==================

Benchmark
+++++++++

Finding a benchmark that leverages a force-threaded IRQ has proved to be
somewhat of a pain, so I crafted my own. It's a bit daft, but so are most
benchmarks (though this one might win a prize).

Long story short, I'm picking an unused IRQ and have it be
force-threaded. The benchmark then is:

  <bench thread>
    loop:
      irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true);
      wait_for_completion(&done);

  <threaded handler>
    complete(&done);

A more complete picture would be:

  <bench thread>   <whatever is on CPU0>   <IRQ thread>
    raise IRQ
    wait
		    run flow handler
		      wake IRQ thread
					    finish handling
					    wake bench thread
    
Letting this run for a fixed amount of time lets me measure an entire IRQ
handling cycle, which is what I'm after since there's one less mask() in
the flow handler and one less unmask() in the threaded handler.

You'll note there's some potential "noise" in there due to scheduling both
the benchmark thread and the IRQ thread. However, the IRQ thread is pinned
to the IRQ's affinity, and I also pinned the benchmark thread in my tests,
which should keep this noise to a minimum.

Results
+++++++

On a Juno r0, 20 iterations of 5 seconds of that benchmark yields
(measuring irqs/sec): 

  | mean | median | 90th percentile | 99th percentile |
  |------+--------+-----------------+-----------------|
  | +11% |   +11% |            +12% |            +14% |

On an Ampere eMAG, 20 iterations of 5 seconds of that benchmark yields
(measuring irqs/sec):

  | mean | median | 90th percentile | 99th percentile |
  |------+--------+-----------------+-----------------|
  | +20% |   +20% |            +20% |            +20% |

This is still quite "artificial", but it reassures me in that skipping those
(un)mask operations can yield some measurable improvement.

Valentin Schneider (10):
  genirq: Add chip flag to denote automatic IRQ (un)masking
  genirq: Define irq_ack() and irq_eoi() helpers
  genirq: Employ ack_irq() and eoi_irq() where relevant
  genirq: Add handle_strict_flow_irq() flow handler
  genirq: Let purely flow-masked ONESHOT irqs through
    unmask_threaded_irq()
  genirq: Don't mask IRQ within flow handler if IRQ is flow-masked
  genirq, irq-gic-v3: Make NMI flow handlers use ->irq_ack() if
    available
  irqchip/gic-v3-its: Use irq_chip_ack_parent()
  irqchip/gic: Convert to handle_strict_flow_irq()
  irqchip/gic-v3: Convert to handle_strict_flow_irq()

 drivers/irqchip/irq-gic-v3-its-pci-msi.c |   1 +
 drivers/irqchip/irq-gic-v3-its.c         |   1 +
 drivers/irqchip/irq-gic-v3.c             |  27 +++--
 drivers/irqchip/irq-gic.c                |  14 ++-
 include/linux/irq.h                      |  15 ++-
 kernel/irq/chip.c                        | 122 ++++++++++++++++++++---
 kernel/irq/debugfs.c                     |   2 +
 kernel/irq/internals.h                   |   7 ++
 kernel/irq/manage.c                      |   2 +-
 9 files changed, 159 insertions(+), 32 deletions(-)

--
2.25.1

