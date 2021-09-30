Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88141D112
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347697AbhI3Bq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbhI3BqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:46:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:44:42 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q205so5564099iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqWt1AT/nKFdPrLGOkMe+DiZuRwHUZkgfm0b5xYXC7E=;
        b=HVjcVjCZM9k2FoRt9qJe2w33eLBEJQRx8dtXUPuls4VUl1aBc+HrXXDxii195mUZeR
         yc4uXCU5373owLFDV7wVdFPOY8u3CxfvZJaW2s8dSquBmLHPwIC52mmKRmY87sixmnHX
         JhyjZxrcIYCBtQBCKQpwjbcxCv6ujPPQ1teXYDEQU366gpGvtPrb92OOP8EmDyykuiFV
         xhzfIzM2lfA7U5L2n60EHxdf0gFiVM097CIU11QOdEnAev3O5DD8CDkbHZmrmw7AZ9t0
         bJifnTUdRgXvb9T0n+P854S9/AtpeJC3P84Ql7TR1v6mpG+2EC3mKkN4gCKzmbADuw3S
         Y06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqWt1AT/nKFdPrLGOkMe+DiZuRwHUZkgfm0b5xYXC7E=;
        b=QvbsN9Q932J8iebvCFKFe23a4WB7LHK5YCJbI0ZPkU/jP0B0ET6mLRcxWFlBhj7xev
         PNurBahJV0sgYINiJxggguTLwtzn5YN8aLDb7lQB5QbQLxRME6aecT8VXbSZyBhp3BBR
         dTjT89Jjw6r7sII/tAFGYT1548qeuD7Zs8g3LDupEzY1tBrXUhZzIxb4phNGFyI0z3yO
         zKHZNVwd1vxT+iFWq26ai5aWhZk2YsD+GanuNawjXYmoHfTCh1p/liZRNAdx/FTZ5zcR
         +sz3Q32KTbU65SyezJlNpm5eN11JJ168STbovRt3VlVLp5BjGx8Zkb32EjmzoLrpAOL1
         6BUA==
X-Gm-Message-State: AOAM5312XTRb9x9xEPiZy45Y9qbbCauPhr9AGR+fu6xCrEP8pC52O4Mf
        fHLyj18/Jnr9WnAl0Nqk/rM6zPJ+iUs=
X-Google-Smtp-Source: ABdhPJyqJOZnrB6AlNc551XGYlGQnMW2K/MQje5PFFr50Q6DIuuNaOhpCkZd44KY7XunZ6I3N1GYFg==
X-Received: by 2002:a05:6638:59:: with SMTP id a25mr2583089jap.92.1632966282293;
        Wed, 29 Sep 2021 18:44:42 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id h23sm1155414ila.32.2021.09.29.18.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 18:44:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/4] nouveau: fold multiple DRM_DEBUG_DRIVERs together
Date:   Wed, 29 Sep 2021 19:44:26 -0600
Message-Id: <20210930014427.14239-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930014427.14239-1-jim.cromie@gmail.com>
References: <20210930014427.14239-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DRM_USE_DYNAMIC_DEBUG, each callsite record requires 56 bytes.
We can combine 12 into one here and save ~620 bytes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 36 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 1f828c9f691c..d9fbd249dbaa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1242,19 +1242,29 @@ nouveau_drm_pci_table[] = {
 
 static void nouveau_display_options(void)
 {
-	DRM_DEBUG_DRIVER("Loading Nouveau with parameters:\n");
-
-	DRM_DEBUG_DRIVER("... tv_disable   : %d\n", nouveau_tv_disable);
-	DRM_DEBUG_DRIVER("... ignorelid    : %d\n", nouveau_ignorelid);
-	DRM_DEBUG_DRIVER("... duallink     : %d\n", nouveau_duallink);
-	DRM_DEBUG_DRIVER("... nofbaccel    : %d\n", nouveau_nofbaccel);
-	DRM_DEBUG_DRIVER("... config       : %s\n", nouveau_config);
-	DRM_DEBUG_DRIVER("... debug        : %s\n", nouveau_debug);
-	DRM_DEBUG_DRIVER("... noaccel      : %d\n", nouveau_noaccel);
-	DRM_DEBUG_DRIVER("... modeset      : %d\n", nouveau_modeset);
-	DRM_DEBUG_DRIVER("... runpm        : %d\n", nouveau_runtime_pm);
-	DRM_DEBUG_DRIVER("... vram_pushbuf : %d\n", nouveau_vram_pushbuf);
-	DRM_DEBUG_DRIVER("... hdmimhz      : %d\n", nouveau_hdmimhz);
+	DRM_DEBUG_DRIVER("Loading Nouveau with parameters:\n"
+			 "... tv_disable   : %d\n"
+			 "... ignorelid    : %d\n"
+			 "... duallink     : %d\n"
+			 "... nofbaccel    : %d\n"
+			 "... config       : %s\n"
+			 "... debug        : %s\n"
+			 "... noaccel      : %d\n"
+			 "... modeset      : %d\n"
+			 "... runpm        : %d\n"
+			 "... vram_pushbuf : %d\n"
+			 "... hdmimhz      : %d\n"
+			 , nouveau_tv_disable
+			 , nouveau_ignorelid
+			 , nouveau_duallink
+			 , nouveau_nofbaccel
+			 , nouveau_config
+			 , nouveau_debug
+			 , nouveau_noaccel
+			 , nouveau_modeset
+			 , nouveau_runtime_pm
+			 , nouveau_vram_pushbuf
+			 , nouveau_hdmimhz);
 }
 
 static const struct dev_pm_ops nouveau_pm_ops = {
-- 
2.31.1

