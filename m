Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91D31725B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhBJV25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233298AbhBJVYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:24:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8865A64E25;
        Wed, 10 Feb 2021 21:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612992213;
        bh=k3bbAR+QQBOR7zd9whmQpQntZ79/acFM/RObzEoAatE=;
        h=Date:From:To:Cc:Subject:From;
        b=BqgEJkVCl0KGcfVOtXDwLivOod3poKWl51r6qsc1KvoGcbt2+SMFUVP7Pn33CoPtx
         4BTBUxGWmk3jirdxVDFeqeLr0lYHm9c3MYOANm+2xiL4KBiSY7gseZEAIDdm92aSQ1
         5NISc/OT1CVUYEmOJ5d2WHKsGYUDvC5QlSc7n7s/7+67IVg3k00gFYjyuDwA7lm5Gu
         1dTeSOnBYXVLq2ZKlqalDU+mZOXAvb6TvObkSKCHqtR1MIxnvWsDkrkwWE/lEB7th0
         6YSOov/V1LzFUuSQrmkQbr+mBDrX8YiAq9nUhn5/xJGwOOHYrevHtdMMxn0vZXoTgM
         cksH2GFNWTrpg==
Date:   Wed, 10 Feb 2021 15:23:30 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] drm/amd/display: Fix potential integer overflow
Message-ID: <20210210212330.GA880153@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix potential integer overflow by casting actual_calculated_clock_100hz
to u64, in order to give the compiler complete information about the
proper arithmetic to use.

Notice that such variable is used in a context that expects
an expression of type u64 (64 bits, unsigned) and the following
expression is currently being evaluated using 32-bit arithmetic:

actual_calculated_clock_100hz * post_divider

Fixes: 7a03fdf628af ("drm/amd/display: fix 64bit division issue on 32bit OS")
Addresses-Coverity-ID: 1501691 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index bc942725b9d8..dec58b3c42e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -240,7 +240,7 @@ static bool calc_fb_divider_checking_tolerance(
 		pll_settings->calculated_pix_clk_100hz =
 			actual_calculated_clock_100hz;
 		pll_settings->vco_freq =
-			div_u64(actual_calculated_clock_100hz * post_divider, 10);
+			div_u64((u64)actual_calculated_clock_100hz * post_divider, 10);
 		return true;
 	}
 	return false;
-- 
2.27.0

