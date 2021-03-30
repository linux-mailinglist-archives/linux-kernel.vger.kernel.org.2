Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1BD34EE32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhC3QpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhC3QpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B154C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j18so16900645wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HmJyYvfh3odbCbwdOHWuZiUzII2bd3LZhTWqsOobYI=;
        b=N6ms+42hVq78eqMDHvrJ+KubWmadCxO/RdIMH/6ke8oTXSzQBpZSyFYwiJucLjMQfJ
         wuRqinNGe7EwXnT2bZ8egaUn9iuIISaciRm355A60HCpPAWOPQQfRDJs2euDMW6Ir7La
         oJ8xI146jd2PxEXMMoWofSec0N/BcDbCetmnGbig+K0aRbzILu2hcwwlJhBbUQk3tgKl
         yehqR/nMxiVnC/k5hTEre8U/jmT53Ts6LSsid5lIpGi74uNAzq1e5cWgC7Tgdo2hZcFO
         RtNQsDvpTpPrCTLse+qT1s3etR9QsB4RVnJ1hJt/MtA910vsR1QBQg7QjWcMRDsmMzUt
         YLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HmJyYvfh3odbCbwdOHWuZiUzII2bd3LZhTWqsOobYI=;
        b=B7eO0MHQQqKB1s/DNdD41kHTvUK9jREsu7Mx/UHwUlVLc5q4V8WBnKGeF25/xx67cW
         cr6uSzZuvH3Su+5gWovuJxtmGX1ih/J5BVXAvf4Qx9s61krbMibiwsaAuP2rRECTFI5V
         NpD9kfb1d0tzq24nPHzNQYWNT+yie2t8oYptRVvsPnrZ6pwUAnQVFavPjgroBPISlLbu
         vSzadsyW99mzPkdGdQV1oeL4kcjaZkHkLFA1ulkNRmAJ0odSXcTyUtC5JDqpLYKCs8cL
         XkCPI7o4UDjSkr8tb+p0Q4jeTqH/tGQqDBM85E+osBHl//Up8T1jBZX2yQCS485lgcI+
         Cpkw==
X-Gm-Message-State: AOAM532ddyJSOfuw+iOKpNiXXtSdbTG4sHEMHwhOkrCGQdvH7eGIqC4U
        5FBuiWCXwTsVIFaybqqPvzGopw==
X-Google-Smtp-Source: ABdhPJyXF7nfP1hcwCVfZjQ+Nv2wGEGsayY2DesI2BlKYoJNiZWkKpKccBiEzU+tuwBhYUpiEe92RQ==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr34598645wrx.91.1617122707218;
        Tue, 30 Mar 2021 09:45:07 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 06/31] fs: gfs2: lops: Help out worthy kernel-doc headers and demote others
Date:   Tue, 30 Mar 2021 17:44:33 +0100
Message-Id: <20210330164458.1625478-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/lops.c:106: warning: Function parameter or member 'tr' not described in 'gfs2_unpin'
 fs/gfs2/lops.c:106: warning: Excess function parameter 'flags' description in 'gfs2_unpin'
 fs/gfs2/lops.c:300: warning: Function parameter or member 'biop' not described in 'gfs2_log_get_bio'
 fs/gfs2/lops.c:300: warning: Excess function parameter 'bio' description in 'gfs2_log_get_bio'
 fs/gfs2/lops.c:333: warning: Function parameter or member 'jd' not described in 'gfs2_log_write'
 fs/gfs2/lops.c:428: warning: Function parameter or member 'head' not described in 'gfs2_jhead_pg_srch'
 fs/gfs2/lops.c:471: warning: Function parameter or member 'head' not described in 'gfs2_jhead_process_page'
 fs/gfs2/lops.c:513: warning: Function parameter or member 'keep_cache' not described in 'gfs2_find_jhead'
 fs/gfs2/lops.c:983: warning: Function parameter or member 'sdp' not described in 'databuf_lo_before_commit'
 fs/gfs2/lops.c:983: warning: Function parameter or member 'tr' not described in 'databuf_lo_before_commit'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/lops.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index a82f4747aa8d5..390ac939aa757 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -92,13 +92,10 @@ static void maybe_release_space(struct gfs2_bufdata *bd)
 	rgrp_unlock_local(rgd);
 }
 
-/**
+/*
  * gfs2_unpin - Unpin a buffer
  * @sdp: the filesystem the buffer belongs to
  * @bh: The buffer to unpin
- * @ai:
- * @flags: The inode dirty flags
- *
  */
 
 static void gfs2_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
@@ -281,7 +278,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
  * gfs2_log_get_bio - Get cached log bio, or allocate a new one
  * @sdp: The super block
  * @blkno: The device block number we want to write to
- * @bio: The bio to get or allocate
+ * @biop: The bio to get or allocate
  * @op: REQ_OP
  * @end_io: The bi_end_io callback
  * @flush: Always flush the current bio and allocate a new one?
@@ -317,6 +314,7 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
 /**
  * gfs2_log_write - write to log
  * @sdp: the filesystem
+ * @jd: The journal descriptor
  * @page: the page to write
  * @size: the size of the data to write
  * @offset: the offset within the page 
@@ -417,6 +415,7 @@ static void gfs2_end_log_read(struct bio *bio)
 /**
  * gfs2_jhead_pg_srch - Look for the journal head in a given page.
  * @jd: The journal descriptor
+ * @head: the head journal to start from
  * @page: The page to look in
  *
  * Returns: 1 if found, 0 otherwise.
@@ -450,6 +449,7 @@ static bool gfs2_jhead_pg_srch(struct gfs2_jdesc *jd,
  * gfs2_jhead_process_page - Search/cleanup a page
  * @jd: The journal descriptor
  * @index: Index of the page to look into
+ * @head: the head journal to start from
  * @done: If set, perform only cleanup, else search and set if found.
  *
  * Find the page with 'index' in the journal's mapping. Search the page for
@@ -502,6 +502,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
  * gfs2_find_jhead - find the head of a log
  * @jd: The journal descriptor
  * @head: The log descriptor for the head of the log is returned here
+ * @keep_cache: If set inode pages will not be truncated
  *
  * Do a search of a journal by reading it in large chunks using bios and find
  * the valid log entry with the highest sequence number.  (i.e. the log head)
@@ -974,7 +975,7 @@ static void revoke_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
 	gfs2_revoke_clean(jd);
 }
 
-/**
+/*
  * databuf_lo_before_commit - Scan the data buffers, writing as we go
  *
  */
-- 
2.27.0

