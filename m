Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA52E44EC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhKLRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235340AbhKLRiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:38:04 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 059C160E93;
        Fri, 12 Nov 2021 17:35:14 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mlaSF-0054QF-QI; Fri, 12 Nov 2021 17:35:11 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Guo Ren <guoren@linux.alibaba.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.16, take #1
Date:   Fri, 12 Nov 2021 17:34:59 +0000
Message-Id: <20211112173459.4015233-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, anup@brainfault.org, atish.patra@wdc.com, bhelgaas@google.com, chzigotzky@xenosoft.de, guoren@linux.alibaba.com, nikita.shubin@maquefel.me, palmer@dabbelt.com, robh@kernel.org, plr.vincent@gmail.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small set of fixes for 5.16.

The most interesting one is a fix for the SiFive PLIC, which happens
to ignore an EOI if the interrupt has been masked during the
handling. Ouch. We also have a fix for the csky interrupt controller
which was mixing mask/unmask with disabled/enabled, and a another for
a regression in the OF irq parsing (this last one is carrying Rob's
 Reviewed-by: tag).

Note that the branch is on the same base as tip/irq/urgent
(debe436e77c7).

Please pull,

	M.

The following changes since commit debe436e77c72fcee804fb867f275e6d31aa999c:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2021-11-10 17:05:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.16-1

for you to fetch changes up to 10a20b34d735fb4a4af067919b9c0a1c870dac99:

  of/irq: Don't ignore interrupt-controller when interrupt-map failed (2021-11-12 16:10:00 +0000)

----------------------------------------------------------------
irqchip fixes for 5.16, take #1

- Address an issue with the SiFive PLIC being unable to EOI
  a masked interrupt

- Move the disable/enable methods in the CSky mpintc to
  mask/unmask

- Fix a regression in the OF irq code where an interrupt-controller
  property in the same node as an interrupt-map property would get
  ignored

----------------------------------------------------------------
Guo Ren (2):
      irqchip/csky-mpintc: Fixup mask/unmask implementation
      irqchip/sifive-plic: Fixup EOI failed when masked

Marc Zyngier (1):
      of/irq: Don't ignore interrupt-controller when interrupt-map failed

 drivers/irqchip/irq-csky-mpintc.c |  8 ++++----
 drivers/irqchip/irq-sifive-plic.c |  8 +++++++-
 drivers/of/irq.c                  | 19 ++++++++++++++++---
 3 files changed, 27 insertions(+), 8 deletions(-)
