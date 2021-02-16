Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07C231D163
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBPULQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:11:12 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B419C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:10:32 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e15so7954654qte.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKwlbcTtgnB6BisI4Bvy7S6GuugskOb7r/1I3tSO040=;
        b=Fwl1w0m1yyz+DUSfQ+nlbFIh9wxR18vvObIsEy0qzWgUdgqJGtnC9sOxTr8SCTD9aP
         66sIMMCN3NX1kJMC2FelE5qc7mO1YvdAR8UDTULWi0w1uUFtDPwcrwJrCdUD8Bd1H2RD
         ce3CYes027o9rz0lBqy9FMu1rJXSbFPANa8l0U2XazTDJVAKB7Xx+t2CkaaVR/AsGl6x
         Gt9fDIFh4os3sf+Wmx+Zxd4XcTG83lwVhc63v/f1GKq480aLQuyO5eya3GABj+ffsfrA
         8oDIl9Grj7LZlSxJBEtTnKeJm+pkYd23mNw5cd0+xGKnR4WQpd//b6q7BfOJe3JXMO4T
         U7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKwlbcTtgnB6BisI4Bvy7S6GuugskOb7r/1I3tSO040=;
        b=flhp9l6CLtaAn2f6Dfo+546QWtlxYQgiq9PT0ql4psOgRdHvhPBA8rtfonk/pgJRDF
         2YrCVJt3aaMaoKgPknQN4n5/6boy+fxfskyxxFnMjvdXrM+3UuoffnhihRXRN43KUJOT
         CuDGhuUnPeAdIbU5eiO0XPbzpv12NUWROepo8vxYsDamENngCZwlnlr11lXd1FCXezMa
         FiC0wI/D6iupq8y87HbM+THaVUKafN0nGGF1DQZPuDNDttojp4J98ptWmSD8WsOtp7ox
         n9bmzrpHG5mUqcTN4ydXcEi989c1hOuFxMRrMw2/Sn3KcPnz6d1MFBuAVsuDZoLib9p/
         7dRA==
X-Gm-Message-State: AOAM530XhXlhmqwijbeHwr3/knuQlhg2calZ5KcBN+zkq6rY3nR6xvyU
        EsIfNkNfZXU1n9bHQa3siPaTVQ==
X-Google-Smtp-Source: ABdhPJx0vhTIMA5ITSYJJ7UNmZPzb2lwEoYHxSg9A1Z0cAvYN5MflzYoDldlCk79CRVDHsPiwZ9t1g==
X-Received: by 2002:ac8:7383:: with SMTP id t3mr19902693qtp.242.1613506231455;
        Tue, 16 Feb 2021 12:10:31 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id 16sm13451423qtp.38.2021.02.16.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:10:30 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: fix for kernels without CONFIG_NVMEM
Date:   Tue, 16 Feb 2021 15:09:07 -0500
Message-Id: <20210216200909.19039-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore nvmem_cell_get() EOPNOTSUPP error in the same way as a ENOENT error,
to fix the case where the kernel was compiled without CONFIG_NVMEM.

Fixes: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index ba8e9d3cf0fe..7fe5d97606aa 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1356,10 +1356,10 @@ static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
 
 	cell = nvmem_cell_get(dev, "speed_bin");
 	/*
-	 * -ENOENT means that the platform doesn't support speedbin which is
-	 * fine
+	 * -ENOENT means no speed bin in device tree,
+	 * -EOPNOTSUPP means kernel was built without CONFIG_NVMEM
 	 */
-	if (PTR_ERR(cell) == -ENOENT)
+	if (PTR_ERR(cell) == -ENOENT || PTR_ERR(cell) == -EOPNOTSUPP)
 		return 0;
 	else if (IS_ERR(cell)) {
 		DRM_DEV_ERROR(dev,
-- 
2.26.1

