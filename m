Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6630A2AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhBAHaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:30:00 -0500
Received: from mail-eopbgr680048.outbound.protection.outlook.com ([40.107.68.48]:3551
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229557AbhBAH36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:29:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igc7JgHNiJhTwYyFrD7HE2cHsXzAbLSZwU8iy2o9yo7peG7QK37EjUP81RVypdW69EUf/vIy/ZM0jP0BSkYRLy7PC0PVjmj8Gd0naFm2iwvEPMOUX4lolyW04KvxOk36KA5E1eNWiAZOUqf/WfmGj9bHWQBAD7UxwXdBJ1atveNcxMU3ir+ne7VrSpGfWQpRzjbemVIDKqa5CO6KQpSm0r7jkxXeUjHoyMnlNzbTlH4Ksw5jvoo5v8m47akAggzEWfY1+WvY6FuiSuNqL4ZV5gvX6ZtLwNIwiLQyzFNIOSAQ2cgmamds7hIGq/LP5cZAIBa9YPaD5TKLyCnb9hSPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5DiwjeicPjCiuIy3tNcB2roF2vvdsi3oAs3Mnv4tWI=;
 b=Qc1zZUCxehZpu5tzKwT4DozPNxZDdbZxgWOvaz7xvuouj3OI7KgthMN9T7WABd3fVOm16k+BeeK32SkiBB/O+hgU0XgoSgDY1Vj6KVoXXrHH7bj8TvNdzp621l3oFCYsP6Pu6gm0A9xlSB2PCDFUg5ANalHU59eAWYv7ypaLjUrWHuuM76d595Ex54fyZ+bwDwtcJyXB+3G+uoy6sr84nFqD9TRpIcH4rrZIh3nlp3Uk/4DdqFzBd5vkdlE7707Mzs6o5HPFdg8yeMrt0kg4My1fif1uFGSnKWROdXpaZ49z6rzID8b8TqtlZWIB+VsX4vfMHC8zGpbTvgCopq3y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5DiwjeicPjCiuIy3tNcB2roF2vvdsi3oAs3Mnv4tWI=;
 b=ivvfE6x7OEYpcoXiACVI/SzojcouzYCxwRuKcrvo5JhV/CZPX9kTC/ekV0ldq79apc+ZJF9L6JTAkjZpFKNb/Pn4DQJ7kZKxZ+p0SzmBD8gr7UYW/OE7NvWAHEwId6qLs9MU1YcbvgGJ991Uck5TWEm8klElUPh4QyYyM1A3wuo=
Received: from (2603:10b6:a03:4a::18) by
 SJ0PR05MB7440.namprd05.prod.outlook.com (2603:10b6:a03:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8; Mon, 1 Feb
 2021 07:29:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3825.013; Mon, 1 Feb 2021
 07:29:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Damian Tometzki <damian@tometzki.de>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 13/20] mm/tlb: introduce tlb_start_ptes() and tlb_end_ptes()
Thread-Topic: [RFC 13/20] mm/tlb: introduce tlb_start_ptes() and
 tlb_end_ptes()
Thread-Index: AQHW97jxFve1Zrb8YkKsvA/XuoT0HqpC6GYA
Date:   Mon, 1 Feb 2021 07:29:07 +0000
Message-ID: <D1BDF583-2F81-464B-B404-25B0C26073BF@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-14-namit@vmware.com>
 <YBaBcc2jEGaxuxH0@fedora.tometzki.de>
In-Reply-To: <YBaBcc2jEGaxuxH0@fedora.tometzki.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: tometzki.de; dkim=none (message not signed)
 header.d=none;tometzki.de; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7482038b-5301-4f47-241c-08d8c6830f71
x-ms-traffictypediagnostic: SJ0PR05MB7440:
x-microsoft-antispam-prvs: <SJ0PR05MB7440AD51F593E33958F1D0E1D0B69@SJ0PR05MB7440.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObWZA5LEkSI2+sp7DhJ1lJagCh4EdCoYwaCizbYqgOfX5DcP6I7ej7OOIegGWUyyUYBxNZj8o/RD9mQ2oLHcvoE39vNbRmrwLxiHWaiHs1UD1JDvjlwrPdIXlVcu5FnQi6AKryks+gT0yI5I0CJSRm6CW7k52gmPjKxkWj4UrTjazPSPG/4aM2rExD/8Nx+3Q+eOzBL8YL1XiJh93fFdO6PAxjhA1rwLShOfrko9xVVzQP+2+V//9uCsNJ/KZfEymlrggfu9z90cWzlM3gxJbEOTkY0uGFQC65hemoGksOeQeDF0DFpcv4K5/xcFM4KRwp3wiLFXKqudd/wZ+tAQy5nj7rDjN5f44xCKXSS3PCr21FmX8juTk1CuxDC8qUnMxPDLs0lPdNxllumUFjhuBHI2bg2aWVViSsIRDQbSKFcjCXvqU5/a8pMKc02PJkdmYolLAM0xBk2W9avN/RjzotOIe55WK7J3Wfa2/2wJtc0Mz2Tp3LAs3LYrn31hBg+nlTo1Odfbi+ftThgIKw9AZbMOXoW3zOfR/M/fs9Fkezbq9F5dVLdw4NMV9HD5rDbur4eZIwwiFFrqoRTDy4tHMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(8936002)(83380400001)(53546011)(316002)(86362001)(54906003)(186003)(2616005)(6506007)(36756003)(26005)(33656002)(6916009)(6512007)(6486002)(71200400001)(66476007)(478600001)(2906002)(7416002)(76116006)(66446008)(64756008)(66556008)(66946007)(5660300002)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5mI2EJg7mDXb9uilRK5VDFUgCcirHbstP3U/xIb6mftB5BwzTHs9fTVT/S0U?=
 =?us-ascii?Q?NUlwCFtc6ORlTf1NAnAJOJVGthSZ5eTvn9NFeym5DVkDnwciDA5iWr3qcCKu?=
 =?us-ascii?Q?Rr8JPydUw0i0jzuHkApA/FrPvHETZmTMiO4z2dVsZWAWsH9WTSIxh+yUoDYh?=
 =?us-ascii?Q?9RKxOfyudIUkAYCKUu66r5Tc6tuawSeu8EaFUnh/15nlq1ec52UXnn+49zta?=
 =?us-ascii?Q?bfxRmrvMAszzje7U7lvNa+uWmA1m3wVauktQh9Ces4CGVXQjtDaUkgvOmdej?=
 =?us-ascii?Q?ml8xVcbDYlOmbktteYFCmiEu3gLT92gZLrTwruNYdkpIdYu26yj9aZubbGpl?=
 =?us-ascii?Q?av5JdHFObyOI4lzlIwyltBvymx8plFc4OlPjoI4BAPhVsceVIhGlaudY/3yK?=
 =?us-ascii?Q?BOvzpFIyyGASvf77EpWuDgDvzHsFAdQ/cg5ZXjynSoSy+FmjpHcA7y8hbb4k?=
 =?us-ascii?Q?KRl6MkuZ/e+Y4IOxgoDG6yabq4hnN888xBJY6AcLev0Nzt+SxA1KIPwMvrS9?=
 =?us-ascii?Q?HHZymtnaR7xbCSkv7FvRt7XHbOUQPIpByvLinXTA5ya0sEGsqG7Jn0BOGvD7?=
 =?us-ascii?Q?k7TIic3M/uPZmaX9FGE+qlt0+ptLVjVjwKfCnrHI8wyYY7APnNZ3dH6nHI6g?=
 =?us-ascii?Q?JOOFM7hTpVmgyuF+ZnwZ/TQRpN/guW8J04kWO6DySJlU0X822MVej9g87sru?=
 =?us-ascii?Q?ULeX/ZLgBAqWwwnVGOo/0sHDm2ecLw4gj8GM+C1iavlc24UuKGa0RQYrm3dT?=
 =?us-ascii?Q?ygkOROsiYsRbQQZU0KfRFXvyYzpGFTaFCJuDufJQOn0FyqyX2PIph8mybM+0?=
 =?us-ascii?Q?mVoc0xJMwnc47JSnAm0ewvO0R3Id5QyHuwA0fWZfPNdsGrXxxWxsycneovJ3?=
 =?us-ascii?Q?R1U2yN+O+yhe/M0t40BiNSHfg+4lgE35nGVL+5m2qzAXv3IpE7OjQvHWDIEy?=
 =?us-ascii?Q?eiZevNvPOG53bnjTstJH1F1EP4qYSrUQTRJ7lWNV8GXi2UeGB74+JBF4ioEg?=
 =?us-ascii?Q?o5STvWjdAFqtZMk4Io9QWs1RDO4J6Wfs7oRHG73Uf8RJ5G8HArp3sH6EGgl8?=
 =?us-ascii?Q?vSQLk1WU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47976AC7E4F0054789E0D004742EB3B5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7482038b-5301-4f47-241c-08d8c6830f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 07:29:07.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVxMljqdOMu6F3rlK6drLlNY/nE22rlAGILCblNuWLx7eMWFu5fyUIw1ASXqqz8QyxPm5VF3pg3x6kCYb+dn9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 31, 2021, at 2:07 AM, Damian Tometzki <linux@tometzki.de> wrote:
>=20
> On Sat, 30. Jan 16:11, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Introduce tlb_start_ptes() and tlb_end_ptes() which would be called
>> before and after PTEs are updated and TLB flushes are deferred. This
>> will be later be used for fine granualrity deferred TLB flushing
>> detection.
>>=20
>> In the meanwhile, move flush_tlb_batched_pending() into
>> tlb_start_ptes(). It was not called from mapping_dirty_helpers by
>> wp_pte() and clean_record_pte(), which might be a bug.
>>=20
>> No additional functional change is intended.
>>=20
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Nick Piggin <npiggin@gmail.com>
>> Cc: x86@kernel.org
>> ---
>> fs/proc/task_mmu.c         |  2 ++
>> include/asm-generic/tlb.h  | 18 ++++++++++++++++++
>> mm/madvise.c               |  6 ++++--
>> mm/mapping_dirty_helpers.c | 15 +++++++++++++--
>> mm/memory.c                |  2 ++
>> mm/mprotect.c              |  3 ++-
>> 6 files changed, 41 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 4cd048ffa0f6..d0cce961fa5c 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1168,6 +1168,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsign=
ed long addr,
>> 		return 0;
>>=20
>> 	pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>> +	tlb_start_ptes(&cp->tlb);
>> 	for (; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
>> 		ptent =3D *pte;
>>=20
>> @@ -1190,6 +1191,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsign=
ed long addr,
>> 		tlb_flush_pte_range(&cp->tlb, addr, PAGE_SIZE);
>> 		ClearPageReferenced(page);
>> 	}
>> +	tlb_end_ptes(&cp->tlb);
>> 	pte_unmap_unlock(pte - 1, ptl);
>> 	cond_resched();
>> 	return 0;
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 041be2ef4426..10690763090a 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -58,6 +58,11 @@
>>  *    Defaults to flushing at tlb_end_vma() to reset the range; helps wh=
en
>>  *    there's large holes between the VMAs.
>>  *
>> + *  - tlb_start_ptes() / tlb_end_ptes; makr the start / end of PTEs cha=
nge.
>=20
> Hello Nadav,
>=20
> short nid makr/mark

Thanks! I will fix it.


