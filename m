Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2298B41AE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhI1MSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:18:12 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:46204 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240426AbhI1MSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:18:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DB2B3FB08;
        Tue, 28 Sep 2021 14:16:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 23JBK4b2CRQh; Tue, 28 Sep 2021 14:16:19 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/5] mxsfb/nwl/panels: media bus format fixes
Date:   Tue, 28 Sep 2021 14:16:07 +0200
Message-Id: <cover.1632828477.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b776b0f00f24 ("drm: mxsfb: Use bus_format from the nearest bridge if
present") added bus format probing to mxsfb this exposed several issues in the
display stack as used on the Librem 5:

The nwl bridge and the panels didn't bother to set any media bus formats and in
that case mxsfb would not pick a reasonable default. This series aims to fix
this.

This series includes the patch from
https://lore.kernel.org/dri-devel/YVLYh%2FSgBritG%2FRJ@qwark.sigxcpu.org/
with a `dev_warn` added.

The patches are against 5.15-rc3. I've marked a single patch with a 'fixes'
which is enough to unbreak the display stack in 5.15.


Guido Günther (5):
  drm: mxsfb: Print failed bus format in hex
  drm: mxsfb: Set proper default bus format when using a bridge
  drm/bridge: nwl-dsi: Add atomic_get_input_bus_fmts
  drm/panel: mantix: Add media bus format
  drm/panel: st7703: Add media bus format

 drivers/gpu/drm/bridge/nwl-dsi.c              | 35 +++++++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_kms.c             |  7 +++-
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  |  9 +++++
 drivers/gpu/drm/panel/panel-sitronix-st7703.c |  8 +++++
 4 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.33.0

