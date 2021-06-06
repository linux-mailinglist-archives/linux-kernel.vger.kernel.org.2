Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE5739D102
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 21:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFFT2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhFFT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:28:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B278C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 12:26:36 -0700 (PDT)
Date:   Sun, 06 Jun 2021 19:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623007594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/Z7Mk4xjfow0i3jL1Mr4rkbkC6cQnWWjnjlJj+dDr6g=;
        b=xw13nLPHurAN9HmWSfYvl7fragH95M0go4BpsCCL4ghf8TX+jVGKuqf2d1wfWv8eYJhy/G
        oNPoYl65IHhpIZtP7yWbP7qT8M4Vz2rhBOwK56qDUvqcMTGDGPRSON0m4N9+KFcwAGX+8Q
        9euWdNV/V/y3VDrouer4A3qFy4Eq+CUJ5tptmQ19dL9jh1b1Pb8Lm3xZMagGmoaDTKHJYa
        hD6DAmYctWkHvgTM6xUUoK3+DPUglBRdVvjbxt+5iy0D77EqlpvY1GJdIUN061Xds2wFJd
        DQ4SLSruIn0Ekim2V6Xl7kTFdydlRNrqJTPPmEbdPR0dz42Clj/f4ij2NKxK8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623007594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/Z7Mk4xjfow0i3jL1Mr4rkbkC6cQnWWjnjlJj+dDr6g=;
        b=xvBBXLlGkRy+fc5R9Hy9lUJnF4Gg3obBKlSpgKv42XVzlUYiaFhddknwSiQLvHZKs9pcAr
        p9e1dEVb4VPFjTAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] fixup! irqdomain: Introduce irq_resolve_mapping()
Cc:     maz@kernel.org, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162300759319.29796.5552916661574311821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9b8a506983a1e5d8c5c0841c66d42b6e309ba60d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9b8a506983a1e5d8c5c0841c66d42b6e309ba60d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 06 Jun 2021 20:19:14 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Jun 2021 20:19:14 +01:00

fixup! irqdomain: Introduce irq_resolve_mapping()
---
 include/linux/irqdomain.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5b7de06..23e4ee5 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -31,8 +31,7 @@
 #define _LINUX_IRQDOMAIN_H
 
 #include <linux/types.h>
-#include <linux/irq.h>
-#include <linux/irqdesc.h>
+#include <linux/irqhandler.h>
 #include <linux/of.h>
 #include <linux/mutex.h>
 #include <linux/radix-tree.h>
@@ -42,6 +41,7 @@ struct fwnode_handle;
 struct irq_domain;
 struct irq_chip;
 struct irq_data;
+struct irq_desc;
 struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
