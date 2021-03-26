Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B98B34A3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhCZJMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhCZJL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:11:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so7278930ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e231YlAtkWfHG8c7u1pVYJ7SLucjnEEbcHHLcgbxIik=;
        b=J9NrGru9033bn0p9Zx41Zv+fD8bS3QnqYo14g5im+xT5Hpc35R5Ypnp43x+ow0jHWd
         73evY4xCfZzd+F//B58ne3nepD8kLRYr5YEsArKcyufuD/uur0wgw9c9Uzq88rOnjspN
         Lp9mJt7ZZwr2ryAmdbwM4ARU+N6t+04koY5O19y+pXTqYzueIYtuI4BPRmrQY0FDv2LT
         Q5RUApkAaev64s9TxCgjRpwdReRucvRe/hpKqvxEyjqzxpp0lzT+lzCGECgTbYNdLKhs
         oyxolgey9NbG+5rQ+X2Gt2Cf35Te/cwcottp1KEhH4HH2pevK5KBKoapSWR72ZRrpcjH
         XF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e231YlAtkWfHG8c7u1pVYJ7SLucjnEEbcHHLcgbxIik=;
        b=kEZJuMKq2fIcwQB2OTz78vNIKUSCtD8E04M4fOQGS4eVrQqDUt83TjsJRBmUFLETEu
         Ars16EtIe0So+i8Z7qS5QTPCFfmNmB5O+e3vHu6rl78nTcA18shYpV/lu7nwOLY8zI/P
         scbQcvwSYNR9Wy1EETgg4BofOwGS50Bncz0g20bYscPoNuHMp1Zx4uCL6pv/mnFjSeii
         vv2s74V0y5kdXPa7pWDGiEnxsxcfp8nW6ikQ6Gh1bHeZ1dv4LH6j0EArjWtiU8faf+fR
         7TImt+r/MLEK9btxq9e4maD7goDgX/tIIro92HqfnUnPnNt6qaOdGs3H5ERoeR/oPyCZ
         CONQ==
X-Gm-Message-State: AOAM533Pj/1iqTmt0hAXr2i8oZOEJNDq3IlOBuej5z6yLQbl53KXXmrb
        Jc0hj6tsmfIdAghQq+S1TE5OUZy5hUA6Sg==
X-Google-Smtp-Source: ABdhPJyzkQEInvqkeEGiWHxYD+6avG7XT2nMg7G0CsAqwnao1BpzqsusSFiPakEw6IpyQLFjv5y9MA==
X-Received: by 2002:a17:906:ae8d:: with SMTP id md13mr14160112ejb.275.1616749917798;
        Fri, 26 Mar 2021 02:11:57 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:11:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 03/18] fs: gfs2: bmap: Demote half-complete kernel-doc headers fix others
Date:   Fri, 26 Mar 2021 09:11:36 +0000
Message-Id: <20210326091151.311647-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/bmap.c:1502: warning: Function parameter or member 'rd_gh' not described in 'sweep_bh_for_rgrps'
 fs/gfs2/bmap.c:1502: warning: Excess function parameter 'rg_gh' description in 'sweep_bh_for_rgrps'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'sdp' not described in 'find_nonnull_ptr'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'end_list' not described in 'find_nonnull_ptr'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'end_aligned' not described in 'find_nonnull_ptr'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/bmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 7a358ae051851..7ff20db4999fb 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1477,7 +1477,7 @@ int gfs2_iomap_get_alloc(struct inode *inode, loff_t pos, loff_t length,
 /**
  * sweep_bh_for_rgrps - find an rgrp in a meta buffer and free blocks therein
  * @ip: inode
- * @rg_gh: holder of resource group glock
+ * @rd_gh: holder of resource group glock
  * @bh: buffer head to sweep
  * @start: starting point in bh
  * @end: end point in bh
@@ -1656,7 +1656,7 @@ static bool mp_eq_to_hgt(struct metapath *mp, __u16 *list, unsigned int h)
 	return true;
 }
 
-/**
+/*
  * find_nonnull_ptr - find a non-null pointer given a metapath and height
  * @mp: starting metapath
  * @h: desired height to search
-- 
2.27.0

