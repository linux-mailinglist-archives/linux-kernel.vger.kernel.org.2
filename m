Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7D32BE63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385653AbhCCRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359152AbhCCNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDD2C061223
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a18so15531016wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AJAppzBH/POa0q/AoG/7N37bnuqBzuHZqtW8TtPzFs=;
        b=RECUpYls0GDGdiRxdJXQ7K3xbf7r5BbWp6b2iHMwQQovUW+jx9jVB6WvZjmq0D+A1K
         aoPgXGH3ekd2uakq+SVcZ1FxgI2/2YTwPUW5kmT7+0B3tj9vWChB3h6klOyX1ghnjTJe
         wIjSunvPdEabWbgRcE5eTUAz+Yc9GZmusfhMKCS15X/BRJcamnQoB7ZgTyZt/CGEjxJF
         xyPOrTZlc9U9s+3zS2hx2Qdw7gpy9PviI1zXFn4ANPjnl163zlyVln/5/CdXCxRuCF9d
         Hm7R8eOZtQqUhVMr1qAg8I0pewTiScdbq7whaHZMuPRBLe1jhcJBNiIztCsrxkOVCI0n
         h5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AJAppzBH/POa0q/AoG/7N37bnuqBzuHZqtW8TtPzFs=;
        b=thr7027uPHO2FBTqz+NYgg2lo5hVLi2T/AsRrmpwoZ3grvpSU4Uiyner6yVCzKvD6X
         xuDa6DuCvZy33VwgmaZcH8ll7HO1SaaID2CdZ6Dr5r4QCktOgTVS4CbzN6bebsBdEu/w
         qvNUWddcBH4W71V//Z85iZGE9HTvh0WXJ9zgMawLXjPPqNs7AMwCx0/JdpfKKx02u9OT
         cNpVdlS5GYLwKUw7TOt2kPqoECq15F/2PTm2o+Sm+rIfU737c41JcqHcFcq2kss1Dt3Q
         VvwWCrvBpqJDmXspk0y0rMr1bWRnKW9gB4Hpj9cqnV5jYh24E/dAK/QaTiy+65TXoW8Z
         pEyw==
X-Gm-Message-State: AOAM530Usf4PPiVhqr96c1BeFxKDbminFoTF48UenX9ljNeunzsvFwam
        oLxzcMnHExjvk/iSv4zbIxxHOQ==
X-Google-Smtp-Source: ABdhPJwaROS/zgXm10yljwkt7cwj2o+Vxhlvcw9Q5dZdRN276Z1ZtlZnetyphPPXytgJQ8lG8tOOqA==
X-Received: by 2002:a5d:528f:: with SMTP id c15mr27391407wrv.142.1614779019564;
        Wed, 03 Mar 2021 05:43:39 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:38 -0800 (PST)
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
Subject: [PATCH 09/53] drm/amd/display/dc/calcs/dce_calcs: Remove some large variables from the stack
Date:   Wed,  3 Mar 2021 13:42:35 +0000
Message-Id: <20210303134319.3160762-10-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘bw_calcs_init’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2726:1: warning: the frame size of 1336 bytes is larger than 1024 bytes [-Wframe-larger-than=]

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
 .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 1122 +++++++++--------
 1 file changed, 567 insertions(+), 555 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 4f0474a3bbcad..53f5c170d9c97 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2043,707 +2043,719 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
 	struct bw_calcs_vbios *bw_vbios,
 	struct hw_asic_id asic_id)
 {
-	struct bw_calcs_dceip dceip = { 0 };
-	struct bw_calcs_vbios vbios = { 0 };
+	struct bw_calcs_dceip *dceip;
+	struct bw_calcs_vbios *vbios;
 
 	enum bw_calcs_version version = bw_calcs_version_from_asic_id(asic_id);
 
-	dceip.version = version;
+	dceip = kzalloc(sizeof(dceip), GFP_KERNEL);
+	if (!dceip)
+		return;
+
+	vbios = kzalloc(sizeof(vbios), GFP_KERNEL);
+	if (!vbios) {
+		kfree(dceip);
+		return;
+	}
+
+	dceip->version = version;
 
 	switch (version) {
 	case BW_CALCS_VERSION_CARRIZO:
-		vbios.memory_type = bw_def_gddr5;
-		vbios.dram_channel_width_in_bits = 64;
-		vbios.number_of_dram_channels = asic_id.vram_width / vbios.dram_channel_width_in_bits;
-		vbios.number_of_dram_banks = 8;
-		vbios.high_yclk = bw_int_to_fixed(1600);
-		vbios.mid_yclk = bw_int_to_fixed(1600);
-		vbios.low_yclk = bw_frc_to_fixed(66666, 100);
-		vbios.low_sclk = bw_int_to_fixed(200);
-		vbios.mid1_sclk = bw_int_to_fixed(300);
-		vbios.mid2_sclk = bw_int_to_fixed(300);
-		vbios.mid3_sclk = bw_int_to_fixed(300);
-		vbios.mid4_sclk = bw_int_to_fixed(300);
-		vbios.mid5_sclk = bw_int_to_fixed(300);
-		vbios.mid6_sclk = bw_int_to_fixed(300);
-		vbios.high_sclk = bw_frc_to_fixed(62609, 100);
-		vbios.low_voltage_max_dispclk = bw_int_to_fixed(352);
-		vbios.mid_voltage_max_dispclk = bw_int_to_fixed(467);
-		vbios.high_voltage_max_dispclk = bw_int_to_fixed(643);
-		vbios.low_voltage_max_phyclk = bw_int_to_fixed(540);
-		vbios.mid_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.high_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.data_return_bus_width = bw_int_to_fixed(32);
-		vbios.trc = bw_int_to_fixed(50);
-		vbios.dmifmc_urgent_latency = bw_int_to_fixed(4);
-		vbios.stutter_self_refresh_exit_latency = bw_frc_to_fixed(153, 10);
-		vbios.stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
-		vbios.nbp_state_change_latency = bw_frc_to_fixed(19649, 1000);
-		vbios.mcifwrmc_urgent_latency = bw_int_to_fixed(10);
-		vbios.scatter_gather_enable = true;
-		vbios.down_spread_percentage = bw_frc_to_fixed(5, 10);
-		vbios.cursor_width = 32;
-		vbios.average_compression_rate = 4;
-		vbios.number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
-		vbios.blackout_duration = bw_int_to_fixed(0); /* us */
-		vbios.maximum_blackout_recovery_time = bw_int_to_fixed(0);
-
-		dceip.max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
-		dceip.max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
-		dceip.percent_of_ideal_port_bw_received_after_urgent_latency = 100;
-		dceip.large_cursor = false;
-		dceip.dmif_request_buffer_size = bw_int_to_fixed(768);
-		dceip.dmif_pipe_en_fbc_chunk_tracker = false;
-		dceip.cursor_max_outstanding_group_num = 1;
-		dceip.lines_interleaved_into_lb = 2;
-		dceip.chunk_width = 256;
-		dceip.number_of_graphics_pipes = 3;
-		dceip.number_of_underlay_pipes = 1;
-		dceip.low_power_tiling_mode = 0;
-		dceip.display_write_back_supported = false;
-		dceip.argb_compression_support = false;
-		dceip.underlay_vscaler_efficiency6_bit_per_component =
+		vbios->memory_type = bw_def_gddr5;
+		vbios->dram_channel_width_in_bits = 64;
+		vbios->number_of_dram_channels = asic_id.vram_width / vbios->dram_channel_width_in_bits;
+		vbios->number_of_dram_banks = 8;
+		vbios->high_yclk = bw_int_to_fixed(1600);
+		vbios->mid_yclk = bw_int_to_fixed(1600);
+		vbios->low_yclk = bw_frc_to_fixed(66666, 100);
+		vbios->low_sclk = bw_int_to_fixed(200);
+		vbios->mid1_sclk = bw_int_to_fixed(300);
+		vbios->mid2_sclk = bw_int_to_fixed(300);
+		vbios->mid3_sclk = bw_int_to_fixed(300);
+		vbios->mid4_sclk = bw_int_to_fixed(300);
+		vbios->mid5_sclk = bw_int_to_fixed(300);
+		vbios->mid6_sclk = bw_int_to_fixed(300);
+		vbios->high_sclk = bw_frc_to_fixed(62609, 100);
+		vbios->low_voltage_max_dispclk = bw_int_to_fixed(352);
+		vbios->mid_voltage_max_dispclk = bw_int_to_fixed(467);
+		vbios->high_voltage_max_dispclk = bw_int_to_fixed(643);
+		vbios->low_voltage_max_phyclk = bw_int_to_fixed(540);
+		vbios->mid_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->high_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->data_return_bus_width = bw_int_to_fixed(32);
+		vbios->trc = bw_int_to_fixed(50);
+		vbios->dmifmc_urgent_latency = bw_int_to_fixed(4);
+		vbios->stutter_self_refresh_exit_latency = bw_frc_to_fixed(153, 10);
+		vbios->stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
+		vbios->nbp_state_change_latency = bw_frc_to_fixed(19649, 1000);
+		vbios->mcifwrmc_urgent_latency = bw_int_to_fixed(10);
+		vbios->scatter_gather_enable = true;
+		vbios->down_spread_percentage = bw_frc_to_fixed(5, 10);
+		vbios->cursor_width = 32;
+		vbios->average_compression_rate = 4;
+		vbios->number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
+		vbios->blackout_duration = bw_int_to_fixed(0); /* us */
+		vbios->maximum_blackout_recovery_time = bw_int_to_fixed(0);
+
+		dceip->max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
+		dceip->max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
+		dceip->percent_of_ideal_port_bw_received_after_urgent_latency = 100;
+		dceip->large_cursor = false;
+		dceip->dmif_request_buffer_size = bw_int_to_fixed(768);
+		dceip->dmif_pipe_en_fbc_chunk_tracker = false;
+		dceip->cursor_max_outstanding_group_num = 1;
+		dceip->lines_interleaved_into_lb = 2;
+		dceip->chunk_width = 256;
+		dceip->number_of_graphics_pipes = 3;
+		dceip->number_of_underlay_pipes = 1;
+		dceip->low_power_tiling_mode = 0;
+		dceip->display_write_back_supported = false;
+		dceip->argb_compression_support = false;
+		dceip->underlay_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35556, 10000);
-		dceip.underlay_vscaler_efficiency8_bit_per_component =
+		dceip->underlay_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.underlay_vscaler_efficiency10_bit_per_component =
+		dceip->underlay_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.underlay_vscaler_efficiency12_bit_per_component =
+		dceip->underlay_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.graphics_vscaler_efficiency6_bit_per_component =
+		dceip->graphics_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35, 10);
-		dceip.graphics_vscaler_efficiency8_bit_per_component =
+		dceip->graphics_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.graphics_vscaler_efficiency10_bit_per_component =
+		dceip->graphics_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.graphics_vscaler_efficiency12_bit_per_component =
+		dceip->graphics_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.alpha_vscaler_efficiency = bw_int_to_fixed(3);
-		dceip.max_dmif_buffer_allocated = 2;
-		dceip.graphics_dmif_size = 12288;
-		dceip.underlay_luma_dmif_size = 19456;
-		dceip.underlay_chroma_dmif_size = 23552;
-		dceip.pre_downscaler_enabled = true;
-		dceip.underlay_downscale_prefetch_enabled = true;
-		dceip.lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
-		dceip.lb_size_per_component444 = bw_int_to_fixed(82176);
-		dceip.graphics_lb_nodownscaling_multi_line_prefetching = false;
-		dceip.stutter_and_dram_clock_state_change_gated_before_cursor =
+		dceip->alpha_vscaler_efficiency = bw_int_to_fixed(3);
+		dceip->max_dmif_buffer_allocated = 2;
+		dceip->graphics_dmif_size = 12288;
+		dceip->underlay_luma_dmif_size = 19456;
+		dceip->underlay_chroma_dmif_size = 23552;
+		dceip->pre_downscaler_enabled = true;
+		dceip->underlay_downscale_prefetch_enabled = true;
+		dceip->lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
+		dceip->lb_size_per_component444 = bw_int_to_fixed(82176);
+		dceip->graphics_lb_nodownscaling_multi_line_prefetching = false;
+		dceip->stutter_and_dram_clock_state_change_gated_before_cursor =
 			bw_int_to_fixed(0);
-		dceip.underlay420_luma_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay420_luma_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.underlay420_chroma_lb_size_per_component =
+		dceip->underlay420_chroma_lb_size_per_component =
 			bw_int_to_fixed(164352);
-		dceip.underlay422_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay422_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.cursor_chunk_width = bw_int_to_fixed(64);
-		dceip.cursor_dcp_buffer_lines = bw_int_to_fixed(4);
-		dceip.underlay_maximum_width_efficient_for_tiling =
+		dceip->cursor_chunk_width = bw_int_to_fixed(64);
+		dceip->cursor_dcp_buffer_lines = bw_int_to_fixed(4);
+		dceip->underlay_maximum_width_efficient_for_tiling =
 			bw_int_to_fixed(1920);
-		dceip.underlay_maximum_height_efficient_for_tiling =
+		dceip->underlay_maximum_height_efficient_for_tiling =
 			bw_int_to_fixed(1080);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
 			bw_frc_to_fixed(3, 10);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
 			bw_int_to_fixed(25);
-		dceip.minimum_outstanding_pte_request_limit = bw_int_to_fixed(
+		dceip->minimum_outstanding_pte_request_limit = bw_int_to_fixed(
 			2);
-		dceip.maximum_total_outstanding_pte_requests_allowed_by_saw =
+		dceip->maximum_total_outstanding_pte_requests_allowed_by_saw =
 			bw_int_to_fixed(128);
-		dceip.limit_excessive_outstanding_dmif_requests = true;
-		dceip.linear_mode_line_request_alternation_slice =
+		dceip->limit_excessive_outstanding_dmif_requests = true;
+		dceip->linear_mode_line_request_alternation_slice =
 			bw_int_to_fixed(64);
-		dceip.scatter_gather_lines_of_pte_prefetching_in_linear_mode =
+		dceip->scatter_gather_lines_of_pte_prefetching_in_linear_mode =
 			32;
-		dceip.display_write_back420_luma_mcifwr_buffer_size = 12288;
-		dceip.display_write_back420_chroma_mcifwr_buffer_size = 8192;
-		dceip.request_efficiency = bw_frc_to_fixed(8, 10);
-		dceip.dispclk_per_request = bw_int_to_fixed(2);
-		dceip.dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
-		dceip.display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
-		dceip.scatter_gather_pte_request_rows_in_tiling_mode = 2;
-		dceip.mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0); /* todo: this is a bug*/
+		dceip->display_write_back420_luma_mcifwr_buffer_size = 12288;
+		dceip->display_write_back420_chroma_mcifwr_buffer_size = 8192;
+		dceip->request_efficiency = bw_frc_to_fixed(8, 10);
+		dceip->dispclk_per_request = bw_int_to_fixed(2);
+		dceip->dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
+		dceip->display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
+		dceip->scatter_gather_pte_request_rows_in_tiling_mode = 2;
+		dceip->mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0); /* todo: this is a bug*/
 		break;
 	case BW_CALCS_VERSION_POLARIS10:
 		/* TODO: Treat VEGAM the same as P10 for now
 		 * Need to tune the para for VEGAM if needed */
 	case BW_CALCS_VERSION_VEGAM:
-		vbios.memory_type = bw_def_gddr5;
-		vbios.dram_channel_width_in_bits = 32;
-		vbios.number_of_dram_channels = asic_id.vram_width / vbios.dram_channel_width_in_bits;
-		vbios.number_of_dram_banks = 8;
-		vbios.high_yclk = bw_int_to_fixed(6000);
-		vbios.mid_yclk = bw_int_to_fixed(3200);
-		vbios.low_yclk = bw_int_to_fixed(1000);
-		vbios.low_sclk = bw_int_to_fixed(300);
-		vbios.mid1_sclk = bw_int_to_fixed(400);
-		vbios.mid2_sclk = bw_int_to_fixed(500);
-		vbios.mid3_sclk = bw_int_to_fixed(600);
-		vbios.mid4_sclk = bw_int_to_fixed(700);
-		vbios.mid5_sclk = bw_int_to_fixed(800);
-		vbios.mid6_sclk = bw_int_to_fixed(974);
-		vbios.high_sclk = bw_int_to_fixed(1154);
-		vbios.low_voltage_max_dispclk = bw_int_to_fixed(459);
-		vbios.mid_voltage_max_dispclk = bw_int_to_fixed(654);
-		vbios.high_voltage_max_dispclk = bw_int_to_fixed(1108);
-		vbios.low_voltage_max_phyclk = bw_int_to_fixed(540);
-		vbios.mid_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.high_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.data_return_bus_width = bw_int_to_fixed(32);
-		vbios.trc = bw_int_to_fixed(48);
-		vbios.dmifmc_urgent_latency = bw_int_to_fixed(3);
-		vbios.stutter_self_refresh_exit_latency = bw_int_to_fixed(5);
-		vbios.stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
-		vbios.nbp_state_change_latency = bw_int_to_fixed(45);
-		vbios.mcifwrmc_urgent_latency = bw_int_to_fixed(10);
-		vbios.scatter_gather_enable = true;
-		vbios.down_spread_percentage = bw_frc_to_fixed(5, 10);
-		vbios.cursor_width = 32;
-		vbios.average_compression_rate = 4;
-		vbios.number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
-		vbios.blackout_duration = bw_int_to_fixed(0); /* us */
-		vbios.maximum_blackout_recovery_time = bw_int_to_fixed(0);
-
-		dceip.max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
-		dceip.max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
-		dceip.percent_of_ideal_port_bw_received_after_urgent_latency = 100;
-		dceip.large_cursor = false;
-		dceip.dmif_request_buffer_size = bw_int_to_fixed(768);
-		dceip.dmif_pipe_en_fbc_chunk_tracker = false;
-		dceip.cursor_max_outstanding_group_num = 1;
-		dceip.lines_interleaved_into_lb = 2;
-		dceip.chunk_width = 256;
-		dceip.number_of_graphics_pipes = 6;
-		dceip.number_of_underlay_pipes = 0;
-		dceip.low_power_tiling_mode = 0;
-		dceip.display_write_back_supported = false;
-		dceip.argb_compression_support = true;
-		dceip.underlay_vscaler_efficiency6_bit_per_component =
+		vbios->memory_type = bw_def_gddr5;
+		vbios->dram_channel_width_in_bits = 32;
+		vbios->number_of_dram_channels = asic_id.vram_width / vbios->dram_channel_width_in_bits;
+		vbios->number_of_dram_banks = 8;
+		vbios->high_yclk = bw_int_to_fixed(6000);
+		vbios->mid_yclk = bw_int_to_fixed(3200);
+		vbios->low_yclk = bw_int_to_fixed(1000);
+		vbios->low_sclk = bw_int_to_fixed(300);
+		vbios->mid1_sclk = bw_int_to_fixed(400);
+		vbios->mid2_sclk = bw_int_to_fixed(500);
+		vbios->mid3_sclk = bw_int_to_fixed(600);
+		vbios->mid4_sclk = bw_int_to_fixed(700);
+		vbios->mid5_sclk = bw_int_to_fixed(800);
+		vbios->mid6_sclk = bw_int_to_fixed(974);
+		vbios->high_sclk = bw_int_to_fixed(1154);
+		vbios->low_voltage_max_dispclk = bw_int_to_fixed(459);
+		vbios->mid_voltage_max_dispclk = bw_int_to_fixed(654);
+		vbios->high_voltage_max_dispclk = bw_int_to_fixed(1108);
+		vbios->low_voltage_max_phyclk = bw_int_to_fixed(540);
+		vbios->mid_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->high_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->data_return_bus_width = bw_int_to_fixed(32);
+		vbios->trc = bw_int_to_fixed(48);
+		vbios->dmifmc_urgent_latency = bw_int_to_fixed(3);
+		vbios->stutter_self_refresh_exit_latency = bw_int_to_fixed(5);
+		vbios->stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
+		vbios->nbp_state_change_latency = bw_int_to_fixed(45);
+		vbios->mcifwrmc_urgent_latency = bw_int_to_fixed(10);
+		vbios->scatter_gather_enable = true;
+		vbios->down_spread_percentage = bw_frc_to_fixed(5, 10);
+		vbios->cursor_width = 32;
+		vbios->average_compression_rate = 4;
+		vbios->number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
+		vbios->blackout_duration = bw_int_to_fixed(0); /* us */
+		vbios->maximum_blackout_recovery_time = bw_int_to_fixed(0);
+
+		dceip->max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
+		dceip->max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
+		dceip->percent_of_ideal_port_bw_received_after_urgent_latency = 100;
+		dceip->large_cursor = false;
+		dceip->dmif_request_buffer_size = bw_int_to_fixed(768);
+		dceip->dmif_pipe_en_fbc_chunk_tracker = false;
+		dceip->cursor_max_outstanding_group_num = 1;
+		dceip->lines_interleaved_into_lb = 2;
+		dceip->chunk_width = 256;
+		dceip->number_of_graphics_pipes = 6;
+		dceip->number_of_underlay_pipes = 0;
+		dceip->low_power_tiling_mode = 0;
+		dceip->display_write_back_supported = false;
+		dceip->argb_compression_support = true;
+		dceip->underlay_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35556, 10000);
-		dceip.underlay_vscaler_efficiency8_bit_per_component =
+		dceip->underlay_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.underlay_vscaler_efficiency10_bit_per_component =
+		dceip->underlay_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.underlay_vscaler_efficiency12_bit_per_component =
+		dceip->underlay_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.graphics_vscaler_efficiency6_bit_per_component =
+		dceip->graphics_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35, 10);
-		dceip.graphics_vscaler_efficiency8_bit_per_component =
+		dceip->graphics_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.graphics_vscaler_efficiency10_bit_per_component =
+		dceip->graphics_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.graphics_vscaler_efficiency12_bit_per_component =
+		dceip->graphics_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.alpha_vscaler_efficiency = bw_int_to_fixed(3);
-		dceip.max_dmif_buffer_allocated = 4;
-		dceip.graphics_dmif_size = 12288;
-		dceip.underlay_luma_dmif_size = 19456;
-		dceip.underlay_chroma_dmif_size = 23552;
-		dceip.pre_downscaler_enabled = true;
-		dceip.underlay_downscale_prefetch_enabled = true;
-		dceip.lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
-		dceip.lb_size_per_component444 = bw_int_to_fixed(245952);
-		dceip.graphics_lb_nodownscaling_multi_line_prefetching = true;
-		dceip.stutter_and_dram_clock_state_change_gated_before_cursor =
+		dceip->alpha_vscaler_efficiency = bw_int_to_fixed(3);
+		dceip->max_dmif_buffer_allocated = 4;
+		dceip->graphics_dmif_size = 12288;
+		dceip->underlay_luma_dmif_size = 19456;
+		dceip->underlay_chroma_dmif_size = 23552;
+		dceip->pre_downscaler_enabled = true;
+		dceip->underlay_downscale_prefetch_enabled = true;
+		dceip->lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
+		dceip->lb_size_per_component444 = bw_int_to_fixed(245952);
+		dceip->graphics_lb_nodownscaling_multi_line_prefetching = true;
+		dceip->stutter_and_dram_clock_state_change_gated_before_cursor =
 			bw_int_to_fixed(1);
-		dceip.underlay420_luma_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay420_luma_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.underlay420_chroma_lb_size_per_component =
+		dceip->underlay420_chroma_lb_size_per_component =
 			bw_int_to_fixed(164352);
-		dceip.underlay422_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay422_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.cursor_chunk_width = bw_int_to_fixed(64);
-		dceip.cursor_dcp_buffer_lines = bw_int_to_fixed(4);
-		dceip.underlay_maximum_width_efficient_for_tiling =
+		dceip->cursor_chunk_width = bw_int_to_fixed(64);
+		dceip->cursor_dcp_buffer_lines = bw_int_to_fixed(4);
+		dceip->underlay_maximum_width_efficient_for_tiling =
 			bw_int_to_fixed(1920);
-		dceip.underlay_maximum_height_efficient_for_tiling =
+		dceip->underlay_maximum_height_efficient_for_tiling =
 			bw_int_to_fixed(1080);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
 			bw_frc_to_fixed(3, 10);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
 			bw_int_to_fixed(25);
-		dceip.minimum_outstanding_pte_request_limit = bw_int_to_fixed(
+		dceip->minimum_outstanding_pte_request_limit = bw_int_to_fixed(
 			2);
-		dceip.maximum_total_outstanding_pte_requests_allowed_by_saw =
+		dceip->maximum_total_outstanding_pte_requests_allowed_by_saw =
 			bw_int_to_fixed(128);
-		dceip.limit_excessive_outstanding_dmif_requests = true;
-		dceip.linear_mode_line_request_alternation_slice =
+		dceip->limit_excessive_outstanding_dmif_requests = true;
+		dceip->linear_mode_line_request_alternation_slice =
 			bw_int_to_fixed(64);
-		dceip.scatter_gather_lines_of_pte_prefetching_in_linear_mode =
+		dceip->scatter_gather_lines_of_pte_prefetching_in_linear_mode =
 			32;
-		dceip.display_write_back420_luma_mcifwr_buffer_size = 12288;
-		dceip.display_write_back420_chroma_mcifwr_buffer_size = 8192;
-		dceip.request_efficiency = bw_frc_to_fixed(8, 10);
-		dceip.dispclk_per_request = bw_int_to_fixed(2);
-		dceip.dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
-		dceip.display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
-		dceip.scatter_gather_pte_request_rows_in_tiling_mode = 2;
-		dceip.mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
+		dceip->display_write_back420_luma_mcifwr_buffer_size = 12288;
+		dceip->display_write_back420_chroma_mcifwr_buffer_size = 8192;
+		dceip->request_efficiency = bw_frc_to_fixed(8, 10);
+		dceip->dispclk_per_request = bw_int_to_fixed(2);
+		dceip->dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
+		dceip->display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
+		dceip->scatter_gather_pte_request_rows_in_tiling_mode = 2;
+		dceip->mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
 		break;
 	case BW_CALCS_VERSION_POLARIS11:
-		vbios.memory_type = bw_def_gddr5;
-		vbios.dram_channel_width_in_bits = 32;
-		vbios.number_of_dram_channels = asic_id.vram_width / vbios.dram_channel_width_in_bits;
-		vbios.number_of_dram_banks = 8;
-		vbios.high_yclk = bw_int_to_fixed(6000);
-		vbios.mid_yclk = bw_int_to_fixed(3200);
-		vbios.low_yclk = bw_int_to_fixed(1000);
-		vbios.low_sclk = bw_int_to_fixed(300);
-		vbios.mid1_sclk = bw_int_to_fixed(400);
-		vbios.mid2_sclk = bw_int_to_fixed(500);
-		vbios.mid3_sclk = bw_int_to_fixed(600);
-		vbios.mid4_sclk = bw_int_to_fixed(700);
-		vbios.mid5_sclk = bw_int_to_fixed(800);
-		vbios.mid6_sclk = bw_int_to_fixed(974);
-		vbios.high_sclk = bw_int_to_fixed(1154);
-		vbios.low_voltage_max_dispclk = bw_int_to_fixed(459);
-		vbios.mid_voltage_max_dispclk = bw_int_to_fixed(654);
-		vbios.high_voltage_max_dispclk = bw_int_to_fixed(1108);
-		vbios.low_voltage_max_phyclk = bw_int_to_fixed(540);
-		vbios.mid_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.high_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.data_return_bus_width = bw_int_to_fixed(32);
-		vbios.trc = bw_int_to_fixed(48);
-		if (vbios.number_of_dram_channels == 2) // 64-bit
-			vbios.dmifmc_urgent_latency = bw_int_to_fixed(4);
+		vbios->memory_type = bw_def_gddr5;
+		vbios->dram_channel_width_in_bits = 32;
+		vbios->number_of_dram_channels = asic_id.vram_width / vbios->dram_channel_width_in_bits;
+		vbios->number_of_dram_banks = 8;
+		vbios->high_yclk = bw_int_to_fixed(6000);
+		vbios->mid_yclk = bw_int_to_fixed(3200);
+		vbios->low_yclk = bw_int_to_fixed(1000);
+		vbios->low_sclk = bw_int_to_fixed(300);
+		vbios->mid1_sclk = bw_int_to_fixed(400);
+		vbios->mid2_sclk = bw_int_to_fixed(500);
+		vbios->mid3_sclk = bw_int_to_fixed(600);
+		vbios->mid4_sclk = bw_int_to_fixed(700);
+		vbios->mid5_sclk = bw_int_to_fixed(800);
+		vbios->mid6_sclk = bw_int_to_fixed(974);
+		vbios->high_sclk = bw_int_to_fixed(1154);
+		vbios->low_voltage_max_dispclk = bw_int_to_fixed(459);
+		vbios->mid_voltage_max_dispclk = bw_int_to_fixed(654);
+		vbios->high_voltage_max_dispclk = bw_int_to_fixed(1108);
+		vbios->low_voltage_max_phyclk = bw_int_to_fixed(540);
+		vbios->mid_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->high_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->data_return_bus_width = bw_int_to_fixed(32);
+		vbios->trc = bw_int_to_fixed(48);
+		if (vbios->number_of_dram_channels == 2) // 64-bit
+			vbios->dmifmc_urgent_latency = bw_int_to_fixed(4);
 		else
-			vbios.dmifmc_urgent_latency = bw_int_to_fixed(3);
-		vbios.stutter_self_refresh_exit_latency = bw_int_to_fixed(5);
-		vbios.stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
-		vbios.nbp_state_change_latency = bw_int_to_fixed(45);
-		vbios.mcifwrmc_urgent_latency = bw_int_to_fixed(10);
-		vbios.scatter_gather_enable = true;
-		vbios.down_spread_percentage = bw_frc_to_fixed(5, 10);
-		vbios.cursor_width = 32;
-		vbios.average_compression_rate = 4;
-		vbios.number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
-		vbios.blackout_duration = bw_int_to_fixed(0); /* us */
-		vbios.maximum_blackout_recovery_time = bw_int_to_fixed(0);
-
-		dceip.max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
-		dceip.max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
-		dceip.percent_of_ideal_port_bw_received_after_urgent_latency = 100;
-		dceip.large_cursor = false;
-		dceip.dmif_request_buffer_size = bw_int_to_fixed(768);
-		dceip.dmif_pipe_en_fbc_chunk_tracker = false;
-		dceip.cursor_max_outstanding_group_num = 1;
-		dceip.lines_interleaved_into_lb = 2;
-		dceip.chunk_width = 256;
-		dceip.number_of_graphics_pipes = 5;
-		dceip.number_of_underlay_pipes = 0;
-		dceip.low_power_tiling_mode = 0;
-		dceip.display_write_back_supported = false;
-		dceip.argb_compression_support = true;
-		dceip.underlay_vscaler_efficiency6_bit_per_component =
+			vbios->dmifmc_urgent_latency = bw_int_to_fixed(3);
+		vbios->stutter_self_refresh_exit_latency = bw_int_to_fixed(5);
+		vbios->stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
+		vbios->nbp_state_change_latency = bw_int_to_fixed(45);
+		vbios->mcifwrmc_urgent_latency = bw_int_to_fixed(10);
+		vbios->scatter_gather_enable = true;
+		vbios->down_spread_percentage = bw_frc_to_fixed(5, 10);
+		vbios->cursor_width = 32;
+		vbios->average_compression_rate = 4;
+		vbios->number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
+		vbios->blackout_duration = bw_int_to_fixed(0); /* us */
+		vbios->maximum_blackout_recovery_time = bw_int_to_fixed(0);
+
+		dceip->max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
+		dceip->max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
+		dceip->percent_of_ideal_port_bw_received_after_urgent_latency = 100;
+		dceip->large_cursor = false;
+		dceip->dmif_request_buffer_size = bw_int_to_fixed(768);
+		dceip->dmif_pipe_en_fbc_chunk_tracker = false;
+		dceip->cursor_max_outstanding_group_num = 1;
+		dceip->lines_interleaved_into_lb = 2;
+		dceip->chunk_width = 256;
+		dceip->number_of_graphics_pipes = 5;
+		dceip->number_of_underlay_pipes = 0;
+		dceip->low_power_tiling_mode = 0;
+		dceip->display_write_back_supported = false;
+		dceip->argb_compression_support = true;
+		dceip->underlay_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35556, 10000);
-		dceip.underlay_vscaler_efficiency8_bit_per_component =
+		dceip->underlay_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.underlay_vscaler_efficiency10_bit_per_component =
+		dceip->underlay_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.underlay_vscaler_efficiency12_bit_per_component =
+		dceip->underlay_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.graphics_vscaler_efficiency6_bit_per_component =
+		dceip->graphics_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35, 10);
-		dceip.graphics_vscaler_efficiency8_bit_per_component =
+		dceip->graphics_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.graphics_vscaler_efficiency10_bit_per_component =
+		dceip->graphics_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.graphics_vscaler_efficiency12_bit_per_component =
+		dceip->graphics_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.alpha_vscaler_efficiency = bw_int_to_fixed(3);
-		dceip.max_dmif_buffer_allocated = 4;
-		dceip.graphics_dmif_size = 12288;
-		dceip.underlay_luma_dmif_size = 19456;
-		dceip.underlay_chroma_dmif_size = 23552;
-		dceip.pre_downscaler_enabled = true;
-		dceip.underlay_downscale_prefetch_enabled = true;
-		dceip.lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
-		dceip.lb_size_per_component444 = bw_int_to_fixed(245952);
-		dceip.graphics_lb_nodownscaling_multi_line_prefetching = true;
-		dceip.stutter_and_dram_clock_state_change_gated_before_cursor =
+		dceip->alpha_vscaler_efficiency = bw_int_to_fixed(3);
+		dceip->max_dmif_buffer_allocated = 4;
+		dceip->graphics_dmif_size = 12288;
+		dceip->underlay_luma_dmif_size = 19456;
+		dceip->underlay_chroma_dmif_size = 23552;
+		dceip->pre_downscaler_enabled = true;
+		dceip->underlay_downscale_prefetch_enabled = true;
+		dceip->lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
+		dceip->lb_size_per_component444 = bw_int_to_fixed(245952);
+		dceip->graphics_lb_nodownscaling_multi_line_prefetching = true;
+		dceip->stutter_and_dram_clock_state_change_gated_before_cursor =
 			bw_int_to_fixed(1);
-		dceip.underlay420_luma_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay420_luma_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.underlay420_chroma_lb_size_per_component =
+		dceip->underlay420_chroma_lb_size_per_component =
 			bw_int_to_fixed(164352);
-		dceip.underlay422_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay422_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.cursor_chunk_width = bw_int_to_fixed(64);
-		dceip.cursor_dcp_buffer_lines = bw_int_to_fixed(4);
-		dceip.underlay_maximum_width_efficient_for_tiling =
+		dceip->cursor_chunk_width = bw_int_to_fixed(64);
+		dceip->cursor_dcp_buffer_lines = bw_int_to_fixed(4);
+		dceip->underlay_maximum_width_efficient_for_tiling =
 			bw_int_to_fixed(1920);
-		dceip.underlay_maximum_height_efficient_for_tiling =
+		dceip->underlay_maximum_height_efficient_for_tiling =
 			bw_int_to_fixed(1080);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
 			bw_frc_to_fixed(3, 10);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
 			bw_int_to_fixed(25);
-		dceip.minimum_outstanding_pte_request_limit = bw_int_to_fixed(
+		dceip->minimum_outstanding_pte_request_limit = bw_int_to_fixed(
 			2);
-		dceip.maximum_total_outstanding_pte_requests_allowed_by_saw =
+		dceip->maximum_total_outstanding_pte_requests_allowed_by_saw =
 			bw_int_to_fixed(128);
-		dceip.limit_excessive_outstanding_dmif_requests = true;
-		dceip.linear_mode_line_request_alternation_slice =
+		dceip->limit_excessive_outstanding_dmif_requests = true;
+		dceip->linear_mode_line_request_alternation_slice =
 			bw_int_to_fixed(64);
-		dceip.scatter_gather_lines_of_pte_prefetching_in_linear_mode =
+		dceip->scatter_gather_lines_of_pte_prefetching_in_linear_mode =
 			32;
-		dceip.display_write_back420_luma_mcifwr_buffer_size = 12288;
-		dceip.display_write_back420_chroma_mcifwr_buffer_size = 8192;
-		dceip.request_efficiency = bw_frc_to_fixed(8, 10);
-		dceip.dispclk_per_request = bw_int_to_fixed(2);
-		dceip.dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
-		dceip.display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
-		dceip.scatter_gather_pte_request_rows_in_tiling_mode = 2;
-		dceip.mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
+		dceip->display_write_back420_luma_mcifwr_buffer_size = 12288;
+		dceip->display_write_back420_chroma_mcifwr_buffer_size = 8192;
+		dceip->request_efficiency = bw_frc_to_fixed(8, 10);
+		dceip->dispclk_per_request = bw_int_to_fixed(2);
+		dceip->dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
+		dceip->display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
+		dceip->scatter_gather_pte_request_rows_in_tiling_mode = 2;
+		dceip->mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
 		break;
 	case BW_CALCS_VERSION_POLARIS12:
-		vbios.memory_type = bw_def_gddr5;
-		vbios.dram_channel_width_in_bits = 32;
-		vbios.number_of_dram_channels = asic_id.vram_width / vbios.dram_channel_width_in_bits;
-		vbios.number_of_dram_banks = 8;
-		vbios.high_yclk = bw_int_to_fixed(6000);
-		vbios.mid_yclk = bw_int_to_fixed(3200);
-		vbios.low_yclk = bw_int_to_fixed(1000);
-		vbios.low_sclk = bw_int_to_fixed(678);
-		vbios.mid1_sclk = bw_int_to_fixed(864);
-		vbios.mid2_sclk = bw_int_to_fixed(900);
-		vbios.mid3_sclk = bw_int_to_fixed(920);
-		vbios.mid4_sclk = bw_int_to_fixed(940);
-		vbios.mid5_sclk = bw_int_to_fixed(960);
-		vbios.mid6_sclk = bw_int_to_fixed(980);
-		vbios.high_sclk = bw_int_to_fixed(1049);
-		vbios.low_voltage_max_dispclk = bw_int_to_fixed(459);
-		vbios.mid_voltage_max_dispclk = bw_int_to_fixed(654);
-		vbios.high_voltage_max_dispclk = bw_int_to_fixed(1108);
-		vbios.low_voltage_max_phyclk = bw_int_to_fixed(540);
-		vbios.mid_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.high_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.data_return_bus_width = bw_int_to_fixed(32);
-		vbios.trc = bw_int_to_fixed(48);
-		if (vbios.number_of_dram_channels == 2) // 64-bit
-			vbios.dmifmc_urgent_latency = bw_int_to_fixed(4);
+		vbios->memory_type = bw_def_gddr5;
+		vbios->dram_channel_width_in_bits = 32;
+		vbios->number_of_dram_channels = asic_id.vram_width / vbios->dram_channel_width_in_bits;
+		vbios->number_of_dram_banks = 8;
+		vbios->high_yclk = bw_int_to_fixed(6000);
+		vbios->mid_yclk = bw_int_to_fixed(3200);
+		vbios->low_yclk = bw_int_to_fixed(1000);
+		vbios->low_sclk = bw_int_to_fixed(678);
+		vbios->mid1_sclk = bw_int_to_fixed(864);
+		vbios->mid2_sclk = bw_int_to_fixed(900);
+		vbios->mid3_sclk = bw_int_to_fixed(920);
+		vbios->mid4_sclk = bw_int_to_fixed(940);
+		vbios->mid5_sclk = bw_int_to_fixed(960);
+		vbios->mid6_sclk = bw_int_to_fixed(980);
+		vbios->high_sclk = bw_int_to_fixed(1049);
+		vbios->low_voltage_max_dispclk = bw_int_to_fixed(459);
+		vbios->mid_voltage_max_dispclk = bw_int_to_fixed(654);
+		vbios->high_voltage_max_dispclk = bw_int_to_fixed(1108);
+		vbios->low_voltage_max_phyclk = bw_int_to_fixed(540);
+		vbios->mid_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->high_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->data_return_bus_width = bw_int_to_fixed(32);
+		vbios->trc = bw_int_to_fixed(48);
+		if (vbios->number_of_dram_channels == 2) // 64-bit
+			vbios->dmifmc_urgent_latency = bw_int_to_fixed(4);
 		else
-			vbios.dmifmc_urgent_latency = bw_int_to_fixed(3);
-		vbios.stutter_self_refresh_exit_latency = bw_int_to_fixed(5);
-		vbios.stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
-		vbios.nbp_state_change_latency = bw_int_to_fixed(250);
-		vbios.mcifwrmc_urgent_latency = bw_int_to_fixed(10);
-		vbios.scatter_gather_enable = false;
-		vbios.down_spread_percentage = bw_frc_to_fixed(5, 10);
-		vbios.cursor_width = 32;
-		vbios.average_compression_rate = 4;
-		vbios.number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
-		vbios.blackout_duration = bw_int_to_fixed(0); /* us */
-		vbios.maximum_blackout_recovery_time = bw_int_to_fixed(0);
-
-		dceip.max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
-		dceip.max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
-		dceip.percent_of_ideal_port_bw_received_after_urgent_latency = 100;
-		dceip.large_cursor = false;
-		dceip.dmif_request_buffer_size = bw_int_to_fixed(768);
-		dceip.dmif_pipe_en_fbc_chunk_tracker = false;
-		dceip.cursor_max_outstanding_group_num = 1;
-		dceip.lines_interleaved_into_lb = 2;
-		dceip.chunk_width = 256;
-		dceip.number_of_graphics_pipes = 5;
-		dceip.number_of_underlay_pipes = 0;
-		dceip.low_power_tiling_mode = 0;
-		dceip.display_write_back_supported = true;
-		dceip.argb_compression_support = true;
-		dceip.underlay_vscaler_efficiency6_bit_per_component =
+			vbios->dmifmc_urgent_latency = bw_int_to_fixed(3);
+		vbios->stutter_self_refresh_exit_latency = bw_int_to_fixed(5);
+		vbios->stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
+		vbios->nbp_state_change_latency = bw_int_to_fixed(250);
+		vbios->mcifwrmc_urgent_latency = bw_int_to_fixed(10);
+		vbios->scatter_gather_enable = false;
+		vbios->down_spread_percentage = bw_frc_to_fixed(5, 10);
+		vbios->cursor_width = 32;
+		vbios->average_compression_rate = 4;
+		vbios->number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
+		vbios->blackout_duration = bw_int_to_fixed(0); /* us */
+		vbios->maximum_blackout_recovery_time = bw_int_to_fixed(0);
+
+		dceip->max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
+		dceip->max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
+		dceip->percent_of_ideal_port_bw_received_after_urgent_latency = 100;
+		dceip->large_cursor = false;
+		dceip->dmif_request_buffer_size = bw_int_to_fixed(768);
+		dceip->dmif_pipe_en_fbc_chunk_tracker = false;
+		dceip->cursor_max_outstanding_group_num = 1;
+		dceip->lines_interleaved_into_lb = 2;
+		dceip->chunk_width = 256;
+		dceip->number_of_graphics_pipes = 5;
+		dceip->number_of_underlay_pipes = 0;
+		dceip->low_power_tiling_mode = 0;
+		dceip->display_write_back_supported = true;
+		dceip->argb_compression_support = true;
+		dceip->underlay_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35556, 10000);
-		dceip.underlay_vscaler_efficiency8_bit_per_component =
+		dceip->underlay_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.underlay_vscaler_efficiency10_bit_per_component =
+		dceip->underlay_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.underlay_vscaler_efficiency12_bit_per_component =
+		dceip->underlay_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.graphics_vscaler_efficiency6_bit_per_component =
+		dceip->graphics_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35, 10);
-		dceip.graphics_vscaler_efficiency8_bit_per_component =
+		dceip->graphics_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.graphics_vscaler_efficiency10_bit_per_component =
+		dceip->graphics_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.graphics_vscaler_efficiency12_bit_per_component =
+		dceip->graphics_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.alpha_vscaler_efficiency = bw_int_to_fixed(3);
-		dceip.max_dmif_buffer_allocated = 4;
-		dceip.graphics_dmif_size = 12288;
-		dceip.underlay_luma_dmif_size = 19456;
-		dceip.underlay_chroma_dmif_size = 23552;
-		dceip.pre_downscaler_enabled = true;
-		dceip.underlay_downscale_prefetch_enabled = true;
-		dceip.lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
-		dceip.lb_size_per_component444 = bw_int_to_fixed(245952);
-		dceip.graphics_lb_nodownscaling_multi_line_prefetching = true;
-		dceip.stutter_and_dram_clock_state_change_gated_before_cursor =
+		dceip->alpha_vscaler_efficiency = bw_int_to_fixed(3);
+		dceip->max_dmif_buffer_allocated = 4;
+		dceip->graphics_dmif_size = 12288;
+		dceip->underlay_luma_dmif_size = 19456;
+		dceip->underlay_chroma_dmif_size = 23552;
+		dceip->pre_downscaler_enabled = true;
+		dceip->underlay_downscale_prefetch_enabled = true;
+		dceip->lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
+		dceip->lb_size_per_component444 = bw_int_to_fixed(245952);
+		dceip->graphics_lb_nodownscaling_multi_line_prefetching = true;
+		dceip->stutter_and_dram_clock_state_change_gated_before_cursor =
 			bw_int_to_fixed(1);
-		dceip.underlay420_luma_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay420_luma_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.underlay420_chroma_lb_size_per_component =
+		dceip->underlay420_chroma_lb_size_per_component =
 			bw_int_to_fixed(164352);
-		dceip.underlay422_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay422_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.cursor_chunk_width = bw_int_to_fixed(64);
-		dceip.cursor_dcp_buffer_lines = bw_int_to_fixed(4);
-		dceip.underlay_maximum_width_efficient_for_tiling =
+		dceip->cursor_chunk_width = bw_int_to_fixed(64);
+		dceip->cursor_dcp_buffer_lines = bw_int_to_fixed(4);
+		dceip->underlay_maximum_width_efficient_for_tiling =
 			bw_int_to_fixed(1920);
-		dceip.underlay_maximum_height_efficient_for_tiling =
+		dceip->underlay_maximum_height_efficient_for_tiling =
 			bw_int_to_fixed(1080);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
 			bw_frc_to_fixed(3, 10);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
 			bw_int_to_fixed(25);
-		dceip.minimum_outstanding_pte_request_limit = bw_int_to_fixed(
+		dceip->minimum_outstanding_pte_request_limit = bw_int_to_fixed(
 			2);
-		dceip.maximum_total_outstanding_pte_requests_allowed_by_saw =
+		dceip->maximum_total_outstanding_pte_requests_allowed_by_saw =
 			bw_int_to_fixed(128);
-		dceip.limit_excessive_outstanding_dmif_requests = true;
-		dceip.linear_mode_line_request_alternation_slice =
+		dceip->limit_excessive_outstanding_dmif_requests = true;
+		dceip->linear_mode_line_request_alternation_slice =
 			bw_int_to_fixed(64);
-		dceip.scatter_gather_lines_of_pte_prefetching_in_linear_mode =
+		dceip->scatter_gather_lines_of_pte_prefetching_in_linear_mode =
 			32;
-		dceip.display_write_back420_luma_mcifwr_buffer_size = 12288;
-		dceip.display_write_back420_chroma_mcifwr_buffer_size = 8192;
-		dceip.request_efficiency = bw_frc_to_fixed(8, 10);
-		dceip.dispclk_per_request = bw_int_to_fixed(2);
-		dceip.dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
-		dceip.display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
-		dceip.scatter_gather_pte_request_rows_in_tiling_mode = 2;
-		dceip.mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
+		dceip->display_write_back420_luma_mcifwr_buffer_size = 12288;
+		dceip->display_write_back420_chroma_mcifwr_buffer_size = 8192;
+		dceip->request_efficiency = bw_frc_to_fixed(8, 10);
+		dceip->dispclk_per_request = bw_int_to_fixed(2);
+		dceip->dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
+		dceip->display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
+		dceip->scatter_gather_pte_request_rows_in_tiling_mode = 2;
+		dceip->mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
 		break;
 	case BW_CALCS_VERSION_STONEY:
-		vbios.memory_type = bw_def_gddr5;
-		vbios.dram_channel_width_in_bits = 64;
-		vbios.number_of_dram_channels = asic_id.vram_width / vbios.dram_channel_width_in_bits;
-		vbios.number_of_dram_banks = 8;
-		vbios.high_yclk = bw_int_to_fixed(1866);
-		vbios.mid_yclk = bw_int_to_fixed(1866);
-		vbios.low_yclk = bw_int_to_fixed(1333);
-		vbios.low_sclk = bw_int_to_fixed(200);
-		vbios.mid1_sclk = bw_int_to_fixed(600);
-		vbios.mid2_sclk = bw_int_to_fixed(600);
-		vbios.mid3_sclk = bw_int_to_fixed(600);
-		vbios.mid4_sclk = bw_int_to_fixed(600);
-		vbios.mid5_sclk = bw_int_to_fixed(600);
-		vbios.mid6_sclk = bw_int_to_fixed(600);
-		vbios.high_sclk = bw_int_to_fixed(800);
-		vbios.low_voltage_max_dispclk = bw_int_to_fixed(352);
-		vbios.mid_voltage_max_dispclk = bw_int_to_fixed(467);
-		vbios.high_voltage_max_dispclk = bw_int_to_fixed(643);
-		vbios.low_voltage_max_phyclk = bw_int_to_fixed(540);
-		vbios.mid_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.high_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.data_return_bus_width = bw_int_to_fixed(32);
-		vbios.trc = bw_int_to_fixed(50);
-		vbios.dmifmc_urgent_latency = bw_int_to_fixed(4);
-		vbios.stutter_self_refresh_exit_latency = bw_frc_to_fixed(158, 10);
-		vbios.stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
-		vbios.nbp_state_change_latency = bw_frc_to_fixed(2008, 100);
-		vbios.mcifwrmc_urgent_latency = bw_int_to_fixed(10);
-		vbios.scatter_gather_enable = true;
-		vbios.down_spread_percentage = bw_frc_to_fixed(5, 10);
-		vbios.cursor_width = 32;
-		vbios.average_compression_rate = 4;
-		vbios.number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
-		vbios.blackout_duration = bw_int_to_fixed(0); /* us */
-		vbios.maximum_blackout_recovery_time = bw_int_to_fixed(0);
-
-		dceip.max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
-		dceip.max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
-		dceip.percent_of_ideal_port_bw_received_after_urgent_latency = 100;
-		dceip.large_cursor = false;
-		dceip.dmif_request_buffer_size = bw_int_to_fixed(768);
-		dceip.dmif_pipe_en_fbc_chunk_tracker = false;
-		dceip.cursor_max_outstanding_group_num = 1;
-		dceip.lines_interleaved_into_lb = 2;
-		dceip.chunk_width = 256;
-		dceip.number_of_graphics_pipes = 2;
-		dceip.number_of_underlay_pipes = 1;
-		dceip.low_power_tiling_mode = 0;
-		dceip.display_write_back_supported = false;
-		dceip.argb_compression_support = true;
-		dceip.underlay_vscaler_efficiency6_bit_per_component =
+		vbios->memory_type = bw_def_gddr5;
+		vbios->dram_channel_width_in_bits = 64;
+		vbios->number_of_dram_channels = asic_id.vram_width / vbios->dram_channel_width_in_bits;
+		vbios->number_of_dram_banks = 8;
+		vbios->high_yclk = bw_int_to_fixed(1866);
+		vbios->mid_yclk = bw_int_to_fixed(1866);
+		vbios->low_yclk = bw_int_to_fixed(1333);
+		vbios->low_sclk = bw_int_to_fixed(200);
+		vbios->mid1_sclk = bw_int_to_fixed(600);
+		vbios->mid2_sclk = bw_int_to_fixed(600);
+		vbios->mid3_sclk = bw_int_to_fixed(600);
+		vbios->mid4_sclk = bw_int_to_fixed(600);
+		vbios->mid5_sclk = bw_int_to_fixed(600);
+		vbios->mid6_sclk = bw_int_to_fixed(600);
+		vbios->high_sclk = bw_int_to_fixed(800);
+		vbios->low_voltage_max_dispclk = bw_int_to_fixed(352);
+		vbios->mid_voltage_max_dispclk = bw_int_to_fixed(467);
+		vbios->high_voltage_max_dispclk = bw_int_to_fixed(643);
+		vbios->low_voltage_max_phyclk = bw_int_to_fixed(540);
+		vbios->mid_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->high_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->data_return_bus_width = bw_int_to_fixed(32);
+		vbios->trc = bw_int_to_fixed(50);
+		vbios->dmifmc_urgent_latency = bw_int_to_fixed(4);
+		vbios->stutter_self_refresh_exit_latency = bw_frc_to_fixed(158, 10);
+		vbios->stutter_self_refresh_entry_latency = bw_int_to_fixed(0);
+		vbios->nbp_state_change_latency = bw_frc_to_fixed(2008, 100);
+		vbios->mcifwrmc_urgent_latency = bw_int_to_fixed(10);
+		vbios->scatter_gather_enable = true;
+		vbios->down_spread_percentage = bw_frc_to_fixed(5, 10);
+		vbios->cursor_width = 32;
+		vbios->average_compression_rate = 4;
+		vbios->number_of_request_slots_gmc_reserves_for_dmif_per_channel = 256;
+		vbios->blackout_duration = bw_int_to_fixed(0); /* us */
+		vbios->maximum_blackout_recovery_time = bw_int_to_fixed(0);
+
+		dceip->max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
+		dceip->max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
+		dceip->percent_of_ideal_port_bw_received_after_urgent_latency = 100;
+		dceip->large_cursor = false;
+		dceip->dmif_request_buffer_size = bw_int_to_fixed(768);
+		dceip->dmif_pipe_en_fbc_chunk_tracker = false;
+		dceip->cursor_max_outstanding_group_num = 1;
+		dceip->lines_interleaved_into_lb = 2;
+		dceip->chunk_width = 256;
+		dceip->number_of_graphics_pipes = 2;
+		dceip->number_of_underlay_pipes = 1;
+		dceip->low_power_tiling_mode = 0;
+		dceip->display_write_back_supported = false;
+		dceip->argb_compression_support = true;
+		dceip->underlay_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35556, 10000);
-		dceip.underlay_vscaler_efficiency8_bit_per_component =
+		dceip->underlay_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.underlay_vscaler_efficiency10_bit_per_component =
+		dceip->underlay_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.underlay_vscaler_efficiency12_bit_per_component =
+		dceip->underlay_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.graphics_vscaler_efficiency6_bit_per_component =
+		dceip->graphics_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35, 10);
-		dceip.graphics_vscaler_efficiency8_bit_per_component =
+		dceip->graphics_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.graphics_vscaler_efficiency10_bit_per_component =
+		dceip->graphics_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.graphics_vscaler_efficiency12_bit_per_component =
+		dceip->graphics_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.alpha_vscaler_efficiency = bw_int_to_fixed(3);
-		dceip.max_dmif_buffer_allocated = 2;
-		dceip.graphics_dmif_size = 12288;
-		dceip.underlay_luma_dmif_size = 19456;
-		dceip.underlay_chroma_dmif_size = 23552;
-		dceip.pre_downscaler_enabled = true;
-		dceip.underlay_downscale_prefetch_enabled = true;
-		dceip.lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
-		dceip.lb_size_per_component444 = bw_int_to_fixed(82176);
-		dceip.graphics_lb_nodownscaling_multi_line_prefetching = false;
-		dceip.stutter_and_dram_clock_state_change_gated_before_cursor =
+		dceip->alpha_vscaler_efficiency = bw_int_to_fixed(3);
+		dceip->max_dmif_buffer_allocated = 2;
+		dceip->graphics_dmif_size = 12288;
+		dceip->underlay_luma_dmif_size = 19456;
+		dceip->underlay_chroma_dmif_size = 23552;
+		dceip->pre_downscaler_enabled = true;
+		dceip->underlay_downscale_prefetch_enabled = true;
+		dceip->lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
+		dceip->lb_size_per_component444 = bw_int_to_fixed(82176);
+		dceip->graphics_lb_nodownscaling_multi_line_prefetching = false;
+		dceip->stutter_and_dram_clock_state_change_gated_before_cursor =
 			bw_int_to_fixed(0);
-		dceip.underlay420_luma_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay420_luma_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.underlay420_chroma_lb_size_per_component =
+		dceip->underlay420_chroma_lb_size_per_component =
 			bw_int_to_fixed(164352);
-		dceip.underlay422_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay422_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.cursor_chunk_width = bw_int_to_fixed(64);
-		dceip.cursor_dcp_buffer_lines = bw_int_to_fixed(4);
-		dceip.underlay_maximum_width_efficient_for_tiling =
+		dceip->cursor_chunk_width = bw_int_to_fixed(64);
+		dceip->cursor_dcp_buffer_lines = bw_int_to_fixed(4);
+		dceip->underlay_maximum_width_efficient_for_tiling =
 			bw_int_to_fixed(1920);
-		dceip.underlay_maximum_height_efficient_for_tiling =
+		dceip->underlay_maximum_height_efficient_for_tiling =
 			bw_int_to_fixed(1080);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
 			bw_frc_to_fixed(3, 10);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
 			bw_int_to_fixed(25);
-		dceip.minimum_outstanding_pte_request_limit = bw_int_to_fixed(
+		dceip->minimum_outstanding_pte_request_limit = bw_int_to_fixed(
 			2);
-		dceip.maximum_total_outstanding_pte_requests_allowed_by_saw =
+		dceip->maximum_total_outstanding_pte_requests_allowed_by_saw =
 			bw_int_to_fixed(128);
-		dceip.limit_excessive_outstanding_dmif_requests = true;
-		dceip.linear_mode_line_request_alternation_slice =
+		dceip->limit_excessive_outstanding_dmif_requests = true;
+		dceip->linear_mode_line_request_alternation_slice =
 			bw_int_to_fixed(64);
-		dceip.scatter_gather_lines_of_pte_prefetching_in_linear_mode =
+		dceip->scatter_gather_lines_of_pte_prefetching_in_linear_mode =
 			32;
-		dceip.display_write_back420_luma_mcifwr_buffer_size = 12288;
-		dceip.display_write_back420_chroma_mcifwr_buffer_size = 8192;
-		dceip.request_efficiency = bw_frc_to_fixed(8, 10);
-		dceip.dispclk_per_request = bw_int_to_fixed(2);
-		dceip.dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
-		dceip.display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
-		dceip.scatter_gather_pte_request_rows_in_tiling_mode = 2;
-		dceip.mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
+		dceip->display_write_back420_luma_mcifwr_buffer_size = 12288;
+		dceip->display_write_back420_chroma_mcifwr_buffer_size = 8192;
+		dceip->request_efficiency = bw_frc_to_fixed(8, 10);
+		dceip->dispclk_per_request = bw_int_to_fixed(2);
+		dceip->dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
+		dceip->display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
+		dceip->scatter_gather_pte_request_rows_in_tiling_mode = 2;
+		dceip->mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
 		break;
 	case BW_CALCS_VERSION_VEGA10:
-		vbios.memory_type = bw_def_hbm;
-		vbios.dram_channel_width_in_bits = 128;
-		vbios.number_of_dram_channels = asic_id.vram_width / vbios.dram_channel_width_in_bits;
-		vbios.number_of_dram_banks = 16;
-		vbios.high_yclk = bw_int_to_fixed(2400);
-		vbios.mid_yclk = bw_int_to_fixed(1700);
-		vbios.low_yclk = bw_int_to_fixed(1000);
-		vbios.low_sclk = bw_int_to_fixed(300);
-		vbios.mid1_sclk = bw_int_to_fixed(350);
-		vbios.mid2_sclk = bw_int_to_fixed(400);
-		vbios.mid3_sclk = bw_int_to_fixed(500);
-		vbios.mid4_sclk = bw_int_to_fixed(600);
-		vbios.mid5_sclk = bw_int_to_fixed(700);
-		vbios.mid6_sclk = bw_int_to_fixed(760);
-		vbios.high_sclk = bw_int_to_fixed(776);
-		vbios.low_voltage_max_dispclk = bw_int_to_fixed(460);
-		vbios.mid_voltage_max_dispclk = bw_int_to_fixed(670);
-		vbios.high_voltage_max_dispclk = bw_int_to_fixed(1133);
-		vbios.low_voltage_max_phyclk = bw_int_to_fixed(540);
-		vbios.mid_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.high_voltage_max_phyclk = bw_int_to_fixed(810);
-		vbios.data_return_bus_width = bw_int_to_fixed(32);
-		vbios.trc = bw_int_to_fixed(48);
-		vbios.dmifmc_urgent_latency = bw_int_to_fixed(3);
-		vbios.stutter_self_refresh_exit_latency = bw_frc_to_fixed(75, 10);
-		vbios.stutter_self_refresh_entry_latency = bw_frc_to_fixed(19, 10);
-		vbios.nbp_state_change_latency = bw_int_to_fixed(39);
-		vbios.mcifwrmc_urgent_latency = bw_int_to_fixed(10);
-		vbios.scatter_gather_enable = false;
-		vbios.down_spread_percentage = bw_frc_to_fixed(5, 10);
-		vbios.cursor_width = 32;
-		vbios.average_compression_rate = 4;
-		vbios.number_of_request_slots_gmc_reserves_for_dmif_per_channel = 8;
-		vbios.blackout_duration = bw_int_to_fixed(0); /* us */
-		vbios.maximum_blackout_recovery_time = bw_int_to_fixed(0);
-
-		dceip.max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
-		dceip.max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
-		dceip.percent_of_ideal_port_bw_received_after_urgent_latency = 100;
-		dceip.large_cursor = false;
-		dceip.dmif_request_buffer_size = bw_int_to_fixed(2304);
-		dceip.dmif_pipe_en_fbc_chunk_tracker = true;
-		dceip.cursor_max_outstanding_group_num = 1;
-		dceip.lines_interleaved_into_lb = 2;
-		dceip.chunk_width = 256;
-		dceip.number_of_graphics_pipes = 6;
-		dceip.number_of_underlay_pipes = 0;
-		dceip.low_power_tiling_mode = 0;
-		dceip.display_write_back_supported = true;
-		dceip.argb_compression_support = true;
-		dceip.underlay_vscaler_efficiency6_bit_per_component =
+		vbios->memory_type = bw_def_hbm;
+		vbios->dram_channel_width_in_bits = 128;
+		vbios->number_of_dram_channels = asic_id.vram_width / vbios->dram_channel_width_in_bits;
+		vbios->number_of_dram_banks = 16;
+		vbios->high_yclk = bw_int_to_fixed(2400);
+		vbios->mid_yclk = bw_int_to_fixed(1700);
+		vbios->low_yclk = bw_int_to_fixed(1000);
+		vbios->low_sclk = bw_int_to_fixed(300);
+		vbios->mid1_sclk = bw_int_to_fixed(350);
+		vbios->mid2_sclk = bw_int_to_fixed(400);
+		vbios->mid3_sclk = bw_int_to_fixed(500);
+		vbios->mid4_sclk = bw_int_to_fixed(600);
+		vbios->mid5_sclk = bw_int_to_fixed(700);
+		vbios->mid6_sclk = bw_int_to_fixed(760);
+		vbios->high_sclk = bw_int_to_fixed(776);
+		vbios->low_voltage_max_dispclk = bw_int_to_fixed(460);
+		vbios->mid_voltage_max_dispclk = bw_int_to_fixed(670);
+		vbios->high_voltage_max_dispclk = bw_int_to_fixed(1133);
+		vbios->low_voltage_max_phyclk = bw_int_to_fixed(540);
+		vbios->mid_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->high_voltage_max_phyclk = bw_int_to_fixed(810);
+		vbios->data_return_bus_width = bw_int_to_fixed(32);
+		vbios->trc = bw_int_to_fixed(48);
+		vbios->dmifmc_urgent_latency = bw_int_to_fixed(3);
+		vbios->stutter_self_refresh_exit_latency = bw_frc_to_fixed(75, 10);
+		vbios->stutter_self_refresh_entry_latency = bw_frc_to_fixed(19, 10);
+		vbios->nbp_state_change_latency = bw_int_to_fixed(39);
+		vbios->mcifwrmc_urgent_latency = bw_int_to_fixed(10);
+		vbios->scatter_gather_enable = false;
+		vbios->down_spread_percentage = bw_frc_to_fixed(5, 10);
+		vbios->cursor_width = 32;
+		vbios->average_compression_rate = 4;
+		vbios->number_of_request_slots_gmc_reserves_for_dmif_per_channel = 8;
+		vbios->blackout_duration = bw_int_to_fixed(0); /* us */
+		vbios->maximum_blackout_recovery_time = bw_int_to_fixed(0);
+
+		dceip->max_average_percent_of_ideal_port_bw_display_can_use_in_normal_system_operation = 100;
+		dceip->max_average_percent_of_ideal_drambw_display_can_use_in_normal_system_operation = 100;
+		dceip->percent_of_ideal_port_bw_received_after_urgent_latency = 100;
+		dceip->large_cursor = false;
+		dceip->dmif_request_buffer_size = bw_int_to_fixed(2304);
+		dceip->dmif_pipe_en_fbc_chunk_tracker = true;
+		dceip->cursor_max_outstanding_group_num = 1;
+		dceip->lines_interleaved_into_lb = 2;
+		dceip->chunk_width = 256;
+		dceip->number_of_graphics_pipes = 6;
+		dceip->number_of_underlay_pipes = 0;
+		dceip->low_power_tiling_mode = 0;
+		dceip->display_write_back_supported = true;
+		dceip->argb_compression_support = true;
+		dceip->underlay_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35556, 10000);
-		dceip.underlay_vscaler_efficiency8_bit_per_component =
+		dceip->underlay_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.underlay_vscaler_efficiency10_bit_per_component =
+		dceip->underlay_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.underlay_vscaler_efficiency12_bit_per_component =
+		dceip->underlay_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.graphics_vscaler_efficiency6_bit_per_component =
+		dceip->graphics_vscaler_efficiency6_bit_per_component =
 			bw_frc_to_fixed(35, 10);
-		dceip.graphics_vscaler_efficiency8_bit_per_component =
+		dceip->graphics_vscaler_efficiency8_bit_per_component =
 			bw_frc_to_fixed(34286, 10000);
-		dceip.graphics_vscaler_efficiency10_bit_per_component =
+		dceip->graphics_vscaler_efficiency10_bit_per_component =
 			bw_frc_to_fixed(32, 10);
-		dceip.graphics_vscaler_efficiency12_bit_per_component =
+		dceip->graphics_vscaler_efficiency12_bit_per_component =
 			bw_int_to_fixed(3);
-		dceip.alpha_vscaler_efficiency = bw_int_to_fixed(3);
-		dceip.max_dmif_buffer_allocated = 4;
-		dceip.graphics_dmif_size = 24576;
-		dceip.underlay_luma_dmif_size = 19456;
-		dceip.underlay_chroma_dmif_size = 23552;
-		dceip.pre_downscaler_enabled = true;
-		dceip.underlay_downscale_prefetch_enabled = false;
-		dceip.lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
-		dceip.lb_size_per_component444 = bw_int_to_fixed(245952);
-		dceip.graphics_lb_nodownscaling_multi_line_prefetching = true;
-		dceip.stutter_and_dram_clock_state_change_gated_before_cursor =
+		dceip->alpha_vscaler_efficiency = bw_int_to_fixed(3);
+		dceip->max_dmif_buffer_allocated = 4;
+		dceip->graphics_dmif_size = 24576;
+		dceip->underlay_luma_dmif_size = 19456;
+		dceip->underlay_chroma_dmif_size = 23552;
+		dceip->pre_downscaler_enabled = true;
+		dceip->underlay_downscale_prefetch_enabled = false;
+		dceip->lb_write_pixels_per_dispclk = bw_int_to_fixed(1);
+		dceip->lb_size_per_component444 = bw_int_to_fixed(245952);
+		dceip->graphics_lb_nodownscaling_multi_line_prefetching = true;
+		dceip->stutter_and_dram_clock_state_change_gated_before_cursor =
 			bw_int_to_fixed(1);
-		dceip.underlay420_luma_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay420_luma_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.underlay420_chroma_lb_size_per_component =
+		dceip->underlay420_chroma_lb_size_per_component =
 			bw_int_to_fixed(164352);
-		dceip.underlay422_lb_size_per_component = bw_int_to_fixed(
+		dceip->underlay422_lb_size_per_component = bw_int_to_fixed(
 			82176);
-		dceip.cursor_chunk_width = bw_int_to_fixed(64);
-		dceip.cursor_dcp_buffer_lines = bw_int_to_fixed(4);
-		dceip.underlay_maximum_width_efficient_for_tiling =
+		dceip->cursor_chunk_width = bw_int_to_fixed(64);
+		dceip->cursor_dcp_buffer_lines = bw_int_to_fixed(4);
+		dceip->underlay_maximum_width_efficient_for_tiling =
 			bw_int_to_fixed(1920);
-		dceip.underlay_maximum_height_efficient_for_tiling =
+		dceip->underlay_maximum_height_efficient_for_tiling =
 			bw_int_to_fixed(1080);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_multiple_displays_or_single_rotated_display =
 			bw_frc_to_fixed(3, 10);
-		dceip.peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
+		dceip->peak_pte_request_to_eviction_ratio_limiting_single_display_no_rotation =
 			bw_int_to_fixed(25);
-		dceip.minimum_outstanding_pte_request_limit = bw_int_to_fixed(
+		dceip->minimum_outstanding_pte_request_limit = bw_int_to_fixed(
 			2);
-		dceip.maximum_total_outstanding_pte_requests_allowed_by_saw =
+		dceip->maximum_total_outstanding_pte_requests_allowed_by_saw =
 			bw_int_to_fixed(128);
-		dceip.limit_excessive_outstanding_dmif_requests = true;
-		dceip.linear_mode_line_request_alternation_slice =
+		dceip->limit_excessive_outstanding_dmif_requests = true;
+		dceip->linear_mode_line_request_alternation_slice =
 			bw_int_to_fixed(64);
-		dceip.scatter_gather_lines_of_pte_prefetching_in_linear_mode =
+		dceip->scatter_gather_lines_of_pte_prefetching_in_linear_mode =
 			32;
-		dceip.display_write_back420_luma_mcifwr_buffer_size = 12288;
-		dceip.display_write_back420_chroma_mcifwr_buffer_size = 8192;
-		dceip.request_efficiency = bw_frc_to_fixed(8, 10);
-		dceip.dispclk_per_request = bw_int_to_fixed(2);
-		dceip.dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
-		dceip.display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
-		dceip.scatter_gather_pte_request_rows_in_tiling_mode = 2;
-		dceip.mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
+		dceip->display_write_back420_luma_mcifwr_buffer_size = 12288;
+		dceip->display_write_back420_chroma_mcifwr_buffer_size = 8192;
+		dceip->request_efficiency = bw_frc_to_fixed(8, 10);
+		dceip->dispclk_per_request = bw_int_to_fixed(2);
+		dceip->dispclk_ramping_factor = bw_frc_to_fixed(105, 100);
+		dceip->display_pipe_throughput_factor = bw_frc_to_fixed(105, 100);
+		dceip->scatter_gather_pte_request_rows_in_tiling_mode = 2;
+		dceip->mcifwr_all_surfaces_burst_time = bw_int_to_fixed(0);
 		break;
 	default:
 		break;
 	}
-	*bw_dceip = dceip;
-	*bw_vbios = vbios;
+	*bw_dceip = *dceip;
+	*bw_vbios = *vbios;
 
+	kfree(dceip);
+	kfree(vbios);
 }
 
 /*
-- 
2.27.0

