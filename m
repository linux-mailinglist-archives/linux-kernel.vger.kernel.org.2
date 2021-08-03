Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085F63DF504
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbhHCSyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:54:11 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:21754
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238214AbhHCSyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+y0zGHB5a0lEl55gUOwzIlwob/Oz+J45xW6NDhrTY+8dMWqVr4b4iecfcnAXOlTiJ2Oqxd/a9wlDurnYvYrwddoR4J+P8Jwao1M0JUk2ClV5MkEBkY8Bp2Y1JWFKKXUJvOQ9LN4ywEy7PXIIGl0Gbz2otziQvt1HSnFRMRAkTwB2fsDGWSND2gOJ9c6U5u+7QFMh4q3mQsPM+dK8HjnlZggTb8xwsj7BmD8Jl8o16FAo2aTB/7eqRajWAo3gE4RS1OTok0xEV7EcTkHVIjZA/Dius3hfEv2JKzXUznCYm1BWfQi7LxLQX+Jx54DQkmdZbmtPN41yEDiUv7sZ0BUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwMwAE4Y1XTM2JVWgsfkNhlJ5Z3g2sxgHF+C94OwmeQ=;
 b=SacmR0XenGI8gxjF3QocRlSABFNIahnm58+QE5fKiV9Qz6hi4o3FuUdoz5Wme52werTJ3ymDMJuUM/8qEOgyNcHt3l27SDt55Gb9LjqpVIQ1FbpJnnLKNvljSOMp4cjyAanAga5l9h3BYS/d1XjmtnWNItuxIXOh+VmJ5WBUUqAKbRYzhYKnMbu3av+4VRnfcmR9H/R4X127AJE89SNNsnvrSIdQdEVBeN1wBS6/YPdlUfSUbq9DYWgL0f6uDcoGatj3exSSR/fb0IQQHkZlC+D2mb9aN5nszxJGSvO2IJxOy+t9/+2uoQt+xeb1bONdLKvfhC/d/kM/YMZlo90VgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwMwAE4Y1XTM2JVWgsfkNhlJ5Z3g2sxgHF+C94OwmeQ=;
 b=PWEPt7uCFcmB61XOYsMYeUgRwE6UpbLMbtC8kZ9Sl58NYU8zynAu29JPteRiN0wHiEqwub/aZwhCDYDP/KfYfDBrFY0nbNdolnvIzWmGRHV3gn3I8BHPw7VxbVtjWDH31WgYRo67dmRNGsCo9qsj9xgxSI3a4vyGGOI2ca7m8+s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB9PR08MB6921.eurprd08.prod.outlook.com (2603:10a6:10:2a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.24; Tue, 3 Aug
 2021 18:53:56 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 18:53:56 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 0/5] arm64: dts: rockchip: rk3568-evb1-v10: add sd card support
Date:   Tue,  3 Aug 2021 20:53:04 +0200
Message-Id: <20210803185309.10013-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P192CA0019.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::24) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by PR3P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend Transport; Tue, 3 Aug 2021 18:53:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 044504b3-84a8-478d-8960-08d956b00bea
X-MS-TrafficTypeDiagnostic: DB9PR08MB6921:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR08MB6921075788E421BFB817B881F2F09@DB9PR08MB6921.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psDSZijB7ao4W4vexxixCMTzQGYAOQwmVXpd4uZMY7ZKmfSVyhZoF4w5myvgWz9USExNFSQE5c0R/3fL4qRwD/nrjgSFqIxnPXhU6F1AbnmrjqD4Ofx0u4lIy6W3BCoZdhX0P177s9uPXEE1nYHgtc12I9dgxhLEWTe2D5/JlENBe+bLj3UxOhK0pNSHjlfDnzG4SkVyzgzCeHzrdZB/NRi5lWuXreex4MEr/R8/XA92hv9FeTM61L7HBvqftPcYeIzbQf7V7cz7fw+uuQnoJCp2/GVftF4lGB4ItcFLbP4v6gBl+4+9o3zQkOgZDzWfn+/BAHKsWbJ+36n1pVJqgFMeX8vK2PVz3A60eusqDFbjS0u+541Ynq/Z4hirxynj1rzpZaAs4Tvsi8zVDoaddn+otyftSERoieEuYekgOqczRgGYfqohjv792KsdyNYl1IAE0+gffYyB5sF6gxlREhUcDF4cs37qalgVOnz4wbIdB6PBIhXKRY6j/nNSnf619UdN3HH9pcCrY1aqD+PUjYpWgYiwnDJSv3KRjFwTW7vZmZiBXvJqcN6reHyUome9t5obKB4zf7YmzeLGA6EZAB8nlIrBnn1kaep2Ii12RTPuXNv7gWhry0bsVHlW45aBT+zOErYWENVq8VB7qsGrrPcEokO4i3e9/fUG2DkbItCs5yN839LmPqYq3pif1qymXg6c2lJ6Frjvn5TaAMvmF5IV4ZBefOIJCkY0vqDGu/uEZtQyIKoglxpYfEyfqali9I8zxGWjylAPsPxLSFV7wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(346002)(396003)(136003)(376002)(966005)(478600001)(52116002)(2616005)(956004)(54906003)(86362001)(66946007)(66556008)(66476007)(316002)(7416002)(2906002)(6512007)(44832011)(6506007)(4744005)(6666004)(8936002)(186003)(8676002)(36756003)(26005)(4326008)(1076003)(38100700002)(38350700002)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CC4asJHtkaCJjVT6QlRZx5VfyQUPYHOI/UX6h33afpS6AVN0CYmKyVq4MXE9?=
 =?us-ascii?Q?JCIzAg1iDUbyKLN8ngtkBrbkqjQp2fM5y7L0YrkVMwRcGaMDi8TPBD7L6ppG?=
 =?us-ascii?Q?ybaoWSBKx3EwWM9fNp7LpyjCRfN8Qw/+gpAu3DAsA4K/QqkvJbod5vGuRp9W?=
 =?us-ascii?Q?ezpC4EjImg0SXju1LPzglMPF2wLeU7jp7nHsSncpBEAVDYW9lYMAEklhw0z2?=
 =?us-ascii?Q?LiKg+oqp2wuLfOfiLOxgHiw2ZyFLu1V6A0kJzp5HjxNkI41bAJmERDu4+iDJ?=
 =?us-ascii?Q?nSsqYKzSdE/o41c+t0NP0umDzmk+b0m5triyQEOesnxons8/L2muBP93bFUn?=
 =?us-ascii?Q?pLlEb0/+laGsGoStpwpNscoxhPoF/JQXiO6gqpqzgpnDLie/dUi81VTRJFA8?=
 =?us-ascii?Q?L7p1bhu54/XXJYsrjfKRKshKGVlyuCbjGKx9IH1W7vRg3Z0ZEDe4qsbZhIBk?=
 =?us-ascii?Q?ZcxaMTDd3UCHWndYlTrmWVjZUtGIOTx578IVTucSM4M1pRyI9sqpIQiR+rvR?=
 =?us-ascii?Q?pFDkZr2ZbuDJzS9r6nT5J+ubr1AAACh66rhV15TyKSgKCfUvO8qCBOer8OUM?=
 =?us-ascii?Q?WKF1nkHPeC0FpzqflAPI38l+VQ3cASDm5Fne/255oRGY1hep7lusPfkLfC7W?=
 =?us-ascii?Q?wKF5PW6UsKNJR6FkNgOxMMkLjzYi+KsVNvah+blLC1AZ8PecksrFgi3U5jK+?=
 =?us-ascii?Q?iYcK32UR1hDvH/ejzza6J96UGjllJkWQtv5JoOI4wNkqYxXLpTQ3UiFOGFSr?=
 =?us-ascii?Q?GPRTkVLrA1GupLN2a0hLUo1CWHhwRxrLdNhlPb56+Nr1TQO1Wwji2juVEF+V?=
 =?us-ascii?Q?hsGr0cUqbO7hm4VDgd8Y8aAr0ZffKTB4qm8vJZjmy69hs9hEnKe2s9oLtv/T?=
 =?us-ascii?Q?CNeCkzMm2wsGe3WHUiFPKA5IkjNq99rmbATk1rYoCsoyzj6HSHEGETH1ntx1?=
 =?us-ascii?Q?mbaHKhX36PiPpZeTfVupFap1qvKNbc8GFNPvywoyyHk7jvfmn4V/fX6lOVac?=
 =?us-ascii?Q?68Wp3wiwdOSTaiWbTq2ZVUeiBD42S8PJTSBSya7fKladHdDA3TElNpCRGbu1?=
 =?us-ascii?Q?HcZWCmQ6ip+YXjg66r60gACx3Om4Nu9F3ZHXQDqZbU89nH66f7CH8xrY9XaR?=
 =?us-ascii?Q?m6k/w9EuF+13sDnLDYpc15cqfGAPfysyqNCyheKeSvLhEnCoKgCMx+E4i1XE?=
 =?us-ascii?Q?58fCpvT/RUncxr+D0LydzOzo71UB2xOKSc3mG6FC+YDh4ZRXTEsMiuI3rDcO?=
 =?us-ascii?Q?BL/5apWyo1ldVOHfae5bRLeApgJ0zIOX9+AZT/cqTP7Svq2KH57SGcbOGlga?=
 =?us-ascii?Q?DVTEYeVD+rqIAYio3FrXL7vD?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 044504b3-84a8-478d-8960-08d956b00bea
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:53:56.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3PVxjPeoxGJoA3CbiFY4w796OI2Y4yBA+8f/9lkQYmM7W/gXuHRQ06tT9W14+O8a3P6ytmxR0uwga1G/x59Jb0vNts4QP/OVhuV1Uckl8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6921
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series enables the SD card reader on the RK3568 EVB1
and completes the support for the on-board eMMC.

As the PMU IO domains are required, this depends on the
patch "soc: rockchip: io-domain: add rk3568 support" [1].

Best regards,
Michael

[1] https://patchwork.kernel.org/project/linux-rockchip/patch/20210527072917.1425321-1-jay.xu@rock-chips.com/

Michael Riesch (5):
  arm64: dts: rockchip: rk3568-evb1-v10: add regulators of rk809 pmic
  arm64: dts: rockchip: enable io domains for rk356x
  arm64: dts: rockchip: rk3568-evb1-v10: enable io domains
  arm64: dts: rockchip: rk3568-evb1-v10: add pinctrl and alias to emmc
    node
  arm64: dts: rockchip: rk3568-evb1-v10: add node for sd card

 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 237 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   5 +
 2 files changed, 242 insertions(+)

-- 
2.17.1

