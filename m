Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539C4424C17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 05:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhJGDM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 23:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhJGDM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 23:12:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 20:11:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q19so3611322pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 20:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YsQBxoifF3R4CuUHJHMPQwF8BNcetz2biy6E1DRV3rE=;
        b=VEZqegoPS452ObjnTlpc93jQHvOkdQY2slDVsO7NdkuMzB7Fxkme1kXIYU2x5BKLOo
         b9ZE+LmBgJM0Azsq7GjS3QtTNsRzvxjWM4iIYmTOsOa6IRm8FN1Cyhluv6wFxHXAap8b
         pXBoYX7fWXNj5kTTy/rGifZ5Q3bQEOjS2FTFTKVanBZsOtg3xGs/Hz5L/pVeF/Fa7nqu
         t//0PfZxkhN2NSU/hETKsKQu1OI5pEnJxBo8aPbHU8A63wUXbVNL2vtJeEeDppsCDRei
         Cu1BsIfyj2fpJ/85Ztr1IJWqhr47BanrhIMUZEC+DAbFddfwaZqSaRIp+CCL1gt7zfjh
         jJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YsQBxoifF3R4CuUHJHMPQwF8BNcetz2biy6E1DRV3rE=;
        b=Goe+9JNw4kfi76eaxzCMpugdlC76SN/SHMauCIQbsmhBBXkZvxQZfsooxNiAvKxkvP
         BqhiqRDJAVuEatEFw+ghPYdkzpK6I78vnpinSGsWQSB8FqpKfxLzJQMtqlSE5zOfsJNc
         rSF5v6PwKrD2ulj3KpqSOhedsKVQLhou4k6Caml00eC0YI43T23pc4bB8qIBMamLmmXW
         pan2+r3OVKRimNKjZGpvmPb3A3A+M6RV2ahpRw664Is+7sw+CxL5DrLBzoKs+Qxyq+B6
         AXYXOdg/qC5oJWRpu7XJ8YWiBIFA+V/CUKl57AhzrjiSV4Gl9vXVJWxgnZVxRNfY4Nxg
         H5kw==
X-Gm-Message-State: AOAM533JfOeFMj+h0naZx95WqrYbUxHEuN7Nh+YXv807XvonYx3mWtQr
        h453Tj9gdCM6o/7g+x32Y0QbEgGSuo8=
X-Google-Smtp-Source: ABdhPJyDSXTwZnQKLVCr10Rx/YbHmXSVJuFL7/kR9AV6l1RnEV8f8EhRXUfP8winw9GYaDMn3nSkOg==
X-Received: by 2002:aa7:8d53:0:b0:44b:fcd8:112 with SMTP id s19-20020aa78d53000000b0044bfcd80112mr1963290pfe.26.1633576264844;
        Wed, 06 Oct 2021 20:11:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n202sm4800336pfd.160.2021.10.06.20.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:11:04 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     bsingharora@gmail.com, john.stultz@linaro.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] delayacct: make delayacct init more efficient
Date:   Thu,  7 Oct 2021 03:09:48 +0000
Message-Id: <20211007030947.460480-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

In delayacct_init(), first there is no need to assign delayacct_on to
delayacct_on in set_delayacct(). Second if delayacct_on is 0, there
is no need call delayacct_tsk_init().

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/delayacct.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 51530d5b15a8..1135a551edd1 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -18,17 +18,6 @@ DEFINE_STATIC_KEY_FALSE(delayacct_key);
 int delayacct_on __read_mostly;	/* Delay accounting turned on/off */
 struct kmem_cache *delayacct_cache;
 
-static void set_delayacct(bool enabled)
-{
-	if (enabled) {
-		static_branch_enable(&delayacct_key);
-		delayacct_on = 1;
-	} else {
-		delayacct_on = 0;
-		static_branch_disable(&delayacct_key);
-	}
-}
-
 static int __init delayacct_setup_enable(char *str)
 {
 	delayacct_on = 1;
@@ -39,11 +28,26 @@ __setup("delayacct", delayacct_setup_enable);
 void delayacct_init(void)
 {
 	delayacct_cache = KMEM_CACHE(task_delay_info, SLAB_PANIC|SLAB_ACCOUNT);
+	if (delayacct_on)
+		static_branch_enable(&delayacct_key);
+	else
+		return;
+
 	delayacct_tsk_init(&init_task);
-	set_delayacct(delayacct_on);
 }
 
 #ifdef CONFIG_PROC_SYSCTL
+static void set_delayacct(bool enabled)
+{
+	if (enabled) {
+		static_branch_enable(&delayacct_key);
+		delayacct_on = 1;
+	} else {
+		delayacct_on = 0;
+		static_branch_disable(&delayacct_key);
+	}
+}
+
 int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
 		     size_t *lenp, loff_t *ppos)
 {
-- 
2.25.1

