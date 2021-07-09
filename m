Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5788C3C2239
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhGIKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:32:09 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:58450 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232052AbhGIKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:32:08 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169AMME9020730;
        Fri, 9 Jul 2021 03:29:20 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-0064b401.pphosted.com with ESMTP id 39pk1vg214-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 03:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhCJShCw9PbhamPSGleyVEWb3rwpamU+QsM3q21OxLzgtVoziM+wMfRXb4ZDTNFMUqnkHdEHq1ExAW6hrh6abTBbpP5o9zAQzlR3OlrO6WW3exiJlXR9n8RDLZWAaHug1N51rucKBMYpst3fAlSwQtl8PePe/n24IbVnvibMUcW3ctrYWJ2XoPElFxiFTw6XpC5lW6q5QUYhfh69socprmprCcAyxFSc9aXdOt5qGSlX2hCv5eCtAd12xMGYANWxSdJ3B5cC2YUajjDrtlNAGV49Pe7dylihNex85A1prvwLktWhoXsvDMW/mGI+JDxqscChG84VblgCRnssnidT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CMClUKfUseqhvni4N9tIiaU+3Yt4Zgc5LUUiu/wgHY=;
 b=RzQn0BMzTmeSDaTcSaOQMTBpIfSEe/JEcwmIDzuSLweID22uvAC1fwD2FPe+SvBEcmbf5OHt1CTowPpsl5UbZQy353WpFwBFpcfMzhm9KGHZ5YhLGNdRWIK9LCBRKh4xDUKY6qoT35N7KbGxuIXSuYiNtmEdLcgIsnHAQdS5DnIgP8Kj0Hae+OWSsQbkOAK/hkAoRr80GcyvK90CY2QUkWG3I4bxqRq3q4dsF5mcMqUuiqlSbR1zroDGgxDojacJ8RZptdQX3fgnK/u27sU6tK+J2Ip+2MaMAoOMG5gc3YTfsAZ4zAbJRpH7VEI/2cdkE5ub3cdcLFwTRml5PUbDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CMClUKfUseqhvni4N9tIiaU+3Yt4Zgc5LUUiu/wgHY=;
 b=PIWO/R5HwqNGbmfnK/wR4pS1sBoOBYzGvJZzFMMw/yIrYJffbjPS4Mv5HDOYjs2v0p9k+3wbQum+AfK8xhH3Gvo7niYFVquPrNtN0K6z4XqQnsC9BwGvTlTN6Te65m71JHkx89XUOl57MsXjuCyuJu5IDwcOSwjB9zp53oKONPU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3147.namprd11.prod.outlook.com (2603:10b6:5:64::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Fri, 9 Jul 2021 10:29:18 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19%8]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 10:29:17 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/page_alloc: correct return value when failing at preparing
Date:   Fri,  9 Jul 2021 18:28:54 +0800
Message-Id: <20210709102855.55058-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 10:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b4ae5f-186d-49b6-03cb-08d942c467ec
X-MS-TrafficTypeDiagnostic: DM6PR11MB3147:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3147589D5D9BDFC800E5F835E4189@DM6PR11MB3147.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZX5tUCZZPDtDBLrX3arnOewaJEzyHiMf9lSFMr4TLD0WoAmOpFwMy+C36UNvBD+LWrXtBaPQPAsqy+IS11yKCGf8fuk7UC76lPWV0Q3d57CzpbJ8v2Qj1NqnnlhNNCPz+wwv4LeuxmUajCAgUDr8bxUB/iJH2RgbwnwuAlcnA2+z8VaP4XYiV3q7ek8GDK1btQcRXAHWIYPkSErNLLWba3wUsk/d1OcoUi7WmqcFNz1CzwyP+YX0xFfH26zHYyGjU0Qf2X+gBw1pVfiJfuORfWTImFGvGAaPIG8BWx02tZf3CvweifDSaDeV6AYlWhqGtf21R+T3/s+PlqtcrbqAJg9ALLYRrBth9HlolNNxgNMOH41YSNyZe/an8n8DshefWnBYg9v0a4I5EQ0gXOG0KWEvw4Kd4MqdNHi/Qu+WPSguQfkSFUKL8geq7IKd1y7Lu/ZSoaoRD0SG9FPOp1w95if+gN43qAKTQAk7LAeKv3ZcHRJGaVAkHZxuKbjy4ig42mRSw6bquABAmc4eJLKLla4YtdWM8yWBQdqHzVYyEiRYqOSKfZ0sefhVBSf4o5xwQdCW4QpuIcFd6BFMFhyWeHJfdauyBMat8G8sQ6UXbkKieuTCSMjAomis6uUVLCZMqY2tXYRdSSJK6qtHMwDrqoE4+cWNafO9kVX6ey0HIiIC0B+eVg4oQ4db0VuIGQckYYpF2aGocP+kEno6jhn4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39840400004)(376002)(366004)(26005)(186003)(2906002)(44832011)(6666004)(6506007)(38350700002)(5660300002)(86362001)(83380400001)(36756003)(1076003)(38100700002)(66946007)(2616005)(6512007)(6486002)(52116002)(4326008)(8936002)(8676002)(4744005)(956004)(478600001)(66476007)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?132XRGzc1aDqVSFea2O/MAgUiHQJhswhtV2ZdW2ooqmRsV2ZsdRCibt7DPRH?=
 =?us-ascii?Q?7BdjZpbNtfxrN1vfzkeTs8P6xlPEQ5LigPWqpcHNROkK9XySYcslMCXsQiXh?=
 =?us-ascii?Q?H4R1xH3eOZGSG7tlIE/qznW1/jpyKUPw/fdiK6kUzPsBvlmDTuEdVWo3TwiH?=
 =?us-ascii?Q?gyFsp1qp3KL2VNa2VfL1lgk8ssu8cu4vszzdgDiOgqUYjuWm5l2Q9VIn1bj5?=
 =?us-ascii?Q?Ain59IenuR30/RXU1GJ6r//XcOFNgpJnSAQlgfqxrS09XX2e/542GCWDNBDC?=
 =?us-ascii?Q?dF6IHmy5ll339YZFDPNOd8PnOIWCaxKEfW//fPDsWULMc/OLbvFExmdtHtBs?=
 =?us-ascii?Q?ny5h7A9IDqqaBXz0OY0f+W5RQpm+bT72qXqi5IvDykAKOlF0yGIrSez+tBeT?=
 =?us-ascii?Q?JiMHTNrkhUtV34cmWiGlenyRcOj/HVhBuWJulFP74FUlUED8a816q7RqEDYl?=
 =?us-ascii?Q?fGhoDtHnuU/pYkHtVQy1N1U11MGYKPsHGt2KaMjMdM2EtXSnJ0vr3V7bKeXu?=
 =?us-ascii?Q?uusg716M6gG049KxbHral8avMv6uT/v66Q6DHRqISIuopf1XfNH8BMmZx2Gz?=
 =?us-ascii?Q?bZPNhXRriPgw9RQFNRGwycNegn70002+ZCobu2iqTqlrKLHd+D6ZxiY6X8wr?=
 =?us-ascii?Q?EgRZqZgjK8NznK86EEja2p8c3Rb48VIyyrf9uUOD4b16IPYpXlOdZuBHYFAj?=
 =?us-ascii?Q?hG87xr+2S21FgCVRO7LKFTWdSGwhRO1MvhEJu7F79N7Wj0/yXdrNuvXEOpKH?=
 =?us-ascii?Q?YUaR2iuL3V5R+ZSg+WwMYCocFT5Xm9MVYVWP2JE1vUwnDdDTOC9bSq9dboKj?=
 =?us-ascii?Q?1s+sbKSeVL6RTZYZX7o07e4jSmjz2Hq3RcYyC28lMsJsUqsDsFjBYE/QjbzA?=
 =?us-ascii?Q?Psw0n3ztOZ0FImZy9uxVJp4y0xM6Gv8d1XKulkn+UsZliJah76OoSmaCgooa?=
 =?us-ascii?Q?1DCw26SblsiE3hKMsJS2KTdMZy7NH9Okx4G3fyk8diA+hIioRJs2ieDECtYl?=
 =?us-ascii?Q?Ssy69TI56fl9fYHHnLwI5JvoZPM6QQedrtxzfky+fYETJ4FM+yF+hhH98j4b?=
 =?us-ascii?Q?x0OuLL6Vj08aowMw+M7+2yUj6AAfPTPN5k0YZla2MTPeCrfRJQchIwl0dUed?=
 =?us-ascii?Q?7Mwi+ffw5LOB2/k3Glb85aOPSoWU/1n4tXdf5Ie094Cu0sRkhs8KyOP1c3lR?=
 =?us-ascii?Q?4jxIJvuphKmnbVJ0IAAYd6OhIgH08adlJ9vBrdt/8JHDjk8CAjvH91m1aZTe?=
 =?us-ascii?Q?wVK0tXRUmGrCTH0NpehZRDVc9F57fHCBgeR66NqNU1IY6O6pCkcoIo+zHvgb?=
 =?us-ascii?Q?gJTvjabGHvMLkj2KP4OYG33I?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b4ae5f-186d-49b6-03cb-08d942c467ec
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 10:29:17.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0qr/A6y4svKADR8ue3mvcohVLDynLxPJW81VroKmlbEe6J2Y1o3K3qRAG4GfW8Qy6Wiab3t+sBddl/WqYiDNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3147
X-Proofpoint-ORIG-GUID: TVvUoJg1LepXaoOFWGYRTlu3VauxHFeI
X-Proofpoint-GUID: TVvUoJg1LepXaoOFWGYRTlu3VauxHFeI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_04:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=798 adultscore=7 clxscore=1011 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the array passed in is already partially populated, we should
return "nr_populated" even failing at preparing arguments stage.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6e94cc8066c..e9fd57ca4c1c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5254,7 +5254,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
-		return 0;
+		return nr_populated;
 	gfp = alloc_gfp;
 
 	/* Find an allowed local zone that meets the low watermark. */
-- 
2.27.0

