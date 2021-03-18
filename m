Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9333FD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhCRChD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:37:03 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55009 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbhCRChC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:37:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0USMCysI_1616035014;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USMCysI_1616035014)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Mar 2021 10:37:00 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
Date:   Thu, 18 Mar 2021 10:36:52 +0800
Message-Id: <1616035012-88614-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c:220:65-70:
WARNING: conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
index 8593145..3fe9e41 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
@@ -217,7 +217,7 @@ static bool dwb3_program_ogam_lut(
 	else
 		next_mode = LUT_RAM_A;
 
-	dwb3_configure_ogam_lut(dwbc30, next_mode == LUT_RAM_A ? true : false);
+	dwb3_configure_ogam_lut(dwbc30, next_mode == LUT_RAM_A);
 
 	if (next_mode == LUT_RAM_A)
 		dwb3_program_ogam_luta_settings(dwbc30, params);
-- 
1.8.3.1

