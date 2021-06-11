Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB683A4393
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhFKN6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhFKN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F38C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:46 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DScQOZbMbCh4YbP2kKeVtck0AfE3VDf9F6Gi1HNR5iw=;
        b=UvQyKHOD9QD5uu8gMAkmHQ50uYzJobOLWlzir2cUBP0kijlyb137iECvrf/o7wbFzP8n64
        SdVvYl1otmnTBqlBrdwMfKqLanZKALra7vQaU1mhAEWKHETKbIziWwUanac+zl9v4Xo21p
        vh8ybQ9L7Zs4OUfkk54Dq0cY0USdHhgefcBuga/WVBleHDn65mSDRezdVPe8JjjJySaamK
        vuPvv1Lr0XvvkzjpWPXHP7Ya2vlkrhpXBx4+qTWvSB6tmkXemeHrObV5TozCDU07r0Sx/S
        lOcy70fpNLV1EoGkqlIoWZVKm/a+MjCU65Cn33GeaI9C9VqSsLgZGUmY4Z652A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DScQOZbMbCh4YbP2kKeVtck0AfE3VDf9F6Gi1HNR5iw=;
        b=Tuolk8BoSgFT/BhDH8yKJCLsfIlffH/TmUCl/v7J+dQ5KxPeJKX9WGTRynZt/YVCtEybqT
        AaY9t5CpZ7QN/bAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] watchdog/octeon-wdt: Directly include
 linux/irqdomain.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968434.19906.5824979606669168375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bc9a454a9440e2872ecf71256fb962e4bb35e937
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bc9a454a9440e2872ecf71256fb962e4bb35e937
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 09:30:34 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:15 +01:00

watchdog/octeon-wdt: Directly include linux/irqdomain.h

This drivers currently obtains linux/irqdomain.h by luck and
a chain of bizarre inclusions, which we're about to fix.

Let's include the required file directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/watchdog/octeon-wdt-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index fde9e73..391c774 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -54,6 +54,7 @@
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include <asm/mipsregs.h>
 #include <asm/uasm.h>
