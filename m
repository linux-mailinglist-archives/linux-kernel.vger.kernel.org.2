Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8E3FC2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhHaG1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:27:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23290 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233665AbhHaG05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:26:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V4guLa016422;
        Tue, 31 Aug 2021 06:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=jEbc+xPe252FsXlJUozVeaJUXOhtA+iiaJNek2TeIbg=;
 b=KuZgadt34/nAfeuc+InIVcWP8VkfiITllGwZqccDuykl2V3jp6AMJvja1JssEfmVItkj
 gXJm5kRFnPlKileVErwgnhVDVjn2NaL1BOsq+I1bC5IWbSaxVPrny5RsktHT+cSgoNZG
 vqRJ3A7ednsx5jArui+fsAD0tqdG+i63NCSzAbIVwqtoJGtRtyZQgb7Vk9tdfN6Cw4I5
 TEj9VXUegXC0MteVAKKEGPac9q/aiQ4g2Tho/eMw7FAdXlz06RrUKyQuBS1tDaM1Y3Ed
 h/VX4oD503NlFTCmWiUvPGCFjJYpyUTd9aBABRjgQ9ldE2YXwkyP/I77gNleXlckzVZy yA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=jEbc+xPe252FsXlJUozVeaJUXOhtA+iiaJNek2TeIbg=;
 b=oYlkf/C7+2bJjJ0D18xYQbfLQsIcJF0L1zB9tpBmJ2FbDznvQsIsiOvRtWRaM01v0Abc
 Xg3hgd0SWa8ad71uGNHAxHgXcsTNLoo/fTPi+nVk5hYxOyfOOqoF2ljxKE39bo4CVn5p
 nXajCUOVVG+tjTZ+6nBVc8SI/jwL+1LcZGSdJ+jcHj+Ii7E5rbs03vfgxNEyULxyqOmu
 Hj4RpurGnb9qyaggh8Kbe9y0QF/lzZ6gHxHeuuMoOChR9DLZ5Kw0wvTqq3gwdvosOnRn
 S5BzGxGfyExuHF6dUCJzIxX3IkSkVxEzkNhQHpHDkWGNx6tsoTuEk1VCUFkkTL7i1iee bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asdn1r5kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 06:25:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V6Fb1B119159;
        Tue, 31 Aug 2021 06:25:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3aqcy459cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 06:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftu1Uolx1qoaifVkfd15PYK8VdnQPNySPvhKnKLjlhC4zdO/xRLOGbBsOoOvLnUUMPXq6qK8s1oI/55qx3AsBTwpGCpqZcmZKY1Rz9EeSLSXTnihaRhZNL9BVy344iu2Nj27XOYZi5y5VMRrLSnpthYu6tBE3PiheVCR6kBgEPJJ0jx3XDd9yNF/9G0VGS8jDuCh6vo/DmoAPU+8bp40NSxJyTRhxakI//UiPdSnR9mnr7gh+6n5FVmB+cQCwsDjknmzrnheTYJT62JE58FOSGBuK+PEhEzYpou91p/tnA0nr0m1vau8IhQmX5aTRhlriRW7R/ur8+8l+k7exKGagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEbc+xPe252FsXlJUozVeaJUXOhtA+iiaJNek2TeIbg=;
 b=TsrKi4uqe2RN+5dVl4081fEbBlezCR5+O5PwsP5iEXpD5Zw7RmqINd7pea3AZrJ/UxobIJNjmhuq4QtajjwRA5IrTJQnvCF0HC+Z4OpZ/fJEmAthJOaReofMSkCEANxz57DVgeuMVTDW9OJLxToxOf9Yf6IAFKRfDdVHs8AneN2I4IhqusFb+iaw1/XUi4InBPKglqU/ARzbIDi1bdJX7jA9dX3+4ANmnqAczRgdqMuBwyZKNvQuKXh2w0n24oDy0Tal+WCFFLjiCrKU28do2C+1ROLCVDfk3dLqIeBaa5aoRodqY8nJzuGMdbE8R3SJfm+buHh9Yu1Li8RLZcNlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEbc+xPe252FsXlJUozVeaJUXOhtA+iiaJNek2TeIbg=;
 b=ESoaP7r5mJYrhAbBi4zEKq7mLWTekrhCvHBieWhaqlgYZOtrofgtvmj1kKI5SJ44vtLEhLUqFDXEFzVAwtMzalBvMZrqcp1dPTWIWOmRs02anmQVcYQBU5KAQy17GpNMyofWky0vrh5PldVk4AjwwXNWepBmthZ5KGMarajfE9s=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 06:25:56 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db%8]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 06:25:56 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     cl@linux.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] mm, slub: Use stackdepot to store user information for slub object.
Date:   Tue, 31 Aug 2021 16:25:39 +1000
Message-Id: <20210831062539.898293-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831062539.898293-1-imran.f.khan@oracle.com>
References: <20210831062539.898293-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:31::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (110.33.47.182) by SYCPR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10:31::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Tue, 31 Aug 2021 06:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb158f36-e64e-42ca-3cd5-08d96c483108
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1999B2C11C116223D371DC4AB0CC9@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIw/7bodPDaeM44YZ/LLPiGxt4JBG1VjJwTxVS8pmFzKCCAIXOopxkEY5uq2DUpUPCyH9raEbe+X32NBJOyWxZn9fs6007s3VqCSrAnkOCMNspbs6aU2hoq/gxyPgd2/T47t3GkA3i/QGe6JNyHbHhkggof8nYsL4Q80SGG/zPIBYdrKL9YAUxCkwyySZkarP2yh9WmKx4T69Bf2rMR1rzrUlPAl26q6R3uAqtybdIC1lr2zlwxW8fUChUdkK9OldHgMDrT9y2s0ij/ZUz8JkOd34GRo+euW3WC74fYlMBO9IyR41FBYeiBO58sPA9SQRfPUnJCeX/H3RcK5HucFzvjBFb8Zq3Ill334mNRPDlf4J5xBFFMgd9c4vfqDspdk+GXKsuGMYYy5qk9ssLEtvY2i0LdTAjZOGrcJSuEXCoIZaqDy6W38fxH0s5l/cDoctCfkvGJ4tlNjbDy/ACzbpoxmBGRvuAf5OgJQoAnNzmXiT23Nv+7qQ4I4+y+mPQdkeqzueI61tujxWiNWW3te7EA0NOqTMncSEM45XiYDgkjtAfdKO/+3A7b9thIZW5S4XA20mdNiwtdBVDTYCHMdLJH4Nn/0FEbwc2B6j3jedfYDGbyJa5m6kCPJIQ92np9bBDmovw5bh9j8fgKr6kgZq9XGCgclamhsH64Jk9KWSPX+sl0EOLPPdRFtxkAb8hnYNA/glQKVE/r38aJydwbCXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(2906002)(956004)(316002)(86362001)(2616005)(5660300002)(66946007)(83380400001)(36756003)(1076003)(4326008)(6666004)(66556008)(66476007)(8936002)(6506007)(6486002)(52116002)(38100700002)(38350700002)(8676002)(26005)(186003)(478600001)(6512007)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6uZoL84Ipe9YqM0SZMpOR1oUMHE/FFBSZj/aYmScjxPjTykxYB0dtzddQSIB?=
 =?us-ascii?Q?WUJoBoTENPQQiU1Wf825a6WGxtGntA4G1nIL7OaLo/Y4PsXLLDWEda6tadw2?=
 =?us-ascii?Q?DaGRqErrZt2MpjFWm4mlCHsD6/Jp+tj4gPVT7FomRZMoVDRMmETTv5zNwKUP?=
 =?us-ascii?Q?6yftN6JdOaCfM9Cd7FzQlGEdob0hTrknTshRMIP24pftUY1bmxzgxoH8wqgZ?=
 =?us-ascii?Q?KrHbPxoJQq7Z7/tWysrekimG4zgaouFnOMYwXzJago2gnoxP8wpS3ZcpDavi?=
 =?us-ascii?Q?73ph3HZ9XjBKQp4o0aaDzjD+LI5HbphtwIKkooG4crmvXdaWCgvVYNdtACsW?=
 =?us-ascii?Q?VB/sOk0UMTbTNQ9XPDOLZ06T55YHI9wu1izJoB3Ug3ARnRtELdX0XCcs4qIM?=
 =?us-ascii?Q?UNjLIJvfQ18chYmqAbV6xeNNHkbllrwrmsvyDkocNWzGf3bv+OHTZgc0HEl0?=
 =?us-ascii?Q?YSFMf7h7eY1GZDtEI2Y/2Lb/Vmut1cdKsgvNU3ZOKU95ZLafjlvBDEVx0cNn?=
 =?us-ascii?Q?El4CRRbD3oyCxohkSxMFPa2p8qxvnKtnlTogJwt9W8Hx6Sz3Bsbn2OAmWCcb?=
 =?us-ascii?Q?eYoFIsSCr5U8kpJxxecBqJTH6xmSl2zY4r/8xT3stH85M2VsUXTbiqoYLYqq?=
 =?us-ascii?Q?8U2A+AilE3z5y5SXCYHURNtyD2nrn1luAzMhzZDjtv5HX3eZe2S033xARSVJ?=
 =?us-ascii?Q?e/lnYVM6f8bPKw4Tknz2TFKsCDukOvA/JPDZ7RFJfC5Jurv93+hRx/7Few+2?=
 =?us-ascii?Q?e/KNeXITure4fjCSczSlBS8b1rgKqSZIVuqqrxNyhn9wOHotYKcXAE3xVk0p?=
 =?us-ascii?Q?QknOKeHuMFxlocHQia7ZGsbhOGcAQmFhO/6a3svIik8tmIR5w5YKXCXwhuSj?=
 =?us-ascii?Q?6A0reRmjUMxQjnjnTkJr8dKTWsh0oON1+w4YuJxoSYwO7TML92Y0ajy3UiSE?=
 =?us-ascii?Q?kxCFn0a0TyyppiIJm5Ni848CVPKYUGOjKPs4eOnwA3Xha2OpwjKQwIiw4rvr?=
 =?us-ascii?Q?PvO8c6MP/mY4jsGsZ26xtSvWij/ubwPcgTF1loK5Q6gpPk24sNqnFC5weA48?=
 =?us-ascii?Q?Tg+iPMOv6bwDz4bHrjI9IzKnxjPvGxbjRVIygSF7UKzl7EJjC8zKYQVs/IEf?=
 =?us-ascii?Q?KcdXc8y5sVGVfUmrsjYkyI8DmzNQv/gy9BuYOgowX6sZWz0O7aviBCenHM61?=
 =?us-ascii?Q?t4JJJ9y4UooXo3Z63Hb9whREKt1zV16xLonVZihf7EiIKhpsb/YIyfuRVaiZ?=
 =?us-ascii?Q?lJp+ABvOWEWU7SkcT1/G9Hui7xcmm+4MWKDvE1p2wWaF0djnsHMducIBW+Ma?=
 =?us-ascii?Q?+q3J4mOXHKdQhz5T3F9JkuJk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb158f36-e64e-42ca-3cd5-08d96c483108
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 06:25:56.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8pGhTgu6Rf5fQKhZ9L6IJFF5Nysw0SbBatwEBT0OuFJOrGHUrKaoxmbtJgCOG3rXz1AHw/qxmPQbs6aWtU/UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310036
X-Proofpoint-ORIG-GUID: 36uYU2Fqdf2FNvQriWcxk4PNCHIYJY6P
X-Proofpoint-GUID: 36uYU2Fqdf2FNvQriWcxk4PNCHIYJY6P
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLAB_STORE_USER causes information about allocating and freeing context
of a slub object, to be stored in metadata area in a couple of struct
track objects. These objects store allocation and/or freeing stack trace
in an array. This may result in same stack trace getting stored in metadata
area of multiple objects.
STACKDEPOT can be used to store unique stack traces without any
duplication,so use STACKDEPOT to store allocation and/or freeing stack
traces as well.
This results in low memory footprint, as we are not storing multiple
copies of the same stack trace for an allocation or free.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 mm/slub.c | 87 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index df1ac8aff86f..8e2a2b837106 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -264,8 +264,8 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 #define TRACK_ADDRS_COUNT 16
 struct track {
 	unsigned long addr;	/* Called from address */
-#ifdef CONFIG_STACKTRACE
-	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
+#ifdef CONFIG_STACKDEPOT
+	depot_stack_handle_t stack;
 #endif
 	int cpu;		/* Was running on cpu */
 	int pid;		/* Pid context */
@@ -668,6 +668,27 @@ static inline unsigned int get_info_end(struct kmem_cache *s)
 		return s->inuse;
 }
 
+#ifdef CONFIG_STACKDEPOT
+static depot_stack_handle_t slub_debug_save_stack(gfp_t flags)
+{
+	unsigned long entries[TRACK_ADDRS_COUNT];
+	unsigned int nr_entries;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 4);
+	nr_entries = filter_irq_stacks(entries, nr_entries);
+	return stack_depot_save(entries, nr_entries, flags);
+}
+
+static void print_stack(depot_stack_handle_t stack)
+{
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(stack, &entries);
+	stack_trace_print(entries, nr_entries, 0);
+}
+#endif
+
 static struct track *get_track(struct kmem_cache *s, void *object,
 	enum track_item alloc)
 {
@@ -679,21 +700,13 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 }
 
 static void set_track(struct kmem_cache *s, void *object,
-			enum track_item alloc, unsigned long addr)
+			enum track_item alloc, unsigned long addr, gfp_t flags)
 {
 	struct track *p = get_track(s, object, alloc);
 
 	if (addr) {
-#ifdef CONFIG_STACKTRACE
-		unsigned int nr_entries;
-
-		metadata_access_enable();
-		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
-					      TRACK_ADDRS_COUNT, 3);
-		metadata_access_disable();
-
-		if (nr_entries < TRACK_ADDRS_COUNT)
-			p->addrs[nr_entries] = 0;
+#ifdef CONFIG_STACKDEPOT
+		p->stack = slub_debug_save_stack(flags);
 #endif
 		p->addr = addr;
 		p->cpu = smp_processor_id();
@@ -709,10 +722,11 @@ static void init_tracking(struct kmem_cache *s, void *object)
 	if (!(s->flags & SLAB_STORE_USER))
 		return;
 
-	set_track(s, object, TRACK_FREE, 0UL);
-	set_track(s, object, TRACK_ALLOC, 0UL);
+	set_track(s, object, TRACK_FREE, 0UL, 0U);
+	set_track(s, object, TRACK_ALLOC, 0UL, 0U);
 }
 
+
 static void print_track(const char *s, struct track *t, unsigned long pr_time)
 {
 	if (!t->addr)
@@ -720,15 +734,11 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 
 	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
 	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
-#ifdef CONFIG_STACKTRACE
-	{
-		int i;
-		for (i = 0; i < TRACK_ADDRS_COUNT; i++)
-			if (t->addrs[i])
-				pr_err("\t%pS\n", (void *)t->addrs[i]);
-			else
-				break;
-	}
+#ifdef CONFIG_STACKDEPOT
+	if (t->stack)
+		print_stack(t->stack);
+	else
+		pr_err("(stack is not available)\n");
 #endif
 }
 
@@ -1261,7 +1271,8 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 
 static noinline int alloc_debug_processing(struct kmem_cache *s,
 					struct page *page,
-					void *object, unsigned long addr)
+					void *object, unsigned long addr,
+					gfp_t flags)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!alloc_consistency_checks(s, page, object))
@@ -1270,7 +1281,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 
 	/* Success perform special debug activities for allocs */
 	if (s->flags & SLAB_STORE_USER)
-		set_track(s, object, TRACK_ALLOC, addr);
+		set_track(s, object, TRACK_ALLOC, addr, flags);
 	trace(s, page, object, 1);
 	init_object(s, object, SLUB_RED_ACTIVE);
 	return 1;
@@ -1350,7 +1361,7 @@ static noinline int free_debug_processing(
 	}
 
 	if (s->flags & SLAB_STORE_USER)
-		set_track(s, object, TRACK_FREE, addr);
+		set_track(s, object, TRACK_FREE, addr, GFP_NOWAIT);
 	trace(s, page, object, 0);
 	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
 	init_object(s, object, SLUB_RED_INACTIVE);
@@ -2987,7 +2998,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 check_new_page:
 
 	if (kmem_cache_debug(s)) {
-		if (!alloc_debug_processing(s, page, freelist, addr)) {
+		if (!alloc_debug_processing(s, page, freelist, addr, gfpflags)) {
 			/* Slab failed checks. Next slab needed */
 			goto new_slab;
 		} else {
@@ -4275,6 +4286,8 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	void *objp0;
 	struct kmem_cache *s = page->slab_cache;
 	struct track __maybe_unused *trackp;
+	unsigned long __maybe_unused *entries;
+	unsigned int __maybe_unused nr_entries;
 
 	kpp->kp_ptr = object;
 	kpp->kp_page = page;
@@ -4297,19 +4310,15 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	objp = fixup_red_left(s, objp);
 	trackp = get_track(s, objp, TRACK_ALLOC);
 	kpp->kp_ret = (void *)trackp->addr;
-#ifdef CONFIG_STACKTRACE
-	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
-		kpp->kp_stack[i] = (void *)trackp->addrs[i];
-		if (!kpp->kp_stack[i])
-			break;
-	}
+#ifdef CONFIG_STACKDEPOT
+	nr_entries = stack_depot_fetch(trackp->stack, &entries);
+	for (i = 0; i < nr_entries; i++)
+		kpp->kp_stack[i] = (void *)entries[i];
 
 	trackp = get_track(s, objp, TRACK_FREE);
-	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
-		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
-		if (!kpp->kp_free_stack[i])
-			break;
-	}
+	nr_entries = stack_depot_fetch(trackp->stack, &entries);
+	for (i = 0; i < nr_entries; i++)
+		kpp->kp_free_stack[i] = (void *)entries[i];
 #endif
 #endif
 }
-- 
2.25.1

