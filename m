Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D74364AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbhDSToI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:44:08 -0400
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:24299 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233739AbhDSToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:44:01 -0400
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JJgSj1020439;
        Mon, 19 Apr 2021 15:43:25 -0400
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2053.outbound.protection.outlook.com [104.47.60.53])
        by mx0c-0054df01.pphosted.com with ESMTP id 381g3bg083-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:43:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln8cuTG9NOFNCSdexkBi7mBwpiMWvekbPSlTsCttrd38yt/R0OS2J6EQRBGKbIEypkCtKecJPuvpmGD5Nt1MTBHDTOX2TXBGUWCPaPy8LAVFvLfVgG7n5VnRrp7+hY/3xK9N+0hflRIldK5yTy3RUU9/JVDuMu5O2IyMMrbBRFrD5x/puJxmLm8VozXVho6qTzjfU1sFHTU0jh+xIXocgPrF3JnHSbYUtoHbHSWnHmcfe+0Y72yteLnSc0LigGPS0xqKqYKPNTXH1C0eDd1biV6WFUckkm/shAWd5moa8YgnRF6EqIelTfx5pfw0B0HhC6Ryt+L8QUHrZpvJDzk2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRbwKJEkYf1kso9oEmGGMUSYDlPeNm0y8+jhISdKfA0=;
 b=eJBzZxTh8RypJU4qtN0qryYKgW5s+BiG56O6QkWw77PZ++UARLyEcxQ6TrytlaBTTc+F92VIigiDksBcR45YzoZBYKtGUfj2fPbCURrFWPybsbGEmZkDIc+Au3fAz0JcnnaDKE2zeBBP7R5H0EoM+AFowUyJTHTVEYBbMSlWS8xgthGpRdnM62KxgOnJA1+58yMSrUKNIEBNnBXbV2bTFXe+g06dAwPs9ZSsEQcbf/dOl7pfnaRtAGSll/UyU6NDPp+wqXrKaN3mP9pD37mnfpC4bB6clnegkT1QyrWLz88C5rqNDU9oKVJuhIIZP4+L9AN8akEn5RJ0pFedCqjH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRbwKJEkYf1kso9oEmGGMUSYDlPeNm0y8+jhISdKfA0=;
 b=VZKEx3JGO3MuIcvbwX7WrhJPMFRnfrenlfhtUuOvqDOJjZ91z03zxY1GsgMDN6oFwZ3ivjqkM4A6R8y78i87Ej2s7rQKD4hk7LaKqjHaNrwlZM/FFMVh1MwLWNIjRcb/pp4uC2Q6Z2rzzI+Gw71QBIWBRXw8cQzN5La/kdAXGrE=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=calian.com;
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f::20)
 by YT2PR01MB4302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Mon, 19 Apr
 2021 19:43:23 +0000
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb]) by YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb%7]) with mapi id 15.20.3999.038; Mon, 19 Apr 2021
 19:43:23 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        anirudh@xilinx.com, Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH v2] irqchip/xilinx: Expose Kconfig option for Zynq/ZynqMP
Date:   Mon, 19 Apr 2021 13:42:45 -0600
Message-Id: <20210419194245.210550-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [204.83.154.189]
X-ClientProxiedBy: MWHPR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:301:15::28) To YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.83.154.189) by MWHPR2001CA0018.namprd20.prod.outlook.com (2603:10b6:301:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 19:43:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d74bdf-46e9-4586-0b74-08d9036b6493
X-MS-TrafficTypeDiagnostic: YT2PR01MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YT2PR01MB430246651EEF96D4BAA77009EC499@YT2PR01MB4302.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arF7m8F+rlIjDefvIUKSgul0uWa/208Vf+45EhCRXx3vR1UWQ18qtsWGI05CCd/5wENUBB8pm4ST1d8TNzvRSbYz4ntXoMpfC8j02JJhc0HtJSpIPNzLuI6B2jmi3Fbd3i9UOXck+lUHasEOFPMZ0i75i1QksmkGUcCPhdrEajnKT/alDQ67NA4TwLBm9CdsvQ14pS8CNwkTDAG0GJVHLPDEEXzFBBFUGTfOH046AmBSphbn1jnzjaEYJi0PuKWAfQa+AbuqoqATkRW9oXn0WeBKYgB9rEOtvlyI/F5jW67HqCwuk7H4Dn+lr4MLZ4+3TEB2UjhsqSnYTLjKojIj/b+wi86Hpa2fdarvNtpq8gKfRsxtVbKLJ/92QqrjO+2Ysur9ru9R2a01a52Lx2cOIfahRU8LHpTDvByajxJhe3DuGlv/qLN53WNpOWjUtXzO8dNZiMOLtCWYTfou0xgXri2vo4nd1JwpcWkB2pSxsFa/eePsV4IM+GUZE8PnWEndZ2VKWI7Dc7CueAwkpAscivLCtJU2aZFKC8/A5q0uYUHGrr4kxEPfxCZ4hfUeoE2m6vh7sMn2VJ/KImYacH1efKEBv3IuYb26r5g9VSzyipQ8LBDmrNB1U6SsLre0fe6vz+Vcu5dHkqM2trqWY2ZsCVIQLRSWNQmRXMYQ6tCleHZ3/BhQGgxEF/+NUy2hM+VE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39850400004)(396003)(8936002)(6512007)(2906002)(107886003)(5660300002)(36756003)(86362001)(6666004)(1076003)(4326008)(6486002)(26005)(316002)(8676002)(6506007)(52116002)(16526019)(66946007)(66556008)(44832011)(478600001)(66476007)(2616005)(186003)(83380400001)(38100700002)(38350700002)(956004)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qeDjShXbZAXHKpV90P2zkmYt78/GolOJyZ+KtRVRTQZCnGnTxXlujubd1ysp?=
 =?us-ascii?Q?mXAh9BVIejwI99K/YKbMAphfmWw494qSzRfoZECnELIpgTyQWJhwD2s4mgCV?=
 =?us-ascii?Q?4TIhq9N4JvtK3+CVngMS03HvTPfPMEtBtP525Rj65ZrPxOUQ32Eq9eKwQvTA?=
 =?us-ascii?Q?5p3E0T+3VCEoebx0yKmSK8LZdHA6L1LO+TZ5fHoYI8fWAr+k6oMRWc/I2Epe?=
 =?us-ascii?Q?tl6L0NfXOtMkEsnUt/+6/VKUUPML0r8pFKZCW2KI6faxHduGCnfoxRZu5lCW?=
 =?us-ascii?Q?An8fPJCeGIDdb2cZClzYk7p4HV+opU22gmzYnI1NR/5Ze02o2A4uPKFFhDZg?=
 =?us-ascii?Q?SfpBV/lY3Dh+gwdhXqpzh4C7P0jIBRTrfHo04gKa/yIC5OYuDVfU9WiNeZnT?=
 =?us-ascii?Q?H3+HCZqqt1f2Yyu49BUosWo8khmRonVByYkyRmoYe4GmpT0wxZkACbLALwza?=
 =?us-ascii?Q?/cn1o2xX0benkmBJkyzqiKumJTtNQTgsqhlaZQWhon/CxCyUqGiAvvPn3Vnx?=
 =?us-ascii?Q?MWT5c5B8HlpyDEegpdyXzV2SVI9U40cqx2x4kuHlfKVQ8nNRUx0UAzNL107G?=
 =?us-ascii?Q?YHR3+MuOl+fLW4tq3J50ZPydltqEy2qERvsejDMGdb6Lp1+BseTpFBOpCsTr?=
 =?us-ascii?Q?/uOhgTPfs+kxkEvYVthGbrtHpCHvm9vWEdwhq+kLO/ockNYyd2Ut7r69npcd?=
 =?us-ascii?Q?MPErg378o3L3C9Pvdfoi917kMm9fTamQiiG5aXJHyrAmO4bhoYyRGBwWodXf?=
 =?us-ascii?Q?Q2ca9yn8vXTMS25BQqnVUB+xRe9bKH+c8xXdLAkTWz7SLerb83fDdKoYdGSX?=
 =?us-ascii?Q?m2Pe2nH1QHjFMZmaDHNcq90I3SGg7DgKmgq9xjt+DdXD+/TjhrTrvWO7AUqO?=
 =?us-ascii?Q?TqdkW/kJmYYGdQ5x0Pcg9YTQc3RmCtvsyZQ5yJ+bG1sT828rBEmsnxlYFFTZ?=
 =?us-ascii?Q?xmEpxWd7fC9B2DLBQaPRQTPq1rNE4SAW4scUu28un0tis0tPp33GDmtUwbI3?=
 =?us-ascii?Q?flyHEVkD4alEJnDWoUNZdwRIutE3xKzOzkCvPy6DXbDh1VTqJJG748xeGKt5?=
 =?us-ascii?Q?1uiADkvqwzQ38UPy9PnKEgVZRdmyayaCVrPSmYU57s8+yspIo95RMpc3qCIs?=
 =?us-ascii?Q?MV+0VZJ1xTsoAaqLIahIeMQZTghsMo9w3NgmRBfTQ8mdY+B2vJZYDLWG+ujn?=
 =?us-ascii?Q?BozSaBarBwQC0PJEGsO+CiiOMmunRyMMzw8u1GMba8uIm6ywwwtJlm3w5e+n?=
 =?us-ascii?Q?tXsHdjzQCwwRcPgD4dlr7UtcNUiQga40/F7fjvsnpS89h0+XwAsc0BcOE2wB?=
 =?us-ascii?Q?6LqbU7frr8tShnFSyANdn+Ox?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d74bdf-46e9-4586-0b74-08d9036b6493
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 19:43:23.5087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2bLdvjC94V1x5vnjCPC0+guEENmEGHhvAx+3DFXmxTLHJ38U5ATVsM92sdcVFhjTSoGG2iWNMK+AfUmb79wZELfE8jOYpYh4zi8aljfjrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB4302
X-Proofpoint-ORIG-GUID: DLoNMlfssdEW2L7Zb_XQB8jU8NwJoysQ
X-Proofpoint-GUID: DLoNMlfssdEW2L7Zb_XQB8jU8NwJoysQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=556
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the XILINX_INTC config option was hidden and only
auto-selected on the MicroBlaze platform. However, this IP can also be
used on the Zynq and ZynqMP platforms as a secondary cascaded
controller. Allow this option to be user-enabled on those platforms.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/irqchip/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15536e321df5..1020cc5a7800 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -279,8 +279,13 @@ config XTENSA_MX
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config XILINX_INTC
-	bool
+	bool "Xilinx Interrupt Controller IP"
+	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP || COMPILE_TEST
 	select IRQ_DOMAIN
+	help
+	  Support for the Xilinx Interrupt Controller IP core.
+	  This is used as a primary controller with MicroBlaze and can also
+	  be used as a secondary chained controller on other platforms.
 
 config IRQ_CROSSBAR
 	bool
-- 
2.27.0

