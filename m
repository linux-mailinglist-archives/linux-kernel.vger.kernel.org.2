Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5841B331872
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCHU0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:26:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCHUZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:25:57 -0500
Date:   Mon, 08 Mar 2021 20:25:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615235156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s10eFY4egescFsZG8xG+T7EKh7bI2H45+6vnIYwy5rQ=;
        b=nbVsMOeIjDV5psv/i+bsIqNOjz6ZQzWud8bytVL5PKDbl8N5l/W19sJAAOI2gEpcZAQqK1
        yvHC3TjmQ9XFvrlKo2uSWD9i87DwzPj9FOR3GjO9SFXxkUL42dkcyY2xmLNZFf+yUwQ2hg
        mgeg8JFiczrDqGxxApS14lrDMbtlKPukeHIQ8LBXYAquzssjRZM32pXu6Zw3iRyNF44ziH
        8xj/FYY8Ohzkw0PoREQVI9qtHzWP5jFVcqY5gIB/baUtN5cntBjTSJcsSM9KnlXsSHu3ZQ
        aN90kjBS8jjhq71D6eeHoYhWQolSofxSof0QeNpPLs07unduU/YKJFjd09O+5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615235156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s10eFY4egescFsZG8xG+T7EKh7bI2H45+6vnIYwy5rQ=;
        b=/XcDG77M/1CsAdp0apqkbJBw/ayCtGICGN195o3heXCC36xzKscZOBDQacK+vrkDHvJr6s
        /46js+IXMSu/dECQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ARM: ep93xx: Select
 GENERIC_IRQ_MULTI_HANDLER directly
Cc:     Marc Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
MIME-Version: 1.0
Message-ID: <161523515594.398.13155598945436374478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3e895f4cbd158c31f1295d097a73ea4fe50f88f4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3e895f4cbd158c31f1295d097a73ea4fe50f88f4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 17 Feb 2021 18:10:35 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 08 Mar 2021 20:18:32 

ARM: ep93xx: Select GENERIC_IRQ_MULTI_HANDLER directly

ep93xx currently relies of CONFIG_ARM_VIC to select
GENERIC_IRQ_MULTI_HANDLER. Given that this is logically a platform
architecture property, add the selection of GENERIC_IRQ_MULTI_HANDLER
at the platform level.

Further patches will remove the selection from the irqchip side.

Reported-by: Marc Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Hector Martin <marcan@marcan.st>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 853aab5..5da96f5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -348,6 +348,7 @@ config ARCH_EP93XX
 	select ARM_AMBA
 	imply ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
+	select GENERIC_IRQ_MULTI_HANDLER
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
