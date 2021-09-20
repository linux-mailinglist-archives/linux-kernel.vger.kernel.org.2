Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB3041141C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhITMRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234824AbhITMRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:17:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2797961040;
        Mon, 20 Sep 2021 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632140172;
        bh=aSGPmPDRLP16GIl3fPiwaIaI2XvPbLSEi9QZQZG0BZY=;
        h=From:To:Cc:Subject:Date:From;
        b=FBRLyWZcK8iMM9gQEg0Jk86YoAgzLk5VU2iSBVgom1MMQIVrPrtpkBbfOnpqdGwiS
         ikF4EBcBk/dj7+wO6GUnDEyqgjALDkkH0aA2DIxIVX0JcBEwDtNMklwsomq+TH+eWl
         ubqm5bClcaOR8SxpHUdcTS8tyl5tC5VmoP5FcKx9GRi/fVFlAiwyNe5QIoP1Vd9Ekm
         rGvl9pm/pfWEqvlIcFl4Y3iyZlqxYB+OuyyQjeUwIXumDW7wr8XTfXEkCBjnEzMS0m
         +PJhWJy+p8ejrIY9+Y+bKJUUQL4H0SprG6tBEX21XYyErKxObCgpDI8UCG+yoKXjBp
         3WZkK31iPrZdQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Zhan Liu <zhan.liu@amd.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jun Lei <Jun.Lei@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Wyatt Wood <wyatt.wood@amd.com>, Jude Shih <shenshih@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix empty debug macros
Date:   Mon, 20 Sep 2021 14:16:00 +0200
Message-Id: <20210920121606.93700-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Using an empty macro expansion as a conditional expression
produces a W=1 warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c: In function 'dce_aux_transfer_with_retries':
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:775:156: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  775 |                                                                 "dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER");
      |                                                                                                                                                            ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:783:155: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  783 |                                                                 "dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK");
      |                                                                                                                                                           ^

Expand it to "do { } while (0)" instead to make the expression
more robust and avoid the warning.

Fixes: 56aca2309301 ("drm/amd/display: Add AUX I2C tracing.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index e14f99b4b0c3..3c3347341103 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -42,7 +42,7 @@
 #define DC_LOGGER \
 	engine->ctx->logger
 
-#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+#define DC_TRACE_LEVEL_MESSAGE(...) do { } while (0)
 #define IS_DC_I2CAUX_LOGGING_ENABLED() (false)
 #define LOG_FLAG_Error_I2cAux LOG_ERROR
 #define LOG_FLAG_I2cAux_DceAux LOG_I2C_AUX
@@ -76,7 +76,7 @@ enum {
 #define DEFAULT_AUX_ENGINE_MULT   0
 #define DEFAULT_AUX_ENGINE_LENGTH 69
 
-#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+#define DC_TRACE_LEVEL_MESSAGE(...) do { } while (0)
 
 static void release_engine(
 	struct dce_aux *engine)
-- 
2.29.2

