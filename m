Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625AD344037
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCVLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCVLzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B672C6198B;
        Mon, 22 Mar 2021 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616414104;
        bh=NQBKDv/xaUzATP3yqfPz6TIrtay/vvss0zT4f9fjrSI=;
        h=From:To:Cc:Subject:Date:From;
        b=e1myS2raWRh96kX7ZJKmiBHBzDIu2m8qv6Ix7gWSD9vrjhn7/vFY0poWWvjq0dmls
         Bk7F/1R7UOc3oaf9W+ldRUhOmIUO6c4oLAYCqlE+OYOq5iLrf6chM6jT3yGn4oUZ4D
         68aT/Eg56zDIlJ3ZVSqMuu/AH0S0qpvWF//xs6wodR9wgKEE2FhqbFbsp5tx/qfuz4
         vhvWBJca31stzUgCzR7csVRzFD/ELTuPOl1uTt+fSDO9kop2sHHKqQiAHSM9r50rZo
         0IvOArywDi2AnNEd6XUlKdtCUTIodPsZJmGmyTVaxoxc5FA8cPB7Sjwpu4jgAaYfKv
         dHja6Dr5uYO1Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chen Li <chenli@uniontech.com>, Tom Rix <trix@redhat.com>,
        Sonny Jiang <sonny.jiang@amd.com>,
        xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] amdgpu: avoid incorrect %hu format string
Date:   Mon, 22 Mar 2021 12:54:42 +0100
Message-Id: <20210322115458.3961825-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang points out that the %hu format string does not match the type
of the variables here:

drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:263:7: warning: format specifies type 'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                  version_major, version_minor);
                                  ^~~~~~~~~~~~~
include/drm/drm_print.h:498:19: note: expanded from macro 'DRM_ERROR'
        __drm_err(fmt, ##__VA_ARGS__)
                  ~~~    ^~~~~~~~~~~

Change it to a regular %u, the same way a previous patch did for
another instance of the same warning.

Fixes: 0b437e64e0af ("drm/amdgpu: remove h from printk format specifier")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index e2ed4689118a..c6dbc0801604 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -259,7 +259,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		if ((adev->asic_type == CHIP_POLARIS10 ||
 		     adev->asic_type == CHIP_POLARIS11) &&
 		    (adev->uvd.fw_version < FW_1_66_16))
-			DRM_ERROR("POLARIS10/11 UVD firmware version %hu.%hu is too old.\n",
+			DRM_ERROR("POLARIS10/11 UVD firmware version %u.%u is too old.\n",
 				  version_major, version_minor);
 	} else {
 		unsigned int enc_major, enc_minor, dec_minor;
-- 
2.29.2

