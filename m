Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6015A36C203
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhD0JqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhD0Jp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:45:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1ACC061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:44:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h10so69155620edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n42LGu+VcJUysptGCXvSA/WZLd2LrRzztiVguwQc09Q=;
        b=XnxbtZIP9SkSEsgl/ckHpw1mbDkpCAbaBdzHz3ZSFlbx2gsgLrN1J1ZJTdFntFmCDD
         vFj4ZlVGFz/PLNXQLttws2gflfuvezcSTbVLLwKtoa6pbbEJ36wJza1ZQEugP4o7rrim
         MZ5TGnwldkEUDlkjbENXJ08ZpMRalXbMrm5OFzrPX8ZdV+L40u455YOff/d0OiZPybdZ
         Rg/hfYGJviGADJTzeQH9Pqo83jESrLoesmL3sMWkiOhXaVR7tH6o1Wgs+mgsTblxPa7x
         NAVmSz03XdKwT15NB02n2QBfRxTVhFp4VdhSAYthW375amQtjaaXYLWaD5K1j7eQrNa7
         OzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n42LGu+VcJUysptGCXvSA/WZLd2LrRzztiVguwQc09Q=;
        b=XFohWN6tM7L/nE+1RhZHw4gXinBEtsMtt3ligKuYKgm2Lu/WYV6+ZEa807wHJYbhiG
         5kaAdWgCPI67skTDWCPe0garZryNEWRPGkDhnBVPWQc0yV/EmPt+jB+7fNA0PMW9yHwj
         ijFV4OpCnhBIR8ByQESqb0d/Dw3F06ukwTAAmjVEML20UvDGGVdSRcrOkURv3Xk52iqr
         VIr/EemDceLcR5AGXtzynM+pQXQliap3Y+H6/+7WEf+J03daCwFdnjcgFqp+6qd4faH/
         VQ+s3qrTS1gTMsGIVimLpwSIu/oMmMB3cLW/zqNfSXBhrCFdLB6eyGyvZNZq3bmzkULy
         cdsw==
X-Gm-Message-State: AOAM5326FH1uLkNOGLeXsASIK6pdurETA2WzEQgr3GYyJPviemvGJ/JB
        4tF0cpsc2Prq9UUD4qK7dIM=
X-Google-Smtp-Source: ABdhPJwDsvVc3VedFDCEoCLMmkddpD77bEIQAmQYJT61GMi3hBoYlkyBR2tvMEkQ0+KlR0/0sYS4uQ==
X-Received: by 2002:a50:eb89:: with SMTP id y9mr3229136edr.172.1619516696345;
        Tue, 27 Apr 2021 02:44:56 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id mf27sm7602704ejb.63.2021.04.27.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 02:44:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        shaoyunl <shaoyun.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4] drm/amd/amdgpu/amdgpu_drv.c: Replace drm_modeset_lock_all with drm_modeset_lock
Date:   Tue, 27 Apr 2021 11:44:49 +0200
Message-Id: <20210427094449.14730-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_modeset_lock_all() is not needed here, so it is replaced with
drm_modeset_lock(). The crtc list around which we are looping never
changes, therefore the only lock we need is to protect access to
crtc->state.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

Changes from v3: CC'ed more (previously missing) maintainers.
Changes from v2: Drop file name from the Subject. Cc'ed all maintainers.
Changes from v1: Removed unnecessary braces around single statement
block.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80130c1c0c68..39204dbc168b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1595,17 +1595,15 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	if (amdgpu_device_has_dc_support(adev)) {
 		struct drm_crtc *crtc;
 
-		drm_modeset_lock_all(drm_dev);
-
 		drm_for_each_crtc(crtc, drm_dev) {
-			if (crtc->state->active) {
+			drm_modeset_lock(&crtc->mutex, NULL);
+			if (crtc->state->active)
 				ret = -EBUSY;
+			drm_modeset_unlock(&crtc->mutex);
+			if (ret < 0)
 				break;
-			}
 		}
 
-		drm_modeset_unlock_all(drm_dev);
-
 	} else {
 		struct drm_connector *list_connector;
 		struct drm_connector_list_iter iter;
-- 
2.31.1

