Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A523373CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhEENwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhEENwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:52:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05690C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:51:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so866457pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y/CTAKzIuKeVAsurTNZSFbDEWvUN/AwDAFxmJzT0nms=;
        b=DzLLaMj0Lgx87w3BkIp+4MM6snNJ3/HHV9Br/aXaoQ6STJzye4LzYr7fEo7rgJZ1N0
         I+ZtIViGeIAHvW/5E+y5JXHyhxn1+cT7fAmIECDhctapolarb/SuJJ1vPA3w73H0qFP+
         dRZtiWpAqOxlVvork+QFV6UDrHEf64x2or9xhCKbs3Sv//fYBhJ3WSJUDEPqcUK20JqP
         MpuXYe4md0vxSoYw8m27rdCX5krP3FefqKc2wRyqcdjrGMQiTO3WGk9R69y+Ga50BawI
         oP3Vo7Fzx+SosIprPRa9TvcjTXuorypGTPufqxZ41CVdbxoJ3mxzmjPxqkN78/kgZE4J
         l8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y/CTAKzIuKeVAsurTNZSFbDEWvUN/AwDAFxmJzT0nms=;
        b=iCqgCgv3tpX9GaGIKRVMkmoRhG8Yue9ytIYq+M4mIiHnGTBWMifIXNj52iLzA0qenP
         kHrbGiSJk0CM6aFRKxeVnr5b4s/S4Ze21qK1sX4D2fSJ7wsIXLjZP4BCpHw+LKWXlKxd
         NftcyMtvP51Wu88Cj7JsyuYpguxENSfnjWjNSGk6qqLrRu3WZQ4mJ54Vc7Hb4gx4EvwM
         khLu+Z4pE2J1eJe567e0AGxsGeY50isQHBWqsPiVrRxRPmU/tFgKQeCjUE46jNqV24eP
         kMMZV8CepOP8+8TD2cXBXYJ+BuHDNwb4TIpd/jNLQ9rbJ8BbcASIABJDhXqAUjRL/qsV
         lYwg==
X-Gm-Message-State: AOAM533cScugBV0LgQFef7YtzuC2jHQfL2Hmh7QfRE/bhgJQ3LEX+PTC
        fvz70mWVjP+uQk9LrcCH9XM=
X-Google-Smtp-Source: ABdhPJyihmU5ExVbrYRHhfLgBX8BHyp1NDS00U+1r3h2pHSTIjrj79btLDXclBTy8wdLyvBcqmGylg==
X-Received: by 2002:a17:902:a9cb:b029:ed:61be:2cfb with SMTP id b11-20020a170902a9cbb02900ed61be2cfbmr31581689plr.9.1620222706620;
        Wed, 05 May 2021 06:51:46 -0700 (PDT)
Received: from localhost ([39.182.0.127])
        by smtp.gmail.com with ESMTPSA id p36sm1880987pgm.74.2021.05.05.06.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 May 2021 06:51:46 -0700 (PDT)
From:   Mingzhe Yang <cainiao666999@gmail.com>
To:     tglx@linutronix.de, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Mingzhe Yang <cainiao666999@gmail.com>
Subject: [PATCH] linux/interrupt.h: fix checkpatch errors
Date:   Wed,  5 May 2021 21:51:36 +0800
Message-Id: <20210505135136.14606-1-cainiao666999@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans several checkpatch errors in the header file.

Signed-off-by: Mingzhe Yang <cainiao666999@gmail.com>
---
 include/linux/interrupt.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850..b9d6a8a 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -529,7 +529,7 @@ extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
  * implement the following hook.
  */
 #ifndef hard_irq_disable
-#define hard_irq_disable()	do { } while(0)
+#define hard_irq_disable()	do { } while (0)
 #endif
 
 /* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
@@ -538,9 +538,8 @@ extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
    al. should be converted to tasklets, not to softirqs.
  */
 
-enum
-{
-	HI_SOFTIRQ=0,
+enum {
+	HI_SOFTIRQ = 0,
 	TIMER_SOFTIRQ,
 	NET_TX_SOFTIRQ,
 	NET_RX_SOFTIRQ,
@@ -565,8 +564,7 @@ enum
  * asm/hardirq.h to get better cache usage.  KAO
  */
 
-struct softirq_action
-{
+struct softirq_action {
 	void	(*action)(struct softirq_action *);
 };
 
@@ -610,8 +608,7 @@ static inline struct task_struct *this_cpu_ksoftirqd(void)
      he makes it with spinlocks.
  */
 
-struct tasklet_struct
-{
+struct tasklet_struct {
 	struct tasklet_struct *next;
 	unsigned long state;
 	atomic_t count;
@@ -652,8 +649,7 @@ struct tasklet_struct name = {				\
 	.func = _func,					\
 }
 
-enum
-{
+enum {
 	TASKLET_STATE_SCHED,	/* Tasklet is scheduled for execution */
 	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
@@ -755,7 +751,7 @@ extern void tasklet_setup(struct tasklet_struct *t,
  * if more than one irq occurred.
  */
 
-#if !defined(CONFIG_GENERIC_IRQ_PROBE) 
+#if !defined(CONFIG_GENERIC_IRQ_PROBE)
 static inline unsigned long probe_irq_on(void)
 {
 	return 0;
-- 
1.8.3.1

