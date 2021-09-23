Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9034160C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbhIWOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbhIWOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:11:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 203so5797151pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lphzpTahG7LS2U3xUhfApocU7Cvv9rH+VCCr6o+2b8Y=;
        b=qcsYU/THvUOnuM29w7s91OlHkUBzEAzfkN0KtxkaHKDFjImyTzJqndOA1fNGd3Zzy2
         V/zgScFiEUXVSE/K6Kgifv7rXgjkuXKiv12CKNXJX60Q49qn0ssI4aLluyHYEoYNzjzt
         k2+dUVPzDzViKMNh1gBxudyzkCFUDnPbPNU2yYlsmfzLeWuGKg9xFqpMCqvJjZBoAiKB
         e6H/epEhJvbb1LAX7GdLBYh99t82SmePrs1Gbxz+7KymQfFjVGjseXrcGrgNBlDJhTV4
         fMpluhxmyV7tJ/GkUR4QBWKK7LlCRitECReP7XV4Dib+S/lUUxG3mep6MHltRmlvKgH5
         DRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lphzpTahG7LS2U3xUhfApocU7Cvv9rH+VCCr6o+2b8Y=;
        b=kzzzxOVonbUhLx13zLms5Y6FzWnNfTpjS7SAk5y5FKkUi2QpLW/2ZhhojJaG14nv55
         2H6BQYbsS89hUHx1rrq2zcRIdXfYMdbuj38gK0SYNopGUVbWLcC94zTX7SqszVcjsKFR
         rMHMNH+jmA6NNUd7wgD3pL8JIrGlToz388qF47CITjghsfrY6WsOVwU5edKQ3Up1NQjj
         AGdSX+UqPNDmeGE3Po3LeLeiFb1IrXGmR4P9CLaGY/mik6QC0V87DuVi1VwdP5kxjhAa
         5XOW5LqfSWZFFyhD6XhlMMxP0iEACzH7KQ/E/hJC1/qLdO1PFc3GT2Hx/4CVfVp6+eGO
         1Sjw==
X-Gm-Message-State: AOAM532w9kj4VERjR7oZW0zlSVYVxnsXvaNHs83hnttZzdbkdL8+3Qk6
        4B49Wdxmn/vGRmruoQLWXsI/kMb0TQ==
X-Google-Smtp-Source: ABdhPJxctOD36OToA6v4P61p+mmh1jpY/eX18Gj8H3Mjg2hsLtwZc/MUzJ7DwkGrLBFHW8DzNuvnSA==
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id a129-20020a627f87000000b00444b07751efmr4653569pfd.61.1632406227945;
        Thu, 23 Sep 2021 07:10:27 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j6sm5800766pfn.107.2021.09.23.07.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:10:27 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 2/4] kernel/watchdog_hld: clarify the condition in hardlockup_detector_event_create()
Date:   Thu, 23 Sep 2021 22:09:49 +0800
Message-Id: <20210923140951.35902-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923140951.35902-1-kernelfans@gmail.com>
References: <20210923140951.35902-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for the context, there are two arguments to change
debug_smp_processor_id() to is_percpu_thread().

  -1. watchdog_ev is percpu, and migration will frustrate the attempt
which try to bind a watchdog_ev to a cpu by protecting this func inside
the pair of preempt_disable()/preempt_enable().

  -2. hardlockup_detector_event_create() indirectly calls
kmem_cache_alloc_node(), which is blockable.

So here, spelling out the really planned context "is_percpu_thread()".

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
Cc: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/watchdog_hld.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..df010df76576 100644
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
+	WARN_ON(!is_percpu_thread());
+	cpu = raw_smp_processor_id();
 	wd_attr = &wd_hw_attr;
 	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
 
-- 
2.31.1

