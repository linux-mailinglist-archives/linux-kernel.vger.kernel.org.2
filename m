Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016A0330969
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCHIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:32:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13138 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhCHIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:32:18 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvBNz6wqGz16HjZ;
        Mon,  8 Mar 2021 16:30:27 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Mar 2021
 16:32:05 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <bskeggs@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <luojiaxing@huawei.com>, <song.bao.hua@hisilicon.com>
Subject: [PATCH v1] drm/nouveau/device: use snprintf() to replace strncpy() to avoid NUL-terminated string loss
Date:   Mon, 8 Mar 2021 16:32:52 +0800
Message-ID: <1615192372-47348-1-git-send-email-luojiaxing@huawei.com>
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
is bigger than number we set by third input parameter, only a part of
characters is copied to the destination, and no NUL-terminated string is
automatically added. There are some potential risks.

So use snprintf() to replace strncpy().

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
index fea9d8f..4bf65bb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
@@ -161,8 +161,8 @@ nvkm_udevice_info(struct nvkm_udevice *udev, void *data, u32 size)
 	if (imem && args->v0.ram_size > 0)
 		args->v0.ram_user = args->v0.ram_user - imem->reserved;
 
-	strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip));
-	strncpy(args->v0.name, device->name, sizeof(args->v0.name));
+	snprintf(args->v0.chip, sizeof(args->v0.chip), "%s", device->chip->name);
+	snprintf(args->v0.name, sizeof(args->v0.name), "%s", device->name);
 	return 0;
 }
 
-- 
2.7.4

