Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD342E92F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhJOGmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:42:31 -0400
Received: from mail-eopbgr1310094.outbound.protection.outlook.com ([40.107.131.94]:12000
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229716AbhJOGm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzHeBOYEhOTjLG4ooiIFDteJ+R6Aab7TsFC20gPmVAYlrrMfWF2zdLdVclRBY8/ts98V1H0JYzbtCdJxPt2kPG9L3Ekufd+1Whr4DrAta00i4VhwuSRqa+fiou4Yh7EUZeC72x1HBFdWH70QU6kh3tUyjEO5BAFs9oc8gkss3GnfZe9Fr8DaVf03oPwZGtf/GIVgo9fJK5d0G0I4ML+GfkB2oED2o7QKaFvjaYN2IZ8pvD6W1tBcy/a3uRmaUiYOlAfLlT22xER/WDMhZSuuYGjuZ+YCMJybkpnuSf1mjMCXJ+plGLEK2fFJJZgTGw4ttohaNcYSfXTIs0K5OcZ9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2squXtlGxA2aucNtfIMRC2ZGHTZ65K7G0hmtySSHCo=;
 b=J5ozeMt44txwTA34uzKENeMlHlJXm1+PbxZljmbP48ivs3I0JvB8vU8JZsZAli10Et2Wxx71iLxiqW20gh9TZFpk+W7FlI6qBw+rUOLGAZR2CNbhDPuMRMC82Owt8iH7oW52PxhjmVcZOyQ2603WgtNj1xl9wa0L1SPuTV21vBoGgSfWjf8gwn+2SI7LnRXgX2/vRMHtrUKJ7cK5cOWZKgKiyriaG3X4JrQpEzSK+8cCrhvSY+3GlkV27lIhX5XLAV3qgrt+m1t+FTc0kVWQgkQgDW9czU5bHMSECIsnfrxN7FMoZ9N9oQ0k8vDDRGV11sCbYKBfz37V2v0ce2PcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2squXtlGxA2aucNtfIMRC2ZGHTZ65K7G0hmtySSHCo=;
 b=nhAc5MU3UM1wSqG++1KsijLfWGEGUKJPXngL2jalkytoh7LecyMhPU/+itCet2Wj6EqNZwQqcPflunNgo9PEnASq5vDBu2U+3Jbkzi4kZ8dRmLV2EBhp+gNCAn+Ca43Le7rARwaU7mgNECvtPJMJZrQZ3vk91ShMi7n4GS9K6tA=
Authentication-Results: lunn.ch; dkim=none (message not signed)
 header.d=none;lunn.ch; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3449.apcprd06.prod.outlook.com (2603:1096:4:9c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20; Fri, 15 Oct 2021 06:40:21 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:40:21 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] ARM: dove: Add of_node_put() before break
Date:   Fri, 15 Oct 2021 02:39:53 -0400
Message-Id: <20211015063953.8603-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0035.apcprd03.prod.outlook.com
 (2603:1096:203:c9::22) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HKAPR03CA0035.apcprd03.prod.outlook.com (2603:1096:203:c9::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Fri, 15 Oct 2021 06:40:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8926e8d9-1587-46a4-dca5-08d98fa6a875
X-MS-TrafficTypeDiagnostic: SG2PR06MB3449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB3449CC7A73108FA5B7515D39ABB99@SG2PR06MB3449.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVKDrxq5g2VdAbusMppnzUbytEEbA8Ll+HI23+22rCkaHbfybBm9gYEmQheoh2zdVAOkaJ02mMnNyqf7FHAxJmmv5bqIVsBgKrsOFonIMLBQse3qHU5xeRP8nmNeh/oQcVuX34ntsLw8V07tYMkDPEN7NdZfBwLXFyp7Y1cg87VFSN89eulM669HZViSplCPbv492rp9pxb/ycaIb0fx70ayFo04IXEbl14e9dw4BaYitTvkUHdduN30aaWJHJHrMWzz28/bSC7q81ljHMmm4OC8b6sWBbWm5dpVfcz3mTRYyew3OoV3fnD2kRvJazeJ+xC0yQeM5a2Fgxpw3s8cCA2ecgd781sURB247tA1yt7eMvo1X2Y4dP7oqtgAONG00EKJq02ThXU29pOWRJU7GiqjT8fg4GAElw8Gja6OxLPDU2DMEvitVOZ4Ef1a6JjyHkBVY6LT3rqXqa6MwM5OKZcflbUx2aeFgdpHgNVSqo1cdWkifVRlJ8ZetwxXoMz4/5Y+a2ogZZzPv6xTZ+13ZeKRoUjmRdQmKEEYJqsv+qng7T3lV28sEBscW3vS/ev3Q7cU4QCm3SeOS6mqKORO5v/eKcojmGSozoRqBP7XGMwQqtenBJH3tpTBIgCio0lKj3JrrQO14NVFPK9kgGNydxXp1CKWk+EyMv/TtoEgdDz7XcUw5oPznFs30iNYHTPSSdlsXEiNtkHx4FjKbgUneg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(26005)(36756003)(86362001)(186003)(52116002)(83380400001)(316002)(956004)(6506007)(6666004)(107886003)(5660300002)(508600001)(8676002)(6512007)(38350700002)(66476007)(66946007)(110136005)(66556008)(6486002)(4744005)(4326008)(8936002)(2616005)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YbdB1sWWrbb1QDi4sSvQ/dEtZoR6XCTNxaV099u5PDOuQqhZeFGvf+MbjQ4R?=
 =?us-ascii?Q?qA7e3Z0MMp01t7vjLr9Iw1aHVtY6nB+/vlUKN/+YIMRVOkhAmE5T8Qkxdn88?=
 =?us-ascii?Q?rQLQbaWkgB5TZo07VyE4QDOZwQvB2rpLE+4W9D3FjmDhlDCJbADJxkSg1fb/?=
 =?us-ascii?Q?D7WgVJ7UdoxYLSLfRNSMxkzoSAAOQBfdoG8x5bF6oM6Ak3kJbw7d6YWREs+T?=
 =?us-ascii?Q?DK11kRc/Dtw4LO2HMavVHNLAr3n/5OtqqD4tBlEw1vE0Vb0nHvFijyj+5m16?=
 =?us-ascii?Q?hMrYFbzcnjgqysXR0gRbk2NvU+eMuIhuzDpOSOxlEGCJ1VXmZD2HT027/Aoq?=
 =?us-ascii?Q?qoi4xnAKW+w6jJDe5CqlLTBdAcl7BguCY+ZZwRe1cI+trYW5BS3UNeYgoTgH?=
 =?us-ascii?Q?ksG0Pa9bxaKPerK6TafhVt1y4QrTQXpcywGqeT/xYtVP3VlQQNPQ8bnSvkva?=
 =?us-ascii?Q?2o8vu0TF60GGrxu1Wy1kuTddjcJFU5tN8IDhUkEKbmjguYGjyyqBYl7tTcq4?=
 =?us-ascii?Q?aKY5r+5KhYkrCKHm+ImKFXtYEx8HfzELNSIAQrqMRKa9CmxsHuXGgp5tfCCz?=
 =?us-ascii?Q?b48hyAU63faEmJ4EAmnGao7TGm+pRi99J2Y2oMvq4yS1ihZUmOsv0pEXc413?=
 =?us-ascii?Q?dUC6/BuAeXHtQ0Pj6CXubRBKjMRUWs3t5Oqo9SPbAo+j0tEuZAkffgV++tw6?=
 =?us-ascii?Q?fOR7PdjIvACwubdUc95gbMbQ21kVNG61t+FLsb809oyxYKOmOoNVN+W5cMn6?=
 =?us-ascii?Q?Q/YBuCYSH1hzgJGlzux+zDujGH4G9u0zBhAzui+3oT8Oc+79zPmRwA0xnOMX?=
 =?us-ascii?Q?8KL73LHxPHL84Hu1/OKOB6hXbnmpWvv91VRBNUsm2m3rj2An9ceGTUx2m/xz?=
 =?us-ascii?Q?XoxDL9Hwv9N7ciKIrv4Xpxy5qwCwCS48R01GvXNpP+j49Qwr21782xChtBCu?=
 =?us-ascii?Q?98A0OMqM5eh7zewOYAOtaFmuBGz8m8j0YU2x/ypUAoOMhXXwb8o5tW+dbWPi?=
 =?us-ascii?Q?im2mT4ZarOs+7rq58Jx4A1SRZxYupzU6rEIHEcd//Wlg0KHDsN0qGHOYwabn?=
 =?us-ascii?Q?BfsfUaTni1oQK/1KlyOzAU0GFERKYYhFnRFYu6d2qMel/RXdqZulHkr6vD0B?=
 =?us-ascii?Q?r0nwDb3Akyoy9oWYzIi91EK9jMd6GYhv7QU9t3sSZUDAcEBniY6ZgyU6jQGp?=
 =?us-ascii?Q?P37w5LCSSNNxx3Uwda0ZEahj81Yhbcr2rAt/yAqzl9bYsvbJdKUMCNF8SBWH?=
 =?us-ascii?Q?QCsddrHFmN/lCAejn1QhlZpttrC8rrX3bvB5pyoiVcXulbaLdmCy8FhdMdxY?=
 =?us-ascii?Q?8c2C3nXfGNdhfxyeyFI++Zdd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8926e8d9-1587-46a4-dca5-08d98fa6a875
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:40:20.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Us7vN7TeHLWiALLrePFh/LjNakOTjHhlbpgC7peeZwLr6JuHiwhYP8LFPHy8oWGLb9H5Rkn8VNjiVi8H8NYYAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3449
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/soc/dove/pmu.c:408:1-33: WARNING: Function
for_each_available_child_of_node should have of_node_put() before break

Early exits from for_each_available_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/soc/dove/pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index ffc5311c0ed8..6202dbcd20a8 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -410,13 +410,16 @@ int __init dove_init_pmu(void)
 		struct pmu_domain *domain;
 
 		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-		if (!domain)
+		if (!domain) {
+			of_node_put(np);
 			break;
+		}
 
 		domain->pmu = pmu;
 		domain->base.name = kasprintf(GFP_KERNEL, "%pOFn", np);
 		if (!domain->base.name) {
 			kfree(domain);
+			of_node_put(np);
 			break;
 		}
 
-- 
2.20.1

