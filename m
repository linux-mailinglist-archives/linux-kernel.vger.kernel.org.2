Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48AA43E77A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ1RrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:47:05 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:10046 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230420AbhJ1Rq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:46:59 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SDKtEv024303;
        Thu, 28 Oct 2021 17:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=j5F1XfiRsqASILn4dEHRDNPuVQBNTLlp8E3V9t5Ht1s=;
 b=J1PdugG51NONhINYpchfhbCNDDXilCVGzcQq65IbhAarsA6ux8P+H63StymDCIPNLHER
 m+KyjtsOSWu7qE9uB1uFGMcttqbKdIEkGKAjfb6Dzyn2IiaM299ScVqgMsx+A5++w5R9
 IBomvoIuJDJ3TQkcaeiedkpG2lOLq7OX8ul2Q8WTsnGcGKFGzxzy1lVFua6w5HI6r8Fs
 2sFCNF7f6sEiUf+foBIe7TClzGKNrPhhgrNqFgB02Is1g/O6uR9177F8BV2ebkzzFdD2
 QYjjnUHVGRHcylVEWR7XJkkqNZY4B/OlIEUDVwKYwGFVX9gUJSRoCt7tldwx9J8u4mqW Uw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0064b401.pphosted.com with ESMTP id 3by93x15aj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 17:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr5RxQg5xw5pKb6SV1TN4rg14lGzL7QkPvzcPX37QuEuAnps/qMmNbL8re+FKsBV5wmBsA4mOuNLPDh1XCRWAf7zKUGgsYmopno50ZPyUEXzQq/jK82YKod2r2dIuDvCo1z7IkUyihi1j/GUw2YxM2dk82g+sF8qHnZiizm4HxJm0a9sUWc1yeBHjuLJRQOogBZSfi1ai0M/ncnRniPE89WmuCjp4o7qMhMdr+rarLpvA9GxcCY09ystLhja5lS8tImxn7RVVUpMLjvDYwOczCRtP5uKQg9c8ioresZrRGIXSYZrboxwl6IOAfhCxnije+yPb8pJvi2ZS3/pKWYXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5F1XfiRsqASILn4dEHRDNPuVQBNTLlp8E3V9t5Ht1s=;
 b=TCKvqoZ6IXRQDdnCEDJuRGZsiLJ7gDLnYJ6JMrVFYIfSdSyQDj6NWZG3DJqSWIkTIY3rLEzhnGJu8ANlT12I6zW0i4odj+AkayjP4RpnXK+/V3PSFNfgkiVSDJXmbjQTGz1rkB+LL4s2UBe4KomjpmQU17g0nrV9ee6fevNbZ4frjAlsNYxMm/jBsf7L8nxMQNlnJjWRml4jkKBbb7LWucWJJlKuNUJq9xqvdBkPmyDBoQLIo/U/V4T6L6Crl/m2iWUTRLQbrTOei6eQIM9F6ijDIDh4tkmYMHcsXDtVPo3+sSAGXLH2GzIqolFyS0MY4Zesz5ZP1ePZN4AzMoRTNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM6PR11MB3449.namprd11.prod.outlook.com (2603:10b6:5:d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Thu, 28 Oct 2021 17:44:24 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3d20:a9f3:70c4:f286]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3d20:a9f3:70c4:f286%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 17:44:24 +0000
From:   Ovidiu Panait <ovidiu.panait@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     edumazet@google.com, davem@davemloft.net, kman001@ucr.edu,
        weiwan@google.com
Subject: [PATCH 5.4 2/2] ipv4: use siphash instead of Jenkins in fnhe_hashfun()
Date:   Thu, 28 Oct 2021 20:42:30 +0300
Message-Id: <20211028174230.1800007-3-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028174230.1800007-1-ovidiu.panait@windriver.com>
References: <20211028174230.1800007-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
Received: from otp-linux03.wrs.com (46.97.150.20) by VI1PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:803:f0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:44:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5216d68-8dc2-4414-68da-08d99a3a94cf
X-MS-TrafficTypeDiagnostic: DM6PR11MB3449:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3449D96A7B693696B042899BFE869@DM6PR11MB3449.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: in0sG1VL2tCSjP7mDk5OTS5hPzIauf+QXMl/QLD8W+Fby1gHfEJPIF+WCo+9HrZx1n9Iz1w8w9kp/s/W1aPNtz1QnAJ1lCtArF6KExzd6kJeA9MI8rhuB6aXkuPtCJnHm4wO7NpjYeb2JUcxKzpqGk847OxSgXYjBLL6BJ9xTLlxKUc/P6nNv+CrdljRJ+idb19nx14isigSDDx1HRSa2nS38g0fKWhcgKtILiog9E/jRbSHpkCgoPyUSTvyr+KlU8ImwW37k1nThD6SvCANKe4HKwVnwi7KXyLjct3jL6dtJLbqAMzmplY2P02plI0ZnWWfeYIJWnpCLy6j37unM4HXGZmNB9M3koGVuMidOMFi/9j3WgQxb/LOePov1qk87xTvP6A1vRcWYXRVT+L4TyDPEH2C5LrFcDeTCNgR1sWbzTa1ghBZr8dgloYvpBrRA1G7RKWkTEJ6aVHL0PSSAoOKtz/cuDUQoips33YgC1iajWWbY64W15l61W1jxI8JSKy0rNlFsVvXm6VVy0gRbzRQPt7poyqGcPh/IHrd8FpM4ugzAlKstyLjTVLxH+/YhvQCiX4HW6jzombWZEhf5rTyamphtuKUOWR6if5amWu/IV/3d0cQS+ft6HjKtnfAkF6zNDndg2ZkyKQvhOm8Fve+/OQngEyHEm0oSsoBzLIbqemlBuwvZM0DfanEmGgJSUOSiZQ8tYt3VuM0vSQOWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6512007)(6486002)(86362001)(2906002)(2616005)(6506007)(6666004)(83380400001)(316002)(5660300002)(36756003)(956004)(66476007)(38100700002)(44832011)(66556008)(6916009)(66946007)(508600001)(186003)(4326008)(8676002)(38350700002)(1076003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KlOCqOpHgYjMXlsMBMFOuokhSUHnmNPmXLnic5eIeoi0rTWMkGRkiObVvs23?=
 =?us-ascii?Q?fGwMA+lNW7WnNTRWdR8tN6UPUSbtN7OAdTDRzhGrMadoFyw3fRRHFmU75YJ4?=
 =?us-ascii?Q?RygFy3qZIme7uN7DSMx7+/pFc+9fAVBXE482nwSKS0FV++A8PZ+3cigsUg5E?=
 =?us-ascii?Q?Q1VYKy4htyGgVlqQUhTrAjTxgdfLf9+XJy0tcmU4zhxvu2BrjlndDuTwwPwo?=
 =?us-ascii?Q?2Zn1gQwlPJww9t/1FT/cACmH9N1s0LYshZ5JBRX7uYGMhWqZumYT6BJN5A0n?=
 =?us-ascii?Q?ZYnBEaRMSzjmAkf2Iav5Uwbjj8jO0nn8I78mkStAc9CzJ4Zm9+baeOS+TiDH?=
 =?us-ascii?Q?hsT6STrKuTgCQYQQjP6Zo3QbrKndECaNdIUeojlLohOjYyrLQzgZJwPNIl8J?=
 =?us-ascii?Q?AMr7OH4d8p7w8p8KZwhDRn0/A7ZZv/3nJ9w/oZruWoCxbtBS9VACPJ3nCF1H?=
 =?us-ascii?Q?HYHvNUz6xD5M8Hl2XGO5a+TbmN40c03gB919G/RIfwUOXtiKjRB6Y+dCvkfx?=
 =?us-ascii?Q?wW8wlWzc4yLzUYx5V02s6K4LpGJDxjyR+lA6lv9OlETivWgXeALQFlOi45y8?=
 =?us-ascii?Q?hoZh9e23eAF5NnNIVL1nsCE5s1CcSgy2xPwle7oKzv9+7tAJO1Jx8kQTLWjb?=
 =?us-ascii?Q?S/loFQTfv+tXPNJ8x4uXInczpEUlSpC9+lqsxvHk3MEUkjhIEKu0dtcmtrCn?=
 =?us-ascii?Q?qGmOVDvIBbNCVU1j4ey9JmLUk+MZ+Yk1BqQJS2VbkYUGPde/el/uis/VP4Jm?=
 =?us-ascii?Q?aAgOsKkFPHlLSw5vBtLjEcbL6QNrT/qTiMVr5IldW7Ddv8kseQud1YfdOuRF?=
 =?us-ascii?Q?EOzQv2d0VhLmRrVhJBYB5g0r74/zkxX+prIQzw8rWYqcCoBMpJEfBoxuCLMr?=
 =?us-ascii?Q?Vo4q6KXv/hWtj/jzmF2sAV29DGlZ95vov+v91+qd3kXVb3Q5C0Z/BD0z+FB0?=
 =?us-ascii?Q?ca6VUlhAWpNr+1md7BYXY2DEjdiqe5V9QxQkYJZwjpJuisGc0WNWbrr9qa/I?=
 =?us-ascii?Q?51vDlsz8Pim9bDulAE9xM722jkrhJSDKY+lycC0yrO4+XQgmX6dEPYFJriVt?=
 =?us-ascii?Q?8cyZe1I6HxoLDSeGth6G30BgrhPHtTje9j1tBw2xJV0bb1Qur2wrUX9/Na44?=
 =?us-ascii?Q?JZ0b+pJrJ6ugMFwMyAZk7RnOAzVsgPsVAHqvoH7L2avLQWFc82nv8Anxn4Wq?=
 =?us-ascii?Q?VRIdVWDBp+/pl05GFm/Flmt5wBltHtZFpTtNQOW/bkIBCCr/ol384NmFI4rW?=
 =?us-ascii?Q?OaQruSDgZSpvd+VpheGQGaBwTEuyJGpfrVRMxK6GpCwOEjG6w7U5HbtT0XJE?=
 =?us-ascii?Q?/i5aw/MkuC7n/YWp0iVECSaJUTC999xl5SfkOUVa1Eecehe0/8P4PdKhGD4u?=
 =?us-ascii?Q?Zcocsb2OVycWpX67ahpJRYR1XM01HBMVe0Ww3FCKXBYZWuquTPjVQWv3Rztr?=
 =?us-ascii?Q?I9Kn9MA67xVRnohoriWNV3R2vCBjHOOoIarWmhQ7Tf+xCO6+VIDqBe8akns7?=
 =?us-ascii?Q?tkazwtLLLMfW70W94z00NCwBDCFD9/mQM1aCSjEQfcC+kCmf3HwxPWXrek0c?=
 =?us-ascii?Q?mTTwbxd8miNIAZRG+dfYlxB73iHKW999Gd6wBjsnMVSpF3nqN11tpwSYatkp?=
 =?us-ascii?Q?UUXzRPFarK5sEi+mD6MApN4N9G2hLaMvlG9Pxr/abB3mtZ2EV2VS7nKvnh4o?=
 =?us-ascii?Q?QLQitw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5216d68-8dc2-4414-68da-08d99a3a94cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:44:24.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xZzdWmNyP+z5klba1TAnUMh0uFWtUl5BhqeSt8ERngf7vDxUG0nxTXpYqICtwlXibANFCWzh6w/epkCXuFkjGldO+7ehtSOZIwa5RiYhi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3449
X-Proofpoint-GUID: e3S0CUx2MVn9nmCjFjdTPuwz1sKQNale
X-Proofpoint-ORIG-GUID: e3S0CUx2MVn9nmCjFjdTPuwz1sKQNale
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_04,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=484 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 6457378fe796815c973f631a1904e147d6ee33b1 upstream.

A group of security researchers brought to our attention
the weakness of hash function used in fnhe_hashfun().

Lets use siphash instead of Jenkins Hash, to considerably
reduce security risks.

Also remove the inline keyword, this really is distracting.

Fixes: d546c621542d ("ipv4: harden fnhe_hashfun()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Keyu Man <kman001@ucr.edu>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: David S. Miller <davem@davemloft.net>
[OP: adjusted context for 5.4 stable]
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 net/ipv4/route.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 539492998864..d1feec97fa06 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -631,14 +631,14 @@ static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
 	kfree_rcu(oldest, rcu);
 }
 
-static inline u32 fnhe_hashfun(__be32 daddr)
+static u32 fnhe_hashfun(__be32 daddr)
 {
-	static u32 fnhe_hashrnd __read_mostly;
-	u32 hval;
+	static siphash_key_t fnhe_hash_key __read_mostly;
+	u64 hval;
 
-	net_get_random_once(&fnhe_hashrnd, sizeof(fnhe_hashrnd));
-	hval = jhash_1word((__force u32) daddr, fnhe_hashrnd);
-	return hash_32(hval, FNHE_HASH_SHIFT);
+	net_get_random_once(&fnhe_hash_key, sizeof(fnhe_hash_key));
+	hval = siphash_1u32((__force u32)daddr, &fnhe_hash_key);
+	return hash_64(hval, FNHE_HASH_SHIFT);
 }
 
 static void fill_route_from_fnhe(struct rtable *rt, struct fib_nh_exception *fnhe)
-- 
2.25.1

