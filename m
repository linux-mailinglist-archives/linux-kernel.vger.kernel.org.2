Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4D30A208
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 07:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBAGgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 01:36:09 -0500
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:4353
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232149AbhBAGPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 01:15:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gquNzVPBeUEIEu1T/7dlc0IUU3QYhis6vNErYLj4n8X+TOBBqK16lRdFq6puYhQxe6d3UxHT/PvSXeMUAO1FKpzLplC6BvjYGV1k2Gq9vfE7kgjzCHxcmD5NW78i8MbPODxYHzpGtp8fBmwA3Oh8mqL7BWM2akDQUXL/XuHrruEj7bd0lZa5P/HTiUNZ2O7kioWcCaP/01fbQLKPPYtOWnay9ZI3XOPfLOoaNVXSlRODiUcuW211BtejSpt0LqmsNt7JCJRZhugvjhs6qEXScGXmyQ430onez11Wn/SO2SfTs14u72RNHl0V1iuZBX22r+j70Yq8VwSBthdiV9Qwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhZY4qb7pg9BE1FgF96BMYu4Bc/fzRb4kSlgP4uHUd0=;
 b=YxgjVAAjoBYWDXy/UGKJ3C9Ku9SPa9/DWi+dwNwiD/i76zdVgCPrRq7+5vFcKSeIHPPgIYmRncQwe9IsLB1uZpnuUL8ADJ0uQVjLjo7LP6nmYDW4D2+KNEcZVS7Uw97aYyIRM7xUQuRSutpEJEJYT45+vs7IQTLcY/9J1FPyCRdDehcMVeubDRy14zuUPyuzNudEh3iKp9I9uCLNu7tz8CB12Lzyj7SoW8P7xAFpSE1GlZA/2KP06Y2z9jcUW94FuhKFoAZsyuC74yy2+90bXc2YHR7tztiiyi+tiqtyQoTUATjStFDTrHMd5rxX8yAcb4xROg2e+MvwBEeixkFimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhZY4qb7pg9BE1FgF96BMYu4Bc/fzRb4kSlgP4uHUd0=;
 b=C3DQz1b76mQdUFZkOzd1GRcLgq3zqx7cGO8LUqJmGEmVSXSn7r99aYhe3TuJLgFifVrcRYChDMZHG/zTCbGLtw63oZirJc1ISCe8FhMfBh+7GtkKayOaYzYhSplBU/i9hVC/75cIYwf5lUSTz4bkMddYJs4FUX1sXR9U0c8vMNg=
Received: from (2603:10b6:a03:4a::18) by
 BY3PR05MB7939.namprd05.prod.outlook.com (2603:10b6:a03:363::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8; Mon, 1 Feb
 2021 05:58:13 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3825.013; Mon, 1 Feb 2021
 05:58:13 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
CC:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC 03/20] mm/mprotect: do not flush on permission promotion
Thread-Topic: [RFC 03/20] mm/mprotect: do not flush on permission promotion
Thread-Index: AQHW921uEanxn+tjZkePaibF0+NzTqpBpV6AgAEqOQA=
Date:   Mon, 1 Feb 2021 05:58:13 +0000
Message-ID: <B24BAD2A-6641-42E3-9098-3A41AA39D417@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-4-namit@vmware.com>
 <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
 <7a6de15a-a570-31f2-14d6-a8010296e694@citrix.com>
In-Reply-To: <7a6de15a-a570-31f2-14d6-a8010296e694@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: citrix.com; dkim=none (message not signed)
 header.d=none;citrix.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87b1d25c-4e71-4a3f-9021-08d8c6765c64
x-ms-traffictypediagnostic: BY3PR05MB7939:
x-microsoft-antispam-prvs: <BY3PR05MB7939A33C084A8E045E141DCED0B69@BY3PR05MB7939.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x+pqR0fpNyemW/7zIRj8dwO1pcwh6AinI/tEgP9WZs5BBg6eSLCZgqC0Zh0StzNVwOfVGaXp8npYG5fw3fmtKQ0z1/JNix4nMEEEwXXKzwH5WxINydpvvsQKALoQf5bKXwTq5QOWOfBbBjiAFp7wxsAvXDnAgSIQ0brYu5z9wujo4w66JquEofnMhlzdzxq0gqF+PzfltpE+wvTgBtgTi66Spcgxh+sGveLw1KrwepKYTyRM3MlF6BUqkkzJLSzNNuEf6QLc+ilF+noW7eD/Ai+FQcxMLPs13UZx+6qmdz9B+qWaXcnM7ELoy+MROAknIQco4iaOlcFeupBoG/YjDv6o7VXy+crOaXKuDwfBOACex6hWz2rXDDK9YzgpGjq7JGzdQT94Se9vVgTo6Rh0eZ2Ut9kmtpCLZzrSoszGPnQvtxLnLjvp/BBqI9kzNvhdT88rDmgLxOh9jQLcXazz50BE3hyre2AEUs0T9aJr40ppYbsDbcxlqmB9/EmjXpZOMykGWkwO9Tji0fxA3cJAo70p8YtRAlES0NKNymp7mFffZK6GnxMHWNa1V83Ub4AgqZuODJZ6JIJux7SCv5hIAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(316002)(66556008)(66476007)(6486002)(8936002)(6506007)(478600001)(71200400001)(33656002)(5660300002)(36756003)(8676002)(53546011)(186003)(4326008)(66946007)(6916009)(54906003)(66446008)(7416002)(76116006)(6512007)(2906002)(83380400001)(64756008)(2616005)(26005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?I9n8rC9tA8dIInOUm7QQEYEGLUaMW8ZuQMDAN6/d++uMmBiCn/Eqr4aOlw4q?=
 =?us-ascii?Q?2LO7EVUv5f1aqKeqYPdq+zynEM6wX+h9TLDP7oG8+4Bn6LDbdPUpdXbHbOdM?=
 =?us-ascii?Q?SSLyvVNcnnSuaCsgoQE3HqWaS5Nlq5ByeZ/S9B+WVlIiAZQUVV2gvygv3vFy?=
 =?us-ascii?Q?CBMKyyBPOf0vfoXF4nx11wn7ofnx/DI67Nc1V3IZuZ3GE3CzDWNn7XOWTA0l?=
 =?us-ascii?Q?FaYXFHou/1pwAoPNq4Lfm9hXg+gQ8ILLadSnHFhon56ZipN6vgw4QMOvnAxF?=
 =?us-ascii?Q?b0ydu+8IPjUD80LqJ4ywpsFeeq7tGIiDYbFwJmDuAxbe3dDY1E5QHsdK2ZIm?=
 =?us-ascii?Q?zS0i0uXWepdZbI7sKK0v9mCypU+/IcXfeV28saNW+xuZrm35irTfLx/JZzj8?=
 =?us-ascii?Q?VaEDz1I/7wRZeYhYAeDbz4PzRLSTcAFvVQ5a1mn/OAjV/WRcePXBDkY0bSbt?=
 =?us-ascii?Q?W/6/HJdlznsokqKAsnDB2EniuUMg10pJyLbKgTeBrNHKeJKXCPprC1h3tpH4?=
 =?us-ascii?Q?LyLtWEsnwfzI5PKh211G1suHexPOAn02t8KDeePAIKzoIfqWjLhWQ5aqT865?=
 =?us-ascii?Q?FyT3DsjQui3jfUbqwXu90YNmKurxoaml7P0PZbniXxVaH6IYKbiarZLdKLQ9?=
 =?us-ascii?Q?oPZlPW7VwNvI2BhKcD82JgacOGhTyLZ5qjwN4DoLvXE29SYkEfBkdWZP6r52?=
 =?us-ascii?Q?D1cGF4mM3PJg1+IYgyeFbz+Hl4o6PYTIrEJu13r9rj6yoYSnxFwqlG94T84G?=
 =?us-ascii?Q?TL5YH4N3tEonQEj3ra8TxeD0EbeV5WN+2j2gSiIMxbRwpEGCoxIvb79w0Xbm?=
 =?us-ascii?Q?93MNsP8Cxo/bQiAc/a+Xxu3Y2QnuS/8jrzYob6Dxk3gYvW64mTeDLUEJ0WPg?=
 =?us-ascii?Q?HIHkGGBKlca1rYJPzheVrVU51eWT/vwurK6ucYIiclweHCfnacfDLAVtM0D9?=
 =?us-ascii?Q?ixAacYFgNFZPnwatG0RrTckgbQo26jLg3nWIE5l5VDqexDXmC79PHFIyxe5N?=
 =?us-ascii?Q?VU+iSadlqwT7TMdSTHTxvnTCFOPc2txIgE/WpoZSiozbCyKlkZ/7btbC/g+9?=
 =?us-ascii?Q?qvK4UoDf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <319F2D1653DDE94F9917A752E0162985@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b1d25c-4e71-4a3f-9021-08d8c6765c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 05:58:13.0740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSLuBUlyWK7CgcbvbzTDQofbFXlWoHhyK0ZOlfOHVMj5XPKnNAdNyjPAi3QTQfIEeIeOE/gdh/bs/5twtgAVqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB7939
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 31, 2021, at 4:10 AM, Andrew Cooper <andrew.cooper3@citrix.com> wr=
ote:
>=20
> On 31/01/2021 01:07, Andy Lutomirski wrote:
>> Adding Andrew Cooper, who has a distressingly extensive understanding
>> of the x86 PTE magic.
>=20
> Pretty sure it is all learning things the hard way...
>=20
>> On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>> index 632d5a677d3f..b7473d2c9a1f 100644
>>> --- a/mm/mprotect.c
>>> +++ b/mm/mprotect.c
>>> @@ -139,7 +139,8 @@ static unsigned long change_pte_range(struct mmu_ga=
ther *tlb,
>>>                                ptent =3D pte_mkwrite(ptent);
>>>                        }
>>>                        ptep_modify_prot_commit(vma, addr, pte, oldpte, =
ptent);
>>> -                       tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>>> +                       if (pte_may_need_flush(oldpte, ptent))
>>> +                               tlb_flush_pte_range(tlb, addr, PAGE_SIZ=
E);
>=20
> You're choosing to avoid the flush, based on A/D bits read ahead of the
> actual modification of the PTE.
>=20
> In this example, another thread can write into the range (sets A and D),
> and get a suitable TLB entry which goes unflushed while the rest of the
> kernel thinks the memory is write-protected and clean.
>=20
> The only safe way to do this is to use XCHG/etc to modify the PTE, and
> base flush calculations on the results.  Atomic operations are ordered
> with A/D updates from pagewalks on other CPUs, even on AMD where A
> updates are explicitly not ordered with regular memory reads, for
> performance reasons.

Thanks Andrew for the feedback, but I think the patch does it exactly in
this safe manner that you describe (at least on native x86, but I see a
similar path elsewhere as well):

oldpte =3D ptep_modify_prot_start()
-> __ptep_modify_prot_start()
-> ptep_get_and_clear
-> native_ptep_get_and_clear()
-> xchg()

Note that the xchg() will clear the PTE (i.e., making it non-present), and
no further updates of A/D are possible until ptep_modify_prot_commit() is
called.

On non-SMP setups this is not atomic (no xchg), but since we hold the lock,
we should be safe.

I guess you are right and a pte_may_need_flush() deserves a comment to
clarify that oldpte must be obtained by an atomic operation to ensure no A/=
D
bits are lost (as you say).

Yet, I do not see a correctness problem. Am I missing something?

