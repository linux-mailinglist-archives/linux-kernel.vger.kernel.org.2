Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74E34A3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCZJMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCZJMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC4EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r12so7316511ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK1kDFMaw5UzDowuwUYCibcsDvXfXP1I8E7qqThRaEU=;
        b=FbS86ThmchCfnSzmohAN8YbvRvyaXwZ+pwvLuT2IV0Zz4uczEQhVeWDprD1dsTzry6
         FFI8mMunfmpqO1PVCbLwqYMwLgpUTFxKgzWUkCrMr5GHr+VQpyeN82EDpDJ6TBe9LLwC
         jFANpm5xG6pHKwqrVlpp/12SkwlthVy0ueXseqWfVHibfyXBIvKdrbtcOkOh/9p5JnSb
         gUefeeq1eE5RfnWBKbsWA0jWUjJsbH0C+aiMnGJp/KNoHlmhnYzEPr21QUiirY5aPDgY
         9iixc8E+ku1ogUYJ0RjjQ4r3hOs2bs2FcrOgYTbDZpceb4INiWn9TXd7kz44pn4uRGEO
         8nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK1kDFMaw5UzDowuwUYCibcsDvXfXP1I8E7qqThRaEU=;
        b=nIMVcGvKdvfsTiBEGfsz1dPM3TU6FCkXQhVLbk3v+4MLC/foKzTK4lSvQl/s48fNua
         hQ3OX73EzpCS3FU8Pf1jX9WrynBspdYf3PT0WQMIWTDqfgdGFG2PD/yHWLt2llmHKsVS
         eoxTrEitSEvv54NiHwnCRVIMjtBJE0ZZf4CXPV7oOaanWSqY29RDHB85W6sB1jjbedf5
         Ci4TipdVvORDMI1LHTW67o0IncHAP2jxxMgAJmIfg2Iag5XbIIScaa8ZKMXuqDWdoW1q
         6w/ACh1TzTuxihP2XCgZAAu8z/IgkIbrFT1RY8HNlf6OB7hUuVe5cmD+7LyvAfab6yIf
         4EGg==
X-Gm-Message-State: AOAM530+zMWOHcHuAyPxAuwmm5IwD1+0v1JfRgYb3LCD/w3YlozoOSkG
        J8TCtGycMwPEHJHj4QM+751gYQ==
X-Google-Smtp-Source: ABdhPJzUkCuX7Zprldus9CoL3wZ4OCF8Btg+3icBHDAkQD98rBiSLMizbOUGsRr6fr+EV7u6vxV+IA==
X-Received: by 2002:a17:906:f203:: with SMTP id gt3mr13827560ejb.346.1616749919627;
        Fri, 26 Mar 2021 02:11:59 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:11:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 05/18] fs: gfs2: log: Fix a couple of param descriptions and demote non-conformant headers
Date:   Fri, 26 Mar 2021 09:11:38 +0000
Message-Id: <20210326091151.311647-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/log.c:76: warning: Excess function parameter 'mapping' description in 'gfs2_remove_from_ail'
 fs/gfs2/log.c:97: warning: Function parameter or member 'tr' not described in 'gfs2_ail1_start_one'
 fs/gfs2/log.c:97: warning: Function parameter or member 'plug' not described in 'gfs2_ail1_start_one'
 fs/gfs2/log.c:97: warning: Excess function parameter 'ai' description in 'gfs2_ail1_start_one'
 fs/gfs2/log.c:278: warning: Function parameter or member 'sdp' not described in 'gfs2_ail_empty_tr'
 fs/gfs2/log.c:278: warning: Function parameter or member 'tr' not described in 'gfs2_ail_empty_tr'
 fs/gfs2/log.c:278: warning: Function parameter or member 'head' not described in 'gfs2_ail_empty_tr'
 fs/gfs2/log.c:1174: warning: Function parameter or member 'sdp' not described in 'gfs2_merge_trans'
 fs/gfs2/log.c:1174: warning: Excess function parameter 'old' description in 'gfs2_merge_trans'
 fs/gfs2/log.c:1293: warning: Function parameter or member 'data' not described in 'gfs2_logd'
 fs/gfs2/log.c:1293: warning: Excess function parameter 'sdp' description in 'gfs2_logd'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/log.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 6410281546f92..eef33cd251e4b 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -65,7 +65,6 @@ unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct)
 
 /**
  * gfs2_remove_from_ail - Remove an entry from the ail lists, updating counters
- * @mapping: The associated mapping (maybe NULL)
  * @bd: The gfs2_bufdata to remove
  *
  * The ail lock _must_ be held when calling this function
@@ -81,12 +80,10 @@ void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 	brelse(bd->bd_bh);
 }
 
-/**
+/*
  * gfs2_ail1_start_one - Start I/O on a part of the AIL
  * @sdp: the filesystem
  * @wbc: The writeback control structure
- * @ai: The ail structure
- *
  */
 
 static int gfs2_ail1_start_one(struct gfs2_sbd *sdp,
@@ -269,7 +266,7 @@ static void gfs2_log_update_head(struct gfs2_sbd *sdp)
 	sdp->sd_log_head = new_head;
 }
 
-/**
+/*
  * gfs2_ail_empty_tr - empty one of the ail lists of a transaction
  */
 
@@ -1166,7 +1163,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 
 /**
  * gfs2_merge_trans - Merge a new transaction into a cached transaction
- * @old: Original transaction to be expanded
+ * @sdp: the filesystem
  * @new: New transaction to be merged
  */
 
@@ -1283,7 +1280,7 @@ static inline int gfs2_ail_flush_reqd(struct gfs2_sbd *sdp)
 
 /**
  * gfs2_logd - Update log tail as Active Items get flushed to in-place blocks
- * @sdp: Pointer to GFS2 superblock
+ * @data: Pointer to GFS2 superblock
  *
  * Also, periodically check to make sure that we're using the most recent
  * journal index.
-- 
2.27.0

