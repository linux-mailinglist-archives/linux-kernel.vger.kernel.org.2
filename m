Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A432045D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 09:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBTHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 02:41:52 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58047 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhBTHlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 02:41:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UP0X9pI_1613806859;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UP0X9pI_1613806859)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 20 Feb 2021 15:41:05 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
Date:   Sat, 20 Feb 2021 15:40:57 +0800
Message-Id: <1613806857-37216-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c:270:16-21: WARNING:
conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 17e84f3..449fcd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -266,8 +266,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
 	copy_settings_data->init_sdp_deadline			= psr_context->sdpTransmitLineNumDeadline;
 	copy_settings_data->debug.u32All = 0;
-	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
-									true : false;
+	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-- 
1.8.3.1

