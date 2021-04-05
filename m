Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A603546B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhDESQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:16:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33093 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhDESQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:16:16 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTTlh-0004sm-7h
        for linux-kernel@vger.kernel.org; Mon, 05 Apr 2021 18:16:09 +0000
Received: by mail-wm1-f71.google.com with SMTP id v5so67339wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+LRPj/fCq0SEo4/VKey3X9K9DoRxq2h/ltKuYY7g0o=;
        b=IsyJrriakr4UccYqfM7mRxrlYaqzS3rOsZaNLjIs/TV0jvpx9/AWlustrXaA47lbQc
         6X6ApQMHo+QFA6oGHOAgVnjckFTfGYjMn77p60eVvVT9qDImnM9iD1QbH0pkShnrjkgE
         IJAzsdOB/yx8lCuvgTd5IhmMcZCkD5ecLHQgkfzlqD5JpIAc95jQPZQFcRL2JyDCbMGC
         HMN0EiBjovnt7On1vokHq/KyTBYzBCoDLegnKHLgdTYkSUCR20x/WX3kNhAkffakSBtL
         sRFvBN7SmJCoIAWOZsRbVto+ShKKQC2gjyy0hYnVKePmSW5Yw9knGx/uBJq8u0YhHa+w
         Fz+g==
X-Gm-Message-State: AOAM531xqX1vNPc/7et8FFvJodC2WBgtSgJRekm/r7nsA6YaeFpHr2QZ
        wqkldU0seVTTjNckc/IiyMSKTULiIe6XMTEgGQuB39mQt1bDfUCLBhkbccmsxIVRYS4RSgAnLX4
        7uaqM75fh4QyPdkDlhMznEpS03wMKaDqBXHRsrQwUOQ==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr30280780wrq.20.1617646569010;
        Mon, 05 Apr 2021 11:16:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKpeiK1vbwLjGL7whf06oPDq1IhygALHGmwF/FSN5Xa9HdtC0t5zWYCtOzZ5sXaQ8ZEOcVbw==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr30280765wrq.20.1617646568854;
        Mon, 05 Apr 2021 11:16:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id b15sm28930075wrx.73.2021.04.05.11.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 11:16:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: exynos: correct kernel doc in platsmp
Date:   Mon,  5 Apr 2021 20:16:05 +0200
Message-Id: <20210405181605.52612-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct few kerneldoc issues, including W=1 compile warning:

  arch/arm/mach-exynos/platsmp.c:89: warning:
    expecting prototype for exynos_core_power_down(). Prototype was for exynos_cpu_power_down() instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/mach-exynos/platsmp.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index ea0be59f469a..fb4a394ece3a 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -78,12 +78,11 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /**
- * exynos_core_power_down : power down the specified cpu
- * @cpu : the cpu to power down
+ * exynos_cpu_power_down() - power down the specified cpu
+ * @cpu: the cpu to power down
  *
  * Power down the specified cpu. The sequence must be finished by a
  * call to cpu_do_idle()
- *
  */
 void exynos_cpu_power_down(int cpu)
 {
@@ -107,8 +106,8 @@ void exynos_cpu_power_down(int cpu)
 }
 
 /**
- * exynos_cpu_power_up : power up the specified cpu
- * @cpu : the cpu to power up
+ * exynos_cpu_power_up() - power up the specified cpu
+ * @cpu: the cpu to power up
  *
  * Power up the specified cpu
  */
@@ -124,9 +123,8 @@ void exynos_cpu_power_up(int cpu)
 }
 
 /**
- * exynos_cpu_power_state : returns the power state of the cpu
- * @cpu : the cpu to retrieve the power state from
- *
+ * exynos_cpu_power_state() - returns the power state of the cpu
+ * @cpu: the cpu to retrieve the power state from
  */
 int exynos_cpu_power_state(int cpu)
 {
@@ -135,8 +133,8 @@ int exynos_cpu_power_state(int cpu)
 }
 
 /**
- * exynos_cluster_power_down : power down the specified cluster
- * @cluster : the cluster to power down
+ * exynos_cluster_power_down() - power down the specified cluster
+ * @cluster: the cluster to power down
  */
 void exynos_cluster_power_down(int cluster)
 {
@@ -144,8 +142,8 @@ void exynos_cluster_power_down(int cluster)
 }
 
 /**
- * exynos_cluster_power_up : power up the specified cluster
- * @cluster : the cluster to power up
+ * exynos_cluster_power_up() - power up the specified cluster
+ * @cluster: the cluster to power up
  */
 void exynos_cluster_power_up(int cluster)
 {
@@ -154,8 +152,8 @@ void exynos_cluster_power_up(int cluster)
 }
 
 /**
- * exynos_cluster_power_state : returns the power state of the cluster
- * @cluster : the cluster to retrieve the power state from
+ * exynos_cluster_power_state() - returns the power state of the cluster
+ * @cluster: the cluster to retrieve the power state from
  *
  */
 int exynos_cluster_power_state(int cluster)
@@ -165,7 +163,7 @@ int exynos_cluster_power_state(int cluster)
 }
 
 /**
- * exynos_scu_enable : enables SCU for Cortex-A9 based system
+ * exynos_scu_enable() - enables SCU for Cortex-A9 based system
  */
 void exynos_scu_enable(void)
 {
-- 
2.25.1

