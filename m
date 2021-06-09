Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9EA3A1A43
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhFIP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:59:17 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:5346 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230311AbhFIP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:59:16 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159FnHRs009309;
        Wed, 9 Jun 2021 15:57:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-0064b401.pphosted.com with ESMTP id 3927fn16f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 15:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTlUX5SwwYXi0O4PW29YXaqUzKbOarsO4bGfeyhpLfVChtrQjiDlCooLCUNkdWmiSvd5TfvqMAqItbke/pRgfSDUf2qj0CmrPmPTPbF2o8yR8BwhhMari89vBqAezcrfvn2/qWR0WQgyy0UotCM0CMGVwSHxScvEthfg0BicHU54i39zvTOcBiVW3IPTQQxSLp2CNRLvaUBIcVdJnuq42kGz44lo1lTIxfebxmz+tbMq5nF5kpE6/ANaIRo098xyIK72Az9kUo0383fG9QTdcl7TKjvlKcDMWp6u+GG4y8S2PbmFvxBX7diwCVEE7of4FAJbDcxOSCzmLUPOdojiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5ebSAbdI+qMccM8+a20mfjE0DaWX0iGXJNa2TRYPao=;
 b=emZIjIuAN2Ykrh1XpBpiF5IY/zrX+t+1v+7353ivATV/4fdvliM4he1Six11A8ALbnKshPRPgMlD1vuNtRPphvxqEBerg+4SodTLm+TeBv64Y7t1lLvNL9YW0YQRe0JlXbwobcF2UfWDUzj6tfYmKJ7R1RIYqeIaJKC9BWFpeIPBRHIM9bvYtxpuLP66R3B4GDYCZj+ydEFjiDYm+PTFsiN21Fy5/tg4/IsdSHyH4DwPze+Hoo1NhNvWeE5j86FaqOswY4UehKMYWwCqiRQ0TfNbhkdYYP0H7aZlnYftuWn6vPAJ1PZyolsV+xk7DSHZZx/JKDZROftdUYTL8sE5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5ebSAbdI+qMccM8+a20mfjE0DaWX0iGXJNa2TRYPao=;
 b=Z1wF7WtnNCrk2bOBFHDYGVF2w0OtQS5lfXTd2IsGdhAdNyeZrQ5GFw+nIMD8IHNDaJdxDbJLZSSZo1va8M8WWHPnssnNNcnerAE/S6VMXvy3iQ6oVPcUTKhLg/mIQPj/2VsmgVzA8pM2imN939oIbgNnJ7o9wPf3Qt+Emxcxgps=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3557.namprd11.prod.outlook.com (2603:10b6:a03:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 9 Jun
 2021 15:57:12 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 15:57:12 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/kmemleak: use READ_ONCE() for accessing jiffies_scan_wait
Date:   Wed,  9 Jun 2021 23:56:57 +0800
Message-Id: <20210609155657.26972-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:202:2::23) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:202:2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 15:57:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4d9debd-ab2d-46f2-d267-08d92b5f3e33
X-MS-TrafficTypeDiagnostic: BYAPR11MB3557:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3557F2CF123E4C096FA0F72FE4369@BYAPR11MB3557.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4YCiz2IFhtbe/SHRJS6BijHFQA5GgvF1IpU2XRlHQJIeDyQdu+kfL9V0skqaVWWpxjoh59Nrmyvah4bYKDSLviAlnGXnvs++YyfYRBpuNATS3t0QLvzEWPdkEMXxii09uUSW0o981bLRbym9twqjjgYjipPvu4knzw1IHFW+zZCtc3tz+VMoJCizaFRrwfjYtyFItKMHgz4+yBbHyglxU/a3fxI/iCyIqanYOszvlQ2BTTnFb4d/endiTqCIbgqX15RBYGkKmhBGkmgeOD1VYgw+ngX+52epw6frBMZFyRR2vO8TnUmf/XfrygFqIs2XCUyqn4IcO27Vp449oFWtnMaKepIDqCnS/zA8Q0YG6Mc8i7rYohX8cp88lkCHZtCYzNvFvIntEflMym40SJlbLYwOSY9OkjyaHVdlDl9wXz8ac7DtjXlf5TeaVpfBys2z6y+a+wPMTotVGXhLm50tVsPB67YYftC//OoscXwJ/JRT96KOIDLX7sd2XewaZS4hFyOwRjcsvLPowFWSqZnYj69yTSER61gpvA6zbihlazBKQ+/MAUKM2S9DBeJ+cvCWdA63SAfMxjagAXeBQm9XOz/5BIyK7iki1fbhg9llFSAbciOjMwtD1X/4yOT+xseuu6u8A3c9YkoE7w45L2prx/tt2qA258CLa1cUPx8u78=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39850400004)(86362001)(36756003)(186003)(2906002)(316002)(6666004)(66556008)(66476007)(956004)(8936002)(83380400001)(4326008)(66946007)(478600001)(6506007)(38100700002)(38350700002)(1076003)(16526019)(6512007)(52116002)(26005)(44832011)(5660300002)(6486002)(8676002)(2616005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCXOQOQQJ9fDop+OkBw6dxTkL+czva9jOEcrOhT8YIrxw8HZtFL1JmnvMoSh?=
 =?us-ascii?Q?/HWay90n/G0ln6OBa+/0xvPMDpa8tN0A0e9fD/0FKzcRLcr4MmRi5tgUrydI?=
 =?us-ascii?Q?i2qAcLSanTG3Iq25BkRhpqaYMVKcdqfdsI9dH/tPs03fBAs7CGM4VxFUFh8f?=
 =?us-ascii?Q?t0Fj3gJaR8pXaxS042JdgaZ0vhhU5WIr2TL2PF+lweUvkme066S/4flxsLEc?=
 =?us-ascii?Q?42RfTfSAQ1wkthtQlscmbw8VCmHvejV3FnCXZQs2sEETJCqiqNZmmkGtaaTS?=
 =?us-ascii?Q?YZSgHHAbaUwvYKtnYv6nKcELAi2oCTZfnUhNE2X/S9IfpVaYG6/iMuaRAw3v?=
 =?us-ascii?Q?A2xZM6nNLPOX6aporwVQBxs4BkIo34IOEM2Uaw2JpuAvfYrCf6mOEb22zNE5?=
 =?us-ascii?Q?t+CLwMPv0A5mreJlDCwg5QEarOgawAyULNK/NkVlRMSUxS1WLW7d98DNIso5?=
 =?us-ascii?Q?t3LJ19PpzGqSVqSBQMmHf4kQ+6G6V9dUxP/8JVksUdmk7CTaje7xCV50N6st?=
 =?us-ascii?Q?3OGIlnKoLHFQoIW51oJy+2qBWl31WJEnE677Cj5x95+2yGSG4v+8Te9ALpmV?=
 =?us-ascii?Q?cNt1ZTEZ/tz0I5cijexsljaB+R7omWCyvnZozAr1og+CRuuK73FDEJK7yed6?=
 =?us-ascii?Q?8/Rg4PYW3fxvsQwBSM5s0meUy7OgkHwxzzkTa7riDkxZtotrhUq6cswfrwD7?=
 =?us-ascii?Q?3pLoO3TRYnvldIUrwI28YOjdCeMBUIgpNWnirfMR2ZuUJzYd1K2kjbF8G4cG?=
 =?us-ascii?Q?mOwMv5KdXCT+fiYJevu6oWDEo4fZ7oHVjFfNejEq0sADoMszcjxfiqPfaMNq?=
 =?us-ascii?Q?/qOb2IUTtn3e2MbQjccHQ4KvWODs6t+PVyYK2/HSg9oNILvlGjvpE5bY5D/r?=
 =?us-ascii?Q?fNbMo5gFhViBD5xVbjgfcRTYjLZAi+fsG/bEKgPf9xfdOo5r8AxCT5gdyfB1?=
 =?us-ascii?Q?qTqFW1gj7mcMxhY2C0xQ4ZZtdZyFZXdTXbtH5uhoxWD0aFmN0jievTvH6RHp?=
 =?us-ascii?Q?ioC3sEQrt4rcz69orocFmuELSL67ghk+XcE5mxkK/K9SvFXBmJDs0lRReU3o?=
 =?us-ascii?Q?9q0NdCiDJEklI3UvKukZAI8wbX/g/Tahq4L2IL3C31o2st2f1PMil9OgBRKa?=
 =?us-ascii?Q?xrFBvCUJMLYlVTiUgr71lj15hdzo36Q3byKplEBwBWOjdpB5VSwQyIVX/k5i?=
 =?us-ascii?Q?dDEQNBtGVMh3QLMFtSXDxdASrfzxaexyeZmGBm+3ItdUgs+qGb/hngbskjWl?=
 =?us-ascii?Q?jO/Si/g/SjphbgyZke2IAzWFe3Wj+CXYSvSuM5qvSgA0VSNyrJLRCnTRS30Y?=
 =?us-ascii?Q?hTQy7xVGuP15U3EVtsIk2OD1?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d9debd-ab2d-46f2-d267-08d92b5f3e33
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:57:11.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfmYNlSzxO/p9nTVUqOV67Wh1KaTRRZocBh5zHSFvSMjO09vrDBZ5p3CctPGiko1o+ydrFWqoNVVlIiEQoufdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3557
X-Proofpoint-GUID: 5bgaLrs1G6t0IjDPtJuC2jxWFYsWjE3a
X-Proofpoint-ORIG-GUID: 5bgaLrs1G6t0IjDPtJuC2jxWFYsWjE3a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1011
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stop_scan_thread() and start_scan_thread() cannot really solve
the problem of concurrent accessing the global jiffies_scan_wait.

kmemleak_write              kmemleak_scan_thread
                              while (!kthread_should_stop())
  stop_scan_thread
  jiffies_scan_wait = xxx       timeout = jiffies_scan_wait
  start_scan_thread

We could replace these with a READ_ONCE() when reading
jiffies_scan_wait. It also can prevent compiler from reordering the
jiffies_scan_wait which is in while loop.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/kmemleak.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 92a2d4885808..5ccf3969b7fe 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1567,7 +1567,7 @@ static int kmemleak_scan_thread(void *arg)
 	}
 
 	while (!kthread_should_stop()) {
-		signed long timeout = jiffies_scan_wait;
+		signed long timeout = READ_ONCE(jiffies_scan_wait);
 
 		mutex_lock(&scan_mutex);
 		kmemleak_scan();
@@ -1812,11 +1812,8 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 		ret = kstrtoul(buf + 5, 0, &secs);
 		if (ret < 0)
 			goto out;
-		stop_scan_thread();
-		if (secs) {
+		if (secs)
 			jiffies_scan_wait = msecs_to_jiffies(secs * 1000);
-			start_scan_thread();
-		}
 	} else if (strncmp(buf, "scan", 4) == 0)
 		kmemleak_scan();
 	else if (strncmp(buf, "dump=", 5) == 0)
-- 
2.27.0

