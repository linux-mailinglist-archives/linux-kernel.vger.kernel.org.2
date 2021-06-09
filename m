Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A973A0A67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhFIDEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:04:15 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:8204 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhFIDEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:04:14 -0400
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 7D0ADAC0056;
        Wed,  9 Jun 2021 11:02:17 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Chris Park <Chris.Park@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drm: display: Remove duplicated argument in dcn31
Date:   Wed,  9 Jun 2021 11:01:46 +0800
Message-Id: <20210609030202.113368-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh5OH1ZKHk1KTx5JSUhPS0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6Vjo*GT8TGQwTSTc6NhUV
        OUgwCjdVSlVKTUlISUtMTEhDSENLVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFITElONwY+
X-HM-Tid: 0a79eeb87a0bb039kuuu7d0adac0056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c:
3539:12-42: duplicated argument to && or ||
./drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c:
5677:87-123: duplicated argument to && or ||

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index d655655baaba..06fac59a3d40 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -3536,7 +3536,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 4;
 		*BytePerPixelC = 0;
-	} else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
+	} else if (SourcePixelFormat == dm_444_16) {
 		*BytePerPixelDETY = 2;
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 2;
@@ -5674,7 +5674,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
 		if (v->ViewportWidth[k] > v->SurfaceWidthY[k] || v->ViewportHeight[k] > v->SurfaceHeightY[k]) {
 			ViewportExceedsSurface = true;
-			if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
+			if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32
 					&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_444_8
 					&& v->SourcePixelFormat[k] != dm_rgbe) {
 				if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k]
-- 
2.20.1

