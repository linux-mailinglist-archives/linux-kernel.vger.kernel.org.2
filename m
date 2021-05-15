Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE09381A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhEORCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:02:46 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:36506 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230040AbhEORCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:02:43 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C31D81822494D;
        Sat, 15 May 2021 17:01:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 61850268E38;
        Sat, 15 May 2021 17:01:28 +0000 (UTC)
Message-ID: <e5f8613b96fe43bd8ab2ac304a2c9fb57a87a2ca.camel@perches.com>
Subject: [trivial PATCH] drm/amd/display: Fix typo of format termination
 newline
From:   Joe Perches <joe@perches.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 15 May 2021 10:01:26 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 61850268E38
X-Spam-Status: No, score=-0.90
X-Stat-Signature: 1n1bipcbf8r5mj9twb3dsoacrqhrzwam
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/vUQKcwaGcFvtEcpO9mg1PoKuCIHLWcwk=
X-HE-Tag: 1621098088-693195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/n should be \n

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 45f96221a094..b38fee783277 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1724,7 +1724,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	if (!is_soc_bounding_box_valid(dc)) {
-		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
+		DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
 		return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5b54b7fc5105..3bf66c994dd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1497,7 +1497,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	if (!is_soc_bounding_box_valid(dc)) {
-		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
+		DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
 		return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fc2dea243d1b..84c61128423e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1093,7 +1093,7 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	if (!is_soc_bounding_box_valid(dc)) {
-		DC_LOG_ERROR("%s: not valid soc bounding box/n", __func__);
+		DC_LOG_ERROR("%s: not valid soc bounding box\n", __func__);
 		return false;
 	}
 

