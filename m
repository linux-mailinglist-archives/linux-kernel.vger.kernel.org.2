Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08140BFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhIOGc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOGc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:32:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 23:31:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g14so1810925pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86eTaH8KbR5TYgo5aX5tgBsD4Tvk26zHleLpZU7uRR0=;
        b=YiVWPanVbhwkfwHk4cCM/LuA3+lkV87InKV/l9k52BJbLr2/gf+MKdH1mqMdPW3Waw
         1PvD9YBoG0XsfrKeI2TiW0QxbZeEhVlip6iz9uL8gj+ARsZkp3A/dxmN+Th8a9qWIBvi
         3c+R5FWH1ra41AdVibDDoNpgt6ZxpBVO2RijRFyBIhvTPh6ZbChvkkgwiNLRwUqZw0dj
         bUC1+KcnlQblyeiTGB1gkpqn4QouapgE0ib5i4UkPvS7QENo5/PSl3Vz4VH1rstb8VQE
         SIC1MgWDlmld6P8BRS0Nr5fM60GJWcuFo6uufFHvmxiZSI6ZYS0EmgddmxJUbI/+oC5o
         OSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86eTaH8KbR5TYgo5aX5tgBsD4Tvk26zHleLpZU7uRR0=;
        b=xozjK6JU+izWwg1nW8pNVverNPMSZB0mTkjPgZctnjhvfsVU8a7UpT1iweiOxWpprn
         aIKYyJYZWH8ppGeyDJrSiUCQyLDFDdSyYIZxO4+3Jl4FLWccLNLLa3fKAh69YPys3r6z
         f3zk4Q25OreQSGOiQDI2QLSgVYwtg177hs23TIIEBSuAuinHf3IG0CW6q7dnr1xgdXfg
         GCCe0sBTmkTr7EVmQkJfQhuTh2VgONS1IUcJUtbveJxvTlwelU2pfEh+jNUYxr3tXUtZ
         M9QrkeKr80XrdTH2KHrE/oKISGKS0QidPMSvAUNtAQOZhIa5b/w4DolZKvI6e+2dbKiF
         xqHA==
X-Gm-Message-State: AOAM533LkJ3XGVB0mcSpk+jFIPCnKekvSaUP0b75eilDihMbtE0NevMK
        9fYCeLz9SB+rTaXWvxsyZ7g=
X-Google-Smtp-Source: ABdhPJxb1YYgTJ9FIxop50H09KxZvebr4ineCDj1uAvSaFI7ohTZKwTK81LKn3N8bCfMKRCrMvKfFQ==
X-Received: by 2002:a05:6a00:24d3:b0:43f:2a7b:8b82 with SMTP id d19-20020a056a0024d300b0043f2a7b8b82mr1802456pfv.36.1631687467499;
        Tue, 14 Sep 2021 23:31:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e2sm12407152pfn.141.2021.09.14.23.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 23:31:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     bsingharora@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] delayacct: optimize delayacct init
Date:   Wed, 15 Sep 2021 06:30:41 +0000
Message-Id: <20210915063040.159018-1-yang.yang29@zte.com.cn>
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
Tested-by: Zeal Robot <zealci@zte.com.cn>
---
v2: move set_delayacct() in CONFIG_PROC_SYSCTL now 
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

