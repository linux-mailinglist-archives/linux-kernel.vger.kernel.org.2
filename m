Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC038D5ED
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhEVNLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 09:11:41 -0400
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:42840
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230431AbhEVNLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 09:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs2XehsloHjU4zBW8o2nkQjA06mDY4plwsTbQD1GsUqe18lWgk8H7D8U8I/9UEbOrlFPx8UvP+Uzx4ukPEgCNIJUBWOmx7/8f1wW584pMpF3smSzaJUvcysuo7wGzI/LzLmTYwiSWIwOWiyMYgM66+YeQ4nL7WwKgeoahmBMPKoiA+u+Oa8iiHiEFU/YAJLBEpoNcpYfGEzlQcUxgQgE8IxEuwdgaPhuxEKZgaU7Uu4nbh1AfHVFF1remcO0J2mXJ53yAnRCCGfOX/Fo03a9xQGKYyVt+GuEIy358xT9hVUacRFDa8tEy13jHGhdCxnoYZ7yL45tQ1qj7IHwx0YrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVHMHqU0j7JGm+11Xwe3k+sWb0k+qgzeEjQ88KVeG6M=;
 b=Zj/p9Eqyb3zKTV/HKSOptqw2jsQXLlRKYtVq6M8prWR0Fdga9QpIYy1cvrGWc7JmEhgmhoV6bSg/FS5bxzPPRKzeZfOlMQjd2Q7tzaFP1gaBNoL7So9gve6C0oRbS55F8kK7oQ5Kwu+22vNOyPnU9d2Ti8f9TySrcCSKG7J3nr2psHF2MLSxPckhjc9yW4iwj/wxwP1cYDJR1aSw5tRTkFg3jR+wqIpajejlVrWAhTgxylw+3w9ETwi+nBslw0TJS6/L3b0XOo+xqQhY7qcezTPSvh8wXEzoGnPfG9pei0SCgcd+2x8MKDvUwcghUL9aPmNHOJAQway3kFQBPnskzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVHMHqU0j7JGm+11Xwe3k+sWb0k+qgzeEjQ88KVeG6M=;
 b=JDAn4iRP6z3tT0DL4PMkkiOIZDPaBr8yr5GsAv3o0M6W5O+piFbx0BS4QUNb8Ai03oXUfdrMOk0E+nzF1+au/H20AE7aVuAcJ3L0J/V4hgybGufpULrZ1WsNSTbtOaAYx5qqhwOaAP1h96MNoCfGhwQsfBGrn+nMmRmw2DpeA4M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5658.eurprd04.prod.outlook.com (2603:10a6:10:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Sat, 22 May
 2021 13:10:09 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Sat, 22 May 2021
 13:10:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/4] soc: imx: add i.MX BLK-CTL support
Date:   Sat, 22 May 2021 21:42:45 +0800
Message-Id: <20210522134249.15322-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Sat, 22 May 2021 13:10:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d56c4a6f-3e1a-43a6-744d-08d91d22ecf9
X-MS-TrafficTypeDiagnostic: DB8PR04MB5658:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5658939635EF0D3B0A2E5AD4C9289@DB8PR04MB5658.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJa4j2ct8pL8jTiYPv82MhIvDGJtP7Jh7Cgkjx98dnotLX7H0BbyVnFe3Ah2kgiTjQsn2SCRV2skcYK64XURy9zHPdyDX+hPmtMKZRGx8LRQZTNd0S7Y79MEAw9AG83byjM9ZMYUVx/7BoHvegZAYkvvV4kcXy3I/kVMxIC7NrkdtjJcH/oKz51soAKLapNMMUTLsjj8jI12gIwx963WP5c6N4iB6R/NRuMgNXtNYer40QOlFGFw23K1/H6Ylypxy9NQPW9Jic2WE5gxvzIqYI1h2J7aSsDMfwmZZWQa4hGuWj0p5vCXsqB3F0Z1txJDKTB0lG3EOihGV4qMuwz9iV/Hbtg33ClkPHH9Muc3737MAFnR75M4gtkHEj4N96FEEonSkONDM0bjhHECGUi6V7/ijxD4ji5zoA8sJG6pPvkwTLJEo1GwXBJ/kKmhGxgbpeC2cCSDj+Wcx6ckj2e9zqEGWnaopAo3zHTBzcOfeqkqWgZLQJ84it95HrbpA7lZorKancPttQGlu9aQtwjFZaDpH1ygS0cK/QOEF+SqJZ8zftYYB7xL119QoDNkCeSD1/g3HCwEEyzqmS1Pvw97ZD7hs4tGTCxC2AflRHpr8QK2phIrNSGgFJNJ3UHVpkA1UCKsmjXzsc4KNDtxU5WFsUQJPogrBPUHwpBgEK429erNt0wuR6W0Y263tL2zdCiBxnDHcze5UNi12Fxs5pQi2RtqHEt09uMRAIQqx026h+GduYgbJ4SsoieI+T9QnpLUifK7WsufFGCcpnKKKSPpdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6506007)(66946007)(16526019)(66476007)(66556008)(186003)(4326008)(8936002)(26005)(52116002)(966005)(6512007)(38350700002)(38100700002)(83380400001)(5660300002)(478600001)(1076003)(8676002)(956004)(2616005)(316002)(86362001)(2906002)(6486002)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sSClVNdScsDOhi9ZlCZijI1eOuEsM24K+vvWe/Ih6N1MRZ1/fqf6VdTpKYZn?=
 =?us-ascii?Q?pNeeeklQsI0JKZb2W54vyJs5Dh1946xR1N7WquTt/jR8bFA99/dUI7po6p4J?=
 =?us-ascii?Q?yesxNlkNbKjqGd076S2WlRklvIuL/V2WHZMRvuPBr0WJ6NKFBHEG8KPOtvsL?=
 =?us-ascii?Q?/O7XB53FW9P5BznM6JvS58Y5cm40EVrRdY2YGZVAqYXW0hMdzacDV0eYpdjC?=
 =?us-ascii?Q?a3q2/jk3hKJ26Z3FZNNJluYZcoQYZSPJl6Hg91soOzSzYwuJv3RLXn5lBH5h?=
 =?us-ascii?Q?ayXrXjWns74yoKET9iHaKcm2Vw4rdphmwmyyVTU+nLVlm+9jFCrDST7qYygQ?=
 =?us-ascii?Q?NVhSxKmwJJoJix5K+b6Rr48/Uem7I70wb7IgIAJjJ5hcd8uCOthS1t/t4Ubj?=
 =?us-ascii?Q?Lac/pI37Q1g+A8jnHrVU5xJkETsLJn/2Klc5SL55UyoX1Ihsts7b3GhTz3ut?=
 =?us-ascii?Q?eM74g4o5Tx8LiC59sEsXqBHZ7UasNYl5Oe7prbmYgJtWMZbk4O3IoGNFCPr3?=
 =?us-ascii?Q?38x2n94kYTDs7YM/L8i0tY5kWM8184bu6C+mA0P3X20bHDVvuUi+zITSyATO?=
 =?us-ascii?Q?EadKzMR9gbbwc62Ut6HaOa3CLITQWZT25VBF3Itz2ZJWeZqelm1mwi7y/x+3?=
 =?us-ascii?Q?l7v2SNelaWU50HBIXgmCKPvtvxCXeCx2qpA5eh0G5HNY1DeA9HkPsL4HM4Hq?=
 =?us-ascii?Q?O8lDe9TiuaKtC1wlXC9oi8swu61SfZAGK0AHuhn5/3UP9Wa/hGOWZ7Ajcf4G?=
 =?us-ascii?Q?7mfTlsLmwaukhAFb2fCOUV+PzCY1B3czXfqPQ3CqR9Y9xD6tAf0fgLnZOydJ?=
 =?us-ascii?Q?1S+xrBjYc4uCVyD5E1lzr/ZKt+5xqZ2q2bUGfoCWGQw8XxYku5aly0zzUPDH?=
 =?us-ascii?Q?dNAWbrpiIbi5At6+7v2Ulh+LHEcSKL+Cz0B/Mc6ed4n38oRRO6Q5ltiNovsj?=
 =?us-ascii?Q?wjXG+Vpir0sz8WVvPNPf3RD+tSJ9pHRaEiAgdF696A+7bt5MNc38h4IAV0hl?=
 =?us-ascii?Q?WSD/p4VLdn9CniRyUkVinDzj7AmRVQLOO2+TSoJ2R5h84K5Sz6HPfa1CPw38?=
 =?us-ascii?Q?rmg3K97afHjb4DdVRv45ralRSF0eOqNr4Sn4otlciZSPS7CAVjYCgYSDdhVF?=
 =?us-ascii?Q?dFR3HKSn5bqx3hcfCb7wVxaewHafzvaaGZ3s3nUEKcrj7rllfS97janv26q3?=
 =?us-ascii?Q?qXVCbw95LCPDumhCl1O4OggO6joz5p0EsG8NAPKsT4cXIxohmP2CyVlNX7bZ?=
 =?us-ascii?Q?Do8lApNXsyRalN4S73Afch6/qHmC+6xQH5wPa50ysc56uG/iOiXvj9GLYVrt?=
 =?us-ascii?Q?dqaXRcfEnZ5TUwY1FUXe6FVt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56c4a6f-3e1a-43a6-744d-08d91d22ecf9
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 13:10:09.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+zoahcXjGjFz8/uZh6ZTRqKKFOY1cObAwrmyveFM1KXJuVwncApwZd+HD9T8kcc3rFCXvB38orpAYeRgueyVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V6:
 Thanks for Adam's report on V5.
 Resolve the error message dump, it is the child device reuse
 the parent device node and matches the parent driver.
 Filled the remove function for child device.
 A diff dts file for upstream:
 https://gist.github.com/MrVan/d73888d8273c43ea4a3b28fa668ca1d0

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
 drivers/soc/imx/blk-ctl.c                     | 334 ++++++++++++++++++
 drivers/soc/imx/blk-ctl.h                     |  85 +++++
 include/dt-bindings/power/imx8mm-power.h      |  13 +
 6 files changed, 638 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
 create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
 create mode 100644 drivers/soc/imx/blk-ctl.c
 create mode 100644 drivers/soc/imx/blk-ctl.h

-- 
2.30.0

