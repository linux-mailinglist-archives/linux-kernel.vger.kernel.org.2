Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0D36F463
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhD3DUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:20:11 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45429 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhD3DUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:20:03 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id DD4CA5809A7;
        Thu, 29 Apr 2021 23:19:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 29 Apr 2021 23:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=7a3B4rcYlKzes6Q1o/O33ZK9lp
        KHHVnQxsvgMFUEdxc=; b=B5qp+eO0DskdaIxSYZIKB/GwTM8+gaEYMI2eWpmXFQ
        XKh623relchjKSnt/H/q5WHOk4YdrumJ/YK4/nwdhFZuh9yCb04gxZynuA95wntG
        B/kjQwfvIZ1EOmKzSyL7wDaEioelOj5BrX05LQp1t5Pm0phEkvx+TCG2kf0hORcI
        UmtRxIYgn8MDCFVb+PT9nDVzxGJhrKQZ1q72QsQX63V9eG5Bj/iZ5vwNurRUoiY7
        YYhM04mVRSA2CNbp59eudQk0rWZeTCBz6xpQQFmKThbHVatvephk+jc5Os091vwg
        1n74ISYJAU8ylSoZiFaoHEQRJwsV3YjBfFI5tkrLkXsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7a3B4rcYlKzes6Q1o
        /O33ZK9lpKHHVnQxsvgMFUEdxc=; b=imaUocYJKYptSmtmViFFsmMU1+4FKRnjB
        YD0Y1wlVeW77YNI5RKLpJFVVN9DmDzS8rWs7bLzseLqhwgrYVDDTyDR1ypvt5lui
        n+aNrrhzLkaYastnN2lqFpeH8+mn8HBgPvwJpXAtAECF+UB0CRWBi39qjWuVR8Jh
        cnTCEiyTVjeSROtFuN6DAhH80u/d0GXD0yZn7R8zR7HH6cINi5sLgrWrbjbshRY7
        s+1pVvcCxR5nSlurxtSt11Z0YAXrpRmEvt3bIO8shWA3ZTaDXRWlA5DEdC5CXTI9
        lL25HSxN3bFULeFZjGfKC+D1wEA8+KxghfWDefX7kLmdmdNkDDAAg==
X-ME-Sender: <xms:MneLYB6hHTawAtddmHnvxlCxcYUpQmVPfXkrfIz9vDlEx1NXueNKNQ>
    <xme:MneLYO6p_HwnnZGopI4Y9N32wYXAQ4e3otZ8M9vgYtdcowBuaURpiF897x6qXhoC1
    Rl4Dy0lVTRAk4_lMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:MneLYIeGCDtqjOJfRqJKFq0mpnHvcjJVE8nFcZ5OL3wTnJ_xjJmYLw>
    <xmx:MneLYKL91SYbwWwMEcXDdguCEk0_fqyrz955zQzVIIU2w9qJ0jHG5g>
    <xmx:MneLYFJOmFTYxRP7cKcQrNoC_Cyzf-K2Pswc6vxiwIzBtUjbv2_eGA>
    <xmx:MneLYOXKzVJekHmPMeU0ThoQFXVwdhtjRWu_C0SsVJ8RtX4jxujggA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 23:19:13 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/2] Allwinner H6 USB3 device tree updates
Date:   Thu, 29 Apr 2021 22:19:10 -0500
Message-Id: <20210430031912.42252-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While implementing support for this USB controller in U-Boot, I noticed
that the reset line alsp affects they PHY. It looks like most platforms
use a separate glue node to represent this, and in fact there is already
a compatible for the H6 listed in drivers/usb/dwc3/dwc3-of-simple.c.

Since this layout matches the usual way of modeling this hardware, it
allows using the existing drivers without adding platform-specific code.


I tried to follow the existing DWC3 glue bindings (most of which are
still .txt). With this version, `make dt_binding_check` still raises a
couple of issues, which I do not know how best to fix:

  - Warning (unit_address_vs_reg): /example-0/usb@5200000: node has a
    unit name, but no reg or ranges property
    => Since there is no MMIO translation, an empty `ranges;` seemed
       appropriate, but it causes this warning.

  - usb@5200000: usb@5200000:phy-names:0: 'usb2-phy' was expected
    => This may be an issue with the snps,dwc3 binding, where the
       `items` list overrides `minItems`. I believe the intention is
       that both PHY references are optional. This implementation has
       only one PHY.

Changes from v1 to v2:
  - Updated the binding to reference the PHY binding by path correctly
  - Dropped DT updates for Pine H64

Samuel Holland (2):
  dt-bindings: usb: Document the Allwinner H6 DWC3 glue
  arm64: dts: allwinner: h6: Wrap DWC3 and PHY in glue layer

 .../usb/allwinner,sun50i-h6-dwc3.yaml         | 75 +++++++++++++++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  6 +-
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  6 +-
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  6 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 60 ++++++++-------
 5 files changed, 111 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml

-- 
2.26.3

