Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39AF31CDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhBPQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhBPQU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:20:56 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0BAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:20:16 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c1so7449558qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0icCT5ApM7LeprOgl2f4wAWSG1VmMUQ3gNso94fT43o=;
        b=mqWp9dSbEn01YNx52E7+PStvmW8EtfqaziS2vz5FTEcwEa/RmONY3tRY5FPJc83+QS
         okRRzYlHTubrtbTDGjqCIJfFpqBcNnu54ZNprIOMeNenO2w2K3b4sqVNSZHFGLmve0Na
         lOOZkUo8OBB7vEdsor0mDx0w3g8fdGaT8QNhIr4YhaaB0nCMyUoMMRb8spSL6E8jgSYR
         5tsUw88RF+BXGs7tqQSX247pHLs1NjbJ9BCZVVgWY8qvPWcBLme0xsHXtEmMqAyko7F3
         ABw5m3QlyLsR6dK90mQ/LQy2W/vk+8ioZsPrANon7gowXiWGtB2a7fQZW8J8VFgy5q7L
         pXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0icCT5ApM7LeprOgl2f4wAWSG1VmMUQ3gNso94fT43o=;
        b=Qiu30QUDX/1Y/DjKpMK2j4TMoWp3X+OC4DjQHTFdAs/rJmM4jxaVbNlFgxhVxqt6e3
         DYrVOHZEWd8KD8jeqXd3P+75grTNrHJWGURchLLVHCuVgAx7WEPvfGMF1P2Mo7lDUK4m
         LNLy48iHnudBXm3E9nk6ZplZ3EW9y3ULggHdewoqUOiOHVzPw7y/rMJba463jBpja5EI
         lYe6BVi+j0F+Wm7ION3EoWqwMXoajSkk33yhxUEz8hFGGl3qKdHGSPA9uX1CxUo5ezKB
         /afWdfXSOj4lbd/H5U2nyMjTSq5QY0jJCgPDH9+uxGqNotDzEar8lJ6lt601lEdfwy6i
         9aZQ==
X-Gm-Message-State: AOAM532t+X9YL+WomavHc8kcBY/Vfupjp7IbEHMKts8LEXrHd4wJPTKE
        EK8WgJ4zX7/1NaNSSo3C8nexrsH5aBctpw==
X-Google-Smtp-Source: ABdhPJzzehrU64QYRiOPi5nqmjSpjmBI/BbsVnX+xybj20LQmtNLshZ47CRqMcK2ZIcM4ElN6snqRA==
X-Received: by 2002:ac8:1c8a:: with SMTP id f10mr19237800qtl.4.1613492415041;
        Tue, 16 Feb 2021 08:20:15 -0800 (PST)
Received: from localhost.localdomain ([187.39.20.240])
        by smtp.gmail.com with ESMTPSA id d22sm13508855qtp.34.2021.02.16.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:20:14 -0800 (PST)
From:   Diego Viola <diego.viola@gmail.com>
To:     bskeggs@redhat.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@spliet.org, gnurou@gmail.com,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH v2] drm/nouveau/pmu: fix timeout on GP108
Date:   Tue, 16 Feb 2021 13:19:24 -0300
Message-Id: <20210216161924.1687-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code times out on GP108, probably because the BIOS puts it into a
bad state.

Since we reset the PMU on driver load anyway, we are at no risk from
missing a response from it since we are not waiting for one to begin
with.

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
index a0fe607c9c07..5c802f2d00cb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
@@ -102,12 +102,8 @@ nvkm_pmu_reset(struct nvkm_pmu *pmu)
 	if (!pmu->func->enabled(pmu))
 		return 0;
 
-	/* Inhibit interrupts, and wait for idle. */
+	/* Inhibit interrupts. */
 	nvkm_wr32(device, 0x10a014, 0x0000ffff);
-	nvkm_msec(device, 2000,
-		if (!nvkm_rd32(device, 0x10a04c))
-			break;
-	);
 
 	/* Reset. */
 	if (pmu->func->reset)
-- 
2.30.1

