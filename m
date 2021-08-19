Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF03F1A93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbhHSNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:39:19 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42712
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238463AbhHSNjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:39:17 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 445B63F33E;
        Thu, 19 Aug 2021 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629380320;
        bh=uDY6JrKLk8FztgRxaD2qoQzFWUTC3bULwnHL6dWM7q0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=pKp4W5jJWQh7i2c+8UZYOJcyQWX8Z2yW81NoyiyYlmjK8k7J6w+s2mzAtAEnzQXSJ
         dKzfSeinMyIJ62VG2JLd0mU8pPueIY24igg97mds7yQTSqRosIrZaP+lheQBmZ7qeg
         ko4ZdjGl5GaAloudfYu1Jpz93mA1Gq9MtbGEZZxzj5XBwELXY1ghtVWny1NGvnFZr0
         mvz6MBALFiBlCX2J+D0hAPXTdBP1WG1Mm6467lgCwzQcDIOcGcttxgpZ4jHBrOHETc
         jtTED9P0XY1MqmK8GVJWsLuYk1WNTf5OE2HT33thN3vHH1OTreYNpm+S0gBx5UdnCw
         L5y/DYYKjxuBw==
From:   Colin King <colin.king@canonical.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge/tc358767: make the array ext_div static const, makes object smaller
Date:   Thu, 19 Aug 2021 14:38:39 +0100
Message-Id: <20210819133839.10745-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array ext_div on the stack but instead it
static const. Makes the object code smaller by 118 bytes:

Before:
   text    data    bss     dec    hex filename
  39449   17500    128   57077   def5 ./drivers/gpu/drm/bridge/tc358767.o

After:
   text    data    bss     dec    hex filename
  39235   17596    128   56959   de7f ./drivers/gpu/drm/bridge/tc358767.o

(gcc version 10.3.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 23a6f90b694b..599c23759400 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -468,7 +468,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
 	int div, best_div = 1;
 	int mul, best_mul = 1;
 	int delta, best_delta;
-	int ext_div[] = {1, 2, 3, 5, 7};
+	static const int ext_div[] = {1, 2, 3, 5, 7};
 	int best_pixelclock = 0;
 	int vco_hi = 0;
 	u32 pxl_pllparam;
-- 
2.32.0

