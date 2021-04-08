Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694B2357CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhDHG63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:58:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16401 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDHG61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:58:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGBrD4mrdzkjSm;
        Thu,  8 Apr 2021 14:56:28 +0800 (CST)
Received: from huawei.com (10.67.174.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 14:58:08 +0800
From:   Zhang Jianhua <zhangjianhua18@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <johnny.chenyi@huawei.com>,
        <heying24@huawei.com>, <zhangjianhua18@huawei.com>
Subject: [PATCH -next] drm/nouveau: delete redundant header file if000c.h
Date:   Thu, 8 Apr 2021 14:58:13 +0800
Message-ID: <20210408065813.176362-1-zhangjianhua18@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file if000c.h has been included two times in nouveau_dmem.c,
delete the redundant one.

Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 92987daa5e17..f5cc057b123b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -33,7 +33,6 @@
 #include <nvif/if000c.h>
 #include <nvif/if500b.h>
 #include <nvif/if900b.h>
-#include <nvif/if000c.h>
 
 #include <nvhw/class/cla0b5.h>
 
-- 
2.17.1

