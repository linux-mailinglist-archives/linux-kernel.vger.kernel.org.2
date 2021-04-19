Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58631363984
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhDSCxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:53:22 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35159 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232753AbhDSCxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:53:19 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6B7A022D7;
        Sun, 18 Apr 2021 22:52:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 18 Apr 2021 22:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZeiZcL85HOddD
        F8hJ3Ac4p0YAseVuX3icv/oC5/libA=; b=IfXeLUQjI++WyB97XxMg0zD5FTPZn
        D6xGZ5sj0rLya0lZVJL/Fd6Ajkpq3aw5RqJm6ziqunFM6soRIHglbX1EXfu+97wZ
        hVbSC/xkcH47jy666emERnl2FpEFWU2Br9vSOPgpKVqfvFJbsQVQQ5qMmlZP/xyv
        udzLJ9SbHsPNay3By4txqQMwcwGReltxDGfGWw+sieU47aNvd5+yca125UCvqc+L
        78I+/Al/gyYmVIzZJ6/YBLqccTxpCTo7D+vL6vWoqFF9YL/qlR0nDfXFvlPkIE2v
        KyIMoPi/LgYYCmQ8lrwuTsE/Ctw0XjolpeKNKwI7PthKVn52LuVnoZ5bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZeiZcL85HOddDF8hJ3Ac4p0YAseVuX3icv/oC5/libA=; b=dH0P8swG
        /Y85HhFnNPwY2nsGvEXtm00dobqP2zNMefWyxFF17/tgdFO+dygS3mEiT5VO4U+M
        G2Lc5cfBw1pdPD20DZ/nDe/U3imq7H0J3qpjuPa15GhV/Lsn93q2bsGgl/KMhsVr
        8zLXB1HLrG6adwyjKb3yVhWk2S6QGA5i7xhGq10Jn5UpE7k4dMvKdxGjB2abwLdM
        THOFO9UA/Q+sP1A5J2fDx4rHPuvhNdf+ifiDRlyz4jf4aLSrg7UP1nkQ/qrZTit0
        6bkSXKjMdCdopuyN3HfvOc+Us9KUSVpqG6LUT7/GBbjw2sUA9Cev2S1ylGvgREbp
        7NDJ0GyRZzIObg==
X-ME-Sender: <xms:gPB8YLM1mbKPtmbEmlSDPepL7otu1piCrcXDVigfPQw6uBuHTlVJiw>
    <xme:gPB8YF_LdLRboq774Yc-jvVZKdRbyoJ8rcV0GwUxClueeqBdv05KJI8sufPx9rZ9T
    O1cNI0p7YNcAEqtgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:gPB8YKRJZpluYASKazA__KABjlCbCfZ8SCG4Kgrviohxb4yeclAz1A>
    <xmx:gPB8YPseypZ_-LNQuYTU8NeLMZsPzsTwnUwBqm7Ct5SKKYZ2QnZDUg>
    <xmx:gPB8YDd3jEFUTXbtqEM9xbW_WawDWiDxMI3moajkN1cQSKrwMpmwdg>
    <xmx:gfB8YEFPW76QIC7Sqi3eBs0l2WK5oq3Ee77p4Xha7leqVrTsjdwoPg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B02BC24005C;
        Sun, 18 Apr 2021 22:52:47 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] ARM: dts: sunxi: h3/h5: Enforce consistent MMC numbering
Date:   Sun, 18 Apr 2021 21:52:45 -0500
Message-Id: <20210419025246.21722-2-samuel@sholland.org>
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
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index e27399aa052c..1cb669c835bd 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -53,6 +53,12 @@ / {
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
-- 
2.26.3

