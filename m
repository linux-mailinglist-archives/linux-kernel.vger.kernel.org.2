Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDEA34BB34
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 07:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhC1FgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 01:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC1Ffm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 01:35:42 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C627FC061762
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 22:35:41 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g24so7205130qts.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdP4ZZZX6mQ1tenG4YVVE2wJVKUCCHOcqzR6vRzskWY=;
        b=AMYomJGJrHO5sm/jwJB0EG2D51iQ9zajdt+KhbP9kMaJOFynw42meirXG7ONMiHynp
         UQ+bjHBEiDaJCYVZy/tLAFxi73UhZcx94b1djFbdZx8JrACl566mTO8fbMMB5/vEVBNu
         K/sDfQKzxtGJwMXIyl5NL6bVUnBS+kgdQfFsRXMFjNPdzrHYfHzmITjSo/DKggu143Np
         rSpLWV1gKqgmOQfE+NudNsZKM+AgTBBH6CxJyRZZyT7esYwSUfpshpKXI2Z2bLUwQUA+
         FIPsnHdcv5yafw2zR5sEaA6KHA9dKHJzO2Xp3Gwnx7aFJzrV1lGD03scDYauH0Vr6N/j
         KRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdP4ZZZX6mQ1tenG4YVVE2wJVKUCCHOcqzR6vRzskWY=;
        b=BrPIkydEYuHxCct8t/T9uBwRHqu2NPtKxy66J3SBlLbz+pWFAjROMDnbgJruBjEwvC
         S3RDzlOdiTRaVOBi88BsX6/n30NxhElZilzqQjgRb9jYfAgkCq4thvXR2Rxv//DJtyDX
         2bG5JlTqdsKfB6/lTSGJ39s3kDN2fa16hGXM/YZ4+TKhzUaucxNhqXsyzzQ9dYK2Trdr
         8PNT3r/cO0iQP8imRdA+p9NkLTEEvWxpab5xzxgI+M5OT/RQLpo5Xf7mwNXR7j55vqmA
         3d01O2oPEyiLYHJYLuRhjY+HYrXNT0d5SAAQ/TtXUGvo/LvosYd/aN24PpPgUvm7sbJk
         1WoQ==
X-Gm-Message-State: AOAM533e3XWdb2x5m0GY9fRIApoAxzksLCT5BMB7qruzZo2WOSi5jw8Y
        YyPr91sdks+dUKx/tfGRQCnEMIGk8tWz9Q==
X-Google-Smtp-Source: ABdhPJw+jo5SZ/TXLaw6w2dFpNvAdtbkBYA/2CACg9RY79xKl0p3m04eaaCICyw5aTp9z/eIEiuqIQ==
X-Received: by 2002:ac8:4d95:: with SMTP id a21mr17745913qtw.304.1616909740846;
        Sat, 27 Mar 2021 22:35:40 -0700 (PDT)
Received: from localhost.localdomain ([187.39.20.240])
        by smtp.gmail.com with ESMTPSA id d3sm10585356qke.27.2021.03.27.22.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 22:35:40 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     alexander.deucher@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Diego Viola <diego.viola@gmail.com>
Subject: [TRIVIAL] drm/amd/display: fix typo: liason -> liaison
Date:   Sun, 28 Mar 2021 02:35:04 -0300
Message-Id: <20210328053504.164301-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 573cf17262da..1b4b4f508662 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -121,7 +121,7 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
  * DOC: overview
  *
  * The AMDgpu display manager, **amdgpu_dm** (or even simpler,
- * **dm**) sits between DRM and DC. It acts as a liason, converting DRM
+ * **dm**) sits between DRM and DC. It acts as a liaison, converting DRM
  * requests into DC requests, and DC responses into DRM responses.
  *
  * The root control structure is &struct amdgpu_display_manager.
-- 
2.31.1

