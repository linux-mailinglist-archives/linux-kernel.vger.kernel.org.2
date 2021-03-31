Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39E435015C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhCaNht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:37:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53808 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbhCaNhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:37:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lRb2O-0004hj-MQ; Wed, 31 Mar 2021 13:37:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: remove redundant initialization of variable status
Date:   Wed, 31 Mar 2021 14:37:36 +0100
Message-Id: <20210331133736.1420943-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable status is being initialized with a value that is
never read and it is being updated later with a new value.
The initialization is redundant and can be removed. Also clean
up an indentation.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b092627bd661..4c226db777dc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1729,12 +1729,11 @@ bool perform_link_training_with_retries(
 			dc_link_dp_perform_link_training_skip_aux(link, link_setting);
 			return true;
 		} else {
-			enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
+			enum link_training_result status;
 
-				status = dc_link_dp_perform_link_training(
-										link,
-										link_setting,
-										skip_video_pattern);
+			status = dc_link_dp_perform_link_training(link,
+								  link_setting,
+								  skip_video_pattern);
 			if (status == LINK_TRAINING_SUCCESS)
 				return true;
 		}
-- 
2.30.2

