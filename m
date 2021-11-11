Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDF44D488
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhKKKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:02:09 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52906 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232203AbhKKKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:02:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uw1deKi_1636624734;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uw1deKi_1636624734)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 17:59:17 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: clean up some inconsistent indenting
Date:   Thu, 11 Nov 2021 17:58:48 +0800
Message-Id: <1636624728-85197-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2245
dp_dsc_slice_bpg_offset_read() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2044
dp_dsc_pic_width_read() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2101
dp_dsc_pic_height_read() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2173
dp_dsc_chunk_size_read() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1868
dp_dsc_bits_per_pixel_read() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1965
dp_dsc_bits_per_pixel_write() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1787
dp_dsc_slice_height_write() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1602
dp_dsc_slice_width_write() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1687
dp_dsc_slice_height_read() warn: inconsistent indenting.

vers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1417
dp_dsc_clock_en_write() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1502
dp_dsc_slice_width_read() warn: inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1315
dp_dsc_clock_en_read() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 72 +++++++++++-----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9d43ecb..50ef248 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1312,9 +1312,9 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx)
@@ -1414,9 +1414,9 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx || !pipe_ctx->stream)
@@ -1499,9 +1499,9 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx)
@@ -1599,9 +1599,9 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx || !pipe_ctx->stream)
@@ -1684,9 +1684,9 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx)
@@ -1784,9 +1784,9 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx || !pipe_ctx->stream)
@@ -1865,9 +1865,9 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx)
@@ -1962,9 +1962,9 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx || !pipe_ctx->stream)
@@ -2041,9 +2041,9 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx)
@@ -2098,9 +2098,9 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx)
@@ -2170,9 +2170,9 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx)
@@ -2242,9 +2242,9 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream &&
-			    pipe_ctx->stream->link == aconnector->dc_link)
-				break;
+		if (pipe_ctx && pipe_ctx->stream &&
+		    pipe_ctx->stream->link == aconnector->dc_link)
+			break;
 	}
 
 	if (!pipe_ctx)
-- 
1.8.3.1

