Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ACE32BE58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385608AbhCCRUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352890AbhCCNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570CC061221
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u14so23748174wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/QIOJ+jcry9nSq3nprw2igH3RHK7U5zFD/JMioUS840=;
        b=jLQUoxJt4yKOi/a2LytqC3f9MXcNn4Ges2MV13JFH21+ISQZPa1bJwuNQ2Ri6hUvPf
         MSCY27ncYgC6IN6vgmZzR1T6D4pKHZPwAFmVroWGy7jSbLeWj3I+8YIATC3TFK7Z6kyo
         vsWNJ9T5qyAgtOynq6rfhL+oGtnJfDzITSbdlRvMIPjJHTq0KCY9YZ2NqolFx35lLnuZ
         Fdf0r9DNAO000lpRErN5MfZq56OW1eVu9aqHf9dFahotdxPJV3nNJiSfioRK+IYOClkU
         5ZwV5WPy849dLVNUZVUPEVDWGrMSkK2uTWDPrsxdHMjmSy87hgYuzeOHLUfZzpc9NE0U
         6+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QIOJ+jcry9nSq3nprw2igH3RHK7U5zFD/JMioUS840=;
        b=ghr/LqV/aCsvNSsesSs0A7h163j+U4eojHfZ054umJaHAIWh706OT0kP4vqF/y2d3f
         1RE7BqX9VVbf49h52YYwIc3IrLm3sZO8EWiCAzWSV9GtEKfg2iAac5YK64ygPC0R4seq
         pz4DOTL+KUQ9L3ZwK6Pyob4Lf4u++PRRc7ROhEGlXtMkubG7osr0PtpQsN+FEE/QeKIl
         LID4yeYazquJ2fNF8RuvUCxm7cazU3sg1gxc6AMtk2cKdReuC2JAXcNlDbTJungPIkrQ
         R4vUBTzyJwGjXzOba0bHp2AxImqkeIx6yZUQNfjtcmT+OQdP/N2QIL9SNkEU1ts43/B7
         jATA==
X-Gm-Message-State: AOAM532FxvzQpuA0C65StEgw4xBTrxAACXZvLFsFY0DsjBPUDkgGYFtt
        J2lX1I7LaiFcNn3P+6JYhgmXPg==
X-Google-Smtp-Source: ABdhPJz/Q3cgwDhOxnkaDEwTxnYCboU3jyFpnYi6sfOOtqaRWiDtP0XhJrm7UCJm7/PlZs/Z4/yTUg==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr27869115wrs.72.1614779020649;
        Wed, 03 Mar 2021 05:43:40 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:40 -0800 (PST)
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
Subject: [PATCH 10/53] drm/amd/display/dc/dce/dce_aux: Remove duplicate line causing 'field overwritten' issue
Date:   Wed,  3 Mar 2021 13:42:36 +0000
Message-Id: <20210303134319.3160762-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:59:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10014:58: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in expansion of macro ‘AUX_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:177:2: note: in expansion of macro ‘DCE_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10014:58: note: (near initialization for ‘aux_shift.AUX_SW_AUTOINCREMENT_DISABLE’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in expansion of macro ‘AUX_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:177:2: note: in expansion of macro ‘DCE_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10013:56: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in expansion of macro ‘AUX_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:181:2: note: in expansion of macro ‘DCE_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10013:56: note: (near initialization for ‘aux_mask.AUX_SW_AUTOINCREMENT_DISABLE’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in expansion of macro ‘AUX_SF’

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
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
index 775e24926380e..566b1bddd8cc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
@@ -100,7 +100,6 @@ struct dce110_aux_registers {
 	AUX_SF(AUX_SW_CONTROL, AUX_SW_GO, mask_sh),\
 	AUX_SF(AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
 	AUX_SF(AUX_SW_DATA, AUX_SW_DATA_RW, mask_sh),\
-	AUX_SF(AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
 	AUX_SF(AUX_SW_DATA, AUX_SW_INDEX, mask_sh),\
 	AUX_SF(AUX_SW_DATA, AUX_SW_DATA, mask_sh),\
 	AUX_SF(AUX_SW_STATUS, AUX_SW_REPLY_BYTE_COUNT, mask_sh),\
-- 
2.27.0

