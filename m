Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A238454974
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhKQPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhKQPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:02:15 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5E2C0613B9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:59:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A0E3941F28;
        Wed, 17 Nov 2021 14:59:12 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 3/3] drm/simpledrm: Enable XRGB2101010 format
Date:   Wed, 17 Nov 2021 23:58:29 +0900
Message-Id: <20211117145829.204360-4-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117145829.204360-1-marcan@marcan.st>
References: <20211117145829.204360-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the format used by the bootloader framebuffer on Apple ARM64
platforms, and is already supported by simplefb. This avoids regressing
on these platforms when simpledrm is enabled and replaces simplefb.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 2c84f2ea1fa2..b4b69f3a7e79 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -571,7 +571,7 @@ static const uint32_t simpledrm_default_formats[] = {
 	//DRM_FORMAT_XRGB1555,
 	//DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_RGB888,
-	//DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_XRGB2101010,
 	//DRM_FORMAT_ARGB2101010,
 };
 
-- 
2.33.0

