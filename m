Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D682038E160
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhEXHSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:18:21 -0400
Received: from m12-15.163.com ([220.181.12.15]:41978 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhEXHSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=S/NJiZJqmVPfl6uxv/
        pDPbwRzT0YuAz/dwnGWeYRgNA=; b=jlMHEbG8bKV22JULJbr/sC/blYN/tiWYdT
        PWtciqU3n8ub5EFcOkMTp6gq2rzkjzvr8P4em+Gp6Ly0V0H1zVIpY+anPmCrDPGV
        veiGUdVR4/jKWvrIcd1A0VR96ftzGPYn8GnzxaE09LKaQ4Y+4RKe55KCREWWoDGN
        4BcNHdsG8=
Received: from huangwentao.ccdomain.com (unknown [218.17.89.92])
        by smtp11 (Coremail) with SMTP id D8CowAA3POi0UqtgIqI3CA--.65S2;
        Mon, 24 May 2021 15:16:27 +0800 (CST)
From:   nswdhpyhwt@163.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        sonny.jiang@amd.com, leo.liu@amd.com, lee.jones@linaro.org
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "tony.huang_cp" <huangwentao@yulong.com>
Subject: [PATCH] drm/amdgpu: fix typo
Date:   Mon, 24 May 2021 15:15:54 +0800
Message-Id: <20210524071554.12344-1-nswdhpyhwt@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: D8CowAA3POi0UqtgIqI3CA--.65S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr18ZrWxAFyfXF1rXw47urg_yoWDGrc_Cr
        48XrnrXw43uFsrtryjv39xX34jvr15CF4kXa4FqFZ5try7Ar43X3y7Zr98Xr48uFy2kF15
        Wa9Ygr1Sqa98GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe6Hq7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: hqvzvxps1k43i6rwjhhfrp/1tbi7wuc8Vr79hwCdQAAs1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "tony.huang_cp" <huangwentao@yulong.com>

change 'interupt' to 'interrupt'

Signed-off-by: tony.huang_cp <huangwentao@yulong.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 284447d..6c0e914 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -340,7 +340,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
 	/* enable VCPU clock */
 	WREG32(mmUVD_VCPU_CNTL,  1 << 9);
 
-	/* disable interupt */
+	/* disable interrupt */
 	WREG32_P(mmUVD_MASTINT_EN, 0, ~(1 << 1));
 
 #ifdef __BIG_ENDIAN
@@ -405,7 +405,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
 		return r;
 	}
 
-	/* enable interupt */
+	/* enable interrupt */
 	WREG32_P(mmUVD_MASTINT_EN, 3<<1, ~(3 << 1));
 
 	WREG32_P(mmUVD_STATUS, 0, ~(1<<2));
-- 
1.9.1

