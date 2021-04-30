Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E636F4B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhD3D76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:59:58 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60809 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhD3D7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:59:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 809F6580991;
        Thu, 29 Apr 2021 23:59:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Apr 2021 23:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=pw3UViUjMVgmZ
        bCu3Ja0rB/pgHOsIsfcqpXmNDlOmSI=; b=a5VCO5oHhRMhi9ChsSAySrkudBfSd
        0eOPTSTDwyEILVhDRxNt9KwGQI9bzarLWMiU2LJGzUBHuUmJGQ2JBv7MXmQpNx15
        TnGflFX4XTBeQOWSXsuJvQbkddwCW98iveBdn1bcCsJJfia9zXkbD0SXSs4MBly1
        2YAXyYiphU6nn4it7+ZIbf5F+YurYl+KKpToeVjhtH8YFRFkB8l1Oa44pE/K2lOj
        sWXPRIYr5PnaRn8MBcijTblGiCv85WFZhBpsGKjg4MqDmk8SgfxlyW9C5Dh6o8JL
        KzxLfYK3T2KzO5rfnwnr+TAp1U+8TzOK90eeHbLP70H06g6GUdhf7jKOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=pw3UViUjMVgmZbCu3Ja0rB/pgHOsIsfcqpXmNDlOmSI=; b=a3t3wL6L
        TSTdfVhubUu+hKlDxFV6KYcsDtsalT2NJOpsOvwGiTDHvDzZNXlww1gXFP2AZ3Pb
        SNEOg2ZwOXek1JkcqMYKdk4tZmahQYNrja8uw8Jj13Pg+8h8UkNt67LhRHjNOGng
        5uxN1cX2GkSsGpEOSilhZPf23TLD4lDvbFEjkVRNgGB/j/ipVrrd5iS/3ntekM8x
        V27x8tl41lOd2HqJjnYIb1VE/F64ng/mdUnhDNIAot/mf7Dkn2BNb/ymWma68zeh
        131aeEXxiyugWYeLdeGoo67wRfcu8i6BUpJKmbOo60XpjnLwTz/kyjp6683HUEmm
        BQrkkoKZCf2bxg==
X-ME-Sender: <xms:iYCLYHayzEGFDqL4O3hjhxbCXN8q6czJK6eLIhTffnjo6isyAeyFHg>
    <xme:iYCLYGYcPA1ek0OCP0xDDHZXcu09z4cyzFPUTjWCAGVSdu0wEQSvwuZPsWib5lRyu
    1gO94nf67yLiirZMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:iYCLYJ8ThD3C2MteHxqF8Jz3aU4Cg7bOsawyOJ5TDB9Dxo0V3Y2Gmw>
    <xmx:iYCLYNqgVBioghOvaVmPYXTmIQ5m4BsqWQ9ipa0xcRwzkaBHmI3M3A>
    <xmx:iYCLYCodyPUIXMhOWshNPe0DQn8Nk4mpxATKfJFRoF-OLUQLzZi_OA>
    <xmx:iYCLYB2sm5ZMAo3FIhIHY5XrdXGMLYztKyR0s2F5AH0ZrTaCywqSAw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 23:59:04 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 4/7] arm64: dts: allwinner: a64: Add pinmux nodes for AIF2/AIF3
Date:   Thu, 29 Apr 2021 22:58:56 -0500
Message-Id: <20210430035859.3487-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430035859.3487-1-samuel@sholland.org>
References: <20210430035859.3487-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the sun8i-codec driver supports AIF2 and AIF3, boards can use
them in DAI links. Add the necessary pinmux nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 3061031780de..a583355a3128 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -658,6 +658,18 @@ pio: pinctrl@1c20800 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			aif2_pins: aif2-pins {
+				pins = "PB4", "PB5", "PB6", "PB7";
+				function = "aif2";
+			};
+
+			/omit-if-no-ref/
+			aif3_pins: aif3-pins {
+				pins = "PG10", "PG11", "PG12", "PG13";
+				function = "aif3";
+			};
+
 			csi_pins: csi-pins {
 				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
 				       "PE7", "PE8", "PE9", "PE10", "PE11";
-- 
2.26.3

