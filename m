Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041C73702FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhD3VbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:31:25 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:3520
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231350AbhD3VbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:31:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gek4FCIi/h6Ljk0LcW7AXaA1uCTDG3TaGBaJx/y1cAIM/67VZEf0vHrhsepdnhlnX2xzN26me0RK4lSSd5QHw/hoXidsFC71/uVsUkP9DqgDXXGpfs46F7KydMHtH87JrIEyFUUxdwnFc5ZKIsni1ek1wypxJc2L9wQbm6RoIwnTyNAmelTCFExexRkfRU8r1qXFb1vGX5V67q5ziYaDjzTStKnfFPz9adHYHxvCHIKgAPdNs0nMzI9n1ctaWbx27qyUBsqRZRBEbp/jaHlGczx5XxK3BIrrJkUA2OssQKCr6WyRiAK3SvgKtBL2ut1SRxsnPFJHk9mHA6AEfsc4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAbcUeu+pvfbXQJBqmqIl8Ul1QeAzB721tWm9/OeuMo=;
 b=Nt1MCA0Jrw6kmvDmsh+Es5MgT+h05cw+U6iQT7iyi1q2gIzbp4ehdc16U//plJCCFZtvKOyX1CyxqCoMVYdidyLf3VIm4H61SbXp7fOHRgxIxP7zvtCOXYbYljrgOPpGyc4CRoOTvMx3MKPcW4IAlHIFinzrRRN6TEBJGAz8OR6Q3Hf0SwsUBgcNHIMMI4/mSx6Lnh7X87L5UuZxMTs2cGyBfOG1kfSmphUdO/WI/zAkEpm1k7rjevOcsZOV0kTtvi7J0jc0qewa9uTS0OwhXXX+73bBHjwelnzsFYUFapGdlk8Nxc6QDe6KvrLcAJcLq8fXqlwsBYUuSLq5R3sqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAbcUeu+pvfbXQJBqmqIl8Ul1QeAzB721tWm9/OeuMo=;
 b=ILoN8VMzy+po36NSG+ca4O77xYfUu+LY+uuC4gIePz+WwGtNfXTywhbfi7i1AFlRVt/ouGTa6ydYNACReLfXxTMzlfdXBoqvJTaLvVrDCjvJtf8B8jOjvoq5CmiJEMHomTznJ0UFsNup5ItSmd631mwurSU6WzXJvX5D1XwA04Hi4T0Bo8DbYVSkKYwuc2Zp0SdUr/LdJRZQm9QmZvhmSzlJTkRuzJGp30uMeIyoD4j/89ATyUidkE014QmJzQEzpILQQyRcGDEBe/HV8YO4j5rNaYCawtxKHv0mM2IssaUrce+iKXG3uYi26FjN/pnTGYMXmEO7HsQfliMEme7yTA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 30 Apr
 2021 21:30:33 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 21:30:33 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yang Shi" <shy828301@gmail.com>
Cc:     kirill.shutemov@linux.intel.com, wangyugui@e16-tech.com,
        hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: check total_mapcount instead of page_mapcount
Date:   Fri, 30 Apr 2021 17:30:27 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <F8189ACA-DE85-45F0-8C9B-A6F9D2099777@nvidia.com>
In-Reply-To: <20210430210744.216095-1-shy828301@gmail.com>
References: <20210430210744.216095-1-shy828301@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_85E05809-A9A0-4E07-9AFE-0219E8A0D7F1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:208:d4::15) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.67] (216.228.112.22) by MN2PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:d4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 21:30:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7be5116-51ba-4ee8-dd6b-08d90c1f2f75
X-MS-TrafficTypeDiagnostic: MN2PR12MB4344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43442BC5A6E36E9328F3E448C25E9@MN2PR12MB4344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G69iebR8LxvuPsOli2lZFJXdEfz5M3nBfTDsw2lDkVLoKYOu39NK7iXfgyFvmi1PYf4Gg9AxHikMB0iGl52NxzQfq6QvWGRddoKeYQSJkvgR7Bf4BEauQsOXjp1DKTKrg1SI8sU/7tf9gRb7t6nwsPqHd4zssR0Hl3DOUAI+H4cdYGyDt74ZVzMVEx79fprb0XJqwkNBBNlcdaSgmuyt1ufo3jZQXg6lo/RMYazf8U1JY/WSGwxCSnKypw/5R0jgRQT2RYE+oscRD+DFhO+tRPEfGYo6QfzDBnt/1PuuGQmphfYJHGkmgPUsZbtf1TnOuMPr9UM+gm+eKTMTej0iKmVjmmYTDkN+1f3vr+VyVifbcCt0dCRamR3rPaITy8eLobuC3zp0L2sJ7eqBdms+4OPMCBGBax648+oNBamj3As67EbBZVORNIeePsgq98jFn2BzsPV37jnJzu8A6H/cRb0CxBhWxNgI9UibAH9EPziGRWPFkVUkx88fKuEwwGCURbqIiPrR9avPjTJ1zFFDuIHnrFGpf5pqVRacHL4jcbKtdPN5GMLplOAMEZoKP+R75UYGUA00l47faD5AX5NEi5WqPCBGNmFZ/jSulZpK0ssJ2plv7gqJq7a5zJDB6Iq8Fbh6Yl66KjeNSaLD1BF+CcskfOZpzRcdIRVPW/X8Om0J3gysLgkO2y3ODIjUZbvua8Kx6qylpGk2OTE4+lPKhCKodl1IxYTj0/Ssgta69VECsjlf4Et7igyjj4aifRpl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(86362001)(16526019)(2616005)(478600001)(235185007)(66556008)(2906002)(956004)(38100700002)(66476007)(5660300002)(66946007)(8936002)(6486002)(83380400001)(966005)(33964004)(36756003)(4326008)(53546011)(186003)(6666004)(33656002)(8676002)(16576012)(26005)(6916009)(316002)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2dLTWEzcWZkZTgwNUdoZzd2Nk5WZGdYTTZlc3gzR3VhYXNZaVpaZDhWWm9x?=
 =?utf-8?B?MHF0ckE4TFZrM0ZxWmF2S2NtRG4xK3VyeHJmSVlmV3VEMDlNbHo2bEozWTgx?=
 =?utf-8?B?bzVITW1OZDhFd1BQN043dE5ia3ZSWkMzOWhCY3dIZ282YlZuSW51L0c5YnBD?=
 =?utf-8?B?UEdwY2p1dEtBY3RISkJibWxtNUEvTnZDVEt3VHRrUGxFZkE4YlE4bndhUmgy?=
 =?utf-8?B?K2Rhd09WVkpNSldxVVFIdVEzb3g3eEo2NElIcCtzVTBIQVFqcjBUUXQ4eUFS?=
 =?utf-8?B?TzF0bkZMQk14MmxtdkF1TUNXQ3JwU29idmxzYk9SbTlWVzZFQ1l2Y2pvditL?=
 =?utf-8?B?SGhWc2FJaE14cC9FcXJFZnB3SnpRVzcvYXNHUlRyWHd0ZWZ2SjNqMFpKNG9C?=
 =?utf-8?B?cFRHWm5STmtTdXQ4UEl2ZnVrdmhiTnlZR0ZtRk1Lb2Z3TXFKNGhUcWs1UnI1?=
 =?utf-8?B?a2svU21aWDBUTGNBVG9NL0MzdS8vc2YwVFcraVNocW5yWEIvOFpKWWNJZ1pX?=
 =?utf-8?B?eSs3eGoxOWtocjhsSzJqVWZhT1FjbWM1cEltdnlQMXJvZVpZemR4eHlRMVpn?=
 =?utf-8?B?SVJJd3dld3NBNzcySE5QNEJVMkc1YVlHakkzZkhBNWpIN3pUSXp0OVdYcEdR?=
 =?utf-8?B?SDNXSmp0MHR5cmRWZ1lGdkloNm9zZzFFU2V5aHI4dExscHZBTG9ORkNOV1FW?=
 =?utf-8?B?K25mTjJoZlNBZmlvNXFBdDZJUk12aWgwY1Zpa0JKOG42WDdzY3IrS3U1REhm?=
 =?utf-8?B?TFMyRTRBS3dBeFFIclI5Vy9Nd1NDYXMxNjNMK0JlQ2RrM0RVYWcvNEhvckhq?=
 =?utf-8?B?cjRUVkVXeExRRzB4ekQxZVZyY2FIU2lhMTNQRmpoN1ppalgxR2laT3lGUTNo?=
 =?utf-8?B?bFEzMkgrelJZekF5aVNjSnY3NGlURkhZcythcko1MXFEZyt0YXpqYWxtVkJU?=
 =?utf-8?B?YzFJdTNGR0ozeWJGK2tQM0ZnSlJ0ZXVLaEVNUEtEb2sySEQyRG5qT0dUWDg0?=
 =?utf-8?B?aXYxb2hPaTkrOXV5cHIrZlQvR3RYOVBkM3BxeUN6N2dXUXY0ZkFtdEpzZFdE?=
 =?utf-8?B?djUyL3FlTlEwNjNjWjlpa2huTWV4RjhHSzIwUTJOVWM3R2hUbFZtTUZQVXFC?=
 =?utf-8?B?L0VqT3N5ZUorWEF1N2FLK2ZhbWZJbEZZRlZPRXo2d1E2MmhYdzZxUEppOW1F?=
 =?utf-8?B?cEdxM3ZBMkx0UWM1Y0RnZkJtZGxub014OVArUmt4K1pHSWwyNlhxUVVyUkNp?=
 =?utf-8?B?bzJYUzY0SUJjcFJqd2orTmF4aUxiVWRBbFNJdVFXdUZ6dzJKVU1Dc1VjVHFE?=
 =?utf-8?B?V0ppMDZjeFo3R1NvcEJtZVhnRzkyUW1ObVpRbDJYUTR1Q3IvaXBEZmNtcERp?=
 =?utf-8?B?STNVa1QxMjBsYm5qZGJtMkE3WHBUSjYyTWpVMklWZTk1Ym4xcnBFRzNDd2Vq?=
 =?utf-8?B?UE9hc1ZralQ5cjRFZFE3aWIzN2dwVURjUldtMytKUUJvRVVyMzl3RlExZjZi?=
 =?utf-8?B?a3RtaHFHQWZ4TmdicnZybkJoUTNTYmdVUVg4a0ZPczJ3aitGd01vdzRtQkJs?=
 =?utf-8?B?Mm9oYkxQVnVOTVBiR0VIYUZPQllTNjdnQTlSREZKQkpxTS9QTWdUaDFzSCtE?=
 =?utf-8?B?ZjF1TnZTc2cvdzJCZFhqN0hwMXNhdDI4MUExSlk5SkhwZXZVbk5hbFBKMHVo?=
 =?utf-8?B?QklIajNiVy9MNS8yNjF6bFV5VEI0dUhuM3VkRFJsdWZ3K08yY0czRmZyM1ZR?=
 =?utf-8?Q?FcWDR2+zBh6/Fl9ldb2t3AJowE5TbkzuFVJcnd9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7be5116-51ba-4ee8-dd6b-08d90c1f2f75
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 21:30:33.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEEScLfiUY0WIA/vNWv9XLNBRAgyqV/n0t0HU9oT76WobIiHIO8y8HILPVpnrG9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_85E05809-A9A0-4E07-9AFE-0219E8A0D7F1_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Apr 2021, at 17:07, Yang Shi wrote:

> When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> return false positive for PTE-mapped THP since page_mapcount() is used
> to check if the THP is unmapped, but it just checks compound mapount an=
d
> head page's mapcount.  If the THP is PTE-mapped and head page is not
> mapped, it may return false positive.
>
> Use total_mapcount() instead of page_mapcount() and do so for the
> VM_BUG_ON_PAGE in split_huge_page_to_list as well.
>
> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-t=
ech.com/
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/huge_memory.c | 2 +-
>  mm/rmap.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..2122c3e853b9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2718,7 +2718,7 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
>  	}
>
>  	unmap_page(head);
> -	VM_BUG_ON_PAGE(compound_mapcount(head), head);
> +	VM_BUG_ON_PAGE(total_mapcount(head), head);

I am not sure about this change. The code below also checks total_mapcoun=
t(head)
and returns EBUSY if the count is non-zero. This change makes the code de=
ad.
On the other hand, the change will force all mappings to the page have to=
 be
successfully unmapped all the time. I am not sure if we want to do that.
Maybe it is better to just check total_mapcount() and fail the split.
The same situation happens with the code change below.

>
>  	/* block interrupt reentry in xa_lock and spinlock */
>  	local_irq_disable();
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 693a610e181d..2e547378ab5f 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1777,7 +1777,7 @@ bool try_to_unmap(struct page *page, enum ttu_fla=
gs flags)
>  	else
>  		rmap_walk(page, &rwc);
>
> -	return !page_mapcount(page) ? true : false;
> +	return !total_mapcount(page) ? true : false;
>  }

In unmap_page(), VM_BUG_ON_PAGE(!unmap_success, page) will force all mapp=
ings
to the page have to be all unmapped, which might not be the case we want.=

Maybe you will want to remove the VM_BUG_ON_PAGE here, check total_mapcou=
nt()
above, and fail the split if not all mappings to the pages are unmapped.



=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_85E05809-A9A0-4E07-9AFE-0219E8A0D7F1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmCMdvMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKJs8P/3l3Gv1CPkJxwawsP/Y65AtXzFwYbx8JL2uW
2IWuicYQUOcT7tM772CLWfQkAUpLVkj97EwOqZsY3y0zQJm05dcdzRyigOEF9gF9
g00yTT4BCWzB9vgY2djV39vCVst5NW6IkMMy87HYNsTaAAuqnsfmsy2xzWMtzIpU
QRV/7QjCH7mDf0ilH7PG1RBWrGj+maT5+RDAKvONQKMz3+v4y7ha+cWW3kXNd7yg
iNWdQyiN8cqyfIcoaimgWw5JrNElm6WwSzvpG0N18hFM4NMJVt+y75WFnFMiTaPJ
9dvnISbBGPJy3lK6nUcBgvmia2RiI8D1+r2xEr+ufr/tRk7zkhrhmqAAKIgxqcCU
ivFEljQ/LHVu1F0pWld1b5b+rYKtths2A8Itfr5fpOegEuXAVvJvuNEof5naVPEW
ITXT+TD5FBzd7UZ9DAwFsoXrN8r2yz093XNnCjoU/XsGYVad6QhzIGq3af0bjSGP
Qizo/kFmAFTiAGThFV0/0VBdIng19KGv02fbW7fjwo5cGWvHfkIMWJNFZwjel63U
zoFoc8+oM+VgL7OcYt7hnKYyjZHWLVd4LwGuy87sXzBYasYkYVeC9UwKxrfJYJBY
d0o8Lg1K+Y2oY8Iz3AETm83VEdQVndWiuUsrERG0Ni6fmdoLG5kWAFAY8vF2ou/8
Vq1uk7I2
=Bfs6
-----END PGP SIGNATURE-----

--=_MailMate_85E05809-A9A0-4E07-9AFE-0219E8A0D7F1_=--
