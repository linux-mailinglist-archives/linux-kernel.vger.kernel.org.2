Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01BA3F499B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhHWLWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:22:20 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:53892
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235077AbhHWLWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCC+9npCFy17JTnOhPp+jZULvmKgzo6kUJHFp5VcmDizuSsAhIhRIrI60s1q+W4FmPcydzU+2p4MGSQEpXkEuk7PbgPJIHFvaWX3fcVogPCADf1hsGVy/pKl0qeKCCcp6a+s6dHsIyOeR/sAJtwKspi45Rl0XO1XpuoH/LD/Nyufa4gc5S9lQ4hQ73fhGnrN0yWZm097TWi3rAHTiMOUI/pZPS5bYxVLEKW6ecn5pXs902kxZzdxEEOaCZvf8MGltI5oysaSLiE3NQqE/vns8Ff6Uyi4nPZ/NzzDNro49fgcTPdCPMpnOcMy83do4MMkbEVojoPnR6RysToYTG0Etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR9fb/y/SwBDL9xh0ayjptgcvGABEIum6YT1hk1HTD0=;
 b=I94QSvlt1mUKr8fzUY5+rs3fDLOI8Qaxr9ZX+NwD5+bgaDd7doimigdc09+h7NdKMnELK2QOZBUFvVjwGlE5Spkbn/aTwlAs6n7MPxPlOCn0xrCQ1DxPHn+QYX1CdftTSC8yZf0OukqlHn0U/1eNvhZqlzy5gE8qIM5/QRJlmSSIG5jAI76/Ytka6eEBejbFHHHfNdtVlLiLtqj2tPwgs7sG+Xr6DAN0ISxVmYStSwX5q52EJPHwhTt37PqXGWyIW5dvvTSUl+hBdl3Q2JuQ14+e4/XX30iu/RlhfyAwFTtPEslXEKYAreSGA4JmCmysEJ0CyrtSTvIZ7rUWAwCDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 91.118.163.37) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=wvls01.wolfvision.net; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=wolfvision.net; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR9fb/y/SwBDL9xh0ayjptgcvGABEIum6YT1hk1HTD0=;
 b=BOW061vVdvxPXhf3pTtZ4QjArotzTXGs5ze8IDSLEO+v51IimgEHhdLjQ0M3Qb2C+m05Y3mIT7lnYGRppT0+I1ZstXuE/a3HuccoSFwBI4C0kDZz+P5h3qUWoMc9LFfxx6W8Rkt96DhGy73wXxPV/ltHv8t9wXRgi4wSrJ5Qewg=
Received: from DB9PR02CA0012.eurprd02.prod.outlook.com (2603:10a6:10:1d9::17)
 by AM6PR08MB3656.eurprd08.prod.outlook.com (2603:10a6:20b:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 11:21:29 +0000
Received: from DB3EUR04FT021.eop-eur04.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::f) by DB9PR02CA0012.outlook.office365.com
 (2603:10a6:10:1d9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 11:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 91.118.163.37)
 smtp.mailfrom=wvls01.wolfvision.net; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=quarantine
 header.from=wolfvision.net;
Received-SPF: None (protection.outlook.com: wvls01.wolfvision.net does not
 designate permitted sender hosts)
Received: from wvls01.wolfvision.net (91.118.163.37) by
 DB3EUR04FT021.mail.protection.outlook.com (10.152.25.28) with Microsoft SMTP
 Server id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 11:21:28
 +0000
Received: by wvls01.wolfvision.net (Postfix, from userid 1000)
        id 057C24A4800; Mon, 23 Aug 2021 13:04:27 +0200 (CEST)
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH] arm64: dts: rockchip: add saradc to rk3568-evb1-v10
Date:   Mon, 23 Aug 2021 13:04:24 +0200
Message-Id: <20210823110424.3592528-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6871356a-ae42-48c8-5e5f-08d966282714
X-MS-TrafficTypeDiagnostic: AM6PR08MB3656:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3656D9ADBB9F89673ECCB2DCEBC49@AM6PR08MB3656.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJNN5bKMjfiZQPtfjOUSNSt38M7ajPRSheNpNMoLmc2CPMp1jPx8Klp3IayCYT7/gXXyy5d5upxXmRRfHPpDB+u5lJyEDcWdfAbU87Ez5y+qXR7s5OmmoeSmDUzgwhJLkqXX7flhWQ0SLaF1OeJhDiJWBpagsIbvBjMTIxXKoU51vVV0xdz5iEfp+Ea+vTOctEzoKqeBvZ+Il4Oi+x9pEunEFfvxqyobBXBNyDf9fN6vmVquMnl9vjo3LMvayZe/jOm7c/CnnNyHY1F8tWXWOqy7L+A32JK/N1Cx2hJfc9FDx3rv6K0bM2rWjMJaEvtJjyX0piSt4czYYX7LUSKBbzaG8TV/OTY2jmfaxSq7fSAgH3UaUH9wGGPcOGacCPvImHdi2P6l3fh+KDL5HmR6OGT8MAe7LbS8tZ1qHyT5CVa2xIdaEmcEgskklq7la8UznOYkNmYtOtmhnoVS1yUuHXOAVcDhHJd2nSfkiVnYOe5HjNfvMnyXjjqce/sDk6PfzWK2oKmoYbYuQUq/guLwgwKu/lESg2cQ6JHEUZwytxKBPVWBBwQ6xB0P/PGYovKZ+KdY7Lbltps3oteAH/2ZlQ+f3rnZF5hDFXrl2ywCcTaEcvH6WzccHbBrRlu3QIvfjFEtj3tiGl/SPN6tYa5bvG/3q4NgEcP2wKW0HSSpENYLk+EeruQHIwjG9EUIYcVyU1wl3VzXau5blimPTdNCf9Itb02ksdPVJRPfTokLbRQ=
X-Forefront-Antispam-Report: CIP:91.118.163.37;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wvls01.wolfvision.net;PTR:91-118-163-37.static.upcbusiness.at;CAT:NONE;SFS:(4636009)(46966006)(4326008)(83170400001)(82310400003)(107886003)(35950700001)(450100002)(426003)(54906003)(42186006)(356005)(36756003)(70206006)(70586007)(2616005)(316002)(5660300002)(1076003)(6666004)(508600001)(2906002)(44832011)(47076005)(8676002)(4744005)(6266002)(336012)(26005)(8936002)(81166007)(14776007)(75936004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 11:21:28.8737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6871356a-ae42-48c8-5e5f-08d966282714
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e94ec9da-9183-471e-83b3-51baa8eb804f;Ip=[91.118.163.37];Helo=[wvls01.wolfvision.net]
X-MS-Exchange-CrossTenant-AuthSource: DB3EUR04FT021.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3656
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SARADC to the device tree of the RK3568 EVB1.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 1bc79e95b2fb..184e2aa2416a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -360,6 +360,11 @@
 	status = "okay";
 };
 
+&saradc {
+	vref-supply = <&vcca_1v8>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.17.1

