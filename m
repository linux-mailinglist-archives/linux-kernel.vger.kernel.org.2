Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992C6324F50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBYLjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:39:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13088 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhBYLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:39:04 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmW2l0pD6z16CZf;
        Thu, 25 Feb 2021 19:36:31 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Feb 2021
 19:37:58 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <bskeggs@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <luojiaxing@huawei.com>
Subject: [PATCH v1] drm/nouveau/device: append a NUL-terminated character for the string which filled by strncpy()
Date:   Thu, 25 Feb 2021 19:38:52 +0800
Message-ID: <1614253132-21793-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following warning is found when using W=1 to build kernel:

In function ‘nvkm_udevice_info’,
    inlined from ‘nvkm_udevice_mthd’ at drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:195:10:
drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:164:2: warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
  164 |  strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip));
drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:165:2: warning: ‘strncpy’ specified bound 64 equals destination size [-Wstringop-truncation]
  165 |  strncpy(args->v0.name, device->name, sizeof(args->v0.name));

The reason of this warning is strncpy() does not guarantee that the
destination buffer will be NUL terminated. If the length of source string
is bigger than number we set by third input parameter, only first [number]
of characters is copied to the destination, and no NUL-terminated is
automatically added. There are some potential risks.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
index fea9d8f..2a32fe0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
@@ -161,8 +161,10 @@ nvkm_udevice_info(struct nvkm_udevice *udev, void *data, u32 size)
 	if (imem && args->v0.ram_size > 0)
 		args->v0.ram_user = args->v0.ram_user - imem->reserved;
 
-	strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip));
-	strncpy(args->v0.name, device->name, sizeof(args->v0.name));
+	strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip) - 1);
+	args->v0.chip[sizeof(args->v0.chip) - 1] = '\0';
+	strncpy(args->v0.name, device->name, sizeof(args->v0.name) - 1);
+	args->v0.name[sizeof(args->v0.name) - 1] = '\0';
 	return 0;
 }
 
-- 
2.7.4

