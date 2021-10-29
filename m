Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F143F786
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhJ2Gz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhJ2Gz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:55:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:53:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r5so6235311pls.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0I//inV63qyurmrg1BffYLLfm9QEgShDl7nWQ+y21aU=;
        b=WzpJWsLMgPBn3Wt18FxzFOLQKt3gDZ+x0olEV2gPQBvrlZwaL5WoqoBfrXoQzCWqP/
         bTNkIXdEcHnUY6YeiTg10/Xw53RzsLbc6xPt8DkLsM9ICBvjExWdFjsK0ftQK6c2eskR
         ntQ8TL00q7z0fm12BJq8aLw4giK4FDI6Wj1haybnZdVYwi0oDrj9z1rG3/wN0X2ObqvB
         l0wKd17tUoXbdeql6+fW/ZCUeBYCdT/zRUQLN1Bj9DruGrD/mqz1gWy8BKvc9qNglCG8
         se3msmKNSSYBRrKcl1vUfK96+zy92AiinCIsmSQNgdvcWAYccrL0orpSKqV4AxPcGxfk
         kDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0I//inV63qyurmrg1BffYLLfm9QEgShDl7nWQ+y21aU=;
        b=4eMZrCqLNCrNF6RMP/yubkQHifRQPCQjmP72gbSVhy3nQDfaGLjR2JO0E+9c4wrbDS
         4XrJIMzGsx2Qf2MtNOc3Zul55BC4PycYkMOckPdb1fLLHBAUw+foYWYgzs6ir9FxZqOL
         aSzfsw8cXfqTete5rwH9Q3/gFIlb/1wzgQqTqGRP2qS11ru8QU+n4o18XXefu+ADF77V
         YsLZgbWr6bl3/K5JIbmr1tMl8wUg+Zr5tPhEj4+irEtwnHKLelpTNW/XQhUukDwHhZLg
         nLF9umX7x2+FRH/pRhiEfu7R9Wj4StY5RmcsKbHg31NHJW7UlGxRx3A+kZfWX/NZjuan
         i/Ug==
X-Gm-Message-State: AOAM530VZIhPh50PC+xzWplDUsoQUO/2mBORqTOwzw/5d4ZQcrnjVjVx
        2077Z+TxTPeG6S6BwkW5fys=
X-Google-Smtp-Source: ABdhPJwEU17CkURHEMXYPlCtWyx4q0nNzWnAY33qDLY3ZTijhLLTbTUk9nDkHYQcotzEux87XKb/EQ==
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr9397372pjb.97.1635490409379;
        Thu, 28 Oct 2021 23:53:29 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id gn1sm4729741pjb.34.2021.10.28.23.53.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 23:53:29 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pstore: Add pstore back-end choice method in kconfig
Date:   Fri, 29 Oct 2021 14:51:19 +0800
Message-Id: <1635490280-8798-2-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1635490280-8798-1-git-send-email-zhenguo6858@gmail.com>
References: <1635490280-8798-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

The pstore has one storage device for back-end,so it should be
use choice method to config.

When ramoops config,insmod pstore_blk.ko,it will print unexpected,the
module will insmod failed.

    if (backend && strcmp(backend, psi->name)) {
        pr_warn("ignoring unexpected backend '%s'\n", psi->name);
        return -EPERM;
    }

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 fs/pstore/Kconfig | 57 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 8adabde..288ed3c 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -146,21 +146,40 @@ config PSTORE_FTRACE
 
 	  If unsure, say N.
 
-config PSTORE_RAM
-	tristate "Log panic/oops to a RAM buffer"
+choice
+	prompt "Choice pstore device"
 	depends on PSTORE
-	depends on HAS_IOMEM
-	select REED_SOLOMON
-	select REED_SOLOMON_ENC8
-	select REED_SOLOMON_DEC8
+	default PSTORE_RAM
 	help
-	  This enables panic and oops messages to be logged to a circular
-	  buffer in RAM where it can be read back at some later point.
-
-	  Note that for historical reasons, the module will be named
-	  "ramoops.ko".
+	  This option chooses ram or blk to use pstore device.
+	config PSTORE_RAM
+		tristate "Log panic/oops to a RAM buffer"
+		depends on HAS_IOMEM
+		select REED_SOLOMON
+		select REED_SOLOMON_ENC8
+		select REED_SOLOMON_DEC8
+		help
+		  This enables panic and oops messages to be logged to a circular
+		  buffer in RAM where it can be read back at some later point.
+
+		  Note that for historical reasons, the module will be named
+		  "ramoops.ko".
+
+		  For more information, see Documentation/admin-guide/ramoops.rst.
+
+	config PSTORE_BLK
+		tristate "Log panic/oops to a block device"
+		depends on BLOCK
+		select PSTORE_ZONE
+		help
+		  This enables panic and oops message to be logged to a block dev
+		  where it can be read back at some later point.
+
+		  For more information, see Documentation/admin-guide/pstore-blk.rst
+
+		  If unsure, say N.
 
-	  For more information, see Documentation/admin-guide/ramoops.rst.
+endchoice
 
 config PSTORE_ZONE
 	tristate
@@ -169,20 +188,6 @@ config PSTORE_ZONE
 	  The common layer for pstore/blk (and pstore/ram in the future)
 	  to manage storage in zones.
 
-config PSTORE_BLK
-	tristate "Log panic/oops to a block device"
-	depends on PSTORE
-	depends on BLOCK
-	select PSTORE_ZONE
-	default n
-	help
-	  This enables panic and oops message to be logged to a block dev
-	  where it can be read back at some later point.
-
-	  For more information, see Documentation/admin-guide/pstore-blk.rst
-
-	  If unsure, say N.
-
 config PSTORE_BLK_BLKDEV
 	string "block device identifier"
 	depends on PSTORE_BLK
-- 
1.9.1

