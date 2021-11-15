Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658BA451BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbhKPAJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350407AbhKOUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:23:48 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74606C036FAC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 12:10:13 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t83so15771961qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZAvsXMw5VujpbEjnWwHvbWvBPNgg8YXYVEoE9t7ECg=;
        b=Uh3/RBwTszJDkfZwDcl1v2hZCuzXcEXIGt822Hi0S97Bw2FhTtT1RUhI8uCgFtzs6n
         wQ94ldpu0lUS9D+Yy1asUQXqqXxNYqIMfQdKr0g0i0NW7kTxihduOQj3QqRUqiz3LM/3
         uIqzcivTIJo/ZIe048N1QKD01XnagxGYkNAXQ4tpVDzdxt0xe8hxh1lprJiE4bp2CFYm
         iaiApc/Pxu3XzTISOi6x+MXZgw54tyrETX1ks0lkx1MG1Z4D3M38QPGpy6gqY9o+pVy7
         D5iZiswlmmc8/qSukJLeE0jYpMdXtlQ3tJCGNw7lNsv/qKXhwTtOks/CCJWvdm3Jtaom
         tR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZAvsXMw5VujpbEjnWwHvbWvBPNgg8YXYVEoE9t7ECg=;
        b=3SBHsWlnJMVZZH2NILIKqfaygReR/MFdXrxcVjcd4nqGnmoVDfZlNQmSpsiehdF4c0
         c0eoV0CkbsxvjM+ODOVpttZr9B/Z1lnWTEmxC54Bpnobk4lRxbzUTKBpy0LcQ7sPKT96
         8ecuUEfDjqz5XtK0DXp88RXdxhbEnrab6o9AIU8NHuVJb4fXoSMh3tcojyS8EJLyTysv
         TVEffBWX15bp/jo+Oqd2JH11uFjQvK+rrdmzR9iZ4tTI3vEnLtp/CTWUC6QqzoGRurHr
         PGo4mAl9ppqGfRyUDk9MYGHRu8aBRfcSl4KMW9MxvT6ZnJ2UI17S1cq18WJB90xgq0H1
         5FOA==
X-Gm-Message-State: AOAM530HieyYB7eE1jELo2P1c1Shyq2d6bHGGGqJPOibLT9vMF+s28FQ
        h+78OPI5oWYzy1EluMQxv2cYAw==
X-Google-Smtp-Source: ABdhPJwg4OYwLbT2S33NVs6YPRAeSmxuo7GGJChe7nuFNWv6zdzQcXKKQMzMrLNXDOMAk2Hm8xVU7w==
X-Received: by 2002:a05:620a:288f:: with SMTP id j15mr1509817qkp.280.1637007011887;
        Mon, 15 Nov 2021 12:10:11 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id m19sm6935664qkn.129.2021.11.15.12.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 12:10:11 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] base: arch_topology: Use policy->max to calculate freq_factor
Date:   Mon, 15 Nov 2021 15:10:10 -0500
Message-Id: <20211115201010.68567-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo.max_freq can reflect boost frequency if enabled during boot.  Since
we don't consider boost frequencies while calculating cpu capacities, use
policy->max to populate the freq_factor during boot up.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 43407665918f..df818b439bc3 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -334,7 +334,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus)
-		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
+		per_cpu(freq_factor, cpu) = policy->max / 1000;
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
-- 
2.25.1

