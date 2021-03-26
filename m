Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1034A3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhCZJMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhCZJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:11:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D42C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so7327759ejs.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgH3DJxocfXj8CzPXRPGR+bvGOz2TXMRbIxLhnqfhyo=;
        b=TFjjMwIxTKAeNU+fw3Fd80rzKtHEsbDrblnlU8s7/ri/wWFFjND6VO+yM03QqnfdzC
         Cy0WwUPCbcTR7Ct55e1EGgb/UuQcXrbRF7LOvOex7H5h60bPyQBlqbOfgL2VCyyl9XKf
         mNYFrvSUjhCarxY835kU1NGfWuD+zXroGM2IPo690eROPTpwbDjzZb/lyAS1gilm8Fg4
         fMl5Knl88x/pgLK3fsI92EjPZwh7aVUShBqyai8y3OCpoukNOU6kbbbQEBoQUl4XfFXq
         ouXEcJjcLKFXOfkLT2pB6p6bEjgRbPCrXMXfDf3SLumxOYTZTVffcfN2VKaixsCTmzKZ
         J9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgH3DJxocfXj8CzPXRPGR+bvGOz2TXMRbIxLhnqfhyo=;
        b=DKgrEYAuz4FRz2ys3uHGjlqc3SiCzbLn8Q7ot4lyfjpGy/8Fu9S75Y0g9gofJXPsJN
         pY/rYckif6X/iIVaMFa3xQQ/wS4WdniCgHas5UgKhjqmcVIU4Fz5OUMM0/gKlmmTGrnz
         1pBopDk5he1I2aa3atdV0+YAe1qXCUXZSv9VyaIhkw66OS9nkdeEZpyWoalp7N8mcW7z
         B+TLfSlnpmhh2WzN46dK6pXNMaPBOtD9RLzn4MY0TZ9znWR1lgH86mKN8zxJLRVol1bz
         dKmMclq5RCYYt8iTW8bcB+wzMMZ03Gi/2LWQ5MS/VDLNZ6WPYVeu4bUgNOwK+iPaULhx
         2j1A==
X-Gm-Message-State: AOAM531p98lLN9BaTp9b2O7uyibpwXCPtOlgd4Eh1+zC+2cBxbzCO+bO
        mepn5IhLI9W5Zd5eA3+sI6xy0g==
X-Google-Smtp-Source: ABdhPJwpUh8wQHMagmRBhTdr1+38AIh6y15c0J3qnhYPq81xTQXWrvygESbWRGQmtUT9IaWouggylg==
X-Received: by 2002:a17:906:73d5:: with SMTP id n21mr14323052ejl.8.1616749915742;
        Fri, 26 Mar 2021 02:11:55 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:11:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 01/18] fs: gfs2: dir: Finish off mostly complete headers demote others
Date:   Fri, 26 Mar 2021 09:11:34 +0000
Message-Id: <20210326091151.311647-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
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

