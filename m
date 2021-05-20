Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6138AEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242490AbhETMmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbhETMl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84281C04FF1F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso2526312wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/K9QEy1CqtI+RwRITDC05ejyAQ80jXH50zTL26wkG0M=;
        b=w7rYpZ4/PoYGKY9/CAHCSNgZZCOepLXHKIfg7dO9or8O1tRzuDaTwz6sntwdMuVBNH
         F5ULPotuZVjMmkMsjRfRv7y9YflKXdsDXfW1BgrEbaIKhRhIbbR5vN9QADcddZA5LVR5
         o7pjEf54iZ8p1iPigXzgbgcDsoAreQR/S5fXI9p9LHE6/7p+9DjdvaZA/iUts1hc6dtv
         Z1LD0KFClQQNBiGd/gIPQVaa32Z1GB6CdCscwttXprN3PldBQByDRYK7ImWEzcKGiKIl
         HGEv/aB98po74Vh4iit38GKdwerSyy/pG14SQmEEDqE92qsMb8+949HMVTsMIwUwBgAS
         /uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/K9QEy1CqtI+RwRITDC05ejyAQ80jXH50zTL26wkG0M=;
        b=RFcik1dGMxaS9o0HPOre7ddPHxXKcDMhCBdJZ47Jzsg8eLyoX5MV9VflVd2B7fAc+L
         BrQ20rn/eakm4wiBX2Qo5ofdtz5cAnjWo8VVVkuR8boiDNgd0a/OGAf2NvE4wL94MkVb
         dVzFjQLxMOuyS36oT+sOt0t3i+ptkx8KpFedzz+NhRqTuEai7BRzHdzB+mH5l/owIeY5
         b15ZKF2f543p9NS/1Q6HUtVBdmtVkcYVOB3hNhpma1Lrz3ANOJbYdNyAsRI8qFPlexwu
         z0V+cjaaL2LNq30NhdzuLYVHC//v7w4AjLGRBtA5g5TcDvV1RaS/Z4DafZvP5OaVTC7t
         riOA==
X-Gm-Message-State: AOAM532hzVBxFF3zityl78gpf2udRw1/yX4jbGo72cvGQe7hTO9F0FSQ
        F26AmHhFzkX5KzXCCwhv4WWReqUbFFyT+g==
X-Google-Smtp-Source: ABdhPJzX3CgE8FEwjw8Auk2s9MqrJXJ9SSB66QlbR7ITvxPAKU4RQzbwXU88IKk3QJj9MjrY5+id6A==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr3209151wmb.121.1621512055152;
        Thu, 20 May 2021 05:00:55 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 11/15] fs: ntfs: super: Provide missing description and demote non-conformant headers
Date:   Thu, 20 May 2021 13:00:39 +0100
Message-Id: <20210520120043.3462759-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/super.c:66: warning: Function parameter or member 's' not described in 'simple_getbool'
 fs/ntfs/super.c:66: warning: Function parameter or member 'setval' not described in 'simple_getbool'
 fs/ntfs/super.c:1204: warning: Function parameter or member 'rp' not described in 'load_and_check_logfile'
 fs/ntfs/super.c:2660: warning: wrong kernel-doc identifier on line:

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 0d7e948cb29c9..ba2be89abb23f 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -57,7 +57,7 @@ const option_t on_errors_arr[] = {
 	{ 0,			NULL }
 };
 
-/**
+/*
  * simple_getbool -
  *
  * Copied from old ntfs driver (which copied from vfat driver).
@@ -1196,6 +1196,7 @@ static bool check_mft_mirror(ntfs_volume *vol)
 /**
  * load_and_check_logfile - load and check the logfile inode for a volume
  * @vol:	ntfs super block describing device whose logfile to load
+ * @rp: 	restart page header to check
  *
  * Return 'true' on success or 'false' on error.
  */
@@ -2656,7 +2657,7 @@ static int ntfs_write_inode(struct inode *vi, struct writeback_control *wbc)
 }
 #endif
 
-/**
+/*
  * The complete super operations.
  */
 static const struct super_operations ntfs_sops = {
-- 
2.31.1

