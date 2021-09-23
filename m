Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14877415C68
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbhIWLCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:02:40 -0400
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:63491
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240442AbhIWLCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQKPEKqwigzGfyil5U0KIcrOOsmQ7XGQGjLPmNXn0DQigZ2VdIqA53q2MmQf9I7yQ1wSV6SfZA3XWcvX4WUc47ck5WfB1tb0cdb8M4qXAc4EuvPtgCNn+Oo6R1jsQDpo6hqugdzlfanc0zJfN3kSHbpHjIBAPV4rYBBKP2pukFVHA9r7/z+KNFBqSMjJkiouJiTJZFuBAEcUO2qZg2Xyn5KAd1s7hhTnckm/tiuuv558J3Po/RyMAEATDBaOr0NmjcNPakSgwChBzQHo7jyaaZoJAVGXp4sLWJUG4cZMQchhfgH2lw31fJ+Y03/QR51+Pgp+AfyKczwFt+3246MAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eXMxwad/4aufHoxMR2JCHSvtQnYlSf2k8/KA7DgTbMs=;
 b=K+UzD/8Luj+it1ivYscQ5rRh7uc7P2+/vp5vJg3KSoEDWWC2kPnoyTl23I+njG0VP7YftPkxptiGz3y6q2V1pcOEGYu07M4Eqgpy50xHsJiRap8a9ca932YUJ508L1FCBq5JI5GKUntBCsCWrh9ravOkuIY3RqCqBtdRAEikF6sM3608tbl4ZbS8QHVZS7s6MO+nULlBImxGnm2n3ToDonIeLslAilTa+6EFtNOOrnnYt8lWFX7bQk20OOu7Xy3KaaLVKfxVeDAUmmiKoPphxASHi9C+NxHrDx1YAX/VVcSAvuVAyXpHZISewTSr1uAG0v6ughKQLb8koiZ8HP/zxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXMxwad/4aufHoxMR2JCHSvtQnYlSf2k8/KA7DgTbMs=;
 b=n03wPVk9Rqs0bHN1ZMfmEPEGua1IMGIom+aouC+oSBMZUKjflr6hrDCal2uc2t4Bvc7lydHc7HKhFbxaK6KZb9DRcmEtFRJ8ubAo0bWoo4HCMG5GWTOSvxH4G400E+HKza8VKG/LdrDur7kfrYHJPgXrGb1d0iocgTqZjDIc1WM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 11:01:06 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 11:01:05 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 0/6] nvmem: add "cell-type" property to support mac-address
Date:   Thu, 23 Sep 2021 19:01:03 +0800
Message-Id: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:01:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a224513-73ef-47e7-2b2e-08d97e81709f
X-MS-TrafficTypeDiagnostic: DBBPR04MB7836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78360613EE136A2D0D166EFDE6A39@DBBPR04MB7836.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:289;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2lkzF1si+MVccuaDgAblhUYg/6Rf+Zs8h59u4lt3DuCdmz44BWsEFQpIb6f3SiQQ83osTQA/sqMLOA/y1oARo2+ala3MY8Jd78KG439cp39eMjf4tTNeDtbEfrxElXDzWOSGCSqARdDzGZ+dvXkL5G1J94RIc7LS2WsVnd14IUijgVd/50H7VWy7Xe9Q7RYkAhCnhlAhJ7UIsVqcYlHQE7xM78OejsRdLwWqIT7F5uyyWORiRdNOZyzSHSslo8meh2YbqDVCRtwpZGe/3yMeDN/7aHUVwUOZOh97rRu0FhZnh3HUDmrPqazq+jB7E+sxKzbUTtYDw037D19vywJ0kBoArqUz/z6/adj8PZtkB22p1vM3IJm26bOID4OVximV8sGYh1g8xfsIyyMVVNZSqVcucy70kFpsfuUPVUNRZZSTP5dzGJ+JZ7FB2e229XhaGGh8HKq6eFxYVPkKagHdBxEJtK9jfylm233/4bjyIc3cQyi+17X+wIGnUOiZNU+F50O2v4wRJhPvxp39MDyURppKBAJ5vF7hK0lw+NY14aHOJ+rCl9ZhwpKKMaoto+qQgU3ECgbOpjM+0fu3peE6JLChTEyTAhnttX/xLuBynExyjXorlykuckZ/2HuqbuvRWpgS4TJrpdLOK/uANMeqI/rp++8U1E/7pzoRkKP5ITcyZN67J2oFaTwFIJB0Mzzee1LwWBKzcUsm/6oCdTXcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(36756003)(8936002)(86362001)(186003)(66946007)(2906002)(6512007)(38100700002)(38350700002)(26005)(8676002)(66476007)(6506007)(5660300002)(66556008)(508600001)(2616005)(316002)(83380400001)(956004)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4vtnElT00qJXVlgKdVuRIWywm9ldoEFmcBbDMUqOTXdrwjqlq6j6EmIrbMTK?=
 =?us-ascii?Q?Nh1XNP1Jlc+U3lRq5d++iC0FYDeHCGGqwjOj5P2gAtmbn1pDI0D/c2WS8AiV?=
 =?us-ascii?Q?XFb0rNheDIZFcwWGQJ9fRXLnYWlvGSDscDo71i+koGqAiHMlj1JBl6WtZLpt?=
 =?us-ascii?Q?2mQQYcDlo8Ngp7hlI1LARRlzKHRY9ls564gibMaeBInnksye8SKYS6uQo1zR?=
 =?us-ascii?Q?V1vnkTAQQcj/gP4F5b6XxsMNW5r5W9cOYEa/lXf14NtLo1bhi3NxD5YYODVc?=
 =?us-ascii?Q?QHpHTs5SQk8d3utlsJT/JyeLAq613GGYbvHfNxQh3K9WKPOONFb2aNEVv0fP?=
 =?us-ascii?Q?2T++J34AmlaoyUmdpEiBABg2Cu2UZQ5K245cl6ALl+FEFTpnEKSZDTFi+wfq?=
 =?us-ascii?Q?YcWov0scr7qc0lqyQzw3G6ubc+qBsgv0SdVC7UAJIpgYEROovxv6vV/dQY/s?=
 =?us-ascii?Q?84tjUCfPnHD7r+ETUQmw47+uUWs1kCeuQB/gS5HDRk0tC31dyUuAwe2zNlXF?=
 =?us-ascii?Q?fE5fzSWf3ZlfiAYADXfIko6ShWqUeT/rdAHlJ4xklvpwHD7EApjoXP3Z3B8k?=
 =?us-ascii?Q?fINjFXVAdR6Df+RxyudV4abWafT3JyfAU+fHKO0kquafuqKU8d/8zsP0kWP2?=
 =?us-ascii?Q?NpqPD9hvch+3g+/mo2Duy8L0f1Uk7HWPMV6LILfXpD3XdiyPEbd4MYLCsBpW?=
 =?us-ascii?Q?90FAyjOehDYAE5ES1o/H4ZTxz8MzSX4CWOStFxKW/QPeo3pCvgWqThlj8Y5w?=
 =?us-ascii?Q?GWRyfOlY0Kto4f5KqDtVAlc9hSEe4i2QfO+XMhKOmEy+q+qr7vBXQ4G+8T8x?=
 =?us-ascii?Q?EN2VP3NJy50lwGHjBpJdVuevrbAHPMgKVqpypVutS3wUBLDNZ013uRwRaQKF?=
 =?us-ascii?Q?fxjomlirEq2LyCUX9HsaYEf9F4sFD9Ap1Z7KPWFZQisVBbfLrsvwhpdZSUXc?=
 =?us-ascii?Q?ZaSgSOrTEkERFS5/ZrF5XUCYCJb2SSsuFt12Nozxs/IIBWweInrDBN3nXxgX?=
 =?us-ascii?Q?v2slNooVIIByi0COX4TIC9mcvNe0AEeV6efj51qIKVEVZKGjnZPqEfsGLbtb?=
 =?us-ascii?Q?FCE98BHb5o0FtWnqtHWm55aGwfoZl+UBzBKST3zaZe3/pdk9SSZ72qVDQPNJ?=
 =?us-ascii?Q?rRhfnigbWEQN4wcbSUp0xcKxczs/dtWYA518QobMeYgf5TT0AwwhYIiK57Es?=
 =?us-ascii?Q?Kjyy0NZnQlMwQoDFmNbz/i+/oyncvoUSKl7GvfIRPAx3Ka0dEEDvibgx5GnW?=
 =?us-ascii?Q?EI9NZw6LxfijnrTWj/wf/QB5ldnkFogKxA7rzoiu5EOtt0mWdHUfdt+b8GIU?=
 =?us-ascii?Q?RRZZWKwntgD+nycs0SnY8BB1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a224513-73ef-47e7-2b2e-08d97e81709f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:01:05.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Kikb60bHYan0W4sLojtk0neRBJ2i5MlAg2zkef5Y94vp5Q8i23KPQkCxHbRP6Syu27G80tcxPw7VeCepPbCIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds "cell-type" property to parse mac address, take i.MX
as an example, which need reverse byte for mac address.

ChangeLogs:
V1->V2:
	* correct comments: @cell_read_callback -> @cell_post_process
	* s/imx8mm/imx8m/ in commit message title
	* add reviewed-by tags

Joakim Zhang (2):
  arm64: dts: imx8m: add "cell-type" property for mac-address
  arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC

Srinivas Kandagatla (4):
  dt-bindings: nvmem: add cell-type to nvmem cells
  nvmem: core: parse nvmem cell-type from device tree
  nvmem: core: add nvmem cell post processing callback
  nvmem: imx-ocotp: add support for post porcessing.

 .../devicetree/bindings/nvmem/nvmem.yaml      | 11 +++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 10 ++++++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  3 +-
 drivers/nvmem/core.c                          | 12 ++++++++
 drivers/nvmem/imx-ocotp.c                     | 30 +++++++++++++++++++
 include/dt-bindings/nvmem/nvmem.h             |  8 +++++
 include/linux/nvmem-provider.h                |  5 ++++
 9 files changed, 81 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/nvmem/nvmem.h

-- 
2.17.1

