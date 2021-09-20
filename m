Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520F3411B18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbhITQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:55:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:14794 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244789AbhITQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:51:17 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KGiRHN022052;
        Mon, 20 Sep 2021 09:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=Km3l6299uDuw5kyPIBMWN1JlaRiFAbeVVD/i+jKZIwo=;
 b=hsErk7glftoDRBLpWbWmpBBH9nlvCIOsLv4vu962akVQgubHJy5UB7reoI+ajwZB+p8E
 nJacZ6d57ZOoQEaHwXY1WzSaiDsot+FIeLAbY/BQOKN7/maTfEDiRsECWBGEh1FfFg5N
 QHFuFVFcAscfGHtRo5g+rTQrjJph9Yhz9PuLzJTu33zWrR0L3CATpMYdTESS/GMGGNyA
 V7+ESSfiwbKJ1QS7FzDMth1DE7e4CZfQ51ZgVBQL2ZnOFb8wTrnfrE4HjUjuXDdCJuT7
 YTVrNK+g4zpeT1hFuu9CWfLR1TL2ukUWLDkF6/SslfaTBr2FTKkG/dAfkC9CIwRuCXQJ gQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3b6ug38csr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 09:49:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKsMf1qAf2GhPcbGfJrH4eVvv4ZIRWXJHJpiwoJa4Ants+d+Tn3vjSsmZrq5HHR8lNZBJEnYq7OeIGchUZ4b1GqizFFdjWJKKOH4kUA/WnFfpIB6+8rGEyc+VNadJ4KinGYM4zM8PcyKlGIgyX35ajdYZAprxBM/SnkQAyL9EUzhsQ6SWhhZz1dulc+g8rpLP2RZ3KYFD/s+hff20boaBubA8U8EF1cHgonkyKnqL7G+EE8XY4lpTDmO3aHzJJ/pfMKslTPKgtw8xQBcszT4O3FT/6kVGF5OMuUStIeiMzPk5eL87qiLriQRd9UDIqYy5QJH4Tg+esHd8b6bPk+7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Km3l6299uDuw5kyPIBMWN1JlaRiFAbeVVD/i+jKZIwo=;
 b=FE5zGJi8NR2Jj9ymQ8ywfDG4tCZ8p6g2egSxVBqyPLxMwnrvUyNbFolq8hFq1vfO00iy5iFeGs/zuzKWUg6bTf0YmvSx0hZV3ZJHnme/ELYNgmc+kSoNO6lLWQRCeG5kZhTux7MDWaYhZJ1kG5X4lEICHN3z+azvx2VGeNDM3kwdp6gAqMkGWD3KChvb73FDfRActTSrWj9ySjqWmb16CIBg77KZdUaN1uAV9I5nwaFjSewMPDPWKBvZ0yFXN9yaLbMhDqXmRMAfSugOjJemRnH6FoqWwrxxSFRYjsqt2Pv609ODQTu7MqTci+Pe9MFm3FdzT+PT5j/nQomJCyUEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nutanix.com;
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB6953.namprd02.prod.outlook.com (2603:10b6:5:253::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Mon, 20 Sep 2021 16:49:45 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e%7]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 16:49:45 +0000
From:   Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, peterx@redhat.com,
        david@redhat.com, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com, jonathan.davies@nutanix.com,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Subject: [PATCH v2 1/1] Documentation: update pagemap with shmem exceptions
Date:   Mon, 20 Sep 2021 16:49:31 +0000
Message-Id: <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
X-Mailer: git-send-email 2.33.0.363.g4c719308ce
In-Reply-To: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
References: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::7) To DM6PR02MB5578.namprd02.prod.outlook.com
 (2603:10b6:5:79::13)
MIME-Version: 1.0
Received: from tiberiu-georgescu.ubvm.nutanix.com (192.146.154.243) by SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 16:49:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfbe1c95-c618-41d9-a660-08d97c56a658
X-MS-TrafficTypeDiagnostic: DM6PR02MB6953:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR02MB69533C68A99A9AFA92E26916E6A09@DM6PR02MB6953.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aw5qznX3mQ2dA7m1XZXPfUVj1cBPUTDtsRH7wXF9tU9xy2yHDOYC5zf3GGPEYcGuaec2ymedvLkTPWvyl2vtZliFfb6DT3XY9rDhMhM0AO7UZbDmg/ojmMPk5Jb7flOboqXYEp39f+1DhTLDbMzySJFuQIwR9XyGV028BvEIiStRmQPRcVq2xCUw3dU0xFYjXrJnF0qFeLT6q1CaKzRafyIdYQqgjIjBSI/Ug4YpTHliOhYnDA9qLBtpRvze/JMYgRYXV4rvnZW2KfIkcF3zW+mGU890Qt9xCCTh5p7eou0e/7KlYQfIOpnYW3j3h9BHV7zT+qqx6jhjWQe9VTCA2kbUg4MeEKgS5HaPw/3bleb4HFuyxQ8E9z3pQFyPsqW10csOdKxnqiHRcuQr6NTFvky82bZ7Wvw3qnHNBxxT7XnC2Uu72NZ8lIKv3LEcx83uodcVVpW/wxBrbrbgthNue9OfWFLhGXHawWV33WuMJHL6GJ0HnG7D6jICrxoB+o7miro1gQE2n+FyK194zqvt0m2QR5BDHIMe2ojH3YzR/wM+llv19mEalW08CwbG1+Ak7V3NGRyGYF1nux0UT1mzc7xQzZaFzMLCA5Qf9mERQxvLGkSLHA0cbdCVf4PPbWrcKqoI6YzsDQ9YV2oKViurdUAEwdQX1TWKYoXsbKvUxurctjPjvs3dD+h0Tm3Uczzu5v4g9ZYcQu7aSQcKFe4NwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(2906002)(5660300002)(86362001)(66476007)(6486002)(4326008)(36756003)(26005)(38100700002)(316002)(83380400001)(956004)(66946007)(52116002)(2616005)(7696005)(8676002)(38350700002)(107886003)(8936002)(1076003)(186003)(66556008)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQZDlXO4e7bHFVWemJfq40nfBQlZOVxyy9CoaPomKB7gwtTvhJDI6N5Z0HLq?=
 =?us-ascii?Q?n6DKqday2Drm9yJNGecEIZoNvzQVrhd+BWNvqaaI3idnC2jnSvST/SjG0ioa?=
 =?us-ascii?Q?73PdiFwQj6VpqKZsvTlEKLQjlotmI1ixNlJd0eCIyadsphmNTSP6nyTdLbxA?=
 =?us-ascii?Q?W3p9NKWxK+Bv5pPwI0+xRb/UXtOXLPOpYvk72b6iURDluqdKyx5WKPThMamb?=
 =?us-ascii?Q?dV5qpQy2ef/AWfmQ1ZLOEV6icWyKV8PCdeBoRTKPbDG4PowF421QJsRPOwBh?=
 =?us-ascii?Q?DB8Lr4jhGW8RYbhMlGRp+/Q8qNpbwFrLmp6OspnomLnv06joiRiKfE0wTgAr?=
 =?us-ascii?Q?4Isok3X4MuuFG8Fp84aiQhjaHmJRFgOdecZyrXRhRQbhpoXUlQL9pFKs+0p5?=
 =?us-ascii?Q?LpcBEKTyxS0ELjbkAaUEehr9TXKzBNamifCo7CMUhgtp6IhqhY2d9aQFu9C+?=
 =?us-ascii?Q?XglRkitGYdPaldL6E7U2l/j3wR0tVNj28i5ohR6zyFHJrYCvHmqxSPnPNZhu?=
 =?us-ascii?Q?8gvN+8wOVvhCZuDVK0618gRuiX+tSnzc1Hi3mMKAGiCz3CplxOcMOYN4v6+X?=
 =?us-ascii?Q?ikFS/6d7U6KktTMsi25+MT+GjSLR+8hD5qnKEqgYTzRM22WGDvOwEY7FiCee?=
 =?us-ascii?Q?WXWwUtgC8bAVA/F+wiObLhA/pncDED5bPSprAvapgWYDhG7fXpyJ+Hm30UHw?=
 =?us-ascii?Q?70rNaF4GF0vcExNstNTIhwzXoIsfW6MskQzfrCb/h1bi/mVXxRAvKxkxFDUw?=
 =?us-ascii?Q?WL1J9f+abrHrfA62/lsXrBT965RKjWyruRQP2fjMP0ib2I0LekMba/nBrxaQ?=
 =?us-ascii?Q?lN3rb9MQRmPkle9vosvslGKDeEtakdyo2I/TaH1585x96pdlzcR9a5y7UL7T?=
 =?us-ascii?Q?Omf8wV4BQZ90/Ns7KSpg4r1btbpDA4iS8craHtezlkT2DXkIbpxN02pUq3Wl?=
 =?us-ascii?Q?TXGd4koymfT3Hi3o/DADQyeOF5fscXlusPAISOKCJlACmSQPyY0T6dfxo1EQ?=
 =?us-ascii?Q?hnR68XmDn/FUjZWvWPD6RfoBH9M1GkGEPwD9yEM3TWNetZ5uzatbXVh3HohH?=
 =?us-ascii?Q?XKV7Ftv08IWzAudE3iZvx+ryoFQrfzSiyAH5YLjF3uWG7tm3zqJAl5obHvNP?=
 =?us-ascii?Q?g8WhrSnTTNScl4SFFxbl/mF7+cbmcRIWLq+gEken/aw0J62puKL0NpQA22Qj?=
 =?us-ascii?Q?m8gqBVt8SnwcHt7oZREnkSfmLTB/3X3+w6MxyeN/jjuJDsUw16bvUMVKJ8lc?=
 =?us-ascii?Q?YCSANhFugFTa6co+jT/l2PxNyv35szB0pA1nR2UB4QmW4ZM+XgHT5zYzEUL+?=
 =?us-ascii?Q?s8J57gy4IUQhGtDQ8Q6VnoV9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbe1c95-c618-41d9-a660-08d97c56a658
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 16:49:45.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHdbl+qWK0r33Szh8B0SzRkLRSqxF+aroTO+ZKoH3I4yKWADl7+0oMAGZOgoVymnR4FCbFidmqFFcayMYickHY2cjkD+igAHrVVsG2BP0LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6953
X-Proofpoint-GUID: jq_ufPv7KyPZukm1YAQFVTOdmUI_PHG8
X-Proofpoint-ORIG-GUID: jq_ufPv7KyPZukm1YAQFVTOdmUI_PHG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mentioning the current missing information in the pagemap and alternatives
on how to retrieve it, in case someone stumbles upon unexpected behaviour.

Signed-off-by: Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Reviewed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Reviewed-by: Florian Schmidt <florian.schmidt@nutanix.com>
Reviewed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index fb578fbbb76c..ea3f88f3c18d 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -196,6 +196,28 @@ you can go through every map in the process, find the PFNs, look those up
 in kpagecount, and tally up the number of pages that are only referenced
 once.
 
+Exceptions for Shared Memory
+============================
+
+Page table entries for shared pages are cleared when the pages are zapped or
+swapped out. This makes swapped out pages indistinguishable from never-allocated
+ones.
+
+In kernel space, the swap location can still be retrieved from the page cache.
+However, values stored only on the normal PTE get lost irretrievably when the
+page is swapped out (i.e. SOFT_DIRTY).
+
+In user space, whether the page is swapped or none can be deduced with the
+lseek system call. For a single page, the algorithm is:
+
+0. If the pagemap entry of the page has bit 63 (page present) set, the page
+   is present.
+1. Otherwise, get an fd to the file where the page is backed. For anonymous
+   shared pages, the file can be found in ``/proc/pid/map_files/``.
+2. Call lseek with LSEEK_DATA flag and seek to the virtual address of the page
+   you wish to inspect. If it overshoots the PAGE_SIZE, the page is NONE.
+3. Otherwise, the page is in swap.
+
 Other notes
 ===========
 
-- 
2.33.0.363.g4c719308ce

