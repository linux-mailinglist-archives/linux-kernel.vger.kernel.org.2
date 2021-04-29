Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E368436EAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhD2Msi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:48:38 -0400
Received: from mail-m176218.qiye.163.com ([59.111.176.218]:53262 "EHLO
        mail-m176218.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhD2Msg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:48:36 -0400
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 08:48:35 EDT
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m176218.qiye.163.com (Hmail) with ESMTPA id 1208F320114;
        Thu, 29 Apr 2021 20:39:09 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Aric Cyr <aric.cyr@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jacky Liao <ziyu.liao@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] [v2] drm/amd/display: Remove duplicate declaration of dc_state
Date:   Thu, 29 Apr 2021 20:38:36 +0800
Message-Id: <20210429123900.25156-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUhKHlZMS0kaGRhJHhkaTR1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6CDo5Hz8IPEgvOD0KFT1C
        SDkKChRVSlVKTUpCTUJCQk9CQkJDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJQ0hKNwY+
X-HM-Tid: 0a791da3e029d978kuws1208f320114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two declarations of struct dc_state here.
Remove the later duplicate more secure.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Remove the later duplicate instead of the former.
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8108b82bac60..6f3c95b5d1a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -594,7 +594,6 @@ struct dc_bounding_box_overrides {
 	int min_dcfclk_mhz;
 };
 
-struct dc_state;
 struct resource_pool;
 struct dce_hwseq;
 struct gpu_info_soc_bounding_box_v1_0;
-- 
2.25.1

