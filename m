Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD563FA686
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhH1Plq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhH1Plq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:41:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D8C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 08:40:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so7126089pjt.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=akdugIMHsoyXsfhl3XKBAKae34UmKAEkl8JKPj7EnFs=;
        b=UrVAIb9+S4rwa2YODgE9Q4ZZr9y00HJhRxBrL83ksYLZ8fKwcOEDr2eWfb/kJioTvV
         r6wwj9PD2lcdcm0dzmjN3szorTZpB68tpcmTigXugfT7CsSaW7vRAkeH/aUhoofYSsjd
         5AY0+7HhaL+rOZ2K1bChM1zoh7ykuc+zEDhpbOdeBoAmgGsLhcFENCCJeqttF67RleKM
         AFwC3/KwH9+JRCJbdZCf5M9unA7CRFjtq3ICBt2rwssnFuJzVCH9ABY3Yv6Ta0vfaI0z
         odkDj03UoukCVMgHmcgUGRc2XYH6RZswiFO4LsWmLimq+CRbxDq4ORlQjisXQpkmyw78
         UKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=akdugIMHsoyXsfhl3XKBAKae34UmKAEkl8JKPj7EnFs=;
        b=qQ0uBDfoluF19TG/PhLtjgUxdZj0U81DtDtewSUXhw19eMhYAc0WrjaskhEEzCtssH
         ZOTswW9pZSjfwFd54N/90rIAdhX9IND+wd4Uq0BFbL1PjjFhYoubp8gMR51ipfRoIln7
         jEkmuu25rFF/kgq6jJLUbeOWn8yqCp6AWrrjFMf13xQdyhUhQqu32oYvChaiRzdvYvr5
         U/cV24UBA08dj7NXv8lLDVFiZEeanQn77lc2lFD1z5bDQNfQRkCtOxoJ8eX1SfMs4ub1
         FX4lsUt8GT5tIhOCx76g4vYYNhZEItbys6ntBAF4cSvy0E/QVDzfqBVSKMhwHIDZPjEa
         M2Fg==
X-Gm-Message-State: AOAM530gjSpy+SdKKDFPGcUMCi9IHK3+LK/k81v/OTT0OBxemFWST10T
        dGl2BOhvgaSc3aMADt2dfU+C
X-Google-Smtp-Source: ABdhPJyFCSQpwgZ/X8ubSpy4OipMWbOOyTJAFIoG0iqKokfsFXHKzOY/xyhQcleKJCB0UXxRqF31xw==
X-Received: by 2002:a17:90a:af8f:: with SMTP id w15mr29098349pjq.90.1630165254592;
        Sat, 28 Aug 2021 08:40:54 -0700 (PDT)
Received: from localhost.localdomain ([123.231.122.209])
        by smtp.gmail.com with ESMTPSA id d1sm9077316pfa.71.2021.08.28.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 08:40:54 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     airlied@redhat.com, sean@poorly.run, tzimmermann@suse.de,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] GPU:drm: returning ENOMEM
Date:   Sat, 28 Aug 2021 21:10:27 +0530
Message-Id: <20210828154027.8198-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory allocation is failed this patch returns out of memory error instead of -1.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/gpu/drm/udl/udl_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_connector.c b/drivers/gpu/drm/udl/udl_connector.c
index 3750fd216131..afebab6186ab 100644
--- a/drivers/gpu/drm/udl/udl_connector.c
+++ b/drivers/gpu/drm/udl/udl_connector.c
@@ -24,7 +24,7 @@ static int udl_get_edid_block(void *data, u8 *buf, unsigned int block,
 
 	read_buff = kmalloc(2, GFP_KERNEL);
 	if (!read_buff)
-		return -1;
+		return -ENOMEM;
 
 	for (i = 0; i < len; i++) {
 		int bval = (i + block * EDID_LENGTH) << 8;
-- 
2.17.1

