Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5D3538A1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhDDPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 11:33:40 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:64865
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230522AbhDDPdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 11:33:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyKLML+beuTlEPu7EBWQsfEfbGwHAPIqnmEoRLIgjshc5GMpQ/0nqr9/2HxKnDV9ggw7zz6mCBQrJ8+a0PxQsjboO23Q4sfLRJRUdUMoMuqLrEhVhi1S7bXNyKNFw4vSFUR3Zpa9N1mFJh7jTS4hvKaBn6R9ohMajRCkdFAHD0lkN8/1znxOjlinl/sJq5n2y73pp+E83SbAfOrTSpFg0mIW7IvhLWJfN6YRMI0Gk2TiNkD+IFcPGEWdxC40mzn/dFB12Q4PnviIVz8dWUmzsunXYg1WbKk0SR6iZFVm2MWjhjoW8xhpwQ8FX05157NYLzr+P11Q+mqggCEG7JrkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBkUAvrWoH0M9to+Si6RvJubAPrImmTr3ieGP5fHuCs=;
 b=bpp0n9jvRcnFHhcmYBVwHbPwmYQLVocYtPszOvHQK8nyrIMuRNV+nIaKg3Qe+hZXv9S4JbigbnRKyoy4+rZgi+dmQJm8maYD08XU/i0pO+anAG7H66I9MGmxS84FI2Asfu/XiZ2lBSE3NBhjnoRTtKLUh0ewzT/TRxqnEytYMTX7sk3e8q5WlOtr5VoA2MHALcWjIBQ85J4UbYEuMXHCHDkpL83YBwWT466omChmarGhbTBRdvh93nqGb1b6zvudS8nQDQ6e5ecFMipa8lrwOdoTDPwezfZZ/IaRBa9F2XxSEAl5buDgF3Ku1+Ooa597MbGj5RZB1wNpBc0a5uVzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBkUAvrWoH0M9to+Si6RvJubAPrImmTr3ieGP5fHuCs=;
 b=G5bnXblui2fxbFnHeMPf5Obrxtal+54xz2YZXvL5SUTlkh7UqXvYRlfzlW5IFt7EktRdukno+2C4iJwtc2M/U39TYGFure7pXydyrFKZBeLHcLZRuOuTOYTEnsvgIeMPxD0ai3kWV5GQF1CVmVkg6GsKpylunO2T28Svk8lQM6M=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4181.namprd11.prod.outlook.com (2603:10b6:a03:18c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Sun, 4 Apr
 2021 15:33:26 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 15:33:25 +0000
From:   yanfei.xu@windriver.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: khugepaged: check MMF_DISABLE_THP ahead of iterating over vmas
Date:   Sun,  4 Apr 2021 23:33:11 +0800
Message-Id: <20210404153311.1460106-3-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210404153311.1460106-1-yanfei.xu@windriver.com>
References: <20210404153311.1460106-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:202:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Sun, 4 Apr 2021 15:33:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a77ed0-487b-42f5-9d3c-08d8f77efd01
X-MS-TrafficTypeDiagnostic: BY5PR11MB4181:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4181C100C3664EE1D2B0600DE4789@BY5PR11MB4181.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZmkmNdDRQs41HFQtdQo1YO+oL2bT5cfpDK/BLvc9lzwn/MEnee2qWoIVku0bBvCahwmWnMuDOErY46w8KHA0CbPdtwDtwCZnYktPLkbjVYpDmBmnNSqXz74fKnBXhclouJHl7cgqU8f50L14wkOwlw/D9CqXhk8CC8p7kZeuNfwvg91lfcbVYWiuQ/EJekouyTo/4vok/xzRwGTugVVostcp5L8gosvaONf2l3b2ZeYLvf6MCJclCftCwlQnFYbskrlBsR7GaRNmCXeL9RXOCBOxhjJogO8VHqIuI9MInRwNFkx93+kO8K1+hJGAxsM56DevTkfWKdxSoO7hds7rh1bDmiiLTGqGoK8XmlaiALxc3kYxlCf9WK3EJLYVIKINxO0pBEreBrMwF96I+tYQNQmvkkRflq/JSySJvNnGSmbIgIHe+plYpGCelR4vOsCvaeBOqHcobj+QqnRSiuWj2JNUyLj3pGQIlP55GjvHJ52/NVxYZCvvsAzfJkp2UWXP3VAZmdcR5czU032aTul8OBbR2I/c1HY5KsAJa0uz4bh/Yz91jknMbyKP3tuxhNLJgWcCvmUn2j94sqPmgcq5RmBkeAydnklSqk+q1wMWTr+ZfJqtjXf7P75k/hvsFOt5H8oCNDcoHUTWbFuffhk5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39830400003)(346002)(186003)(16526019)(6486002)(8936002)(1076003)(36756003)(6506007)(86362001)(83380400001)(8676002)(956004)(6666004)(5660300002)(52116002)(38100700001)(9686003)(6512007)(2616005)(66556008)(66476007)(66946007)(2906002)(478600001)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bMnGw+XPSNQ4DA++aDeshtyaLZQFBVGWbeUdc1nQpoCAcdUcafNAci/Be4IC?=
 =?us-ascii?Q?7HzP8jkWzK2/G/vHDMgl2RvvdiKeX2/t7wt4m87zF+4QqV/vvt0zVqq5Y9nd?=
 =?us-ascii?Q?mOEWR+taVfY5dwB2/A8jsThLG9tPSblJxZCAG1q95t4+Hzj8n2rC6VZGVM4c?=
 =?us-ascii?Q?umpQ5tO8qV5b5PE9UkTb6lfJYPobfHgtiOrthUgQ9AUrJewOBVqTZf6ktGCN?=
 =?us-ascii?Q?3cJnqzPGKjJ67eh9qrlgnC9WNnI1qF6c5ndKl6W3K5NxcN7bhfPzPMBgLa7w?=
 =?us-ascii?Q?pS/i5vnqnrbSPsGPfkpP7/hxvX4qFBtctb8JzfmD1gdq0CKPheb3EL1EXC05?=
 =?us-ascii?Q?5pNxHbNnk3Om2T6Xyx3zlHPeb6NaH4CNVw4jGK3BYmpnYKSVdhHQGfExFKQJ?=
 =?us-ascii?Q?4ChpUpD94czom9Daa+Du9rEkRcZMbeYDzicl1LOElBuUWgbEX+ZSip846IuD?=
 =?us-ascii?Q?tJ2KUdaF749woGCUYe0DrBVehWJPFr5LrK376uk4bx/MnsEd/Gl6z8GCJYW6?=
 =?us-ascii?Q?PqZXK8BPG74YVXo4gzBFC3oxnyyCzS8AaJxTf4sDj+/td1DDobXy3MFesnV0?=
 =?us-ascii?Q?GtyK0jGGYpzUlE7650ceDDXoePNvNgH19XbDlbYQWmjZRMh+QHmno8vpt02Y?=
 =?us-ascii?Q?ZT3zowEqoPMN+mnrHL6S9PDXPOmh2aa74/qOeN35sHEAjQ37y5Uxib2qw1vR?=
 =?us-ascii?Q?d5W/t5R/zUzS7PIPGWy8kiVZArCBopPNuXRfXrvXPCOqM28xj5lCZvWngBJi?=
 =?us-ascii?Q?xdMQ74gHXmG2eubhK8B/3x8xaPP6Fh7O3v/2fMzggSoo7X+3PvoAgL1QyEIp?=
 =?us-ascii?Q?tmsxXsXy3v/xUw+19xuliAfn4n4btU0cO6KRUdQ7yn47Gnxfq1CpiaKuHEzy?=
 =?us-ascii?Q?pYUo540Cxok5MMsG5AMKS5I9H4KGtxgoTAEPZ3mHpY7bMh2gU0zPWrwx1tfa?=
 =?us-ascii?Q?bwwRr9y676quKnU91VS7BpZB2CzIfjZ57L6/PjmCJlXa/gVTs38JwBKI/xS2?=
 =?us-ascii?Q?jVjdLD6LpQuKVwjvOTzfuxADuGGfMsMKqGUqAw9QyNxssh1xxJWk3NY1clpv?=
 =?us-ascii?Q?Cn1XKbWm43QMM4UinEQ5D5g1AfydOaTb94vO+iOvKzCcW0JLlR6O9yccqsr+?=
 =?us-ascii?Q?LtBMZr1aKjEbB4rz6l944ktFRkHGarSjC4ZFCciJTPqydinzo3mpNcGvdVtn?=
 =?us-ascii?Q?jeTWurqAcONpdPmdQZob+dgIkYxX4WHTlb7oBsuQdVUQktiUErMBF1GROJyW?=
 =?us-ascii?Q?T0EHapr4VA1jjmFUMT1TJsIjvttujEmEWbdCYLuVIb1f2800LGDZd/dfHMcV?=
 =?us-ascii?Q?kq4aAN0pGLvfosbFujJhhJXc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a77ed0-487b-42f5-9d3c-08d8f77efd01
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2021 15:33:25.8924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZJHoXGEGZ/om2O9g5HAaZQnfTfEwSTqqFvDnZo5BcwK2urRlPvf1BU4P0Lj+e4ONRT/ODMhexyHPar/wYRYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

We could check MMF_DISABLE_THP ahead of iterating over all of vma.
Otherwise if some mm_struct contain a large number of vma, there will
be amounts meaningless cpu cycles cost.

BTW, drop an unnecessary cond_resched(), because there is a another
cond_resched() followed it and no consumed invocation between them.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/khugepaged.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2efe1d0c92ed..c293ec4a94ea 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2094,6 +2094,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 	 */
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
+	if (test_bit(MMF_DISABLE_THP, &mm->flags))
+		goto breakouterloop_mmap_lock;
 	if (likely(!khugepaged_test_exit(mm)))
 		vma = find_vma(mm, khugepaged_scan.address);
 
@@ -2101,7 +2103,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 	for (; vma; vma = vma->vm_next) {
 		unsigned long hstart, hend;
 
-		cond_resched();
 		if (unlikely(khugepaged_test_exit(mm))) {
 			progress++;
 			break;
-- 
2.27.0

