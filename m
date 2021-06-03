Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3282F399891
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 05:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFCDbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 23:31:02 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:61694 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCDbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 23:31:01 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 83B74AC03B3;
        Thu,  3 Jun 2021 11:29:15 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
        Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drm: amdgpu: Remove unneeded semicolon in amdgpu_vm.c
Date:   Thu,  3 Jun 2021 11:28:59 +0800
Message-Id: <1622690940-10972-1-git-send-email-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUseTlZPHR1CSRlDQkMZQxpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NyI6Vio5MD8QKxVLNCMpMENM
        Qj0aCS9VSlVKTUlJTUJLQk5NT0tNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUhJWVdZCAFZQUlISkk3Bg++
X-HM-Tid: 0a79cfeb0322b039kuuu83b74ac03b3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1726:2-3: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2460371..231745b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1723,7 +1723,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;
-	};
+	}
 
 	r = vm->update_funcs->commit(&params, fence);
 
-- 
2.7.4

