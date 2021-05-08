Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82003376F4C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 05:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhEHD5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 23:57:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17599 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhEHD5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 23:57:21 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FcYMT1TF9z16Pc9;
        Sat,  8 May 2021 11:53:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 11:56:10 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] drm/mga: Fix error return code in mga_do_pci_dma_bootstrap()
Date:   Sat, 8 May 2021 11:55:54 +0800
Message-ID: <20210508035554.2424-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user may incorrectly set the value of dma_bs->secondary_bin_count to 0.
In this case, the for loop is not entered and the 'err' value remains 0.

Fixes: 6795c985a648 ("Add support for PCI MGA cards to MGA DRM.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/gpu/drm/mga/mga_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mga/mga_dma.c b/drivers/gpu/drm/mga/mga_dma.c
index 1cb7d120d18f..e41d44ec26de 100644
--- a/drivers/gpu/drm/mga/mga_dma.c
+++ b/drivers/gpu/drm/mga/mga_dma.c
@@ -693,7 +693,7 @@ static int mga_do_pci_dma_bootstrap(struct drm_device *dev,
 	}
 
 	if (bin_count == 0) {
-		DRM_ERROR("Unable to add secondary DMA buffers: %d\n", err);
+		DRM_ERROR("Unable to add secondary DMA buffers: %d\n", err ? : -EINVAL);
 		return err;
 	}
 
-- 
2.25.1


