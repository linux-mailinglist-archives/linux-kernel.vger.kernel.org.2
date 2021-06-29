Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D038A3B786E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhF2TQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:16:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:62760 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhF2TQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:16:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208166336"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="208166336"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 12:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="492803485"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2021 12:13:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 29 Jun 2021 12:13:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 29 Jun 2021 12:13:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 29 Jun 2021 12:13:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 29 Jun 2021 12:13:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akDmXKpjZs0R4nJvMqNf/wsKI0ZnTJ4MZq9Qt6ycOty8RaVwt1FbgNlC68GYFnVqzlQn5p/VgbOLmIBuASH+c8aOYljelUmzf6hexW2h7fZaGFZmvadKfGTTnq1WbQHuvrlcnBeDKDM+H+LCB+xD++x4Sw0tslKsUtJinANQ6Ymf8cFL5t8jl2yucO7r9Tp1TQvU2CaG9JfhO0dqN4iAnTDUEloi1OJA+qjFHRPy7PSPkK4PskkKJvb0VQXbyBP8ykIS/kQ8kNQ/SDbUIxfoTq/yBUlKwOhe+3lqRjwWLu7ChTyF+Dsp6G32bnFdVEgdZtzYvpA4C875HY3FghN8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL/0M8eoioXhza+wWnR5b1KD3AXssHOwXlswR0GmLs8=;
 b=eMoUW46TIWmXROa8IpSRwCjbD7Tn3EBcBRWxp6erDHtMuy4ZmFgoal0K7nW6WOm0PQiUjQAtWAZ1sdM0ARlZDIfcwzkirLRTLGaaLKZb7ssN6lc/sjKR6brMQzQKH3jyIHDvcNrBkm/JpDVUgeKuFjS/I64s6+ChxLXnqR7YknOHxAswreXlwtSNFsjH80GN1YGF7ROz68lSahBozwYAPzW0rg6fpDiSwlhB+/BrLa2r74lChD5pMtUoLALDcfbgldUMy9dUnb4wIHVZHcNoOxCOoto+wzREemRxHTQgrceRrsHvjDN+ppMH+v6c3barx1Ji2mXus/kA2u6i9WYzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL/0M8eoioXhza+wWnR5b1KD3AXssHOwXlswR0GmLs8=;
 b=UVK502N041vf7yo5oQJd1l+/LDFsOJchxzPHht7CycjjDfrwX1k4jRGiUI5hJqDRhF8glzIiWjnOlye7Vsq1nt4h8uHV+lMX8M1lJnbcHp5rkd98V/hKwHpj48fjLSKH4HB7qEMJ9YGiSGmVRwWYazRTzdrvNhFSWxwOBlV/e7g=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 19:13:45 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 19:13:45 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     "Lutomirski, Andy" <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Topic: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Index: AQHXUAs71FpA6GLTCUWvxGMv7m3G8KsW+QQAgAAdOYCAAAnJgIAAA/+AgBRYTYCAAAMZAIAAC5mAgAAESACAAAZfAA==
Date:   Tue, 29 Jun 2021 19:13:45 +0000
Message-ID: <D147640C-0248-4934-8F11-69706E0EE5CB@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-15-chang.seok.bae@intel.com>
 <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
 <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
 <36D0486A-D955-4C32-941A-A2A4985A450C@intel.com>
 <48e86785-838d-f5d4-c93c-3232b8ffd915@intel.com>
 <3AB6DECB-2A53-4EC2-84A6-0CACE44CFC1C@intel.com>
 <6754330a-bbbb-aa29-7800-f2d16216ad8c@intel.com>
 <406DB587-F598-484F-A128-990E2DB6EC78@intel.com>
 <842d8e8a-44c6-a8c5-c580-a77fc52d267f@intel.com>
In-Reply-To: <842d8e8a-44c6-a8c5-c580-a77fc52d267f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86c4cf9f-5de0-4f16-de66-08d93b320441
x-ms-traffictypediagnostic: PH0PR11MB4903:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB49036799E01560A8F1BA42B9D8029@PH0PR11MB4903.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WzeWhTe4vJoj6+4lkTP5GaAMW+Kovay/NEl1BfLVnpqesMelJUYmAABLRSMnVr3AgYZMZsCWHuusDhcLxxTLYstblvnxL/3arHK/jlM3+dgMZhCsd7gj+6Z+cWCBi4dTdpws51prB7/U7ueAnrny+XCYNSY7Munirkj08tVezLppPYOj89q2ggxT+vCCOfTDCIqg+OX2RGebu3qd4JznaXMWxDPH6iqTLPEnBJpRcra4S2v1hziYob+bT/ODhjXCHBUwq21433/tWGaeWlrYqKiGjSp1TaUruU8647d5Vk8ADJof1aD8/8Bvb4MUOF+AHRcDsgav0KjabHyhnzEfi3CZ/we/8/UKd4n5hK1jhils7GA+q9n5wS3gKtykc++/bmKZ/9qBEpBTQQDI2JWp6BVmlBbAFm6z40vDbW1IE1aLztl5eYO3FIh9QiyZwZG9mOLRcfniM9MNleeY4KJ7l5grdlcchIc+aYqkHbUsojfInNkkReZxpd7U+QWdqMZ34sCW5PtHowuix1yllshNscOLhxjUQAXlt2a8ZiP3MQjM3aAMEuNs/gx9qaF7r2Rtz/s0fIlUT1hfAOIGe2UHn6GO8stAEq2yYbaWqJdJX2XFmxx3i2AefAM5YRrOKm7NRJdph21mp/P6WLv69VGuS2N/DHrPDYHr0vhkesqPesEcU5agVVQ3NdG5k+MNQBAoT8ikoWRzFR9tK1qETTTyDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(366004)(376002)(346002)(316002)(66946007)(66476007)(6486002)(33656002)(6512007)(71200400001)(76116006)(2906002)(37006003)(6636002)(64756008)(66446008)(8676002)(66556008)(478600001)(6862004)(8936002)(54906003)(86362001)(2616005)(36756003)(5660300002)(38100700002)(83380400001)(4326008)(53546011)(186003)(6506007)(26005)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?85MQ5xNrL+FXh7vZzEgYWJHfiWIx0/MHSRXM+vs5OIEVwAuIaCmRVXoaCZYM?=
 =?us-ascii?Q?ydVc2uF/NpxAhvH9HLg7EPUljmRpFrOsCBljSM/TjF7CdmHmUzyJb5eUQYey?=
 =?us-ascii?Q?Q46Htzqsnw6ZAE1AukneHrPioHVVo5JtaaYsI6017Hjk2R1lwzG3CfUsenxF?=
 =?us-ascii?Q?vuZq7XL0XmPYzj9CeHGOqok91EBojT12l+IFVOosPEL6Bv4+5zMHBXilKiQs?=
 =?us-ascii?Q?ipvd4EkbZBMh6/pffONSfrcSE+fELvrqe0/1dozDQEPF9Q+Ot++gChAabKTh?=
 =?us-ascii?Q?wmQr1RzenWcOzHr7UbfbfT8hmdyhg2OLrNxNJpGSj9iTKl8vM+yq+Uz29hl6?=
 =?us-ascii?Q?gZUmQb/CzlKFLGoBjufAs+teNzb5358aS0ZwR5NatdDozLDMwbYHaJMqbFF0?=
 =?us-ascii?Q?eoxo/k606LAAHXkmRieHgsj6IqMX66giSQ3di3XAKa4ztIVC4p1siv8BRka4?=
 =?us-ascii?Q?Dfepwf4Jwehcg3BDn3n7IgYeg0a7jVPvTQ1jY84uH7GDwdL8gncqUstKzBRw?=
 =?us-ascii?Q?DQ+b8OwkREXuKf4Xileepei5aaY4tPG0jMKGwPaQhq7D5JoCPcJT0ZUPMspv?=
 =?us-ascii?Q?yYQ7G5tkzf2D66jTWUHj2Fk8Xf1skCA8qCFTehj7IQcHYm9G45KjkF90zFWu?=
 =?us-ascii?Q?Z+XSqKxL9o7nZlc0Z5UyGdaqdKgqai1P3JEG4CgxzSLZCn8xI68u6yN/JvPP?=
 =?us-ascii?Q?o1GuHzDTxVbvvirDYcZziSBwE8eARYkmDFAIb/0F0Cc/UFkVEJypYrmW0X7h?=
 =?us-ascii?Q?mU01CApNUUN50m2RuMpLMW6zrYLMUlZF69Q/XLMZ9MRVENygY86aB/qdniix?=
 =?us-ascii?Q?k/nwwKbjk7iaxuxm1TK6ZXhmcnlNpenj6lGDIo/yxUGS5H6QwGieX8p8kF8U?=
 =?us-ascii?Q?kr0rAraPr/NqupPfAAVsm1iDJrC3GFCfVhHaqqmxpNuZMPBYrLUUG/ApqDy4?=
 =?us-ascii?Q?qYr3okr6W2VfgMPbz17dSkNHdwRrbGSqGCCydGhLNZMRUck5OXSxMeiDmD/6?=
 =?us-ascii?Q?D40jYx1hZCIR6/nNRaTwll06LvVJX0hOnu5L2ToRFryTQ4oCOQODIOzCCzJ6?=
 =?us-ascii?Q?wmylHDMR7suOLfFsRibfRXFcG99PJ2jimSiZK4aAhKyiWEdpakIN3VEfYQqr?=
 =?us-ascii?Q?tIP0eBlvu+I0Y3obqYYxMSdhHu48gnKCm1y2GrE0hzAtY/Bbg3XaVsrt/EV6?=
 =?us-ascii?Q?PaOl7grcY4kPhLKi0ALCRF7JbZ+s8R2crzy8IxPnfEEjDbjWg3uhWSOTeqK1?=
 =?us-ascii?Q?kOTtLYcjt/gk8LNoHjDtwQkX4ox8IkUJ90EP7Ln0mggFUjKr8ko2YOMCGEbo?=
 =?us-ascii?Q?dYfT6d42CoamfK/moe4OhakxUj6hE/k/2/l8Zy9lV6fFMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D93BE15DE8F02B4693B155FFC1753FF9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c4cf9f-5de0-4f16-de66-08d93b320441
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 19:13:45.3921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrONXjqPNG7AgsFQ+KousXUsKgIhWvh0EXtpYijLJ29mDNT+39PQ957kT9PX7Y0im1GUieOn9X0LrEjPOnyMdJyftpvHUd5MK44mtCyuRwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 29, 2021, at 11:50, Hansen, Dave <dave.hansen@intel.com> wrote:
> On 6/29/21 11:35 AM, Bae, Chang Seok wrote:
>>        if (likely(use_xsave())) {
>> +               /*
>> +                * MSR IA32_XFD write follows after this XSAVE(S). So if=
 a
>> +                * state component is in use, XFD should not be armed fo=
r
>> +                * current. But, for potential changes in the future,
>> +                * cross-check XINUSE and XFD values. If a XINUSE state
>> +                * is XFD-armed, the following XSAVE(S) does not save th=
e
>> +                * state.
>> +                *
>> +                * Reference the shadow XFD value instead of reading the
>> +                * MSR.
>> +                */
>> +               if (xfd_capable() && boot_cpu_has(X86_FEATURE_XGETBV1)) =
{
>> +                       u64 current_xfd =3D (fpu->state_mask & xfd_capab=
le()) ^ xfd_capable();
>> +
>> +                       WARN_ON_FPU(xgetbv(1) & current_xfd);
>> +               }
>=20
> The code looks fine.  But, as usual, I hate the comment.  Maybe:
>=20
> 		/*
> 		 * If XFD is armed for an xfeature, XSAVE* will not save
> 		 * its state.  Ensure XFD is clear for all features that
> 		 * are in use before XSAVE*.
> 		 */
>=20
> BTW, the ->state_mask calculation is a little confusing to me.  I
> understand that fpu->state_mask shouldn't have any bits set that are
> unset in xgetbv(1).
>=20
> This code seems to be asking the question: Are any dynamic features in
> their init state *and* XFD-armed?
>=20
> Is it actually important to make sure that they are dynamic features?
> Is there *any* case where a feature (dynamic or not) can have XFD armed
> and be out of its init state?

In this AMX series, XFD is only used for the xstate buffer management. The
code is made in a such way that XFD and dynamic states are a bit coupled.

But I think XFD can be extended for other usages in the future. Then, yes.
(This warning is also for future code changes.)

So, reading the MSR is just simple and clean here, but it consumes cycles. =
Or,
a task may have a field for XFD value per se unless this conversion is
acceptable.

Thanks,
Chang=
