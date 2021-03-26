Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7746834A3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhCZJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:11:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D816C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u21so7251089ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hX4c3dvNt7mKQZ9EtHrANR7zKvje+/DsUArCAOpPAxo=;
        b=QA/F/O4mY3JFggs7g6PyX4QLf5ATVI4SuyjFEudNTz/qNNwKhEZ3p8UMZgzGFthKY8
         ufYDZcVZ20zSYIZ0Oi3sn4/nUdXb5tQcFATPNUPxswhRLwZMIdZRVskkov9guzeA0/lz
         tOmuvk13ZMy/Nyn5cdk5IX+48+brTgASB24aUUi3IAwpBxvpcxnnMyIQOhqAOA5s9dxu
         IASKKXGokYFrIwgwNxrVUsPre1ThqtXST6PUJ0pkO2/ZT3bPmxd5Vzif9My/tK7cdPAB
         xwU/n/fkidwAWiFmJe5KaQ8YFNrv2BWIeIQFg/sv94PWSTqRiQthCobLpOsWQ9kJuzUA
         M72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hX4c3dvNt7mKQZ9EtHrANR7zKvje+/DsUArCAOpPAxo=;
        b=BickColIYOh5unO23UlwiUFKUe8XrxRo74EFtyXanlmk1RxcsuKszQwpDrsGsIQJRa
         nzbrWbe2pwolve3dmrHaq/Cmh2hJ3TCe1tn960T3CBUUYeGrAJbsZo0SwPkc8Co6scMY
         9oEZE3sbA9I15V/+OyZluyWmEAULHMlt3/usPSBRpXa42hfUR+wjO1dvj6hlnAsOO2Vr
         Vyojx4MwHpoaPmhRaqoqsf2vYaHzuTq+l+eF28Wl/ql+l3jkM//Ip+XKnmjFNEnoJtuw
         GwxPA00SlcKi3jLY1RaTNdpjrs2BEOMf3JfjAOpR5r2lIllSZSXONysCZbTtnqKmgEvF
         Tu+Q==
X-Gm-Message-State: AOAM5318Rn2IZikK2ReOtZrHZanyiDgg/DozcHcF1Fp2iKOxhG+2+Ix0
        QtzvWbLWAlpaB4PMSfBh2CoI7Q==
X-Google-Smtp-Source: ABdhPJxR+lIy6DkgxMy/iXCj7OI3hGdfxIgmfkEnZ2iQ5TSwMq7S8/xoP7s0FL+OiVeUaH0ktza/hw==
X-Received: by 2002:a17:906:684b:: with SMTP id a11mr13620938ejs.329.1616749916879;
        Fri, 26 Mar 2021 02:11:56 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:11:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 02/18] fs: gfs2: xattr: Help out some kernel-doc header demote non-conformant ones
Date:   Fri, 26 Mar 2021 09:11:35 +0000
Message-Id: <20210326091151.311647-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/xattr.c:41: warning: Function parameter or member 'sdp' not described in 'ea_calc_size'
 fs/gfs2/xattr.c:41: warning: Function parameter or member 'nsize' not described in 'ea_calc_size'
 fs/gfs2/xattr.c:41: warning: Function parameter or member 'dsize' not described in 'ea_calc_size'
 fs/gfs2/xattr.c:240: warning: Function parameter or member 'ip' not described in 'ea_dealloc_unstuffed'
 fs/gfs2/xattr.c:240: warning: Function parameter or member 'bh' not described in 'ea_dealloc_unstuffed'
 fs/gfs2/xattr.c:240: warning: Function parameter or member 'ea' not described in 'ea_dealloc_unstuffed'
 fs/gfs2/xattr.c:240: warning: Function parameter or member 'prev' not described in 'ea_dealloc_unstuffed'
 fs/gfs2/xattr.c:463: warning: expecting prototype for ea_iter_unstuffed(). Prototype was for gfs2_iter_unstuffed() instead
 fs/gfs2/xattr.c:587: warning: expecting prototype for gfs2_xattr_get(). Prototype was for __gfs2_xattr_get() instead
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'ip' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'type' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'name' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'data' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Function parameter or member 'size' not described in 'ea_init'
 fs/gfs2/xattr.c:814: warning: Excess function parameter 'er' description in 'ea_init'
 fs/gfs2/xattr.c:1181: warning: Function parameter or member 'inode' not described in '__gfs2_xattr_set'
 fs/gfs2/xattr.c:1181: warning: Excess function parameter 'ip' description in '__gfs2_xattr_set'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/xattr.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 124b3d5a72665..fe2109789f75b 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -26,12 +26,9 @@
 #include "trans.h"
 #include "util.h"
 
-/**
+/*
  * ea_calc_size - returns the acutal number of bytes the request will take up
  *                (not counting any unstuffed data blocks)
- * @sdp:
- * @er:
- * @size:
  *
  * Returns: 1 if the EA should be stuffed
  */
@@ -219,13 +216,8 @@ static int gfs2_ea_find(struct gfs2_inode *ip, int type, const char *name,
 	return error;
 }
 
-/**
+/*
  * ea_dealloc_unstuffed -
- * @ip:
- * @bh:
- * @ea:
- * @prev:
- * @private:
  *
  * Take advantage of the fact that all unstuffed blocks are
  * allocated from the same RG.  But watch, this may not always
@@ -448,8 +440,8 @@ ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
 }
 
 /**
- * ea_iter_unstuffed - copies the unstuffed xattr data to/from the
- *                     request buffer
+ * gfs2_iter_unstuffed - copies the unstuffed xattr data to/from the
+ *                       request buffer
  * @ip: The GFS2 inode
  * @ea: The extended attribute header structure
  * @din: The data to be copied in
@@ -573,7 +565,7 @@ int gfs2_xattr_acl_get(struct gfs2_inode *ip, const char *name, char **ppdata)
 }
 
 /**
- * gfs2_xattr_get - Get a GFS2 extended attribute
+ * __gfs2_xattr_get - Get a GFS2 extended attribute
  * @inode: The inode
  * @name: The name of the extended attribute
  * @buffer: The buffer to write the result into
@@ -801,14 +793,11 @@ static int ea_init_i(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 	return error;
 }
 
-/**
+/*
  * ea_init - initializes a new eattr block
- * @ip:
- * @er:
  *
  * Returns: errno
  */
-
 static int ea_init(struct gfs2_inode *ip, int type, const char *name,
 		   const void *data, size_t size)
 {
@@ -1164,7 +1153,7 @@ static int gfs2_xattr_remove(struct gfs2_inode *ip, int type, const char *name)
 
 /**
  * __gfs2_xattr_set - Set (or remove) a GFS2 extended attribute
- * @ip: The inode
+ * @inode: The inode
  * @name: The name of the extended attribute
  * @value: The value of the extended attribute (NULL for remove)
  * @size: The size of the @value argument
-- 
2.27.0

