Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C334EE44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhC3QpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhC3QpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so16885857wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgH3DJxocfXj8CzPXRPGR+bvGOz2TXMRbIxLhnqfhyo=;
        b=sqeFvMwRcd3ikRNA8lnNvx8LIrR6I0WGwBmpWqWu6CocjnsePHOO2YRNjc4gw+kJg9
         gmCjhmvv+oQdgR686L0ElUsxwE9bixgpJRBhXIYl7Fv23I1VoBwCEWwPEuyD3xrx4YGf
         3x/JAywdoXZzVQ5O4fB3HzO3OYnKHBEVYPS8epWIOTkJf5b16ZtYv6COQFYkqVjt0aal
         +T0YqJO11rG8GLavfXzYW9KKr+T6wrp04sNySjOpk82ELRcg9YR9LsawDqoJHndF88Fa
         lOGtiS1tSsrSKnSrRIj5s5pHZPOR5Ouozm01QVH+1bhsJ7l38wYPpNByrANjN0UW6pIs
         v0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgH3DJxocfXj8CzPXRPGR+bvGOz2TXMRbIxLhnqfhyo=;
        b=LfArDSakR8VRld3VOyhT23iVOCod1Npmjq0WN0kGUh44W3XvARkSHwqDFzBOAiY13m
         eP15tN0g9EXgJ3VQAEMLzSX2liS6O9puiJ9Iahq1z0FFpno2WKq1nd3bi2SPiYjkxYKn
         OXjZNk2oMz6fy1xd7rdollMKgpnVk2djWnfjyXa0pqKpbndvpskGBvqBxca2X4VqEqE0
         jaxR80efEAA7hJke8dkMAnVYed5P6rxFS6XLU2GE5Nml2G7TYFTms2OyA5uSEa2Oed4S
         4wJHTvurpVsX/XGqh1Be4YhSHf9bDJ8HnqUHznThNE/++OJQh7ALfBZMLJvzJ9LTdpws
         QX3Q==
X-Gm-Message-State: AOAM532HryJMnghLJ4Yl14+qkZIso0E7HxmQ1Vaw85qSkgRtmCu+AcgB
        of6SRjK58G3wQPndNB06cdtnNg==
X-Google-Smtp-Source: ABdhPJws1Qko4Cx2qR/gy8xBRjKR25JXC+t27LNEoN/7S9huCXZU1SuL6zGBIsZhImOeMJESQK1JmA==
X-Received: by 2002:a5d:6304:: with SMTP id i4mr34815235wru.155.1617122702461;
        Tue, 30 Mar 2021 09:45:02 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 01/31] fs: gfs2: dir: Finish off mostly complete headers demote others
Date:   Tue, 30 Mar 2021 17:44:28 +0100
Message-Id: <20210330164458.1625478-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/dir.c:781: warning: Function parameter or member 'index' not described in 'get_leaf_nr'
 fs/gfs2/dir.c:907: warning: Function parameter or member 'inode' not described in 'dir_make_exhash'
 fs/gfs2/dir.c:907: warning: Excess function parameter 'dip' description in 'dir_make_exhash'
 fs/gfs2/dir.c:1002: warning: Function parameter or member 'inode' not described in 'dir_split_leaf'
 fs/gfs2/dir.c:1002: warning: Function parameter or member 'name' not described in 'dir_split_leaf'
 fs/gfs2/dir.c:1002: warning: Excess function parameter 'dip' description in 'dir_split_leaf'
 fs/gfs2/dir.c:1002: warning: Excess function parameter 'leaf_no' description in 'dir_split_leaf'
 fs/gfs2/dir.c:1268: warning: Function parameter or member 'sort_start' not described in 'do_filldir_main'
 fs/gfs2/dir.c:1479: warning: Function parameter or member 'inode' not described in 'gfs2_dir_readahead'
 fs/gfs2/dir.c:1479: warning: Function parameter or member 'hsize' not described in 'gfs2_dir_readahead'
 fs/gfs2/dir.c:1479: warning: Function parameter or member 'index' not described in 'gfs2_dir_readahead'
 fs/gfs2/dir.c:1479: warning: Function parameter or member 'f_ra' not described in 'gfs2_dir_readahead'
 fs/gfs2/dir.c:1528: warning: Function parameter or member 'inode' not described in 'dir_e_read'
 fs/gfs2/dir.c:1528: warning: Function parameter or member 'f_ra' not described in 'dir_e_read'
 fs/gfs2/dir.c:1528: warning: Excess function parameter 'dip' description in 'dir_e_read'
 fs/gfs2/dir.c:1642: warning: Function parameter or member 'dir' not described in 'gfs2_dir_search'
 fs/gfs2/dir.c:1642: warning: Excess function parameter 'dip' description in 'gfs2_dir_search'
 fs/gfs2/dir.c:1873: warning: Function parameter or member 'dentry' not described in 'gfs2_dir_del'
 fs/gfs2/dir.c:1873: warning: Excess function parameter 'filename' description in 'gfs2_dir_del'
 fs/gfs2/dir.c:1934: warning: Function parameter or member 'filename' not described in 'gfs2_dir_mvino'
 fs/gfs2/dir.c:1934: warning: Function parameter or member 'nip' not described in 'gfs2_dir_mvino'
 fs/gfs2/dir.c:1934: warning: Function parameter or member 'new_type' not described in 'gfs2_dir_mvino'
 fs/gfs2/dir.c:1934: warning: Excess function parameter 'new_inode' description in 'gfs2_dir_mvino'
 fs/gfs2/dir.c:1971: warning: Function parameter or member 'last_dealloc' not described in 'leaf_dealloc'
 fs/gfs2/dir.c:2154: warning: Function parameter or member 'inode' not described in 'gfs2_diradd_alloc_required'
 fs/gfs2/dir.c:2154: warning: Function parameter or member 'name' not described in 'gfs2_diradd_alloc_required'
 fs/gfs2/dir.c:2154: warning: Excess function parameter 'ip' description in 'gfs2_diradd_alloc_required'
 fs/gfs2/dir.c:2154: warning: Excess function parameter 'filname' description in 'gfs2_diradd_alloc_required'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/dir.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index c0f2875c946c9..9c1caaef3f0cd 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -767,7 +767,7 @@ static int get_leaf(struct gfs2_inode *dip, u64 leaf_no,
 	return error;
 }
 
-/**
+/*
  * get_leaf_nr - Get a leaf number associated with the index
  * @dip: The GFS2 inode
  * @index:
@@ -775,7 +775,6 @@ static int get_leaf(struct gfs2_inode *dip, u64 leaf_no,
  *
  * Returns: 0 on success, error code otherwise
  */
-
 static int get_leaf_nr(struct gfs2_inode *dip, u32 index,
 		       u64 *leaf_out)
 {
@@ -898,7 +897,7 @@ static struct gfs2_leaf *new_leaf(struct inode *inode, struct buffer_head **pbh,
 
 /**
  * dir_make_exhash - Convert a stuffed directory into an ExHash directory
- * @dip: The GFS2 inode
+ * @inode: The GFS2 inode
  *
  * Returns: 0 on success, error code otherwise
  */
@@ -989,11 +988,9 @@ static int dir_make_exhash(struct inode *inode)
 	return 0;
 }
 
-/**
+/*
  * dir_split_leaf - Split a leaf block into two
- * @dip: The GFS2 inode
- * @index:
- * @leaf_no:
+ * @inode: The GFS2 inode
  *
  * Returns: 0 on success, error code on failure
  */
@@ -1252,6 +1249,7 @@ static int compare_dents(const void *a, const void *b)
  * @ctx: what to feed the entries to
  * @darr: an array of struct gfs2_dirent pointers to read
  * @entries: the number of entries in darr
+ * @sort_start: the index into @darr to start the sort from
  * @copied: pointer to int that's non-zero if a entry has been copied out
  *
  * Jump through some hoops to make sure that if there are hash collsions,
@@ -1466,7 +1464,7 @@ static int gfs2_dir_read_leaf(struct inode *inode, struct dir_context *ctx,
 	return error;
 }
 
-/**
+/*
  * gfs2_dir_readahead - Issue read-ahead requests for leaf blocks.
  *
  * Note: we can't calculate each index like dir_e_read can because we don't
@@ -1515,14 +1513,11 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
 	}
 }
 
-/**
+/*
  * dir_e_read - Reads the entries from a directory into a filldir buffer
- * @dip: dinode pointer
- * @ctx: actor to feed the entries to
  *
  * Returns: errno
  */
-
 static int dir_e_read(struct inode *inode, struct dir_context *ctx,
 		      struct file_ra_state *f_ra)
 {
@@ -1627,7 +1622,7 @@ int gfs2_dir_read(struct inode *inode, struct dir_context *ctx,
 
 /**
  * gfs2_dir_search - Search a directory
- * @dip: The GFS2 dir inode
+ * @dir: The GFS2 dir inode
  * @name: The name we are looking up
  * @fail_on_exist: Fail if the name exists rather than looking it up
  *
@@ -1636,7 +1631,6 @@ int gfs2_dir_read(struct inode *inode, struct dir_context *ctx,
  *
  * Returns: errno
  */
-
 struct inode *gfs2_dir_search(struct inode *dir, const struct qstr *name,
 			      bool fail_on_exist)
 {
@@ -1864,11 +1858,10 @@ int gfs2_dir_add(struct inode *inode, const struct qstr *name,
 /**
  * gfs2_dir_del - Delete a directory entry
  * @dip: The GFS2 inode
- * @filename: The filename
+ * @dentry: The directory entry to delete
  *
  * Returns: 0 on success, error code on failure
  */
-
 int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 {
 	const struct qstr *name = &dentry->d_name;
@@ -1916,11 +1909,9 @@ int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 	return 0;
 }
 
-/**
+/*
  * gfs2_dir_mvino - Change inode number of directory entry
  * @dip: The GFS2 inode
- * @filename:
- * @new_inode:
  *
  * This routine changes the inode number of a directory entry.  It's used
  * by rename to change ".." when a directory is moved.
@@ -1960,7 +1951,7 @@ int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
  * @len: the number of pointers to this leaf
  * @leaf_no: the leaf number
  * @leaf_bh: buffer_head for the starting leaf
- * last_dealloc: 1 if this is the final dealloc for the leaf, else 0
+ * @last_dealloc: 1 if this is the final dealloc for the leaf, else 0
  *
  * Returns: errno
  */
@@ -2142,8 +2133,8 @@ int gfs2_dir_exhash_dealloc(struct gfs2_inode *dip)
 
 /**
  * gfs2_diradd_alloc_required - find if adding entry will require an allocation
- * @ip: the file being written to
- * @filname: the filename that's going to be added
+ * @inode: The directory inode
+ * @name: the filename that's going to be added
  * @da: The structure to return dir alloc info
  *
  * Returns: 0 if ok, -ve on error
-- 
2.27.0

