Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0C34EE56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhC3Qqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhC3Qp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D60C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y124-20020a1c32820000b029010c93864955so10679053wmy.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+/n16QniF69Ucp7rG4xjWyhhaEhUVOJzq/rP2Jsm7M=;
        b=Li33xaWejssxErfGthJkO44gD/l7QdLn5QOUI4M7rPBgBLWyeBQanIewbKALzqSUc5
         vvg+GjhSe3gbmLXigfmbK38QcnzRmxkyLYrrq1InjQMDzIivCXKp+k/HMEx7NLy7d+J4
         d50tsK7gg2bEMJaavRdN9TKLUheMjfxB2TUxl6S8uhkW/mugnMfMS4Ms1nCbSRV4kEfO
         krEkjtExXqK5oBTJ2EpK7XYC20sF6q7uG/GUA3/j1VFjXA6zV8yfLg7dzMG/1Ln2kYCE
         mVZ3vfDg7q/kK6940ZHZG9yHBjowS71IoqVrN+TiRVHV4tpirA2qM639+qZ1Jw+q+ySp
         9iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+/n16QniF69Ucp7rG4xjWyhhaEhUVOJzq/rP2Jsm7M=;
        b=jk+fv9JUGpsIoz11buEXs3SkBgSDP1/waxka+Vm/RWYWVJtQG46HkZWg1iMd+cuhno
         Y6G8zdab3HpNmz7bZcHa7ng/rAM4VG6Ix2mAnKqc18Jpus0fmH/pvfCHQlH9xTe/wA/z
         EtZwN2umAJQdFk2o0nmak5irlgOsCov7Y/1M+PeYzLxct7GiIxIcMenpiWFTXiBQS6Ep
         jriCSIdRmfusZZMt0pdGzWCAqHd+VQnjz4v20EQCYcr+1eG3F3aH5RT1a795MMAjr/XL
         wRwh/z1aDY2a9GgZPNhskOYIQ7y6EfRPRDNzUCyRdmW3vAMpL0NJBEhsp6Ar4FSrQCfb
         NkFA==
X-Gm-Message-State: AOAM530M/SHvXGVBEHKr2RvE2rjx74kfgK+CRkqIFiCRGBxF+eU6SZOU
        oaxOBrokmcDZoHlY1I+x9M/WlA==
X-Google-Smtp-Source: ABdhPJyUIWzWW4Ns/iJtSy17L56qE9R9lJ+qAbksUrm0OfE9TIGAJ4bUehIefrpSiGuI7eKrHjISYg==
X-Received: by 2002:a1c:9a09:: with SMTP id c9mr4854661wme.172.1617122727389;
        Tue, 30 Mar 2021 09:45:27 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "Michael A. Halcrow" <mahalcro@us.ibm.com>,
        "Michael C. Thompson" <mcthomps@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 26/31] fs: ecryptfs: main: Demote a bunch of non-conformant kernel-doc headers
Date:   Tue, 30 Mar 2021 17:44:53 +0100
Message-Id: <20210330164458.1625478-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/main.c:28: warning: Incorrect use of kernel-doc format:  * Module parameter that defines the ecryptfs_verbosity level.
 fs/ecryptfs/main.c:30: warning: cannot understand function prototype: 'int ecryptfs_verbosity = 0; '
 fs/ecryptfs/main.c:40: warning: cannot understand function prototype: 'unsigned int ecryptfs_message_buf_len = ECRYPTFS_DEFAULT_MSG_CTX_ELEMS; '
 fs/ecryptfs/main.c:52: warning: cannot understand function prototype: 'signed long ecryptfs_message_wait_timeout = ECRYPTFS_MAX_MSG_CTX_TTL / HZ; '
 fs/ecryptfs/main.c:65: warning: cannot understand function prototype: 'unsigned int ecryptfs_number_of_users = ECRYPTFS_DEFAULT_NUM_USERS; '
 fs/ecryptfs/main.c:106: warning: Function parameter or member 'dentry' not described in 'ecryptfs_init_lower_file'
 fs/ecryptfs/main.c:106: warning: Function parameter or member 'lower_file' not described in 'ecryptfs_init_lower_file'
 fs/ecryptfs/main.c:106: warning: Excess function parameter 'ecryptfs_dentry' description in 'ecryptfs_init_lower_file'
 fs/ecryptfs/main.c:244: warning: Function parameter or member 'sbi' not described in 'ecryptfs_parse_options'
 fs/ecryptfs/main.c:244: warning: Excess function parameter 'sb' description in 'ecryptfs_parse_options'
 fs/ecryptfs/main.c:478: warning: Function parameter or member 'fs_type' not described in 'ecryptfs_mount'
 fs/ecryptfs/main.c:478: warning: Function parameter or member 'flags' not described in 'ecryptfs_mount'
 fs/ecryptfs/main.c:478: warning: expecting prototype for ecryptfs_get_sb(). Prototype was for ecryptfs_mount() instead
 fs/ecryptfs/main.c:645: warning: Function parameter or member 'vptr' not described in 'inode_info_init_once'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: James Morris <jamorris@linux.microsoft.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: "Michael C. Thompson" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index cdf40a54a35d8..0a6ef2472f205 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2003 Erez Zadok
@@ -24,7 +24,7 @@
 #include <linux/magic.h>
 #include "ecryptfs_kernel.h"
 
-/**
+/*
  * Module parameter that defines the ecryptfs_verbosity level.
  */
 int ecryptfs_verbosity = 0;
@@ -34,7 +34,7 @@ MODULE_PARM_DESC(ecryptfs_verbosity,
 		 "Initial verbosity level (0 or 1; defaults to "
 		 "0, which is Quiet)");
 
-/**
+/*
  * Module parameter that defines the number of message buffer elements
  */
 unsigned int ecryptfs_message_buf_len = ECRYPTFS_DEFAULT_MSG_CTX_ELEMS;
@@ -43,7 +43,7 @@ module_param(ecryptfs_message_buf_len, uint, 0);
 MODULE_PARM_DESC(ecryptfs_message_buf_len,
 		 "Number of message buffer elements");
 
-/**
+/*
  * Module parameter that defines the maximum guaranteed amount of time to wait
  * for a response from ecryptfsd.  The actual sleep time will be, more than
  * likely, a small amount greater than this specified value, but only less if
@@ -57,7 +57,7 @@ MODULE_PARM_DESC(ecryptfs_message_wait_timeout,
 		 "sleep while waiting for a message response from "
 		 "userspace");
 
-/**
+/*
  * Module parameter that is an estimate of the maximum number of users
  * that will be concurrently using eCryptfs. Set this to the right
  * value to balance performance and memory use.
@@ -80,7 +80,7 @@ void __ecryptfs_printk(const char *fmt, ...)
 	va_end(args);
 }
 
-/**
+/*
  * ecryptfs_init_lower_file
  * @ecryptfs_dentry: Fully initialized eCryptfs dentry object, with
  *                   the lower dentry and the lower mount set
@@ -221,7 +221,7 @@ static void ecryptfs_init_mount_crypt_stat(
 
 /**
  * ecryptfs_parse_options
- * @sb: The ecryptfs super block
+ * @sbi: The ecryptfs super block
  * @options: The options passed to the kernel
  * @check_ruid: set to 1 if device uid should be checked against the ruid
  *
@@ -466,10 +466,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 struct kmem_cache *ecryptfs_sb_info_cache;
 static struct file_system_type ecryptfs_fs_type;
 
-/**
+/*
  * ecryptfs_get_sb
- * @fs_type
- * @flags
  * @dev_name: The path to mount over
  * @raw_data: The options passed into the kernel
  */
@@ -635,7 +633,7 @@ static struct file_system_type ecryptfs_fs_type = {
 };
 MODULE_ALIAS_FS("ecryptfs");
 
-/**
+/*
  * inode_info_init_once
  *
  * Initializes the ecryptfs_inode_info_cache when it is created
-- 
2.27.0

