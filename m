Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3134440AAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhINJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:36:41 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:45489 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhINJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:36:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 63A232B012CF;
        Tue, 14 Sep 2021 05:35:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 14 Sep 2021 05:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm3; bh=MbCLtK+Ko5KselMLX35ztLWqzX
        dUel8YRNbzefJz1cE=; b=317Og+AUXwATmqZIxz3bOKDtnoNNTzr9kG6VPjI2+y
        s8uAUBuLyo7LOzyUa7iU1p6NoysO/aajkUWHY9razMCgZKNFQv7tI+vgSWI/Im7D
        gjhlRpzB+vhDIzpvDbjPKA2wVy8+MjMkzgrdcllm9RhvRsA/oUCRIpzeMhhOjP88
        4gPUfDJfK/nHCf7KM90bcZhUfmWt9xStd/21wG88F58GvDYyHH7jJSiTGfEAqTdJ
        /NZ6hM5XUmPYoe8Lg4XgeiRsUgwDcdloqrEGFoER4CqsWljR/DjGQ7gAhpze5tdF
        HYfd7+cymkc/oNFGx8ZJK0+Ipi8eeoDm4Zm9A0dYjMxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MbCLtK
        +Ko5KselMLX35ztLWqzXdUel8YRNbzefJz1cE=; b=GVao7Y4Q1YQJNhGABYV89q
        jCV2sIMtGKRvvBxCT21m7bHOOnQzskd6CWOw6FfqyoRe+tnQRWxSfe0G8fDaAnhZ
        PFWo2JhLVaBPuWPujwmfOMGGN+4AO3a7hYUt4ATQyoldi2ZOn787HIBWDUDfn1x8
        /Sxk5sdIw3hK5KrwHE6iueTBhL9KVBAiYeXp38mvR18HNi+pQT3EJMs83C6BUgdV
        +5jKFEDeH/D+dWe/hPrQDC/qAJA3Z8MAjtg2QegB7O5IMIe4kSmxC+MjeKusxG7W
        HtAjzbw6c1OejplzK5C2OA66lGabLjWgjtJgM3Jk9BCDbNWtq1Zsqx6k2iPi+JKw
        ==
X-ME-Sender: <xms:1mxAYeRbQzROIlbqAwe0d1I_jzcGjHDg1v0ePSWdKUchSJ2UtmJrcQ>
    <xme:1mxAYTwUY3uAMm6y6K9rrTIv8-0gGomy-zR-MfBS-NCdZOLasjROM7e9wR3Kolmwu
    IhGBmAUIjPff5nTv3o>
X-ME-Received: <xmr:1mxAYb3dDTRwVRqCbEC_4zLa605WHhVVpm_Gc58Ep9MAh2VJUVr4lJyrgSrj6P0S_ie3DbdSu6Wd1iR_3IT0Jmg2u-ivRrVhVA43>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffotggggfesthhqredtredtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeetteeltddujefhffdtuefgudffleelleehjeeggeffuddvvdfgvdfhhfelgfet
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:1mxAYaCjPjQ5a5iAYPKaX0cnEDQTv_Nv3Yvg7-VA5kntoU9FQX2nZw>
    <xmx:1mxAYXgvcVnX_9Z_YqrFUV1xyi-weM8EAlf4_TuuFCjqlUpev88E9Q>
    <xmx:1mxAYWqiXRmV3P06_mUbS9z9dXGIMph7wFXf3_orgzacCBO--yBTqQ>
    <xmx:2GxAYXxoqhxpM_wLU4-CbiiHj0Fz1iQ1vAzEfSz86vE3gw2M-Y2hY27z8c0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 05:35:17 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 0/3] clk: Implement a clock request API
Date:   Tue, 14 Sep 2021 11:35:12 +0200
Message-Id: <20210914093515.260031-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
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
Changes from v1:=0D
  - Return NULL in clk_request_start if clk pointer is NULL=0D
  - Test for clk_req pointer in clk_request_done=0D
  - Add another user in vc4=0D
  - Rebased on top of v5.15-rc1=0D
=0D
Dom Cobley (1):=0D
  drm/vc4: hvs: Convert to the new clock request API=0D
=0D
Maxime Ripard (2):=0D
  clk: Introduce a clock request API=0D
  drm/vc4: hdmi: Convert to the new clock request API=0D
=0D
 drivers/clk/clk.c              | 126 +++++++++++++++++++++++++++++++++=0D
 drivers/gpu/drm/vc4/vc4_hdmi.c |  15 ++--=0D
 drivers/gpu/drm/vc4/vc4_hdmi.h |   3 +=0D
 drivers/gpu/drm/vc4/vc4_kms.c  |   5 +-=0D
 include/linux/clk.h            |   4 ++=0D
 5 files changed, 146 insertions(+), 7 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D
