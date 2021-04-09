Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F37359A52
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhDIJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233655AbhDIJ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A14016115C;
        Fri,  9 Apr 2021 09:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617962179;
        bh=i9H08rKNPCDFCto/eGhd+dFQRD9tjWlncXUq4Ng5sjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQBULByKRtYOwIlukzvq0URB+Y9p1ldNRviU7HpZgDpkIQqVhVXfCPstkRZo5dijH
         17mDhBUEsmExYrl4mDet1d7DA2cdKQkI73an7OMuoA8dLrAQEPFMC9Zf+JCEvOspTj
         KtjaThyGOYHiE5dc+hrWPUgd7jJH8KUHFjepCBtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 05/14] drm/msm: Ratelimit invalid-fence message
Date:   Fri,  9 Apr 2021 11:53:30 +0200
Message-Id: <20210409095300.567414904@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210409095300.391558233@linuxfoundation.org>
References: <20210409095300.391558233@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 7ad48d27a2846bfda29214fb454d001c3e02b9e7 ]

We have seen a couple cases where low memory situations cause something
bad to happen, followed by a flood of these messages obscuring the root
cause.  Lets ratelimit the dmesg spam so that next time it happens we
don't lose the kernel traces leading up to this.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
index a2f89bac9c16..4c0ac0360b93 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -56,7 +56,7 @@ int msm_wait_fence(struct msm_fence_context *fctx, uint32_t fence,
 	int ret;
 
 	if (fence > fctx->last_fence) {
-		DRM_ERROR("%s: waiting on invalid fence: %u (of %u)\n",
+		DRM_ERROR_RATELIMITED("%s: waiting on invalid fence: %u (of %u)\n",
 				fctx->name, fence, fctx->last_fence);
 		return -EINVAL;
 	}
-- 
2.30.2



