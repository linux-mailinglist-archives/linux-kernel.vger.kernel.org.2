Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04D7315802
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 21:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhBIUtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:49:52 -0500
Received: from mailoutvs2.siol.net ([185.57.226.193]:51620 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233530AbhBISgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:36:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 611CA52347D;
        Tue,  9 Feb 2021 18:59:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B-xRnyhS4CEV; Tue,  9 Feb 2021 18:59:18 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 2A26C5233C8;
        Tue,  9 Feb 2021 18:59:18 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id D250652348C;
        Tue,  9 Feb 2021 18:59:15 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        Andre Heider <a.heider@gmail.com>
Subject: [PATCH v3 5/5] drm/sun4i: dw-hdmi: Fix max. frequency for H6
Date:   Tue,  9 Feb 2021 18:59:00 +0100
Message-Id: <20210209175900.7092-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209175900.7092-1-jernej.skrabec@siol.net>
References: <20210209175900.7092-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that reasoning for lowering max. supported frequency is
wrong. Scrambling works just fine. Several now fixed bugs prevented
proper functioning, even with rates lower than 340 MHz. Issues were just
more pronounced with higher frequencies.

Fix that by allowing max. supported frequency in HW and fix the comment.

Fixes: cd9063757a22 ("drm/sun4i: DW HDMI: Lower max. supported rate for H=
6")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
index 23773a5e0650..bbdfd5e26ec8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -47,11 +47,9 @@ sun8i_dw_hdmi_mode_valid_h6(struct dw_hdmi *hdmi, void=
 *data,
 {
 	/*
 	 * Controller support maximum of 594 MHz, which correlates to
-	 * 4K@60Hz 4:4:4 or RGB. However, for frequencies greater than
-	 * 340 MHz scrambling has to be enabled. Because scrambling is
-	 * not yet implemented, just limit to 340 MHz for now.
+	 * 4K@60Hz 4:4:4 or RGB.
 	 */
-	if (mode->clock > 340000)
+	if (mode->clock > 594000)
 		return MODE_CLOCK_HIGH;
=20
 	return MODE_OK;
--=20
2.30.0

