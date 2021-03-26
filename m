Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3132334A3E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCZJNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCZJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE183C0613B5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ce10so7315857ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1njdwRhshSVXy0eOES4wxf/WUKXCRRzOwxm8fp7f+E=;
        b=Zeb3OcnBwe0hiZcP61Lg6BSajkVVqOQuMC93dMClJKsB47R3iMxIJLVzNL7U5ZaBgb
         Ol7AhMWDUzr1YgH+WnkjCMBuKFNZzN1iVMbGLG1pUpoWZ8ohJaL06P2pxpWlCMvtfA0a
         PnP2J2D7C2T9KkCUIFTRvvLCz4Ss9pjydeNe5597jAlMQu7mUlNWUnXHtCzNwQK2BGfA
         PJ7k6l8VD6l49uWwBy0SEe0NeUsXyOuXK8Ejv43Fyuuz3OdHh/RKIHD8ivrIzcjqaF80
         3zMp61tdqzFCTse6BpEvRSw7NjGq7UB3ZuBd6rZft2iDFnvDlFEd+hsw4v2GDH7GL6lU
         CASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1njdwRhshSVXy0eOES4wxf/WUKXCRRzOwxm8fp7f+E=;
        b=Z+QyX4N3juBbrbEA++PDKd9NfZnTyhdciEIW+GD/SJ1XL9K49/kO+Us19Onlg76Mvt
         PRXFkn/RT5PXDgfkThxQ5hP3z4xXgmzb8Azf4jtZzOd/Iz17kptKe//gKclEGYzhl9he
         891z8vMDsX2ZU3lMDcqrS4a7ED7iKmH8U3zW5LQV6AjTMIyIj0HA91W1WZ5fW60odGvq
         aTYxa37fAkKCU+DWi4lvCAYpYvIxkWWZ6/nJSkpXoBJIckmxJjxLmuPbzcXM1B+eUyr3
         p3qTQ8fLPn9jb8h1Vmzv7je9fhtN9IsP837U9deS0uCEkIHSWH3safBn/EKTpVaeuXke
         ayfg==
X-Gm-Message-State: AOAM533+CAHW9qJ7pEhEj5THLeqhiJEXx+MOlysgxWY+FLwKWUDrgR6c
        W/7vCyJFVyHvj85EixX6RbAjiQ==
X-Google-Smtp-Source: ABdhPJycW/zb7Hhq5xkauZbWOmpyno9uCrxt/IhwOdBD3FCy6HyY1KXJ2ZBQjQ29J82c6Mj0vKsmIg==
X-Received: by 2002:a17:906:8807:: with SMTP id zh7mr14083856ejb.196.1616749927732;
        Fri, 26 Mar 2021 02:12:07 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 14/18] fs: gfs2: rgrp: Fix a few kernel-doc misdemeanours
Date:   Fri, 26 Mar 2021 09:11:47 +0000
Message-Id: <20210326091151.311647-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
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

