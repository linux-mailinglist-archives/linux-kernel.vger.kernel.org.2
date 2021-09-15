Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDF40CAD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhIOQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhIOQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:42:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356CC0613EE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n24so4233685ion.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGySo7k0NjjBiBRbyy4yXpdKe55PNlaZiqwyz/FCdfQ=;
        b=d+p3RsTZLUbwM5WECrBsvsLpys+DqpXcTlXhgBb7KZKj1mDu72+z73rq1+Du6iMOTU
         eUwmXknjKT7t6V75qRFohcnbAJiWTLRQsQx3cdgtrobQKyLdxjm3jsQgz+ktqBlEqmtA
         B5Wdm+gsnWFnu/ww52o/gFBOeeGZmGn/HCZdMZbZ3wtpvLcyBB9Z+OkxdDwB7j0qkIAj
         GddbnQ63l0b/tGceVP6eFPkH6Wqgrt4yNEBflkB6bP/ZDugWz91uFBZUfMyoV5/d762p
         SRrz8BhmWCXjN1gtHlKdNDsKDfYmRRi3QSQP8AGUQTduNyOzxAZwmcnOY2pZMVFcrFIP
         hbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGySo7k0NjjBiBRbyy4yXpdKe55PNlaZiqwyz/FCdfQ=;
        b=3p/xxNf+g29lgO6Tw2oq06WARgLJFR9rTUoCQ6mRTAXgCFuyQ+MPitCc+HXOzENvDR
         fsLFO8OaG4MS7Co7EX4RR9Le8Sl68aSzRZHZNICczmNCOYNzF4A4R/AC9NUSCN6wz1fG
         0SXICHWlUuXrmz+TgWPH8ka8+tnWjqE9ohoyka+6v/3xqdF4R+AcUA9166sjXgxMulld
         xak2HdJN0bZu+YxlWHtZH//98xDKLIWlx9RstBBrQgPFyWMVdcSXLoY2EYV7pVon3Y0P
         bCwDkQ1zb7Aqjzv1FOi1QCx57K6bSwc5UMObeqPxkcErBrYf0GxTHU4/zwxfinJ+VxTO
         yYiA==
X-Gm-Message-State: AOAM530tOT5APqQ6GcJQ8+Nti8WNfByoGYfX4lFe/vRgkl+DzD+48HKL
        dn3c3UeOb1cCtBrP+SI/ZmU=
X-Google-Smtp-Source: ABdhPJyDQjSMRAJaMsFgpMVy1fDH3hRfwSgOHJSWZHbJXrASzvM+1k7Z90iDXwgLejhIjEzU9THisQ==
X-Received: by 2002:a6b:e905:: with SMTP id u5mr779475iof.116.1631724056597;
        Wed, 15 Sep 2021 09:40:56 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 15/16] amdgpu_ucode: reduce number of pr_debug calls
Date:   Wed, 15 Sep 2021 10:39:56 -0600
Message-Id: <20210915163957.2949166-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are blocks of DRM_DEBUG calls, consolidate their args into
single calls.  With dynamic-debug in use, each callsite consumes 56
bytes of callsite data, and this patch removes about 65 calls, so
it saves ~3.5kb.

no functional changes.

RFC: this creates multi-line log messages, does that break any syslog
conventions ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 293 ++++++++++++----------
 1 file changed, 158 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 2834981f8c08..14a9fef1f4c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -30,17 +30,26 @@
 
 static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
 {
-	DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
-	DRM_DEBUG("header_size_bytes: %u\n", le32_to_cpu(hdr->header_size_bytes));
-	DRM_DEBUG("header_version_major: %u\n", le16_to_cpu(hdr->header_version_major));
-	DRM_DEBUG("header_version_minor: %u\n", le16_to_cpu(hdr->header_version_minor));
-	DRM_DEBUG("ip_version_major: %u\n", le16_to_cpu(hdr->ip_version_major));
-	DRM_DEBUG("ip_version_minor: %u\n", le16_to_cpu(hdr->ip_version_minor));
-	DRM_DEBUG("ucode_version: 0x%08x\n", le32_to_cpu(hdr->ucode_version));
-	DRM_DEBUG("ucode_size_bytes: %u\n", le32_to_cpu(hdr->ucode_size_bytes));
-	DRM_DEBUG("ucode_array_offset_bytes: %u\n",
-		  le32_to_cpu(hdr->ucode_array_offset_bytes));
-	DRM_DEBUG("crc32: 0x%08x\n", le32_to_cpu(hdr->crc32));
+	DRM_DEBUG("size_bytes: %u\n"
+		  "header_size_bytes: %u\n"
+		  "header_version_major: %u\n"
+		  "header_version_minor: %u\n"
+		  "ip_version_major: %u\n"
+		  "ip_version_minor: %u\n"
+		  "ucode_version: 0x%08x\n"
+		  "ucode_size_bytes: %u\n"
+		  "ucode_array_offset_bytes: %u\n"
+		  "crc32: 0x%08x\n",
+		  le32_to_cpu(hdr->size_bytes),
+		  le32_to_cpu(hdr->header_size_bytes),
+		  le16_to_cpu(hdr->header_version_major),
+		  le16_to_cpu(hdr->header_version_minor),
+		  le16_to_cpu(hdr->ip_version_major),
+		  le16_to_cpu(hdr->ip_version_minor),
+		  le32_to_cpu(hdr->ucode_version),
+		  le32_to_cpu(hdr->ucode_size_bytes),
+		  le32_to_cpu(hdr->ucode_array_offset_bytes),
+		  le32_to_cpu(hdr->crc32));
 }
 
 void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr)
@@ -55,9 +64,9 @@ void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr)
 		const struct mc_firmware_header_v1_0 *mc_hdr =
 			container_of(hdr, struct mc_firmware_header_v1_0, header);
 
-		DRM_DEBUG("io_debug_size_bytes: %u\n",
-			  le32_to_cpu(mc_hdr->io_debug_size_bytes));
-		DRM_DEBUG("io_debug_array_offset_bytes: %u\n",
+		DRM_DEBUG("io_debug_size_bytes: %u\n"
+			  "io_debug_array_offset_bytes: %u\n",
+			  le32_to_cpu(mc_hdr->io_debug_size_bytes),
 			  le32_to_cpu(mc_hdr->io_debug_array_offset_bytes));
 	} else {
 		DRM_ERROR("Unknown MC ucode version: %u.%u\n", version_major, version_minor);
@@ -82,13 +91,17 @@ void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr)
 		switch (version_minor) {
 		case 0:
 			v2_0_hdr = container_of(hdr, struct smc_firmware_header_v2_0, v1_0.header);
-			DRM_DEBUG("ppt_offset_bytes: %u\n", le32_to_cpu(v2_0_hdr->ppt_offset_bytes));
-			DRM_DEBUG("ppt_size_bytes: %u\n", le32_to_cpu(v2_0_hdr->ppt_size_bytes));
+			DRM_DEBUG("ppt_offset_bytes: %u\n"
+				  "ppt_size_bytes: %u\n",
+				  le32_to_cpu(v2_0_hdr->ppt_offset_bytes),
+				  le32_to_cpu(v2_0_hdr->ppt_size_bytes));
 			break;
 		case 1:
 			v2_1_hdr = container_of(hdr, struct smc_firmware_header_v2_1, v1_0.header);
-			DRM_DEBUG("pptable_count: %u\n", le32_to_cpu(v2_1_hdr->pptable_count));
-			DRM_DEBUG("pptable_entry_offset: %u\n", le32_to_cpu(v2_1_hdr->pptable_entry_offset));
+			DRM_DEBUG("pptable_count: %u\n"
+				  "pptable_entry_offset: %u\n",
+				  le32_to_cpu(v2_1_hdr->pptable_count),
+				  le32_to_cpu(v2_1_hdr->pptable_entry_offset));
 			break;
 		default:
 			break;
@@ -111,10 +124,12 @@ void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr)
 		const struct gfx_firmware_header_v1_0 *gfx_hdr =
 			container_of(hdr, struct gfx_firmware_header_v1_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
-			  le32_to_cpu(gfx_hdr->ucode_feature_version));
-		DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(gfx_hdr->jt_offset));
-		DRM_DEBUG("jt_size: %u\n", le32_to_cpu(gfx_hdr->jt_size));
+		DRM_DEBUG("ucode_feature_version: %u\n"
+			  "jt_offset: %u\n"
+			  "jt_size: %u\n",
+			  le32_to_cpu(gfx_hdr->ucode_feature_version),
+			  le32_to_cpu(gfx_hdr->jt_offset),
+			  le32_to_cpu(gfx_hdr->jt_size));
 	} else {
 		DRM_ERROR("Unknown GFX ucode version: %u.%u\n", version_major, version_minor);
 	}
@@ -132,82 +147,88 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 		const struct rlc_firmware_header_v1_0 *rlc_hdr =
 			container_of(hdr, struct rlc_firmware_header_v1_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
-			  le32_to_cpu(rlc_hdr->ucode_feature_version));
-		DRM_DEBUG("save_and_restore_offset: %u\n",
-			  le32_to_cpu(rlc_hdr->save_and_restore_offset));
-		DRM_DEBUG("clear_state_descriptor_offset: %u\n",
-			  le32_to_cpu(rlc_hdr->clear_state_descriptor_offset));
-		DRM_DEBUG("avail_scratch_ram_locations: %u\n",
-			  le32_to_cpu(rlc_hdr->avail_scratch_ram_locations));
-		DRM_DEBUG("master_pkt_description_offset: %u\n",
+		DRM_DEBUG("ucode_feature_version: %u\n"
+			  "save_and_restore_offset: %u\n"
+			  "clear_state_descriptor_offset: %u\n"
+			  "avail_scratch_ram_locations: %u\n"
+			  "master_pkt_description_offset: %u\n",
+			  le32_to_cpu(rlc_hdr->ucode_feature_version),
+			  le32_to_cpu(rlc_hdr->save_and_restore_offset),
+			  le32_to_cpu(rlc_hdr->clear_state_descriptor_offset),
+			  le32_to_cpu(rlc_hdr->avail_scratch_ram_locations),
 			  le32_to_cpu(rlc_hdr->master_pkt_description_offset));
+
 	} else if (version_major == 2) {
 		const struct rlc_firmware_header_v2_0 *rlc_hdr =
 			container_of(hdr, struct rlc_firmware_header_v2_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
-			  le32_to_cpu(rlc_hdr->ucode_feature_version));
-		DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(rlc_hdr->jt_offset));
-		DRM_DEBUG("jt_size: %u\n", le32_to_cpu(rlc_hdr->jt_size));
-		DRM_DEBUG("save_and_restore_offset: %u\n",
-			  le32_to_cpu(rlc_hdr->save_and_restore_offset));
-		DRM_DEBUG("clear_state_descriptor_offset: %u\n",
-			  le32_to_cpu(rlc_hdr->clear_state_descriptor_offset));
-		DRM_DEBUG("avail_scratch_ram_locations: %u\n",
-			  le32_to_cpu(rlc_hdr->avail_scratch_ram_locations));
-		DRM_DEBUG("reg_restore_list_size: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_restore_list_size));
-		DRM_DEBUG("reg_list_format_start: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_start));
-		DRM_DEBUG("reg_list_format_separate_start: %u\n",
+		DRM_DEBUG("ucode_feature_version: %u\n"
+			  "jt_offset: %u\n"
+			  "jt_size: %u\n"
+			  "save_and_restore_offset: %u\n"
+			  "clear_state_descriptor_offset: %u\n"
+			  "avail_scratch_ram_locations: %u\n"
+			  "reg_restore_list_size: %u\n"
+			  "reg_list_format_start: %u\n"
+			  "reg_list_format_separate_start: %u\n",
+			  le32_to_cpu(rlc_hdr->ucode_feature_version),
+			  le32_to_cpu(rlc_hdr->jt_offset),
+			  le32_to_cpu(rlc_hdr->jt_size),
+			  le32_to_cpu(rlc_hdr->save_and_restore_offset),
+			  le32_to_cpu(rlc_hdr->clear_state_descriptor_offset),
+			  le32_to_cpu(rlc_hdr->avail_scratch_ram_locations),
+			  le32_to_cpu(rlc_hdr->reg_restore_list_size),
+			  le32_to_cpu(rlc_hdr->reg_list_format_start),
 			  le32_to_cpu(rlc_hdr->reg_list_format_separate_start));
-		DRM_DEBUG("starting_offsets_start: %u\n",
-			  le32_to_cpu(rlc_hdr->starting_offsets_start));
-		DRM_DEBUG("reg_list_format_size_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_size_bytes));
-		DRM_DEBUG("reg_list_format_array_offset_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
-		DRM_DEBUG("reg_list_size_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_size_bytes));
-		DRM_DEBUG("reg_list_array_offset_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
-		DRM_DEBUG("reg_list_format_separate_size_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_separate_size_bytes));
-		DRM_DEBUG("reg_list_format_separate_array_offset_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_separate_array_offset_bytes));
-		DRM_DEBUG("reg_list_separate_size_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_separate_size_bytes));
-		DRM_DEBUG("reg_list_separate_array_offset_bytes: %u\n",
+
+		DRM_DEBUG("starting_offsets_start: %u\n"
+			  "reg_list_format_size_bytes: %u\n"
+			  "reg_list_format_array_offset_bytes: %u\n"
+			  "reg_list_size_bytes: %u\n"
+			  "reg_list_array_offset_bytes: %u\n"
+			  "reg_list_format_separate_size_bytes: %u\n"
+			  "reg_list_format_separate_array_offset_bytes: %u\n"
+			  "reg_list_separate_size_bytes: %u\n"
+			  "reg_list_separate_array_offset_bytes: %u\n",
+			  le32_to_cpu(rlc_hdr->starting_offsets_start),
+			  le32_to_cpu(rlc_hdr->reg_list_format_size_bytes),
+			  le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes),
+			  le32_to_cpu(rlc_hdr->reg_list_size_bytes),
+			  le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes),
+			  le32_to_cpu(rlc_hdr->reg_list_format_separate_size_bytes),
+			  le32_to_cpu(rlc_hdr->reg_list_format_separate_array_offset_bytes),
+			  le32_to_cpu(rlc_hdr->reg_list_separate_size_bytes),
 			  le32_to_cpu(rlc_hdr->reg_list_separate_array_offset_bytes));
+
 		if (version_minor == 1) {
 			const struct rlc_firmware_header_v2_1 *v2_1 =
 				container_of(rlc_hdr, struct rlc_firmware_header_v2_1, v2_0);
-			DRM_DEBUG("reg_list_format_direct_reg_list_length: %u\n",
-				  le32_to_cpu(v2_1->reg_list_format_direct_reg_list_length));
-			DRM_DEBUG("save_restore_list_cntl_ucode_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_cntl_ucode_ver));
-			DRM_DEBUG("save_restore_list_cntl_feature_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_cntl_feature_ver));
-			DRM_DEBUG("save_restore_list_cntl_size_bytes %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_cntl_size_bytes));
-			DRM_DEBUG("save_restore_list_cntl_offset_bytes: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_cntl_offset_bytes));
-			DRM_DEBUG("save_restore_list_gpm_ucode_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_gpm_ucode_ver));
-			DRM_DEBUG("save_restore_list_gpm_feature_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_gpm_feature_ver));
-			DRM_DEBUG("save_restore_list_gpm_size_bytes %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_gpm_size_bytes));
-			DRM_DEBUG("save_restore_list_gpm_offset_bytes: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_gpm_offset_bytes));
-			DRM_DEBUG("save_restore_list_srm_ucode_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_srm_ucode_ver));
-			DRM_DEBUG("save_restore_list_srm_feature_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_srm_feature_ver));
-			DRM_DEBUG("save_restore_list_srm_size_bytes %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_srm_size_bytes));
-			DRM_DEBUG("save_restore_list_srm_offset_bytes: %u\n",
+
+			DRM_DEBUG("reg_list_format_direct_reg_list_length: %u\n"
+				  "save_restore_list_cntl_ucode_ver: %u\n"
+				  "save_restore_list_cntl_feature_ver: %u\n"
+				  "save_restore_list_cntl_size_bytes %u\n"
+				  "save_restore_list_cntl_offset_bytes: %u\n"
+				  "save_restore_list_gpm_ucode_ver: %u\n"
+				  "save_restore_list_gpm_feature_ver: %u\n"
+				  "save_restore_list_gpm_size_bytes %u\n"
+				  "save_restore_list_gpm_offset_bytes: %u\n"
+				  "save_restore_list_srm_ucode_ver: %u\n"
+				  "save_restore_list_srm_feature_ver: %u\n"
+				  "save_restore_list_srm_size_bytes %u\n"
+				  "save_restore_list_srm_offset_bytes: %u\n",
+				  le32_to_cpu(v2_1->reg_list_format_direct_reg_list_length),
+				  le32_to_cpu(v2_1->save_restore_list_cntl_ucode_ver),
+				  le32_to_cpu(v2_1->save_restore_list_cntl_feature_ver),
+				  le32_to_cpu(v2_1->save_restore_list_cntl_size_bytes),
+				  le32_to_cpu(v2_1->save_restore_list_cntl_offset_bytes),
+				  le32_to_cpu(v2_1->save_restore_list_gpm_ucode_ver),
+				  le32_to_cpu(v2_1->save_restore_list_gpm_feature_ver),
+				  le32_to_cpu(v2_1->save_restore_list_gpm_size_bytes),
+				  le32_to_cpu(v2_1->save_restore_list_gpm_offset_bytes),
+				  le32_to_cpu(v2_1->save_restore_list_srm_ucode_ver),
+				  le32_to_cpu(v2_1->save_restore_list_srm_feature_ver),
+				  le32_to_cpu(v2_1->save_restore_list_srm_size_bytes),
 				  le32_to_cpu(v2_1->save_restore_list_srm_offset_bytes));
 		}
 	} else {
@@ -227,12 +248,14 @@ void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr)
 		const struct sdma_firmware_header_v1_0 *sdma_hdr =
 			container_of(hdr, struct sdma_firmware_header_v1_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
-			  le32_to_cpu(sdma_hdr->ucode_feature_version));
-		DRM_DEBUG("ucode_change_version: %u\n",
-			  le32_to_cpu(sdma_hdr->ucode_change_version));
-		DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(sdma_hdr->jt_offset));
-		DRM_DEBUG("jt_size: %u\n", le32_to_cpu(sdma_hdr->jt_size));
+		DRM_DEBUG("ucode_feature_version: %u\n"
+			  "ucode_change_version: %u\n"
+			  "jt_offset: %u\n"
+			  "jt_size: %u\n",
+			  le32_to_cpu(sdma_hdr->ucode_feature_version),
+			  le32_to_cpu(sdma_hdr->ucode_change_version),
+			  le32_to_cpu(sdma_hdr->jt_offset),
+			  le32_to_cpu(sdma_hdr->jt_size));
 		if (version_minor >= 1) {
 			const struct sdma_firmware_header_v1_1 *sdma_v1_1_hdr =
 				container_of(sdma_hdr, struct sdma_firmware_header_v1_1, v1_0);
@@ -256,36 +279,36 @@ void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr)
 		const struct psp_firmware_header_v1_0 *psp_hdr =
 			container_of(hdr, struct psp_firmware_header_v1_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
-			  le32_to_cpu(psp_hdr->sos.fw_version));
-		DRM_DEBUG("sos_offset_bytes: %u\n",
-			  le32_to_cpu(psp_hdr->sos.offset_bytes));
-		DRM_DEBUG("sos_size_bytes: %u\n",
+		DRM_DEBUG("ucode_feature_version: %u\n"
+			  "sos_offset_bytes: %u\n"
+			  "sos_size_bytes: %u\n",
+			  le32_to_cpu(psp_hdr->sos.fw_version),
+			  le32_to_cpu(psp_hdr->sos.offset_bytes),
 			  le32_to_cpu(psp_hdr->sos.size_bytes));
 		if (version_minor == 1) {
 			const struct psp_firmware_header_v1_1 *psp_hdr_v1_1 =
 				container_of(psp_hdr, struct psp_firmware_header_v1_1, v1_0);
-			DRM_DEBUG("toc_header_version: %u\n",
-				  le32_to_cpu(psp_hdr_v1_1->toc.fw_version));
-			DRM_DEBUG("toc_offset_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_1->toc.offset_bytes));
-			DRM_DEBUG("toc_size_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_1->toc.size_bytes));
-			DRM_DEBUG("kdb_header_version: %u\n",
-				  le32_to_cpu(psp_hdr_v1_1->kdb.fw_version));
-			DRM_DEBUG("kdb_offset_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_1->kdb.offset_bytes));
-			DRM_DEBUG("kdb_size_bytes: %u\n",
+			DRM_DEBUG("toc_header_version: %u\n"
+				  "toc_offset_bytes: %u\n"
+				  "toc_size_bytes: %u\n"
+				  "kdb_header_version: %u\n"
+				  "kdb_offset_bytes: %u\n"
+				  "kdb_size_bytes: %u\n",
+				  le32_to_cpu(psp_hdr_v1_1->toc.fw_version),
+				  le32_to_cpu(psp_hdr_v1_1->toc.offset_bytes),
+				  le32_to_cpu(psp_hdr_v1_1->toc.size_bytes),
+				  le32_to_cpu(psp_hdr_v1_1->kdb.fw_version),
+				  le32_to_cpu(psp_hdr_v1_1->kdb.offset_bytes),
 				  le32_to_cpu(psp_hdr_v1_1->kdb.size_bytes));
 		}
 		if (version_minor == 2) {
 			const struct psp_firmware_header_v1_2 *psp_hdr_v1_2 =
 				container_of(psp_hdr, struct psp_firmware_header_v1_2, v1_0);
-			DRM_DEBUG("kdb_header_version: %u\n",
-				  le32_to_cpu(psp_hdr_v1_2->kdb.fw_version));
-			DRM_DEBUG("kdb_offset_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_2->kdb.offset_bytes));
-			DRM_DEBUG("kdb_size_bytes: %u\n",
+			DRM_DEBUG("kdb_header_version: %u\n"
+				  "kdb_offset_bytes: %u\n"
+				  "kdb_size_bytes: %u\n",
+				  le32_to_cpu(psp_hdr_v1_2->kdb.fw_version),
+				  le32_to_cpu(psp_hdr_v1_2->kdb.offset_bytes),
 				  le32_to_cpu(psp_hdr_v1_2->kdb.size_bytes));
 		}
 		if (version_minor == 3) {
@@ -293,23 +316,23 @@ void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr)
 				container_of(psp_hdr, struct psp_firmware_header_v1_1, v1_0);
 			const struct psp_firmware_header_v1_3 *psp_hdr_v1_3 =
 				container_of(psp_hdr_v1_1, struct psp_firmware_header_v1_3, v1_1);
-			DRM_DEBUG("toc_header_version: %u\n",
-				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.fw_version));
-			DRM_DEBUG("toc_offset_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.offset_bytes));
-			DRM_DEBUG("toc_size_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.size_bytes));
-			DRM_DEBUG("kdb_header_version: %u\n",
-				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.fw_version));
-			DRM_DEBUG("kdb_offset_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.offset_bytes));
-			DRM_DEBUG("kdb_size_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.size_bytes));
-			DRM_DEBUG("spl_header_version: %u\n",
-				  le32_to_cpu(psp_hdr_v1_3->spl.fw_version));
-			DRM_DEBUG("spl_offset_bytes: %u\n",
-				  le32_to_cpu(psp_hdr_v1_3->spl.offset_bytes));
-			DRM_DEBUG("spl_size_bytes: %u\n",
+			DRM_DEBUG("toc_header_version: %u\n"
+				  "toc_offset_bytes: %u\n"
+				  "toc_size_bytes: %u\n"
+				  "kdb_header_version: %u\n"
+				  "kdb_offset_bytes: %u\n"
+				  "kdb_size_bytes: %u\n"
+				  "spl_header_version: %u\n"
+				  "spl_offset_bytes: %u\n"
+				  "spl_size_bytes: %u\n",
+				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.fw_version),
+				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.offset_bytes),
+				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.size_bytes),
+				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.fw_version),
+				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.offset_bytes),
+				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.size_bytes),
+				  le32_to_cpu(psp_hdr_v1_3->spl.fw_version),
+				  le32_to_cpu(psp_hdr_v1_3->spl.offset_bytes),
 				  le32_to_cpu(psp_hdr_v1_3->spl.size_bytes));
 		}
 	} else {
@@ -330,9 +353,9 @@ void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr)
 		const struct gpu_info_firmware_header_v1_0 *gpu_info_hdr =
 			container_of(hdr, struct gpu_info_firmware_header_v1_0, header);
 
-		DRM_DEBUG("version_major: %u\n",
-			  le16_to_cpu(gpu_info_hdr->version_major));
-		DRM_DEBUG("version_minor: %u\n",
+		DRM_DEBUG("version_major: %u\n"
+			  "version_minor: %u\n",
+			  le16_to_cpu(gpu_info_hdr->version_major),
 			  le16_to_cpu(gpu_info_hdr->version_minor));
 	} else {
 		DRM_ERROR("Unknown gpu_info ucode version: %u.%u\n", version_major, version_minor);
-- 
2.31.1

