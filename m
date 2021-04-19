Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6276363985
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhDSCxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:53:24 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35723 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232775AbhDSCxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:53:19 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A28CF22D9;
        Sun, 18 Apr 2021 22:52:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 18 Apr 2021 22:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=fknWd3je8bKB9
        0K09u49b0QN8C2hWKG3Vt+kDBR0zXE=; b=aDdWixQ7+0dBsYBrY1EbUBs1EeDKj
        kzXKTpy1ES8KlSB5eZWrf2uKe5oPEDDoAM86fTuz7xy+EhqMf4keKNjpsvQyFCFs
        OGt8Op0ZbDUCJBW7FM/95hPA44g4R22hpTcKi5/+QbltOo+AxvBjS8fLDEY8oJ2/
        /ie1bbCPz+N6eHpcb0AAlXAHuhhkOHHV6//wxYo2hQxFkYcXgf5tzYerJIGaUxlR
        29HH9CWLzeHSwwE3kJlEyYINzoizYFOPFU88MSXEgYqnuCZ9TgJZqGY96mArnzW7
        +HGasOaOS7jqma/lFDelY2F6hfCwPLuwKJMgUGOlcRu1ptO4/ro1B3inA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=fknWd3je8bKB90K09u49b0QN8C2hWKG3Vt+kDBR0zXE=; b=Uzkm73pX
        iCSwF8gZJDLUVkZFIbLS7QiSvKF493qM1NBpRIoftIEEGBykeuyuP1oggU05tq2c
        F2WWXj+GBL3WyG1WdX6imnIYu66vnBXdDfZ9ZqsLmpuKgIjFj/CJtXiJ1YUi2eC9
        t0b51LHZ0wrrw15Gv3QUvpSFoMtxDIUr6LFB4c37O/tP5RkMt5B98mGdlCEkei0d
        gOnfS1zOgiAzqFGX4v27S2/sNTqQVVFSStGYlVAQWBPKWvB3k/vnV4PmmpVjn9Vv
        LxbtDAkHrxj/gyYGlDxHHB/f3envEZM5BpCzPOhlCYMCCELXUt+8Peu3Zr9vU/qv
        8eCNOk4h/1I8eA==
X-ME-Sender: <xms:gPB8YAZaGb0xFc_KlLxBs6bbZBvztjAqQy-_FE44uABQplCJvHKPQw>
    <xme:gPB8YLbUKsQycVJ-Cs9f0VHt6hjw4TluJi-2wF-uibiDSv3QR8IJ8ugMO2jqfJjzU
    2HLmPYWaajXG2J1vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:gPB8YK9tgOScctT5rIFKU8eUdT5IpyU2EDR7tmMzxobP00jCCh_cPQ>
    <xmx:gPB8YKpZcdHWjv9Qmpw2_XoITJNVvzTyg_GrN_VDMN1MFEhRC3NInQ>
    <xmx:gPB8YLqtzVTM1b3MVZQsDbvo14c__gZdqWqoGuJ3mxMMS3JWLJ92eQ>
    <xmx:gfB8YMC6U_baTtVdleFAskL8Ercsi5ULcDzxqjY02EICeHC3M1Szdw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 17A8824005B;
        Sun, 18 Apr 2021 22:52:48 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] arm64: dts: allwinner: Enforce consistent MMC numbering
Date:   Sun, 18 Apr 2021 21:52:46 -0500
Message-Id: <20210419025246.21722-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419025246.21722-1-samuel@sholland.org>
References: <20210419025246.21722-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally, the sunxi-mmc device numbers matched the register address
order. However, that was broken by asynchronous probe, and now the MMC
device numbers are not deterministic. Add aliases to keep the device
numbers consistent between boots. Use the traditional order, since there
is no need to change it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 9b58cfbefa6d..3df70a41b3b9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -17,6 +17,12 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
+	};
+
 	chosen {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d8ebc1a84af9..4bdc48caf68a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -16,6 +16,12 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.26.3

