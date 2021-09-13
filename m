Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3B540871C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbhIMIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:37:37 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52087 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238772AbhIMIff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:35:35 -0400
Received: from localhost.localdomain (ip5f5aef84.dynamic.kabel-deutschland.de [95.90.239.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 88F3461E5FE00;
        Mon, 13 Sep 2021 10:34:17 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amdgpu: Clarify that TMZ unsupported message is due to hardware
Date:   Mon, 13 Sep 2021 10:34:10 +0200
Message-Id: <20210913083411.11215-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning

    amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported

leaves the reader wondering, if anything can be done about it. As it’s
unsupported in the hardware, and nothing can be done about, mention that
in the log message.

    amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported by hardware

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c7797eac83c3..c4c56c57b0c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -599,7 +599,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	default:
 		adev->gmc.tmz_enabled = false;
 		dev_warn(adev->dev,
-			 "Trusted Memory Zone (TMZ) feature not supported\n");
+			 "Trusted Memory Zone (TMZ) feature not supported by hardware\n");
 		break;
 	}
 }
-- 
2.33.0

