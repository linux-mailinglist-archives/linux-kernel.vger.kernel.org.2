Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6AE40871D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbhIMIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:37:39 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59963 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238775AbhIMIfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:35:36 -0400
Received: from localhost.localdomain (ip5f5aef84.dynamic.kabel-deutschland.de [95.90.239.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 78D0061E5FE33;
        Mon, 13 Sep 2021 10:34:19 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu: Demote TMZ unsupported log message from warning to info
Date:   Mon, 13 Sep 2021 10:34:11 +0200
Message-Id: <20210913083411.11215-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913083411.11215-1-pmenzel@molgen.mpg.de>
References: <20210913083411.11215-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the user cannot do anything about the unsupported Trusted Memory Zone
(TMZ) feature, do not warn about it, but make it informational, so
demote the log level from warning to info.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c4c56c57b0c0..bfa0275ff5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -598,7 +598,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 		break;
 	default:
 		adev->gmc.tmz_enabled = false;
-		dev_warn(adev->dev,
+		dev_info(adev->dev,
 			 "Trusted Memory Zone (TMZ) feature not supported by hardware\n");
 		break;
 	}
-- 
2.33.0

