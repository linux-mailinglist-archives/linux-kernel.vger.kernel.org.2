Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7765143FFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhJ2Pq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:46:29 -0400
Received: from mail-bn7nam10on2083.outbound.protection.outlook.com ([40.107.92.83]:64096
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229893AbhJ2Pq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:46:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1Q88ahZN1KLm2XzEho5sE6IjAEnQMJZZQvldwm4KaPqvya6ICi2PhZZmQk2jGNexnhfOd1eqcUg9Iyx6Bg+gaFd4rib+oSrEsGiwXUHnMYDJAaPbmChSM6ejfe3Riy/7lZDfomt/b1Jr26VVReAOgpDIiCMOwPVi8IflXbza7vdejKaIxCWrp/1h1bkDoUykH5tftDavLEN/ijFB45SbwFh6Rx9W3/8bfILjbTHMYSIDzqoet4vh3duV/U9qXEkCvBcoVHPUed1z0Dz6hR7KBlVVcB7cJffycmxtncYJMsW6Yhl1hrB2h1hg608DtWUwZjjFt5m5DjbimzCO9orYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHMj6K2Pr/7HSEh1txJV8iaZMi9FvG3F7DE2qL5bZPk=;
 b=XneuMMQ6ZxWwxt87UqSbiwyqfPV1Ez6sTgKerDSXdaXfNRmajNGDXa6Tki1AwE061plkFLXF4Fp2jbGDZjFueSEipqNZsaauZyOZL9lixEux+W1F+PqBncx67UQB+r8U15p+/OzIU+evOlo2197G+byp9d64z6GHSE5qWdhSqrUnB9H2Bf7TApLv4O+BifhTu2X6L9h2Smk6SZOToPo6ABu66ghiqERD/k1WWOv4S8JOxdob/S95LfaS9eMFRJ6o3zaGps6x+JonXwU5HVEcH8VkAsi9BVeEZHKXqASahdN4O00pPHtnsVsS2W12/uZN9LApe69cnXnTamsH5RJ71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHMj6K2Pr/7HSEh1txJV8iaZMi9FvG3F7DE2qL5bZPk=;
 b=nPZ9oMbWdD/4X0EbYfqEkR0bWaF/30a4kJ/qHqSv4AykQbybHaqx527OfZAhPgCfcH19vlRXorCiNoszl6kYXBvdkRs00BAhnX5+tD5qwVycKTwVz8EGAjH3cm3rHZJQKwOjvh4aCXrnpmDeMJ+NS39dzjZvHL0fVVu8m3DoL/QGx0hUO0MLUnfzj4UEh93FqrM8ll1ClvdudhS2+e1N1AAMdnP7YF9fLRMkx+ri+mXS3cgFJkyrqi0Hh4xY3ruiS3xf37bh1Tu1u8pecwArTh9uOe0Fkqcu9uY3XejYEDnmxbM/i1SLZ2twE5MVHJovjx1rxW7fdO/6ndnoUPJ0Yw==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:43:57 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 15:43:57 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: Correct the hugetlb migration stats
Date:   Fri, 29 Oct 2021 11:43:51 -0400
X-Mailer: MailMate (1.14r5839)
Message-ID: <677EF981-F33E-4002-AA38-DD669C319284@nvidia.com>
In-Reply-To: <b35e54802a9a82d03d24845b463e9d9a68f7fd6b.1635491660.git.baolin.wang@linux.alibaba.com>
References: <b35e54802a9a82d03d24845b463e9d9a68f7fd6b.1635491660.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_9FEF314C-2998-4A8C-A25A-73B1387854BF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:208:e8::18) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.50.144] (216.228.112.21) by MN2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:208:e8::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 15:43:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f05f48-6c8e-4103-ba38-08d99af2eb65
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45023A362B0288A950451298C2879@MN2PR12MB4502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIsElyv4WbLyxLwweaclGqrHnFZUSJGAJ64lQA+pSugD/cw5zOB6RTA/XEqo3yI+pgu7ANvacVIMqBhet1dKii5xRaJCQ6h+r6rYvaE99HTugB4z3i9rFfwTKiV5hZ8GYON56Fn9EmC5BkpEgjk6ucgOXGdkqC9iFfAUdsQfP8Zi4cctooH4HG4nao6BEHlA4WE8VUjLPncu+c1DS9uGJFILmcjGOAtgZUGMUVs0osQNvMDh5w+pR26kQtxhWMk9cZxqa2wFU/+ctcVtM0X8ZO9sOZWpUW4ExMuMsvMOJ9KQk1fyw02KwgoQvTMMny2QPpOB58r47H3yBTbVYbTc4/INyBmMRNMGwfI9Ydv6752nsM6MzNfwanB1aJVf7q6zj4oB/ApqtLlJLXrPQueKLZ8OL2bODKy9PCoZyKvdlJjP/MRmluQLG8aMTU3GcGhnDzp/ZUsokxhFIkg7h2DeMWFg1pSfCQQf/unCI3QIVaFPv9VBoMbYGZeao+wnDC6txf+RHAXHtaJsiLVnjZGGkKitwtd465u0S/uGXpfbGd9Uuk1VwdLTcMX50NztdpboHzmkfKis/tMt2scQtiGqNHVu+/SufoAEB+YqsWHXuALMnFPOFuVg1oCON9mmp4TdnjjZDh2jORzUHDSOn9xzGCT/05R0a6yab4w3ihMGqZcB/BQd9+IekyHq6G6HhUF0dfzs3FtaYhfxnm1V7wECHOzFlnoydxvS0fFPqM4Hueo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(8676002)(21480400003)(6916009)(86362001)(66946007)(38100700002)(66476007)(8936002)(316002)(16576012)(26005)(33656002)(508600001)(5660300002)(36756003)(83380400001)(53546011)(33964004)(186003)(235185007)(4326008)(6486002)(2906002)(2616005)(956004)(6666004)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlVaY2ZBS3dMVCtXVXlhUEJTMEpIdzlJV3NQbm9RNGN6UDN6RHEreXZxV215?=
 =?utf-8?B?SU0zZ0twNjU5MlArak0weks1R1MwOEk0UDRUL1BzcFFPREoxOTZrZlVNNjBs?=
 =?utf-8?B?ZFloSUZTcUdQUmFCV255dmQrTE5ETDdwN3RyZXJ2SzRycE0xK01XTDB5WW5a?=
 =?utf-8?B?bGtBa1QzOHN3Q3R1NXNxenNPSkdRZmlsdnZvcGRaMzlxVytlc0lBTmRhMHA3?=
 =?utf-8?B?YzluLy9udWx6RkNCckZxOXI5a2k1aW11M1JlQWNBZklGUG9Sc0ltOXVzOWcy?=
 =?utf-8?B?cFZRS2dxQ3JuU1dVa3h2dyswaTg1UU0xYi9RQzkzQ2ZLN0Ewakl4bG93S09O?=
 =?utf-8?B?d2haZjdoOW1LM0ZSS1VFSVBkWUc2T2tJMlE2eVJZeVdjZkZjdHVlT09ZNDlp?=
 =?utf-8?B?dmNjU3cvZHNqRFh0WEVIb0FIV1NsTVZuUG1zSkoxeWZ2cHNaM1BzRW4rZ09y?=
 =?utf-8?B?cFhPNEZ0UUh3MDBENDVvUStHWjYwa1ZQQkUyS0hPdk90aWdrNWt0a1ZOdWZP?=
 =?utf-8?B?VFNEb3plbXRLZW04TEJjb3ZRbGdnS0M0c0cwZld4MzJpM0crVUF1UWFBYkQr?=
 =?utf-8?B?THRZOVdMQkRzcHFHM25kVVBxOWxHMWtJVHF0M2dhaUY2VHF4M3RtVFZ5TzFo?=
 =?utf-8?B?T0w2MWc2TVhsOWFzelJmRjlJUy9mTDQ2cnA3c3ROZFQ1V0RhK1dxWEltaXpF?=
 =?utf-8?B?U3pCeEJhT3czMjk0RzBOK2VmTTNTdFdJSGZ5emVGUVlyWnlGcDNhLzVsZjZr?=
 =?utf-8?B?eWx4bVN4S1dZM1J3SVlQWlU3cUVtTTdSVUl4bGdoNUhrZDNoSmY4ZlplYUdn?=
 =?utf-8?B?V0Z2YnZSUjErNE01L2JNcU5LRGRvbjB4d1J2QzJDOVkxVk40d2ppZHJsYzIx?=
 =?utf-8?B?Y0dLSjE3WkJDMzVYZUxtRUZRRWcwbDZHVmhxMVFNSktldnFDd0hyVWozejFV?=
 =?utf-8?B?SzVhbi9HMnVqK3F0YzhoQlJTemVqNFJZMTMrMzl6Und6QmhpYWx2T0hwQi94?=
 =?utf-8?B?QVJqNjdXNlptdCs0c1E1QURzY0lTRW81UUJzREJnN0NNV29KaGNCVGMxOGg4?=
 =?utf-8?B?ZklpTDBaU3VJMlBvMnR3dWpqVENJOUZDc2VXVStQUjV2Z3E1WUlyQzhLdjJW?=
 =?utf-8?B?a1pmb3JCM3ZTU3JWNll0a2VaNFZrMGs5ZEFtZW9FTnVuZmp2c0RVV3Zhei96?=
 =?utf-8?B?SG1MZDJqeEllVjlZRm9DZ3pYNEFjK3RFQ2tTcVY0OFJDWmN4ZnZBNHdLcU5M?=
 =?utf-8?B?VFhIS09mSkRTcWZMT21QYlNiL0VYS281NGYxT3BCMXJibmpZM2VsMWhaZnVu?=
 =?utf-8?B?aTZzWnI4NHFzVGFCQ21iSS85aWo0Vi9KYVp1VERkaTI4RnJCY0R3Nloza2t2?=
 =?utf-8?B?MzRUbXNPclNnc3ZWMXNOL0J5bkFkbmwreXFrQjZDZlVuanppT2FQVDRjRjJs?=
 =?utf-8?B?WW55NElrUUtmdURxb3gzZU40YlhhMWloK3MrU2ozVE8wclNkZkRScTRoQUpJ?=
 =?utf-8?B?L0cxMHh4U1BVU3BDNTVjWlovNjVOelN4SG4ySkRpUG13N1NWeTRyTnNFcURx?=
 =?utf-8?B?Tk9aQ1dsNUhma3hSQmhSOWFEZ3ZtNmNKVTZyT0hUNHJkMzFUNE9yVWVsbmhx?=
 =?utf-8?B?TSsxd21NVXV1cTFiY0x0cnp2K3hvcDZZT3pTUGRDcW1zamk3QWpoaHhJTWwz?=
 =?utf-8?B?cDlqVWY0QUlIQTN6VGlRd29wNEljM3hrVVp3T09vMjBwVG1QeUFtSEJZTEJD?=
 =?utf-8?B?Q01iWVczdFpEcDBRbGdiVXZsRHRMT0FTRDVLVFlCaEpsV2diV05zNDdUTHpz?=
 =?utf-8?B?ckVWK2RzZDRVWVRkQW5EeHZ1UDRadklsaTkvZ2NqV0lZdFZHR1JjYzR4ekFO?=
 =?utf-8?B?WVFIekptWkxZSWhmV3hPcnhlOUpmVkRCVFJBYm1IaGl1T0tGRDUxVlozU2JY?=
 =?utf-8?B?d0ZPeVBaTU5BNEpoVk9HbzJKWFRHL1AzbEQ4TnByWDhlaHRKYWNtSTZJNDla?=
 =?utf-8?B?ZnlWaVI5Ni9yZVhBdUpMM1lnc0xJZllFeXlwWXFUMmR6aHJHYzFaYkZmTzlx?=
 =?utf-8?B?MFQrSjhOejAwZjQ0MDhsTUtKOGtJVEM1cG56TTh2N2pWWEFMMXUveHQyaVhk?=
 =?utf-8?Q?0oow=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f05f48-6c8e-4103-ba38-08d99af2eb65
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:43:57.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E94AjzVz9PTBsFh1inJlzGWeTORejAj0cAgqeQTd93jpfjTNmqhUMZCn+fAWXz/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_9FEF314C-2998-4A8C-A25A-73B1387854BF_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 29 Oct 2021, at 3:42, Baolin Wang wrote:

> Now hugetlb migration is also available for some scenarios, such as
> soft offling or memory compaction. So we should correct the migration

hugetlb migration is available at the time if (PageHuge(page)) branch
is added. I am not sure what is new here.

> stats for hugetlb with using compound_nr() instead of thp_nr_pages()
> to get the number of pages.

nr_failed records the number of pages, not subpages. It is returned to
user space when move_pages() syscall is used. After your change,
if users try to migrate a list of pages including THPs and/or hugetlb
pages and some of THPs and/or hugetlb fail to migrate, move_pages()
will return a number larger than the number of pages the users tried
to migrate. I am not sure this is the change we want. Or at least,
the comment of migrate_pages() and the manpage of move_pages() need
to be changed and linux-api mailing list should be cc=E2=80=99d.

>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a11e948..2b45a29 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1475,7 +1475,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  			 * during migration.
>  			 */
>  			is_thp =3D PageTransHuge(page) && !PageHuge(page);
> -			nr_subpages =3D thp_nr_pages(page);
> +			nr_subpages =3D compound_nr(page);
>  			cond_resched();
>
>  			if (PageHuge(page))
> @@ -1540,7 +1540,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  					nr_failed +=3D nr_subpages;
>  					goto out;
>  				}
> -				nr_failed++;
> +				nr_failed +=3D nr_subpages;
>  				goto out;
>  			case -EAGAIN:
>  				if (is_thp) {
> @@ -1550,14 +1550,14 @@ int migrate_pages(struct list_head *from, new_p=
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
> +				nr_failed +=3D nr_subpages;
>  				/*
>  				 * Permanent failure (-EBUSY, etc.):
>  				 * unlike -EAGAIN case, the failed page is
> @@ -1566,10 +1566,8 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>  				 */
>  				if (is_thp) {
>  					nr_thp_failed++;
> -					nr_failed +=3D nr_subpages;
>  					break;
>  				}
> -				nr_failed++;
>  				break;
>  			}
>  		}
> -- =

> 1.8.3.1

--
Best Regards,
Yan, Zi

--=_MailMate_9FEF314C-2998-4A8C-A25A-73B1387854BF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmF8FrgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKtz8P/0qWIGSJhgqHfBOVgkl5tk9YzT4Jj561W83k
KZStjpUnb4+D/yDDCrC8QhVP2OJSYwb8tYJWELdBa8cZVj+2+PpMGb/XoZGoATKt
1/B1ysnFcs2++NwkZFGloD1qWyhqhx5HMUHl/u3ypCtRoXtbjx6HSxo8cPretcbj
EwQxBSVc0yhSr1Kjne+8WIAPT/txOvOTDNUC+sJ5y+S232MnBV/YfTLd0tHuPCuC
ZbehWYxKjK2Pti1p/c9B/aE5hoRd9WNhCtY3y7kyGsTkMyP29S6kyIDqMe3vviyA
o4/qpGdjsQOZTaiOUQC3rI9hvea3eT33qB+Am+1UwVv49vgiW11h1v4/y1Achnpr
UI38FC1vP+YSxoZrFb2EfMDdVCiSIPigle3HQugz09aEAk2913+xyXPwR7QKYghW
Tuht8Q34fPriYsFHd5hNfXPsRrJAJAHdicWFbcELlxQb1gLD82DsI1E9WXOv79ko
IUgVfkFXwHMGNHyiohCYbQFCUFacmwXDzDUsIlDKyZZzJprMzNRPgO5jcByDO2L+
UvW5R64woT19F9R6aOlYG0ZTRW2g5bZvhoS6URCSdn/93QdssPoUN5N1XsL9e0Z9
PlazqHkiqisdGLoySZSkv2M3FfoT4OiUsYy7q/jOXTKSlDm0eYYPM9tyyAJb7odv
Fjk+Dy6d
=uePf
-----END PGP SIGNATURE-----

--=_MailMate_9FEF314C-2998-4A8C-A25A-73B1387854BF_=--
