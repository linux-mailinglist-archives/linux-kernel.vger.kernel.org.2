Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72724307204
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhA1IvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:51:01 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35864 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232084AbhA1Itc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:49:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UN7ZEIP_1611823776;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UN7ZEIP_1611823776)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Jan 2021 16:50:14 +0800
From:   Abaci Team <abaci-bugfix@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Abaci Team <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Simplify bool conversion
Date:   Thu, 28 Jan 2021 16:49:34 +0800
Message-Id: <1611823774-20749-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:3137:35-40:
WARNING: conversion to bool not needed here

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Suggested-by: Yang Li <oswb@linux.alibaba.com>
Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 017b67b8..fc03d91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3134,7 +3134,7 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
 
 	pipe_ctx->stream_res.opp->funcs->opp_program_stereo(
 		pipe_ctx->stream_res.opp,
-		flags.PROGRAM_STEREO == 1 ? true:false,
+		flags.PROGRAM_STEREO == 1,
 		&stream->timing);
 
 	pipe_ctx->stream_res.tg->funcs->program_stereo(
-- 
1.8.3.1

