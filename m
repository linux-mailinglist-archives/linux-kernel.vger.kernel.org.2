Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F433C223A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhGIKcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:32:12 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:34454 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232087AbhGIKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:32:08 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169AMHio008376;
        Fri, 9 Jul 2021 10:29:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-0064b401.pphosted.com with ESMTP id 39pjyhr27j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 10:29:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9YFJNsOn4sNH4F6jBCAibhVOPd/rRSzm9wIWdpI3OTEXJ7aUsJp2DzzisowEudch2CsWZfGkUhXoyfETs/q5zZNbAcHN2D0GodmIMiStCCRFVGXNxgyEEHcNiUtZJvW613i8Bd1Inx0WQuzB6wM6PMi6eOSlclr0k4eB63hQO0EifrtprzP7Pd491cyLhxfvb6ox3/vSh4eVE92EJ0XlyYyDJ4/13IzdPEzSsChmrm2U67MlgGpVJMyjql/veCgIor0/MmLZib8GoGvWvxpyhUIFV2BZmXzBSxoUmLdDI47QV43V06h9W84YAQPunz513Pa9QVV4P+dvLQLR1TkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxrVu3VaR9lStAi1dxSWnhqWOgJP5GNx041on9xydYM=;
 b=R07+1lUlc7gwgOPaWaEkWAPJXsAnGzAnaxYRP5n/sbhMgozgcIrfL9G/5DUJGofSVSbs4/u/Cu33OSWFum6IkK1Z4jnoQTN3LYGLfdIGwKIGfiL9YgrD3th8XE8cVNsukAJxnhD7Ex8zcP57mVf2KEMaj7GHhb0KoggvWktXvpS5/pxN/VuuQmT4mElifiupDrTZhhkAnb6TVkTCQEcioZsL1u3NwXwHZ0iMHOGn5fYOtjJLQfxd33qHLuQ75m14PzHeYI+lk9d2QG0QhvNseB7AOZh8OaENEEwM06HAVjUCrpHt/KD0C18jBprjuLfeGyZHEKU+CB8Tc9BzEKlhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxrVu3VaR9lStAi1dxSWnhqWOgJP5GNx041on9xydYM=;
 b=ZOtHA+ocTnt1WME9ucvwfzMwXXnGgr39OvBX32weOL6rsLKvBgJjAwhSiN0HHX87f3NvnoHxpfJA4+1FRVxj2YpM0rkd7rqSu9xEwuQaphe5vPHOACz1R6Dlv16xsQVBJuMx/rZLXUyAP8JIzxGhhXOufNso0WueRBrqDnXkalg=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3147.namprd11.prod.outlook.com (2603:10b6:5:64::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Fri, 9 Jul 2021 10:29:19 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19%8]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 10:29:19 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/page_alloc: avoid counting event if no successful allocation
Date:   Fri,  9 Jul 2021 18:28:55 +0800
Message-Id: <20210709102855.55058-2-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210709102855.55058-1-yanfei.xu@windriver.com>
References: <20210709102855.55058-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 10:29:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d89ec5d2-f7e2-4a3f-b815-08d942c46938
X-MS-TrafficTypeDiagnostic: DM6PR11MB3147:
X-Microsoft-Antispam-PRVS: <DM6PR11MB31473EA075B8C61215BB2473E4189@DM6PR11MB3147.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtzqEroO1+mVGZ+HO3ielSlnhqiq4/oYFYSNdcyUPxYFHuAs5iiqTizqHnuu/DE+v2bRsml1nDlVD+vhDcMzcuMpmraLWf/yb4bxeOEoJIrL80/3Ct2V/KLnSUxFCfBm5tcMhnjE8hb8eOkcXANeQg3DFHLBxwvSHD6Qpjr3ilow03RQM/rkU6Vi1ZZHVT4v1fFJcXfgiQj2xHMxSGJDLRPm+jQL0ZPxIqY4ozRBBPEXebu5OlS8rdkvYq+1XZlk2v6vmYvoyscG5HJQQTFGeXdL1SztP6h4tzZy/F3CpnTj+JBPT8zXHJNcZYWBr9pMJ9hjcPSwYV/2ysO6W9djOY/joGMcGgeOlInX7nuBJsDsem9gB8YO6Ojs1/OVmPYgl9J+pOJUl2xGcOe/PcCYTchSPEFrubqmQ1ayjMy3cwFCA+dielYFz1ywMRecLEaqZG8wgsU31D/aPwxajMmUPzonPFtwKWrykfaDmQZnyNkom/gF5V2PkOnGuk+cmCTRBZnYA9TNbDWugZUPv+KZYUEesK30seIcX3N7Sqtw45mwZrSBlbrvrXFiAK3jRbB6Un2sMM2yeyQFawrKJq/5+N4Richm61BG5qvBP10leCIZlmOMZym9ij8qmnu6gQXXfAlvvB1tjJbQreBagWyJ96wfzkffxSh+mNdI1a29JFPjH7Fp7H/ft9QyzCReIOlLA7kojmTHAEcuI0mmigktTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39840400004)(376002)(366004)(26005)(186003)(2906002)(44832011)(6666004)(6506007)(38350700002)(5660300002)(86362001)(83380400001)(36756003)(1076003)(38100700002)(66946007)(2616005)(6512007)(6486002)(52116002)(4326008)(8936002)(8676002)(956004)(478600001)(66476007)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yitEsd44nkZpngd/M4xnl30C4USsTmoimwV5SvLzhLwfI0OCBBez3sV5g+ss?=
 =?us-ascii?Q?UuDGjMoXR1YDFJRNdHI125kFitefTY9EpkG9gXiKAZISWtW1IxjREgH7Cl2E?=
 =?us-ascii?Q?LF5jmicOU75lE919jWBpu6G72kGlWSSNOPF2xUmoHjHIV/MUuw6PKTmzjhSM?=
 =?us-ascii?Q?zx3B1Y43GGb4tBqBzlTZyuobjwxLZRGpAsvg8VtPI0L/t0iYGh+Y7kfgHPyn?=
 =?us-ascii?Q?WxnYhktG2l4Nnp6yXMbKI3iv3lzP622aarO13nyo3rolgYuQSk62Q6QSf6+h?=
 =?us-ascii?Q?jbLRj1bXsyAnEsHiNEjhp0Lb5SZyIBn1hKz4fBuE1ckgi1gYmq76+fyqJWWb?=
 =?us-ascii?Q?l2veJmd5KWkqKcKhMW2u8A8UN5YY7+DGe66RdHpaCelPj+GmZYVB0OaauCVv?=
 =?us-ascii?Q?cv6y6+Vi3AzuqXRu5c4N8IJDS+f5OmC++9qUG4nVsncca1fkQquqU4EuNHmI?=
 =?us-ascii?Q?NhjdgWJrp7XwyK0a6VrZB2SVJUgMQbhNFBS5PZDDFwjNl+iAk+X3Y2sxg0DF?=
 =?us-ascii?Q?CaSXU+QfVO2FMZz9Loiyt+KgrcSVXRxcrD1LBNO9NCd1VN7j+z8QeetllIpX?=
 =?us-ascii?Q?xxQry6ZecgE0+zYW9U68D4rk6qUKvwfLIhPUJTk/wZB46T1z/bQRY2tO1J15?=
 =?us-ascii?Q?9F1IxDj1X+yuPyPQAlf4hZmTjdWuQEKUXtTg6rg5ZiWyJz5b4fq298NYd8IO?=
 =?us-ascii?Q?5NT9hgUMvKk5B8ROZUp4Z2Yz1/ZLnA16mEdl+iE3c8WN1ElWLn4wLUuY+6jy?=
 =?us-ascii?Q?JPXM8wVWt5hMAY1EUAz7GQtROkidDiYbbZA/jjw2rXwt8V2Yg/3VHbCgcVRy?=
 =?us-ascii?Q?7sDFsenYH5281ckE61nR2grWDH5wttv1ieY+gAlUmbMV+Am8fHdZReXy1zt6?=
 =?us-ascii?Q?ptxq7G12Ems4sXQFHnMIfJOoMW5v1zUz9aOhDQSQ0vpDXmWXS0i1ToVeNRTA?=
 =?us-ascii?Q?aQm5IcpTY1vw/wDESw9JdkVAcl2ZlXehOleiO0eiE4jYutsH6cQ8Nb05TFpk?=
 =?us-ascii?Q?6RYst8Q0JPkO8hrGAdkpiz585A73q6I5LWxexyeb3rxCtxGdr95SJSePUrhM?=
 =?us-ascii?Q?uoklpsNdQClrmNv/z5ibPWXTYaIy/UYx6IvY9fOHyLxOR1iz+nJmyRMyvnbH?=
 =?us-ascii?Q?PKcd0Mj/J6D5vvJ5Txfw84rVutT0RUK/0CxG5vk0Gl5suuWgsZGfaQ9wgcEm?=
 =?us-ascii?Q?Cr4VMOkUncstfBCkSRjaIHBUGDHhFuz9kh6gBvqcL/NI02r8oBYCcu72S9f1?=
 =?us-ascii?Q?nQU153Z5db+OZQzTDM6zpZNBAOGHa3lqqNRxu0SU5t5TM/ZRUD5QJ5V1nX5C?=
 =?us-ascii?Q?vYcQ0fOZu4PLwTdYEio8MTE6?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89ec5d2-f7e2-4a3f-b815-08d942c46938
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 10:29:19.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIknUM0mzfy2HORmBBhAJIasBd5GblKqeQs4gUUzEexsB2UlF2N4CCg/XIuIXsEYBorgxJw/VIP38KZv78e6GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3147
X-Proofpoint-GUID: t-dZj-zkOs2_dc1oq8vjjsu829anhyJz
X-Proofpoint-ORIG-GUID: t-dZj-zkOs2_dc1oq8vjjsu829anhyJz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_04:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the nr_populated is non-zero, however the nr_account might be
zero if allocating fails. In this case, not to count event can save
some cycles.

And this commit extract the check of "page_array" from a while
statement to avoid unnecessary checks for it.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/page_alloc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e9fd57ca4c1c..e25d508b85e9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5235,16 +5235,18 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(nr_pages <= 0))
 		return 0;
 
-	/*
-	 * Skip populated array elements to determine if any pages need
-	 * to be allocated before disabling IRQs.
-	 */
-	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
-		nr_populated++;
+	if (page_array) {
+		/*
+		 * Skip populated array elements to determine if any pages need
+		 * to be allocated before disabling IRQs.
+		 */
+		while (nr_populated < nr_pages && page_array[nr_populated])
+			nr_populated++;
 
-	/* Already populated array? */
-	if (unlikely(page_array && nr_pages - nr_populated == 0))
-		return nr_populated;
+		/* Already populated array? */
+		if (unlikely(nr_pages - nr_populated == 0))
+			return nr_populated;
+	}
 
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
@@ -5319,9 +5321,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
-	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
-
+	if (likely(nr_account)) {
+		__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
+		zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+	}
 	return nr_populated;
 
 failed_irq:
-- 
2.27.0

