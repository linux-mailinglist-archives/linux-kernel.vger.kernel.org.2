Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B73912C6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhEZItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhEZItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACECC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z17so198117wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qrtEkiWPh1VsC0TCpSiXhurw/AoAcdO+uVVz+pBsZfQ=;
        b=ezhWvGsdrmBxcn9brdcQNASBFzEUTDY+CWlPgn0LfRwhFwjnRx1C0WPMxVEA3cgFqx
         WNqu7WDp6Md98NycpVBE0w/QwtnsWHdzC2G/PMJF/Pj0oZYQaE2FRO2OKiuUJtb3e+Us
         q/x37uy5grJyPcj8LwAYfYfKDw4HSnk1YD9ub9NF6LKYv3FFhFH4EYk6M8sY3G9lvsrI
         Rp98ZAsTPJuUjduDt8a717DmOenksFyeISlJYJrDv+53r7X/TmADYbGRizlOS94//FBy
         qhpNPhsEEQoeRoyfwdYWCK8H6vamKnyAczb2BX5tZn9JpqB9FSs54fYUpPfH4b9poA5u
         jwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qrtEkiWPh1VsC0TCpSiXhurw/AoAcdO+uVVz+pBsZfQ=;
        b=C+rrm7uO2SJwBRnDsqfHIt4GksVjRXKz1q5+uaK214vYha4tdiebsCtfnTUMafNFtB
         EzUJ9HTQa/FIqyFORmwQbwFKP9WiUJk7oR1UugBT67FduhL9FdpKjBRMvnwkXhz8sAYi
         K8oC5Qw9EuUGDvsS17y7oOxetJcFUuQolh6nKMulqh/m7YQN9XMOVf4X1dKhbrgBduOg
         hbcuC4VJF/mxuuEB/2ZxrzH/3DKBc9fq6IeRvxOH0i/483Op0djCzPN/cLAF/Bhudd7h
         mVHLk3HLHs1znyLQBcYLOxtSr7TEQoRxchSqGneth3JjB7+stZgURLe1QUf+S3NgqtmE
         qvjQ==
X-Gm-Message-State: AOAM530TXDd5Zh9E5LYd4PSYly5xWkX98ykmA+VJZXPkXsNwQFoS+E9k
        5x9P7EN0CmKVIiwZYxnOZen/rw==
X-Google-Smtp-Source: ABdhPJzZzHw3tZBUns2t0+wWPmVsHNPAlKPZ4UZNuMBF9U/LCq6esrCB+KvyMAs+4MnFN1yCu4+QBw==
X-Received: by 2002:a5d:6484:: with SMTP id o4mr30586678wri.8.1622018856595;
        Wed, 26 May 2021 01:47:36 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/34] drm/amd/pm/powerplay/hwmgr/vega10_hwmgr: Kernel-doc headers must contain function names
Date:   Wed, 26 May 2021 09:46:58 +0100
Message-Id: <20210526084726.552052-7-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:547: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:603: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:629: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1006: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1155: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1608: warning: expecting prototype for Populates single SMC GFXSCLK structure using the provided engine clock(). Prototype was for vega10_populate_single_gfx_level() instead
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1663: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1713: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1862: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:2546: warning: expecting prototype for Initializes the SMC table and uploads it(). Prototype was for vega10_init_smc_table() instead
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:2922: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 31c61ac3bd5e1..25979106fd255 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -544,7 +544,7 @@ static int vega10_get_socclk_for_voltage_evv(struct pp_hwmgr *hwmgr,
 
 #define ATOM_VIRTUAL_VOLTAGE_ID0             0xff01
 /**
- * Get Leakage VDDC based on leakage ID.
+ * vega10_get_evv_voltages - Get Leakage VDDC based on leakage ID.
  *
  * @hwmgr:  the address of the powerplay hardware manager.
  * return:  always 0.
@@ -600,7 +600,7 @@ static int vega10_get_evv_voltages(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * Change virtual leakage voltage to actual value.
+ * vega10_patch_with_vdd_leakage - Change virtual leakage voltage to actual value.
  *
  * @hwmgr:         the address of the powerplay hardware manager.
  * @voltage:       pointer to changing voltage
@@ -626,7 +626,7 @@ static void vega10_patch_with_vdd_leakage(struct pp_hwmgr *hwmgr,
 }
 
 /**
- * Patch voltage lookup table by EVV leakages.
+ * vega10_patch_lookup_table_with_leakage - Patch voltage lookup table by EVV leakages.
  *
  * @hwmgr:         the address of the powerplay hardware manager.
  * @lookup_table:  pointer to voltage lookup table
@@ -1003,7 +1003,7 @@ static int vega10_setup_asic_task(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * Remove repeated voltage values and create table with unique values.
+ * vega10_trim_voltage_table - Remove repeated voltage values and create table with unique values.
  *
  * @hwmgr:      the address of the powerplay hardware manager.
  * @vol_table:  the pointer to changing voltage table
@@ -1152,7 +1152,7 @@ static void vega10_trim_voltage_table_to_fit_state_table(
 }
 
 /**
- * Create Voltage Tables.
+ * vega10_construct_voltage_tables - Create Voltage Tables.
  *
  * @hwmgr:  the address of the powerplay hardware manager.
  * return:  always 0
@@ -1595,7 +1595,8 @@ static int vega10_populate_smc_link_levels(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * Populates single SMC GFXSCLK structure using the provided engine clock
+ * vega10_populate_single_gfx_level - Populates single SMC GFXSCLK structure
+ *                                    using the provided engine clock
  *
  * @hwmgr:      the address of the hardware manager
  * @gfx_clock:  the GFX clock to use to populate the structure.
@@ -1660,7 +1661,8 @@ static int vega10_populate_single_gfx_level(struct pp_hwmgr *hwmgr,
 }
 
 /**
- * Populates single SMC SOCCLK structure using the provided clock.
+ * vega10_populate_single_soc_level - Populates single SMC SOCCLK structure
+ *                                    using the provided clock.
  *
  * @hwmgr:     the address of the hardware manager.
  * @soc_clock: the SOC clock to use to populate the structure.
@@ -1710,7 +1712,8 @@ static int vega10_populate_single_soc_level(struct pp_hwmgr *hwmgr,
 }
 
 /**
- * Populates all SMC SCLK levels' structure based on the trimmed allowed dpm engine clock states
+ * vega10_populate_all_graphic_levels - Populates all SMC SCLK levels' structure
+ *                                      based on the trimmed allowed dpm engine clock states
  *
  * @hwmgr:      the address of the hardware manager
  */
@@ -1859,7 +1862,8 @@ static int vega10_populate_single_memory_level(struct pp_hwmgr *hwmgr,
 }
 
 /**
- * Populates all SMC MCLK levels' structure based on the trimmed allowed dpm memory clock states.
+ * vega10_populate_all_memory_levels - Populates all SMC MCLK levels' structure
+ *                                     based on the trimmed allowed dpm memory clock states.
  *
  * @hwmgr:  the address of the hardware manager.
  * return:   PP_Result_OK on success.
@@ -2537,7 +2541,7 @@ static void vega10_check_dpm_table_updated(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * Initializes the SMC table and uploads it
+ * vega10_init_smc_table - Initializes the SMC table and uploads it
  *
  * @hwmgr:  the address of the powerplay hardware manager.
  * return:  always 0
@@ -2919,7 +2923,7 @@ static int vega10_stop_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
 }
 
 /**
- * Tell SMC to enabled the supported DPMs.
+ * vega10_start_dpm - Tell SMC to enabled the supported DPMs.
  *
  * @hwmgr:   the address of the powerplay hardware manager.
  * @bitmap:  bitmap for the features to enabled.
-- 
2.31.1

