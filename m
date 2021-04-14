Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF635F7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352248AbhDNP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:28:04 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:23521
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232271AbhDNP1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:27:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP0fI9xuZsY4sVE2tR9VSV32fiopRB/UQXtArCWf6QsSIguE1Cr8GL6fcsv7ItEtYAXr+d41J44pEKTPPhqxhAEONU5I5ReD7Mcz9Ay38WLDBB1PEUMYl9wtmCTYOc2XAfE5LLIVAUUcd2gFkAdwsN3gvIZmvnBKCCjSYpfctaPNbKRw5IKdqTtg2cXk0MDkoFQ62JzWXQmTp9NrjkqERwDxC4WSor//HyuFuO9N/iIeMCmKxa4KYIp7sRPqzs9PeRuu/Q7mr2Pk2a1o4cn2uDGD7meByWNgdHn5ZeHEk5BaeBX/LP4AuV3CJ5RpglewloEk8HWh7PsSWa5WJOV9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlWqjR44ThlB2qEdRYiNPCAJlcClfI7o1RSxamqSZP0=;
 b=T5SskMKbtSN3yPtnPwFQr/Ghx1IAGz2g4/tVkqcL31sazL3fdea+N1ka+ttgkO7b+JRCLzm0tziOFtYwIbAwSTQbZJUDDeiWKS5mMFS/8CxiyzwSvNJsyh7nn6X3fKgNGJ2sM1J/X3enEbRpiQHXMcvjSlvVNC17wahIuvl0BgUlqtRJ0NLcvDWhJn8y/DLt+ozq7oDs40q4Bl+XnYwdChoXUhA3jQGBe3CfZ3WvasU9KerhTHtuJIi4211s37e3sjGCRH20e32iT2a/rn/qpYSn4MbQgYx/2dNMBW9De5eLok0WuYk27f1vsPkvae85vVz+6hx/EjzxpBOhtJ2L4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlWqjR44ThlB2qEdRYiNPCAJlcClfI7o1RSxamqSZP0=;
 b=Fbe2TPWTTTu82aceE7Eq7SmsN68uc5NxKSpeqEukMk4GS4TY3lnjEU8lWM7gtWMCGrUnAsV9ZqLfY4q2Lo3Wxywg8CNYGXfYBMt3M7NN1PWGvGJhAo2pMCNmMXP+u5wTya3h0obkCjBtqxkEQXm3kPutAsEu34F8No/PXQ+7jv6n1EoQLgFmkNjz7+lWIUkIfKTsQyMFsNP+cyIY5y82IepxiE3cPKM5ESZ+k9yGHRzDJMWSRFWVPpbRJm7ei0ugfCWkjECvdzoePjWd3SXxzfC9N0dXLv2K4xP6n678pzlgbOenHeZ4W1AqhFK6UIWcBpg7exs5nbXfags1staqrw==
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 14 Apr
 2021 15:27:31 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 15:27:31 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Tejun Heo" <tj@kernel.org>,
        "FUJITA Tomonori" <fujita.tomonori@lab.ntt.co.jp>,
        "Douglas Gilbert" <dougg@torque.net>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH] mm: Optimise nth_page for contiguous memmap
Date:   Wed, 14 Apr 2021 11:27:25 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <CF4348D5-9BDD-4A93-891F-D81FD15ED174@nvidia.com>
In-Reply-To: <20210413194625.1472345-1-willy@infradead.org>
References: <20210413194625.1472345-1-willy@infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_F46BFDF0-3B3F-4428-9464-C28A0A8875A4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:208:23d::10) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.61.222] (216.228.112.21) by MN2PR06CA0005.namprd06.prod.outlook.com (2603:10b6:208:23d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 15:27:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb91c466-ebbb-4d1d-7343-08d8ff59d1c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4471DA7670C8645321607CE9C24E9@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oM+SKOtNuGi0+8i/cq8cS0Pu7m7HS8N3xavE92eo5Q6hjCnj3bLtZHefPJwqeIQ2+pvrP4XHseyLfal1lMh4pI9By23Dj9/LcdITU7wO4pZW+8HXvfD7I0tjTK4o9HIXBAk2PlDBHpIJ7NyZuzQOUwkHtTB6I18vVSscTtd2Sflttb9xFipy/ARqK7unCTVGvq2gBwl/h8uDC0CSEDHey4A8Npn1YoZhqM0s1/XkGIzf4inf2HsjTLQpgaB1hqVFXzbNrj9EhlULQJKsHqsE0PnhZdnKWWs8PvdDNHdXKQ/ZJ4L2m4ubkwmN8GEp+ZRiM8TEPNxf/dADNuky1EBcZJGIZBLGQtf++jRUlwN0UGbbkerau35Nt45shrFFUbSbHHfIkkBjDFyrFD5mF72JHVZrwXPY+eF8fu2CMa4gaCkqAPAJkV8iY+ahwyE9DeQaRnhKgrRY5LYRH6DF1E9tFMM1SEi6EcTVu3tSBllD3E7HE0xhJfAbrXlJLjnMjFC78WqpQ5tqC9pOpWvyc9qzKKlAMaEhWRDfQrqroy7n9n4w25Kz+/po14zx/9KcYfAhVIsuzfIt4O8a/nLrh79oZcaZZpAMMuVUU6m98QmXBQTm1m+wfX2a4R3+0bcEztoiGtbJUMyPZqoBab2CUaFTjqrUcVJwiiiy9E6B+NjLHok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(36756003)(83380400001)(186003)(33964004)(33656002)(6486002)(66946007)(5660300002)(316002)(54906003)(66476007)(235185007)(66556008)(6916009)(956004)(6666004)(86362001)(8676002)(16526019)(2906002)(4326008)(8936002)(26005)(16576012)(2616005)(53546011)(38100700002)(478600001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ckxmWkNUMTh6SjZIOEkrWjFaTks4dHhySGsza2gwUzlWK2F0MGJHSUpXRzZO?=
 =?utf-8?B?dkRiSkxyK0lxbG9tcWlYZmMzUFF3Y2pteUNWdTFwTFl0dThJNm1WbHVuL1hp?=
 =?utf-8?B?MThVcGphaGREL2VjTGtNRmNCRHZUMVFWV0pNVG9FbVpObkpmajgzUGU4d3l6?=
 =?utf-8?B?MkZKUyt0Sk44L2lLbVN3QkxpSEJDMHJ6YmgwVXRveGxybVdFQVlmbUdCSnFs?=
 =?utf-8?B?eXlEcmNkUXhNRE5uSE42dlFWQXF0ZkU0MURSc2M1Z050VnlIOHhjdXp2bVpY?=
 =?utf-8?B?QnlWQ2VEOE05Zk8vcUk3QUpnS0NXVUhWMzl6a2ZIdm40eEJGTjdtQ1ZEM01M?=
 =?utf-8?B?dVI0MXFZR2hzd09FdDJOTFlTUEYzUUJuV2lLZmJCNW5ZREkxWDJNTkdraElq?=
 =?utf-8?B?eXFsaSs5Njg3SURBRFphN1pqSlZLdU5rNDdjWTFVUWF5NUlhKzBxZWl6a003?=
 =?utf-8?B?WUIyZHhHUDBkK3JFY3dmdmtlTC9vRUZhRjZCRVQyUUVPd2poL3FZbVNXeE9j?=
 =?utf-8?B?UnNVWmgyM285YUFLWUozeWlVZkxkckxHaW5rNUJmd1VIaVFlWncxaW92VFE2?=
 =?utf-8?B?cnBXeFZxS05jM3ZDRDI3Si9NMmxjKzNzVUloRnVyc2wrd1BhNjRGdGI4eWhx?=
 =?utf-8?B?WHB1Qi9IcWlqUlBMa25rQTRXdnROenQ3YXJUNFVhekRWc1lKbTR6T0JpbXpt?=
 =?utf-8?B?SnI3eFhPUmQvdmZBbVlUVTR1NzZyY0NWZWlxbnZVMUhYTDNMaDJ5YUVWaE1u?=
 =?utf-8?B?RVJOUlZGeFBXYk5XN1NhcTBSQlVidnoveU9VN1Bla05rR1dVSnRlSjR2Tmli?=
 =?utf-8?B?NUpxVHVSb1hpTjkxSDV6YXVpWVNla3hlTzZvVE1NNXk4eW5oS2dzQWF3V3Ra?=
 =?utf-8?B?WEVjbUZ0V2plWmlZK3F4cnM5K2RNVEt0MFNCK2JDVWg0Y2s4RUxSVEpBRlBi?=
 =?utf-8?B?dXFUenZ6Njdncjl6cjRvZ0tEV003Vnd5c2I3T1lERlhaV3V6ckpTS05rSkF3?=
 =?utf-8?B?WjNQR2ZDdlJHTDJjRXhGZWtqUVI5MEFNaUlPVTc4SFVBekVVcVJlQTVMTHFT?=
 =?utf-8?B?dnZKNndaMG9YQmFEc0pVY3Q0dzVBUU16RVFTa2FaNFRMTmZDUnpQbTF1K2pi?=
 =?utf-8?B?WGNjaTd0NUs5LzljdFdWNFdnY0lRdGp5QXJyQTdsYnhkcElJM0lyKy9BSG5K?=
 =?utf-8?B?SkZVc1FBTFFlTFJINHBVL29pK3pDeHIvdWdXT21vUlBsMDV6K1VzOGpTcXNp?=
 =?utf-8?B?NUFXRHUzUHhYeGJXUWIyK3dyckZMclFTQjJJaW00d3pOemo5NGlPVkJqRDYy?=
 =?utf-8?B?Si9ZdmdpU0lFS1F4UEYrdG4rN0UwMm1VTkxpWVBkZklSc2dXelNGZFNWRDc0?=
 =?utf-8?B?L1FvUnJmbzEybThGaXA0MkM4ZXIxTzU0dVZadGw1ME1EbzRhNTJrWTZUZUMw?=
 =?utf-8?B?b09rZHBVazRuUW4wZVd5UE1SYnRPeElMYWtuOUhoWkdwN2M0dUdLYzFkYXNB?=
 =?utf-8?B?aDk0UDJGZDBYOXFKL0ttckZDaWNndkpKYmlJcXJHQTV2UUtmVkcvanJBYnZI?=
 =?utf-8?B?M1ZObDRtSU00VExBSlVXNEczUzZYbmdmQU1oMFpPL3FORWJrbHhTa1dkTzRG?=
 =?utf-8?B?QnNwUndEZDIzYzZHUGNYbG9GelRFTEU0Z0QyQUJVODBwRkVZR0djbExlM2hQ?=
 =?utf-8?B?eUQ4dDdhNk1OWkpoVS9HbS94ZngvK2h4RE80M1lBMEtwNCtuWnBXODNJQkRG?=
 =?utf-8?Q?s/DkyuE/X8pFbqYSCDaM461nOZwUPZOcdmU2yek?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb91c466-ebbb-4d1d-7343-08d8ff59d1c6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 15:27:31.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrqYGsEyruAt2UyUZrCqKczJjqlh+/GR8LQZq+tDeBPyOuItrj0iY9JfhXviW7Nb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F46BFDF0-3B3F-4428-9464-C28A0A8875A4_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 13 Apr 2021, at 15:46, Matthew Wilcox (Oracle) wrote:

> If the memmap is virtually contiguous (either because we're using
> a virtually mapped memmap or because we don't support a discontig
> memmap at all), then we can implement nth_page() by simple addition.
> Contrary to popular belief, the compiler is not able to optimise this
> itself for a vmemmap configuration.  This reduces one example user (sg.=
c)
> by four instructions:
>
>         struct page *page =3D nth_page(rsv_schp->pages[k], offset >> PA=
GE_SHIFT);
>
> before:
>    49 8b 45 70             mov    0x70(%r13),%rax
>    48 63 c9                movslq %ecx,%rcx
>    48 c1 eb 0c             shr    $0xc,%rbx
>    48 8b 04 c8             mov    (%rax,%rcx,8),%rax
>    48 2b 05 00 00 00 00    sub    0x0(%rip),%rax
>            R_X86_64_PC32      vmemmap_base-0x4
>    48 c1 f8 06             sar    $0x6,%rax
>    48 01 d8                add    %rbx,%rax
>    48 c1 e0 06             shl    $0x6,%rax
>    48 03 05 00 00 00 00    add    0x0(%rip),%rax
>            R_X86_64_PC32      vmemmap_base-0x4
>
> after:
>    49 8b 45 70             mov    0x70(%r13),%rax
>    48 63 c9                movslq %ecx,%rcx
>    48 c1 eb 0c             shr    $0xc,%rbx
>    48 c1 e3 06             shl    $0x6,%rbx
>    48 03 1c c8             add    (%rax,%rcx,8),%rbx
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 25b9041f9925..2327f99b121f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -234,7 +234,11 @@ int overcommit_policy_handler(struct ctl_table *, =
int, void *, size_t *,
>  int __add_to_page_cache_locked(struct page *page, struct address_space=
 *mapping,
>  		pgoff_t index, gfp_t gfp, void **shadowp);
>
> +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>  #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> +#else
> +#define nth_page(page,n) ((page) + (n))
> +#endif
>
>  /* to align the pointer to the (next) page boundary */
>  #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
> -- =

> 2.30.2

LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_F46BFDF0-3B3F-4428-9464-C28A0A8875A4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmB3Cd0PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKgvAQAIJMmwgUAI+4e+fyqWT+YDixLvuT+43QaRXB
QxwKdNiwSNnjLITwy8Z86TekM0afrvU8iuh0fhG82tgGKP3/q4hWkeIbbJyI1uJ9
ql3Rls/p3YybIi1YyB9N58tB8tSD2AOYwznSNBKe0J7q45YFtmHm3UkEB4kMVoUb
Bp20loMNy8hixAXfXqV6KMMVD/OJGf8dKWhylKqk7nQEYPbOcG2bKSEqLcWXzb3R
WWVUjeFdzztxcwIxaQ9vFPARJWOYM8B0zbqfutVWPiIvGJcVLIjNpFSF1hCLT1qu
qlNuAaVU4urejp1lW0lBXqrINlJtjaEfAhDb9L3jIu+BHNOYJYSc1P4P33Dg/8za
TR+tgoFRoSeEJypY8FLelgWJcirvFQ1KtbK0aBl/6S2AIvtmBxEUYJcJVWwuFPbL
ZayvXJsSsPLY5J0SJ1qekFxBSJM/baaV2VPgbJv0wFJCPcipVn+kkRsDHhQs0242
npgLwIMUtnv+tuaxm/K7prXxjr2BuI9r4UkPC5l6zOjlfUYIdeORvAu299R2YrKD
51oysZFcOUKnx3tUlDyDmdFzP+gR7OXjrjPflJPB8c8s5qcZ+4iwTgzFaeUH8F1Z
Oy/PFUf/qBGiYYXJ7ws/vmYuQhJ2MDauMSkYHtumOv+OgpaNdDeV5M8E2r8zvh1t
4vlbYg9l
=1GAM
-----END PGP SIGNATURE-----

--=_MailMate_F46BFDF0-3B3F-4428-9464-C28A0A8875A4_=--
