Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8F30FBE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbhBDStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:49:32 -0500
Received: from mailoutvs34.siol.net ([185.57.226.225]:59536 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239386AbhBDSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:48:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E017F523FAF;
        Thu,  4 Feb 2021 19:48:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Jkndiio0b4pd; Thu,  4 Feb 2021 19:48:11 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 97FE0523FBF;
        Thu,  4 Feb 2021 19:48:11 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 9F790523FAF;
        Thu,  4 Feb 2021 19:48:10 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: [PATCH 0/5] sunxi: fix H6 HDMI related issues
Date:   Thu,  4 Feb 2021 19:47:05 +0100
Message-Id: <20210204184710.1880895-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over the year I got plenty of reports of troubles with H6 HDMI signal.
Sometimes monitor flickers, sometimes there was no image at all and
sometimes it didn't play well with AVR.

It turns out there are multiple issues. Patch 1 fixes clock issue,
which didn't adjust parent rate, even if it is allowed to do so. Patch 2
adds polarity config in tcon1. This is seemingly not needed for pre-HDMI2
controllers, although BSP drivers set it accordingly every time. It
turns out that HDMI2 controllers often don't work with monitors if
polarity is not set correctly. Patch 3 always set clock rate for HDMI
controller. Patch 4 fixes cpce PHY setting for 594 MHz. Patch 5 fixes
comment and clock rate limit (wrong reasoning).

Please take a look.

Best regards,
Jernej

Jernej Skrabec (5):
  clk: sunxi-ng: mp: fix parent rate change flag check
  drm/sun4i: tcon: set sync polarity for tcon1 channel
  drm/sun4i: dw-hdmi: always set clock rate
  drm/sun4i: Fix H6 HDMI PHY configuration
  drm/sun4i: dw-hdmi: Fix max. frequency for H6

 drivers/clk/sunxi-ng/ccu_mp.c          |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c     | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h     |  5 +++++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  | 10 +++-------
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  1 -
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c |  2 +-
 6 files changed, 34 insertions(+), 10 deletions(-)

--=20
2.30.0

