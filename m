Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CB43A4392
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhFKN56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhFKN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:44 -0400
Date:   Fri, 11 Jun 2021 13:54:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=95wSyKdB4h+RavespXKKWWFzNXRBSrGH6ty0ApJTs34=;
        b=RO26VnvEMjytaQH1gqyKcUkb+siiN7fwwrJnsl4/kWkSbQedDKtVW/r/6mYIiPozI+eaf7
        DJpIEqcBh/YI9MTb4zGmZHXTXzfEDxV1vVwFgi01aPY27LXMbsJSjbPCNXrfDMLhEPmmOL
        tnsDZQPx0P4juJ5+KbvbppgeNcPmO2sTziBL7UeM779Y+7XE+BxTW4LKHmQ+1rMBTD7G+9
        EZgWcoI99d0JK2ElOnqYadLgV9pjpk9RRpUCGusYGGr7CWCOuFqzwVWxcfodxuKE2suSnx
        AaTLSgNPZHqZOitQNJfsnfXdPmuLgxsyP1cUAcm0uFAUOP6by/xzVHo3PGL/rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=95wSyKdB4h+RavespXKKWWFzNXRBSrGH6ty0ApJTs34=;
        b=q1ou9/hwrajOTspOXxiN926nrqbGcCQKTeEiTwegLwXs3DgD4NR9OkeeBlNEIa+2bOCKWt
        bVVrSI5JzHl53MAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] staging: octeon-hcd: Directly include linux/of.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968522.19906.11623650142444847384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     aa5f6a89700700fe6fe7e8727581a21a7d679630
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/aa5f6a89700700fe6fe7e8727581a21a7d679630
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 09:31:09 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:15 +01:00

staging: octeon-hcd: Directly include linux/of.h

This drivers currently obtains linux/of.h by luck and a chain of
bizarre inclusions, which we're about to fix.

Let's include the required file directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index f27f20a..a1cd81d 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -50,8 +50,10 @@
 #include <linux/module.h>
 #include <linux/usb/hcd.h>
 #include <linux/prefetch.h>
+#include <linux/irqdomain.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 
