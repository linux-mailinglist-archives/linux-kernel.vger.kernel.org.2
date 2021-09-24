Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB635416E68
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbhIXJCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbhIXJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:02:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C6FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:01:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id p12-20020a17090adf8c00b0019c959bc795so7089431pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0I//inV63qyurmrg1BffYLLfm9QEgShDl7nWQ+y21aU=;
        b=aTeZ7RP2KaSlLh3Wcgsd7ggo8/ynDHGa1aUo+wnW/PbYmyMVi++dF1FIV8M1V9oX0H
         CI2r4KJCiuaUjnq3ypmyAWbdwBJva3TEN1ztyWzE2EBwl3CUHreJTJAXGpc12devbQuj
         b0zEt8vZKCoKk5h8Uh4LNU/moPQAGwy8q2g5TmFQIbgHkUK75mYKAc89BiFfLTkfkPyv
         PtxC7HdWD5dyxbiwrxMaIojlX830pUpaKkw5vjLL6liTaelZKh5b93q3A5yiyKX60Vr2
         f24INJrDBSPBy9zuk3iv0WahgHrLkU2nU5Uu6xYoa3ElRklPngUbXwpleM1RrHt9h0Pt
         QNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0I//inV63qyurmrg1BffYLLfm9QEgShDl7nWQ+y21aU=;
        b=a+zwYsvgTeyFNUdvtHgxy0TgyPCIrOfgJMpx3u+tHeoMDrH7/YK4CaxResyIErax1j
         ZTJrh2Evbqr16UKrhbCpYyRGkhs3THpLBJazi8rPzZiWm1IyoxCdbXRwy6pakNsrCqI+
         bS4OxFl1ZcRKM2v6x8db24Ow6xcIqoC5CmCbZAywB7XacZUBQDbHrZjqmfmoIb4Q3+rM
         TXU9H9CZrIIOAS6hoHLJdOGyJ3f6vR+uzEaD+4Z7AvOzyDcrHzTZozM/DVq0MXSsI8i0
         lhcu8iPc4Edkk1Mo2r5cF2pqpXWzaAkFaeuTkIRZAiYtjUoQPPmEDqqwtGp4GgclsEHy
         zS+g==
X-Gm-Message-State: AOAM5303yCCpMJNEVQ2rQJfH3ltya3Hm8Mn00IBCi5jAb35+IBNa46c6
        mdLlBsblHnog36v4cvQJphw=
X-Google-Smtp-Source: ABdhPJwtVVJLktmkcny8iANFoT+hC3qrYzgxe0Q0QF9DHeek1XfS1Cwa05WVMkRQQEzM7ifUjcKpyA==
X-Received: by 2002:a17:90b:4d8e:: with SMTP id oj14mr957338pjb.37.1632474066890;
        Fri, 24 Sep 2021 02:01:06 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b142sm8501848pfb.17.2021.09.24.02.01.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 02:01:06 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pstore: Add pstore back-end choice method in kconfig
Date:   Fri, 24 Sep 2021 16:59:21 +0800
Message-Id: <1632473962-29686-2-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1632473962-29686-1-git-send-email-zhenguo6858@gmail.com>
References: <1632473962-29686-1-git-send-email-zhenguo6858@gmail.com>
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

