Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443243FFF33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349296AbhICLaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349210AbhICLaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:30:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE8C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 04:29:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 2so4068678pfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0I//inV63qyurmrg1BffYLLfm9QEgShDl7nWQ+y21aU=;
        b=q6Qiylu6AkvzHZrdLLE5WkEWLRhFg1l2ZYKx94DC4huDKmMtTT9hoPGxCu1SzV59au
         BJajk83gMYYA19BQsVMxeFkVVU9/2HWdVPwIIIMYFsH34yhF1XwNFNK0xcEtrB+ENXWp
         y19bIIiNYW5rApCpKjRWXuYiGuJBf7WOM5xObiMZwj7g1bmSidPhF4OwJzyY/Efq8iaq
         gx2fm3RlvDOPRGTDXm9of7NDK2blUF8/qHz/L8TEJOU1xH4xQ2ai2hXh3JpgClwd23iY
         JlIN5eEuZE5x3vQAjbPk6JFvhvAo5TNahqmZyu6mkx0ah5kVpjJj/Fti65QbjNv4evYA
         qSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0I//inV63qyurmrg1BffYLLfm9QEgShDl7nWQ+y21aU=;
        b=YIPDEp9ySNyTWPOQsziyFw2sSZrUZE+ftWBQ8DZWLepjcatyRCaVhq7h8xpBIpve4w
         9S5YdE9m9R+6Jn6dPMZghlQ6dMHrNUpZyinYQwvohboZ6gK5JBTaXQOKDnMye+zIIg9M
         QY85acv0W7OM0xxOB8VHzlYWFxcBp6awj6eBzE2QcoOoWWfTQIbeJBQ28MNuWRaZXhPS
         3SiaFRwU0JBQXh3zcK5PtkhSBHMiMeDUGFDbE2Ks79/dMzavZVIkjzcfc/g+JHPIWrz/
         wYBaUC62WF3Y4tzhv422ocxQ4k3Q4lR55y7MFInxejXN653G/vU6W2GNzMvpt8Cbi7A5
         hE2A==
X-Gm-Message-State: AOAM533PGEMZ98oUHIW4NY6mCyuBTxzTF3QTLTH3yzCEGKTdWg9VSMPa
        R5VGmlfQllaFPoeJBhPRkxnu9H5JyUXs1g==
X-Google-Smtp-Source: ABdhPJxi4/iwwdHiOP818FoRPtwAzNOPXLk2Cg4hzZ8nnurJWUSpUrA2AC7B7FaW1bscCh88e/b/Tg==
X-Received: by 2002:a63:7447:: with SMTP id e7mr3222816pgn.46.1630668558021;
        Fri, 03 Sep 2021 04:29:18 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j14sm5023847pjg.29.2021.09.03.04.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 04:29:17 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pstore: Add pstore back-end choice method in kconfig
Date:   Fri,  3 Sep 2021 19:27:41 +0800
Message-Id: <1630668462-24527-2-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1630668462-24527-1-git-send-email-zhenguo6858@gmail.com>
References: <1630668462-24527-1-git-send-email-zhenguo6858@gmail.com>
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

