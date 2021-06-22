Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6763B0526
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFVMuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:50:40 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:21984
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229675AbhFVMuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6BIx5Gwm84Jpv9Ym0uamvZrWeNOnlAfw+TlldhY+s5urLYzRb/369zui+xBTehE4m6xgaivKWfK7FoQnO7k5SXFMZZHLYKuZ96hQhvkVyMPS4tSn+m+HSahDuQAgtkTkHpNlMyWqdOZin9TxCOw+hO51lJMaJTAtlA0hXebK8tAV9PpGJM9JQJ9FqAbubw5IzCqgiWPeEqEy/tl+2gcG1xWs9DxGS8foCACEu11vVyE8H6AJVoYr+Lq3vIXWFPysM5ZCKy98jK8y/5hMg85Y+dOk3xvRpaULFJTKul0f8y71EvgJ9Mxr8y+4xpTcPxBj9SV8pRpDUIKFeLadwTogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5yxcI2ZqVQ22JtmRCwFf0R1O7rX5Hb3ftPHPtUg1Bc=;
 b=DgB0AV/tnLT4oDG7sTSTQueHeJWyvMvk3c+WGyBxxsA0vw2mn2LUwrgxmG2LwPzlAdCK6AeGNbcG7W/ENUHopYEiq3lGY3Uh2hNMtpIScKtCX60gwwLXEAhHL0wWyWIoB2LSwLHK8T3ajUKl18Xblxjww5rwNsr+H8apjjAeMSdV9Wddmi39bCs6Hv34lZn1dsKeFeh+UW5tPiWeBrcOWSUXcMIg8kkZJjfz8nk9zR/Zbe0o4byhj1YThFR6vRfpdHNdiEh2/bl2OZv8Ct2tmNX9Fr/z2iwXAQ8Keffw01BIa2dtTkqtxN68cT8MWtvLyu91hQbOD50GPMtWfPeJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5yxcI2ZqVQ22JtmRCwFf0R1O7rX5Hb3ftPHPtUg1Bc=;
 b=mMp8r5N0ZRQU5gXuFLdusRnRUrb+kZy1PCdvCY1cqYg8EM3mzH/h9bfuV+p6x0kAf9nbg9AwCgbHBq7fFaEul6aTpnMnB5pw3RBLrFVa4g6aH6BMKR75l+qrLFeWMWmm+IBhbKtBnc7m+Ym/8ABVcS79Ygcraz4GPU4DNBRweRrwbGE1D4uTcoyIBSX1PA9CubQtqSLFH06iHcVeTFIyzSkHJL9bnGgBqlG6dQnBh8Sf3PydTNdyebKlnXtpe3LEp6FTBbMsadI+/rT19KxzqStkM6HOuLayE/R/Z5BCNeWjCuEofv5/M3ZXvHO8AfkGvABOdJOFi2UumSNyM5A3/A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 12:48:20 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 12:48:20 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 02/10] mm/numa: automatically generate node migration order
Date:   Tue, 22 Jun 2021 08:48:14 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <7E27A89B-DAFD-43E3-B90D-76E90FEE2EDD@nvidia.com>
In-Reply-To: <4732ff69-bd5a-018c-0d76-c1f724abb677@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
 <20210618061537.434999-3-ying.huang@intel.com>
 <79397FE3-4B08-4DE5-8468-C5CAE36A3E39@nvidia.com>
 <87v96anu6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2AA3D792-7F14-4297-8EDD-3B5A7B31AECA@nvidia.com>
 <4732ff69-bd5a-018c-0d76-c1f724abb677@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_75F1ABB9-F2F2-40E9-8DD4-8805BE694696_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:208:23c::32) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.58.56] (216.228.112.21) by MN2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:208:23c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Tue, 22 Jun 2021 12:48:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ae4a076-f994-4d3c-34c2-08d9357c036a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016274B7B275AB8197DA287C2099@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1rwYkZhQMYBXXaw3fOCSA39yzDaINbJ4UGievs4Sm0aHK98HKLPH1CrOzgWAyq7Z1coVsX4PyZ4fbYAdMFc3v4i/UPdK2uMH0v3TfsWyVZ0OIAU+SWHDkjsMmZTXKQFDL3Q7xaNNWrJ5Rsl7XoVzHZmPMjerdkWFKUAf926+STWNsXu+fbwhA29ZLMe8ue+NTqtHSOhDOsfQ2Tmiiu5yrZYmT226Ox0Om5FY7ZJ18lxHEb/ugihnq96bSHX6WUAq3Ou3x2CoR2v2ZWhyLN6mYm7H/SlAvnV0k4rLiO2cKw1bf0bedRS+exrkI46pVS+CfbQf6dsPna+wm8dd/BVSuUmamtsI558mdnskB5ME2NdhgFm1s+ODAAIexYVq9A2AHn3BTWrFhBzymwZOmMsIG1XrVDw2A333KJUhxeoWVmcT5dBqI9hbKG1cQ36dw8QO4dTq3eJzYVE4ZCZNyn67UZ22G3p6pGQ4RDHhYekwY5lrESBNhPrUSKUXNJODh3V8ZmF8+SeeQy3InV9MZ2jEfJ28PaZ/9HdtrqHQVwkszYrCT22avHkre4gZZ1kV6e0bDQrzQwmpF+S9mzveE652HZs7wMfEW2XbeQo+nnp8Ncj54UlLdvsE8hl/kUv8ACidg39wiy9LXCz1wZEbeVpZtzdF4PadwM06D0R28rjzc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(2616005)(956004)(36756003)(2906002)(478600001)(6486002)(235185007)(6916009)(4326008)(5660300002)(38100700002)(21480400003)(186003)(83380400001)(26005)(8676002)(53546011)(66946007)(66476007)(66556008)(16526019)(7416002)(33964004)(8936002)(86362001)(33656002)(16576012)(54906003)(6666004)(316002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhsRjhCUzBBVkY4QjVuRExDS1dwZ3k2bDhwYkFNaUdubjdGRENKRGpseEJY?=
 =?utf-8?B?NW9mNnhRakd6SlR4MjR0Q2NkM2hNbUhWbGFrVUs0ZW9sM2wrNTZXTXUxTjVm?=
 =?utf-8?B?b2lTWUFldUx3bEZwU0lxQi9DQ3NFK0pLbXpadDRLdXFKaUM5ak9leHVZMFAv?=
 =?utf-8?B?NmFQQnZTK1JNSlNQZk9uZ2p6UjZFbUVjVXVZNW1MdVVnTGFlK3cyc3cwekdN?=
 =?utf-8?B?NTVGRFZVRzVFQkhhMmkyWVY4RExlaUIxWnpwQ0dRc3pzUlM4ck1LMWs5dHZl?=
 =?utf-8?B?Umc4QXNFRm1YYjRONDBMRGFKYm1FOFZTYjFhSWIvbEFlaDVHbjFyRkhJYkhv?=
 =?utf-8?B?cjlQeGtRaU1OTzFCeWNaM3hYOEQwR08wR1luRnBxdDdLVm9sM2h4NTJVRE9S?=
 =?utf-8?B?STk2UVpmbjZ3NWxUTTcydVRid211TkNldThaSzFCU2F5MnBLR3RCbTZ3RTYv?=
 =?utf-8?B?VDdmbmR5eU80Qk91cTBMc0xPVk1TaldEbmY4dDdJVlFEOXVqZTA4eXdWelRW?=
 =?utf-8?B?TzBaQXFuRW9GZmYwczg1VUN6a0N5Z2FkVGNkanNiOTllYW1ib2RwTjRJWURm?=
 =?utf-8?B?bmtic1ZuYTI2UThWQTJsQ09Mc0U3WUxUZ0Z5bkRaaUFkd2ZvcVFPRGlDd0Q1?=
 =?utf-8?B?NGxMa29jeHpoaWNYY1FJR2M5RVk4NURYSDZaTjdXYjdvcFY0amNSOXAxUHFn?=
 =?utf-8?B?MkFjU0I0REQwZmFDNGtqWXd6YUhuSm50UDY5THpveDZsZFVCTFZYZGdaYkpB?=
 =?utf-8?B?Z29JMld1WW0zeVp3Z1NnSXc5SHN5VmZIaVpLV1BUb3JvRHMzajJnLzdWT0o3?=
 =?utf-8?B?cWVMY2piaEl5bnhkVXBGYkV6SG9lbGhZVEs5VUJFWS9uL0VQenB0cGpBZTgz?=
 =?utf-8?B?d3ZXUDJ3czBqVG55bTk5ZHJOb1h1UUFxSVloNmIvQmFHQnlHc3REdU5aSUMx?=
 =?utf-8?B?Y2ViTlVyOGszdWJQRzJUTGwxaDhDNnNZYmczNTVwYUR5UzBLS1RER2pMcmdz?=
 =?utf-8?B?b0s2SVU3dnk5TW83SDdDb0JjV3gvVGpkMk9UT013Nll1SWQ2UXY3L2VFRytz?=
 =?utf-8?B?Z3RBOU9tVWU4MzhCWW8zOHFkZmZTS2lzdlBKaDliMkNiR2laMnhoMy91OWpQ?=
 =?utf-8?B?YjR0VEp0VE42Y1llSzhrRkF3SG9iZGlpT21PRWZRa1RLUjFYVXE0b2pyZTJt?=
 =?utf-8?B?RVpyRkRnZTZWV0Z1RDRVVjhrUW1hUzFjZHRsT3FETmJueGZVMWEra2o3NmJE?=
 =?utf-8?B?Q003ZkpTdUNXVm5UTUEwR1FZeEQ0dnNTWHg0VlZLSE1hZHVqdG01aXE4VCtX?=
 =?utf-8?B?Nk10ZXg3NnlwNG1zb3ZkV3QvNzJmS1NHT2h1TzhIY2g4aGU3R1VLMkh5QXI5?=
 =?utf-8?B?VjFrZFFBYjg5V3dtOWdwRkowSTgyN0pPUmhwZGw4VVZORW9SYmRCUDUzWDVa?=
 =?utf-8?B?ZEs0S3I5SkxiU2lNK3FqOUpLRHFTMUQ0dGRCUzFXL0xLSkh4YUtTQkpKNG9E?=
 =?utf-8?B?K3RuYStEZHdrME9NL3Z5RGFlc3MwQzJJK0MzYmw5WU82MUlJNFZJTGdjb09Q?=
 =?utf-8?B?REl1ejlxV1pXbHVqdWZFL29SWHp1eXFKZFRiZHY5UmYycXFjeGM0UURHV3dq?=
 =?utf-8?B?Q3NnbTZZcWR5cDZsOG5rZTVYaC9WT2xBeE1YL2M3dTVwZzRwR2loZXRUQWxm?=
 =?utf-8?B?MTRGUDRIaE5hMUJFaXdBR1lKTlJqV3d6alFhWlQ5SC93d0pFN2ZINjdFRk1H?=
 =?utf-8?Q?jgVKZ8RP2LDYjohLFgbMqHXqRIbDoa1mfMJJ3F5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae4a076-f994-4d3c-34c2-08d9357c036a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 12:48:20.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7ZTh5pLPrdeOQiGK+dhyZ9G0iYd9F/soOTtiZFVaUiH3Bmvb1m7U3OYtWsoPc5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_75F1ABB9-F2F2-40E9-8DD4-8805BE694696_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22 Jun 2021, at 8:06, Dave Hansen wrote:

> Yan, your reply came through in HTML.  It doesn't bother me too much,
> but you'll find your replies dropped by LKML and other mailing lists
> if you do this.

Apologies. I used the wrong text mode. Thanks for letting me know.

>
> On 6/21/21 7:50 AM, Zi Yan wrote:
>> Is there a plan of allowing user to change where the migration path
>> starts? Or maybe one step further providing an interface to allow
>> user to specify the demotion path. Something like
>> /sys/devices/system/node/node*/node_demotion.
>
> We actually had this in an earlier series.  I pulled it out because we
> don't really *need* this ABI at the moment.  But, I totally agree that
> it would be handy for many things, including any non-obvious topology
> where the built-in ordering isn't optimal.
>
>> I don't think that's necessary at least for now. Do you know any
>> real world use case for this?
>>
>> In our P9+volta system, GPU memory is exposed as a NUMA node. For
>> the GPU workloads with data size greater than GPU memory size, it
>> will be very helpful to allow pages in GPU memory to be
>> migrated/demoted to CPU memory. With your current assumption, GPU
>> memory -> CPU memory demotion seems not possible, right? This
>> should also apply to any system with a device memory exposed as a
>> NUMA node and workloads running on the device and using CPU memory
>> as a lower tier memory than the device memory.
>
> Yes, with the current ordering, CPU memory would be demoted to the
> GPU, not the other way around.  The right way to fix this (on ACPI
> platforms at least) is probably to use the HMAT table and build the
> demotion based on any memory targets rather than just CPUs.
>
> That would be a great future enhancement to all of this.  But, because
> not all systems have HMATs, we also need something more basic, which
> is what is in this series.

This information is very helpful. I agree that reading HMAT table is
the right way. I will look into it. Thanks!


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_75F1ABB9-F2F2-40E9-8DD4-8805BE694696_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDR3A4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKvCUP/1Rk56RLMSffjFWcUZrv256vjCaRk47h5KSr
5TJh8+wdmMElnKbX1kZuT/PbalyZ/pOkEMuLr4HPJ/SaVEFQa2wfMKuuDQ4GiXxk
UtA6cypEU7gQz9hNRQy3yEwgzqpx4e/EiPzXn9FvqkZ1p+xIWZ5t1RvaGCOccMKV
AY8L+LTkmnFVRUlVC7WJWHyV5iNhM9eQTwBdwq/b2OjLvDqz3mxDI5VmcVpJUY0c
ipRivlivK/UqGRjbLoQUnr34hMEkiAJ5jF4mCiyHpMMA+/ykfLtln85EL/ewuSq9
5yroLYcONJGWV9pdIVxLxPA73qVbmtphMwwv5g/QlPkoJnQX82/izooSpnyYBFHR
9DwvdtKr2NX//fbPp3/y6f3iqEDfILDtFHlBtMDFG7xHiFXMLQR1ZPyHRdcRN0M0
8ORTOtrq43xcJZDztEdn6r1on/GQQpeRQ6ThoDp5LpAsUpn29foBGrvo44Kf5von
jzHIeqfHmdLQYKR6t8dHY7i3Z/P1Q4v518v6xNaH6Uvu4+kYAIL0CIzEwJRJQKIO
kVK+kiMIsWmhICxSvuJoeAD3kp+bv1kZJmz1FImOBGmellhip6OhZ6XFGlag/tNU
hEjRKwXC+5xTM1VTlxqnAfPuR95+Qbq6qh5wmD9tfiFIfrm+Ql5f8gRPBrzNBYaC
iyePFeM4
=HM5P
-----END PGP SIGNATURE-----

--=_MailMate_75F1ABB9-F2F2-40E9-8DD4-8805BE694696_=--
