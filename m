Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E534EE54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhC3Qqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhC3Qp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k8so16892799wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmCCi8Ei2sV2xzcgDxh9zocT++u/z4vv8g5O2Nqa5dY=;
        b=W93sbjiI0hfpGEploXfA/yA80LVHjtZ0j6Aw9GxiBeu9zY9kyFSTCL6cJMTfboZLuT
         Jx/vRZDv90YW4DgMEGjj/994PgR6lw5uqYOOBRS+3QJQpPRm4hBDkjM+3i348jbMyK+7
         axsR1r793nw26SFNT8pJRacif+IV/XukgREXLWGLmBA8BpN7NJlemvyu6pKx0XovMP1j
         87/N+En4rRR1v5NfREXI68Xc1wlgSW/T/cnXovjlfN7ECpHTMCqUak3rqPO/trozPfDz
         hIB5ChgkBn66mkvpSQHQ3Xf8+msL6wtBO226O5vtbX8/P+ySCY6a6m3h8KA/yCbiwOat
         M/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmCCi8Ei2sV2xzcgDxh9zocT++u/z4vv8g5O2Nqa5dY=;
        b=HjsEJCtguULVhpn/rckeg9Xs0Xxk23iItR+we0+KTg2j0TfzMxsV9nWO0CAIEHyGx2
         ruclJQMyxJa5986U+Y5PFwgj8C3gJ1Qfl7g3+GFkVX3IJE8Ah09QMsainfyNHZKneSlO
         zu7tuynweXMh4GDvnSdlQERNirguVmExYlZcQ4A03ZYROdTP8txjZS69iyoki/tvk3pa
         o0J3NPQLTv5uCiwMDreTuQAacDtEHcwde87cbY+ANiXNiKi9QWZ8wmN4+U7BXwhCP0Qi
         eUzTsm0CMsEsTaXogCqYxNFKwqFry0WQKeSzenszm24KwnxWUVI6+9fmDFzmufh6dMEU
         ympQ==
X-Gm-Message-State: AOAM533F00s3INyHLMVSitcs77YLdxrk7a6hZ75nJs1Jpa7yTM03e9nY
        DwRq39GC/3/5tNn2AjN3vcC3+w==
X-Google-Smtp-Source: ABdhPJxNyyCeDO/k+ZC2vkRxploJGMCvdE3VOffxlj6KdDn1Po9xvowbsk8TymPmBXto/BaHf8JYKA==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr34599817wrx.91.1617122725162;
        Tue, 30 Mar 2021 09:45:25 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        "Michael A. Halcrow" <mahalcro@us.ibm.com>,
        "Michael C. Thompson" <mcthomps@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 24/31] fs: ecryptfs: super: Fix formatting, naming and kernel-doc abuses
Date:   Tue, 30 Mar 2021 17:44:51 +0100
Message-Id: <20210330164458.1625478-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/super.c:22: warning: cannot understand function prototype: 'struct kmem_cache *ecryptfs_inode_info_cache; '
 fs/ecryptfs/super.c:91: warning: Function parameter or member 'dentry' not described in 'ecryptfs_statfs'
 fs/ecryptfs/super.c:91: warning: Excess function parameter 'sb' description in 'ecryptfs_statfs'
 fs/ecryptfs/super.c:120: warning: Function parameter or member 'inode' not described in 'ecryptfs_evict_inode'
 fs/ecryptfs/super.c:133: warning: Function parameter or member 'm' not described in 'ecryptfs_show_options'
 fs/ecryptfs/super.c:133: warning: Function parameter or member 'root' not described in 'ecryptfs_show_options'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: "Michael C. Thompson" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 6b1853f1c06a9..39116af0390f7 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2003 Erez Zadok
@@ -81,7 +81,7 @@ static void ecryptfs_destroy_inode(struct inode *inode)
 
 /**
  * ecryptfs_statfs
- * @sb: The ecryptfs super block
+ * @dentry: The ecryptfs dentry
  * @buf: The struct kstatfs to fill in with stats
  *
  * Get the filesystem statistics. Currently, we let this pass right through
@@ -108,7 +108,7 @@ static int ecryptfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 /**
  * ecryptfs_evict_inode
- * @inode - The ecryptfs inode
+ * @inode: The ecryptfs inode
  *
  * Called by iput() when the inode reference count reached zero
  * and the inode is not hashed anywhere.  Used to clear anything
@@ -123,7 +123,7 @@ static void ecryptfs_evict_inode(struct inode *inode)
 	iput(ecryptfs_inode_to_lower(inode));
 }
 
-/**
+/*
  * ecryptfs_show_options
  *
  * Prints the mount options for a given superblock.
-- 
2.27.0

