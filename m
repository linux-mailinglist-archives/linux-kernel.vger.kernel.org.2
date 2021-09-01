Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA70D3FD2D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241975AbhIAFUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:20:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58542 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241915AbhIAFUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:20:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VNagJ0006754;
        Wed, 1 Sep 2021 05:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+V/MMcWZ1r5caFiFnhe7CHbUrS3YhGOKl0ZKdvtUkUs=;
 b=VsspbjTO4ArYIdxY81x6HEXBG2GvzUbonYGrie8UXG20FSvW5AGyN5Yc3D/zv/iWC72u
 sKi1Ft37g4tmxwkpHOf4tEJ5GrMrgUynWXYKASm+bUFTKOI9dtoweH1ekM5qb1xoo40X
 SP0rqv01bgE+fO7yXWlX5vMCU1jdcwKoeEEFPjx9jpbAY33sCnj2J4gkMuLtgR6b9Ucq
 Fytiouzzkq7tHu2M5PtzTsGNGgtzfW3Cmpi5+HBdxARDB1yxFfm8vM+iQrEBlXvVEKzB
 GqINwLOpjilVB2f9z9IccQPphISvKShBGxjGFDDhqLg8bG8aYOPsXlj84fWuWwzKFew/ nA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=+V/MMcWZ1r5caFiFnhe7CHbUrS3YhGOKl0ZKdvtUkUs=;
 b=E2l6Ge/ST9erwqJJhYTqdVGT/NKQllMd+6B6+z8B2OWjjotuI2vz6QsHI9owrFKrQGoh
 9TikxV9jJKSeDG+M2Dzv2esorrTMugIyX1dt7Cc4UCgKBe9J8TwBzOylfpgHkDdKM2ah
 K+MxRSpcYZEo/Xzqrjta/lwtzTh7ZiywThCZCun7aLkJW2B0tTOUeD4I7WwHaJGuh6Tj
 yMEk88GUKtyLolzM1Om0y4usWwUB3j3A/tP5mLbRDDrfrC3zZmmbozytsqEzuP4pQLPt
 XWgX5ZAIOM0xc0rIcTWMrwwWmD18Esnmy8yQm4MKHpjCh3iBe4xHPAA2Y3PNjOGGSVzq xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asdn1uehe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 05:19:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1815ARGx167364;
        Wed, 1 Sep 2021 05:19:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 3arpf5s5vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 05:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP+DPvVfy2YIMawQFOxhM80Vk2K7oNm34fodclXUTIT/gOGpQ29oGz2S81I8L4owXSyimpPKFR6atzJyqbq+myv+nDfTH8h4gu+cCABEHHtFhXaFwTS1eqYdWbjw47+C9DxKR6YCY/a4u1qwwv8F0TW5GLV5cVcbjcd2VJDEC1DdT0UTMhP9u19f7q+/74bUPNxRNNQUqVLR12+yASR3rlu80C5mUDpP9ae59eGgyelDzg6hG2bVhtEIjnxr+q4Di2TeN+pFaXi6p16mfNwmrVaD0NySEeirsxY2DS5SiqxrBXRwQnNeH+m7eKLisFJEwK1c5yz3rNbM1aiWhziWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V/MMcWZ1r5caFiFnhe7CHbUrS3YhGOKl0ZKdvtUkUs=;
 b=l5XEZ55OwlGbU/HqEH082KBnc6IsipIMRXLkY4JYPv5fk+AWSR11c/RtYr+3xJVOq90NsdPiarwYjIJDsa99+I31cbywPOcJAdJ996ojBRYgdYziPtLTW/QJI8O4lCFJIIo/QnduCj3KOil1pXg8kCfItqmZHrX0f+HDgzghChmUwpmtJqFKmzpr8ay0E98RuCvzKa6WPOOuxcnlJXIgpMnbAv5VjKcsqWnSI3iKsLoqQw40n4ciGZY7B1LJePkY6rE/Z0hGiQsVvnqgWK941B/9SZ7RJzkSB4984CZ/C1kUaS6uVHj5Rx2seULUpO7tIFkNj+/1aaX61eoXrt4LcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V/MMcWZ1r5caFiFnhe7CHbUrS3YhGOKl0ZKdvtUkUs=;
 b=s/knL93NIPt+6JYTerAC1j1XlSJjvTj6kSDEivXFwWB9bfWKyPf3tkpNmBF1THIU5hi4rrlyyyVgHl52flCUr10Bs/ii0O4Yt8qBLA3Kiz0S49mbMleKr9r39HP9/U9447vIExQDJiqV6JQW02dL14TWa7QLzxc2kTXcs8Ho5po=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4691.namprd10.prod.outlook.com (2603:10b6:303:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 05:19:31 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:19:31 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     geert@linux-m68k.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] lib, stackdepot: Add helper to print stack entries.
Date:   Wed,  1 Sep 2021 15:19:14 +1000
Message-Id: <20210901051914.971603-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901051914.971603-1-imran.f.khan@oracle.com>
References: <20210901051914.971603-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::24) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (110.33.47.182) by SYYP282CA0014.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b4::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Wed, 1 Sep 2021 05:19:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef42436f-8fa4-4240-dd20-08d96d0813a9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4691F4F635D4782E78482A2FB0CD9@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYFMZaEkebQ0TmdtA5zG0jXp4VjgZFzqzGGVbLKKxtsDoYel2DhjR+lA4aTpPOVZIFrE1BgzpfT9MlqNIHLdp1RvW3777XGOFaA8qSs/80lvGwHRICpJzFBAYrfjv7h73//2jzNwmy3OEdzsK8giJpHOIRnRcJig0/EbuXAtq9F/+fmPA2PhwJaM90Ea4cKbWU2NsiDcr1UInsj/7RKkovIjA15g9HWH5ekc73ebxMXx4cUZncFRAglbywmmlXgOSUeOcHgVONQYuEQrq0dDFJ5OpjfWgze/MRpFrZ+sb/lRt0E6aF+/0FCS3Y8SHjAYJ8MKjsdQsm3YQy8BdJGmJC8f392JoCCKtsQrH7uN5+P4bzYtIm2spB8DZxvhUr2PLNpVOvD2O1LbhwovUKVSMyLzjWwKYiOUUOXPPTZR7v81k42QWAHpPxk6280p+cx7nlTD/JU+8fDcGumzsa9DOvFQRKd/j/f/+3lT5iHUffqez45hrcu67J/7G0EwXEJlRGTTItxUvMMPgL2j8KG5NcTAIg9ZhZJN+y8o3UE3acaOudmVLjx25GYiF350fK7xzMEyjEHESXz9Wq7yT558UQJm4Ot769OMbfsznih/odaaDpgUl/X9kwS2hsiZ17Oy1Dkv+msP9Jh5gN5jT4OAtv7TQEgvwe/u8vbbVAQDJSWxZvfVgITBTOBXOru6UplRhLeyzTYnUDsz+hUxgVYRXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(38350700002)(66476007)(66556008)(36756003)(86362001)(186003)(5660300002)(2906002)(508600001)(1076003)(6512007)(956004)(6666004)(8936002)(316002)(2616005)(4326008)(52116002)(26005)(6506007)(66946007)(6486002)(103116003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iR2ir2EuBY1YmNLXLhmup4zBj5pOSq/XGDxseSfu0XFnTbQWDaGxpAt8xfPj?=
 =?us-ascii?Q?neMRj/14kZbkInRz7NaGcvhS334/HvsIqQSXXliwhqZ7dXQ+yxvU399HfAzh?=
 =?us-ascii?Q?TFeFmbTBcFJYnc/HZMlGOXdYT535QG2i7Xmq8dI3FOaaw68GePzABrPbZMAK?=
 =?us-ascii?Q?dmJyuVO/GKRbLXdgtrIpDpWb4Vwa3P7M25Uz2ZSID+VvaW1Q4BOcfPdigBNG?=
 =?us-ascii?Q?YMS6XUqQyWLUFT0Hs7h2cm1STg5Be34jOePA8UMe1pwi6BFddephANNNcfdx?=
 =?us-ascii?Q?ZXR1UE/nVr1xjPmPQIukh0P5/DAHE507znRAOyVo7M9KFZ4t1yQ72oPrjKzK?=
 =?us-ascii?Q?7l4w7ysMvEPrRBCdURWhFYsudRbq653cQFJXFn6/WXB8HthCjkfxGOVw0H5V?=
 =?us-ascii?Q?W/c5aJd4iJ0+JrVP9cTFKD0n+5c6XxyOG1A0aLcwav9ajDEJXdQ2yyEqcfHB?=
 =?us-ascii?Q?enitXO6LBqbrHH2ef//Y/54/IV6y70R/q8vWJCEw0B7cEpP1tdW0xN9aDnEj?=
 =?us-ascii?Q?IumH3HWP+CQ2W+UUtr1kLNfOdoe3vySf2gefBmD2kBqsTVV89gTVFuAlCce8?=
 =?us-ascii?Q?4oNN8rKCrQlgwcJLEEbhAn9R+FxZdqP0AjDu2spVH/+NcYK4WOFrRGLJ5x0X?=
 =?us-ascii?Q?frdWauFMTEBRq+K/WAg6+lLapMadtjyWoKDH9+fubWE19c4H5HUZ95036OwC?=
 =?us-ascii?Q?U0Q1tUuOlPzU5djJCFxCVfxwzoB+zzYBCmqnee1/lTdPvVqmyXhgditsV6oY?=
 =?us-ascii?Q?NlS21QcvBXvFMH9iIkgT+1jDexIldbjbh+dm0c43J3ud7yfWsiUJzmchqujy?=
 =?us-ascii?Q?MnGl4NEEu4fTRPFDVgugwChTfezg5VVwlLecT4ULUwVg42YKlPIsllw7K2px?=
 =?us-ascii?Q?7vVGk2vAh66F9Tkq2aTG0gOTC+ckUwbZA4Sxpco5AUTzLP/0wWXGMSccHKXp?=
 =?us-ascii?Q?DpMvKlpD00a816SWONWYnyHx0ueN5ll7eydNpFFvHSwxqe2S4Knix2O96Tkm?=
 =?us-ascii?Q?EV/3arx4G5FPF7JHJqcVz5C12Y/QdBtGXyzfjcu9wq/u4atBhUQF/ypjqTee?=
 =?us-ascii?Q?p7yZUUhud9wMyxyY71dLiW7j/0y2zZJ0K4uMsn7rovaxrZm5crExKz0lUmjw?=
 =?us-ascii?Q?kAKjdZTsfvyI8GCyFb/30nf0vjEcoNzv7TM5KeIREiXsUvWkk/IBqinhzoxS?=
 =?us-ascii?Q?OtHHyjze6eFQ2NPdR3JnM4xyDD9QoW197OkSwofXSXAkvLU0T2YocXMMyhLD?=
 =?us-ascii?Q?W9agO47g8vLDazbfiMwK6Tn01e+mCDJuiLSnF345yTYWhPjufDpH37KuDD9V?=
 =?us-ascii?Q?lASsgSt3A7b+zFq+JNWqe7hh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef42436f-8fa4-4240-dd20-08d96d0813a9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 05:19:30.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S62+wYCZc6z/QzcKHeT7238YKOK+zpLKMVEC/8ai9C+xcQap73gr27tXdITWMxhRQnHUCUZqbKiFCWzBY0VcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010028
X-Proofpoint-ORIG-GUID: WXuXwZTxrPc3dk3P8RLSsfcn-lvKay9U
X-Proofpoint-GUID: WXuXwZTxrPc3dk3P8RLSsfcn-lvKay9U
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To print a stack entries, users of stackdepot, first
use stack_depot_fetch to get a list of stack entries
and then use stack_trace_print to print this list.
Provide a helper in stackdepot to print stack entries
based on stackdepot handle.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/stackdepot.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 1d42ef9ef766..eab4476b060b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -214,6 +214,23 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
 	return NULL;
 }
 
+/**
+ * stack_depot_print - print stack entries from a depot
+ *
+ * @handle:		Stack depot handle which was returned from
+ *			stack_depot_save().
+ *
+ */
+void stack_depot_print(depot_stack_handle_t stack)
+{
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(stack, &entries);
+	stack_trace_print(entries, nr_entries, 0);
+}
+EXPORT_SYMBOL_GPL(stack_depot_print);
+
 /**
  * stack_depot_fetch - Fetch stack entries from a depot
  *
-- 
2.30.2

