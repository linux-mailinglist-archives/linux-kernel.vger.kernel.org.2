Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D633D20F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhGVIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhGVItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:49:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385FBC061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:30:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so4659601pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A2l/KYBC3bXoznTgQM09vSdqpXWqmsKUF+1UGlqjuAs=;
        b=iVpkBp98NPm8dzyyjh2eWotbxQtjnGNI1V2cdYfzEqO8V2JwfDNWiljVhOnth5v9vV
         JCLZ0eWSPMARC4eF7+5anNLBscRUOCtfHoDE9BKCnZ7WlthaGsCOmK+QXDfEM119EHAs
         9zlgS5BKQXnuI/wObxt9KXRXzsqsbN2pSrv1E0A32+AJpLQstfJPNoTDW/ZyBMRsjUP2
         r2sAKbAPGA3A+lGRQQztqiF4D5bzJk3Q+J98dqlC5BzylIBi16x4VN1uqrrEBkPEEset
         6PuSnPzJSKGWMrW1iyPf8aoz8Uha7BQm5bq2xoH9ONbdjpUqxiJjkvhO0EgprYuGFl2/
         dqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2l/KYBC3bXoznTgQM09vSdqpXWqmsKUF+1UGlqjuAs=;
        b=qkf4RjZUr/G12ag3J6Sdf2KxExvrinvLVPHI7tQ72k6MxcKW2hmAxGFBgJbAPnEhuX
         AfgUOwM8o/fZCa3tWJH3a+qhFuR3o02pjxcClP91VwMOGNPjvopStvx5hpYhMJZUusJI
         VeWfXN8q8GEqObMrO6YsC7tQrthq3dFGN7cUp20thALNewGwXIE710psHum0nyCpEi5X
         lIhrW/xhtJrC9Avc/b+rrNQTRHWSbp708tqQqy09nXia8JjVXZxcQ5eBhBPC1hOzokGO
         xxpkkpImmD82ugU3eXPUP6GY4a26qi19pAEnLOkur2mTOfpiqB6Hag5Sah2FrHrKzkGD
         ukew==
X-Gm-Message-State: AOAM531qP/FDayxfSGr/e0icxBHIKRQ1NAsjDsXJsiSieGi/77cqzgk4
        LFgzc43Jf50h9gnJaXr8rFE=
X-Google-Smtp-Source: ABdhPJwWSq7bPLEO8MIHqEQ+hopaL1ENBkio6HpKz1UWTD3GAqFQS/Lxme9q8QwdqhvLTnGtDD1QDA==
X-Received: by 2002:a17:90a:8811:: with SMTP id s17mr8215397pjn.171.1626946221835;
        Thu, 22 Jul 2021 02:30:21 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id q5sm1069592pjo.7.2021.07.22.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:30:21 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 3/3] drm/vmwgfx: fix potential UAF in vmwgfx_surface.c
Date:   Thu, 22 Jul 2021 17:29:29 +0800
Message-Id: <20210722092929.244629-4-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722092929.244629-1-desmondcheongzx@gmail.com>
References: <20210722092929.244629-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_file.master should be protected by either drm_device.master_mutex
or drm_file.master_lookup_lock when being dereferenced. However,
drm_master_get is called on unprotected file_priv->master pointers in
vmw_surface_define_ioctl and vmw_gb_surface_define_internal.

This is fixed by replacing drm_master_get with drm_file_get_master.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 0eba47762bed..5d53a5f9d123 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -865,7 +865,7 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	user_srf->prime.base.shareable = false;
 	user_srf->prime.base.tfile = NULL;
 	if (drm_is_primary_client(file_priv))
-		user_srf->master = drm_master_get(file_priv->master);
+		user_srf->master = drm_file_get_master(file_priv);
 
 	/**
 	 * From this point, the generic resource management functions
@@ -1534,7 +1534,7 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 
 	user_srf = container_of(srf, struct vmw_user_surface, srf);
 	if (drm_is_primary_client(file_priv))
-		user_srf->master = drm_master_get(file_priv->master);
+		user_srf->master = drm_file_get_master(file_priv);
 
 	res = &user_srf->srf.res;
 
-- 
2.25.1

