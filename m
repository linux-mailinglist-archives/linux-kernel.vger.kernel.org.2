Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539593A0ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhFIIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:41:15 -0400
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:48540 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhFIIlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:41:13 -0400
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 89BDF201A7;
        Wed,  9 Jun 2021 08:39:18 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.155])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 9DA13200FE;
        Wed,  9 Jun 2021 08:39:15 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 98D462000B;
        Wed,  9 Jun 2021 08:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id D7B692A0D2;
        Wed,  9 Jun 2021 04:39:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1623227951;
        bh=rmytQxnOpk4vxyV/FzXpiVZ2jb/LlTJDTmb0VH8OGXY=;
        h=From:To:Cc:Subject:Date:From;
        b=BRidAcX7tQtSncIO+5ONUE2I7NZV3XsQ/DD0AijcGygfauFb+9xw/+9/4Z9zlxRn2
         zgiXbfJQsAsfn5D7yVlYakSx2Mssx4qeCw/HNryNVSxxiK3AcXKtqYr4BJpfSW2jBP
         4Hs53VtMs/CKw5tvzTw3T1FiLO5ZMsvvkIr+QhKI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ap29_pKn5cYR; Wed,  9 Jun 2021 04:39:11 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Wed,  9 Jun 2021 04:39:11 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 8B48340CA4;
        Wed,  9 Jun 2021 08:39:09 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="HFRQbTFC";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.75])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id ED7CC42655;
        Wed,  9 Jun 2021 08:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1623227939; bh=rmytQxnOpk4vxyV/FzXpiVZ2jb/LlTJDTmb0VH8OGXY=;
        h=From:To:Cc:Subject:Date:From;
        b=HFRQbTFC6S0hSLpNIKwHFT/LlhlJcCp4hUqDL2fYbGl734BHB5Ibpz6fMZqXLmpoA
         x+l6CFkOKxALmsuujoIuv+BGZS6yLpsH3jCzJs9yyCfceU5fUIsf3sI6vfJHHsFihi
         QHSYfVLTw7urpF7q/ZviejElG09GuAC+wZLOm/tk=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] arm64: dts: allwinner: a64-sopine-baseboard: change RGMII mode to TXID
Date:   Wed,  9 Jun 2021 16:38:43 +0800
Message-Id: <20210609083843.463750-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         FREEMAIL_TO(0.00)[kernel.org,csie.org,gmail.com,gmx.de];
         RCVD_NO_TLS_LAST(0.10)[];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.75:received];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         MID_CONTAINS_FROM(1.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 8B48340CA4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the schematics of Pine A64-LTS and SoPine Baseboard shows both
the RX and TX internal delay are enabled, they're using the same broken
RTL8211E chip batch with Pine A64+, so they should use TXID instead, not
ID.

In addition, by checking the real components soldered on both a SoPine
Baseboard and a Pine A64-LTS, RX delay is not enabled (GR69 soldered and
GR70 NC) despite the schematics says it's enabled. It's a common
situation for Pine64 boards that the NC information on schematics is not
the same with the board.

So the RGMII delay mode should be TXID on these boards.

Fixes: c2b111e59a7b ("arm64: dts: allwinner: A64 Sopine: phy-mode rgmii-id")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index e22b94c83647..5e66ce1a334f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -79,7 +79,7 @@ &ehci1 {
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii-txid";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_dc1sw>;
 	status = "okay";
-- 
2.30.2
