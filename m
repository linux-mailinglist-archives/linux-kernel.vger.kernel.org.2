Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A14344637
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCVNv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhCVNu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:50:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57F90619A3;
        Mon, 22 Mar 2021 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616421058;
        bh=YA9YxD1Hu+DERDZ6cRSWdcGKGXcYVO3XLjCTjk6a89c=;
        h=Date:From:To:Cc:Subject:From;
        b=M4CHKLXyIARQtuW0IHzOkTDnqSQjfjn6Zt5hkAnIQ2Monol6/1f4qAbjvZQnQNSI4
         PRcVXi/vGJHG9kujjdUlGwmtX8sbmqkDQT0+4Tw1Ox2gTKiM4SiMZABZLJTxpf1Es0
         gV2V/BTEQWIB6kXzKnW3rgwwNal+yqcOCUSkEOiyfTa7xBSbRVu7c9ycTVsh/VUcS4
         5F562g4ZIA6aClkEnxF2Nv2jXlr/t5+bR5BmsKoWw+45JshZ/4f1+B6KlRT/P7OBCP
         jctyHT6dR6P5Q+jm0P4Eewm+7aN86ETIod/MOFuAABy3gocbOXdZN89D3EjzEilcCl
         1kzdMHSpYnh6g==
Date:   Mon, 22 Mar 2021 07:50:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] drm/amd/display: Fix sizeof arguments in
 bw_calcs_init()
Message-ID: <20210322125050.GA236782@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrong sizeof values are currently being used as arguments to
kzalloc().

Fix this by using the right arguments *dceip and *vbios,
correspondingly.

Addresses-Coverity-ID: 1502901 ("Wrong sizeof argument")
Fixes: fca1e079055e ("drm/amd/display/dc/calcs/dce_calcs: Remove some large variables from the stack")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 556ecfabc8d2..1244fcb0f446 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2051,11 +2051,11 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
 
 	enum bw_calcs_version version = bw_calcs_version_from_asic_id(asic_id);
 
-	dceip = kzalloc(sizeof(dceip), GFP_KERNEL);
+	dceip = kzalloc(sizeof(*dceip), GFP_KERNEL);
 	if (!dceip)
 		return;
 
-	vbios = kzalloc(sizeof(vbios), GFP_KERNEL);
+	vbios = kzalloc(sizeof(*vbios), GFP_KERNEL);
 	if (!vbios) {
 		kfree(dceip);
 		return;
-- 
2.27.0

