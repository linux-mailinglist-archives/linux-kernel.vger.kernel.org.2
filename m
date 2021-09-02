Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3B3FF5C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347362AbhIBVqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:46:13 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59708
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244085AbhIBVqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:46:12 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ECE8F3FE71;
        Thu,  2 Sep 2021 21:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630619112;
        bh=s9p5QLB1+aDHhWrCWaZs6bVSkWVQnpCvcnaOFCjNF1w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=uqdIoGDigSHGeux/F/gdDe1/0r9C8ZJjDg/Zssuiyaf7iStZADcs8G1Agx+zAG0Zz
         DavD3If6UqRelNJ7Iyu3VYe4DxH/B5WA/JhdMMOoWqblbAs0ideETSSn2WfrtcCmEg
         PQKlH8kp5ziQ+8jNGWGV/KsHB6TQpsi4h2C7voTwuCBigjptd8reBUmcjWdo1HDL83
         xgQ+AEE2pNYMB5ceNhLrugjnODd1AkQOPa47EKmWfAviEipmR1aQkIL4Hgh1vTH5Hr
         bvLNmiZJ0p0KseS3Bkd2I9mPoACChBoB9/6UajHNv1c4yL6MjC9OlccsaMZJyjMsAE
         iZpzC0q9yQ7/A==
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: clean up inconsistent indenting
Date:   Thu,  2 Sep 2021 22:45:10 +0100
Message-Id: <20210902214510.55070-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of statements that are indented one character
too deeply, clean these up.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d6aa032890ee..a573424a6e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -60,10 +60,9 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 			goto unlock;
 		}
 
-		 ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
-						TTM_BO_VM_NUM_PREFAULT, 1);
-
-		 drm_dev_exit(idx);
+		ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
+					       TTM_BO_VM_NUM_PREFAULT, 1);
+		drm_dev_exit(idx);
 	} else {
 		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
 	}
-- 
2.32.0

