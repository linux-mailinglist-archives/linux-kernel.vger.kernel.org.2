Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA643CA0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhGOOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:46:50 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:40204
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234745AbhGOOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:46:49 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3894D4057E;
        Thu, 15 Jul 2021 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626360235;
        bh=gfs+8/c8hnN8i/caRw7hYMCuUCYqZVb6lnRHT6b4R+Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=gD/Vf+hjnBEAE7QGXUPYOvycIlwFLK6pPMepWb9CndW3pG9tg3vrGVNnSaYic8e1D
         s8BHi56rzerLcrtlk4UkFEY8Mq7Lz/6+SCvOMK7qLhWDUNuMRLRFic1JJWmC45NKlI
         XTqn2rrPRPLvrlbYnGU6SlAF1BX3cLTTMsxYMaqbYNX66hS1A74FI1I4DIwSl2pSSv
         45JJ5CDWZpgZGaSifQH2xOsemHu9vfYvjQOLBNsR3YmvU3HvtsUVss5YbtwAODyAxc
         7FLi8Khg8IxSGMDP13MjQcWbsNu8PuckJRR2YSnw0dYGf42r2q5L/Ds+62elxAX901
         1XFNSIquCrepg==
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
Subject: [PATCH] drm: bridge: make const array frs_limits static, makes object smaller
Date:   Thu, 15 Jul 2021 15:43:55 +0100
Message-Id: <20210715144355.28675-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array frs_limits on the stack but instead it
static. Makes the object code smaller by 128 bytes:

Before:
   text    data     bss     dec     hex filename
  25155    7440      64   32659    7f93 ./drivers/gpu/drm/bridge/tc358768.o

After:
   text    data     bss     dec     hex filename
  25059    7408      64   32531    7f13 ./drivers/gpu/drm/bridge/tc358768.o

(gcc version 10.3.0)

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
2.31.1

