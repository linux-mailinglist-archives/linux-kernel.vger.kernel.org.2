Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58BC3A4388
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFKN5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhFKN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:40 -0400
Date:   Fri, 11 Jun 2021 13:54:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419682;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bu8CRXR2or4f6988M88yH92m3hKkeR/M1c241kFHPC0=;
        b=clB2UySxPockUVJfg4yqQCYkiohhaLwc6xbMjesU0W+kkYmQzSLqgBk0Hphf1Uf7MPcM3n
        jVotM1pZsYxBLVE83CVF3F5eiXNcY1ueppo9MxBD5KXWzHdKW6Va6g2JY+wzjfU0R1In6s
        cwiIEzAs6M/EL0pJUE5GIPpO/ttyNHuaoot3qAx+khQNubiZFvuFXh1z8OmvOONJ0qKsEB
        eaTpOLROnF4TRJffdhIpj657m/wE0gusT54fgFrKVvYSq/CN3b6UTm/5pHAbloCoayLuj6
        qJQn7JkaxyupX/Y3b9LvGcIGVfc3rPqW8rJu4wQM+dwe4PqHl9SYXZZoYOTMRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419682;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bu8CRXR2or4f6988M88yH92m3hKkeR/M1c241kFHPC0=;
        b=TgL3DD9sS3w6BlVsflQDpn0xDq2ifeUci1K6bSDTcCgn5CNV6UUR+hXjbay2P3A9eakmys
        Qaq9nUzEBHE12aAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] scsi/ibmvscsi: Directly include
 linux/{of.h,irqdomain.h}
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968131.19906.7377287876027292449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5951be4c9c361242c9f0d7c9b9ef03fe82e45c7b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5951be4c9c361242c9f0d7c9b9ef03fe82e45c7b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 14 Sep 2018 09:49:11 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:16 +01:00

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
