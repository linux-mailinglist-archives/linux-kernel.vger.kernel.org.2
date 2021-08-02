Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1372F3DD138
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhHBHc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:32:57 -0400
Received: from mail-m17655.qiye.163.com ([59.111.176.55]:11326 "EHLO
        mail-m17655.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhHBHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:32:56 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17655.qiye.163.com (Hmail) with ESMTPA id 717234014F;
        Mon,  2 Aug 2021 15:32:44 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>,
        Victor Zhao <Victor.Zhao@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] gpu/drm/amd: Remove duplicated include of drm_drv.h
Date:   Mon,  2 Aug 2021 00:32:32 -0700
Message-Id: <1627889555-56431-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJCSktWH0hPQ0JNGR9PHU
        5LVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6Shw*Gj9MPTMKKjY#KDIi
        NC4wFCxVSlVKTUlMQ0NCTk1OTUJMVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlOS083Bg++
X-HM-Tid: 0a7b05c77c4eda01kuws717234014f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate include header file <drm/drm_drv.h>
line 28: #include <drm/drm_drv.h>
line 44: #include <drm/drm_drv.h>

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3ec5099..05f864f 100644
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

