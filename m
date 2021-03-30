Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2263E34EE65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhC3Qqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhC3Qpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A4C061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e18so16887280wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/spb9LRHUMxN66/6QSJQNTttxpX5BOghUyL/FOk6e8=;
        b=TL/eXuEWoC6+qh2nSz7K4LOTV4NTLt+YRmw7iYzM6IxNZzXo0cv48dXwSoyio7/qhW
         xlcu5Hw6BmOkCeoXCA8hVjRZBz3zUo4Yf0z0kW6KeZIok5o7V84hU6Q4mXS+7muhA64n
         6X+gv0/6kkZGcRbfcs6KV200eN9mN7j6AKJ8LpocOHH56Z0NXy8/RNWN1Ot5kXZTYpye
         6zvNowA4ousK9qVCc06Ev4HjO2e9ZF5TU2IK2/JzC66wwsqXC08usqNr/awj/Xr6NdF9
         hZ3iseDIMjFM80Jh3hw4+2OPViwDePgz5JyaD8sV0mSZC2K+m5JecXvz0lLdLXilvyDP
         Olhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/spb9LRHUMxN66/6QSJQNTttxpX5BOghUyL/FOk6e8=;
        b=HevUVGBSWfg6TPJYQvW3UD+NyqLdS0WT0JbnQd2YwCFHEtFjIjgCXsLCsE5IjTaTb/
         cd3a5HSiaiye1YthSyzOemqMBdcwOTlWADdjeOPrePy7hWb4xyzNhRma/rZJghuhi1Y0
         BNjLPALGTmv9p4Gwbr/2FWNceCFbObV1SN6wbRiarIEq8NECYFrsOIoZP24BtF55n1g3
         rawb/c/ocZIYqulYFmolBwd15Wk5IIWkz+VYBJ51aq8F/yzrtasU8iN03ld5oohIofyE
         YWsKKdGjtUnkacb6+75pMib2tcndDwXowB02KSfuC5UkBpnXuQO3LFKwe3WPs4IaiSiU
         767g==
X-Gm-Message-State: AOAM530M5FvsUrrdyxmuAWiHZUphMDUnL/Lmo9MjKvMVbz0MjgtBZNsq
        qVy2cWpqR4vpNVhOc4bq52JfeA==
X-Google-Smtp-Source: ABdhPJxIwyTcWOjhOpfxmI0ZrYANboT6RTuIMOwQl0x5QXtNVUUIYcj5rt0mhqxbvZ9KKMsD68WElw==
X-Received: by 2002:adf:f743:: with SMTP id z3mr35117602wrp.304.1617122731233;
        Tue, 30 Mar 2021 09:45:31 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        "Michael A. Halcrow" <mahalcro@us.ibm.com>,
        "Michael C. Thompsion" <mcthomps@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 30/31] fs: ecryptfs: inode: Help out nearly-there header and demote non-conformant ones
Date:   Tue, 30 Mar 2021 17:44:57 +0100
Message-Id: <20210330164458.1625478-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/inode.c:27: warning: Function parameter or member 'dentry' not described in 'lock_parent'
 fs/ecryptfs/inode.c:27: warning: Function parameter or member 'lower_dentry' not described in 'lock_parent'
 fs/ecryptfs/inode.c:27: warning: Function parameter or member 'lower_dir' not described in 'lock_parent'
 fs/ecryptfs/inode.c:27: warning: expecting prototype for eCryptfs(). Prototype was for lock_parent() instead
 fs/ecryptfs/inode.c:211: warning: Function parameter or member 'ecryptfs_dentry' not described in 'ecryptfs_initialize_file'
 fs/ecryptfs/inode.c:211: warning: Function parameter or member 'ecryptfs_inode' not described in 'ecryptfs_initialize_file'
 fs/ecryptfs/inode.c:258: warning: Function parameter or member 'mnt_userns' not described in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Function parameter or member 'directory_inode' not described in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Function parameter or member 'ecryptfs_dentry' not described in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Function parameter or member 'excl' not described in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Excess function parameter 'dir' description in 'ecryptfs_create'
 fs/ecryptfs/inode.c:258: warning: Excess function parameter 'dentry' description in 'ecryptfs_create'
 fs/ecryptfs/inode.c:320: warning: Function parameter or member 'dentry' not described in 'ecryptfs_lookup_interpose'
 fs/ecryptfs/inode.c:320: warning: Function parameter or member 'lower_dentry' not described in 'ecryptfs_lookup_interpose'
 fs/ecryptfs/inode.c:887: warning: Function parameter or member 'mnt_userns' not described in 'ecryptfs_setattr'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: "Michael C. Thompsion" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 861a01713f3f4..9ac527e498e16 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2004 Erez Zadok
@@ -198,7 +198,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	return inode;
 }
 
-/**
+/*
  * ecryptfs_initialize_file
  *
  * Cause the file to be changed from a basic empty file to an ecryptfs
@@ -241,10 +241,8 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
 	return rc;
 }
 
-/**
+/*
  * ecryptfs_create
- * @dir: The inode of the directory in which to create the file.
- * @dentry: The eCryptfs dentry
  * @mode: The mode of the new file.
  *
  * Creates a new file.
@@ -312,7 +310,7 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
 	return 0;
 }
 
-/**
+/*
  * ecryptfs_lookup_interpose - Dentry interposition for a lookup
  */
 static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
@@ -872,6 +870,7 @@ ecryptfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 
 /**
  * ecryptfs_setattr
+ * @mnt_userns: user namespace of the target mount
  * @dentry: dentry handle to the inode to modify
  * @ia: Structure with flags of what to change and values
  *
-- 
2.27.0

