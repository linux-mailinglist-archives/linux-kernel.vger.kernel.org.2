Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD853A42C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhFKNNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:13:48 -0400
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:3446
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230382AbhFKNNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:13:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA5aZoJKA+yfq1sz2Tts1E8A9lqVGIDvEYl6wwC4cVZ8JD6sg5KEN54TX6Oyw434Kvotm3VI0qcR/sBwplgixpkozGLSBvfspjtX5puNc6dvPE6RlqTI0d+zurdjeZWNe5XJR0R+6T4YauK4V0B6/L3awcgo5+a78UciLaVi/IhD20+f+7WnycbN+BwOf09p01ehFD0crdIfUqDWKT64ZOO63lyocWAmqM54oj3rVqQHYjhN/TPc4DUrvB8jxUMCHmRuG61zRhM7wV0VrdKhiMJ++tyVQ1n1cvCw6N1iBlARjzWTZRz5YOcewxIbtL4QQ6f5geGNx0syBuVx4mX9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyYlJwbZwH7LAKwO6QOWlqHh9/q1+BcF03xffIp9DS0=;
 b=IsP2aQo8ffqQ+BfYjNM9mGmTxTcHb9YP5C0L5oNL/PDIWnjMNz9hML2cUjbX0+CdY9k1xerKij50PamxZsvkZPOBo3MDKxDpRL35vf37I5heJqpnwRazfUZZJ6MhbtebadEouOYLBeqowKzgUqlwWCTehKYg9CPHFAdfN47O5+D7Nxj2C5RZFInjIiyscpcm6707v0nnSvcMBf0Yjp0hfjci9j8bF0F2l73BsyTMHKkcrqVKXdLIC6VFUZB5lGYHaZTwW6UXZjtMsOTFxdb7YeEqZ4maiPN1yXkmQwogNC+/FFHsGRDzrRXiiXF9GXPEsdtDqjIMgrCdfL01Yp9C1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyYlJwbZwH7LAKwO6QOWlqHh9/q1+BcF03xffIp9DS0=;
 b=RVMR6SekLX++57F+lEL63PzlhVQvshdMJB0heLUKhtnv7Zt0WqvgY+jsZYyq7/tS6//QAdlbSXX9gCKWeN0+xvsgJ9Z5XnoJaZ3jiRnNXjsKa8u0CnAwMdUT1RgLIifOsaC5hpz5bluxkC6A2Y7AhA6LIpCigdkqFVVgmK+v4IA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 13:11:47 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%7]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 13:11:47 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dongas86@gmail.com, linux-arm-kernel@lists.infradead.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/1] dma: coherent: check no-map property for arm64
Date:   Fri, 11 Jun 2021 21:10:56 +0800
Message-Id: <20210611131056.3731084-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0139.apcprd06.prod.outlook.com
 (2603:1096:1:1f::17) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0139.apcprd06.prod.outlook.com (2603:1096:1:1f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 13:11:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5329cae0-2685-4c5a-f35b-08d92cda775a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8536156CD113413C741DE92180349@DU2PR04MB8536.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egbr9T1QOFGjgXUkQNLtW7xQB0kzQbAyyaf10HJN3KdD30MKC4Ds/Zf1bvn8qp3lp5cxpSDUUtMTAlBzmzPxL4BQ5kYRiwIaPn5kt4P/NGmcTF+zjNDa+8zDkaR8WzEPcbU+9k9SU3KOEiE4vZD25+0mCNbVQ9OlDRPhgog6xKXEm0PRtEfrBMw/7rx+wVgt+6b3e8a5/+5mBS3ZQ1gl+IkdvOIMSe0EcfmENHSF4CpnskiKb/b/6hhC7XM0DreJOnXEiGiIL8+4TC5TH+UPWLCb3r5klrltDWCUTn2he6+mOVaGzJV9fOmMzDRzHM9P5bcVfz7iK8PGNrm68kr3QpUqPJf2LqjPrmYYjuQfOmfgAiwaTkaqrI4NMsh/3TWG0aDFn0G609qnNT2saby1CHlSqmG4FdiwGf/g9A58YXCP/9rO5+WgFcAQf6XmlPU4y2Mu2G7ub4dBSRaj3mfq09hnl8bmBY98iG/mq8+VOao/fMDVyhYuial+oTcH+pNTgL5KS/0lgkdPJTJ1GPJXDXYuHNxas/TKfo7VtP+mAe+5rJSpO15I1wxM1kLZ8EPkWdZSdqvCyKpTRfJ7l1eIN4WD1Hv8ZP6cKIcmDPMJ+hq+B8ZrCS5GL46S5n7ZKyJ5WTTJC0i7bOZXGUcqYBz9MDwsw0jW0tSNOJDv+gGJwwiqieCjK93Ecaa5OjJuh2aD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(1076003)(5660300002)(2616005)(956004)(26005)(8936002)(186003)(8676002)(86362001)(2906002)(36756003)(4326008)(6506007)(83380400001)(316002)(52116002)(478600001)(54906003)(66556008)(66946007)(66476007)(38100700002)(38350700002)(6666004)(16526019)(6512007)(6486002)(6916009)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amQN9Yc4VrWwNrRSpHC472m7nc67OZD6/ON3eHkvYTbkWq3UlgHaLj9XL31L?=
 =?us-ascii?Q?WHy4aFHL2ie6IwEJv74RKm1mLxA5nK0TdE7DX/cVfN9CljqlBR/HjNEGjM+v?=
 =?us-ascii?Q?7fSimNSlcJPlc3YUsp8hhm6BwgojCOYnP1vSG0XEW7XPfzeQ1cA+fTijL9pZ?=
 =?us-ascii?Q?Nu9CkJif8WIY92EKsON5xl0ZZh4z5ojAGbDFfRVp5mvwHvUv9trGgsE9YhGw?=
 =?us-ascii?Q?5DMixD10x+8unMQxlZlgwKlF8veY4B434G/8Qwh6QK3EXPDf7FLCeXXuZX9w?=
 =?us-ascii?Q?JPGqs2QS2bSTQNLDmPCmqpKMhPD7u2YIN8O0Zt6Aa3R/MgkV4fRElQyW9YTU?=
 =?us-ascii?Q?fS8+UMxMNddQ8f5DAfYk8XkVLpp6rDAE9bjYScglpk7T9pn1fl9pUOBGLJbV?=
 =?us-ascii?Q?rqTwr6OHKSl82lIZCDBtFFFREiI6KGmerTaF5K/NVKVAW1ybTn8UXf+yEUkk?=
 =?us-ascii?Q?AaO2UImvIs2/N1TL3FPgnWMms1EN7BymB2L6ggLJHkaAgLYJE7WC3cGMmWJq?=
 =?us-ascii?Q?IBvuDNEa5f6NgvOm5VwIcTehz9lm0FCOeicn+GMQu9k5r96xpM+FA+1khyHO?=
 =?us-ascii?Q?US/0+raRM/+06gJfRi0HmBRQo9UbkgwDVGaFejFcRdRPWwgvO5J8aFBZx8he?=
 =?us-ascii?Q?soHO70UB+NvVcVxJ5xXg2VtmZpn3494ak1GPubFeFzGx2iU3AoTMhDbZZOgD?=
 =?us-ascii?Q?JuLzo90FW29B+EX2zNPv2IQWdJSXzfa7581fd2Njg/5Qslri0wtGlHSP1JnM?=
 =?us-ascii?Q?nR5mMMbcGr4up9KrKSBbXLUhcqMBfvv0/v/K5tjvRf+N1ugR6EOA9wVnLc+D?=
 =?us-ascii?Q?/0SZgTdRwiqDSU0kqvPv94eq9VTGp0cHyk3hAms151siNMRsOzR2zWtaQ4Lp?=
 =?us-ascii?Q?2P7qq+/kG77L3nSed+oewsFWinZi3QHL+mFHHjhJ6MmBBIXFju0dvieH1yyr?=
 =?us-ascii?Q?wLkRe3rVJJmRPRRg4zBIie/QBz0R0n4D/5Um8XM5cjz2NBBzvGaxE1TZB0WG?=
 =?us-ascii?Q?6yALvGfpQZm7o8BeUJ6kwK22b9HBqfY+PwSAbQx/2QzDLeMsrcFzX33I+e4r?=
 =?us-ascii?Q?gl/D1FIXgs3uVG4Iybp/T6tLnm8JMCnLm4D9FiyU8coqxSiKShtKkZJ+GF6u?=
 =?us-ascii?Q?IpVTp2lJ5iJopw18QSl2Tv46kX/q41lsIcqlAsS096yf91Hm945QixJKqFjW?=
 =?us-ascii?Q?zYDeFb4KLFdnoFMnbV0/t2eG9wIT/HDXW3l07x0TKAfwpKxWL9NByu0L+XGP?=
 =?us-ascii?Q?aTZ40FugQWeb2mejF3bajajdiQGADs88Hgs/suFyhXvFv9A2/DNcVE+yfekf?=
 =?us-ascii?Q?l6MCNGTdLcMykBERLXiz/eFz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5329cae0-2685-4c5a-f35b-08d92cda775a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 13:11:47.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szZvpNX1Wa/o8G7xRdE0agBjb3LKZkkFXFrJaTJG8cORYq2GqmcLgl/yGdbdpPldcCoijjVI8qMH0/i15x5J3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coherent dma on ARM64 also can't work with mapped system ram,
that means 'no-map' property must be specified in dts.
Add the missing check for ARM64 platforms as well.
Besides 'no-map' checking, 'linux,dma-default' feature is also
enabled for ARM64 along with this patch.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 kernel/dma/coherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 5b5b6c7ec7f2..d1831da7afba 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -356,7 +356,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 	if (of_get_flat_dt_prop(node, "reusable", NULL))
 		return -EINVAL;
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
-- 
2.25.1

