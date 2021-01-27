Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332D7306836
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhA0XoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhA0Xkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:40:42 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642A0C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:39:51 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 11so2504517pfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v21tqpgjolQTw9HY0r2tj0ANjKrErbpBBTjA+9enZnA=;
        b=GSJN/wW2FLosUcOoaOOPX6pRLCpf1WGgRyuzL23NjZyHaXz1F2Lms6J8Txs907+HRd
         ynRTinENDoHcgXcOV50q/G28w0/F/Pm/FMe/SsNGhGlPjl7Pz4pCk4WCWDXg0MWkz27N
         gjBUw1AMQor+yWquWtv/ypkvU0lnRuy04CHOd+b29xOeK6yYPRmN98jhNct98ycmZ2pO
         ouAzM80cCw/ZmLvlzsA/nU2rHNMLj+qvnb9kPjgzd1e4JNFWpQvQyklStfCloaenmWlT
         +jR9qDLrcS4TpM7d1pY7xqU6H5+ifF8wDonv8yaIDesaEg0o8/svdnfHKkNLFvSA0FZK
         UkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v21tqpgjolQTw9HY0r2tj0ANjKrErbpBBTjA+9enZnA=;
        b=ao00rXwI9gqMvOPFE8jRrCoogefE+gF3PEv7Tqti+bn+KICl6PQG9zLHTXMgqSnOLh
         n7X5Xyfol/YK0UcrJRwTivlwvTaSOUoA7LSwXF1YShl94NvG9DzGbKhSsU57+0OsWzu0
         857m34lLGQ8I+33oXAJR5r4fljBK/XwYR44jZ3cxfieypeOGRd4LEeIEV80XZwjuCYQ6
         928Fk6Q6udA3D6qPhzuivK64BMFtXHO2ncjh26MPEahtCJIQ3OLPRqAH09RVILjzuTBF
         D0KqulOACxNr05Gi+FAm8fYnolGqAN5TQtgXaPtJaTozFnvGM8C1cuaLwWmpr6p0N/7U
         j8Tg==
X-Gm-Message-State: AOAM533qDmI/ru9a8CFCBKOkz26MkHPdnQsiXxIBA09n86zidzKD5/Sv
        feNkD0TvD+X+PJDyzOYHrfsK2w==
X-Google-Smtp-Source: ABdhPJzmIapKXviXijCoY/g+Uxn8nZp1kHCOJ+D3IrJvEwM1XcEejiCexzx+2M4N95x4UBfEan29fA==
X-Received: by 2002:a63:2cc5:: with SMTP id s188mr13948806pgs.233.1611790791019;
        Wed, 27 Jan 2021 15:39:51 -0800 (PST)
Received: from wildbow.anholt.net ([75.164.105.146])
        by smtp.gmail.com with ESMTPSA id q2sm3282382pfj.32.2021.01.27.15.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:39:50 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        stable@vger.kernel.org
Subject: [PATCH 2/3] drm/msm: Fix races managing the OOB state for timestamp vs timestamps.
Date:   Wed, 27 Jan 2021 15:39:45 -0800
Message-Id: <20210127233946.1286386-2-eric@anholt.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127233946.1286386-1-eric@anholt.net>
References: <20210127233946.1286386-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we're not racing with GPU setup, also fix races of timestamps
against other timestamps.  In CI, we were seeing this path trigger
timeouts on setting the GMU bit, especially on the first set of tests
right after boot (it's probably easier to lose the race than one might
think, given that we start many tests in parallel, and waiting for NFS
to page in code probably means that lots of tests hit the same point
of screen init at the same time).

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: stable@vger.kernel.org # v5.9
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7424a70b9d35..e8f0b5325a7f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1175,6 +1175,9 @@ static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	static DEFINE_MUTEX(perfcounter_oob);
+
+	mutex_lock(&perfcounter_oob);
 
 	/* Force the GPU power on so we can read this register */
 	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
@@ -1183,6 +1186,7 @@ static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 		REG_A6XX_RBBM_PERFCTR_CP_0_HI);
 
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
+	mutex_unlock(&perfcounter_oob);
 	return 0;
 }
 
-- 
2.30.0

