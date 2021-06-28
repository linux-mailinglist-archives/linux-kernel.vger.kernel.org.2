Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506733B596C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhF1HG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:06:29 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:15585
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229998AbhF1HG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGdMY22fuZ7bXhIim27QHaXzFe2iDYRagcbJmOPLUhlpURw2yGxS+jn3S9833tN/nqh6ilkydV/vqdVY9XCNmyCSv3X3YXfVsga049MKtqSM5um/ag6OTUge7q4flyP/qn8iuJdMO4E1dYHuLzqkp7RPkysrq513QwuAXmibxusameXKPVJLHEFT5DD+Yg4gDMg/Xe5XDl/29/7sfmdytXFOpqAal3W/1xPQmS9eLoPpHtV0hlz0yVELh5+DMf/P5Fu01IntXTUKqzbAD+PveUhQST+IYEQVPhDRkdkTqXM5UCLy1HK7X0Udv5TokJ+VFgRgq1Dxkz/1FT6RVEqpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpUxVZGuHfI0KlHNlx3YQhXoosIPpJQhFH3Yqmdn14U=;
 b=l/TGhJBka6luJVy9uOJUm7+5GUcgiM2S9h7PxPVAWmaMY2cvaJm35I6QJ+5XdcEm+gIdE2sMUW+cSk2OhwGZn/48o2KF/d/0fesPcNGCR0UJTIdvyxzRPPrsz6W6rQwd2+30CkU4Q8QUlkpYlBfiZQNt0QhvmE5TBDwurJL+k0rzD0upNOLAe7eecZmGbR7aWFK2QDJrYWget4Lo/o3h8z+Na8OebKqh2W18BCcevxb/lGastpg6gsqLPX/yPX6cd8eoP6hKaxeFN9sxnnyASU7ApJObhkQZe9eiSxcDv9thldORsNvRlOOjgSxuDZ1FHr/rPbd0YgwJ/UgHSb0wHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpUxVZGuHfI0KlHNlx3YQhXoosIPpJQhFH3Yqmdn14U=;
 b=mks0TRiYFvJmkd3LE5ZXrWgrcGVRg0y9ane0AuHJzBAqSBEEBKz1nrfiaInx/72uMW9RR52dOgVs6KUXeXrawK1zWJzLhyRINzp3iOITCtUMBaOAe6PjK8rU7Sgg+kg1bZ94BuPYvOm1jZtD3nST5SvgESPoO+EP5tXdFDyULZk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 28 Jun
 2021 07:03:56 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 07:03:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mailbox: imx-mailbox: fix uninitialized symbol 'val'
Date:   Mon, 28 Jun 2021 15:37:29 +0800
Message-Id: <20210628073729.8449-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0086.apcprd02.prod.outlook.com
 (2603:1096:4:90::26) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0086.apcprd02.prod.outlook.com (2603:1096:4:90::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 07:03:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1842c455-0698-4050-6892-08d93a02e528
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6857F3FCF4F783929E98F628C9039@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maIHwfUXZqTXJGXXi2Uwit6q14FmbdRcsWwwT5APdXbngYdbswqQDFZLiPZdNZTBbQpUWeosbdQWDVo8huD7sSxum9hqnNVivocWOYMw4dGnW9rnHnYeI88g7Oq0zg154J8RFai6Es1pQxH4t+FNqQ8ZLbmujPpIog2lCRFDmEPGH21xfCIr6aTghypDnUGFW680EffJbak8A+Hkj6tXXvPKPB4A53V8orhNyAPAm48pA3d1Ds3gkzrqA82c7eu8tx32q8NfC9kZbkAlTecqWzw06C0F2Wpt8+frj5SGHzJeNs0+emsePkjGjP2MIxLIDkyW3Un4sCzSvPGLGm3a0Gy/CFbs1Nb3OkAzKReMAoOJhACRhq+WY2AYa5LNT9Iv1zDZgjLkyKRrt+uziPEJbyh7H/VjsYhJ4Qdu5ibo7MVtQoTKt+bCozpPsaoddKuoZj9G4vaKQAT7oTmKCLaZ1I8+hEw9nz1RwIdeQxelDurwIBnzZlYWnVUFnV2lMuzq1/J/PYNzBd3DGh66gqIy1Nek3uFBg1KXlICHtsReat5msRmgzHA5wh4LfLHR6RXLgiFL+hn40GZ2mBD1fVQ8BdhrX3bq9N6rbJzfGl7dtDEmU8fYQGwybVwepZI8r1SkIIEDwFjcUB/uxpi+3wKQXRiyr4i8eZS9DBKXW5vmHDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(5660300002)(478600001)(16526019)(956004)(66556008)(6486002)(316002)(54906003)(66476007)(2616005)(66946007)(15650500001)(4744005)(4326008)(1076003)(6506007)(6512007)(6666004)(52116002)(26005)(38100700002)(8936002)(186003)(2906002)(38350700002)(83380400001)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8TAo9UBoKH8zpS6ULQLqBJeZB3yYbptQ4PE2y7AAWsj4BvmrAXZAtSSwzPiQ?=
 =?us-ascii?Q?DqAoDzsDa4DsaOBLjdOekHUA1EtDCOhkqsf1Ab6QsL6zJgZLIEsRnvRi1F0p?=
 =?us-ascii?Q?oTG9TdiNKEqqMc8lwQr7EU6/MGmPTe1yftALVUEam+tFO/x5hhmwBlxWfumX?=
 =?us-ascii?Q?a66eAyNPC2qqBpnhy/Bd30Nb15EbNWaUV2ddj7G6JsbF6OgqHEEJ4TxnanUZ?=
 =?us-ascii?Q?DgloOALYQHcOK85xm3EIB3/9eBiVSPiiU0e/rrTIN9WeusagCNZpBj5uAFZ/?=
 =?us-ascii?Q?+feBemxevgZLOrEHo9Q/oeTgZoDWQBPANcs3wOSMUkdQ9x7LFQt6zwhugvTU?=
 =?us-ascii?Q?FtlLYbHKT0wU7D+JAxncqY8tBy0CKaEjeEfJsMhATeBX+kUQQ84vlCE5Bs2D?=
 =?us-ascii?Q?9HrL9azV6XYsL1CoxdsEDoWtOzrCXPJ5ki7hgAwXj8beHvUEiDbrsQ5Nl3ui?=
 =?us-ascii?Q?4PzOYjV+pfC1pjxT7Sz0RZMREP1mQeAR9gch3Ln2xHyYeqhfvn1P3WqIDGLU?=
 =?us-ascii?Q?uCc0MqnelqsrNH1FPGlvb2tno5ueuuU/xRvv8jAVoXby7qU6n7riuW/1Q98x?=
 =?us-ascii?Q?h6pmyOB6wED31LZelalBCiYnBfJond+n0s/L4gWKQkZzxDbV7GBf/49bWu4V?=
 =?us-ascii?Q?5UCpzS0i2QSehr4oiZ8kBsvtRgzGgeY1CzHm5ugB7SfdsY7FMnTPVZAh+/jK?=
 =?us-ascii?Q?FLTY536PqrtNLL/KzI5zK/QykTaZ8hcZDqx5kCV3qULjEt8edUpjaLE7TIqB?=
 =?us-ascii?Q?0hQfPZNYAFqA8qYDXuEbWVzrKq/Py7Ey0kTtiBUgdOv0b9mPuBXmSYKKkH19?=
 =?us-ascii?Q?2VglkPcds/lWa8ZWaAqguuAx5Tl4ZJWae1pbPXTU1A7r93TzpqNWfg7ai1LZ?=
 =?us-ascii?Q?zxh/jKaltdNn2uEOr06bI8lq/YlzyjsIA7nNAsfmCTtTcNbc2z7GaW3kz74U?=
 =?us-ascii?Q?xZFpnB9qAxc18VRmpunwr8s1faXwrcGtGtsBL0zQui+WyVtvjSDLa/zp4Vff?=
 =?us-ascii?Q?dxXJ4twMBLi9jOOzUEKqz6zT0CQf3lrLOx6/zMauC+rUCwCEp4DFMV4W69ZH?=
 =?us-ascii?Q?bLID2breg0y3x/5BqkOyIyLxNjA4i3tGQClN2TPCkhmfInlOKR5NoSpChv67?=
 =?us-ascii?Q?ZQFxa4RRDXUO5pvOW449zrm/J2djHYE/wnAuPnGIsIb8QQPxuyc0AzTRxO/j?=
 =?us-ascii?Q?HdpGcXRrtvld2UODrglXd/J4fMouRV+TSPaqyfk8JlOeFv07Z6GE4gFxvjQX?=
 =?us-ascii?Q?mgEQT7h2oi+rVru8SoUPye6P/BChBAvC4ggJTEdWmUnGGY+L1/Bz3lNA9H8y?=
 =?us-ascii?Q?xlE87Xp9kzCRdkUEW1Uoo+SV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1842c455-0698-4050-6892-08d93a02e528
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 07:03:56.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsWoCtTvbp2NuSXMnGVRsL3i8E4YxClDK+ZHBKtCn4CgnlJHGB0Ife1TCWHJeokm40Ih5pciv1d/7/RTFkII9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

"val" not initialized on default path, so initialize val to 0 to fix
this issue.

Fixes: 91c8c1fbe498 ("mailbox: imx: add xSR/xCR register array")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index bc51bd3c1999..6c6875dd30e7 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -282,6 +282,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 			(ctrl & IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx));
 		break;
 	default:
+		val = 0;
 		break;
 	}
 
-- 
2.30.0

