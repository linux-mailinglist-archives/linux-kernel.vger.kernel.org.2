Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4275344D070
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 04:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhKKDgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 22:36:01 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:33553 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKKDf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 22:35:59 -0500
X-QQ-mid: bizesmtp54t1636601555t45jsico
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 11 Nov 2021 11:32:28 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00B0000000
X-QQ-FEAT: 0Eq+cbWb7RxGihMVh/8acEZ0o4ZW2aFncchquYndHLD9hp+YJ3afPEWy1mqcW
        4YflMIpR0C2NGQ30aoXyAn8jPofjp8EJ9tmYl6nwy7UauNbg7WvcwIud6AXaPW4J5q2rwk6
        v5h9I4qrwn7CW35o9iP2vzXRwfWqmlTtepHUnvmHg3HEyecCR0o8/ZSV07zUzvv++ho1EeE
        0N7g3UcnWJhy4czFUSqMTszRqhusbDyk5DVU7Y9bDF7MaKXTGEAMaR1jzHtnPBxHn0K1Koe
        3ZIDs/s7c8SCtGokzxmgGjktihcx5mHLdhRceq5Z3u+IRqDscx/AkZFZMsGhg4j5Y7S8UwG
        DV57HBt1vXDPlqcQxolsJDZ3gqbzw==
X-QQ-GoodBg: 2
From:   hongao <hongao@uniontech.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, hongao <hongao@uniontech.com>
Subject: [PATCH] drm/amdgpu: fix set scaling mode Full/Full aspect/Center not works on vga and dvi connectors
Date:   Thu, 11 Nov 2021 11:32:07 +0800
Message-Id: <20211111033207.28565-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdgpu_connector_vga_get_modes missed function amdgpu_get_native_mode
which assign amdgpu_encoder->native_mode with *preferred_mode result in
amdgpu_encoder->native_mode.clock always be 0. That will cause
amdgpu_connector_set_property returned early on:
if ((rmx_type != DRM_MODE_SCALE_NONE) &&
	(amdgpu_encoder->native_mode.clock == 0))
when we try to set scaling mode Full/Full aspect/Center.
Add the missing function to amdgpu_connector_vga_get_mode can fix this.
It also works on dvi connectors because
amdgpu_connector_dvi_helper_funcs.get_mode use the same method.

Signed-off-by: hongao <hongao@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index b9c11c2b2885..0de66f59adb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -827,6 +827,7 @@ static int amdgpu_connector_vga_get_modes(struct drm_connector *connector)
 
 	amdgpu_connector_get_edid(connector);
 	ret = amdgpu_connector_ddc_get_modes(connector);
+	amdgpu_get_native_mode(connector);
 
 	return ret;
 }
-- 
2.20.1



