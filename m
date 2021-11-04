Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94369445669
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhKDPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:38:35 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:27136
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229770AbhKDPie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdezojqHeEnUHQOWFLrNhVnsROs/Hp2NN4F9ScvP33cSwf3BgTsi4l+0Raz5dNZJCQhI5cZKEDxeBePdMqOJTigr4x+Hqb7RFzLUVQpRdDfulww92C0h5JrnRUKh3wtQ8pGZ3TvL2dqSfE8KZqZlJqPC/qeltDpl0GnPLRPR2g2zWSFBd8gFqtgUdpM1O1xZKXLWQUdKfxIAU/ioiFNFh9DN1XXPstKXO6bYHr4j+J0HTnBV9V8/rCTo9t4U086ZZRZz/04Baks2H32mczsV9ljj9OjxmeiKcrVjY6w+jk1nsmmEDNnVc+IrbfmfvMxLWrdVbevcyTYNiw3xFSIbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJszAQRiidpksEqbtlgVznhVfFHIjuFyAf8rrBO7S/4=;
 b=kOriq44g9nJEVHY75kiD3QrMd6mn2CRyvFC26vwjW2JNCh4DseE/iAoUZTftTyjPRZ7tkQLviWe0tMGUQlZWjQzGUbLh4AHKzOlv4lOQ39usTiEqoT4sxSUKe+M90954u7Df38dBwCJQ1BqNBHNMqm5eJA7whdFNTQko4VChqDTEPg0zVckXc9TisWXbDHg3H7uKgXNL8Ec1Ffdr7B6zL8AtlZhNfCeLXnu3/H9KafJ9n1mxDJhP4vjsBz95CA7Nq8KPO66ak/oz3s5qbWBel+N7I8cGhxjCZHgtnQ5ET1ixHgROk1781EHJb41uiK3wrs0MFYEAjqn8GVY4OVRrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJszAQRiidpksEqbtlgVznhVfFHIjuFyAf8rrBO7S/4=;
 b=f9yuL6IeiU4tv8FliO+H2Bfr6xpYE8ufydacU+cPj7fiKpVUFanwPTCVvseYvM/p8GhE/vREU7lZzFMeuNXsOlNMnl/bdbTRpksDhMjXxWzT/AxG5GhT+CF+BdUrg8U6hCOzbFS/VNLblSdUEjI1T/SRirYnB1fxmX8nU0+9tooLn8OJmck7wvY8Hlmbxau/6Ot4nB5k+ltOidU1AWx2bia8jjaWfSnPHmBFMOnJ6MePX5VGvBHlh331B1UPR4FIWdBEAb/xBIn1UwhD3LeQNxrZ1dyCZRtxIPUpxJGuf/IyuAxQpPSZsQ/6gCiUA5RN+jGuHhwPFlFu4j/6heYggw==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 15:35:55 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e%7]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 15:35:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mm: migrate: Correct the hugetlb migration stats
Date:   Thu, 04 Nov 2021 11:35:50 -0400
X-Mailer: MailMate (1.14r5839)
Message-ID: <A3211A4F-361E-4049-932F-6ED01D5EAD37@nvidia.com>
In-Reply-To: <c07ad378b6c7e67cba8d3eef1af786613386a042.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
 <c07ad378b6c7e67cba8d3eef1af786613386a042.1635936218.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D03CF259-3164-469E-9554-46072E8A0B91_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0252.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::17) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.56.203] (216.228.112.22) by BL1PR13CA0252.namprd13.prod.outlook.com (2603:10b6:208:2ba::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend Transport; Thu, 4 Nov 2021 15:35:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83529b11-1af1-4bb0-2f0e-08d99fa8ca58
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:
X-Microsoft-Antispam-PRVS: <MN2PR12MB442304ABE4A4FBD3C53CBDC2C28D9@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13XnlRj/NB6yx0egwkSvkJDXymxDYgOQsYhwAUTVbSQJyS/AM3CwI620qaixCY9SAYh7ZZZa5LvckyGqYP4KkyOxCL+qhsvh+ZeJPZPYLfvsOI24UCTi/LfXi/M1338hp/+NkKSsNhbI0q5J7Yw0LC//ZeVO/nYUhkOWhTgr3SyEhPZ5cZNFYX68JGKrBQgWDRhv9a9oeGPNWrN3HQtkgOzDINlFPGoaRMYRYO7iZTVP1rZQhb+LYlET42gzXjPMP3sfObIjFrXcq6T5jN/lpq7W/pbrb6D5V4jYbgztnfzH6xai8Uep/Pv/608fyx9P1rcKXOLrKw4D/7GVKZnSFsWDXgWSZkT0+JI8AHQUAPlYK9q9G6Ef7xbRrdS/0lT+Xoy0xe1itPVgTh9qgWATVD7Lqko4hFvrWAqV8fCrcqtd+H/qz9CkdTGRkHGKTeSYlZJl7GORVOSURbqyd/9y/UkJY/GOikllqiSv6Rs3UGwSihrJLeHTEsMPWFMvenB8D0trCdzO9JZTkKpVO1xyZP55SgddOyAdpCSSB7sAZ0kMkaupxfcDqdM1QyfZIjBoMqjNGsmjp0gFaX112TDKqU/xsTrXC4LVjhDgcO4rHK5iFs/JncBBinVK58gH9FYhUQHGa1tdcfyZBCHknlRPk6CA9+qKVC1EolVP5fmKUQadX/+lhX7wleP4R7YjuMrgPTfVZYpUAo51LzxpSpZI6abHY/c2u8WCMegQ7xmeWZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(83380400001)(66476007)(956004)(8936002)(36756003)(4326008)(26005)(6916009)(33656002)(86362001)(6486002)(66946007)(316002)(38100700002)(8676002)(5660300002)(508600001)(21480400003)(2906002)(2616005)(16576012)(53546011)(235185007)(186003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IlovOIvZc3Jd7r2+1e7BodtFjRw0jxIL7+fZm26P99MGXs1UZ83Hx3s0AoEw?=
 =?us-ascii?Q?/LZqt4wV9RYGQsIJOQXwhRNVzyW568x1cQ1WwKnDDRcfgU2k5q3p1ibYlios?=
 =?us-ascii?Q?yDz/5L/PyWZOqM1Nwe5WdCah8jEfF1gozE+w8DIY5VtxOlm7KHMi4scHXF5c?=
 =?us-ascii?Q?WS5e2h1D3bwkyFAKBj8qIc+iA0c4NZaa0DZ3WbO6Mk9T6eKWlqksSM0rPgjI?=
 =?us-ascii?Q?n40PKzeBYZCNc04T5q5b/3N6Bd7MwKzNOXjqi7MYpHSctmxOQtZvazvO0KD7?=
 =?us-ascii?Q?tTNtP9Nu2ZK/YVZOtHsgPIH9P3H/bOA3aVb2OpwOC+Wi0TPCMb6SC3MGR4CS?=
 =?us-ascii?Q?X9+9lCalRPFznBkgiipD6pZjvd2d/aJY3pr1EGXO7p04+SKIilbvks79f4LM?=
 =?us-ascii?Q?Onb2PIDu+HaWAae4/zRRThS1sZ82ezSm+IjloK6kQ/tSQbrxJZfgT05g/UP1?=
 =?us-ascii?Q?ULlMrFAzUwpd42V11LXNmE8/nE9AZIEAv4u6s+AHOL5+SbLMa0Q96lxUZVyb?=
 =?us-ascii?Q?dnP84NLl5b8JPdT4OPtujkmqEBKmTsVjMor+bryjIdgMFGuZHXIypHBXhqsL?=
 =?us-ascii?Q?fDRmRUkjy8aUxDNVvvgzNvtaf7PHAgj5i7+BCvuV2H2grpM/xWPEqIJYId8w?=
 =?us-ascii?Q?oZAs3/YJjxUWrisS+psr6EQl64QCfU5Gk4UOedhIevPXTFbO0VsJiu/C/VuL?=
 =?us-ascii?Q?UjyaDH+BRH7wKFimmiIt1w5wBpB959fN6rHCsBjCspJCEOQtP7zwXOxEIlFq?=
 =?us-ascii?Q?LDfvzPLq8AFcG4z/kqu66dU8how/Ca8mZrmc7O36hy2ba8ilrPRnQh2ourxv?=
 =?us-ascii?Q?+4FbxLCC5fIg0F1z2u/Sh/fHFu82ZwrCM9HVQY1Q42N3vyfSbO7CymUqCHRD?=
 =?us-ascii?Q?Ne7atdSZSeJTYiGiVWjwdCGRqIHhDaAQc/F3MQgpqL2DP3NOHNNLEpHNCf1H?=
 =?us-ascii?Q?YOcRwCaP0fVI6iIYGADxqlhh9u79TY6JCLn1Jy0GwtZZn+ldAUl1PwMFJs5c?=
 =?us-ascii?Q?/uipnyA/sJyJ30odk5tjWOwF5IQpv2voKJM6B8VIxvAooFfTUV1PONjjfEJe?=
 =?us-ascii?Q?8z5ej9HLuvmjwGprKd2J+GKZhqQvbtHqlaSW96osA3vAcvEkS/YuRNyXNZNZ?=
 =?us-ascii?Q?5PftyDm7DVNO359tratenNNLOqus5W3jr9iHscW45X+TY7C5r/OjUb99umj5?=
 =?us-ascii?Q?bZzq4PuXkyd3E84tEF8Wxpuso6Z4V26QGhCSLZdQh3xog98cUKdhUiS0HjF4?=
 =?us-ascii?Q?kcZoXVhFNFqTJOeDVnXMS2V1z+hHbQ2FbzEVuVaWPvUvYn2tRBHx4GkncY4v?=
 =?us-ascii?Q?MyAuuALiskr0hNbvcQsRoituuoxxuhwA7U+eSHJ1QPJUtKGf+gcEJr2T+FOZ?=
 =?us-ascii?Q?6e5MmZ2e5EEjYn9c7fsWkwi6N9DhFtQ8vhIv3fxts8hLHBNAEUcnsz7PKc6W?=
 =?us-ascii?Q?RGjzhn8a49fxWbzZU+DDvI5hVfhg0V8JOby+YZ+Mo+twM0HosvW49T+BDvpf?=
 =?us-ascii?Q?dluktKfaB8b/CYXQzyJws/guCxHTG1kYGi5Bvd5gQdFg1TlPAPPeb6d0IywP?=
 =?us-ascii?Q?QlDftCEQQEb4tbKH4Ts=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83529b11-1af1-4bb0-2f0e-08d99fa8ca58
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 15:35:54.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtEeWHK1+p+LAsUh+oJMLLHIadiBIGGnrXwrq0nalnga1L+qHT4YY4rcJAPTAvOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D03CF259-3164-469E-9554-46072E8A0B91_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 3 Nov 2021, at 6:51, Baolin Wang wrote:

> Correct the migration stats for hugetlb with using compound_nr() instea=
d
> of thp_nr_pages(), meanwhile change 'nr_failed_pages' to record the
> number of normal pages failed to migrate, including THP and hugetlb,
> and 'nr_succeeded' will record the number of normal pages migrated
> successfully.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 00b8922..00e231c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1436,7 +1436,8 @@ static inline int try_split_thp(struct page *page=
, struct page **page2,
>   * It is caller's responsibility to call putback_movable_pages() to re=
turn pages
>   * to the LRU or free list only if ret !=3D 0.
>   *
> - * Returns the number of {normal page, THP} that were not migrated, or=
 an error code.
> + * Returns the number of {normal page, THP, hugetlb} that were not mig=
rated,
> + * or an error code.
>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		free_page_t put_new_page, unsigned long private,
> @@ -1476,7 +1477,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  			 * during migration.
>  			 */
>  			is_thp =3D PageTransHuge(page) && !PageHuge(page);
> -			nr_subpages =3D thp_nr_pages(page);
> +			nr_subpages =3D compound_nr(page);
>  			cond_resched();
>
>  			if (PageHuge(page))
> @@ -1523,6 +1524,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  				}
>
>  				/* Hugetlb migration is unsupported */
> +				nr_failed_pages++;
>  				nr_failed++;
>  				break;
>  			case -ENOMEM:
> @@ -1541,6 +1543,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  					nr_failed_pages +=3D nr_subpages;
>  					goto out;
>  				}
> +				nr_failed_pages +=3D nr_subpages;
>  				nr_failed++;
>  				goto out;
>  			case -EAGAIN:
> @@ -1551,12 +1554,11 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  				retry++;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> +				nr_succeeded +=3D nr_subpages;
>  				if (is_thp) {
>  					nr_thp_succeeded++;
> -					nr_succeeded +=3D nr_subpages;
>  					break;
>  				}
> -				nr_succeeded++;
>  				break;
>  			default:
>  				/*
> @@ -1565,9 +1567,9 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  				 * removed from migration page list and not
>  				 * retried in the next outer loop.
>  				 */
> +				nr_failed_pages +=3D nr_subpages;
>  				if (is_thp) {
>  					nr_thp_failed++;
> -					nr_failed_pages +=3D nr_subpages;
>  					break;
>  				}
>  				nr_failed++;
> @@ -1576,7 +1578,6 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  		}
>  	}
>  	nr_failed +=3D retry + thp_retry;
> -	nr_failed_pages +=3D nr_failed;
>  	nr_thp_failed +=3D thp_retry;
>  	rc =3D nr_failed + nr_thp_failed;
>  out:
> -- =

> 1.8.3.1

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_D03CF259-3164-469E-9554-46072E8A0B91_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmGD/dYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKFXAQAKiu0IO8cLB6sNrzf6qEeYrBfkUK+ce6G/iP
FU7YCIPNg/EF2M0K3o7vW+hwjSXEax3DW83UzPiF99TUkuXUdSO4hEINQtV8dron
oMDc26ObSAFthM3HO8y9yEpjFziDzy9Chk+A99Tv4d5+OMrytvDdoqSEO7N00VmA
DMjGBiZfRvbgMeT/KFXV4M+TZNq7qFZ8JQCjvhJPPhFH5SoE/d8wVsfV+9/z3FYb
nZLqxE9UZ1iUUb54YhghofVqUO4BScHyI0fybW2oPpBZQY4W163FbEHYsI5C3Za0
tx+TYcUmB1oinlt6j753EgYZO4QGIXF2uaNGSMOlFOem6YO4kt0Izq+omoHbwgVm
0rH/82oW0FpssShNDFyyHGL6qgubvb0ERyaEkAxvEvg7hy4VFHKhCBPdhDJrADed
fY+ZrOWd46CvP+YMsHFdG8VbGcWyw0vAgNf6liWXOPHZhlRxSTGi+nJYix+S6X4N
51EIiSP6YupHboOdCjIYScsbNU0AYZoOxMmt/lAHV0iCllo9HihysCnPubJzIkCS
1u4lrHNUfTaXmhWY66qQY14JPJPpZqTeV5qYzqWXZ6YTkC++9ApbOk/ybDC3+eSO
e+CVpg9NFNpwCsTdZchBz5OuocG9Vnun6bUxyC0J58BaknlPWA9JD/vR8tUNZVMq
Um8Wtdoh
=Bq28
-----END PGP SIGNATURE-----

--=_MailMate_D03CF259-3164-469E-9554-46072E8A0B91_=--
