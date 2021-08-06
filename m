Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A392E3E2DB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbhHFPYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:24:13 -0400
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:51073
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244335AbhHFPYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:24:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls2ISwAjsc3w7WMpmTal1EY8XGWWy6dpxOJxS+o3etiMdTYPeeZCBM7FvoUG9TmiXrQdTQikeD9nc5lqTJ8XEQmo48SSmeGs4XhGwsN11y9ghxen9iV/ZTLC0Mn6m1dK699pElR61lYP5P6QEXs3LD2QQ0eM9TCiVr6qPPdYihWF3TS4c5NC0Mj6x/g3j05IyoJMYlLJs0wh/jYjp0/nj4qyktocpi3mwKBYQXc90wDeqjv318OXMsCUCiehdVROKVgU4QKFwWJO1G1UJUw7cks6evvsB/EaRXQJ/oQFicUZvEAwGgz9js4Bq0wrVLzpgrqfrwT6RmuzgliMRLa4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbQD1nQ/J2DLSnDc0q16Qd03KhjscbrD+uTNrSKm0LQ=;
 b=Qutb24a8Fc1OKFoiGztVcAiEJtP81naLw5yyXgmZL/cmBjji5GJ6LXcdlj2O/Qc9i0nF8kUzohaTqimzdQKBbNfjLFk5QNa01Yiwm+HmeEaDNHXnx2xQ2dOYerh1G2C30QwYo7TJ6Z3XAoVbnTfJYhsaE+eTKgKtML00OzNfPnGWmTp0GHgMglaGPSbH4mPZ9FZtaVMxSTnvSVvkvutG8k6vKTiOtxhBcOUoyep2WQCRCjcsCgGAmefjgkvil4Wy5Frtt99wCmnP+D8Iz0VrNg1XQWnFcknNtYW+EkOkA0gjnmCpu3uEksWlD7AsNvhjAgz+H3i444GKvK6aSX2GOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbQD1nQ/J2DLSnDc0q16Qd03KhjscbrD+uTNrSKm0LQ=;
 b=lDj3dMXK5E+Mxha4LZ8UW82AFQxNH+bvhP4QV0HsA4v+ieWoJ0vXpnP1XtDCSLoCtPSWiUOkYNdfRxkli4957V17zfumwFJRQEo7yYDVMQX3K1xClFdZhQ28mqymDulkkRF6umNdYHnkW4Zzql9navIgRb0d+82fkUa/UIE/FNgR7eqlzMXBFPULadzRil/4lqSSNuZ9Y8/GieF1+jKw//H+QS1XZptziGzd8pyA4oFOTSxiAUN6m1msegoyEiLdMIqjvLTBppFxoDr8u5FUeCA3jA2IoffXri83qfL5F8bFG+X7A04tlXObtDXSLEpZOsKl6sBV51MiXREIlKwRNA==
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4029.namprd12.prod.outlook.com (2603:10b6:208:167::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 15:23:45 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 15:23:45 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 12/15] mm: Make MAX_ORDER of buddy allocator configurable via Kconfig SET_MAX_ORDER.
Date:   Fri, 06 Aug 2021 11:23:40 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <58BBA058-DAD4-42F4-9AA6-ECFC5F7D61CC@nvidia.com>
In-Reply-To: <1a5c17ac-7f63-6aae-b83b-4438bfa6fe34@suse.cz>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-13-zi.yan@sent.com>
 <1a5c17ac-7f63-6aae-b83b-4438bfa6fe34@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_FCE8FC84-793E-4C3F-ACC8-A4481287DCF4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::19) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.235] (216.228.112.22) by BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 15:23:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875d382a-3e26-493f-3838-08d958ee2e75
X-MS-TrafficTypeDiagnostic: MN2PR12MB4029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4029A08066AC1448192F9CD6C2F39@MN2PR12MB4029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQvOLFn1+FNWrYVFxO4gfaVpD741kgOVWKPOAL85RmCBqkndP3pY0CAR2dw1nzPYzMWkCugon6agjK0sJi5FoeKKdx9YeQYi5OWskApD0vGtmq5X0V0NuMAQFrtnHIr7u3Jtzzx3cb5+faDThtTyrJYGF3a8yLhAbPFeIXuPdlCczI5f+90KQjiPs/g0lEfB8KGTYJcMC7MHQ97sVv+qIA9cp9XYGdAXfVZIAPNa6P0WtsfnTe6Q1yCgxORDsNCrGh5LY7pCRFO4HaJJIkAM3fi3pA4sPAITNb7UUDnlyk5odBWj9shw/BLY++NDWAhL/YOqHMO8u8zjyQYlJUU979FW9A7CsLuLF2P/lISwiTR5+s+aM/NVPfoxkytF4BxAJ2bfnnbpFNlTNq+QJ7YoxI+YfHdloYvD3CBvq0yOZ+eKkLzxEMFURLANSWBpqKdu0atI0PZoeEDdTbO9Hxvw0VGeQ/cZFaiMPXKewEg3eQhmKt8EHfEa6aZedffJfGWYTaJ4jTgzc6Zx1FiSxYHflnwcjv9DrnkV68x7p0qO0s/hgEGaxPTC4duzmoIADg1G2QQIdgLlPsOunleQLDt1vY3RQeUzso5ecV2DDycpid8qy4WX4gC1oBjpnRwr38yUdJBvwnwh+BZ11lqLw8x+y9om0ApZwnbi6SyjSJjsOz3wvYtHodidBGjc+h7UUroUbTGOLfO4bZimyfWwjij0gxSvlwavOfBDHKOab3avcpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(5660300002)(235185007)(54906003)(16576012)(316002)(2906002)(66476007)(26005)(66556008)(53546011)(83380400001)(36756003)(21480400003)(66946007)(33964004)(186003)(6916009)(7416002)(6486002)(38100700002)(86362001)(33656002)(478600001)(956004)(8676002)(2616005)(8936002)(4326008)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnJQbU5mNnd6YzJPWldsa0NxQXg1RkZUVU5LZEErYTR3ZDRTcUExVUhWSFdX?=
 =?utf-8?B?OS9qTW1XRFg0bWowdk5UL2ZBbmFWekswUDQ3bnNVTVJBYllFZ1czOVFwVEVm?=
 =?utf-8?B?OWhMTC9za1hmOGVRdG9BTlBFbEpKTjNFaWJiWC9XYlI3a2JFYkk1Rk5zVFdR?=
 =?utf-8?B?dkM0dlpuMFpOZmFHcWVHYmJkQTIxeXV1eldCRS9wOFJjdEp4TldkVjg0MlFI?=
 =?utf-8?B?Q2dQVHV5T3JaU0kvWFk1bzhIQ1NSTjVWam9EWVFVRkpDUnBkTXZYZW9udkJJ?=
 =?utf-8?B?aG9aL3B2RlQweUNBMlJuTVBycEYyaEdxZCtQTDlQbjBBTVZxOG13SndtcWlO?=
 =?utf-8?B?ejZ4UExmdzMvWlRGcHZqOC9PY0J0MmhNc2NvQ3IrT3dHQjJMR1Npd29WTHQ3?=
 =?utf-8?B?S2tpOERVQUR4UTRzVWpsYlRraWphQSt0bHFwb2VicG9OZU5PY2h2dlgrZzhu?=
 =?utf-8?B?SFowN3p5UVYvQ2RtUTJId3lreUFRQytOa1FQdzhlMTBKSjBQbUlUeFBSVURs?=
 =?utf-8?B?T2VvT3N4RXRoNy9uWDNmcjFrRXhZRFhaMXlqM2NPNFczbTlDbDJreXo1MEtG?=
 =?utf-8?B?NGNUeXBndTc5L0N4dXJkVFpHaTBqSEM3WVZRTUlXSEUwVjhNanlCMkxxYXBL?=
 =?utf-8?B?Y0twMkE2M3JYak5RWmp0QmwvVlVIR0JyY1hVN0hpQXZHN2dsVTA4cXpPS1di?=
 =?utf-8?B?QXR4d0dSM0dNa2RKdzBlQ1NvaisxNElPeWNhNktZMzFLSEp3L2dCN2dOK3I1?=
 =?utf-8?B?bElxc1Q0RUZXaEwrblp5ZGh6KzV1UGFpVExmYTdMcFRaamZXR0h3cTA4T3pq?=
 =?utf-8?B?UXRQbFRLU05lSEdCUWM3bFVIdktWRGFDZWRyNXFxZWJhTE5GVnRncGlLZEc1?=
 =?utf-8?B?b3VtUytsQWdadStMMmp0ZHIyUFBFenRVTEFNSE5mbmgxUTFydU1DQzVGTFF2?=
 =?utf-8?B?dXhIczQ2c1BpbldNRXcwa0MyWEZSMHhwMzRaREcwUUxyMzBwZWNQdExvZ0lD?=
 =?utf-8?B?VnpMcElUNFFOMzExT3lkUXQ5d1oyTDZrY244Q05sVEhFZmxBck1BNUJqaVkx?=
 =?utf-8?B?UnFaTmZEdkRmcGdhYmg5YVBhVU5XU0VTSFluWEkvajA0SE1NRDFQcDBhS3Yx?=
 =?utf-8?B?RXpFRXRTcWprYnErMmtqNC9YcGhzeThVYkUxTHJPODZwTFgyYU9PV2R5M0Qx?=
 =?utf-8?B?RlQ3aURZOHlXOVJXZTQ1dDM0ckd0OVFCS3FVVlhjVFZrZU5zWmM5Rkk3cEFC?=
 =?utf-8?B?emd3eHNSNCtwd2pLRFd6dmFPWU5zVWI4SHZiRzJUNmdtcEtRRXZ0Mk8rd2dJ?=
 =?utf-8?B?MGppNENpZTY1OUI2SGZKVmJBV0ZPRFByMzJRRTNueGRzNW9uSjZ1SmdMTlBF?=
 =?utf-8?B?d3JOZWhoU2RYbjhxeGdZNHhIVzgrKzZkR3BTcnhnVEJwL0lVVVppMWpidTFY?=
 =?utf-8?B?VGd0bkltUUN0NW9lM2xnRzlQdyt5TVVpcmxtRGxwaW9Ubk1nRHdNMkhqWXhG?=
 =?utf-8?B?dnk0bTFXOE9ScWVTZmpNRjdhZ2NxMUVmNms4RysxWXhVYzVIL2xBc2RCa0Z4?=
 =?utf-8?B?aGREbWxiWDdLd1UvbktCeGIwWTFua0VtN2RBbkJwcUJrd0ZGeTFkYnhmS0Jn?=
 =?utf-8?B?NTF3OENVMVJTY2VaUEszNHNVNWQwVGtCUStRbkR1Mk1KVDF1aFphUm1QRTcr?=
 =?utf-8?B?bWIrRkhWRkd0MWlyMXNtN1ByU1h4ZVlOcVJ3L0E3YmY3eWtBbWhQUW5VZFVv?=
 =?utf-8?Q?n7EYIsHuptkkQ8+RuoJf/ViMbUpYUZ2+754TsCO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875d382a-3e26-493f-3838-08d958ee2e75
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 15:23:45.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6bFYoflYJ7Si9RrJtrHExLu1Mt6NJPiIrKq0AUx806Vs+clRL7XDg7SuiqkDw0k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FCE8FC84-793E-4C3F-ACC8-A4481287DCF4_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6 Aug 2021, at 11:16, Vlastimil Babka wrote:

> On 8/5/21 9:02 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>> +config SET_MAX_ORDER
>> +	int "Set maximum order of buddy allocator"
>> +    depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER =3D 0)
>> +	range 11 255
>> +	default "11"
>> +	help
>> +	  The kernel memory allocator divides physically contiguous memory
>> +	  blocks into "zones", where each zone is a power of two number of
>> +	  pages.  This option selects the largest power of two that the kern=
el
>> +	  keeps in the memory allocator.  If you need to allocate very large=

>> +	  blocks of physically contiguous memory, then you may need to
>> +	  increase this value.
>> +
>> +	  This config option is actually maximum order plus one. For example=
,
>> +	  a value of 11 means that the largest free memory block is 2^10 pag=
es.
>
> It's enough that it's confusing for the devs, we could spare the users =
and add
> +1 to the value they specify :)

Sure. I will change the existing ARCH_FORCE_MAX_ORDER too, otherwise peop=
le might
get confused by two different MAX_ORDERs. Since this Kconfig only appears=
 when
ARCH_FORCE_MAX_ORDER is not specified.


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_FCE8FC84-793E-4C3F-ACC8-A4481287DCF4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmENU/wPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKsvwQALYfaYlLHQxPltzWBSjHmEZXSHiiDwEso1Za
tXQ2qT85VKLgOGeZa4vFei9AYjk628OqUDjZFaF4iz9cGsnLMT/kEkQ/2+h6nJ4C
O/mmHkEvCkgKwST54A82d4I19WUl9XvliFbtUre/DCVNlug60temutQi4TLYyFxy
jipDaRaTngXRdxWs5U9EebdGYxzWjTLEv2qRKqT3Ut+U3TE//n5otUQCZUiCV0NI
5KCmkqfGawGDsl6J8O2ZKRP0J6mh5oEPxot3Qh+Spi0EmDLOPWJ83PugZulMz3Ni
KZXnAlrsiBAZ79af3KsBDHyqSiAfJ9Xc7Wvf23HRzWn6cscuBgQTJ8Wq/JY38Jsl
RHn/zxONFo37Qm6XwEnaSFvuvIEBgPqjtinixr/6pla4UIwb9G60cF4OBlpaMcnT
+2bf0tsLPRnyChlQqPTVYG1Pu+hYTAZtRp9xH1idsm5ixdFrRIy5Rk85xq7ZmPjj
yIg+gz9C/Lmz0plSoRfsZ5eRNC/FxctZhAKv6RxVuZXoHxXLYpIlyQw1PDEZH6ca
G3iuJiBfVnl+7GyCF84zFo5TAWL/HzjXOYY1NWtH7xEn3RE3PvhP/hBlRIKBNZrZ
cpzuUfEhLdwcT9ZEUsCm8vYTQAg9BkepCp4aN7MYB/BPPSvj1FuFNyOZS/I6CkS/
Nr6/mH4j
=qbJx
-----END PGP SIGNATURE-----

--=_MailMate_FCE8FC84-793E-4C3F-ACC8-A4481287DCF4_=--
