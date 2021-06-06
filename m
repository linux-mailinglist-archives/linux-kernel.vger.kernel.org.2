Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F272C39CF28
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFFMrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:47:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhFFMpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:45 -0400
Date:   Sun, 06 Jun 2021 12:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TElj5jnf9edw91rvBOTcBtk+v7e26frcOWFThEYK5u0=;
        b=FgP8ouygUQDVOImAq6D8Uqtv22vmRZ1mbU92TS+C+NS9cxk6cRHRgruAk5vX4JNF6EssqG
        HBm0S0/HUcRyxuog0Q7adJUaiM1NjgbVdqcTtP9vUA2lxsewJC8xmfgcdKPnZc8gFgYVYs
        uVkohiez+i4K2fKrzbtCazV/uStyfjPRmpQtWDvCielPo5AwbmrwgoXxeqFMOGvFQ9D2Fm
        AOL4NNKedA0SRhYeKRxwXZKdrW5f+Ve3RRiX7OoRfhYl4h3sbaoMYULmfIGdElkNZHW0gY
        kZMOZH7m1JsSD4nq9tXdJP6x8mV+kGKIniibgVwg20nhuZ9oxX2GAn5GZMt/pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TElj5jnf9edw91rvBOTcBtk+v7e26frcOWFThEYK5u0=;
        b=BXhd4FsutBWcFMh4vjeX2BfWrTK4+JWFP9MNO5OyKmUQMMFf20aZLFMJHpTydQ9g5BGnVD
        jUpN5+bt3JOxF5DA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] watchdog/octeon-wdt: Directly include
 linux/irqdomain.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343483.29796.18340903739200064941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     39c55b6680c30dfa75e5dd4132add7327cb50750
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/39c55b6680c30dfa75e5dd4132add7327cb50750
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 09:30:34 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:47 +01:00

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
