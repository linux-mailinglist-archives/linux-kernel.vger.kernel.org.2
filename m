Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607383A7BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFOK1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:27:22 -0400
Received: from foss.arm.com ([217.140.110.172]:58854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhFOK1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:27:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23874D6E;
        Tue, 15 Jun 2021 03:25:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B80D3F694;
        Tue, 15 Jun 2021 03:25:15 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, maz@kernel.org, paulmck@kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: [PATCH v2 0/2] irq: detect slow IRQ handlers
Date:   Tue, 15 Jun 2021 11:25:05 +0100
Message-Id: <20210615102507.9677-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While fuzzing arm64 with Syzkaller (under QEMU+KVM) over a number of releases,
I've occasionally seen some ridiculously long stalls (20+ seconds), where it
appears that a CPU is stuck in a hard IRQ context. As this gets detected after
the CPU returns to the interrupted context, it's difficult to identify where
exactly the stall is coming from.

These patches are intended to help tracking this down, with a WARN() if an IRQ
handler takes longer than a given timout (1 second by default), logging the
specific IRQ and handler function. While it's possible to achieve similar with
tracing, it's harder to integrate that into an automated fuzzing setup.

I've been running this for a short while, and haven't yet seen any of the
stalls with this applied, but I've tested with smaller timeout periods in the 1
millisecond range by overloading the host, so I'm confident that the check
works.

Thanks,
Mark.

Since v1 [1]:
* Minor commit message tweaks
* Add Paul's Acked-by
* Trivial rebase to v5.13-rc4

[1] https://lore.kernel.org/r/20210112135950.30607-1-mark.rutland@arm.com

Mark Rutland (2):
  irq: abstract irqaction handler invocation
  irq: detect long-running IRQ handlers

 kernel/irq/chip.c      | 15 +++----------
 kernel/irq/handle.c    |  4 +---
 kernel/irq/internals.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug      | 15 +++++++++++++
 4 files changed, 76 insertions(+), 15 deletions(-)

-- 
2.11.0

