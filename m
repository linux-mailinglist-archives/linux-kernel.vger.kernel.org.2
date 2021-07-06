Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8D3BC513
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhGFDcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:32:16 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:11064 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbhGFDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:32:10 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1663TELN020284;
        Tue, 6 Jul 2021 03:29:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-0064b401.pphosted.com with ESMTP id 39keq6gxrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 03:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL7Y+BASmQ5zbq8vxw1tLEailMKMB1jia8Ho/imsC2btR8rYN1k93kQVDJWVXt1vzZb+y5TRH9YP7jvS4bMwrPehlm0ziVEa8okPEaZNmheAHMRapqri1ln7J7vDY+tYZVUDxQunHhkVKjvPW6ugNW22dkB9nq71FK27Q7YIE+UJeEqu+1Sj3r6XYkKkvoGBXsalCsKUMyHXqK7xDiQM51uUJnSt2zLxMzM873YPRTRI1vaC9pKthXAwK46348i47FD0fRDUcH+6GlSPVWv2ep73RErQhRqS6vM7785ct9132NBv0Q51/Nj3mewVbOzOcf57jeK5HzPZqWNJy1KGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR9+qThdM+NBgFft6Q2FLOOogLTH7x2kfcVXqmqfR54=;
 b=AgMHpEi41p2Nz5Z6K88+WUuPE65FstzxD3jYK1FHq91xvWlDgYhzQAnwGKdF7QLRvgi9hQ9NxfsTKjBtwrSZWd2N013GKLlfwbL9hLujOIY7fhWI4lY6NR4FA4QK6haOd4h/Wcf+KAcQSj/YPXHG2eWe70owZXrhYrFlWvjq9VM6u962mQw3Y1Gv/lVlHrMjMoKauMH2UXtqsCgd0KHlsqkARKanGLu0DuQowIuYz8xQMirDUWqVfPUCAJGHfu7BXUhtoMqMPmhId3oE7AvGSUAJ1oD+Wu+Uz1Ew8tanUblaEidip4ANj+90lNti71s8JrCxgWSzn5MaTDGK788AGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR9+qThdM+NBgFft6Q2FLOOogLTH7x2kfcVXqmqfR54=;
 b=lpsnFbhUpZZW/HrHjV2oiavqRvLheiOXtiqF7xRYsoFdNmG3AN4poMIt54TnueJRowpUuYWfxsKPxwO4pYaDSeogt6Y2hbji7bikNbIwBZjJWdV+5XveIpMghIH1YUIZ8ygmkb6ypVRMfF28ugJj7CtBTsQ8BVXRe2ttPa9cc7A=
Authentication-Results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=windriver.com;
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Tue, 6 Jul
 2021 03:29:15 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b%8]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 03:29:15 +0000
From:   qiang.zhang@windriver.com
To:     mgorman@techsingularity.net, akpm@linux-foundation.org,
        alobakin@pm.me
Cc:     songmuchun@bytedance.com, wangqing@vivo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: Fix sleeping function called in case of irqsdisable.
Date:   Tue,  6 Jul 2021 11:29:07 +0800
Message-Id: <20210706032907.1276-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SLXP216CA0058.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:5::20) To BL1PR11MB5478.namprd11.prod.outlook.com
 (2603:10b6:208:31d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by SLXP216CA0058.KORP216.PROD.OUTLOOK.COM (2603:1096:100:5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Tue, 6 Jul 2021 03:29:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f58ceb-602d-4f9c-258b-08d9402e3b2a
X-MS-TrafficTypeDiagnostic: MN2PR11MB4662:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4662E9865208498973E02BBDFF1B9@MN2PR11MB4662.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lo2uOhmIS6KKiKHH9bF1vUBihkaTvTKl0GrOMrU1pG6HgsZG/vvIfeKoX5NGUhbyAiU1bw8vUnSCxLqmF8MYepi6b48JRbGlGMS/e5s7WI3prGIpzWcfNHPSsWeY3fMdgQVkcnp4vEd6+qCQ3jO5tVwp5oj3TQp4KNb8tXGLkeMfOYoOcLLfDUQdqXPblbnUIlQVdgFXKMmYcIvHt01U+h/R2SCLrIJQrSCy8U1NLFz8j4JTUr+73k25UDAVzsyoh0cstSiygt7+TpFEAOkriGAn2kkzhHSp0CEg+gojOQdHYWgoVmXSEZJs7Nl4cG+Rf1m4lRIHo6BtURbDqh9IZFC4BIYHw95Mu6v/f1qyk/51FWuH2/YShLZfnwTVgkDskk4abbChivtddi3LVTqP7d4tAq7thLNP1L90T3Er+hL0Vk6I77oM2beu2kOVi1b2Yd3wOhj+bDdOBJp6AQRukb7BnmaK36PETz0jpV1y1i6m6KFbRrGm03NlyWIBQB+FXdFE8btVtGEAyd/zHPpugRTzkY0+MGyVMN1s04jq9JhowDTmpHhnJpyeScqeeHBHrWNSk60eQ7iQZ0RvReIfaGya+WTemgmMLe47StTFFOSJf6fi5EXFLNDQLkrWmt5zRiXn1JCBIgHz+XkrKstSAkxuKsjcsGPSbgyB9CNmoOmpOpw6IUWlrTmJrloupNY1u8RwoUJE1RBcqDlzQqw43g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(136003)(346002)(376002)(83380400001)(36756003)(2616005)(956004)(38350700002)(38100700002)(86362001)(2906002)(1076003)(66476007)(52116002)(66556008)(6486002)(478600001)(66946007)(6666004)(316002)(6506007)(4326008)(8936002)(26005)(186003)(6512007)(9686003)(5660300002)(16526019)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eV/o3V4wyDlTVGyI8D35kkb+TcxuWLPBb3tevG38MlFOJ4bIWYBXX+PEq12V?=
 =?us-ascii?Q?vzDhS7yGAD2W76UNS43MMSqaBNM7DwnYyBY3egUhMv61trBmfy7LiwTjpC01?=
 =?us-ascii?Q?3T4O9bk01k3IbP6mWuqji3CNquOsVgdNqqgNzMqeYVsqxpA7r3yhxWVaMXNf?=
 =?us-ascii?Q?4IKkgqV2ZT5C1JEREsVFwXXZ7aGi0S2vrXbmnneQM25miCphp8Y8DnduYobP?=
 =?us-ascii?Q?IxCBxkzbVKcsVoxa5Y1kr04DjjBNXRdcL8KlOR/9XEbtisuqz5C6PQnOescp?=
 =?us-ascii?Q?JcPo7PyWwu2o88gF6q21jJZRpO07MiFn8FYjLoaizPfliinFBs5e2odck47u?=
 =?us-ascii?Q?tP57g9kO0MnhclGs2+2jX+GCxNhUTURlO/95s6+IghYhyc1SfPY7pcyduewd?=
 =?us-ascii?Q?Brq2hql8Xt/l4FtG3fBHEQwZH61Pf8tXitXT+IJ8NpRZVNO3DVJoXjDyM9qA?=
 =?us-ascii?Q?mbV+8tLMuVrLB7uoOr34/A8PeG0/RjejzvlpThVPlHM+g4b/Osfl0YUoLSVn?=
 =?us-ascii?Q?L1fm3glu4N8fDZRrQuCm2+Uy1DANds0yZ1OmsvUuj+S3i8PC0uG2bqjzSOGO?=
 =?us-ascii?Q?DmLV/w1MCFz73w4A0G6oqm/t7Vb8R8IChRadzZUgjvoLdVIRpy+wQsDm6DG5?=
 =?us-ascii?Q?YRssKh/AhZTUTQhY/JRrxWxaTIJXZiL8Dtl3movDiBmvENNXzl0zu9jxbthM?=
 =?us-ascii?Q?zeWjDlBnfq1oKiOKg4xo3RXHKT8wVCLViziHmfNkfKlbPSNqlrI42L9TsQ75?=
 =?us-ascii?Q?PjNRszNzSVPaaEGSa/p4NYwPbLN124+cIn9Z+9YWPZAP/woEF2FjwfB6UH1J?=
 =?us-ascii?Q?8Fy+gXN6UctNQjEBudF5Gbjcz5qwbHSvVYqqKkTqA7TFKoZZWWMzjzXU21l1?=
 =?us-ascii?Q?yYZm7A0YZot3aAYsHj2yQUiBUDSeM/7/2T1gFP1SYBdAF/T84R7t2DkN9Gx3?=
 =?us-ascii?Q?zsWgwOtxDmoywgrkc/Ha0HyOTI6kItrLoaxE7JqY+1MaHnrpBd6XxPlB+3k9?=
 =?us-ascii?Q?K9yzET7vsr+OqeFFT6y+cTay+tP8UOXEvIN9KNRYNeIojcazcDWe7aSwpNwn?=
 =?us-ascii?Q?q/6JYCjRGVURcJuLFQVKWK4XItu1yQYmuml5CZHvpDLGBiurtMbbNFy3BtMn?=
 =?us-ascii?Q?JOc+Rb4Zbo6WvB7Mmiz1XicwfYdCJDFRQJPW+uvlRxKNSiGJShU11Fg7SzbK?=
 =?us-ascii?Q?V55X8qUlXRlcP/1B6FtqD84N7QnFFy+WQNcBAKT56HWo7fdpnE6JWAqBcC7n?=
 =?us-ascii?Q?Bea+NFWqVWeDNgofJR41uSe+yQoMDM8gqA942bQey1XvXyM3X33SXvHhY226?=
 =?us-ascii?Q?W+m3+iH+5fVUS6HX90z1XusU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f58ceb-602d-4f9c-258b-08d9402e3b2a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 03:29:15.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7QR6cpI2vogZ7L19QGOhAceearTI2gujBdz00zanfcNYH3pfcz3Xoax2pnyMaNaf50/L+1aqbJuxCi5Awvao+UhOFZ6IvODpTGQLJvzuGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-Proofpoint-GUID: VhApMXyWa5cr9WLlGl05q1rnVj51icaY
X-Proofpoint-ORIG-GUID: VhApMXyWa5cr9WLlGl05q1rnVj51icaY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_01:2021-07-02,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=940 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107060014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
.....
__dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
 prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
 __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
 alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
 stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x50/0x290 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2445 [inline]
 __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
 __vmalloc_area_node mm/vmalloc.c:2845 [inline]
 __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
 __vmalloc_node mm/vmalloc.c:2996 [inline]
 vzalloc+0x67/0x80 mm/vmalloc.c:3066

If the PAGE_OWNER is enabled, in __set_page_owner(), the pages will be
allocated to save calltrace info, due to the allocated action is executed
under irq disable(pagesets.lock be held), if the gfp variable contains
the flag that causes sleep, will trigger above information. the
prep_new_page() is not need to disable irq for protection, fix it through
enable irq before call prep_new_page().

Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
Reported-by: syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6e94cc8066c..8d7f0f5ce891 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5309,12 +5309,14 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		}
 		nr_account++;
 
+		local_unlock_irqrestore(&pagesets.lock, flags);
 		prep_new_page(page, 0, gfp, 0);
 		if (page_list)
 			list_add(&page->lru, page_list);
 		else
 			page_array[nr_populated] = page;
 		nr_populated++;
+		local_lock_irqsave(&pagesets.lock, flags);
 	}
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
-- 
2.17.1

