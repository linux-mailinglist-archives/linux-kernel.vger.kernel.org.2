Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339333ECFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhHPHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:46:39 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:9012 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234060AbhHPHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:46:38 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17G7cStq022466;
        Mon, 16 Aug 2021 00:45:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=VNFDYJ9aWy2zB03hgEyG8T/ANdmB5S9fgSDqfrhNYuM=;
 b=g9QpKzuONhM0+/ncKK7vXqAAdkas4Uqx2tIfZ/bOvVjJcde/l7rDnzJqtJHXG6/NURFx
 MawyeEY5rHW/UfdU9/b33BniyEdziBjFdKMhO8SW4x7oYfA46vjp9WDm1nMjM6r/N1UI
 jZuEsGgA4upP+eaU+hvlyKLky83WbfQkDL/6sowA2Daq/ax4Irp8PFiLIGOHjEmKPqvz
 3GdzYD5yzOa61f07D2e8voMy4e3NIUM9IgQJBau9+CR9gClgxYNoGS3c0SxnPtm1S8yr
 ZJqt9tpzPCO1OPpiPJMITOMj3QyynUNshu51Ta7Tv/n1y6pmpd49PAZMJqG6oMLpGrVZ eg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com with ESMTP id 3af7xwg8we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 00:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG60ncKKCE4oii7iMVtCWm2Mg52nQu7m+W4JWf4l9BQIeUIKU8fYVLaa7QgnUmrdBQQS86hY699ki4VbctK2ZGBztIs1qLyPUz+j0Otscj6ZO1jhVQlICqIPe17GUPlLzrU66KoNm/mWzgVyO+1Yurm2SqOr0/YfcaEloAU63i8l1BD6r8oF3CQs2Sk6JKe9mAAowc5LVM0o/UCrHwTsqpiY+f+tikLGlqPidCYauOxVqpG6yFZAPpsxzVKMi947NCXYcofH/x9G57wmoveVtG/xkv/jGurXiijTGjB2jeiFoZFco600b993d3O5es0jNy7H+HvYDebVLqRL1/Oj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNFDYJ9aWy2zB03hgEyG8T/ANdmB5S9fgSDqfrhNYuM=;
 b=budpxnL6/68+9L1K80wdi+IpfWFHMr8DK7KCS1xXlk2KMwMZNDE4ElhM11sKQE5j/77w7O8Fprihy49W4AbQllcgCSSwM/Lpbgc4Y6L/2tQO9rs1AkAWipNImjqPujtEyxRxlLtuInzQWYb2ZZ+Sg7p2VD+9C66ukywRPHYMKsf2gvYaOfUPugTC30MNWxuKRdPDKBXV4N9U2nsSbXW9d0oLLhNifON8bzrr9u9QkxmPH9zmEE3jL9R3GUVUS+IACw8myShy0gR3CL9t4irHHwFOvJbdMdPttieF/E8VY3iAYpU8ejTeOJZufAbMIqGJek5jV1idloFmeW62GPo8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=windriver.com;
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL0PR11MB3378.namprd11.prod.outlook.com (2603:10b6:208:68::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Mon, 16 Aug
 2021 07:45:38 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::b16b:d6bd:fb7:457f]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::b16b:d6bd:fb7:457f%3]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 07:45:38 +0000
From:   qiang.zhang@windriver.com
To:     vbabka@suse.cz, akpm@linux-foundation.org, sfr@canb.auug.org.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm, slub: add cpus_read_lock/unlock() for slab_mem_going_offline_callback()
Date:   Mon, 16 Aug 2021 15:46:05 +0800
Message-Id: <20210816074605.30336-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To BL1PR11MB5478.namprd11.prod.outlook.com
 (2603:10b6:208:31d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Mon, 16 Aug 2021 07:45:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96df479e-d44c-49b3-9e0e-08d96089d6d6
X-MS-TrafficTypeDiagnostic: BL0PR11MB3378:
X-Microsoft-Antispam-PRVS: <BL0PR11MB33786A254946AA8D802CBFA0FFFD9@BL0PR11MB3378.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tShEkEqUZl2R00jlL7cYP687Gw+G7on8i9sceMKMFkAcxR6yD52elMqkkKd6wy8P0Q7Ty7xDV8YF09vOfUI3US7Qu4ly0/zBhrpChV3nm/JOlB+Fw++YMLoTI8j/vABFCtaP4HqplS5dGwHQOhfCXAGMaQotgwztmY0kI+w3AN06NRCbd/KFie2j6uG8Rt8Zs4XBdOwA94RcjbmiqnMxZyUGel3QX2jJsGDeUB9SNefEYXajyo1aXEQrxzfQZWI/CIN4w8Spm+PxVqaIK21mfH9NVcVFNWwCkaDwpNdsoT5va5RZVdOmX34BnBGtlQ19V/VftGrMJF+HpQ70P38nmPBUfMBGfUK7++exGu0dg8pEw/oHTEbs4Sn9xfOLcUlZbRYYmG9i6YnQwobd1iK8JH/5+hiaEf+qkQovC9fBSRkIY1/u1sijgebmPOsCCiFAC+XIsc/2FJS44F7r0kcBPrrv84hF6Mh6+M7/Zb1b8fg5p00tMsiJVrcjPdu2gIERNKeqXxF3YNQKDYAHKIXfLRMknislhTNjwP/qNzN0PN/JV/NzTW1Ws8mfArrz0ZyewQFP48zdhL7Uwot1VEcUrgEyxn2npZtvfWhvxHlFf/MWAD/TjtKOQreuofQY0W2nsM1EWT+mWsm0n9x/0GXBBhQMUluOCR5YxNd+7xTxqZ8Rb+1ZEdorYWbD3H1JhYHYNthtwSFsb4X0v25+h6cUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(36756003)(66476007)(83380400001)(66946007)(2616005)(478600001)(52116002)(6506007)(8676002)(38350700002)(38100700002)(316002)(5660300002)(8936002)(66556008)(26005)(6666004)(6512007)(9686003)(86362001)(4326008)(4744005)(2906002)(1076003)(6486002)(186003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMbanrz7dpgaklzyIEs5tnHbZMvYzpA81CNuvS5vp4c68fnf+ibE5+Vgwlmz?=
 =?us-ascii?Q?+JypzBAeA5FBZSwaH4aCpw38p48MvO/UdpZ3CaH/yXvPLBRwx2/pvVnprAet?=
 =?us-ascii?Q?0bwnZqrw9D1/RXFVKGUk1QzIT1fgY1NHupIp/j76VHGEtabwObPRBYtlqkeK?=
 =?us-ascii?Q?1IUp6VAN1XhjlaLSBNK5wDDhuCdPbE5YcLQAAfdulcmj2l40DSFIWjuUnZUt?=
 =?us-ascii?Q?ssgBAfD1zh4qOtlk1fQ4SwaC51+RX2ryCAXKP/5aerkmJjFUvwx43129zjSp?=
 =?us-ascii?Q?CvJFb5332UPYMLPJI3cfhZcn6zxiPag3G/7WhzUs4l85VIKM2wVk4ngx+ubU?=
 =?us-ascii?Q?aUqBKlh4xdQr/ClYKJBShDEm6lS0wza+Kh2dK+aXUmniwrHRnJEUFEDSfppw?=
 =?us-ascii?Q?xVafTdaouiep6GHdI2Nx1cAIc7Gm8zFAyM9J+Tem7yWikRf0Mk51wB5QdAwh?=
 =?us-ascii?Q?rULPIw96vBicnaQcdUWoEq4DakNQo5R0FVLaFKLOEfunMd51j8wmiPNLqFO4?=
 =?us-ascii?Q?6EHEgG7m1vN3AMhGNUm43LH2E3VDJrTYoY7jBqsUkVluLZqsjTnMb1WIpUfK?=
 =?us-ascii?Q?HjT02wG+ZyYIH/SahdiMrKlnBz8S3EXrR7SBVfBQRmea7BpKpvdNzcWHfCzo?=
 =?us-ascii?Q?VdbxKyHtG1ujxfJp1jAI6miVFDAt9rGMfIDNtx5I4eBs/EvcD0DMN91KL0LX?=
 =?us-ascii?Q?Keuf2rCJ3a6/opaHivzb+UYbv7axicNgExZLCbGROB+WedXUBTWsuav93m4v?=
 =?us-ascii?Q?Xw7DYW3rGw6TVcZpImp71pCh7Yp2V3Qbo4dh9Sxt55WdHWKQI2a3OBlaEDK6?=
 =?us-ascii?Q?go+Lq4/1KgtgkA83xotff1TdwkW2/+WzqujgE6z7i0comuvU0LHvlLxU2R89?=
 =?us-ascii?Q?TzJsHWpzJwLLjvGC2N9VbwUcDWLVALDlrz9vX7cVOoXRLXCC54NXmnI7Go3k?=
 =?us-ascii?Q?s9q2OpEnkQiuqXZXZtPf3LF1SCosCijfjlW7/QtUx5cXh7qoR+5BeEgq+eIP?=
 =?us-ascii?Q?uRsKH3lb6quSAfY1baHPe8UcsVB0MiQWYqx18hPYHkLzf4nR0S3GmAtFRwrj?=
 =?us-ascii?Q?tVHUD6z6TZV4TOVBiV+tBdKkOycoLU2e9ntLRaomaw9bolZEszmP4AMeRKmS?=
 =?us-ascii?Q?KoMfCx0cJXRVdDoTZ0ypEwWwF0dLL0cT9NpoCw7QpDhqHiJMQW5KJPqDmO0v?=
 =?us-ascii?Q?3ag+s+/Wk+TcE80GK4bgYKoSJ681bHVysdkMpnjp3b9fEgoNzZ83Lb8RXxsD?=
 =?us-ascii?Q?iN5/ChPOOZ8ESY2PfAG9Uot4/6kkspUbD5/poSTtwmJLwJkiyHGhsOoW4CB/?=
 =?us-ascii?Q?g1IpNyXQlUxRhSrFrLpH650o?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96df479e-d44c-49b3-9e0e-08d96089d6d6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 07:45:38.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVFj35ByEN+3aKeXpUhDx2JN00QGC9IM50BcZQZE/ygmQnXn0NV1XyF1DO2Ezw49qhy/iA2v8zrzFb27sd6jeFAGX1m7SJ7gdhDJl9YStOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3378
X-Proofpoint-GUID: GlMWnzJwvaXLCVFgA_ZKe9xwjeE9RaNM
X-Proofpoint-ORIG-GUID: GlMWnzJwvaXLCVFgA_ZKe9xwjeE9RaNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-16_02,2021-08-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Qiang.Zhang" <qiang.zhang@windriver.com>

The flush_all_cpus_locked() should be called with cpus_read_lock/unlock(),
ensure flush_cpu_slab() can be executed on schedule_on CPU.

Fixes: 1c84f3c91640 ("mm, slub: fix memory and cpu hotplug related lock ordering issues")
Signed-off-by: Qiang.Zhang <qiang.zhang@windriver.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 5543d57cb128..cf3f93abbd3e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4593,12 +4593,14 @@ static int slab_mem_going_offline_callback(void *arg)
 {
 	struct kmem_cache *s;
 
+	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
 		flush_all_cpus_locked(s);
 		__kmem_cache_do_shrink(s);
 	}
 	mutex_unlock(&slab_mutex);
+	cpus_read_unlock();
 
 	return 0;
 }
-- 
2.17.1

