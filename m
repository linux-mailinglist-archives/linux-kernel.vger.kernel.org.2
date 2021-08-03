Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DA73DF50F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbhHCSy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:54:28 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:5700
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239315AbhHCSyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chZepgixZjoxjJ13lEaFC0oJB/5Kg6OrGXUk5FC00hQB7TGbrY8abGCsPuibaZbdgHtpHjIUSTsxHaoW33T3B8BiUvFcvL4qlaBcu46Gd2I5tVv1hG9jdb9Rs3FG3N0VovBVAt9TjvYOdCsJ6dP6dPxGCX5pCjIilTpKDEes4+PIIOlWoYmUwGf0pK8ts6MrZi2XGCBd4AWPlUUf7Y//yAgpk902anLQ9C+v7kSwbrBDWGYnu4pbYN9j7DoS/HT3F73rbZ357j2q2Xh1g3n6ahxpeWzOdoR5Kdj3tWHFMz+AQj/AqtCp89easnEeUnexUvKOajXAaZF1BKJMWZV4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VjrhhYpJhbbG5YbCZ4pDMiWvrs3N3FoKI4l9KWjp1w=;
 b=I5B1I9ps5OOUvDuM2/vNf4bWB7jUCru+CX1kmU7XcSYNYucn1glhytdeUaATXGCSEyo7pi7unZP7yWMt7DSaYKd5tGPNywAITnLJQnLv5d70xfJ3khDcuFHbDEku6Zasw4WBnBymBBTUn/yTecQ1I1NF5qE3cD9VM6fL3lrNP0oSe/iyxk1y6FSIjPEq0wDA4Ug3PLAb0c2o8Hg39LIEvj3eZmRXRNLO9zbS2q/a7uMiDV5Yr39h+w/fbYLHLWRFeP6O6Od5zRJ0JXEQSZOeISIw724kB65uggX3pidvgVmc1aiMsY9KdX/VSKREaradZGwMgKkph6NNPhDG/jSN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VjrhhYpJhbbG5YbCZ4pDMiWvrs3N3FoKI4l9KWjp1w=;
 b=OKud7p12xD6Cr+M7n1p9Wmc28RpcPvb9e1JkVWCs9k4xL7XDrplCg4r3B87Hs6bGcAGcghVxuSnW2Gcto+nmND3oIjO9xKQRh5CtppBT+NEVbmmOngYQPvg8H0ERi0XD+fs5s2tlGnElGWGWzrBI/CFXySNAB6KtSER1NyRUf80=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB9PR08MB6921.eurprd08.prod.outlook.com (2603:10a6:10:2a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.24; Tue, 3 Aug
 2021 18:54:10 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 18:54:10 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 4/5] arm64: dts: rockchip: rk3568-evb1-v10: add pinctrl and alias to emmc node
Date:   Tue,  3 Aug 2021 20:53:08 +0200
Message-Id: <20210803185309.10013-5-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803185309.10013-1-michael.riesch@wolfvision.net>
References: <20210803185309.10013-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P192CA0019.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::24) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by PR3P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend Transport; Tue, 3 Aug 2021 18:54:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71729179-5eeb-439c-e823-08d956b01407
X-MS-TrafficTypeDiagnostic: DB9PR08MB6921:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR08MB6921D19ACD21ADE9D781F796F2F09@DB9PR08MB6921.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piEp8Ny4xLwaG4IVLpkoW5c4GOoaggjl3rtZ4LJgpskp6pbdchyZMS+iRgf+I6eO7BIaeImz0EJlNKmyhv5kF6XweY4vcaxvEE51A9WOZjh5PoUaUTDT6jzwNbT41lGRJ9bRkrhSYIQsgXgZhbKHTZeYPPHq6b3KW1EN6smY8maliGDyr677SS7N0wK79KJcm8YnhFfTMjHznR5S6/4Na4i1EqT3gIgT5ig1uDWWxuhRemkJC0xm4R45dkoT0VtlXSrKerpP7QoM2TPnHGSL7CE603ysaIAssID9FBvf7wnE81TknZ5Wjvb08q9DOwwMzJ6l49MJ92NkysGSnxyMTiGGMIEX2MGEY6Ix7n24oEvadQoVcAcVSQ0PnkTGm6VP58Q70yGP5KEPLgZCNvzgqTcBlreso62dUgCsrB7drJrx1kfKZDHrTzPT8hxCj2aIasSqoWWzlpEnNJNOXY2k+Z6u9IberoX9Msu007IcSLIW9z3Kek5X4z+FfT7+hTMkWwmsCAfOxIyWoQnVbqAeR4kPIP61uFSv1zGuuOoqsgmoZ74lgpAR0DLsFSRgiGbWHMtxKjPI3lA9SGbk1b6Iw9xDFbIEdOhDl5KdLgYti86x654EsKImz3rzXwhO43zh+a3nXZ2OF9m0o79DGtGPIeW91V6/1qpO8/Um8WcVqqvoPul4I6aFGny+vm3YKFfuxM5UNUxcqyqROYiMW1qHUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(346002)(396003)(136003)(376002)(478600001)(52116002)(2616005)(956004)(54906003)(86362001)(66946007)(66556008)(66476007)(316002)(7416002)(2906002)(6512007)(44832011)(6506007)(4744005)(8936002)(186003)(8676002)(36756003)(26005)(4326008)(1076003)(38100700002)(38350700002)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HsLBmDwGdFB9lYl2CWPCBS1yv6mGhn3oB1ZnmUGXWJhwIzW/FCN893lq+Zmx?=
 =?us-ascii?Q?gQ4/I/Mq5DSbgHnetNKPT8rZcA4XQsPE9RrpvoKWLuPIATPwwcLUOJCuvSE6?=
 =?us-ascii?Q?LR5oiodn/qc2nxwO19Qv5D0JxfXWFIg/MpCZfmNS+t+4N5AtrTrh7x/NNg3z?=
 =?us-ascii?Q?JhMSqRDCrtYmdJl4PAUfDK9wEIZ9dKfxYHm6c1eQ+Zcu1ikrwcC5Priqdhcq?=
 =?us-ascii?Q?3PR9J1GdprJ9XnrzSenRPuemHxwp8OT9OOBcXeczZLAcN3RaE51/Cqn6W+3W?=
 =?us-ascii?Q?kX06XurBKNtT3bBi4IKIC+CkC1m2j3pkAkALQoTOpeQ+cj5fbgw5fMzdqfz5?=
 =?us-ascii?Q?udOf8B+x6upR5IfAKlkKSGBL3LuUFkyCW0xNvFf/3L0QObHOLfxyCwMAs8cD?=
 =?us-ascii?Q?YOnv3/YE/qtL85w7DDUyeM25xASjE7bnEqyE6vum5CSpC5N39BASNY2TMYHb?=
 =?us-ascii?Q?PhhMF/SLEKg66FmNhI/05OohBoIM3fZuk+ABUhHBatCgnl+w/nXguVDhH/4M?=
 =?us-ascii?Q?z+45HsjSx31GLwmnlFAp6B+CzHTv3sdEmZ9ZKjI8qi3AAXqzftjoLKIf144z?=
 =?us-ascii?Q?fql3MuQkgTkQzvhYBrUmTJzd3C+uANbH6R1m0zKjeDJU7k7nVWQmzcTsLDqA?=
 =?us-ascii?Q?SbXBsTQdrm0yVzkTvfEXX50R97R3ZGZ0Vxb0x634nBoiRoToVdGuj5Xngf1+?=
 =?us-ascii?Q?PjbI8R0FPCSJeiycp/g9wzfd0i3RgdqHd+AALSOMFy+0rYdbDzj9Pg0UDUM6?=
 =?us-ascii?Q?UdNbns8RxdEs98h/lhJwUstZ6yP/sXgBR/L/zokl+vxGCf96wAdbSlt8iKxj?=
 =?us-ascii?Q?ETKY9GakP78na7JWadteSK7/5OV3q8/Zd5MRbmQ/KYKgtaIRqykovskfUBwM?=
 =?us-ascii?Q?vWq5+v/rFM4mnWEGPtubxP5q8A+JxQeQ4guq+ocJhYoYtJnzfQdtwR1MmHf0?=
 =?us-ascii?Q?UVQniVS+UAhslkW739XNdlNoG2B5PYoFT5Q75Db+b6AK3vZCXEwcDRaVCvw/?=
 =?us-ascii?Q?ky8jM9EvrYc//vNiQS6nDE6SvTplMCdOTuzqGHYZUUr8z46jtiqkRLZU3oJI?=
 =?us-ascii?Q?aGWmbsTf0oUqas1A7YK9n/mzreDJHzbO6tjbks883P40IPAwl/21WPIPWKUP?=
 =?us-ascii?Q?MYBUbSYjWiIc7AKD1XwSHwrbN91xtvy5Uzs96BTD6IaDM40w24wmwjkrS7Aj?=
 =?us-ascii?Q?1MJTUlkKt3Ihfv+Atg/qwRT+OtXWFSdrjX4l+Vb+ith33giQQySxSGY7VqA5?=
 =?us-ascii?Q?sGnhUSMiioZDNah4Qv1TAETAiB2ArjWxxaL8LWxUz4cE0u2RyohlCb8Tfjq6?=
 =?us-ascii?Q?x+KWqldG0O0KEUbzLBiQkJDO?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 71729179-5eeb-439c-e823-08d956b01407
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:54:10.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUrJWJ6BKpu2ZbrxnMtq1EWQ4WMHPDr6AnWmtmmKAxfH0sLMB/sbqvtTgXiGn0Fhm8fohjptE6SCE2P4Uw3cbs7cmv3zn0eh9IeKaYOWv0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6921
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index f3fd4a6813a2..3ac70a8183c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -16,6 +16,7 @@
 	aliases {
 		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
+		emmc = &sdhci;
 	};
 
 	chosen: chosen {
@@ -347,6 +348,8 @@
 	bus-width = <8>;
 	max-frequency = <200000000>;
 	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
 	status = "okay";
 };
 
-- 
2.17.1

