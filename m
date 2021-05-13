Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03A837F385
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhEMHZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:25:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3742 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhEMHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:24:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgjjX661NzqTXR;
        Thu, 13 May 2021 15:20:16 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 15:23:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH -next 4/4] drm/radeon/radeon_vm: correct function names in radeon_vm.c
Date:   Thu, 13 May 2021 15:25:59 +0800
Message-ID: <20210513072559.1731410-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513072559.1731410-1-yangyingliang@huawei.com>
References: <20210513072559.1731410-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following make W=1 kernel build warnings:

  drivers/gpu/drm/radeon/radeon_vm.c:61: warning: expecting prototype for radeon_vm_num_pde(). Prototype was for radeon_vm_num_pdes() instead
  drivers/gpu/drm/radeon/radeon_vm.c:642: warning: expecting prototype for radeon_vm_update_pdes(). Prototype was for radeon_vm_update_page_directory() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index 2dc9c9f98049..36a38adaaea9 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -51,7 +51,7 @@
  */
 
 /**
- * radeon_vm_num_pde - return the number of page directory entries
+ * radeon_vm_num_pdes - return the number of page directory entries
  *
  * @rdev: radeon_device pointer
  *
@@ -626,7 +626,7 @@ static uint32_t radeon_vm_page_flags(uint32_t flags)
 }
 
 /**
- * radeon_vm_update_pdes - make sure that page directory is valid
+ * radeon_vm_update_page_directory - make sure that page directory is valid
  *
  * @rdev: radeon_device pointer
  * @vm: requested vm
-- 
2.25.1

