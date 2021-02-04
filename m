Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EEC30FC87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhBDTWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:22:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60022 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbhBDSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:34:30 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l7jRo-0007RB-Ig; Thu, 04 Feb 2021 18:33:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: make a const array static, makes object smaller
Date:   Thu,  4 Feb 2021 18:33:44 +0000
Message-Id: <20210204183344.110078-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array frs_limits on the stack but instead make
it static. Makes the object code smaller by 128 bytes:

Before:
   text    data     bss     dec     hex filename
  24845    7440      64   32349    7e5d ./drivers/gpu/drm/bridge/tc358768.o

After:
   text    data     bss     dec     hex filename
  24749    7408      64   32221    7ddd ./drivers/gpu/drm/bridge/tc358768.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 8ed8302d6bbb..2495ea46b091 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -291,7 +291,7 @@ static int tc358768_calc_pll(struct tc358768_priv *priv,
 			     const struct drm_display_mode *mode,
 			     bool verify_only)
 {
-	const u32 frs_limits[] = {
+	static const u32 frs_limits[] = {
 		1000000000,
 		500000000,
 		250000000,
-- 
2.29.2

