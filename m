Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B024F387AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349837AbhERONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:13:37 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:50359
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243415AbhERONf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCf4WwSTyEP9NwYsYDIGKQZvuVMRE1gY6qPNeY1Esu93L/RSaY15xwsbaNGnaPLxm7O+2PVGqU2YHo7fqG4MFwRdt2xm4ezxF+vARNBcCVJGCIRtdjAFvHU4Ok9220dyWxMaiUCR5ywf0dDsHcneirAtEGPdUYzyQzE6sSs/b5a+t4GXUlM0oaosBcvvClltn6o0p3F7U+OFI1r2IbeWRJbpVL0t6k8DVv1vDWnl6riMA/z5zjGbrmoLN5H0n/Kr2zBpvyP5Z6KKYAyq5jjjCMnjC2VabLZn8GC3MTyAN6qz+B+qLKZWRf1OPhRcB89LymahaUoELMQPhz/ZksNcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlSeJl3X+bpHDasRa4EoJ5sQi8R2BzrbSpAsqw8Z75g=;
 b=lSYFU3nNSrtLBFv5ONHKgbr7bFaIB0eFswb77ZOfqsh/btY9swMJraXKS8YUmddIGITVEM1t8qPlLtyP7Orce+UNEvY0raaeabtxNrElIetzFQtBKguPsCVcWywcpZ8pAE9OOKoF0Pl/QZJ/yjCxsqgfmGyWbohjQdsVY3/TLy2J4pM1zlvGX6dGRrpttNnpfGKgGGcrXgVpIWBK/45i+ujDVgYq5w6X34E9Ta5uSQWp2DAYoE/f/uCyJlRbXaI7d0S2P5CsWDytwVsn+nAcrgIv0s7guB5YfGrajaxZEgOIQ/QQV2wlK4R+vpdIrU2IH7936ZbZl9MWxmiABhSGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlSeJl3X+bpHDasRa4EoJ5sQi8R2BzrbSpAsqw8Z75g=;
 b=izuPv4TD0fHU69yDLXOKPRN1Sd4pH7zAhuoj6ipNVSzTulLPTJuwchLnvzet9fdeNx0nuoz0xT0IOMSviExH8Qk8VHp1Xet1KbcAo7nhorNxYINTtn7enWR+dSUMsKx410THKrNStKWMS/PbK8THIZdzsYgbpbA8kyzjQZp+mMdbjwpEJRwyo/FTFKSh9ZkRjGFmTWbKySYHaq1DIapedNek4EFqI8R9UHjxLBVhKLbnL+2xJqjsHQlNc0Z9qF6E17D9blNHOAnA1CvnMH49RL6olgIY2QM4zFTLLeVAi3yBkHw10x0NG4HWQ9c02o+p/+NFbNWbjRr5mldj4f8n2A==
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4991.namprd12.prod.outlook.com (2603:10b6:208:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 14:12:16 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 14:12:16 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: Update mm_struct's MM_ANONPAGES stat for huge zero pages
Date:   Tue, 18 May 2021 10:12:11 -0400
X-Mailer: MailMate (1.14r5806)
Message-ID: <CCC1BD4E-F6B2-4833-94F9-6AD4C5D46950@nvidia.com>
In-Reply-To: <1621313300-1118-1-git-send-email-anshuman.khandual@arm.com>
References: <1621313300-1118-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B3F4F89C-822C-4BEF-9FD5-0F06B2169C43_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.60.96] (216.228.112.21) by MN2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:208:236::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Tue, 18 May 2021 14:12:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8f75b33-2718-4a8e-3167-08d91a06f0b6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4991:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB49915F9D2C0FCBB58E9212BAC22C9@MN2PR12MB4991.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQfeMBHIPms590O5zTU+9e34t4ZCTs+yIjJ4cMbDET8pFRO2fBTS3eGXKsKsNCB8U90mwHalOpheT4WtnyeKOyU9MkIJd5aDJgBr15WYaICocAfga56LAAhyZIMAmaeWpvEbyT9XmS5kKHIWPmFzNtKmCm7g6LE7VzyDITDgUchsDNQirNe75OuKc7ICJmLsCR8dM8NoIzeaHOO6Gvr1brCem0YREhz6Id+WGa4RQp0hHJ7u1wJ9YmPguvR9nl905wqoHWXIzPdV3jTAKEOYbq6AFDaA/QVn1gTJYHJKUTdHYEGCgtPQxnjnznTy9lnMeVGgNDedyz6kHgPTeycIsWfVXM8v1Qc5/S2Dw5xG0Lvz80kgKU6gwrdwHa/W3su7DQOoT75H1UsLPvRdlImg34pH+EciDQcZma/K4wJesXSW0kgj84+WJh/mccCQIewl91tpTt+MDX1ZzXX4be+QEiqBrxL2R/b1+HzfNZS0h+eypS5E9BxtebtjSnfovin7Wmj2F8awl1qNTHVmHcoHdNYogBLllWHDYqrfuV3pKxx7oSdK4Nryx8RuIOUZj4azx89XvJuLwIkZxdui8FUeu6/CIOOEWlQ+wKoX/g0wl5mgBqWr0dQzlk2uAFMXCWndZppMwmf/Ju349vqJOGe7IQA+Yp3G4sgYPrUtu12xHcbwlNNVHYj2Uwopl20AMpvCcJekiTd/6IzIfN8SwHGVr/2XOurOmFb+Oh34AuQGmGo5ll5gArdhF9udRcu1Z9nNnn8W97liqWvSViIEPX3Bo6dluIt/QC+xI+xdeNYsBL2fjOpR5GEan/dj5f5OthHX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(86362001)(66556008)(36756003)(2616005)(6486002)(956004)(21480400003)(15650500001)(66946007)(66476007)(478600001)(83380400001)(4326008)(6666004)(966005)(5660300002)(33656002)(235185007)(8936002)(8676002)(33964004)(53546011)(26005)(16526019)(38100700002)(2906002)(16576012)(6916009)(186003)(316002)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RjBMc2VVcGVDTkxwZktXZk9hb0JIditmc2Y4L1ZvVVk1TlpkcVd0T1hCWGg3?=
 =?utf-8?B?M1NwTUhEa0plMzY5TkkyQTlHODltd25aOW5YQVFrVDhmbm5ZbUordEtGTU9B?=
 =?utf-8?B?eUk5cDdvME0yTWlJb1pkcG1YcnU3Z1Jqa2lqMlBDZlcyUFJLMW8zRmo0VUx1?=
 =?utf-8?B?MTM0cDlyQlJGUXRKTG9LSTJDeU1Cbmd2MnVIcU8zRXJQY25OSXR1ejZnTnNS?=
 =?utf-8?B?YjYrMUpDb1ZUODB4clVpVjRSakg3ZkMwQjFCSUozSlAxSTJjcFpWRnhTVFoz?=
 =?utf-8?B?NUllVTE0eUltWEZYYTgwTEtDMTR4ZkYyQUJUOTdpdkZzS0lrY1J5emRVYjdM?=
 =?utf-8?B?dlQ0Qi9LQzBJdUlqLzRHejB3RUdtWWg0b3hPSmZjYnNsRWtXSGVjbU1YdGJK?=
 =?utf-8?B?a2E1VldwK2dpTVFuYUhEMmNuVlNvNlNJenUxNTRyTGtYZG9CZk9FRHhqVEJB?=
 =?utf-8?B?WUpQZnZwbGJyK0h6ZnlvMmRWa0VRRStCNCtHUS9RaFJrM3ZoVFA0eTE1a2hO?=
 =?utf-8?B?S2J0cW5lcWdMQUEzNWJUY3M3Wk0rUzh2TTZVVjNaeTJLSHplbUVxYXd3Vzhk?=
 =?utf-8?B?SWJTS1RBNGpnRUpXeUVqcVBxSEJudEtqdmhLNEhlazZvT2xFM3NwQ3dYckZO?=
 =?utf-8?B?R2NmYXBRWkUzUjcvY0xYdkdpUlF2T29EaFA2Ty9SYTFXM0pIbHB5a0ZQL09a?=
 =?utf-8?B?MzVuZXhPY0FoVDFhdmwzdDNyRVlUcHZJTThNK2pKbEUxQ0w0RTFRT1BsM0Iy?=
 =?utf-8?B?dnR6TlQ2MDFvV2VGKzdKcUNwQ0JEdUhDajdCV3EwbVlHWWdKZEQyVXd2ZnIx?=
 =?utf-8?B?akE2Sk9DMEFzTjJOdVEzTDk1MDBCRWdVeHU3djlqVkpOTFg3Y3ptUzYrUlpM?=
 =?utf-8?B?TlJGQ011OUhwMlVycEVDZjczemJabjQ5aDJVOElSRGVqMDJkS1laTWF5VUlj?=
 =?utf-8?B?c1FzVXh4ckEwZTNacTNoWkYva0J6TFVFVU5YeHJMRURxNXlwdlA0Y0lLZGRW?=
 =?utf-8?B?dzRZVG1FK25hQ3U5N2pWTGFpY0NTSGJKOFpTWDcybnFjMktDS1ptTjFoMzl5?=
 =?utf-8?B?N3g4NXl2TmdyNmZneWZvS1NCUDF0MzZUb0NlYjBSelF3YVdoQk5sOEdmbmw1?=
 =?utf-8?B?V2VvSHpzL2Uzc2NBUDFQOGc0bTFBbFdiZWRta2NCOFJCMmRVNjQ3TlhQRGF2?=
 =?utf-8?B?QjJZU2MwemtvN0FXbmJQYnJrNW5Obnd3RjVNcXZUL1U3NUpWS1Q1QU54N2V2?=
 =?utf-8?B?WVFkeGdNeFcwSjNvOGlRVGNINlZKQVBOMkw4SlgyR1RzemUvWVBSYlNzVmRT?=
 =?utf-8?B?TmZVejBYVVVvRzk1RmVRRGRnUnJMbEE1MFdRV2VSVU9uVEl5M1VzTmIwUXlv?=
 =?utf-8?B?dWIrWGV2Rk1pcWtyZDVLNENhNmtGQlNLUC9OdGtWWTNMN3paTUpNeHVVTis2?=
 =?utf-8?B?R2wrUXpoTStlUVFzbXB0bEJZVkg4eC9Md3hWZk9SRjRTem1UMmQ4am1tbUV2?=
 =?utf-8?B?d1kvczZiSWtIdE13L3NJK1NDRXVsT0I4VkdDYjVsZUdJTG5QcFlBeGE5ZThS?=
 =?utf-8?B?Y1V2M0ZMUTl5OWNTb2w4dEtxYVVCQXBYekJxT2NXUVNFTkMxZ0RJay8vNTNP?=
 =?utf-8?B?MmRURGFhbjc1dXVsb1RNd0xaTjNOYm42NERtV1U3cVlRZmtsTkkzS2tHS2gw?=
 =?utf-8?B?bFJBVjhadXVlWGRLdWcySUNmbVF0bkVzQ1IxVi9qcW5iMEh3QlFiUTY0QVc4?=
 =?utf-8?Q?DIbIo/C+OTkKipeKAOvDqWFSzjbGdjwLm5cwNVI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f75b33-2718-4a8e-3167-08d91a06f0b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 14:12:16.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7q/o9Uy/P5FhiyZJYcNgbLl55H7RZZEdkHk3LrE9xBq6QITgbMM7wdXGdc9q856
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4991
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B3F4F89C-822C-4BEF-9FD5-0F06B2169C43_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18 May 2021, at 0:48, Anshuman Khandual wrote:

> Although the zero huge page is being shared across various processes, e=
ach
> mapping needs to update its mm_struct's MM_ANONPAGES stat by HPAGE_PMD_=
NR
> to be consistent. This just updates the stats in set_huge_zero_page() a=
fter
> the mapping gets created and in zap_huge_pmd() when mapping gets destro=
yed.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.13-rc2.
>
> Changes in V1:
>
> - Updated MM_ANONPAGES stat in zap_huge_pmd()
> - Updated the commit message
>
> Changes in RFC:
>
> https://lore.kernel.org/linux-mm/1620890438-9127-1-git-send-email-anshu=
man.khandual@arm.com/
>
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>
LGTM. Thanks. Reviewed-by: Zi Yan<ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_B3F4F89C-822C-4BEF-9FD5-0F06B2169C43_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmCjyzsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK3DwP/0JlOLg1fypV7V0gehEeDIKSQ+09D9ZF0HWZ
LhuO7qD1EAOsyuIfMDCduh0Wt2XB10eMOjVvhbnUCtssDaOBGonVEVjrLmwPprkz
rN7v15qfteIS788bIZWsObdXJ5FbQND8i3ALzu1IT/d7zMePOaHTD8kZ6ycSQUQo
Dufc1beHT1XqeeDfszM06nwP3RzudQQJKFlhqgJcBSPubkm9Z56mA7x3EBFmKZwa
gR9EjCvOig6JJ3kubtFRuyZjFEtU6NuxKDBuleifzyHGYzBeFn0gH39EaKlnPvzw
AUthOG6x1ZDcjdIbtebi8FoQqnej7WYWZYFLPJ/g19Z6AtF3AXu6Zvm60B2dpLH4
I2p9o6CcRhs7Au6fTMN3NtSQOxmrS+xfQjZ91uHTdIEMfTHP4zqkBGG8dFv/N30h
DaAnhVp/McNJPyRQ8TnFrWo/aOWKL2zI1GWz8FV084ktM3ua7FrdAXeB0Ao19lMQ
jXq/8SJO7FRvbm+zLx4GcD0cGPNQSnuhTDctIgwbDpNBS0TyaISVnRKjAwK/mKfr
GeR2EF4lSDtbo1srfdrxmsiDu17l+RdiJve74D+T508TCJo59sTo901APzR11OzI
JlhI8rPgje6Q0bqQVmxgLIRpnFPTWkeIrMn0AA1sGaDnofyP05o48Yfmg11UL8H+
72P3Vtyp
=Koab
-----END PGP SIGNATURE-----

--=_MailMate_B3F4F89C-822C-4BEF-9FD5-0F06B2169C43_=--
