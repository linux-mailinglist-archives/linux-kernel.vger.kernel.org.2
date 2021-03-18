Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FFF340F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhCRU0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhCRU0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:26:34 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F0DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:26:33 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g20so613526qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfWkFC2hGX7FJGJQjgEoAFgo2CeiDrhWvQ3LOmHsLm0=;
        b=Z7SJ3tKdyS+cujui3ZNLLtq2X+T9wQl4QMMIMdjqxI4cKxiO49AXbqtRBK5+uFICwY
         EjlalX53XBXReOQZADmexESUjo0EH1MQq/u5lvUoFYir2mm6icEBClYGcVQ63EoSoqO0
         MEAI4DPXejcVouHot0/h6th82uWyuMlzeTIAz3Ul44+hdyjxLdQ0muBTwiH5eHl+SiqT
         dvvkYR1O0OkO84KfKxGG29iGyTbj0eErbbN/sNN/B4iGbm7WV6Jw1zQr83qOD4NMwYOs
         fQw8BVtjufvdyhJwi+fd4vupmxUnX+k/HqnabkQD1CjxvGiEZNhDz3z+GWhk5C0cG6Km
         XoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfWkFC2hGX7FJGJQjgEoAFgo2CeiDrhWvQ3LOmHsLm0=;
        b=OsEG99vryTLkjJT0WJ3vQ/5RcFslogJbgxsLyYP1BdI6IYg+aFChrKQ+PxqquK+fBH
         XAvQj2dl9e9tEbAoMZ6iL1sCCYf1suRdvtpwmntLvrbsphpVxu4Wr6asB6SS5N5z8+op
         FxjMRppnQbH30eT+bBdAoSRC0bpM+gLhPIhbeiwwKUKMG2HPzqOfZzcoJrgV5RjlEBoQ
         eHFARIN8yifnZD0EE0qyVH3QrUUYZl0Jx9gh25pJESDKApFS7mara6MuomDIVHSM3WK0
         wBxHWdC2nK/kAfTYLTe4e1aidLCu/jP//S6l9jTm3No9U8Uhy4ZN5HqIv2Y7/gsW1Sis
         hoRA==
X-Gm-Message-State: AOAM5307QvpNoHSwNm43Mr3j5F4vGgWdNdKvxHBwZF2OtasFTkPeJ08P
        r/92qfT12M3Hh55kAMmPRas=
X-Google-Smtp-Source: ABdhPJwrPO3+5RzvcpKYhHwegYfMnS5cha49OiiD3mTxGTiXFxONegDkQ+mPcpfr7/QRqj+bACLN7A==
X-Received: by 2002:a37:a0ca:: with SMTP id j193mr6255899qke.242.1616099193200;
        Thu, 18 Mar 2021 13:26:33 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.63])
        by smtp.gmail.com with ESMTPSA id j15sm2199786qtr.34.2021.03.18.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:26:32 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
        John.Clements@amd.com, tao.zhou1@amd.com, guchun.chen@amd.com,
        Likun.Gao@amd.com, Bhawanpreet.Lakha@amd.com,
        unixbhaskar@gmail.com, ray.huang@amd.com, Jiansong.Chen@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2] drm/amdgpu: Fix a typo
Date:   Fri, 19 Mar 2021 01:54:14 +0530
Message-Id: <20210318202414.10547-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/traing/training/

...Plus the entire sentence construction for better readability.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Alex and Randy's suggestions incorporated.

 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index c325d6f53a71..bf3857867f51 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -661,10 +661,10 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)

 	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
 		/*
-		 * Long traing will encroach certain mount of bottom VRAM,
-		 * saving the content of this bottom VRAM to system memory
-		 * before training, and restoring it after training to avoid
-		 * VRAM corruption.
+		 * Long training will encroach a certain amount on the bottom of VRAM;
+                 * save the content from the bottom VRAM to system memory
+                 * before training, and restore it after training to avoid
+                 * VRAM corruption.
 		 */
 		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;

--
2.26.2

