Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F087315D04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhBJCPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:15:01 -0500
Received: from mailoutvs29.siol.net ([185.57.226.220]:48080 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234012AbhBJBKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:10:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 1B725522FAE;
        Tue,  9 Feb 2021 18:59:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pwugU7GkgDO3; Tue,  9 Feb 2021 18:59:15 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id CC3515233C8;
        Tue,  9 Feb 2021 18:59:15 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 81842522FAE;
        Tue,  9 Feb 2021 18:59:13 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        Andre Heider <a.heider@gmail.com>
Subject: [PATCH v3 4/5] drm/sun4i: Fix H6 HDMI PHY configuration
Date:   Tue,  9 Feb 2021 18:58:59 +0100
Message-Id: <20210209175900.7092-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209175900.7092-1-jernej.skrabec@siol.net>
References: <20210209175900.7092-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it turns out, vendor HDMI PHY driver for H6 has a pretty big table
of predefined values for various pixel clocks. However, most of them are
not useful/tested because they come from reference driver code. Vendor
PHY driver is concerned with only few of those, namely 27 MHz, 74.25
MHz, 148.5 MHz, 297 MHz and 594 MHz. These are all frequencies for
standard CEA modes.

Fix sun50i_h6_cur_ctr and sun50i_h6_phy_config with the values only for
aforementioned frequencies.

Table sun50i_h6_mpll_cfg doesn't need to be changed because values are
actually frequency dependant and not so much SoC dependant. See i.MX6
documentation for explanation of those values for similar PHY.

Fixes: c71c9b2fee17 ("drm/sun4i: Add support for Synopsys HDMI PHY")
Tested-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
index 35c2133724e2..9994edf67509 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -104,29 +104,21 @@ static const struct dw_hdmi_mpll_config sun50i_h6_m=
pll_cfg[] =3D {
=20
 static const struct dw_hdmi_curr_ctrl sun50i_h6_cur_ctr[] =3D {
 	/* pixelclk    bpp8    bpp10   bpp12 */
-	{ 25175000,  { 0x0000, 0x0000, 0x0000 }, },
 	{ 27000000,  { 0x0012, 0x0000, 0x0000 }, },
-	{ 59400000,  { 0x0008, 0x0008, 0x0008 }, },
-	{ 72000000,  { 0x0008, 0x0008, 0x001b }, },
-	{ 74250000,  { 0x0013, 0x0013, 0x0013 }, },
-	{ 90000000,  { 0x0008, 0x001a, 0x001b }, },
-	{ 118800000, { 0x001b, 0x001a, 0x001b }, },
-	{ 144000000, { 0x001b, 0x001a, 0x0034 }, },
-	{ 180000000, { 0x001b, 0x0033, 0x0034 }, },
-	{ 216000000, { 0x0036, 0x0033, 0x0034 }, },
-	{ 237600000, { 0x0036, 0x0033, 0x001b }, },
-	{ 288000000, { 0x0036, 0x001b, 0x001b }, },
-	{ 297000000, { 0x0019, 0x001b, 0x0019 }, },
-	{ 330000000, { 0x0036, 0x001b, 0x001b }, },
-	{ 594000000, { 0x003f, 0x001b, 0x001b }, },
+	{ 74250000,  { 0x0013, 0x001a, 0x001b }, },
+	{ 148500000, { 0x0019, 0x0033, 0x0034 }, },
+	{ 297000000, { 0x0019, 0x001b, 0x001b }, },
+	{ 594000000, { 0x0010, 0x001b, 0x001b }, },
 	{ ~0UL,      { 0x0000, 0x0000, 0x0000 }, }
 };
=20
 static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] =3D {
 	/*pixelclk   symbol   term   vlev*/
-	{ 74250000,  0x8009, 0x0004, 0x0232},
-	{ 148500000, 0x8029, 0x0004, 0x0273},
-	{ 594000000, 0x8039, 0x0004, 0x014a},
+	{ 27000000,  0x8009, 0x0007, 0x02b0 },
+	{ 74250000,  0x8009, 0x0006, 0x022d },
+	{ 148500000, 0x8029, 0x0006, 0x0270 },
+	{ 297000000, 0x8039, 0x0005, 0x01ab },
+	{ 594000000, 0x8029, 0x0000, 0x008a },
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
=20
--=20
2.30.0

