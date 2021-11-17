Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A76454B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbhKQQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:35:45 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38834 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhKQQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:35:44 -0500
Received: from Monstersaurus.ksquared.org.uk.beta.tailscale.net (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78BC6E7;
        Wed, 17 Nov 2021 17:32:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1637166763;
        bh=MD1fVoPuDcvM3q0RBHroMxwiN1Vyl8xroqKjJv+0Pvc=;
        h=From:To:Cc:Subject:Date:From;
        b=c5KB0FrCZyMWVjs4PJXB+A+rLPnAwAUpPwgwPUAf+9Hrigo1gAVuZ0eRMMVFlvKjv
         v1pP91PsC8Z3hZsBf6+4B4TgaUmRbD4VnO9Q/jQiv2mkTFixHvj5u8QGuYhnENd9+/
         8lVR2Yh6onza3cuvuKHLxw3zID90fiJAE26EgTlo=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpu: drm: panel-edp: Fix edp_panel_entry documentation
Date:   Wed, 17 Nov 2021 16:32:39 +0000
Message-Id: <20211117163239.529781-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The edp_panel_entry members 'delay' and 'name' are documented, but
without the correct syntax for kernel doc.

This generates the following warnings:

drivers/gpu/drm/panel/panel-edp.c:204: warning: Function parameter or member 'delay' not described in 'edp_panel_entry'
drivers/gpu/drm/panel/panel-edp.c:204: warning: Function parameter or member 'name' not described in 'edp_panel_entry'

Fix them accordingly.

Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probed by EDID")
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index fc03046de134..176ef0c3cc1d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -196,10 +196,10 @@ struct edp_panel_entry {
 	/** @panel_id: 32-bit ID for panel, encoded with drm_edid_encode_panel_id(). */
 	u32 panel_id;
 
-	/* @delay: The power sequencing delays needed for this panel. */
+	/** @delay: The power sequencing delays needed for this panel. */
 	const struct panel_delay *delay;
 
-	/* @name: Name of this panel (for printing to logs). */
+	/** @name: Name of this panel (for printing to logs). */
 	const char *name;
 };
 
-- 
2.30.2

