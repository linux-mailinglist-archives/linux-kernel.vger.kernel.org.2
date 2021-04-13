Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8835DC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhDMKN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:13:56 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:52423 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231322AbhDMKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:13:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id E94221ABB;
        Tue, 13 Apr 2021 06:13:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 13 Apr 2021 06:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm2; bh=Pkg2kboYAC5nTcmClnwVE954LT
        tXEgfGAcYRYIm8EPU=; b=reakQQ1ySK5GSXpN0t2zP9I9bv1qisz8X788SNpQO7
        FMeUJIj5ZVjT7iDLnVDSLF3Q5OVnncFqu7PmnbiPgpWCToesLeA9laTjJzWd1oiy
        7LpG/BT5oItd19ffERy201TuSvJx5Ho5JacrobTTN4xawk/Rev+S9jDSSFv9tHFE
        fVBYpR/KchyDy6VRNqhV8lyKYdnSvpUo/Kko24JfgCEqCF0Q6oxGzpC6KC1dw8xR
        tmj1PpZTsxUUK+Udggf0JzUwsu6BGB7QMHxuDRhEqtdLhqgrgLsfFDMBE8i85VFM
        gtYQwPJfoCwUks9fgjkou5LCsbUQcCY51pr2L9BenWYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Pkg2kb
        oYAC5nTcmClnwVE954LTtXEgfGAcYRYIm8EPU=; b=Qzt2s51J9abkyV+kogGp3J
        9gyA739Yx0NavY75cbuEMZkSKTvNb4vdN3ZyBEMA12nHCE2gp4nGIuY8BqnAD3Er
        RIL32vBiYs7GnjrskvNu3JjF/50nKI+otB70TZJf0uPHD6cmtaMS0p5rps+vx6A3
        /QqVmkESDqfs+yuTJsnaHznOUVpvCg0Dr61wINrfGrbmed0zFG4Ojo2frb647rM1
        Hm/x7E4Tz9DfPoGhomuFsnWUD4thlhT8f5011vwo6n1cgunV+6prhAc4xolRfY21
        CureZnWFAnD4ieKvTEIPvp7ScHGc5rfTTCblRkfQP9pBxrNKwDEiZF606qiB5Lgw
        ==
X-ME-Sender: <xms:wm51YCqk-zmpbA6p92LeeZh_LhKictnqNgm5osCI5F42-FqHlQRnkw>
    <xme:wm51YAq-UNDyLz1npfzdl_0xJ_FoRW4hl4RXo33EDKUY0ddsdFCxD3yzc6Thm5GWX
    By9X3QRlFkmWT_HeFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffotggggfesthhqredtredtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeetteeltddujefhffdtuefgudffleelleehjeeggeffuddvvdfgvdfhhfelgfet
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wm51YHM-thGTF-Q83CIZi3AgCLgOM-nAUbEyg5Pb7hVfbcIWANUkrw>
    <xmx:wm51YB5Vm9eRdnC6-kjlC2MIH04ZjIEg5ia7sF99NZYIQevrC04LDw>
    <xmx:wm51YB72hxMpNW1aKhQW7G6KeppFU52xXP9jQHqcb6s-55PhHmqMUQ>
    <xmx:xm51YIq9guRZZ_u0OeQ0n8mtdDJrhWIPWyiUx08I-zNFLbS47q46hahkZIs>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9020D108005F;
        Tue, 13 Apr 2021 06:13:22 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-clk@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/2] clk: Implement a clock request API
Date:   Tue, 13 Apr 2021 12:13:18 +0200
Message-Id: <20210413101320.321584-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0D
=0D
This is a follow-up of the discussion here:=0D
https://lore.kernel.org/linux-clk/20210319150355.xzw7ikwdaga2dwhv@gilmour/=
=0D
=0D
This implements a mechanism to raise and lower clock rates based on consume=
r=0D
workloads, with an example of such an implementation for the RaspberryPi4 H=
DMI=0D
controller.=0D
=0D
There's a couple of things worth discussing:=0D
=0D
  - The name is in conflict with clk_request_rate, and even though it feels=
=0D
    like the right name to me, we should probably avoid any confusion=0D
=0D
  - The code so far implements a policy of always going for the lowest rate=
=0D
    possible. While we don't have an use-case for something else, this shou=
ld=0D
    maybe be made more flexible?=0D
=0D
Let me know what you think=0D
Maxime=0D
=0D
Maxime Ripard (2):=0D
  clk: Introduce a clock request API=0D
  drm/vc4: hdmi: Convert to the new clock request API=0D
=0D
 drivers/clk/clk.c              | 121 +++++++++++++++++++++++++++++++++=0D
 drivers/gpu/drm/vc4/vc4_hdmi.c |  19 ++++--=0D
 drivers/gpu/drm/vc4/vc4_hdmi.h |   3 +=0D
 include/linux/clk.h            |   4 ++=0D
 4 files changed, 140 insertions(+), 7 deletions(-)=0D
=0D
-- =0D
2.30.2=0D
=0D
