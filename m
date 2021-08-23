Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69283F495E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhHWLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:08:25 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:40773
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236305AbhHWLIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3I0SVGUD1kbJ75itjCNO/6cu+wVQj3wMLJ8aEbrHbfYzixQfv2coXzFM6YMl1uTbAl/C6hL+Jal214ME5QibEoHyrzjDaZR5aROTEAgv++WcvvNE85DORXf0s1JCqzlhTbfjPWZVSbzdRd/OOSB4zUxCwFMLHHZDDL6mJ0vSDeH71yka0Dwe0wT3qh9RglpILc62IH1ZxYwrwZ06QGavx/UNMmFVj5euMiurRDtlxkJAqkMZmPGjVauv7eY++4ogQV/nsiHFOu770LRA/g9ZjgP5fNphqs/sfDj2cklM6Eqx8Z6uTFPw21WKf3bilDzzaXoQnMwipc+I230z4wrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR9fb/y/SwBDL9xh0ayjptgcvGABEIum6YT1hk1HTD0=;
 b=XpBjQUw1qQO+S8qGYNUEVPAjUztDyhvfr6dowQzFwSxDbADsXHNJCBeoRfgqH16/Vl4nRH5xmTjYZHx4juB066WuRACTgqY5K2Ku3x3FMGUkR7uswJGoEOaPiwoLwJKkpYxzjDaSCMnYY37KE7ysQkXGI9aue9AL4fe/fBigO9MYaYWZbvVY6VvIXUfjpLqhHa0fYhdaLi6fL1Nc1uSRdvlfp3yK8/9sw7mYxtemq98O1njIvoLqXKn+6xmxMcm3Hh/BbihKbAQ2M8eueGiv5QD58lSZr/mGNd900u2tv0npmDoDDUaasCpBBq4tLICwEXVunW3AcvNep8mWv6OIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR9fb/y/SwBDL9xh0ayjptgcvGABEIum6YT1hk1HTD0=;
 b=jogiyrCLSfVoNMWaXa62IOOuXZ+aEgiCBjSYNmClXAhF46nJzokzPdj/XgJDsff3VvM+y3ZS2og/g80D1KRmk/lS4SMyF348mKrj+AxncZ0i6b6nsBu7QooyzK3Ix08oc8BLyX48mgOAaFsIoSJ2lo1bNfHbllMaJWblPxkpDAM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB9PR08MB7007.eurprd08.prod.outlook.com (2603:10a6:10:2c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 11:07:37 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 11:07:37 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH] arm64: dts: rockchip: add saradc to rk3568-evb1-v10
Date:   Mon, 23 Aug 2021 13:07:16 +0200
Message-Id: <20210823110716.10038-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0801CA0077.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::21) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR0801CA0077.eurprd08.prod.outlook.com (2603:10a6:800:7d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 11:07:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696d0d41-4041-4db3-f56f-08d96626370d
X-MS-TrafficTypeDiagnostic: DB9PR08MB7007:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR08MB70075B9B1DB26D6FDE82B231F2C49@DB9PR08MB7007.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Id8ikoEGcYq9Xqt0vnXWSCwiiCSdqpw+Z1bPBB2vLtRRm79y4iHb0ZQS2BrG0Iv0XPeWeEVlLaZDdLsc7lwMk5kNAoMjPZvUTICSNtTKWzc2nLAvqjNRDls1YC6DEGJj1RpBPVaA7SOKrmV4KlGtzim4breHw38iRjWQmkb+PteAZtEXnq2uI6Xzu7npICBb23dkFoFbcPyAY3w/7x6uW1++DiKJDHgnjUmA49nGsWHIGCm69VAgohMVutSJSYQxKZbHeqtO/NmSybM2hIxZ1SFFxR07gtI2kUXHrIEM3woSKXXaDuzprgpPx8lfqet7h+sPOKdxBMXZDIfIQejKmIlI5NVLDA0Oojx4ns5ioeWoVCCd2BEXqA1Ngj0a4ZzCaUz5czy1B180lm2uyTH94uwOLUYpCTOR3UdNa+C+E5n/F+kXYL7UFUZnlu1bmI+T01MpLzfuM7nFQMDei6RA2cYACzyRQm8KWAyVpYU1Te7vaA4pbbvwvwMAAJyfTzghhxcqTbTWsaMETfBBPjPP+0w0I3DiEzaPtSbjf/6/f/+40l8oXnmgcOqjYgPxdZGHk3ozCLb9bSf2JrPu/jCQ18O54xevCJ8O8AgLlfEwEcXODD2IFXATBq5r+mEq8OKHwmjie3W/WbfGXVvdT5A1JoZOiljQ836QSfeWgl3V1Jo/SVZsWmTwpRdDaiRZzCTTOCsup/d0aBkrssrlH/zC0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(6512007)(36756003)(44832011)(2906002)(66946007)(1076003)(107886003)(6506007)(52116002)(508600001)(26005)(6486002)(956004)(6666004)(8936002)(2616005)(38100700002)(316002)(38350700002)(4744005)(8676002)(5660300002)(86362001)(54906003)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kK89eoP9nFfVtT7eZrR9DVWw/IKW7PGpTq2g2jmajvovV6MwbLzSxFKpW9dc?=
 =?us-ascii?Q?KaXm0IyQbFKLFkCf7oFk3xNgbriQD3/3pegTqrTk/Jt7bbzTz6qnb2FE1eLo?=
 =?us-ascii?Q?w5VeDNKdQiHzPaFFOwU5I/0ICR24OP06IDptDJWcLMWXsJyG2LZ6NRAlAmER?=
 =?us-ascii?Q?oubTLZiX2QFGkma3pSSs28ekz1q1o5EHXCFVUXRtX9jr4V0+ARGIzw7M8E5i?=
 =?us-ascii?Q?vZbep+/p2KY5VWXDALP8tiIvEjhTGU4nNkoIJZWDVZXGQLqPmFQeh2GYugnh?=
 =?us-ascii?Q?l41o7C6YmZxYhCKcbTKf++9aT5lQA4eMl0/eijfJFGNlW4TaWzG8p8u1sCGg?=
 =?us-ascii?Q?xRd+770pDqXtBJL63nyvlzH0Mfg4i08M/0KV6X2yKIWPQjynU2y7xKcaihil?=
 =?us-ascii?Q?lryElUtBHrjnSFsExCrbRr5Jo2Alg/E1l7tkrjw++J8pH7ASUZfXtr6U8FTE?=
 =?us-ascii?Q?NuhGasP0ziY1Q9VzOnS59gYak3zmusmTE63vIdLp2IneOvpboPqUz6jW2WhY?=
 =?us-ascii?Q?akOy7UGAgtVMQuD0P9/u0b+AygLuXmoxtvJWV/seKQbYbC6PP05tiedfCQDY?=
 =?us-ascii?Q?nZdY4OpINKSGAqfyZgyTGRPQtC6OwOC7Sef5Mp1zwUiKoDK5ZNiYp6qc7zbN?=
 =?us-ascii?Q?LtzFOC9fY4qgjsJlOJTsFCLAvmlvtL/FEJB2HXeXYrP3uP+ouKHV/0YxASEX?=
 =?us-ascii?Q?ScdVUG5qQSOV/jjXd2sVPdNroyr2oBw0F7l+d3pFviTMsg71xV3Q2N1YM+6a?=
 =?us-ascii?Q?7hvrGuwVx6Pod+46R3z90EhMTQu23YEdQQrSzPD6NGd5fWITMsUgSh/Z5+Qw?=
 =?us-ascii?Q?yGYOQ3fJc0EW9Fl9i8L3VPFWxwu0B5zGPWufk3nsVSgU9R1AqyarnkT2WP4R?=
 =?us-ascii?Q?pfNLLOzNvgI0Z1QHk92ycSlfoINaPUbt7p7EX07BnAnPh+rEjqadtZcFPyww?=
 =?us-ascii?Q?00gX2BhUf/TuVunbOWAdYOAGc44LTgkNrro3QE/2Y7aeel6ADzXdmjKixAmq?=
 =?us-ascii?Q?PWx63ko0nOuPkc/+V590LFU5BuyzR7JAUSq0w2pK6aO/aLvIQXL/wyeKpWub?=
 =?us-ascii?Q?jeKhDQqfhOX5WKBE6UHID6b4J5zdFRoHeOYPalGKxhNOMftRkbaVo2OrvK0M?=
 =?us-ascii?Q?a1o32DrV9dJbcV5M1TkYY5Z9MSKlWOdcZuwqp0ws2KTfXPdGwH9T5MoCj9wo?=
 =?us-ascii?Q?pnCFqicHNMcQJxZBfZYPxZlqSasygtOHQRp3LIayW8MQFu4YVTsHrbaSXjYw?=
 =?us-ascii?Q?nYAIzo3rCWMhXOd+QDxbdPohWLqUL8hKDnExGGIIO1apwlorcyU3limzl7d6?=
 =?us-ascii?Q?QCfYTvjoFTtf2+Ha53hsI3RL?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 696d0d41-4041-4db3-f56f-08d96626370d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 11:07:36.9737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SRD71OpS6Q50e7ggk9yLLfJmgtVIsyVqRD6ckCVEdOt3RMySFe3CgmQLJ/ZlEDLM/vbedK+Y7PQ1cVj3L5CGInzvqaOrxT6Kt5KV0N/+Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7007
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

