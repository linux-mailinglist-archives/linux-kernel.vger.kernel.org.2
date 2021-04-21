Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A814367397
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbhDUTnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245449AbhDUTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:43:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53840C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:42:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so1899986wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ShTncdUzjrz6cNLv2EKSnQN/sv7lyGf36TiUA7bk/P0=;
        b=JhGwi36fjJc+zoWDVEAcd8lB5RGChTW67hYEkCOC1tUmIaOKPqs6rnKskCvBMnZFpf
         5yJA3OwFHq4WOCETMWUgYec55fTPCbFSU+jC18CLuvetf0yj+n7EQNZisWMcFu/nYbGp
         NCQDiuXgo+tvAK23b+z7iRoLHRJZRqA3teYaefAytAwg9/hsWCYG61AF3eyjdKLX+cFR
         uqy8MjhmOKF0zzGbfPdDtKe/piA7+lFKCJwC2kOkUWwd6b4RDyHRnacdwc/CxyCo24Cm
         /KXHz7sxjXjmHprM6h5KPF2uBK8beIqsEkKNkJ+aV6yaitcNzkr1tZOzJUR2FEdCKRCz
         hxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShTncdUzjrz6cNLv2EKSnQN/sv7lyGf36TiUA7bk/P0=;
        b=hOV+zFxA/5FGTx75Zy4u4nPhYSBjLhNfYiud0BriyXU5cID5vUesxJpKkVQ0RBpPU4
         7Z1GmO/uNGAPqEZSrozVyIstmmaobm8zeHE9q7oJdt/AFxAdSNt/nr9DavGW3/1Jc3+l
         j4KdYR7+cohMRb3SwKmWIhbo8W9SMynLhlo8lLf8fBz036mgoNvCp6n7vJcWqPg9jIja
         jzOG9+/uhD6ZRfFQ1aF0sts0tz9qMa1AcWjH/Qxl3qVNojrXcOKMgAVgpatscyXwZUUL
         uUffijWHG032Nktf8kJjPR3Zv37TlwDRplkearOiZ68XLSjVb54zMBphBatpu2m7y6xy
         0JjA==
X-Gm-Message-State: AOAM530t6t/pC+RIGwm66YVouD2wSrerbUX+3flF9VvFGi419Ziqe0hI
        h/I/U588Xl6WlX3gpt1D6wI=
X-Google-Smtp-Source: ABdhPJzdYSdyl7cnO5J1oIr2zrMu2Krywp24GqqGQ0qefC5fYcnsi8ZReoTLrjM0QPEQXbYRLmFNdw==
X-Received: by 2002:a05:600c:d9:: with SMTP id u25mr11619370wmm.151.1619034175119;
        Wed, 21 Apr 2021 12:42:55 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id o4sm484163wrn.81.2021.04.21.12.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:42:54 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 2/3] drm: drm_blend.c: Use tabs for code indents
Date:   Wed, 21 Apr 2021 20:42:48 +0100
Message-Id: <f441188f84aac2f9f72f36a42c88623b16cd1f87.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove space and use tabs for indent the code to follow the
Linux kernel coding conventions.
Problem found by checkpatch.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/gpu/drm/drm_blend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 26e2f2ffd255..ec37cbfabb50 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -328,8 +328,8 @@ unsigned int drm_rotation_simplify(unsigned int rotation,
 	if (rotation & ~supported_rotations) {
 		rotation ^= DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
 		rotation = (rotation & DRM_MODE_REFLECT_MASK) |
-		           BIT((ffs(rotation & DRM_MODE_ROTATE_MASK) + 1)
-		           % 4);
+			    BIT((ffs(rotation & DRM_MODE_ROTATE_MASK) + 1)
+			    % 4);
 	}
 
 	return rotation;
-- 
2.25.1

