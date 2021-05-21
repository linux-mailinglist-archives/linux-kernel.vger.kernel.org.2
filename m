Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612DE38C4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhEUK3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:29:18 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:14390
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233232AbhEUK2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTHbsYnjwzmrq+DJLK+irVdY85ETjmzu0XOkaF0aENTMG3h72cCIDq3zvP95uSPLN+oMN/QzWw/cU5Ppvh9+EUbyTpyYvtJTfPPJ7zYCL5ysCRXZAz8FXeYCxFWh9Qip7acEQiBeC6qaJ3vE1gLnYyS78StbGIM1bDm5EL3UxoHKDjbkevyX4tno1g+7jU1Bmbej+7+FXmd8JgfxTQaz3bKTvg89R6kpCa21VisotA+tMyQejvnotABXLix4qvD7tge922vMV2pZioizBCAnpSxgx8vdyMejulvqJ9LC7ixdVIjZVNPkr4QErBikfPzX79EEv1Kpf9lI54/i0SjOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyvQprL6EURJbUNZ/BqipUJ0FzfSkWQ/UyPpEeuhNYU=;
 b=NgyJA8+Gjo0KdI/Kd27H8fQhaoXYU7OIpbfkTme2ne4O2xQToO0U6JOxIa8xy5Xmx53BKyKA3U3vqiUL3EfAeDPmAMCkJrvisTwl45lW9ZlvuNWB1mUbAGtXs5KZCEife2IcXOyTrAK4eN405pjfztq0J18iMXcmUah81mMIv94RdKBKZWQwiucDB2lBfZuKPVXsoJyFcsrh5RgwBitzKPb32r7D2G3lJluHnaXkGCSkSbXiDCgM/sTWHdXK5VdGa8Oleuknp0KOMwGoXba3h2tcNIDUYR13plE4dSH6Xqgu7fkfi5nhNT/1vLp/bkce9sprB1zzlCXOyNWatHQc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyvQprL6EURJbUNZ/BqipUJ0FzfSkWQ/UyPpEeuhNYU=;
 b=JJje/6JMhd4WaDhSvJ/OsJw9DQHwC7KerOBdSgHlxR71Dcgme4WUHV5DNjGEIK3M5MggFFp7ugYD8rGXjZcYnIF2Z6G6Q3jXXSTpfUcwm2BJ8luLj/l9lQGwXaXtkTDmKelNj+OtbhZWB1Z2irwrmB9rFJ6GjMUvGEH6j2T+u+s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4636.eurprd04.prod.outlook.com (2603:10a6:5:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 21 May
 2021 10:27:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 10:27:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
Date:   Fri, 21 May 2021 18:59:15 +0800
Message-Id: <20210521105919.20167-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0163.apcprd06.prod.outlook.com
 (2603:1096:1:1e::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0163.apcprd06.prod.outlook.com (2603:1096:1:1e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 10:26:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d4a7bc3-45ae-4e3d-8470-08d91c42fa6c
X-MS-TrafficTypeDiagnostic: DB7PR04MB4636:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4636A2CCC901F9C3E21F3AC0C9299@DB7PR04MB4636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVoKNgkGdineX4S9g6qUvjYMWmajLkK9Buw8jlRZ9rzIA4stXpK3uESQBsOn8McL2i2VK449F0zWkxtB1wK4lE/MFy9P/H7sYykK/TiU0jDP5LAlATpkiZQorrm5Er2ONPRaxBDs33kszQgEUaXITD/UqvKIMCWy0x+CLxynGjGoIUPBD8zuT+XhIzSsK2jTVl/MQoRAZ68h+7HDOl+VQYLVEy29h3GLZphN+c7hQSjeBQFDsVKGU3/hQijgEvACgfXfJ8xBDBGgzUChVeusGqidLTb/k7qYvCRIsrBZUI+apLIACXn6RmOYkRPa1/iWwUPmlVa8PsFurvTjyf9PnJuGD1ihtUhygzdQ3EHkSRnIe6IzSWSS3lLvhKf3MaD+xOlUUPduUDqVuUaO2sRGTjyzYuVvsLlhMtsEN2SM9DWKOhYgA7OqgV9Ql7duEUphj2Eu9CqhSRMuYD9k9RAFI0GPgbmQQj1ta8yPDv7Jb4fnqF1EEx5oW6bPtrWVW1/0VIl8FSaGV83M0sQ0r4Czw+PpbrUQl3moid7RlVRlhNL+PS1TVUwCJQf2j8v/O8pOQDCQMvkLoU9SwYE8zA/B26L9Gfwbvs/9HbWLwQ33/n4dkKe0zlL+lbak9W6qfj00jUzyWMTjwXVyoBxr/qmAAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(16526019)(1076003)(6486002)(4326008)(956004)(6506007)(478600001)(186003)(6512007)(5660300002)(2616005)(52116002)(8676002)(8936002)(86362001)(7416002)(66556008)(26005)(38100700002)(66476007)(83380400001)(6666004)(2906002)(316002)(66946007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?X6VRScr5TWvQy+HNvZ6Izqp201Ph92wjDO2HvAycKy3ulKalPPlYZZyZ3QiC?=
 =?us-ascii?Q?NMLSbgjuZSV6LwEPQIubVfGm+P7cGdAas4ioF3tCdsecyLrRW71fp0ckA3yX?=
 =?us-ascii?Q?FykLRVdEks/P2W8m9Yk/omqo1i22ZrRlaXaelLgg9RSk/V2ZZH6/orDccftu?=
 =?us-ascii?Q?N6nzulFopCrKeEwv4QWKEsx6ifY8pgLHtpiKMwqEy/FHH9pEKgZOPxOUCWX0?=
 =?us-ascii?Q?ifv0IUdqTfnonjVXUN6RYjJ63tN/Kz9qaUgr1vXOdox2tkAT9om9sbk2bhgk?=
 =?us-ascii?Q?TRi+Nae64j3kH5es0jwDPYo+GyBc48ljhczXcyTWI6ENRIMYT2eKQ7Pw4Z4R?=
 =?us-ascii?Q?Z+glMhF/F9QcoljAo3RKUpLSPBawKHXqScqVZ+gcJuPCSLbIZ2rHdTEmBpQL?=
 =?us-ascii?Q?SR4tFZ5n6UAiFM8A1+GfLqXuuGDuwZw42At3B5AVL4dBR6ThKuF6BCPsF2YI?=
 =?us-ascii?Q?jxc6KmiqVfN0otUVFtLzPdx8LHxWRZKG390IijeQw7AyBM+zQ6C1tFRpIREP?=
 =?us-ascii?Q?fey8KpwB4EGRS0bUP++qaupP6u1ewsCsEI3yREi8ZEbl/0zYNfWy4OhnAAJm?=
 =?us-ascii?Q?rzSeZ5jgOn18Ejw3Jv+B4k7BzjTHlNm1fgXvvPUNIcwcTXznZNz/1lV6egYT?=
 =?us-ascii?Q?6IPusWJpQa1piugCvUrO+U7aRsjAA+bIODHIScCFa9Rb90oyDuBFRM3/68rl?=
 =?us-ascii?Q?xZydL5rWnmnVOi/PaLCBEcyQLztVqMv14emqkATBICpR7b+jijFUeayE4PdV?=
 =?us-ascii?Q?YmSshZXdL/slBBVX+bV8FjywLXN3Cfv/gjLk6sITE7M5eonE4MC1oDN8v0ui?=
 =?us-ascii?Q?5Nd4TVa+VCHFcpvVeiQN0/jL+zwpz0OrT5eMPiATYFugXzePLI1wQ95PupH8?=
 =?us-ascii?Q?djxJ7NemH2o1OMAamNMMEbvdCJ2X0VzehPd4BsH7jWtnUc8hQ1AHjv2+SVhP?=
 =?us-ascii?Q?HAJzh7FUIrYK52sGY/eRRot5nqmWf3k9vCmquq+EY0OFSR8tDIZAy6PUQZtw?=
 =?us-ascii?Q?nEjR4HFarO74H+sv9dcnJfItYauMfKXgJb1rEiEP11TYHdVd7rgGbzjKJSch?=
 =?us-ascii?Q?8B56qZp/MoTticv2bucbyvwdbowdfq9o2XfzsswfXl82gfOlIaicVo+Folgd?=
 =?us-ascii?Q?s6Js7vfPY7ZwidmJbMQmKZsAuOWTmvbD5/al6Pabw4QDawH/IHKs4drVXS01?=
 =?us-ascii?Q?U3qvKRKAjiy9R2RxCX8JlUL7lnvbow+ZfLPsQ/vpXnQBVKqG4hRLL+Ku+SPp?=
 =?us-ascii?Q?uNksmggZHWAjxjFrl/UHLLeD4ZYPASdqNMFAYl2zndxdHT57xgeXxo5MvbdQ?=
 =?us-ascii?Q?P7F7ubhL0iB/fDnF35xSy9aN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4a7bc3-45ae-4e3d-8470-08d91c42fa6c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 10:27:04.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwDqjfQscIcbebi/pui/KoDLyj5iYm74FNrQK/y+bThisPp8S8X4ymJbJ/wXrID8CZDMJy2RwGHFfDN4ZZmfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4636
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent power
 domain to fix the potential handshake issue.
 I still keep R-b/A-b tag for Patch 1,2,4, since very minor changes
 I only drop R-b tag for Patch 3, since it has big change.
 An example, the pgc_mipi not take pgc_dispmix as parent:

	pgc_dispmix: power-domain@10 {
		#power-domain-cells = <0>;
		reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
		clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
			 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
			 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
	};

	pgc_mipi: power-domain@11 {
		#power-domain-cells = <0>;
		reg = <IMX8MM_POWER_DOMAIN_MIPI>;
		power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
	};

	dispmix_blk_ctl: clock-controller@32e28000 {
		compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
		reg = <0x32e28000 0x100>;
		#power-domain-cells = <1>;
		power-domains = <&pgc_dispmix>, <&pgc_mipi>;
		power-domain-names = "dispmix", "mipi";
		clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
			 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
	};

V4:
 Add R-b tag
 Typo fix
 Update the power domain macro names Per Abel and Frieder

V3:
 Add explaination for not listing items in patch 2 commit log Per Rob.
 Addressed comments from Lucas and Frieder on patch [3,4].
 A few comments from Jacky was ignored, because following gpcv2
 coding style.

V2:
 Fix yaml check failure.

Previously there is an effort from Abel that take BLK-CTL as clock
provider, but it turns out that there is A/B lock issue and we are
not able resolve that.

Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
as a power domain provider and use GPC's domain as parent, the consumer
node take BLK-CTL as power domain input.

This patchset has been tested on i.MX8MM EVK board, but one hack
is not included in the patchset is that the DISPMIX BLK-CTL
MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a MIPI
DPHY driver, so fine to leave it.

Thanks for Lucas's suggestion, Frieder Schrempf for collecting
all the patches, Abel's previous BLK-CTL work, Jacky Bai on help
debug issues.


Peng Fan (4):
  dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
  Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
  soc: imx: Add generic blk-ctl driver
  soc: imx: Add blk-ctl driver for i.MX8MM

 .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
 drivers/soc/imx/Makefile                      |   2 +-
 drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
 drivers/soc/imx/blk-ctl.c                     | 311 ++++++++++++++++++
 drivers/soc/imx/blk-ctl.h                     |  85 +++++
 include/dt-bindings/power/imx8mm-power.h      |  13 +
 6 files changed, 615 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
 create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
 create mode 100644 drivers/soc/imx/blk-ctl.c
 create mode 100644 drivers/soc/imx/blk-ctl.h

-- 
2.30.0

