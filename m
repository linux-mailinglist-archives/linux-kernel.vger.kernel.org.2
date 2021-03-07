Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6503304BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 21:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhCGU5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 15:57:17 -0500
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:3342
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232988AbhCGU4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 15:56:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVbTmgv9hnZiTELwqbspDA+avfV8A6byJKBhgKJH99IYfKVJVkgNT76xY11taG3Bhp1mdpgL6xjGAH3V0nQKRnYUn0geuHE+FBvCXkmHepP45u6XSQ7xY+dZ+0JM6k46fob1yoM9fJsZrTl1udevAPnuL7umOPVfwNoVyVONGmy0nlzmlN7YB6u3bw+L+JvKD3esFzv8/tahB41Ocu6iXol3ps+Tl2Y0xtwSN4yGRHZh4imTZ7f9nDaZQ02aIVAh9gORauhWpImmr9L/0PcsbuwbOtquNi87mGOV2BBsLxtRRlvnowj4qEQt5yPnf72+0Q4NmbwST4tjjnyQD8zJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ3ITOq6LSJPYciqz0COifxTAUytMnFdY7fzjj37lmc=;
 b=AywtVb4vm312HeDx8lbKgO4nQqLnFo2JHbMyak217Xbt2r1Z+XDyrt9Zu/mtYWMIFiX/kjZXH41GwZtv0MLZoeA8QD95OcpptH5nr4clZ4uGgLEYDkU9ZvQGByNOezwP1kDuXnJ/EAbKtTeeyy4ig8M0kvRA2aNHt7NmwO9ZVePnqOUDV9R2W1z7NitNppAagr4MFpsRbYrjVOLjBCmfHLnTWVqOFsSk/2C/8y/NNUC77xGsGYb96NIfYAWPGUlrosGingQX3u+ZD7wZPs5jEVevmCDjTBRieDTeuudaF8TOBjD/GLHGqmWvj6Xc2ZsYBeLgrV7M4qIg0gVoCr8vcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ3ITOq6LSJPYciqz0COifxTAUytMnFdY7fzjj37lmc=;
 b=PqQ8o8jbS2vC8Ek+wUYagljwalT+bKgFPdCYxU0RVmkvNl3R+yGOdVWNCOd1u8m2Dw2bT9vCoYzDM7W5UOUTU0y8Z4c+IYjqW9/Nf4xN5C5cbWsPxcpFgO/tS6Hn5lvTZ0asaHNGlOiBHFMsg9rJBFFcbqCIoP2cZ1M7eKfXpDE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR0402MB3792.eurprd04.prod.outlook.com (2603:10a6:803:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sun, 7 Mar
 2021 20:56:48 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba%5]) with mapi id 15.20.3912.026; Sun, 7 Mar 2021
 20:56:48 +0000
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: ls1021a: mark crypto engine dma coherent
Date:   Sun,  7 Mar 2021 22:56:29 +0200
Message-Id: <20210307205629.12180-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48)
 To VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv15138.swis.ro-buh01.nxp.com (83.217.231.2) by AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Sun, 7 Mar 2021 20:56:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbfe1686-ec91-46ed-d8cf-08d8e1ab8657
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB379240CD1D2BC7D0086D948598949@VI1PR0402MB3792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQX7gJTbILpysuctH4naxpJ8s2T2g8EVWy3Q51L7u7CGwZRcPLjOTr0KSH+orsju5wIXSdpfZGwJCKKWfazoWcGiCy9ZvV4SW28gIDR3o7QEU/MoC2wI/Tt+++G6oNZegkr8OFh/WEkskmtp3NU/AQqpQP0uwYXkYTnbf++fPyUiQhL1ab0pdJ//DK7mZ6Jfbd2MZwNSRiW8iAQW7rtUKfYV1S+qb+d8gaSMteO9Pa1jiBwKYrnOc6q1gcKppKsfPelUOJUVp3upUYoajh3Ke+OIzoUcSL3hcSRQ1eru2JX+y7p9wNqiLrzAkboq60QyVOBf+XBwZ1a9mdob7Uxvg9S3l6T+Z9JaNib1YV/lxOe+Y9H4Ip1pnPCNrcBHsPMc9qv3Cy/3SDdfbO/ySXfOK1/WFaV55SW8xrMFzBZlaoKrMPvDym06EpcLprsFF4M5f0f+CIXTnONtUeMt/ZghfU1WA11/yQBauAOLw5eZmXfloRTiP89Wu2Zccccy1vYMBts8YQ8KIfxeXyBBS09zRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(6666004)(66476007)(316002)(8936002)(186003)(7696005)(4326008)(6486002)(52116002)(478600001)(66556008)(956004)(5660300002)(8676002)(4744005)(2906002)(2616005)(16526019)(26005)(36756003)(86362001)(66946007)(1076003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3NOU0E4VE5XeEtxbnlFZDA1TkkrVkVkVWpOUks5bWs3ancwL29lbDJSWXpM?=
 =?utf-8?B?YzlDV0NVNVFORHY1L0NWcW9vQWpCR1BwVSt3QlpPb1phZEpiRHVqeUNzVXVZ?=
 =?utf-8?B?RS9acGU3TGlGNHlhZEZDYW1SVUVuOWJrSWhsSUJQd0Q5UDR4cmtRcDB5UGRv?=
 =?utf-8?B?WGtpeC9EdnZ2QmVaL2ZuV0FGZVdnUjJJbW1xU1BBeENzRFI5VUZ0RC96K0lD?=
 =?utf-8?B?ci9pWVhxSDl1bmJGUDdLQUZmUFhLZ2s3QWhrT1cyRk51MUpLTnNZbmZTNkdp?=
 =?utf-8?B?dXRabjEza1NkTmRZUFFiQnVmWlAwa1pZdVEzd1N4Vm4vRGFtcmE5eVBJRDly?=
 =?utf-8?B?dXNqSVZTMG5DTnJ4b3hseC93NFlmaHpiMU5yRURPL2ttVFNSbVhrNUVqWjVp?=
 =?utf-8?B?a1ZTM1ZZclRJOG1SQm9sbVRpbjcwd2FhNkhJVTVtMzhtNXFBUFdVSlBuSGhU?=
 =?utf-8?B?dHJjcXlpSUIrSW5na3RmdHpVMzNuNVRoam9lbXBIN2ZpTThXWkwyNkVlUlRo?=
 =?utf-8?B?YjhIdlRCNkNIT0VVM3ZhSFN3WFZEUGVTQ0VXSGs3N1pQQ0ZwTldIdmZNTHJ4?=
 =?utf-8?B?ZzZQdUZSMTdZT0hpaEUxNUFGVmFocms4MzUxR3dMRTF3cXZzZXA0eGgwUjdT?=
 =?utf-8?B?UFZjZTR1cWlaSmhXR29PdGp5dU9qZUpYVVcxazg4Y09OSWpZS1VlbEVlTytP?=
 =?utf-8?B?ME53STloaXhjSy9PWHV5S3ZkbDlEK0RGZW5JZGxyVDE5WVlYcEJUL1piUUhG?=
 =?utf-8?B?UWkvWE5SVlJXaWN6RGs0VktCclRYelNSUis3Y05jaUFhem9oV1hvZ1o3ejhH?=
 =?utf-8?B?U0lSUFMzWlRNMXZEaGx6dVJYMTd4SWtOY1FXbzlZZzl6bXRyK291NHNzU1BH?=
 =?utf-8?B?eTU2U2kvd3M2TVZDOE5DOFhWRUtBYVNicVR2dkhhc3NQQVJGVnJNcnpFZk5X?=
 =?utf-8?B?OE80U0pFWXBYdEpkckJuU0I4ZzFScWh2aWdmM095TndWVVI4NnhxNk5QOXRK?=
 =?utf-8?B?REtzYWpRR3l6Tml0QW9DOTJHdFRtV2cvSDVVeFVYTHpUNzV4VnhZS1UzUE9q?=
 =?utf-8?B?eS9ucnJubitPcnFNbC9hVjErcVo1NmpaWk41a3BJRXBzdzM1SlJCa0VaVStY?=
 =?utf-8?B?Y202eUF6bzhRajJxdFhuY3A1cnpzOU9CZGpRSXpkS1lIcXhOOXlVWWJzZzFG?=
 =?utf-8?B?V0Vyd3M1eDRGaUhnRkJKNEJhQklzd3lpTk1MMWtQZysyQU5sY3ZVaDJuUG16?=
 =?utf-8?B?dG4zV1JLaGpnakgrOVZ4RSs1d3duUTZjQTFUak0xL0RSL1E5WUNiVEhvZjB2?=
 =?utf-8?B?N2ZhQ2doRTNBZTRBdG42d3NnYnRtN1EzcDA1bVlEZ0FnU3JrdUZwWjdLTSth?=
 =?utf-8?B?bDhHMCtrUnI0TW9rN3hRalBTUWNXeWFVQW11RjdtQXc0RWhYMkVYekxqckVn?=
 =?utf-8?B?azZzZmJpVXRYTWxPVTRaRUFDeEMwaUhSWlFnYjlJem52VVE2NE52Y0UrYjRl?=
 =?utf-8?B?ZTNjR2RjeGN2WEYwNFMvUWQ4OHE5eFc5Z0NWT3VyRnREbi9VbXFSSStVMGxS?=
 =?utf-8?B?MkVWYjltWmtWa2tZUnFYaG1mbG15R2RLTkRqVHoxalJjMzNpY3J6N2VmMlJi?=
 =?utf-8?B?UUdpYytDRUhna082TmNpdHRmVUUyVStzUk8yRHJGTi9RNnVmOTJ6Y1RGL2s0?=
 =?utf-8?B?OXFNbG9vdzJSOEhxUk1HcTRISnkrQzZqNk1EbVlOZVpLakdFUmVaUVY4dXJy?=
 =?utf-8?Q?zgt5Ije4ZaUCpD3nTjrf59KZ886F5zJv8pBRJ4r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfe1686-ec91-46ed-d8cf-08d8e1ab8657
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2021 20:56:48.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjD9dtAiekm5VbeMulH1vujJxnfba7CvcsvucYubiwL/l4ghFWGqm74NTbqtimOfeW8J3DpLpn6+6K4dttlWTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crypto engine (CAAM) on LS1021A platform is configured HW-coherent,
mark accordingly the DT node.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 007dd2bd0595..62c6eb87cfb7 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -246,6 +246,7 @@
 			reg		 = <0x0 0x1700000 0x0 0x100000>;
 			ranges		 = <0x0 0x0 0x1700000 0x100000>;
 			interrupts	 = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.0-job-ring",

base-commit: 498f8aee6ec000392d918ecbcbeb1b5ee3132006
-- 
2.17.1

