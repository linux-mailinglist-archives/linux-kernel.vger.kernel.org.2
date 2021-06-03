Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652DF39981B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCCnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:43:42 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:19372 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:43:41 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.229])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id AD808AC034F;
        Thu,  3 Jun 2021 10:41:54 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, Huang Rui <ray.huang@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>,
        Liu ChengZhe <ChengZhe.Liu@amd.com>,
        Victor Zhao <Victor.Zhao@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drm: amdgpu: Remove duplicate include of drm_drv.h
Date:   Thu,  3 Jun 2021 10:41:45 +0800
Message-Id: <1622688107-20340-1-git-send-email-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR9OSFYdHUtDSEtPTElDSU9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ME06Ejo4Ez8UHRUvGDBITTQ3
        L1EwFBJVSlVKTUlJTUNDSkpOTE5JVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTktVSkxNVUlJQllXWQgBWUFJTEtPNwY+
X-HM-Tid: 0a79cfbfaac1b039kuuuad808ac034f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_drv.h is included at line 28, remove the duplicate here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3ff76cb..131cff0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -41,8 +41,6 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#include <drm/drm_drv.h>
-
 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
 
-- 
2.7.4

