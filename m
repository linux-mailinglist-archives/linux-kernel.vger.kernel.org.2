Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F736E376
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 05:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhD2DFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 23:05:24 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:52600 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhD2DFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 23:05:11 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id A113E4002B9;
        Thu, 29 Apr 2021 11:04:21 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Aric Cyr <aric.cyr@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drm/amd/display: Remove duplicate include of hubp.h
Date:   Thu, 29 Apr 2021 11:04:01 +0800
Message-Id: <20210429030412.18344-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQk8ZSVZOGkIYT0hNTUpLQxpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6Nhw4Kj8JOElLPxQtSAwc
        GDgaCjFVSlVKTUpCTU1OT01IT0JLVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFIS05ONwY+
X-HM-Tid: 0a791b95a6c3d991kuwsa113e4002b9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 482812d56698e ("drm/amd/display: Set max TTU on
DPG enable"), "hubp.h" was added which caused the duplicate include.
To be on the safe side, remove the later duplicate include.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8f0a13807d05..dcaa6b1e16af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -58,7 +58,6 @@
 #include "dc_link_ddc.h"
 #include "dm_helpers.h"
 #include "mem_input.h"
-#include "hubp.h"
 
 #include "dc_link_dp.h"
 #include "dc_dmub_srv.h"
-- 
2.25.1

