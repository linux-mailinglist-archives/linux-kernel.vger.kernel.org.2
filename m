Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1ED34A3DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhCZJMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhCZJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E654C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l4so7279222ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+FYFjvrmmmlFKosOJsmCEZQd+qs37SblTzL1IxaAKE=;
        b=bYB5FxX8ds/xjWrKZsrsszki5NqMXqFrNdH9TvZ8AN+oEQ/+6++qQgmyd8LMjEeUmJ
         KnExTFKtHO74xBQbZhNRYPuOXnnqC/c7Ql8+gSUFDxToKFKyRw/Ef0iShnsweZlxUcdY
         OZXnhY+uBgrQ6inJIT/bEAKxVZVU0RlErDnaQb2YW4dAqQbpQn5k7AUYGxA7pILePEyD
         YBaDA7FUdqc261xFwDmlm1SxzRY6HZIWjM9tassQh5xeXGqtbOWecuK9EvdC2HGY/klX
         JEU9kgnMyb3pP+ubqaBSFxHYQaNEud2tDxjTNPVJXBW0i1gL+/klYoJVwvXXqHxNapPr
         bqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+FYFjvrmmmlFKosOJsmCEZQd+qs37SblTzL1IxaAKE=;
        b=lODBXi572zhaqoMwjrWR6SuG2r6CWuY2+zDJPPHWD5aNucj2CefaOIqtwdppLfRap+
         y8FE2BVvHQ1Mo9+S65sKgebszUnq2HJNwitNpZ8s0OQxQNlC2qS5o3AnjdRiT3G/DpAc
         U0qMIdzcYniXLT/5s4cW/6HbGrMdwr6QopzCdSN/lwmXitixBReuOVwhBWpYf6zxBXho
         Q2AYy68xKBOqKSZwArRBIunB58aDl/TdRuSPjm+ZwyiI1khFvo8vSbya61HfU4TQwEUf
         oo8jNjPl+tdsmLDkNz5ure3xiTSEHJfbFte6E3WuBzDSURzVN0jy/KZ0wj102dIua0Ew
         Vl+w==
X-Gm-Message-State: AOAM5333lXsQdrZh5S0HizkQN+dpvG+3FikAdlkJAGsb+c/VGpqsaE9A
        sixoVHrhJACcvX8PkP29bF8gUw==
X-Google-Smtp-Source: ABdhPJzJeHGCo0UYLImqJUYfxFQqyhHWKtiEd4YJgZAOfwlyGncAVLLUb2T/YZs7JQPGaRKXaTnlrA==
X-Received: by 2002:a17:906:3395:: with SMTP id v21mr14305432eja.322.1616749922360;
        Fri, 26 Mar 2021 02:12:02 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 08/18] fs: gfs2: aops: Fix a little potential doc-rot
Date:   Fri, 26 Mar 2021 09:11:41 +0000
Message-Id: <20210326091151.311647-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/aops.c:560: warning: Function parameter or member 'rac' not described in 'gfs2_readahead'
 fs/gfs2/aops.c:560: warning: Excess function parameter 'file' description in 'gfs2_readahead'
 fs/gfs2/aops.c:560: warning: Excess function parameter 'mapping' description in 'gfs2_readahead'
 fs/gfs2/aops.c:560: warning: Excess function parameter 'pages' description in 'gfs2_readahead'
 fs/gfs2/aops.c:560: warning: Excess function parameter 'nr_pages' description in 'gfs2_readahead'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/aops.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index cc4f987687f3c..23b5be3db044c 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -540,10 +540,7 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 
 /**
  * gfs2_readahead - Read a bunch of pages at once
- * @file: The file to read from
- * @mapping: Address space info
- * @pages: List of pages to read
- * @nr_pages: Number of pages to read
+ * @rac: Read-ahead control structure
  *
  * Some notes:
  * 1. This is only for readahead, so we can simply ignore any things
-- 
2.27.0

