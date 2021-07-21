Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4790F3D18D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhGUUd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:33:29 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:22913
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229516AbhGUUd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:33:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI/M3UxfsfKDIRdJL9pR37YawzxL0MjreJNB+iEcpjFPWKgdsPQNY+ij/jKaVRQNYRr2SFPegVbeznkVFuFsy7dofMhD1pX6ww188HzQC23wkYxfLZu7WKnx2N15EanN5hhJ9JDp2sPTCyuis4E28DdlD+rsnqI/Wma6rwML6cTgu5GqGhGPAu7pGdoHYIz2LjhHsEr1V2jJaJ2SD/vkiyyLNr4fXSfIj2wX0mb2ZqmQShTUbYYlel4EuV05BgrFBSaJ1F+EE15zw1NfyajC6uHTIhlS/5wL1nk58m2GNAK5eKBJmPkc738nSuKTBnhyh1PL78BwYPMkyytQqiZURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZF2OxVgK0bHKenW9Ki2OK19f7XRsvcDQPkiId3ZQCQ=;
 b=UVijVG2PhWs/cyVb8XLbeLRTvUCv9rXZZuDmmx2053ZQAlCZneKqxtBcYla7HECogeeyaCYu/bW2u1hf5alJDbw+rbZaS13j25RRSV6ot1YCqZK3IZtcLyBhc8UmQ9WRiY/4wzxH/Sq/CCZLeDq6fgse3Wot1BfG0TI1/ia1Q4DCgB13aqa6DS3BpSPVAk1ohmz9wqQrZggf6BCL5C0zXW8HCmEtMkp/Lb9hmxNIBlk1PiJwgSDKxIcCe6Ljbx2Vy/fSmexxcrmH6Ds+1GAPRz/mZldP2fAeH8r0FLQoPuGS4tF/Y1tyr8JNqjf6l2rjFqExJMSaRjcS2KSdWr3q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZF2OxVgK0bHKenW9Ki2OK19f7XRsvcDQPkiId3ZQCQ=;
 b=A0cx9B4y/DaVHr/ERRtiXuKXdMKGTaxbGZTPfPMUuQzwImRb6GCQhKnCYyLdoA7PybB7bQ3PBeoGxxlL9CTN06kvhe8Ke+DdXkC0DKfBURe+uo2aKeYsj5g7KfzoLnI5IodeEDQ/C+UiWD10LGgsBZoxoqOuvxUoh1M20df7oeQEnNI9T0lGYe0Lc6cN5BDL2LmEjAJO5+ecwvNAeQHSTX7q6QTKYmWP8WjMs4QA/MhpUGZ1eM8S9MiYU/r7lVyOHx9SbAsEdOzwHruoh8CujdLJFafVsOfHPa5HafbcnCnMBXE4ic3PVbM58rk0rLZZKJUmCsWGJAIcM7tUm3R2oQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Wed, 21 Jul
 2021 21:14:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 21:14:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH -V11 5/9] mm/vmscan: add page demotion counter
Date:   Wed, 21 Jul 2021 17:13:56 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <6B46E3AD-1504-4F27-B4D7-10BB27479BE4@nvidia.com>
In-Reply-To: <20210721063926.3024591-5-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-5-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B8B841A2-2B85-4DDE-84F3-4832B9BDBF41_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0036.namprd10.prod.outlook.com
 (2603:10b6:208:120::49) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.80] (216.228.112.21) by MN2PR10CA0036.namprd10.prod.outlook.com (2603:10b6:208:120::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 21:13:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8d32ffd-1d9f-484b-06d9-08d94c8c76e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43763424AF1487089ED9CBDBC2E39@MN2PR12MB4376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2e+OfDdEenBohzyEEPO0cFB55cxRScB7cQBI/i8vFXZzNBhxgkDFRMTSxGmN7m+jQx87NAscoWHfBvvvscKxgKS0hZjbkWL+dSppi3k+H+HTQzWegOg3VbmWBiNLLijPk2KoYbc19FeAox3JTWIosErG3R4+Argy0vBz+HhlQ7F8MxpN7B/aQ7U5uO+XFimYZrR2x0N4JUB+CcZAcXjT13BQMhRIshu90B8vJatcFTeiDsGDR9CztXZLYRpSGKe4x5Cl/WNflG/stnWsDgqkuAcF0z970/OfTDQmS7QgDM4BEod4/Shzfs/fUEqqUcq+zP69gTgM5uaxlDIyjH4fjEtNX2i2KXEMnYuZkIbQ9n2jE5XhyXkURcaOvWqA03hFLM5rS4tPg463XCRanMFE5ss6ZMGqZqHd2gYN67mVgra6BWYNcV56L3mOyrAdUVEDekunZtu3zDCOtq9QLpyP3Tarl8d/frdgGS7PYj0g/nlYQc0poJKz+aJe7Ut1kRhwaKsaGV1wlRxEumhZVEbDX9KxhyIlpF1VArSXjbzPWUwR9CUqZl+HMRgynqdVjMrDXiuYE0zn5YoZrin+6sM091Lvz7i0pe/jnXWAu/FbtKPfYFHdtPIWa29AvyIf11PAE3viLBIX4wj3jcZOurOXGvgyxS3R6tXubcHM4LePIapu4G9yE3ZauriKbIbtoBLkvslOc5sHQxpc5GBj6cjrY4wGBY6pCQFj10G5JiAsf99sDj2RMF7hVJfGMy9RIWk23H6wcmEkvZ8v9jCgQuMMXzV8HIRSdvKifp7i0GK0q0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(966005)(6486002)(2616005)(54906003)(6666004)(6916009)(8936002)(8676002)(21480400003)(36756003)(66556008)(66476007)(478600001)(66946007)(86362001)(83380400001)(16576012)(53546011)(38100700002)(7416002)(316002)(5660300002)(26005)(186003)(4326008)(2906002)(956004)(33964004)(33656002)(235185007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEZTbWs2SzdrMUFJUnNJUUtXek9NQU1pM2grN3ZJV2V3d2EvUWs1Mll3Mi9t?=
 =?utf-8?B?RTRESG9JUHIxNzJaRFE0RVpMK3pwdHFmUUVlbEFQbDc5UmlaRDdUbUNjRXZN?=
 =?utf-8?B?YnFUTVJHYXVyM2drUFMraytic2F1U3Q1ZEtDWUxsUWVlYnFSY0FZRUxFazBC?=
 =?utf-8?B?QXYyUHlZa0krZ1lmR2ZMamEwU1RoQWEweDVuV1E3ZXYvZ1VLR1p2WXN2OVZu?=
 =?utf-8?B?STdQaVYxZW1FOEJ2YWU4TWgwejJqVjZmNUF0bDBiYmNONG1LRW54RWE0MXhx?=
 =?utf-8?B?N05qOC85OGdFbGdsTk1GY0dLN3lDVzMwSENFNFhXNG9iMnFwNWU5UXd3djR6?=
 =?utf-8?B?eWtFVjVUZVF2S1gwQVdqRTNGRkp0Q1NWOU1OaDh5ditLTzdvQWdHQXM5YkdV?=
 =?utf-8?B?VGxNaGZiLzZTcm9NYzdaSVFiZVJVc0VTMGNGZnN6eWRleEkwMW1zZGdKc0No?=
 =?utf-8?B?UUFKSTBNQlhmem5kblpiNERGamM0d2ZoWFIvK01GeGVOdkt0Rlp5VElxWlJW?=
 =?utf-8?B?WDhoRlNzOExtWDhsejZMaUFuU1dvSHpjOVJmWGZDQnVRWVNzZkRqWXBtZzJB?=
 =?utf-8?B?U2ZiempveFAvaGMxcE9FcTA3b3lMT1ByYXVlak44eHN3R2JYNExpYm1Qcysr?=
 =?utf-8?B?Rm9ldHNoVCtDWTB0Z1Z3L29DTGEyeXNHS3J0UlU1cnFrSnpKa3JpQkpNOHZW?=
 =?utf-8?B?SlJuT2FUbzkvdkhmcWtBV2tuQVdvZEtjbFJRcmI1ZStPOUZZNGgxKzVFSlRj?=
 =?utf-8?B?K3ljUHZldUphRW8zQ2pQeXJBVFdIeDRpR3VMelNWaEExQ2xCaklzLzU0OEpE?=
 =?utf-8?B?T3dWWTkwS1VBQnlWQnY4b1YrNTQ4YXEyYkNLTHB4S0QwL0c4cDAwKzNhUWN0?=
 =?utf-8?B?TmVJQjFYU0JTSXVMdTFuRC9iSmdxdUNzTVVRWldEVlRCRENwZUJIT0ZJbU9I?=
 =?utf-8?B?NWVuNkRPZm83enZRbU5oM0lBSzFYeHFpQjA0VTZQajdlSkFaVnIrZFFYSHRj?=
 =?utf-8?B?UkdLblJKdWdmenFHU3lsZmhrS0V5LzJKVllidi9pOG5lT255UXlVdGgvaE02?=
 =?utf-8?B?TmFzL3pwa1NDazRLTWQ4cDEwRUg3UFdvYXhBY2hFcmdvcitTZ0FlWmwveEdo?=
 =?utf-8?B?ZkY0UmUzdHJaKzhKckxhVXgyaUtkRXR4NnVwLzZ2ZU4vY09YK0pRR1ZVTjJL?=
 =?utf-8?B?cm5XNGF6Z2liTXRzU2tNdHBUUWEwTW9RY2JuYWQyTnJoeW9tNUlIRTU3TDQz?=
 =?utf-8?B?MXVzYlF3L2l1YlhhUk4xQmEwZ2U1QTEyRWRwMUZ6TEF3bytuMnM2OCsxWmpm?=
 =?utf-8?B?TG8zd2V3UUZMMXNWWTVMUm5PWHR4cTJheG90aklON1FXRzdDS3FwOE53S2NV?=
 =?utf-8?B?ZUovVXkvUEdaOHozazlCUHh3TzNTYmRlOWZSSW5hV1htRm5pRHEyTGVyVFNw?=
 =?utf-8?B?MzZwMS9TcHJETEhLZVJLM3k0THFrOFVwN1hicW5NcTVMMGxZUDJSMkliSUNH?=
 =?utf-8?B?SjdRbDhYVTFZYlBtT01HZk45bVRzWWhYdU1tMUFyak1iYzl3bHlTUnJqZ0Ja?=
 =?utf-8?B?aEN1MW1hVkFQcTdSY2pBb1FwV1I5dk5GWVh4L3UyUjNxVHlqY0FkVWtlbmlF?=
 =?utf-8?B?SzFUWlZOZHhQZFAxUGQ3T2U4WjdDTUxqOGhXR2N6Q3gxWnVSbDQ2NndSWnRo?=
 =?utf-8?B?NEp3Z3pWb0tvWjhuRVFIY21XTFJtQ3NseHhDclUvV2wzRlNrdy9qR0Jvbktr?=
 =?utf-8?Q?lX2V+br0gdNFfUIwbmC1klLQsQu6edTUjLqYVRK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d32ffd-1d9f-484b-06d9-08d94c8c76e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 21:14:02.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBY6rGRJBiZs3I748ipzVXJ4184Z5L9jM3E6Fcxx4/gjtI70I27qCcidjdO+He5H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B8B841A2-2B85-4DDE-84F3-4832B9BDBF41_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Jul 2021, at 2:39, Huang Ying wrote:

> From: Yang Shi <yang.shi@linux.alibaba.com>
>
> Account the number of demoted pages.
>
> Add pgdemote_kswapd and pgdemote_direct VM counters showed in
> /proc/vmstat.
>
> [ daveh:
>    - __count_vm_events() a bit, and made them look at the THP
>      size directly rather than getting data from migrate_pages()
> ]
>
> Link: https://lkml.kernel.org/r/20210715055145.195411-6-ying.huang@inte=
l.com
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Wei Xu <weixugc@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/vm_event_item.h | 2 ++
>  mm/vmscan.c                   | 5 +++++
>  mm/vmstat.c                   | 2 ++
>  3 files changed, 9 insertions(+)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_B8B841A2-2B85-4DDE-84F3-4832B9BDBF41_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmD4jhQPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKVM4QAIjMzfltkj+v72135tkjfcofPYCMG76Ay+7U
Esnjn4pDHqTGZimrmlUGyNyJo0PpsMJ8jolMXKjNuw9WwXZS91N7LAAxuWb6PyFD
02k+8zn4wFtMVoR9MudTb4gla/+3KwWyUmr5OXHVbWURDvjHMtIypQneZ4h8+tUr
Bkzw0dcgqTLPJKIIeLdKKXyo9mg6y9XRgfeYi4YRhQBBazNUJvD0V9jAVhHEXaMK
q5X3Iqao9ag79ZdAJQQIEhgE2fKpyZDerpzMy676IDn+pxt9HLtcWnxH+iwTlXDB
t+ySjAU0ONRXNaR/1wTsDyptYlVY7MJ9q8XVhHLvhJn6AMlA2HDEytvO0Dj3tUFx
Gi7JHFtmzP8BAbp3GR9bx5AyOvBtvZwMkivJi3vSES+P+Nol5O6/3WGlhFIGdeyY
FQSjqxWQx3imM2xsLwccqxSRlSmEeolXtC7PJgN9KdFqtKomrJfdSJiyV/ngeC+x
Sti6xO7GsNuyik2mOt2RIvJqLHq8vSfKVt0qBGt7BtNYKsBfiIKHDR5ahYOOLJ6/
S+Cq1D2LJ/S8ulh2drb7d8im/sYL7yULWUR68cfaQAOA0fo0m7mjd+ceArLUFncj
2GoahbcExr5RTcY5rLG6mDBzDetms7USrdNVVtHAZ5W4B4OS67GWatSFvrVM7CSd
+CX/WeB0
=8IB8
-----END PGP SIGNATURE-----

--=_MailMate_B8B841A2-2B85-4DDE-84F3-4832B9BDBF41_=--
