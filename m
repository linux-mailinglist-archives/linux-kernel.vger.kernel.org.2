Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE834EE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhC3Qqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhC3QpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47528C0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so16875361wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1njdwRhshSVXy0eOES4wxf/WUKXCRRzOwxm8fp7f+E=;
        b=zWUQtGGPtZHwfwiiCV3P//jqLVOrGQ8lUotiyjrV3wuEQ/fZOIyHvP9wc1V827m5nr
         kI4DW4vY8tDLioJGQtz97yce9Dkc/9W1uCA5L86fpfE4O9WPbl+VLhIzrAykrRc9fmLj
         l02GgpPXldtmUA6qa4THwwLuksKykX8eCTAzKBhMrmEzNBXL3Iht1zWuFtYerVQdDC6N
         m8f8PM7BiLtVg9u6GtwovwALF709+ma1SqnxpYEqa7GBz4e5kcJykeVnnVleLniNpE0F
         Wu1Y9TlDeD8zpzL3LsNLZnZ2bLRTTYk76eqDOCFk05r/R6ztj5sVDqFt+99zzhK21s5y
         jjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1njdwRhshSVXy0eOES4wxf/WUKXCRRzOwxm8fp7f+E=;
        b=JeAMF0jc5mGEv/YS/48SJy0DrqaqQLlL7P8jEjn0RvORdAVKdj1AjGwG2TKf4sC1lv
         292rzd5JmAnDJxZQqLFG07kFTd+BnieCt4JTEmExYreG/WF4YdplsYxr8EGWTJyeE1PA
         5F3sfKNFVSkPzPZiOI04NG+JzSgR2KxSuDlJR3OUYT538kpyBSMZ22uEjpa5wMBLRGUd
         Tsar7qiKhWacgqmqsv1GH2jZUmnxDLh9C198ENc3V9l9HimEW293s/GhljmFsU1bifBn
         G/otuO87amsJY80aGR5eVqihvRuuj4wF+/t7Mmvd0ja2E6CGJ9f45s3fsJpB5q8L5m+O
         dmAg==
X-Gm-Message-State: AOAM530pr4RqYRlyfDvC+es17RK7JucgD8jLncaygiBlXoLIOFWFdjjo
        twdtva2qdaK5PAn8yg5+ULWggw==
X-Google-Smtp-Source: ABdhPJxt8QzhE2HMOmplN4iwxdsgcPCW0HvH3PdfLfKGQgf7xkOBHa50IgLmQlkZk75bmuIDfb185Q==
X-Received: by 2002:adf:9148:: with SMTP id j66mr35679944wrj.124.1617122715069;
        Tue, 30 Mar 2021 09:45:15 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 14/31] fs: gfs2: rgrp: Fix a few kernel-doc misdemeanours
Date:   Tue, 30 Mar 2021 17:44:41 +0100
Message-Id: <20210330164458.1625478-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/rgrp.c:755: warning: expecting prototype for gfs2_compute_bitstructs(). Prototype was for compute_bitstructs() instead
 fs/gfs2/rgrp.c:1549: warning: Function parameter or member 'rs' not described in 'rgd_free'
 fs/gfs2/rgrp.c:2027: warning: Function parameter or member 'rgd' not described in 'fast_to_acquire'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/rgrp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 89c37a845e649..88133c4ae8e93 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -743,7 +743,7 @@ void gfs2_clear_rgrpd(struct gfs2_sbd *sdp)
 }
 
 /**
- * gfs2_compute_bitstructs - Compute the bitmap sizes
+ * compute_bitstructs - Compute the bitmap sizes
  * @rgd: The resource group descriptor
  *
  * Calculates bitmap descriptors, one for each block that contains bitmap data
@@ -1536,6 +1536,7 @@ static void rs_insert(struct gfs2_inode *ip)
 /**
  * rgd_free - return the number of free blocks we can allocate.
  * @rgd: the resource group
+ * @rs: The reservation to free
  *
  * This function returns the number of free blocks for an rgrp.
  * That's the clone-free blocks (blocks that are free, not including those
@@ -2019,6 +2020,7 @@ static bool gfs2_select_rgrp(struct gfs2_rgrpd **pos, const struct gfs2_rgrpd *b
 
 /**
  * fast_to_acquire - determine if a resource group will be fast to acquire
+ * @rgd: The rgrp
  *
  * If this is one of our preferred rgrps, it should be quicker to acquire,
  * because we tried to set ourselves up as dlm lock master.
-- 
2.27.0

