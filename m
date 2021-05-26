Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB953912CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhEZIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhEZItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE3C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so8109686wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSDS0B4fQp47KmNI4VulVH8wz4wQl27Y7BX42nP21sg=;
        b=dcN/WRihIO90bHiQ9m0MJt0eKZLdYaTMCHRtA5oqLwEwYpsQgez2GUQcn71i3ih0jW
         plNUmFHspKhJO2iQGHv17+YcEIRq4fiTrfQWA4ghswtFulk+FsfsAv831pv8xyB2c6cG
         owohKi5lh4ZipKQPkVyvihqIPKWE8AoypYbSepOd+/l8UozrVuWyHTfYYmlUD7EQHqgh
         GwstL/JKm2DpxzzEzwW+FqvbzAxso9w8qJcpSNqPW1TEJ1oRqhaGLvsQWsR+yqoCTV9C
         1/iEm0F+7DwR2FNLxuVifk5iaWQWisncmcnNFZCooBlssHa10v7lifobDNHrux6bNLiq
         3Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSDS0B4fQp47KmNI4VulVH8wz4wQl27Y7BX42nP21sg=;
        b=fU8iSZz3qb5SPf7TDS/OdNEXDmnrBNPRGxEZfIxoybMmnRJI/wZ9o71Zl5/whhWKl9
         jHZGkOiPumjF7LDb/PrE8viyRSDQOqPKJzqz1eq7RI6503OKKDktfEBT6nJb7UDJTjEb
         F1pXA6k7Z543OFr4rUO7BGP2O4Rsl2A8MDVio0a+TL6D6E0jleE6Fn8p1RthWOsUZR3f
         ErmhyhHz1ag1I3fQHizQGgRULgjqBt9ixxc/4+CfOBxJu1YXFutwOjDZCfpHg83rzAji
         xzKXRp37NXXovLvGNRZNU+QjYL62cE5qKzoe48RPrMf3mhWi3xOrcX7SCye6WfTlnsXY
         U0CA==
X-Gm-Message-State: AOAM5314fyd3Ox/Sgl7inzFy92KmrxLrH9BXRP+qEOXwxYi/p1ww3eWZ
        6r22WCukjPHrKS1RDFntVf+4Ag==
X-Google-Smtp-Source: ABdhPJzqDrnjoRziv6JoSt76RUtBnwKhDOJNyexrZdLJodTCazVGqrbE34zIibURPetmptwFMYs0jA==
X-Received: by 2002:a05:600c:2289:: with SMTP id 9mr2320654wmf.29.1622018859683;
        Wed, 26 May 2021 01:47:39 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/34] drm/amd/display/dc/bios/command_table_helper2: Fix function name 'dal_cmd_table_helper_transmitter_bp_to_atom2()'
Date:   Wed, 26 May 2021 09:47:01 +0100
Message-Id: <20210526084726.552052-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper2.c:141: warning: expecting prototype for translate_transmitter_bp_to_atom2(). Prototype was for dal_cmd_table_helper_transmitter_bp_to_atom2() instead

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 00706b072b5f8..6d2fb112ad9f9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -129,7 +129,7 @@ bool dal_cmd_table_helper_controller_id_to_atom2(
 }
 
 /**
- * translate_transmitter_bp_to_atom2 - Translate the Transmitter to the
+ * dal_cmd_table_helper_transmitter_bp_to_atom2 - Translate the Transmitter to the
  *                                     corresponding ATOM BIOS value
  *  @t: transmitter
  *  returns: digitalTransmitter
-- 
2.31.1

