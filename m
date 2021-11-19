Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD24E456E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhKSLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbhKSLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B2C061757
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso7243962wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8Op8q7rZcErif+pW+kwkGZtnL8oyJAgnngcVRDPzbg=;
        b=IXJgNQ6gL/FxwEbUq5q3i9V84CCtzWNIyO9fAVkFpEioDBvHm52cIznFZ1UjWzuJIj
         tfgQWAqC4HmYj19m1NTBA1nkHezfWSWq21Np4s3Us8DiXYiWvTpzSaBTIoNuWhOKpOnA
         t8NV4UNpqPLJgYrccdRMiWB8Thnr85FwXpkxQCXZ4IB1d0d42naeQCcPB7s0tKuoVtnT
         DjnclxLlsf5/q/sCSM1FSZOBJeQATUwOOVgAZee9vIvIOiCTuazXo/zw/VvTPjwoMS02
         KIGMhb6uWLuZZehb5V5y/oeiK+TPE2XKlV9hOPmLGF7ZUDIi7K8wokr2NwI9LZZUTOe9
         5vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8Op8q7rZcErif+pW+kwkGZtnL8oyJAgnngcVRDPzbg=;
        b=JcEy9W08rvVqcluiZOzSzBAZclfokW26pwCJsYIfg3gtKQDtzxCHEYPzvJsHDa7V7g
         yjtnxBiHW0/i3gzBdMFTnnNapI6dqB3Brxa6as2Aa8b/eVxIHXcoK2K/hhrN2XNrwq5n
         NT5Dj9+sXLWiNYmfjGgI4f7/febbU6+XhW49hQYPuXf+MVkpH321qbY750GcGYVK+O9H
         PB+Bk6/WlEdIq2Xu5Ypip9GewFbeR2Y3sUH32bhuHhZXjr7Y4brM8vi8WZ48YKvvbfhF
         WsOio2PlGSsm03DbhB+et0+S10CXWS779MrVOb3YVq9w8HfJIGX8MMdyhjvwu5H3I4cD
         EqBQ==
X-Gm-Message-State: AOAM532nGccO3NDBEtW//z67gxPvDDfFF18VJ/C9d9CwXXt0cU+b/WsJ
        no2OSLongq7VyBmiqfuCrGMNyXW9YCZyEg==
X-Google-Smtp-Source: ABdhPJzn089NHd/QbWea0dnUrHZzZkGrMjKPiq8SSq4jcNq6GKzGAePtJWUzlKCojkJJDDLmOKf5ZA==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr5917767wmi.151.1637321835520;
        Fri, 19 Nov 2021 03:37:15 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:15 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 06/17] Simplify sizeof(typeof_member()) to sizeof_field()
Date:   Fri, 19 Nov 2021 12:36:34 +0100
Message-Id: <20211119113644.1600-7-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to use typeof() on the input to sizeof().

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 drivers/platform/x86/wmi.c | 4 ++--
 kernel/kallsyms.c          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 5daadcafd808..0b1c49aa6d5f 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -33,7 +33,7 @@
 #include <linux/uuid.h>
 #include <linux/wmi.h>
 #include <linux/fs.h>
-#include <linux/typeof_member.h>
+#include <linux/stddef.h>
 #include <uapi/linux/wmi.h>
 
 MODULE_AUTHOR("Carlos Corbacho");
@@ -54,7 +54,7 @@ struct guid_block {
 	u8 instance_count;
 	u8 flags;
 } __packed;
-static_assert(sizeof(typeof_member(struct guid_block, guid)) == 16);
+static_assert(sizeof_field(struct guid_block, guid) == 16);
 static_assert(sizeof(struct guid_block) == 20);
 static_assert(__alignof__(struct guid_block) == 1);
 
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3bf04d89d72c..9a1e986fac0d 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -29,7 +29,7 @@
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/typeof_member.h>
+#include <linux/stddef.h>
 
 /*
  * These will be re-linked against their real values
@@ -467,7 +467,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 		if (add_buildid && buildid) {
 			/* build ID should match length of sprintf */
 #if IS_ENABLED(CONFIG_MODULES)
-			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
+			static_assert(sizeof_field(struct module, build_id) == 20);
 #endif
 			len += sprintf(buffer + len, " %20phN", buildid);
 		}
-- 
2.33.1

