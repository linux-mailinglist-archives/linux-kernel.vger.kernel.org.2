Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B142346137
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhCWOQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:16:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34228 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhCWOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:15:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lOhor-0008LE-Be; Tue, 23 Mar 2021 14:15:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display/dc/calcs/dce_calcs: Fix allocation size for dceip and vbios
Date:   Tue, 23 Mar 2021 14:15:41 +0000
Message-Id: <20210323141541.348376-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the allocations for dceip and vbios are based on the size of
the pointer rather than the size of the data structures, causing heap
issues. Fix this by using the correct allocation sizes.

Addresses-Coverity: ("Wrong size of argument")
Fixes: a2a855772210 ("drm/amd/display/dc/calcs/dce_calcs: Remove some large variables from the stack")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
2.30.2

