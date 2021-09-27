Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5C419408
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhI0MVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhI0MVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:21:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87C0161058;
        Mon, 27 Sep 2021 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632745203;
        bh=rmYi1PvPT1PYGiIrRbsoqUqXMv2Mf8xdCMrtisP77f8=;
        h=From:To:Cc:Subject:Date:From;
        b=a4PnTyc+sw14XVzQYouRB33jI9JBDcpSCFSVPIqcMZAwh1kPwxjMkMl1VbpWmWFCQ
         ZIPPJyRMw//6bUf9KtqQ92XXzx9ECuMO/kM/Ty70tUAr1mf5FB3zhyQtpJ6ky57GfP
         pF6pF80dgXOHevWXfr1K8HKNRJxA6Xf1w7rQWKzCoeqk1luwGAMkqhQJQD2Loxf4ER
         Y9wrOFVDEKUlOs7r7e8/ENkwttHv7HOenm5LVFfmZFQbPVHz7ArAupgisbxwu5eyl1
         voL6Xbs/QWhoYLuXQAJOjyQcAjCq4RwhJ+ZoVthtUgUMpDMwZJbGeYgqhYN26Zklpi
         3LnFhuX4T1xPg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>, shaoyunl <shaoyun.liu@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Jack Zhang <Jack.Zhang1@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] drm/amdgpu: fix clang out-of-range warning
Date:   Mon, 27 Sep 2021 14:19:45 +0200
Message-Id: <20210927121958.941637-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang-14 points out that comparing an 'unsigned int' against a large
64-bit constantn is pointless:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1206:18: error: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                    res->start > 0x100000000ull)

Rephrase the comparison using the upper_32_bits() macro, which should
keep it legible while avoiding the warning.

Fixes: 31b8adab3247 ("drm/amdgpu: require a root bus window above 4GB for BAR resize")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ab3794c42d36..741a55031ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1203,7 +1203,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_bus_for_each_resource(root, res, i) {
 		if (res && res->flags & (IORESOURCE_MEM | IORESOURCE_MEM_64) &&
-		    res->start > 0x100000000ull)
+		    upper_32_bits(res->start) != 0)
 			break;
 	}
 
-- 
2.29.2

