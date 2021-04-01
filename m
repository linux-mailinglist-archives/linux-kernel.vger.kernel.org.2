Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4384351B16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbhDASGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:06:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15896 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbhDARuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:50:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FB4ry6b0hzkbk8;
        Thu,  1 Apr 2021 22:12:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 22:14:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>
CC:     <bskeggs@redhat.com>
Subject: [PATCH -next] drm/nouveau/gem: remove redundant semi-colon
Date:   Thu, 1 Apr 2021 22:17:31 +0800
Message-ID: <20210401141731.1684236-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index c88cbb85f101..492e6794c5e6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -303,7 +303,7 @@ nouveau_gem_set_domain(struct drm_gem_object *gem, uint32_t read_domains,
 	struct ttm_buffer_object *bo = &nvbo->bo;
 	uint32_t domains = valid_domains & nvbo->valid_domains &
 		(write_domains ? write_domains : read_domains);
-	uint32_t pref_domains = 0;;
+	uint32_t pref_domains = 0;
 
 	if (!domains)
 		return -EINVAL;
-- 
2.25.1

