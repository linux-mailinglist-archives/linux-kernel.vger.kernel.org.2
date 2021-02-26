Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC234325B91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBZCVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:21:30 -0500
Received: from mail-eopbgr1400081.outbound.protection.outlook.com ([40.107.140.81]:3161
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229498AbhBZCV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:21:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYFmfEMaNjTCLS0Z0B3JKIFaC83KYmapT6dLojjeQhOSHQLbAldJ52BKQMIegXq+v2kgwaMsuXCgU/w9vHJquwrc67G3Mg9J3/kRG4KN2jRZ2i84N3Srn2pu8dphJxoBgztJ9fuEdibYB9QdeRuqWBQqgVzgbT1WlwuYk6dTuSAFf6ndAE8rWUJHcYDe3yAUkD3xt1Sk7C0nTaWN2wmhhOv18QnA8Cb8okAtWb9jTq0eVC7//NMfbr3m8hiCtlIRIn9rOAOYxOBf40qVVlApJWQaYI3f4JlQhQj//fg8xTct18PREHp30MM0bMJ/JodnGShoLM05TLSd4DA7/0pmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmOBmyNTb8XLSg9A2EXG3MC3LxCxCjO/wQNvveVra6g=;
 b=fjYqPzUgUi7H1cIooacyVzYXLBNknsfThUxqwnhJCuXo6IP2ey3G+8PT64jxTDkhQ1aUraKzG5/sg2oq6diABoRtAeUyBq3ROHqRyDDTo2LKzCVjXOS2wCv15BALahjR11Y77Ld0sJt97IV2Rftb0+hJEBrM1U9r7b23z+CB1qwmDtKxLlbRv9B9n1Xv6eWIycGE9J9uung+vfX0G53qaZuKljphBUUZClBVz3l+ov9zIhRLlFoImrLv7qBMT93vWaE6FLth6INaC84zKOhcuPS4QQni5NmUmbOTQxfPNF2POqHM7bHPFhJkgKlvNZM1j1k+bMrHP1YEJGPzyW6qXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmOBmyNTb8XLSg9A2EXG3MC3LxCxCjO/wQNvveVra6g=;
 b=Xw0AwgAkYDVcxG5A+c1wd3h7yLmRribnEywR7IPcPVvkKQ7nza/vKO5P2n4JPgM/nsZGxnymcW6JYjtVPavzUTUxRUGnRi0eWAwrwLRbMw3LD9O9iotB0xYhIeOlbdrzow7Vo3YQPJj5NhbtN4ut+D8uZEnC7a2hRSelAlDZ2A0=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYBPR01MB5344.jpnprd01.prod.outlook.com (2603:1096:404:802f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 02:19:07 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1d15:6a82:ea9b:5101]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1d15:6a82:ea9b:5101%6]) with mapi id 15.20.3868.032; Fri, 26 Feb 2021
 02:19:07 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Oscar Salvador <osalvador@suse.de>,
        Aili Yao <yaoaili@kingsoft.com>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "inux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCn0F5fAOAyGRl0mX4JfXYioGdapnG5GAgAEgN4CAAIHeAIAAAyEAgAAQYACAAF5TAIAAhxGA
Date:   Fri, 26 Feb 2021 02:19:07 +0000
Message-ID: <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
References: <20210224151619.67c29731@alex-virtual-machine>
 <20210224103105.GA16368@linux> <20210225114329.4e1a41c6@alex-virtual-machine>
 <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
 <20210225113930.GA7227@localhost.localdomain>
 <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
 <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e86e947-7a70-4157-d118-08d8d9fce56c
x-ms-traffictypediagnostic: TYBPR01MB5344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB53449F6113872B22CFC1F640E79D9@TYBPR01MB5344.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSI1HalQfBD7/+Y9DPVYmUp8Bj30kSmbf414+xxB/MVX+Y0uyMzQnGjJaqZLOVQOfTw9Uq4EMyKVJxFV7TNyI6N2426oDXl8V6aYmdAV2Hzr+0ksAzQAka7K16qpRYqZJ/uRjmks6/3jaOLiBIrKKAKxmrQTtkpDs2xVq4N00LNKoz9BJLhF5vHXW+P+n8BE9fvKi+m9HrxHp0RSz7t0mSDIVNTJ8h8qbm4N58CxKQiQ0zYkZEVgmWaQ1UP6zVWrUo6SrxH56ksJCHFd6XpKsz/+/HHX7S0vVoF5n9AuX+FTkM0dk3rqv6o7Mysoym76WeLl4DGw16IW6euCY+Lnh+XauTMY05VFlrPmd9jx3mU804YCmDqfDaZN1CkPX4r3FU1reLQC/JbvfJHDawMkZpXcgXlPkuy5aBAjhfTWlwweoecJEsrqQKaYi6NZAbmLHsKU17wBkav1pc5KbeVBglnCchVYorSQxoajpNjIQ86r9U5QvTBYMS1rsieqNmzADRXRGXBAHw6bqQVjShEA0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(7416002)(316002)(33656002)(6512007)(26005)(8936002)(186003)(55236004)(8676002)(85182001)(6486002)(9686003)(71200400001)(54906003)(4326008)(83380400001)(2906002)(6506007)(1076003)(76116006)(6916009)(66556008)(86362001)(5660300002)(66446008)(64756008)(66476007)(478600001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?VGRBckF0a0xOY1BaNENzdTVsdDZkTGVKZWVyN3NsWWttT215aFlRZEFa?=
 =?iso-2022-jp?B?dnRSK0QxUUtBVmszY3JhVEx1c3VadWg2N2c4RWNlMmRsbkJYSTRmbVF3?=
 =?iso-2022-jp?B?dk1aSlU0NTIyRjhKeHlYNEowWkM1ZjFraUR3R2NFZHVJdnZmUVFkZ1Z0?=
 =?iso-2022-jp?B?MzJWam9zMjkyR3k1TmVjNUd2WUpvOXpmU2p2cVQvQm05aUtsVlRmTHYw?=
 =?iso-2022-jp?B?SXc4RWcyeGl3RUNiMTRtcnFjME45RU4zVHRacS9KdFhVc1ZkWEh2NElS?=
 =?iso-2022-jp?B?TVZIRU1xTmx5UXhEYWRMbThOYkxaTXpMRjdBRHB4WmRwZFkvWDg2NHg4?=
 =?iso-2022-jp?B?SEZ1MUZNN1ZiNDF4RTZjRGFIUFBPNHUvVEkwanRSNzFxRnhwckRtTm8y?=
 =?iso-2022-jp?B?UndwMFg0VTY1ZXorNVljaWI4R3FaWXZ0SW5PZXhZQXVmUUdlR0dwTndt?=
 =?iso-2022-jp?B?UzNQV3JOWHg2QlZTRVRJTnBYcElZNm5tdWdkSnVLSU1MYlIrSUVWeUlQ?=
 =?iso-2022-jp?B?K0xabmdmT0NTREthaEF0MVRuWjlmdUpBOUpHdTlwMzBoT29jeUFhZW40?=
 =?iso-2022-jp?B?cHh2ZFRaUjVxOG5MNVBuQ0w2bS93L3FaeWZ1eVg2U0FKY2NOUmR6dU1B?=
 =?iso-2022-jp?B?WVEzd29TVTN5eEU5UnI4NDZEMmR5czI4MEZqZm41dzZUR3RtVEdrUFd1?=
 =?iso-2022-jp?B?eXR5WThDdjFlQzZFeCsxSGNua3hyaGZmQ0MvdTNucUhHQTJmYVB4cDdu?=
 =?iso-2022-jp?B?Kyt2QzJtUDE3VnV1dFN6aTlYK0dEM2xBSk5POWx6WTU4Y2hGMnRDb1pB?=
 =?iso-2022-jp?B?RkpNbzlhTWpRMTA2QmIxcERJQU16ZjNiSStjUWRWdnlHQ25qQnBVVGFs?=
 =?iso-2022-jp?B?aHh5OFdGT3pjOG5UU2Z6ZzFZS3VIbXl4cTI1QjRUM1ZLQzlJSlVHRDVI?=
 =?iso-2022-jp?B?Z2hGQWthQm5zeUdEcVlxZVpZVjRSRWRJZzVlUFJueWs4MTAyd1pVTkFm?=
 =?iso-2022-jp?B?eDFtMElTUXRvdGlGcUJqZUVvNE5tQkJEbzlrWGNKaGVLY3lFTE00WkVB?=
 =?iso-2022-jp?B?R3ozak5MTmsrNytEbk1zK3VPRS9sQkUyVk5KN055SmttOEJ6MDdMSkNW?=
 =?iso-2022-jp?B?Y0N1NTJoQU0yaytpd3BkREhEL1pJOGJDWnVURUdVZTBMb1JGenRBWEY1?=
 =?iso-2022-jp?B?WmNtQlMzV0pQb24yd0pKUXNzMHNZdVpXcmZoMWtqbXdCLzIyZEdMTUtQ?=
 =?iso-2022-jp?B?NWhib2JKaVd1NkFYOHFqcGJzNFR4dEhMNVNvNGtRUFZNWmtoWmxmMFY4?=
 =?iso-2022-jp?B?ZWJ6MTFpbGFUek4waUw0MlI2MlBrWlhEVmk2YlpHOEUrakxmalRFTnh1?=
 =?iso-2022-jp?B?K2RxdlpNSlFoOFBlZmN6OU9xc2d5QUFxYzVwOGtHaUJXWkNhTjRyVjA3?=
 =?iso-2022-jp?B?MTF6ZGxHUG9XRUYzNXNxWjNib0p3THRGMUg4Y0VXOGRHNWF0QzRuR052?=
 =?iso-2022-jp?B?YTN4SWtFeEJ0UVQxTG55NXYxUmQ4dTVjWlRaNW5TZmYvSDYxYk5FY3BC?=
 =?iso-2022-jp?B?YmhOaDQvZlVMUHZPTlBtaUR3SlhhclE4WlBtS1BCVmJQSWpRNVpkZVI4?=
 =?iso-2022-jp?B?YW5PdGNxOW13elV4UGVGRW1iVCtwUitUMm5sM3ViRStmd1RjTWdzVTZ1?=
 =?iso-2022-jp?B?eWg3M0VIZ3NBRDUrUGtLc2ZweE10NENCeFp2MFhwdnQ3SFpWMHNoenQx?=
 =?iso-2022-jp?B?NFZZY0tTQW4vUWJlMUdvbVhCUVZJRU5kL3Y5dUxsNkJXK1NPbGVNdjdn?=
 =?iso-2022-jp?B?dEFNY1FqbVZOYTFwREJ3S3J0bUZwYVV4enJJQmp3Ry80b1dDZUg0WXEx?=
 =?iso-2022-jp?B?T2dDOXh5dk16Rk9DV2JFcWJnUzNNb2RZRHFpc2tUWmIzTHJJbi82RHN1?=
 =?iso-2022-jp?B?dFdMMktSWmo5aXRDMVdWTm5xU1ZOZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <3FAC7A6880162E4F8B9653A00116D5E0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e86e947-7a70-4157-d118-08d8d9fce56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 02:19:07.6135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HudB/NYHgvuthNZTMrUTTiesTLydrcW3MHZiHQgx6wBwIwY5HH6TSXh7WFACUoF3rcPyMgB9vVIQlChw5M4vqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:15:42AM -0800, Luck, Tony wrote:
> On Thu, Feb 25, 2021 at 12:38:06PM +0000, HORIGUCHI NAOYA(=1B$BKY8}=1B(B =
=1B$BD>Li=1B(B) wrote:
> > Thank you for shedding light on this, this race looks worrisome to me.
> > We call try_to_unmap() inside memory_failure(), where we find affected
> > ptes by page_vma_mapped_walk() and convert into hwpoison entires in
> > try_to_unmap_one().  So there seems two racy cases:
> >=20
> >   1)
> >      CPU 0                          CPU 1
> >      page_vma_mapped_walk
> >                                     clear _PAGE_PRESENT bit
> >        // skipped the entry
> >=20
> >   2)
> >      CPU 0                          CPU 1
> >      page_vma_mapped_walk
> >        try_to_unmap_one
> >                                     clear _PAGE_PRESENT bit
> >          convert the entry
> >          set_pte_at
> >=20
> > In case 1, the affected processes get signals on later access,
> > so although the info in SIGBUS could be different, that's OK.
> > And we have no impact in case 2.
>=20
> I've been debugging a similar issue for a few days and finally
> got enough traces to partially understand what happened.
>=20
> The test case is a multi-threaded pointer chasing micro-benchmark
> running on all logical CPUs. We then inject poison into the address
> space of the process.
>=20
> All works fine if one thread consumes poison and completes all
> Linux machine check processing before any other threads read the
> poison. The page is unmapped, a SIGBUS is sent (which kills all
> threads).
>=20
> But in the problem case I see:

Thanks for the description, it's helpful to understand the problem.

>=20
> CPU1 reads poison, takes a machine check. Gets to the
> kill_me_maybe() task work, which calls memory_failure()
> this CPU sets the page poison flag, but is still executing the
> rest of the flow to hunt down tasks/mappings to invalidate pages
> and send SIGBUS if required.
>=20
> CPU2 reads the poison. When it gets to memory_failure()
> there's an early return because the poison flag is already
> set. So in current code it returns and takes the machine
> check again.
>=20
> CPU3 reads the poison and starts along same path that CPU2
> did.

I think that the MCE loop happening on CPU2 and CPU3 is unexpected
and these threads should immediately kill the current process on
each CPU.  force_sig_mceerr() in kill_me_maybe() is supposed to do it,
so Aili's patch would fix this issue too?

>=20
> Meanwhile CPU1 gets far enough along in memory failure and hits
> a problem. It prints:
>=20
> [ 1867.409837] Memory failure: 0x42a9ff6: reserved kernel page still refe=
renced by 1 users
> [ 1867.409850] Memory failure: 0x42a9ff6: recovery action for reserved ke=
rnel page: Failed
>=20
> and doesn't complete unmapping the page that CPU2 and CPU3 are touching.
>=20
> Other CPUs gradually reach the poison and join in the fun of repeatedly
> taking machine checks.
>=20
> I have not yet tracked why this user access is reporting as a "reserved k=
ernel page".
> Some traces showed that futex(2) syscall was in use from this benchmark,
> so maybe the kernel locked a user page that was a contended futex???

This might imply that current logic to identify page state does
not work properly on this exotic type of user page, I'll take a
look on this from futex's viewpoint.

>=20
> Idea for what we should do next ... Now that x86 is calling memory_failur=
e()
> from user context ... maybe parallel calls for the same page should
> be blocked until the first caller completes so we can:
> a) know that pages are unmapped (if that happens)
> b) all get the same success/fail status

One memory_failure() call changes the target page's status and
affects all mappings to all affected processes, so I think that
(ideally) we don't have to block other threads (letting them
early return seems fine).  Sometimes memory_failure() fails,
but even in such case, PG_hwpoison is set on the page and other
threads properly get SIGBUSs with this patch, so I think that
we can avoid the worst scenario (like system stall by MCE loop).

Thanks,
Naoya Horiguchi=
