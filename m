Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C931337B148
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhEKWFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:05:35 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:12832
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhEKWFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3OuzM0R5wMbk0UgNYjE+JmLnOdUInsPaNyqljNPxGeUqBMenD7nrKph8//zr8sctg46ahLrrI2TL+wMKLvms+HXRQw46Sc0tjgMMlfQu4YYiXAkUjmqFwFQd3XUTw978LlzJFNhaGYQYPRUyDEk1y+0l+bcLmM/4hqsPud/3cOiTX98njRKSrmBp2V3JQiN5tg7hurZhSUCqmI+47UlPYTjIJteA8WXOY61vbIA4Yl98bbxFr+2u/ZpO3OGAGZSbLsE2PcO/zdPRWFW0Vb85tsROCHDWtdjs7S2uPg1VFBlsx2gXjxOIhgF6NKmNVCF9KXUzkf8hfZQyikDrzvMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cHcY90TnidqcmIeLmMc/iV9ZXRP/lnwDms4bow/Qro=;
 b=G207rHmjFcI4wxGfbfd7Dq78polzs5JNsaXC0G4uSfksTiNinCux2g9VZFLwSnbIRfdsywSajBsuRk2lI2jVMQYfBbdd1EuFAK2BpwiAvS1WatSGj1Qry06p3tyL+vW7NFXaWara/6PfEAV3bxxnYXEBcwnGRDBxdzBXwv+SHBnXNMK7UG3mcznsekSn+LzuzJhK7+C4FIP2ottCq4pZJ07qA1VZUReuhmPym3ecr0Zk5RHMiWTNmn45oLUn2zWkRLlZoGPOrJ3m6EBcIxN8fmbog1qMOCppaXFrPf7+YB6ZfJdcGu22WCz+oGfOTJNIwUcN+o2KwuT15zESIDGC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cHcY90TnidqcmIeLmMc/iV9ZXRP/lnwDms4bow/Qro=;
 b=Kjw+84tnRfvQ/zImWmNH+2VR0claItNrNIfgQKFBr6qL0bjzDxx99QzzbDte7/YmVis69z1d1ptvrUamMDOwPeCirgpRro0k+l2/VOiFDSgXgLWutaRFV8sZBQ0i616dWpb53u5uxpQZq3MbEDx0Cg91ZMZo+LsxztuDebECj6SFPkGArCbOaSxXQZciLUI+hX6M9zSrKs0GMNDTZ6BavlwOSDedFy7dhqtH8t7n0daJw4qXl1CxJNqXrQbmMu6FcdfTYAhMFpcf00arnXdGISBkMCY8Uhe7OffkT2B1mb+fmKMKLNfWJ0AiQS3wreN7tkW9FIW0v3hyYfp96a65gg==
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 22:04:26 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 22:04:26 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] mm/migrate: Add folio_migrate_mapping
Date:   Tue, 11 May 2021 18:04:21 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <DD640D43-3101-4291-9882-57A89C74866E@nvidia.com>
In-Reply-To: <20210510232308.1592750-2-willy@infradead.org>
References: <20210510232308.1592750-1-willy@infradead.org>
 <20210510232308.1592750-2-willy@infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_9358DF66-535A-41C7-90F7-455658FD512F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:208:23c::30) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.93.183] (216.228.112.22) by MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Tue, 11 May 2021 22:04:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0350f1d0-d145-4464-8273-08d914c8bd9c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4190:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4190CDA1B2B8F58BDAD09609C2539@MN2PR12MB4190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7CDHLEmU72PqrYyaXho2Uc3gcHQEyc0XIwaJl/kqeyqj9PWMfZIvvtk0kujTLONiyg+GuOM5KlSzHpxkjSto5thdpUUhMpH2NHwRKCMpMQXCUNydrjvdrbLudATjRekW0dlI+Pnbp58uP/wvAY5jSj6C7fltkq974eoSup213M/lYw3UxCJKd9Zvf8KlFZfzT7EyL2OTx3haBCbYJdIT3729qYBSjKmLV9W2KmSafSKZhIn0IiaaWrOMG/DD9jCLi0IVstHah/AnVDtIOjHZaByRKRD++PT3RxDC9gUi/SLg3AOMpel6OU3RYHwFNxXe+jHC0HiI11M1kXPSWVm71noIznYh5q9TgpxcmPbTJn8E7fWysnobWNo1jfSPLZqXHx/KkydB9btUL8wJA+/3rA+E8WcbNBPfC1VI8Y+WI6P15QLFduOLL2LgIe9nr2IxqdJDzNZ/NtVKxMLd4mOczsdOPwjrNENi8CmE60/Hx75c+7aJ3uO/Lpc2DoHtI8081r5p4vGiDhGJpU3GaIlPMiyekfZuuDFkokQiMvlnPMaAwekUv1c+ZZ/64WYM4iOGV100MPio8Lq9TkUhEoJa7in1cDka9yPC1Xtk4jpzCyeCHF/4Pdmmj6oxaE6PJbwZilyK678vV8uZhecIYxZLG9AB2qviTOEP0iwxiBoVXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(6486002)(8676002)(186003)(6916009)(316002)(16576012)(16526019)(478600001)(2616005)(956004)(19627235002)(4326008)(2906002)(53546011)(8936002)(26005)(33964004)(5660300002)(38100700002)(36756003)(86362001)(33656002)(6666004)(66556008)(66946007)(66476007)(83380400001)(235185007)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnFJbWFZTk1oL0NJTzFJYU45R3VZeHEvSmlmQ1l2MkREOHdPanN4djVjak5D?=
 =?utf-8?B?ZWNiUHFxY3VsZjZzeTdFcTNlMGNFZy9zcTQzd3BGcGdnTi9FaDhJMjBuYTQ3?=
 =?utf-8?B?c2VmbjJKMzBnV3JxRDViMFpOSmcyd2h3RnFzeVdHMTdhZWtEWVF1dDRmYWcw?=
 =?utf-8?B?cWljdDk5ZDZHcXV0L0VUcTVXWEQ5OEEvY3lSRWY3VzZ3N1VpdGlvbiszVkVJ?=
 =?utf-8?B?R1lJOVFMVnNqL3VUREVveFU0cnpWQlh4TlB1a1AyRzdUZ3NsYWNOeVExOXdD?=
 =?utf-8?B?QzkxWGduMnFsZWJQMUYvaDg4MHMxN05vWHU1dlpKTko2cERBVmluQXVwVWpv?=
 =?utf-8?B?Wk5KeHhUT0ZjTVpZMnFRTEVKZG5ORG91TlNuWURkdjJZNER2RmVoTS91anNj?=
 =?utf-8?B?MHNoV3JIcjFmeFZ4ZGYwWW5iS0FkRmxaNjVPd3VtZWkvdWJ0NG9lM0JRZjBU?=
 =?utf-8?B?NFQyOU5wUWZvSVdrbmwyUDg5aXFUVDBVRHdlREVRVE82Uk1QVkJSNWpYVXV1?=
 =?utf-8?B?OExlSStzOVZOU0lYUVB1Mk5UVSs1elhQdkNmWFE3R1VXN055TEw5RkZSU0JB?=
 =?utf-8?B?aEhoTVI0RjkvbEU0UGJWamtmQUduTlVJQWZBMEk2YmNZSnRweWF0ZnoyenJM?=
 =?utf-8?B?b3pMVlNZVitTNlN4U213aE4xeW1ta3pkODlTZ3BPbUY2MFJvRFI2Sy93WUFU?=
 =?utf-8?B?aENhbzFxa1JXbDE4YmQ4OGh2ZGllNnR6QVNkN09MREx5dDdsaTJTd3ViemI0?=
 =?utf-8?B?Umh4bnpUcXZEK2EwcE9NS0YwRGdNVXU2azBDbnJpMmIwRm8xSnFCV09QbElw?=
 =?utf-8?B?SEhwWXhkYzN1eEhRcVpuR0gxRGNrRFU1eDJyTTAwWnIxZDdOOStHU3dDTG5N?=
 =?utf-8?B?TUFzN0d2SFBDMVRWVGxON2VYckF3eVk0T3Z5Y1hqWXZUZnhjWUVMVXlTN3FQ?=
 =?utf-8?B?d3Rsc2IxV3paUHE0a3FQbHZOZzJlUWZHRzBYTk9Ib0NpbkorejFZQkl4NjBZ?=
 =?utf-8?B?Q2RJZkZPVXFzYjlnODVnWk04NmpGbjBoVHYzNEV5TXkwTkJ0OHdWalFkUE53?=
 =?utf-8?B?UUI4bCtkK3JCTFNFTCtwbitITzNYcXJpdEt4aVltR1lQSWFUVjJTWTh3aWo3?=
 =?utf-8?B?YWhBdXBqNXNiMStTV1M2cmp3Nzl1dE94VGdEckpoL1FYRk9FMHp3MThkTWdi?=
 =?utf-8?B?eGY2bEVYS1FmN0grdlNYZmxoZzh3alVmQmkxMWFWZm4wSTB2WXpDU3RabmNC?=
 =?utf-8?B?QlFrTy9sMUlBRDJXbWUxR1BSZ0dqRHhTMWhWUk0wa1h4aHdFdmRFdloxQ0JE?=
 =?utf-8?B?QmlHc09vTVFtbEEyMmo2akpVcjJjMVhtVlptdkdTUG1xZFNrNnl5bGdHZ016?=
 =?utf-8?B?RnNwUys5K2RjbnJqNmNycDQ2bkVOaDhCSVd5bldMdUVhY3dhQ3ZNSVJBRC9a?=
 =?utf-8?B?M01LYUlzbWNiQWwrSW9HSWU5Z1dzL09DODg2WHFleEFzaUlQM3NqbitYT3Jn?=
 =?utf-8?B?a3dhSHpsR3dac2JkenZGKzdLWXVwcno3QlVPc1dxTjV4SmMrajlSUU9sUS9v?=
 =?utf-8?B?QWxEL1V4SUkxTDBObFN5RUZKaVlxaFJFZUxkYXRscTg4UXcyWUxhamR0YVdZ?=
 =?utf-8?B?OS93QVU4RU4rdTlmOVl3UnpyK3NEOGY4Y09OUzZWcnlWTlFYYUJnSk1iRk1W?=
 =?utf-8?B?R1BmZ0xqZ1RqL3psRFZlTlhMU09nbUlpakJLakN6bXFEejdESkYzWUV3UmM2?=
 =?utf-8?Q?hUjUky9fmitjupYpC3/okQ2K0IjIflTR7LBLF3r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0350f1d0-d145-4464-8273-08d914c8bd9c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 22:04:25.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q7Q1b593zPxIPmrsm4yFGMM47rn1A8P3yN400Sh1bqAq1+pJXtDOuwTnwA4jLOO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_9358DF66-535A-41C7-90F7-455658FD512F_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 May 2021, at 19:23, Matthew Wilcox (Oracle) wrote:

> Reimplement migrate_page_move_mapping() as a wrapper around
> folio_migrate_mapping().  Saves 193 bytes of kernel text.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/migrate.h |  2 +
>  mm/folio-compat.c       | 11 ++++++
>  mm/migrate.c            | 85 +++++++++++++++++++++--------------------=

>  3 files changed, 57 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 4bb4e519e3f5..a4ff65e9c1e3 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -51,6 +51,8 @@ extern int migrate_huge_page_move_mapping(struct addr=
ess_space *mapping,
>  				  struct page *newpage, struct page *page);
>  extern int migrate_page_move_mapping(struct address_space *mapping,
>  		struct page *newpage, struct page *page, int extra_count);
> +int folio_migrate_mapping(struct address_space *mapping,
> +		struct folio *newfolio, struct folio *folio, int extra_count);
>  #else
>
>  static inline void putback_movable_pages(struct list_head *l) {}
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index d229b979b00d..25c2269655f4 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -4,6 +4,7 @@
>   * eventually.
>   */
>
> +#include <linux/migrate.h>
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
>
> @@ -60,3 +61,13 @@ void mem_cgroup_uncharge(struct page *page)
>  	folio_uncharge_cgroup(page_folio(page));
>  }
>  #endif
> +
> +#ifdef CONFIG_MIGRATION
> +int migrate_page_move_mapping(struct address_space *mapping,
> +		struct page *newpage, struct page *page, int extra_count)
> +{
> +	return folio_migrate_mapping(mapping, page_folio(newpage),
> +					page_folio(page), extra_count);
> +}
> +EXPORT_SYMBOL(migrate_page_move_mapping);
> +#endif
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fff63e139767..b668970acd11 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -355,7 +355,7 @@ static int expected_page_refs(struct address_space =
*mapping, struct page *page)
>  	 */
>  	expected_count +=3D is_device_private_page(page);
>  	if (mapping)
> -		expected_count +=3D thp_nr_pages(page) + page_has_private(page);
> +		expected_count +=3D compound_nr(page) + page_has_private(page);

Why this change? Is it because you are passing folio->page to expected_pa=
ge_refs() below
and the nr_pages for the folio should be checked with folio_nr_pages() wh=
ich just returns
compound_nr()?

The change seems to imply that folio can be compound page and migrated ev=
en when THP is
disabled. Is it the case or something else?

>
>  	return expected_count;
>  }
> @@ -368,74 +368,75 @@ static int expected_page_refs(struct address_spac=
e *mapping, struct page *page)
>   * 2 for pages with a mapping
>   * 3 for pages with a mapping and PagePrivate/PagePrivate2 set.
>   */
> -int migrate_page_move_mapping(struct address_space *mapping,
> -		struct page *newpage, struct page *page, int extra_count)
> +int folio_migrate_mapping(struct address_space *mapping,
> +		struct folio *newfolio, struct folio *folio, int extra_count)
>  {
> -	XA_STATE(xas, &mapping->i_pages, page_index(page));
> +	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
>  	struct zone *oldzone, *newzone;
>  	int dirty;
> -	int expected_count =3D expected_page_refs(mapping, page) + extra_coun=
t;
> -	int nr =3D thp_nr_pages(page);
> +	int expected_count =3D expected_page_refs(mapping, &folio->page) + ex=
tra_count;
> +	int nr =3D folio_nr_pages(folio);

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_9358DF66-535A-41C7-90F7-455658FD512F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmCa/2UPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKAXgP/iJYY/821rLNU8JKSo4SmaErtnfqj6xabHFJ
zC/WFahkqk8nI39zI50rqlfjBc3YJq2b/PF2LpVCeFNZP5lIJ4pAzDBZEasJFdAW
DEctKKlk0GHK1OXg/ai+q1DEoInTiAcpjK+RneULIU5L6sJjnY8Kq7slr4B9SN5J
pYbvHeSD8mFSGb9H2NaaXqA9fy5M98SxTQ1n0wQm8SVePJV+4yF28ioXY9pD0twz
VB5KWaYdLiBVi4ktBu5kMJhvtQYtLrtnatnVT1FgVEGUgoxax0fj1mq7k4r4LopL
PI0C/GScG98aS8ClDsWvWCw47wETa7MdtZn3clpXn9TZJtLHQA15AXa3b4wW0fCJ
Tj31kh+CgDoQMYPIh6cLAysS+5xAKm3DZAaCID2vBE9A9S+kZrcSz9tWMw2/r6Wg
YFsSHr+nppZA9/ma2pHJifKsQz1S+MWHpcBBCbwUZGASjIep5gWeiaNxPqQ7LmLa
hzrh+DyAIzbV3xl05uk8uMJGSG584oDRF/TIx0vlCG8C1F7bCTMGOE1tCdogHJ6K
OwhZv9zkKy3g4+egNqDlzXavcoNuX053V8fhSVEzftJJOShl8C8QYt9iucOGtklQ
v+tTX2FKwd8qj6yC88ymHdGGdSGrKc8G1EEe3vtwFlmbLWjXDzpBdhdutMZQm45+
Ov/6tZjL
=El7m
-----END PGP SIGNATURE-----

--=_MailMate_9358DF66-535A-41C7-90F7-455658FD512F_=--
