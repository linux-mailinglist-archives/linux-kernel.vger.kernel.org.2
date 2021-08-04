Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248B03E01A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhHDNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:06:53 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:30017
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231310AbhHDNGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmSu5G2kVFj3pINIO34KrLZLGBvzc6rGw+DDIK8VNE4W5wROqPJrDYCB9MOKHsk9QNQhmKq8BjQOybyowD5smokQfAnqawdHTAYjVfCWbJsfcpwUfTfo5FTLtxp4QLcrZm6WxMdwPvQB0I1D+efPbruKvnLxbMF2MMlOgzglj8u7Mzel4PJbo4N3Fdcx0DvM0m5al8gIPjRi8jDWSmLPnPRwBmDQk6yoUXuuwmaGQiV2wAQwMFaLh2HB5+rmRH23uCMIkCdcXVYJtQrGVvzh0o08v33uIa0bHDaU8R/6i0V1PpSlgt1M+mNaI+2xj2jbINJaSZC6rV1cWzW025L9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61g4JixVwa/rU0H3/EKE5WgzMEHvqNtrxhKmRbDxbss=;
 b=QBYHe3bVOU17h9vYSRTDwBusPTmsz5INY8HvufJG8WDd3/M5PL+LWazyrSTLD4HB3JWb4duexGnBmTzodGZDOIq2Kh54HFbHtyOZWK4Hthxgbh5CeFGqLcvaF1M5tIkgvPJk3QSkGC8YrGt26yMmYqZ7UQfcll0ZDHWQeMpOOuSpj+Uhmm8Vqm4giZPRB2H6xF8OnUlS1SUiCHIH26ZDiaWeYvmMZYf0/7cj3HKKzAdt/pAigmfO5+Px4EBNUbyITscUy/nDpijfzNwl74tS8L/JbvaGjPD/IQjB/QQtWIJ+EFrLjTKoI59RBIuz4V4qNF9FhwP84c7QlrdgHoq8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61g4JixVwa/rU0H3/EKE5WgzMEHvqNtrxhKmRbDxbss=;
 b=T7sqSX/VI8I3IX44br9Fdg6BiQ3KbowPmQh6anmEK6ChQGcvV0JQYi3vOJYyOdEDYKfo8hD1qZCGvHVQz2lsBIfiHKVXOe4AwMZVtmE1bLV7F1cY7isw7RjJwqLU8TH2gfsyhzV6rWg6gcFFmYKnv4TOBlEEdJNxdiY1WHtq1UY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5401.eurprd08.prod.outlook.com (2603:10a6:10:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 13:06:37 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 13:06:36 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 0/7] arm64: dts: rockchip: rk3568-evb1-v10: add sd card support
Date:   Wed,  4 Aug 2021 15:06:18 +0200
Message-Id: <20210804130625.15449-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:200:89::22) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM4PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:200:89::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:06:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45c8f033-29ad-4375-d11e-08d95748b0d6
X-MS-TrafficTypeDiagnostic: DB8PR08MB5401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5401DB8B81EB64209401025BF2F19@DB8PR08MB5401.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0wkj7iLOu43tEPuO0m2YvFOCYXRm+vF+1cps5DY4Ql88M9Wur7B0H3SpMslN+E5aiqXWS9rxwGI5aaPt0ZjORKriiZ3vDhKTrMExrolBdzIW86+n/577hbDrNRQxcnvBta1j218G+ntbs0DLXiBRcoxr7T27C4NFVij7JZCbgjNIElrN1msSJ1k/WO6n9bFxVq3QTiI2/iinzeiKNhUP/Zd9U2R9NPB5YCxg6qdjzFtv95KUfKL0qmA6tc5UCfHr0l34F4YkQPDUBFLIwafu8m9MKAeSTg8EpdLf3PCfdFQl0lZwM3yclup5lV6CnDyrsUUnkK+Ro10AB2iBK90GtfKWCvdVlNFT87RAj/uK2cHxSXBnC5TNvWGacRAk0qmRrpAIlrB+3yfc6qd4PW86KPHp3J3eCTnD60XmEbF2uJLxqeucHpS7/xcYibTP+iEWL752L7sJTudcoJRzgOBEO/D8NcHegXuxD8VWdI/nN0WIi5umOiRQ3+hIUBZ8J8alxX4PCAG3IErBqjh9ADdAmU89bErOPEERVvOEV6ZVempp6wTFQwBxLbCtXhJSZF5tvtlaiYRHRvYaSTuhSzyPypDkRkA+1LR6RQ0itIW5jYl2WqkXte9FxxPHnyVQ54636hk5zLjSDPPfBNip9vvovMU+aYiGVEF7tK/pNJqbzrM3lJcBNqt+OgLN1Da1g/HdKFh2FBtvIZUPSlFO/YpJn/BgTXepIe13EPfFJBj9GV2W9EDSc4M+u44M3zg+IoUqFN8e/9frFIk0VCUvkv+pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(396003)(366004)(346002)(136003)(8676002)(186003)(956004)(1076003)(7416002)(478600001)(2616005)(2906002)(66556008)(8936002)(966005)(66476007)(66946007)(52116002)(6666004)(83380400001)(54906003)(36756003)(38350700002)(5660300002)(44832011)(316002)(6512007)(38100700002)(26005)(86362001)(6486002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qtM2VHz88XU6PsuNcduuGi/hRB6b4du1mCZ77ocKuci/4RTJuipzP/OVMEhB?=
 =?us-ascii?Q?pPHmPEUck8tGSDiKAxMSEt2hS6EGOJLFSgiUvV8qguQUVn9bp79ULG2jdoFz?=
 =?us-ascii?Q?1vxHq3weglEUGKKdmNT+myWRSGWQH3A3chbe8Mw2+OScIcp2r94KVe0fHo5k?=
 =?us-ascii?Q?HpkmVtYtA1cBt1aJlKCT4Mmo4CtjJc0NADaBaNoSwjNRQ3rbwfcXAPjgbxe6?=
 =?us-ascii?Q?YTfPwbuLuTCe7aVXw1M4HDr3McxbYX+R6R1/bx/9Y42kytDBUBI5KQ1+lAv3?=
 =?us-ascii?Q?y4ppc7LpBh+f8sJhwyTBMyXc7R/pKGVvnQL8SvB5AfVdfpi+wPTVJsqqmZBj?=
 =?us-ascii?Q?7UlTcaiYyFwn6s9cm/8agyBYoQcyTTSvqrFauz6tJYCUYYRJyl8NbGsLpqnd?=
 =?us-ascii?Q?k1AdKWHZ/t9BpD9q4lsfk9yfuw+fA/5fchXEo+tMCcGkhkSuSpOqpFVHENjX?=
 =?us-ascii?Q?+m5AcXRydfpgf746Tv9LOVn4/PQShPU2Htn/z869T3eo2SGw0md6I8/BW8t7?=
 =?us-ascii?Q?PaYXxllDoBTPmK9tJYaIhXhSFFqve8h7z1DRnaZZ5iRkcSwWAmsOpBcjsXfJ?=
 =?us-ascii?Q?xiblymz30hWSX0WGTp9TJsplCr5FVGn8my7eamBHMuCpDSNPjPTr5o+V5SVg?=
 =?us-ascii?Q?QGXZgIF8fMAoB7JeigfKbtUk8Twoiy3cjz1o6qtPyU6TxQzwE47k9FpVDFaG?=
 =?us-ascii?Q?fWqcELseoNtCczEIC9gTKy4rmG8P2IvnBEz0eZ/0fE+PHDpY8d0gt2iuQjtO?=
 =?us-ascii?Q?ebq064qUGL8/RGzDZESG6M3Rlc3bPSdz/BkIH5W2d0sghFJLmiochAItLo8y?=
 =?us-ascii?Q?KRUvemuPIrnrWrjhLm76bwN2itUvjH2V3mM3Eu53KCapiz8pth/DBy0/MmEz?=
 =?us-ascii?Q?MFqJnQhAHv8C90qBYxiOFegNuorsbhaaWkUPknvwoiv6zhbeShF3CF681FDT?=
 =?us-ascii?Q?IkasqrFj9CBJt4kG4IHyPOgnCtyEruVgncyXpLyw0gG8jZ0fP8ezc2Wnup4z?=
 =?us-ascii?Q?qm1z4bK9ZoO+4mIirAntPj9PSTvDmHLuktTihOMkc7utdUv3Ywc7NN2DhPpR?=
 =?us-ascii?Q?S7aqdWeP0V87PT29/fs7P8IEI/J0ml5lS9Lq60/oEQYgLEg76LXwWnXCkI7Y?=
 =?us-ascii?Q?sI88VPVECEVf8oMjxyL/COpBOlIar2675p3IbpcObliGWpI/O7A6C1G46tzI?=
 =?us-ascii?Q?byQQD4Mib7OYEjIp97vNzFdRjr+BTfSgyWoRXezXOJB/FH9ieIfvg+FLO7BL?=
 =?us-ascii?Q?7Uh8Ot5x/Ld2Pd9rKYpA/Rh7kcupalmwns/ByrEem44ZQzi/rG/BBMwPUpDD?=
 =?us-ascii?Q?7v0pJD8OTNbMMhWBFsCKK7v7?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c8f033-29ad-4375-d11e-08d95748b0d6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:06:36.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcdOoks3TiaWyYz3Bazf7mpt4NLHwco+KY2VG+kivoNR9m/SXnqYRHHRitCfJxL7v6r1jLUHYL8lZVhK8YIPeXQlXR+WhnU+gGtgzoFhcLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series enables the SD card reader on the RK3568 EVB1
and completes the support for the on-board eMMC.

As the PMU IO domains are required, the patch series that
introduces support for the RK3568 [1] has been integrated
in this series to bring this mainline.

Best regards,
Michael

[1] https://patchwork.kernel.org/project/linux-rockchip/list/?series=489383

v2:
- rename alias to match convention
- add support for rk3568 io domains

Jianqun Xu (1):
  soc: rockchip: io-domain: add rk3568 support

Michael Riesch (6):
  dt-bindings: power: add rk3568-pmu-io-domain support
  arm64: dts: rockchip: rk3568-evb1-v10: add regulators of rk809 pmic
  arm64: dts: rockchip: enable io domains for rk356x
  arm64: dts: rockchip: rk3568-evb1-v10: enable io domains
  arm64: dts: rockchip: rk3568-evb1-v10: add pinctrl and alias to emmc
    node
  arm64: dts: rockchip: rk3568-evb1-v10: add node for sd card

 .../bindings/power/rockchip-io-domain.yaml    |  30 +++
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 237 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |   5 +
 drivers/soc/rockchip/io-domain.c              |  88 ++++++-
 4 files changed, 352 insertions(+), 8 deletions(-)

-- 
2.20.1

