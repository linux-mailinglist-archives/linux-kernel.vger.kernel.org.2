Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3716237F978
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhEMONZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:13:25 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:32033
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234292AbhEMONQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:13:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L61cZ8ZMu/pXdZv9nD1+lLOKf7x3NOcYsfqdehtNyYFKANuH8TcKfhJ/WrsofACrQ5DlHvJ/uCBV+H4wnKxTW6lzwPBzAa1eUZAu2/f475NusqSZJRD96YX7Zy7oAIx1ce1SYyxZhApqnSYS78QwYmTRp14us+qJjTONemifxtrszohhrGMBX9fe5ON9MTbSYRwXnybHkwsMQMHOiXbrhelcgkYwmtAGJ7dfZHi3Yh6CKQEptuBbl2+wOiFUB18s5+HdPxA1UBmsBhzN+zwXHXX5t6lNPijnyxE4KyNt4jo9Nwv//f0Ab85q/58GDPYZmAJTkGaWTN3whd3EuP5kIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RBxCGKgDWNzB5n1BeSoAS4h7rExNX+zJ8CuaPRnnzo=;
 b=Px9JzDi+7kdfav75leZl0y9GGiCvOpUGbgVLPuxRaS/V8X6T+ssWhnY0XV9mocsZwiIx92tGdh4j0w2o1Gxt3TyaHg7135cSklHCtTkuYxCL8OT98wd7Qomnj/IbluUWsk3L95v+rnrZGo6w0gjCKaNSFP9IwNtsyOisFpL9lJweVB9Ep+mjuLmcwZj7Fww6nIwxLRQHRdEAuzFosf0YIKdatThUG5FYc6hPWTouOAPvzzSx1kn990X3hnQnbP5eoHXuMb20bcCl41ZhwTBjTLUA1/o9bZVR0I/fjXIR7FWIgWXDDUV2xcBiqv1ZBTgQRSj8ellI/waIqHTIHFKTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RBxCGKgDWNzB5n1BeSoAS4h7rExNX+zJ8CuaPRnnzo=;
 b=li8kcGe9BTOVPMczzEGMvsZzBYZCjzhgLMxzM7QDmZc9+R81/35TuZDWyb+gmOAX8KJAkftwLWTba5N4ETM0d+y+lWd1djbQLeX8vBJ/+3zh6KJ3+RUhOUn/1Z6O71/D5rPXV5vpVPsh+jwC7eGCQNRn9xRIO3G7PZhG8c066ozDmpKy8K8P2r44aQyRl6EpJxTySPFAoWfntaOo06nTBfbgkL9Prkad99yrSEzlZOOHQv3r+GVayw1wCi5JRKgS/WPy24GABVavUYHXFoGGpQrSNZZ0z1l1Bjk6KvZ5xNMbUM6IrZ3jrOI9raWfgf0yswTBHlKPY95V52T1z2EMGg==
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4799.namprd12.prod.outlook.com (2603:10b6:208:a2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 14:12:05 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 14:12:05 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/thp: Update mm's MM_ANONPAGES stat in set_huge_zero_page()
Date:   Thu, 13 May 2021 10:12:00 -0400
X-Mailer: MailMate (1.14r5804)
Message-ID: <1B37E0D8-2F69-45A3-9384-DC5BCE9F67A8@nvidia.com>
In-Reply-To: <1620890438-9127-1-git-send-email-anshuman.khandual@arm.com>
References: <1620890438-9127-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_51A8673E-449A-478D-87EA-0CCA466659E5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:208:178::26) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.93.183] (216.228.112.22) by MN2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:208:178::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 13 May 2021 14:12:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d27a7e2-852e-46ce-0989-08d916191603
X-MS-TrafficTypeDiagnostic: MN2PR12MB4799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB479914B3E6D95B0D2D957D9AC2519@MN2PR12MB4799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xt7ua2t5Hm2KrIfxpRve5f6a+FSx5D/1g1Cignv4jW5RNIU4bvehPWGSpBsxxsGxow+UXrh4Lyn7dkzLpEbfnJj4YeNEEOn5jlIJ1KFHgW0zhxpPxLpldq4FYBREruuvgxyZXTW6b3yCbk/Eh6AAWx2vjJA71bskLFS05seDc+Nme3OVaE/7VPs+vsV8wE1bUrctZVyNzHlL0G8hLK7vMu6jXq5dsPj9cQstYifKkGoN3YNA0/3THMHx0Sk68ZCBfeHiiZBXjY+Vqik4iX0slqWeAVEqGzKWf949ZZ8j8w1aRxvdzB1TjieOvLqnf7IYhsO/f5EEYOxOmYAGBiwmmizUmUQGs6L8UqdniwjgPO7/Ciz/phVeAdZkOAK7BbM2rpVVhTq/BmFugidRk46K8o2HG3YNyNbmP16nfshV9KWd13RTybNKhQ7X8PsbFCx2PBnpa9o5RAxLOKYDbktGImbn6hfb/ZodqbsusTwAQj273xj36JtMMsKmSy71HQ7hDY0ejw6mpRkYyylDNsimta71yvUhWuddJNRxqAJVbjBg/KnwwUaLnTmwz8IKrhevHLp68KKb/XKq3jpQufKK96A4NM0ZyYlpCz1AQaL4Su7MzXIeFPhluLaDRg/hwlRS+L1iedavK/9Uoam5x6z8k7jMwYWfRignQF/4cQ3mouQ6B5GW/L5H6L/3kv9spcZjBCdRVIdE4aIvHsdGD6Y7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(86362001)(36756003)(6486002)(33964004)(15650500001)(53546011)(26005)(33656002)(38100700002)(8676002)(83380400001)(8936002)(316002)(235185007)(16526019)(21480400003)(5660300002)(16576012)(478600001)(2906002)(66946007)(66476007)(4326008)(6916009)(186003)(2616005)(66556008)(956004)(14583001)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZnNoWjVXc1lVR0ZkazNlMEpHcHU1T0E0TzJ1OUUxTHE2cUFub3VHNHBhZDI3?=
 =?utf-8?B?djJySW9RVVRjOUtUaDU4cFBpeTJpZFNyazRGMWVkei91VUVoakI0NU9qR3Ji?=
 =?utf-8?B?dGQzNVBVWktZb0x4Yy9QRnZZOXUrTWVMS0thbHI1MG50UzRSdEhEQkNDQnZ1?=
 =?utf-8?B?azRha3hDLzY2WE5GTk1pWWM2TjFIZStULzBRN24xcWVoU1ZUTGpwSmliaWxm?=
 =?utf-8?B?a1VrYVRDc0VNUTlGQXdqb2RXWDlqQlpFT2lMRDFMRUZ6L2ZmcWdiNlphQlZv?=
 =?utf-8?B?blN1Kzd0bEFXVmZqRTNxcmJxcWMwc3g4dHZoZ1QvMmhNbUNyZHNTUW1QdEV4?=
 =?utf-8?B?R0kzN0RTM0ZOaitPTmFsOXprOVd0L1pxOXdhWGJ6UVJocC9sMkErZzhnRUY0?=
 =?utf-8?B?ZVpOWmJyZ1N4UDRjM3ZkMnpINjczSnlUQVlURXQxTzlwWEtkWVZnNUhMZzMy?=
 =?utf-8?B?bXczdHBKMGdKY2NJeUtsYUhuZXFpenNHSmQrSW1aVXhac3Y0Z1YzY0V4UlZn?=
 =?utf-8?B?SFR3MGEwbk91d3JIUUZ3MWFjdmlsb1BpWURydVpVUUUvK1VxVTRMMUVTZWNC?=
 =?utf-8?B?UTAwcEN2M3dKR3BKeWFlTVpNUmVJNjdHK1BIRWs2VTBUNFZwUS9QWkE5UFJp?=
 =?utf-8?B?Tit2NjhmNlhkNGhkM0dLd0E0clROOXY2SmYvKzFRYjNVdHJVU1Q1NU8zemRj?=
 =?utf-8?B?Qk9ReEJFZ0lKMXdFbHk1Q0wzWGV1T2l5cmRoa1BMaGpIUHc1Y1Z0aGJKQzA0?=
 =?utf-8?B?STNDLzd5TUwxN21BTnZmV1ZFbmpRaSt6WjZHeGZTYlBaM1V4LzFDczNCYS8r?=
 =?utf-8?B?SlVhTUsyNGJQL0hYSytWT1A2UWQvbHVyb1JQWmdKOEFKYlBrS1AxMTIybDNP?=
 =?utf-8?B?S1hSMUVOVmk3eHF6bDZjeUwzSXRRUHc3bWZpV09uT0hWUHNXemFUUnQyRC9J?=
 =?utf-8?B?VllXcnNhZnF4R1REeTVrTkVFcTVKMTE5ZUtpS3JwaUw1VjlEOXE0cVR1ekRI?=
 =?utf-8?B?eG1GcFBxVE8weUdZUDZrS3k3Zmpzd0VHdStWeGNNOS85WDR6WUlCak1uRmN4?=
 =?utf-8?B?dk1nTXJDZkNaMHM2NThJQ0tGWFJyR1NyUWRlUlJIMllaZjd6eG9PaDF1VCtQ?=
 =?utf-8?B?UGt4cndEQ2lmWWUveUxCKytZUlFFbTNaVmxrZ2dwM3Z2eWs0djJSUXh1Z1pE?=
 =?utf-8?B?UHNjODlSUzR2OFcvNkZFc2gxTVEyTHAvajFreHZ5Vk1HMHZKa29Rd2RwN3dv?=
 =?utf-8?B?RW5TeU9zYktza3FSbU1yUitnWVZ1MUtWYVlISURmQW9NbWtCSHFQQ1REL0I5?=
 =?utf-8?B?Z0tjZ0JFVnRVWHVINTFIUWNMZDdDNGVBRFdqWC9KcDNMNDRRNUFJNGpvdGMy?=
 =?utf-8?B?QXkxK0hCcU5CY0REY0hQQ3cxUElwS2ZUZmdrOUJsQTRGVDUxakxiRjlsK0RV?=
 =?utf-8?B?VWxzM1JLK0h5SjZjOG0vVzBaNTVjL0YrNUtCcTFIbHFGcGF0b2RvMHdzam9s?=
 =?utf-8?B?UE1FN05uUDZKWjZYcDRUZDU0R2hBMGxESVJCR2tJdGNqL3pBbnhXSGxxMlov?=
 =?utf-8?B?bDZEcmg1SDVHaU8yNGtWcFk4c2Q3Sk02NFJ6a3NRUWtpWW5sb05ZTC9UUXVy?=
 =?utf-8?B?dzl2aFdKQU45UHJHQzlSOG0wdWl5Ull4KzR0aXhYY2xzMUQwNEZDSGl0enls?=
 =?utf-8?B?Qm1DbFZtZGhqN2dzRlVnbUZaTGRQM3JlMmJreGZNNnNzdzlrZTRraloxcjlp?=
 =?utf-8?Q?xABnzsw6Kr4/Ge/m8N+br93WDQoq/S00kxahU4z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d27a7e2-852e-46ce-0989-08d916191603
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 14:12:05.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lysvCphe6W7Ggz2Yz3g+EEoh8BUQFc6XkGfZQryjqOxNLylAnGFRfW90lHN0dmn+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4799
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_51A8673E-449A-478D-87EA-0CCA466659E5_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13 May 2021, at 3:20, Anshuman Khandual wrote:

> Although the zero huge page is being shared across various processes, e=
ach
> mapping needs to update its mm's MM_ANONPAGES stat by HPAGE_PMD_NR in o=
rder
> to be consistent. This just updates the stats in set_huge_zero_page() a=
fter
> the mapping gets created.

In addition, MM_ANONPAGES stats should be decreased at zap_huge_pmd() and=

__split_huge_pmd_locked() when the zero huge page mapping is removed from=

a process, right?

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Should it update MM_SHMEM_PAGES instead ? Applies on latest mainline.

zero huge page is added via do_huge_pmd_anonymous_page(), I think MM_ANON=
PAGES
is appropriate.

>
>  mm/huge_memory.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..262703304807 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -706,6 +706,7 @@ static void set_huge_zero_page(pgtable_t pgtable, s=
truct mm_struct *mm,
>  	if (pgtable)
>  		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>  	set_pmd_at(mm, haddr, pmd, entry);
> +	add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
>  	mm_inc_nr_ptes(mm);
>  }
>
> -- =

> 2.20.1


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_51A8673E-449A-478D-87EA-0CCA466659E5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmCdM7APHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKzhsQAI4zChftpGQ/3BHkgMv1LCQG25FCYj1NZ7ww
gpqWg+L0zg4CYaXToL88CvYZWIbW0gbluMAtfy7LTrPb6qim/ATALcQjFGrJ94GO
+cu4CygSV8+6ToNuDPBLXegxvZyS42mTStQ+0NiB3UbbyaTVFHy0NgTzcr/s73iL
GZfqrB/KXN/mobvjI6EjqU6OXDOK6mj1kIyU7mt7fHXFjsvtNGVlLrGvnC3+MEaP
/Ts4mGPphc7tXysLLzNV1NPwwvY4igQuj6IZiddB/ar7ghQtB4CnRaapZKGhzI17
pUBlA2+JjISrpenOslU1ekfDKqeWzWac+5waZq6I7WB5uhWxL1KgNIDcdwg0str9
R7IQj45S5Z7veB6xwV6lnp4Uzn15soMANkb7DHgqePWODfMjenXBYF5WoT5OgOC6
5vc4U1U5lrI185L5rLZpzKtZndO7aB1naKwSs6s0q5vKTY5+43x8Xa3jhuj2nVrz
l9laUTfMDl51Uxl/7kJdyIRCJMWjwsVdHrWlPSAiocS9K6N5Z20/f9JsKZG+eUym
gGd3NBB07tz+DbFzXm8m1+XHCaeUpZ/v4+DZPjAmibl+QHTtloCjC9BzvjvlL+RQ
yiSdTMuSizXEEoL4kdCXw22Q5h1mlApBUTbhvR4Scpe1s+7MFQmB8HlYZquSTv3a
XCKHvwX/
=s+xh
-----END PGP SIGNATURE-----

--=_MailMate_51A8673E-449A-478D-87EA-0CCA466659E5_=--
