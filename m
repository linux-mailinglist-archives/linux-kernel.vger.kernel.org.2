Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29D83E4529
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhHIMBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhHIMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:01:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B3C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 05:01:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l18so21098470wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4If4cpP4LPIaPQs636VHmaLTFfgMpoUmseK3DeS8Y0=;
        b=gE/LA37GWYJJf00sk9Rv7LV4oh2eDaoHMclKUUCqHwhHXETfKaQGoSgdeMsvWxs1Fn
         iAN+gqjRVb32zuHbu8gv5PQ8hw0wWvS8w6l0QeAZmQaG0MX2w7s7cvOZ1jAJN246/HUS
         AsAjqFcg/kIC1Sp6HsWX3JAkwAwsStHjDp0nj5DWEC57jXfFd46IwTs6EcrhaHed4k8u
         j8ZhlgWjoEeNJ6vgB4fhO3USZSYu0/nBtkAIQT3fNyqv/LNhnm9iqlutL7apvDyoZ3x6
         yMtrhUtaTbDCYyMObF9P08AX+rMd98IPI7MmATkzOPwh79Du58owcEt48dxTiF3lWtnp
         eXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4If4cpP4LPIaPQs636VHmaLTFfgMpoUmseK3DeS8Y0=;
        b=lCfa0KCW3AXCZ2CjDwr8+go5wvI3/SMIabmwhfNcA8NFCczHyer7UeiAo9pjhgSH/l
         dVAf26/pZECSdZPwzjiFvi0o2u/r4MlHj1Z/7LuhjayUM60O1d6cxCXj3UyCuzHy0YAt
         w/nSlwOYKFy1AMF6FktIRp6f5zAaXvRDNn5qYqA53a7UnER08w9RZH4MbfAMfK236aFp
         pnZSn0qi7NrvpzLAdrqijvlV7V95AuAKtBJo4DHpTRv+y72SskAwkIruOSXo7DcMYUqt
         9edsvyrixWaYHz8UTUeLjlH8f1T/6g2Zs7kashAfLX5rHKWauv0TpHfs3JJ28rVkFXMt
         Pyaw==
X-Gm-Message-State: AOAM532ibBrCHUprM6IvFZVCJBZ5w7Qn0E2cwqBEMKqg8U3xZqn1VZAu
        ZYpxcuxrEuly0RnyPG7zAqA=
X-Google-Smtp-Source: ABdhPJz2+xJ2R2cWN2HTp440376o4s3BF7cxkmZov7B1XkOSTkldojCEYJretPMpEuTrnFiMfbMgyA==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr24570467wrp.330.1628510484098;
        Mon, 09 Aug 2021 05:01:24 -0700 (PDT)
Received: from icebear.localdomain ([170.253.11.129])
        by smtp.gmail.com with ESMTPSA id g198sm26028771wme.0.2021.08.09.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:01:23 -0700 (PDT)
From:   "=?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=" <lonyelon@gmail.com>
X-Google-Original-From: =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Hawking.Zhang@amd.com, Felix.Kuehling@amd.com,
        ray.huang@amd.com, lee.jones@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
Subject: [PATCH] drm/amdgpu: Removed unnecessary if statement
Date:   Mon,  9 Aug 2021 14:00:50 +0200
Message-Id: <20210809120050.679048-1-sergio@lony.xyz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was an "if" statement that did nothing so it was removed.

Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 09b048647523..5eb3869d029e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -273,9 +273,6 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	return 0;
 
 out:
-	if (abo) {
-
-	}
 	if (fb && ret) {
 		drm_gem_object_put(gobj);
 		drm_framebuffer_unregister_private(fb);
-- 
2.32.0

