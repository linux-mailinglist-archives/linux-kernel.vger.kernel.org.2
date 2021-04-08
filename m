Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0825A357CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhDHGy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:54:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15964 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHGyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:54:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGBlg3NC6zyNlN;
        Thu,  8 Apr 2021 14:52:31 +0800 (CST)
Received: from huawei.com (10.67.174.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 14:54:32 +0800
From:   Zhang Jianhua <zhangjianhua18@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <lyude@redhat.com>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <zhangjianhua18@huawei.com>
Subject: [PATCH -next] drm/nouveau/nvenc: delete redundant header file priv.h
Date:   Thu, 8 Apr 2021 14:54:37 +0800
Message-ID: <20210408065437.175608-1-zhangjianhua18@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file priv.h has been included two times in base.c,
delete the redundant one.

Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
index c39e797dc7c9..cf5dcfda7b25 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
@@ -21,7 +21,6 @@
  */
 #include "priv.h"
 
-#include "priv.h"
 #include <core/firmware.h>
 
 static void *
-- 
2.17.1

