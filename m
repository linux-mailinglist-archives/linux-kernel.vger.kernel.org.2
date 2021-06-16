Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965103A9DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhFPOnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:43:14 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:38496 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhFPOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:43:10 -0400
DKIM-Signature: a=rsa-sha256;
        b=oWdj3MK6w00kMAtjf/o9RCmgDwsKgplJKew8/BHJabycQZUq46eLHQuQX2Oo4fv2H9ivLhj3quexArV/B0rYvD0XFih9FxsqsuAE1Cx/NZq08r7C8b2FgNPpacqWitaHBb65FPt5JPZdcrxJbMLj7O8f9xg1PSeilNIrGLR4ewU=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=nzgfyB066oFaVBGEf/uxwlSYulIxyQZSrA3RBgxK6Bw=;
        h=date:mime-version:subject:message-id:from;
Received: from wanjb-KLV-WX9.. (unknown [121.229.73.16])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id B6A54AC01F0;
        Wed, 16 Jun 2021 22:40:41 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] drm/display: Fix duplicated argument
Date:   Wed, 16 Jun 2021 22:40:17 +0800
Message-Id: <20210616144027.27225-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ00aTFYaT09IS05OQk4fTU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6LSo4UT8cGU5PCx9IOTAo
        LxEaCUtVSlVKTUlIQ05PT09JSE9LVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
        SUpVSUlCVUxIVUpNWVdZCAFZQUlMS003Bg++
X-HM-Tid: 0a7a154465f2b039kuuub6a54ac01f0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:

./drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c:
55:12-42: duplicated argument to && or ||

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index cb15525ddb49..dc8b3afef301 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -52,7 +52,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 4;
 		*BytePerPixelC = 0;
-	} else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
+	} else if (SourcePixelFormat == dm_444_16) {
 		*BytePerPixelDETY = 2;
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 2;
-- 
2.30.2

