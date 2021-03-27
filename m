Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CEE34B3BC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 03:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC0CWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 22:22:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14622 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhC0CWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:22:13 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6jGv2yMPz19Kqm;
        Sat, 27 Mar 2021 10:20:07 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 10:21:59 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] drm/amd/display: Remove duplicated header file inclusion
Date:   Sat, 27 Mar 2021 10:21:44 +0800
Message-ID: <20210327022144.2074-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file "dce110/dce110_resource.h" is already included above and
can be removed here.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 4a3df13c9e49add..c4fe21b3b23f65a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -61,7 +61,6 @@
 #include "dcn21/dcn21_dccg.h"
 #include "dcn21_hubbub.h"
 #include "dcn10/dcn10_resource.h"
-#include "dce110/dce110_resource.h"
 #include "dce/dce_panel_cntl.h"
 
 #include "dcn20/dcn20_dwb.h"
-- 
1.8.3


