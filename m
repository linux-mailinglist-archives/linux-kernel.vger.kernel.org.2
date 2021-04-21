Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF036648E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 06:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhDUE3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 00:29:16 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60857 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232146AbhDUE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 00:29:10 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 208A9580E36;
        Wed, 21 Apr 2021 00:28:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Apr 2021 00:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=YXnwjaQf4TTDuRmPezz8p5W4Jg
        qo7LkSPHQCWgY88+M=; b=YLEYDOnSCY6uJsLXSQ1JmuVG3Rzr6SOCgxRZkoWcjZ
        eKEbd0oUunvLRN3plY3ecTweyhZIjOVKXDoXvasqSMM+mKMZcxf78gcXBIRFUWbH
        aj1Rv/nWsFhF/Pqu0ViG8Yg9L3VikT9o5pJ7b7qIxxSojIx4gOQmffuqYn1I31mS
        jpC7946qWIdiwcSgSB8XSBEdxLVBG+6MmVNbXgrn+0VI9c6efMg7XQHUfp/DU3J3
        0d+7GrQnt+lZptomaQ32Dcg4e1JUutxUpNjcKCB6bAXE1rQ6g2tSYik0DJiDak5k
        n90tdtf5Tg5BRGQp7Y4cHGwkfGsb6egSx39bV3epCu7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YXnwjaQf4TTDuRmPe
        zz8p5W4Jgqo7LkSPHQCWgY88+M=; b=IQQMKATz/C5peZqJUjIwgisq89Je0gnVq
        MB8u3OKT0EePtYp+RDv6vpHXwSU5O+KoKolpLs9OhSizsUEOdx2YVklXSQpTgeQ5
        tm6Ewq0K+QJn3SxJKzryMZ4qjWq6KROi/pDOO1sYgNeng/xs8IYlBnjFNQrkBiEX
        YPxPMuJF7xzOYN4pTIIdemFviBKYrAzh6o9uzQzVzRMEEfdFovp5EKQ9rySys+ZH
        5mLbDu5hk7pZyTupbQTv2nvzu8DLhcqRbAAIY36lpg7gfRJ2G/sdSvXYl8lfSzOq
        ZpAUmfz5HLVIBHVOwr1cuBICOnK0s3ezy1L017gLRrS+Z4nu43TpQ==
X-ME-Sender: <xms:9Kl_YFzUQHsh5scW-mQlJawaUUTbLMlZMus9uUPm0odRRAl1mk1cKg>
    <xme:9Kl_YFQvK46b8vZNqkZwBx0WoESPk0cgc4Xy384q6ALzscks2PblDKBcNxO7q36hU
    CEbaW3zBPHoEa4RNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:9Kl_YPX2uMXYxfVK98bPgeI4FXSptLgYEyAcjTlJbjChFLV6Lj4BIA>
    <xmx:9Kl_YHiwYMLnzNxBBceFQLHD7LSa7yQdo50DspMsNlga4NJokfL05A>
    <xmx:9Kl_YHC3mpw6mhXHOfBKMCPvKeD0EHMowrlWNJzRoxnueAc5X7hqQQ>
    <xmx:9ql_YL2Gl6Q91ZHp5rMkpvJSkTMQOMIBz5yYvJJAm3ptI1___MA_TQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9AB9D24005A;
        Wed, 21 Apr 2021 00:28:35 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/2] Allwinner H6 USB3 device tree updates
Date:   Tue, 20 Apr 2021 23:28:32 -0500
Message-Id: <20210421042834.27309-1-samuel@sholland.org>
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

Samuel Holland (2):
  dt-bindings: usb: Document the Allwinner H6 DWC3 glue
  arm64: dts: allwinner: h6: Wrap DWC3 and PHY in glue layer

 .../usb/allwinner,sun50i-h6-dwc3.yaml         | 75 +++++++++++++++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  6 +-
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  6 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  9 +--
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  6 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 60 ++++++++-------
 6 files changed, 115 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml

-- 
2.26.3

