Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8E942D092
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhJNCoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJNCoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:44:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01968C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f21so3143945plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPEZG1UTOCdMILrBYHfNzu5EIxiMBByUqdY5jycPoxc=;
        b=lxzz23UgvQBpk6EVby72CERgNBPtwtcWXvKbYgUu9rqY5RRWf2XGRJBkfLNEOq+Hnw
         CnwMGXIh38ez/Uzs4zVLwymHfqIMRxwZ4dVcvCjovXnjgWH9CHGNRi9xMPB5zim4/PaK
         cwG1ayqWpQMDNtpteDZifV8y1MZmXOFU0phUK00goB0aeV0MHVOGEnoFJ8iWLlT2kWeb
         fKLHuGVu15NG8xbCQ8yerKgMcvuUn2kZul02AvSXPkD3BWBY/i4YwU2/LvrFEZUeJppc
         ZS4gsXuMfnW+LaWjmqgNTiBxM65548wroBcqfTrvuaN5DXFaXfl9D0YQ7oo8aOaz3AGs
         ihnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPEZG1UTOCdMILrBYHfNzu5EIxiMBByUqdY5jycPoxc=;
        b=DoPEEBpHc+wp5W/K3/iuUTcdEiuJZKH8u7t50d6Ms44IyGNCcH4K7jkN2u+Bk3xr1L
         96mtpoE5NpwzLxIRDiFSkYThCW6w4RcVoDtoMCjh5tKN9pBEChf4Q8r8x0Ifj4uW8ePQ
         mfUsakpU7hfaUdI4Ub2gptOON58lkNZWVxyJ2gZz7FtkcWW/GNnEiEseM6DuIjMILOVa
         J0g2Fx0/MulOzFdXYqLUACfam0Mp5RCYDXWiD8PSWETFROKEq1G49gVWYXvwzSgFwWG8
         g5sMAHkLpkVDYRKrCfMtazPUK2RzvChXtZLiaUxa3YvaXfTSMgNjUXb1/RpMvJY2Mvpb
         C6jg==
X-Gm-Message-State: AOAM530+N6Ov0wjotsAjZS1R0REy2TgHIFd/I8vzHdtpgskRkwSiju1L
        LUREQGmY+QAlWii+/QtAlM4Wl647qA==
X-Google-Smtp-Source: ABdhPJyg/U09wdEAopvM6ev2T6v/23FdAJfCe329HDtgHDUz1zy3T2j76fZoYZFWx4+JOF4++xvH0Q==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr3351886pjb.127.1634179336371;
        Wed, 13 Oct 2021 19:42:16 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m28sm818403pgl.9.2021.10.13.19.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 19:42:15 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv3 2/4] kernel/watchdog_hld: Ensure CPU-bound context when creating hardlockup detector event
Date:   Thu, 14 Oct 2021 10:41:53 +0800
Message-Id: <20211014024155.15253-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014024155.15253-1-kernelfans@gmail.com>
References: <20211014024155.15253-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hardlockup_detector_event_create() should create perf_event on the
current CPU. Preemption could not get disabled because
perf_event_create_kernel_counter() allocates memory. Instead,
the CPU locality is achieved by processing the code in a per-CPU
bound kthread.

Add a check to prevent mistakes when calling the code in another
code path.

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

