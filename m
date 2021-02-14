Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4929F31B24F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBNTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBNTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:42:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BAC06178A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gb24so2482643pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYz3kOtrZ6Hf5DjXT1UkBRogQ4J1lPOvWIWH1kd6QXA=;
        b=aO2QjQGa2mG9vCy1BwYu3zPMtnftm5Mg2AM9uV8EZImKreIS9VatNBo8bb0qRtNplE
         3OBD8aDO1PGAaH8XGG16wdFBOCLqqTx5nMR5pn1I8GBZO4l4CssVedKyRpXL6TVYrtw6
         TcovWJ3IIlzD1+m8i7Q6j4uqUZI5AThOLWvR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYz3kOtrZ6Hf5DjXT1UkBRogQ4J1lPOvWIWH1kd6QXA=;
        b=Z+Q5J4e1NyKCDa++UmNJugReIbmvq+DhLZuThVaAu0kOpeuztznccgXwbAli50gAHQ
         3hkm4saFmJObDWsjXQnIWwRo557l/bb/PDOAO/UI74bw4Bm83vGpakc/UKUlLcBRo5Mt
         Nolni6/KYDau24qmr3Q2LH1lR5aLk0exeSF2oLPLCWS4mdkjPgST0B6jKlY2+473UT8A
         DA13DUs4JrlI07bewB7t6lT2d12mjEoQ2zM4adS8V0K7rYd2rDZhZ+5MfzTaWuGkPTZ2
         GFUDrFAbCy5kH+4ojjiksrJTWrpdrbSqscxcVg+jn7GZotHBMrzIrEs4zUdb9fawdLWM
         BYDQ==
X-Gm-Message-State: AOAM532rfnztPWzEmuoxz9/7bGHvJCUSKDArbxQcirSLLn/6we+J8LjA
        wYgsGo/wSrZxax59GTMIdzWkMw==
X-Google-Smtp-Source: ABdhPJzLLpSe6h6YLhCLR1f9osYYHY7qcokxZFU5wgjVcteYh/v71KLAWqCEIpbS89QnvAza0juNXg==
X-Received: by 2002:a17:90b:4d06:: with SMTP id mw6mr12223997pjb.24.1613331699994;
        Sun, 14 Feb 2021 11:41:39 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id 125sm15129247pfu.7.2021.02.14.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 11:41:39 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 5/7] drm: bridge: Queue the bridge chain instead of stacking
Date:   Mon, 15 Feb 2021 01:11:00 +0530
Message-Id: <20210214194102.126146-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214194102.126146-1-jagan@amarulasolutions.com>
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_bridge_attach has stacked the bridge chain, so the bridge
that gets pushed last can trigger its bridge function pre_enable
first from drm_atomic_bridge_chain_pre_enable.

This indeed gives a chance to trigger slave bridge pre_enable
first without triggering its host bridge pre_enable for the
usual host to slave device model like DSI host with panel slave.

For fully enabled bridge drivers, host bridge pre_enable has all
host related clock, reset, PHY configuration code that needs to
initialized before sending commands or configuration from a slave
to communicate its host.

Queue the bridge chain instead of stacking it so-that the bridges
that got enqueued first can have a chance to trigger first.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch

 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 64f0effb52ac..e75d1a080c55 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -191,9 +191,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	bridge->encoder = encoder;
 
 	if (previous)
-		list_add(&bridge->chain_node, &previous->chain_node);
+		list_add_tail(&bridge->chain_node, &previous->chain_node);
 	else
-		list_add(&bridge->chain_node, &encoder->bridge_chain);
+		list_add_tail(&bridge->chain_node, &encoder->bridge_chain);
 
 	if (bridge->funcs->attach) {
 		ret = bridge->funcs->attach(bridge, flags);
-- 
2.25.1

