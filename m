Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70D9366B87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbhDUNDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240226AbhDUNC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB1D161451;
        Wed, 21 Apr 2021 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010142;
        bh=wG2djFfT+8osfehaB7R4fcMmPfwzBy8RgTh8ZI6qvhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqKJKpxPSNZKEBu/fnUtlCd67KRx5bgDxy5/Dsc+qAWt+j5KHwRBMNUpN4+GgSuDl
         714vKXnRn1aINJB760mMY9OTWuaZPEXDboFQap0TGYUPqe5PAhc1/jbQdlt/F1Z40g
         3tZnd1Dyi6MDKwp1gJ1Yd0xnBDS0tn3xG7Dh6DZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>, Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 027/190] Revert "ASoC: rockchip: Fix a reference count leak."
Date:   Wed, 21 Apr 2021 14:58:22 +0200
Message-Id: <20210421130105.1226686-28-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f141a422159a199f4c8dedb7e0df55b3b2cf16cd.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: https
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 9295d648624e..c52e1dbf6dbe 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -590,10 +590,8 @@ static int rockchip_pdm_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = regcache_sync(pdm->regmap);
 
-- 
2.31.1

