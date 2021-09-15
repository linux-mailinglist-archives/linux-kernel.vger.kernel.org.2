Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2C840BE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhIODwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbhIODws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:52:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFADEC061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w8so1370470pgf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfimq1QM2ub4RCzsUMT7wxbrZt86ZSDXRQu91Wlfp5Q=;
        b=JDdFqobRqLt1C9EL/bCPgSLe+1r6014LFaqefAW+z7gCruWRHNhVxaeVuhtSMJhVAG
         7d9io1vBFiLJrDkxGuRa2hFbGwDl286hlO/XliN6s5UHH3fJVG2/lsJ7LOgZ9yYIX9hc
         +oxEpNpU979BSNbcSGqj+jeD9xZ4CqDSWYPzfOigKT10PKMQ/C+EaiJF9YRZMMblaQTa
         AQA5vpD9q2nKDC/pZablhBrkzQ1yc8xJXAHzH1jCKkkX8k521flVQhBXszmmnPdpUMgG
         b6R9nEqfTq2KocQo1Od9sIcR2oY4E1BuzoOLgBrQ10njQCdAwbdpSh/OvgNe6GHCruAs
         Oojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfimq1QM2ub4RCzsUMT7wxbrZt86ZSDXRQu91Wlfp5Q=;
        b=YFuh41ZmeZyS+6uAaJDpoGM9ApXdP/7rcdyOando9JE8gP5aJEdxMme6XkzJbjN1jQ
         7oRBbr/Qjs1+2By7qlHqS9YJWzLKq70LRCcF0zpj8UenU/ElQhnC6aTbZ2ras/KSYOyJ
         GeI8PGDAG1AVr7axedVqbhbGWl4bxVs+UhWhGSPkJYzV5VRsDETKjUcSdtCsmwMOax74
         tDs+0WbaYyKZgvu43iRO2T5R6qAts7WNh/OFvad7cQ17zHvl5wqKuiM4z2+INQpxh8q9
         ZrRDFfgnZlduvZs0KUykngb3LJpYf51Vj9dLsRwdPNuSV+FjxNTz/sfBeCveWl2hCzTm
         vPCw==
X-Gm-Message-State: AOAM53070OnURQl/tsmSxpCXiiws7UeBhUOiXSWb7ZZf6+8btA8gFxGi
        pZK3SqzbZLirHNGnk7gGiP0eU8mKKA==
X-Google-Smtp-Source: ABdhPJxtTw/h8SXKYy8qHRGgdZjwIdVKXkNtI9YCxrUXlKu0gqKpKdwB6O6AaDhMQY8wAX9yT6jydw==
X-Received: by 2002:a63:4607:: with SMTP id t7mr18569791pga.332.1631677889263;
        Tue, 14 Sep 2021 20:51:29 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x13sm8602357pfp.133.2021.09.14.20.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 20:51:29 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/5] kernel/watchdog_hld: clarify the condition in hardlockup_detector_event_create()
Date:   Wed, 15 Sep 2021 11:51:00 +0800
Message-Id: <20210915035103.15586-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915035103.15586-1-kernelfans@gmail.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hardlockup_detector_event_create() indirectly calls
kmem_cache_alloc_node(), which is blockable.

So here, the really planned context is is_percpu_thread().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
---
 kernel/watchdog_hld.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..6876e796dbf5 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -165,10 +165,13 @@ static void watchdog_overflow_callback(struct perf_event *event,
 
 static int hardlockup_detector_event_create(void)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
 	struct perf_event_attr *wd_attr;
 	struct perf_event *evt;
 
+	/* This function plans to execute in cpu bound kthread */
+	BUG_ON(!is_percpu_thread());
+	cpu = raw_smp_processor_id();
 	wd_attr = &wd_hw_attr;
 	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
 
-- 
2.31.1

