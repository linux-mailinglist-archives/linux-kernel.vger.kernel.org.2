Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6940B36F4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhD3EAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:00:06 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50471 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhD3D7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:59:55 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 70A4258098B;
        Thu, 29 Apr 2021 23:59:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Apr 2021 23:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=bZ5Jq/1+ZthwK
        TvuIq15eH/CIV4N1NBK/xFYSqK20FA=; b=Xwz5L2eWhQfh9qWryMixZTGZUdZ/o
        AGvrmkXe4K4YnKORZBkoH7+V0ID0bBnqmGYsW+qDt125V2ffHDqyUsjYOnGNFgVe
        rljCEEgfDZdv2w1JxG8IC9Pyv6gV7zydAN9EpwwagqpwK1NWEU2PpyvJxvtPhpyu
        MKmi/RW6ARObfgn/guPWgfh3BYOw+8X45s0vzVECdBfwxXtZ/7cs81p0zYjT2w8q
        JQh10HhthUdcxdU4JND7TzsRcUvJJwfvtpABUQTG1mtB0ws2cQN9OiS7zD97vQjs
        kYwmTvoKkCCrW/hlJOA1wYCkLmZi9a5j71qMNn+LEpHWfjKDKXCO6o8JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=bZ5Jq/1+ZthwKTvuIq15eH/CIV4N1NBK/xFYSqK20FA=; b=eLXcISbW
        lqCxdLxiK35V7QEUswLanJaWpAts4+9v+C9YhiWuVa6K+6f0h3QEMQQXXD2CUuka
        qupXy9+9naEkHfAM61ib6Bzj9c8gR84FXEjoX2VMvsYq3uLgZMfIThPMf95f7786
        HJFn3bwtwtq7EP3saeyqFVn4x2b6R0zjCtQ0A3ZmGdNyy/OQKchdn4VXeE3RArhX
        WBVcRIAZa0bSIFbd14l2WXjXcSHtXZYZ1ONarTYSVuVOYUIYf27eYuhpaMzYdN4q
        4dnxu76YaKS5QLsr92EgGDuEDfIxAUA3XR+Hoa6/1j10P8E88mm9c9WGpLeVRK3z
        TgazJ3g/4CEtAw==
X-ME-Sender: <xms:ioCLYBtDIL-CzTkiCnXpubSfs9V5wVgPo2rp-nFz-zl_a94y9l90tA>
    <xme:ioCLYKfw4Ovz3sJ8P-iGg5wEtwI2flECUQX7-Iw9VnX0UiuBXq6zQNrna8x04Mw8F
    wEw8IhuiHOk4Nz0-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:ioCLYEzZUCreVqubBWe-m2CPEX39QTJQPqOJhkB_qTLYXD8uqNeVfA>
    <xmx:ioCLYIM5miYotec4ZLSG3O6obBHYQS3LFajdOXZ7VA9A7wIsv_4aKg>
    <xmx:ioCLYB_zXdqpP4LK9VFXPL0CL8R0OYgAR_KpV2XvSlZtDO_sPrOyzg>
    <xmx:i4CLYAbBDE5SiXHTqYUCRWhVeYLeripbCiuChjUL5AX-qnIJndKGag>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 23:59:06 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 6/7] arm64: dts: allwinner: pinephone: Add support for Bluetooth audio
Date:   Thu, 29 Apr 2021 22:58:58 -0500
Message-Id: <20210430035859.3487-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430035859.3487-1-samuel@sholland.org>
References: <20210430035859.3487-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PinePhone has a Bluetooth chip with its PCM interface connected to
AIF3. Add the DAI link so headeset audio can be routed in hardware.

Even though the link is 16 bit PCM, configuring the link a 32-bit slot
is required for compatibility with AIF2, which also uses a 32-bit slot,
and which shares clock dividers with AIF3. Using equal clock frequencies
allows the modem and headset to be used at the same time.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 9f69d489a81d..51cbfdc12936 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -25,6 +25,11 @@ backlight: backlight {
 		/* Backlight configuration differs per PinePhone revision. */
 	};
 
+	bt_sco_codec: bt-sco-codec {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -91,6 +96,8 @@ vibrator {
 };
 
 &codec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&aif3_pins>;
 	status = "okay";
 };
 
@@ -447,6 +454,23 @@ &sound {
 			"MIC1", "Internal Microphone",
 			"Headset Microphone", "HBIAS",
 			"MIC2", "Headset Microphone";
+
+	simple-audio-card,dai-link@2 {
+		format = "dsp_a";
+		frame-master = <&link2_codec>;
+		bitclock-master = <&link2_codec>;
+		bitclock-inversion;
+
+		link2_cpu: cpu {
+			sound-dai = <&bt_sco_codec 0>;
+		};
+
+		link2_codec: codec {
+			sound-dai = <&codec 2>;
+			dai-tdm-slot-num = <1>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
 };
 
 &uart0 {
-- 
2.26.3

