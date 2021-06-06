Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0180139D103
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 21:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFFT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhFFT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:28:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2C1C061767
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 12:26:36 -0700 (PDT)
Date:   Sun, 06 Jun 2021 19:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623007595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VorqEaipdXvj41T+2jLNJJ/YUg4s7u6SI1ScyhsoEKs=;
        b=P2a0iOuDRqKx3+LkhmMLL7sQfAghTQHl5j5UmC3OM+OjpgSrm7MDi3T9VENlcMrD3DsOH2
        9M09I84TlkwYb9+iUcq0JxTqr5g86G7drHJwWn7C8Pns5R7THlbd9mskcGCVUq19hOZFUg
        ir+1ukHj8vauPxDimL94LKDx7zm+bO6DyqajlFZv+YqbhuUeF6pq+pu7wLdxswTuOT0alc
        9m7SJ4lsx8QeDRA/I4osapuPr7Zo3NiiOQ/QtQldE9hvhkzz003OPCFRAopXDxCmeJZekg
        uH3X6n33ymnef6bzNMgUmqKwzmx/7oEJfweAcpJcD+vY32lZhwuDKJzEHOyZdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623007595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VorqEaipdXvj41T+2jLNJJ/YUg4s7u6SI1ScyhsoEKs=;
        b=q4Ke7XF9wsiS1Hs9sDzga65Fe3N9ETKk6RTl9YhYLXPtr/qyWdygzmuKTiLW4QppgVYQAV
        b3cEQcz3gOoBhHCg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] fixup! staging: octeon-hcd: Directly
 include linux/of.h
Cc:     maz@kernel.org, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162300759437.29796.461824426744628595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     69250ebd068edfd2868ef7467a7350acae830074
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/69250ebd068edfd2868ef7467a7350acae830074
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 06 Jun 2021 18:29:32 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Jun 2021 18:29:32 +01:00

fixup! staging: octeon-hcd: Directly include linux/of.h
---
 drivers/staging/octeon-usb/octeon-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index a079bd0..a1cd81d 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -50,6 +50,7 @@
 #include <linux/module.h>
 #include <linux/usb/hcd.h>
 #include <linux/prefetch.h>
+#include <linux/irqdomain.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
