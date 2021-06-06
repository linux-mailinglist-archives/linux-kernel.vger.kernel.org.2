Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1A39CF23
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFFMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFFMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:43 -0400
Date:   Sun, 06 Jun 2021 12:43:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B6QXZqjMhElclwL780NtVsL4ijXTol5fZQHBVtC7mWI=;
        b=g8d4iCWRjiiQoWBO6jOBK8y/mMpSwLVFw/V6lnqvChihdoe+fdK9W1WXvlS8HjnkFG69D5
        gMALl+bLQue3Ah4xNMTsewy7Cz82XJHK9za1MoLsJ6dn/D4Z7+MOfDR3SwnzMOdavHLIWO
        R5EIe3wiEh7YoPSD1b06ozWiZrRtQ8ytAw5Yid0d5CjVMpyIBQJU3BM8ht/lFPsHaHx4yu
        pXbgrXh+sseuSQTXxruQ8OD5jNHzvNIUZ1sNtsPoroj92OWUK2J/ADLKUrTy5DSVaiflrS
        XJVhDORsv/ZphW/rN6ZM6Q0LB6KcccBtthU1AQCAKMIsxXntHlG4VoJNFd6HFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B6QXZqjMhElclwL780NtVsL4ijXTol5fZQHBVtC7mWI=;
        b=/izm3g1Ne3kWHA1hjDntGpboWCBcu/WfzqdGJAAZRjNoN9Ntmp+kli0tsAJDTd18N9DzVk
        D04t2WL5X1ZPh/Dg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] scsi/ibmvscsi: Directly include
 linux/{of.h,irqdomain.h}
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343216.29796.5279464366399216908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     108b411871eb9f165d5f63c194856e9ca4a93d6b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/108b411871eb9f165d5f63c194856e9ca4a93d6b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 14 Sep 2018 09:49:11 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:48 +01:00

scsi/ibmvscsi: Directly include linux/{of.h,irqdomain.h}

A couple of ibmvscsi files are missing the inclusion of linux/of.h
and linux/irqdomain.h, relying on transitive inclusion from another
file.

As we are about to break this dependency, make sure these dependencies
are explicit.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/scsi/ibmvscsi/ibmvfc.c           | 1 +
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 6540d48..715c349 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -13,6 +13,7 @@
 #include <linux/dmapool.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/of.h>
diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 41ac947..10b6c6d 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 
 #include <target/target_core_base.h>
 #include <target/target_core_fabric.h>
