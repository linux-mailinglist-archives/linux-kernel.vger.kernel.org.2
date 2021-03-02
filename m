Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4138532A7B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579068AbhCBQ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:28:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572940AbhCBOIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:08:05 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lH5e9-0005J7-TI; Tue, 02 Mar 2021 14:05:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Mikita Lipski <Mikita.Lipski@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: fix the return of the uninitialized value in ret
Date:   Tue,  2 Mar 2021 14:05:09 +0000
Message-Id: <20210302140509.8466-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if stream->signal is neither SIGNAL_TYPE_DISPLAY_PORT_MST or
SIGNAL_TYPE_DISPLAY_PORT then variable ret is uninitialized and this is
checked for > 0 at the end of the function.  Ret should be initialized,
I believe setting it to zero is a correct default.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: bd0c064c161c ("drm/amd/display: Add return code instead of boolean for future use")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 5159399f8239..5750818db8f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -530,7 +530,7 @@ bool dm_helpers_dp_write_dsc_enable(
 {
 	uint8_t enable_dsc = enable ? 1 : 0;
 	struct amdgpu_dm_connector *aconnector;
-	uint8_t ret;
+	uint8_t ret = 0;
 
 	if (!stream)
 		return false;
-- 
2.30.0

