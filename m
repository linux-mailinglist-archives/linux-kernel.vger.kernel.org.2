Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB4F3454E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhCWBUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:20:10 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:57986 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhCWBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:19:40 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 295F0980299;
        Tue, 23 Mar 2021 09:19:36 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wan Jiabing <wanjiabing@vivo.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] gpu: drm: amd: Remove duplicate includes
Date:   Tue, 23 Mar 2021 09:19:20 +0800
Message-Id: <20210323011923.133284-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGktPHx0eSENIHk4dVkpNSk1PTUlITE1PSE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M1E6PSo6Cz8KNDoMAkNPHT0L
        ExoKCjlVSlVKTUpNT01JSExMSEpOVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJS0JPNwY+
X-HM-Tid: 0a785caa6db4d992kuws295f0980299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

../hw_ddc.h, ../hw_gpio.h and ../hw_hpd.h have been included 
at line 32, so remove them.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 .../gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c    | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
index 66e4841f41e4..ca335ea60412 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
@@ -48,10 +48,6 @@
 #define REGI(reg_name, block, id)\
 	mm ## block ## id ## _ ## reg_name
 
-#include "../hw_gpio.h"
-#include "../hw_ddc.h"
-#include "../hw_hpd.h"
-
 #include "reg_helper.h"
 #include "../hpd_regs.h"
 
-- 
2.25.1

