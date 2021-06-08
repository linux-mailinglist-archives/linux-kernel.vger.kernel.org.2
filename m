Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BCA39EC9D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhFHDDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:03:40 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:49232 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhFHDDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:03:37 -0400
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 9C6BFAC0149;
        Tue,  8 Jun 2021 11:01:41 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Strauss <michael.strauss@amd.com>,
        Jake Wang <haonan.wang2@amd.com>,
        Chris Park <Chris.Park@amd.com>, Yao Wang1 <Yao.Wang1@amd.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Jun Lei <jun.lei@amd.com>, Hugo Hu <hugo.hu@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drm: display: Remove duplicate include in dce110
Date:   Tue,  8 Jun 2021 11:01:24 +0800
Message-Id: <20210608030126.23206-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkgYHlZOHkxNHk0aQ0oYGEpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mj46DQw6Fj8SAQ4vMBQvLk4d
        TUlPFAxVSlVKTUlISklKSEtJT0pLVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFISklNNwY+
X-HM-Tid: 0a79e991923ab039kuuu9c6bfac0149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkincludes.pl warning:
./drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
35      #include "dce110_hw_sequencer.h"
    69  #include "dce110_hw_sequencer.h"


Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index a08cd52f6ba8..e20d4def3eb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -66,7 +66,6 @@
 
 #include "atomfirmware.h"
 
-#include "dce110_hw_sequencer.h"
 #include "dcn10/dcn10_hw_sequencer.h"
 
 #define GAMMA_HW_POINTS_NUM 256
-- 
2.20.1

