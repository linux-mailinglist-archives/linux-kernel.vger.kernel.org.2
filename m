Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD63C9C26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbhGOJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:53:30 -0400
Received: from foss.arm.com ([217.140.110.172]:50196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239035AbhGOJx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:53:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD1646D;
        Thu, 15 Jul 2021 02:50:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5A473F694;
        Thu, 15 Jul 2021 02:50:35 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     mark.rutland@arm.com, maz@kernel.org, paulmck@kernel.org,
        peterz@infradead.org
Subject: [PATCH v3 0/2]  irq: detect slow IRQ handlers
Date:   Thu, 15 Jul 2021 10:50:29 +0100
Message-Id: <20210715095031.41922-1-mark.rutland@arm.com>
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

Since v2 [2]:
* Trivial rebase to v5.14-rc1

[1] https://lore.kernel.org/r/20210112135950.30607-1-mark.rutland@arm.com
[2] https://lore.kernel.org/r/20210615102507.9677-1-mark.rutland@arm.com

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

