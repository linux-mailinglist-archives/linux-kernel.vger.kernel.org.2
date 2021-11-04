Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41D445661
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhKDPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:36:18 -0400
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:40032
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229783AbhKDPgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:36:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzz0QXxle1HZeMaTOMnzPRSVxnCiVEUARNvCdCpcLwozEa3bZRGh2kLoEDO/TuRlf7TgvF6/MpASmGb0NFv7aDKf0RzNZFolWyYES4lj/LNjmAmrOnxVdkdjIv6j1fst4I9QVnLMmIcOkpJ4BYBU/whu2wPZ7G2lw0FWm80KeB+3tXghgglLWCiyFDQKdN/mkbZiR8+d6PtPW9lZJXN0RQ1tTzNCgz07/Ku+Io1M1RpldCD7F3gte7NZ/9hzxQQ+M266mdRKNbi1jBMvFu2YfsInlJlAdSkFcFygGzArGUF5YfVC0zWgEcjqSLU/ZFrpcd+n8QOGp61wfRzcGx8DfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKq01q5Khxkf5zZ8Lci+a6BGOm2g3xRz8fLxdgLJVyc=;
 b=IcaVoRklK2DOqClv2dNoDP8K4l32Hd4kKfBjzPNYGWm9sHrqqX9i640GAqrmUOX76W5mgO1yy4+N4Dx9FBYSBLpkCGf0ZDRPWJbJqWDWWn1PmisviCmlpDfIckdggEedm6XzOOl9pPX/MHoTpSws0+ixBECYcddfujBtdqna7O0sk34ek9aM993MjQP5ecRzPsjAu9S3kN9MbMvxJOq6H27T8xgwYq7Qo9rHWlvGKctZ5ZvTE0pmraCoUG8uZeIeMEuEWx53YSTUFyNymH4MwSInRJ3ESfxg6qxNUj3uH49O/HZtUrYoXpn1WZHQcoKsnAZgureoHfVyKc/msPMSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKq01q5Khxkf5zZ8Lci+a6BGOm2g3xRz8fLxdgLJVyc=;
 b=oVwJ2lqPAa4vndFmXux8cowpFEyu17ipFobK0OIW2rscgUFFSp7DMPVLxPB2b04aQLvJfmdY4gd51liLxXsOu8j67a3oMIHs1ssVXXgrp07G1Xxa7n6rFgKeDXSz98HU/vl6UK1TtZgsz9D8nYiXJyBdV+LfetAgPGuiZobQktdY708QM9vjuyB/zfLMNLD91i0ilgMWjYiqn2aPfNHy4OIgw7SzSgCoCUHhddJN8KAkbt6vBiweV0RRTpujskQBwB5CZ1Gm6fOD7FMv/SqYxxMEncn/AZUhu+rkE9EGkDbbzBcnWnyqRPwd+7/RWZTvdfH2UUn5ogyK8Wf/6eAJEw==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 15:33:37 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e%7]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 15:33:37 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] mm: migrate: Fix the return value of migrate_pages()
Date:   Thu, 04 Nov 2021 11:33:31 -0400
X-Mailer: MailMate (1.14r5839)
Message-ID: <81ED0EF7-779F-4977-AF09-665FF750319C@nvidia.com>
In-Reply-To: <c838c56f12cd3e6c693c0b124a167fdc07f59fb6.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
 <c838c56f12cd3e6c693c0b124a167fdc07f59fb6.1635936218.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A003A9A0-0FAD-4F55-83A4-641B103304D5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.56.203] (216.228.112.22) by MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 15:33:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 108bed27-f0a4-428b-872e-08d99fa8786d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3742:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37427D07BFF720B4265F05CFC28D9@MN2PR12MB3742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUSCkqL0mYXBUlVNRcR62zM5Qk+RqH07KBBuYI2tnzo9H3MmTLr0d5nRzIWYPMFPNF12Dp8VU8IO96ysDWGBsqb4poJeWvjxMANfUCnfSh+AcG7pi87QZZ639qguKDjACLZGxbBb7dym84llffLwT/UcMjQnFENRCXeeoqLzJ5KW1kCTmdKkA74ZYSoXecRD+VACDzQAp7ZH4ebGoseO3/YiEXwHE7vaCFzdad3kZN166y0HKdBLLnxFa64aHsf6jgNGKlsM7Q4ieNyNKAxNUrWreehyEjpfFlyNfOfK0dGKTFdrlO6dO7H4lsWKbJK+DkmrosAed3mdkVBXVoVeqfCvtFqGE83/hB+2TT+c5bdFY/ERnUu1nqD4OjT6ucC2dMj5tBB9900bgY0S1HsaCialjgoX6ajde81Llxao6y+OcEdsEtQGT5kQ4vbWoaoiErBhjMH2rPDzqq7frOCDpwIw8OlE1B5u1A6c2lwDd92YrTDwIkLGfltEyzSR0mAJyZEUSr3n8lb4mphHuQJhn85hJtfYAY+VQfj28n/iFPUQIbrgLglX007TgzuDHDtcy/DgJkpzdSDEnEEy+jDD3OUytSHNt116zaY4smyQc5D1sE9T4wqENC8wG7yrg1Mmwvzbci3IXPV/dKAgFEZo85OSszA9MgTLATUPHjwW1xegxHpzzLQnATBow8HnMV8vWo2n+p4mn2fQeId+6cuNagN6DdYLX5QL7McNF/d7NVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(508600001)(6666004)(6486002)(956004)(2906002)(316002)(16576012)(21480400003)(2616005)(4326008)(235185007)(6916009)(38100700002)(8936002)(5660300002)(8676002)(53546011)(26005)(86362001)(33656002)(66556008)(66946007)(83380400001)(66476007)(186003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jILKi+ukVyIqU40pmfIVj/D3kBuH8gkNGWWA2CbPFZAMD5JHqAwQ0IE1cS/F?=
 =?us-ascii?Q?UyfsNCgHVAVSrTSLjnpuB37cVZrym+yUR6wF6K7dEuD0K8qST1cw5LYoFBkW?=
 =?us-ascii?Q?YFGFRhbqCGty0lev8twyMcxonmoCZl6+iM38smUI35N8mxrP7rV3UkLAkzD+?=
 =?us-ascii?Q?Sk2APl6ndno5UHANRvjiYg76+RcGVuBL8wjeG+maciYGYSP9FqgVR3keNZtB?=
 =?us-ascii?Q?r4aawtMBhrEriadyQ+XMPWJeLSa8l54vPuFLOl3fG/LZqoJUjk1dgCWJ9gW0?=
 =?us-ascii?Q?r1OW+4Cq39Sqcty9C9SGvPF+qLf2bMYHJmBdJbB5VFRRI/FnsRG2L33CiFwe?=
 =?us-ascii?Q?eJlPVfLEU/4ZyLxrYZ93jYjpPZvyklYdKRfclggo2P5mAVKl9u6hQcw91i2b?=
 =?us-ascii?Q?clPgxVhadh55AYlaYSEkMfl+GcrARQ38PuTLS9rnTX4njl6dpKIKu/mE5lMj?=
 =?us-ascii?Q?Qjn1Xttn7prn2g5+HgzXENGpOrfenlw87tY3rOMqx4vzRDnytXEzB16tQYWi?=
 =?us-ascii?Q?o8TY4wMCJymIcbiVekxD6WtGAAIMUmulZm7zVJqWVUIOJqYb7oHBlIM9xxXj?=
 =?us-ascii?Q?1MORl3ltZzu7VCvDNWrYLSJgsmr7sG999pdXLY4/rPjMGnN5eXv1vZThWCAB?=
 =?us-ascii?Q?r+7ZjRoUvXA6Yg00zelMoA/mOo+pvOxUlABUKbelNXrdnHUQLzQzZdyIMuZG?=
 =?us-ascii?Q?Re2IqhcrPNacHQ91zE8ew9MLPlUM1WHCMcVq7Jgvzvi+cK67ZrljCdBh3EzW?=
 =?us-ascii?Q?Jw0K9vho1y26ePW0ZrvdfrvmeShSgnHuK6Mko7IeutB9WwCjFqEnCJ+63DsS?=
 =?us-ascii?Q?YptRZTXyUVwq1KhK9PI4oiVcN9fz3AxmOCq8KM52r/EQwWVAVPf1eYXInj6r?=
 =?us-ascii?Q?3NxYoxi5aHOcD0g2f6VRBrUsGHJ+EXzwoXtLFen9G0L/w3XrAGbP4MxzxMVC?=
 =?us-ascii?Q?A0Q7ubqBHNWLMTc7VpV/pCJpnklFKWYYXI3GPiyhOaCSCvP5xplrR2+eccXo?=
 =?us-ascii?Q?MyOy7Gychiqx1SN+hxoVpBAEXKQOhhoM0BeWXRyok8s7oNFS8yjbmuEPIg6F?=
 =?us-ascii?Q?hdV/eqhY3vRw9fKaAmGywrzIYt3IYZDQxjesWEaklzu4nGbTkyzz+7KbjZOw?=
 =?us-ascii?Q?zbFc2knyPULaadl9dAlkCRP2LvfL0O34VefAd2pCfCthpsQmf50r3sU3tqHr?=
 =?us-ascii?Q?uVIcCClNazNRuQFRC5O9vINXDB1R+KwwycHaQSyJUf2V1bysGTr9QTX0MtpY?=
 =?us-ascii?Q?r+d2h3bA3GYqhkvvrrWAKJxlG1dKdTYZAbq1rxUehVvjImbsqG+hVcrpZ8NS?=
 =?us-ascii?Q?5kPtXdO7XcbEDNprQmlM1AXMXfyBpFyUVH51hrILX9/84G7059RJ3neekxTK?=
 =?us-ascii?Q?+t8hIUpM0xMWQ1jbt0YUfkvO/+u66fuBe1P511OePoZBAJLOXbWbH6r+mL1F?=
 =?us-ascii?Q?5ABR51w4ZK8TUNIlDIY6DNB/HJ2hXHCy5wkYbmLwGaHDlfrHwVwef7k3k9y4?=
 =?us-ascii?Q?Kbq3CVnbptA31IXahCLJ1ZEFmRJ8H2T+TCv13wA94RXz7ZNDr83af+hwe+nu?=
 =?us-ascii?Q?yAToMWzAYK34Kkg3huI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108bed27-f0a4-428b-872e-08d99fa8786d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 15:33:37.4971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHWj2oqdBa+PRky8TeptT+lGmrdTkN3r721cZoiXS8cdz3onEfjJ+c0PUR+tScuT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A003A9A0-0FAD-4F55-83A4-641B103304D5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 3 Nov 2021, at 6:51, Baolin Wang wrote:

> As Zi Yan pointed out, the syscall move_pages() can return a non-migrat=
ed
> number larger than the number of pages the users tried to migrate, when=
 a
> THP page is failed to migrate. This is confusing for users.
>
> Since other migration scenarios do not care about the actual non-migrat=
ed
> number of pages except the memory compaction migration which will fix i=
n
> following patch. Thus we can change the return value to return the numb=
er
> of {normal page, THP, hugetlb} instead to avoid this issue, meanwhile w=
e
> should still keep the migration counters using the number of normal pag=
es.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a11e948..00b8922 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1428,7 +1428,7 @@ static inline int try_split_thp(struct page *page=
, struct page **page2,
>   * @mode:		The migration mode that specifies the constraints for
>   *			page migration, if any.
>   * @reason:		The reason for page migration.
> - * @ret_succeeded:	Set to the number of pages migrated successfully if=

> + * @ret_succeeded:	Set to the number of normal pages migrated successf=
ully if
>   *			the caller passes a non-NULL pointer.
>   *
>   * The function returns after 10 attempts or if no pages are movable a=
ny more
> @@ -1436,7 +1436,7 @@ static inline int try_split_thp(struct page *page=
, struct page **page2,
>   * It is caller's responsibility to call putback_movable_pages() to re=
turn pages
>   * to the LRU or free list only if ret !=3D 0.
>   *
> - * Returns the number of pages that were not migrated, or an error cod=
e.
> + * Returns the number of {normal page, THP} that were not migrated, or=
 an error code.
>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		free_page_t put_new_page, unsigned long private,
> @@ -1445,6 +1445,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  	int retry =3D 1;
>  	int thp_retry =3D 1;
>  	int nr_failed =3D 0;
> +	int nr_failed_pages =3D 0;
>  	int nr_succeeded =3D 0;
>  	int nr_thp_succeeded =3D 0;
>  	int nr_thp_failed =3D 0;
> @@ -1517,7 +1518,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  					}
>
>  					nr_thp_failed++;
> -					nr_failed +=3D nr_subpages;
> +					nr_failed_pages +=3D nr_subpages;
>  					break;
>  				}
>
> @@ -1537,7 +1538,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  					}
>
>  					nr_thp_failed++;
> -					nr_failed +=3D nr_subpages;
> +					nr_failed_pages +=3D nr_subpages;
>  					goto out;
>  				}
>  				nr_failed++;
> @@ -1566,7 +1567,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  				 */
>  				if (is_thp) {
>  					nr_thp_failed++;
> -					nr_failed +=3D nr_subpages;
> +					nr_failed_pages +=3D nr_subpages;
>  					break;
>  				}
>  				nr_failed++;
> @@ -1575,8 +1576,9 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  		}
>  	}
>  	nr_failed +=3D retry + thp_retry;

This line can probably go away, since we do not want to count retried pag=
es.

> +	nr_failed_pages +=3D nr_failed;
>  	nr_thp_failed +=3D thp_retry;
> -	rc =3D nr_failed;
> +	rc =3D nr_failed + nr_thp_failed;
>  out:
>  	/*
>  	 * Put the permanent failure page back to migration list, they
> @@ -1585,11 +1587,11 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  	list_splice(&ret_pages, from);
>
>  	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> -	count_vm_events(PGMIGRATE_FAIL, nr_failed);
> +	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>  	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>  	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>  	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
> +	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeede=
d,
>  			       nr_thp_failed, nr_thp_split, mode, reason);
>
>  	if (!swapwrite)
> -- =

> 1.8.3.1

Thank you for the patch!

In general, this looks good to me. But like you said in other email, when=
 a THP fails to
migrate and gets split, the number of nr_failed will still be inflated by=
 the number of
failed subpage migrations. What I can think of is to split THPs to a sepa=
rate list and
stop increasing nr_failed when the pages from the new list is under migra=
tion. Let me
know how it sounds to you.

An untested but compiled patch (please apply it before this one) looks li=
ke:

diff --git a/mm/migrate.c b/mm/migrate.c
index 1852d787e6ab..f7e424f8e647 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1457,13 +1457,16 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
        int swapwrite =3D current->flags & PF_SWAPWRITE;
        int rc, nr_subpages;
        LIST_HEAD(ret_pages);
+       LIST_HEAD(thp_split_pages);
        bool nosplit =3D (reason =3D=3D MR_NUMA_MISPLACED);
+       bool no_failed_counting =3D false;

        trace_mm_migrate_pages_start(mode, reason);

        if (!swapwrite)
                current->flags |=3D PF_SWAPWRITE;

+thp_subpage_migration:
        for (pass =3D 0; pass < 10 && (retry || thp_retry); pass++) {
                retry =3D 0;
                thp_retry =3D 0;
@@ -1512,7 +1515,7 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
                        case -ENOSYS:
                                /* THP migration is unsupported */
                                if (is_thp) {
-                                       if (!try_split_thp(page, &page2, =
from)) {
+                                       if (!try_split_thp(page, &page2, =
&thp_split_pages)) {
                                                nr_thp_split++;
                                                goto retry;
                                        }
@@ -1523,7 +1526,8 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
                                }

                                /* Hugetlb migration is unsupported */
-                               nr_failed++;
+                               if (!no_failed_counting)
+                                       nr_failed++;
                                break;
                        case -ENOMEM:
                                /*
@@ -1532,7 +1536,7 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
                                 * THP NUMA faulting doesn't split THP to=
 retry.
                                 */
                                if (is_thp && !nosplit) {
-                                       if (!try_split_thp(page, &page2, =
from)) {
+                                       if (!try_split_thp(page, &page2, =
&thp_split_pages)) {
                                                nr_thp_split++;
                                                goto retry;
                                        }
@@ -1541,7 +1545,8 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
                                        nr_failed +=3D nr_subpages;
                                        goto out;
                                }
-                               nr_failed++;
+                               if (!no_failed_counting)
+                                       nr_failed++;
                                goto out;
                        case -EAGAIN:
                                if (is_thp) {
@@ -1570,13 +1575,24 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
                                        nr_failed +=3D nr_subpages;
                                        break;
                                }
-                               nr_failed++;
+                               if (!no_failed_counting)
+                                       nr_failed++;
                                break;
                        }
                }
        }
-       nr_failed +=3D retry + thp_retry;
+       /* get thp_retry before it can be reset in THP subpage migration.=
 */
        nr_thp_failed +=3D thp_retry;
+       /* try to migrate subpages of fail-to-migrate THPs, no nr_failed
+        * counting in this round, since all subpages of a THP is counted=
 as
+        * 1 failure in the first round. */
+       if (!list_empty(&thp_split_pages)) {
+               list_splice(from, &thp_split_pages);
+               no_failed_counting =3D true;
+               goto thp_subpage_migration;
+       }
+
+       nr_failed +=3D retry + thp_retry;
        rc =3D nr_failed;
 out:
        /*
--
Best Regards,
Yan, Zi

--=_MailMate_A003A9A0-0FAD-4F55-83A4-641B103304D5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmGD/UwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKWVQP/j2QQr+LXWdBUfO3JZwgJ+hQEeXOnwIuCaJW
68/TvWEsiPrMbwnl8Yo64NEark2VWpxsDIWwUJPetPmAbSvExlfWwxNrd71dpch6
nJFMdT9Nq/W1e+vRobWrWpb3jKjv3nMEXQNxdNsNLeawE3blf4kteJdq+tPJcWUh
4tuljhLsm+gYqHIfHXmHsZARcSr/mgToD4BEzKksGDLHMKWl3HfXTBsJLh6lh8v/
mXJDI+cjZ1FRcNG3bXVHJrLt5r7wdUme1Nyi6PrLmGe970VaLtE5qO/w3pKgRZSk
sDaaJ2kn+QD3fhLNzm1c4nZZwA94zXmEKNhq3sjj6+kDsj+yQ7KhXUAGTVaDsY3l
SziRX49UjhMuyqnjhpdKmHArszjjOVdn++NJR5C9G8QyacGRqrpKLOhcS/scoEun
m8b9gBbu/1zBq+GBItF6VfYuxVrEjIOws0g/tedHqCQAb9RbOIO32gE3oKbumYgv
8IxsW2+JZV96q8qOWeJz0yH7HtKf8Mz8g+IabcW4B4Z/zlPzBSD+qFuQRO2bwZrl
MWeOPC6Xj8LfjRvUjZn4ZiP4GoNakhClp7/pCXr5J9Elv7OSlOKfnVgB3jpYNocU
CHwrBZXaqDUSVjU/gJ9QXHRxeu+nGjf8A9Gzzlf8MJcWHj0jMlL+tnC91TkXwknl
ZwPiH6Ci
=gumU
-----END PGP SIGNATURE-----

--=_MailMate_A003A9A0-0FAD-4F55-83A4-641B103304D5_=--
