Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3A3FBF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhH3Xkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:40:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:4224 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhH3Xkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:40:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205589070"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="205589070"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 16:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="498015350"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2021 16:39:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 16:39:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 16:39:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 30 Aug 2021 16:39:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 30 Aug 2021 16:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMnVPQOKL5r8Xm16/xsraxGePEg3zXEDFAjZMO5n9H2ZvqxuzAeiL99foZImPe6aqpQNnLD1UIAE7IneJb55Hn9JTFj55OEiT3/9fArPY9fQj8c7TFRxjS2HH/dAjcqjShqgbVIh/lx+H6CjdYOMF727779Qv12JPUOZEm5Mfqb4+v4sJP+urpDhboWvok+h0fLyPzVvyUUgvvMw0fsasMRLTAz/Dom2tvEnxOYrp6FjNf7Jhx4dRb431j06zuh9VwO2DjepgmV1E//7ahyykL1UhxKubVHInF7Pn6Kagi45OM152X+xQ6VsxZ2ZVKt86F5N/x+ktovHWVYDQLh3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWdo9xD1q1Ieo9kQ1Ju5NMfGiZG4XE9X+Hg4lxjSvKU=;
 b=X+e0q7K/dnTcpbSDfVs1U2FoAeq8mHb7hmIcB+cjjHqAPpaO35DpE3UtNJyQyv+FZG7yL8zfKEzsE08AyzD9rHYPjHAuBtgySoJrcSjOVm/ibpi0rp6fjLoZ2elV9BBjf31f5Pkdv3QBrOZ0HclzZ8BbjuPURP+CSCJYbkBB64v4n5sHMXBcA3mqWL5RaVyRmSV0MQW12O07o8z+gUTxqPRIz+KzqKwa9C2jFb4ReEhcnRVvWkleM28whufPofH3PcKipGfwtB/uMCox0u5Kukdo/qNs98WY+RQmR5iwfWy1Rh0yE5tPnpy8W0Emeun9c/kMTbaumcPIcnanY9lX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWdo9xD1q1Ieo9kQ1Ju5NMfGiZG4XE9X+Hg4lxjSvKU=;
 b=zOPxvdrxOhwYHM8Bk3kbHjpR0hOIwYx+AqwsQuVDtEmOa3mZ0br0hw4KWuRKSbhDHZMFLtcWVXWP/bpdzMLGISrc6XDDz1b5gqGh/fh4JIo5nf+5KhPrs+vCUw8q8B0qd3ybT7m/qwhPZHnIe8XncrWL/eY6cNiv67WRDEBC5Gk=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 30 Aug
 2021 23:39:33 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 23:39:33 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Topic: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Index: AQHXhVRxstI5EaBny0+yAHwtQ/jrKKuMguIAgABjBIA=
Date:   Mon, 30 Aug 2021 23:39:33 +0000
Message-ID: <2FC84687-9F89-49E6-85C0-448D3DAF201C@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com>
 <bb49fdc9-2228-8bd1-bcc5-7c498daf0887@intel.com>
In-Reply-To: <bb49fdc9-2228-8bd1-bcc5-7c498daf0887@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aac83c2a-4652-4b6a-cded-08d96c0f6b81
x-ms-traffictypediagnostic: PH0PR11MB4967:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB49678A94EE4D1B16C247E37FD8CB9@PH0PR11MB4967.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o/+cFXqRrxlAgqWEQB8KDXVMSnYeIU1S4XdeBRku0sdsIV7/t09NO1EMOWYXd3YH2ERePNoQGE7QXiLZ4bgw3nI564hDCtBzPX+R1DrYl8BPKGpK30ZWbJ/+x/ae5LoSqSAchOArMAohAFn8sP/8zxB2+210BDKFy4c7Y1revYRTN9BG34Vzw+IkOJWbeBvRnCUQRYlAyBdMv8pzEPBZHTvKWhOOzsrp8qJNwEKQju+faHp4ca/GdH9Ae6sMjAErp8sNsovTn6rEYymxv8r4qijFUQsDKTmEFB69p2ci2aSQZGxGVwlUdhuVJEuG8oQ/jP9ythE6/Fpdg90RVsuQEsOz36OPio8NLUhjAMm1Vg92zWM70LfzbGGZYxUY9IbqRbsW9CTGd9p2f8/HOt5VY7vIGQad1BM7SkXaGwPUtJG7s3PsniBPxj6bI1eLgB3H0UwA2Ts8g1kZjJZQB5ltYb8FyCELZgXwkFa9qEwiqEsdwRpsc9TSeK3CzSCLp2Bu/0Ryr/cvTseiZNafHLHzy87920xIUehoORzw1vSEfkISkuX+N0TSG6JlUkTgEgzwcghrStb82ihBgDhPOG8aRFL98i6noNnXZSFdjMICs2zsYcwvXhoggt/NjGcL2cD0Dpp5yJvwrqChMFX2xhUPalDi7z08S82XJAKFX2VQ2JKMfYJUYz+2QJ6ipRqKM/omfteiZ+AY+4izX+g7ec5WYxB/j1QG2VLl2uYRtDjBJdgJBCxGsZLbaTHoIWArEghXokPHoF9oln7K100KjgfpNB5Me9peK4lknBy9GDl5hJ9nJOPupIwZUC4TOBjyMpQi+tqMm+gk4XEyOlHo8ugZp9eI1wv7G0izD4ORi7n0SkM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(66556008)(38100700002)(26005)(186003)(76116006)(66946007)(54906003)(4326008)(6486002)(64756008)(6636002)(53546011)(33656002)(966005)(66476007)(478600001)(66446008)(316002)(5660300002)(37006003)(36756003)(6506007)(8936002)(38070700005)(8676002)(71200400001)(6512007)(122000001)(6862004)(2906002)(2616005)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V2WZVO/fiju66RBU4IpvqdAgenjasyae8IYYk/Yot8X3QzABHhn6rZ7tWiia?=
 =?us-ascii?Q?B6yCRsTlxEQFcgKf4/76tzC4lWANM7FfaYIoJhwaygf9jDGTe9EYTL7H2Fno?=
 =?us-ascii?Q?TnqR1MPMTcS3Tnuvx2TaqVQQLqE+mAFZWRaKWmdk8HnRtMo7zpSZBvlswDrB?=
 =?us-ascii?Q?PbGnDdvXbkGD4z9hTl3xtDdDoSsRfnKLuCSwwjRhf132xjF8VuSz5Uf8nr1v?=
 =?us-ascii?Q?FTMkjhJ1qg6ENdGwq5BFjxKzE3FNqIo/zrmKhWYnNAAXhwZvLAQ08a29b5us?=
 =?us-ascii?Q?b7tPBW2NbsY6lPu0pcUSvg7d6XCikF+FMVNgD1LW33as4E42iB0lKP9alx15?=
 =?us-ascii?Q?Zqv752KYviMDIAe6Sgb6ZEL6L1mDj4Y+vVjJ/6KsQUhbYe0ozmXgGzQor2if?=
 =?us-ascii?Q?hIGlbGsQMj9Z4if++j3NQJjWgjYdRw+Ulo08Sbo6eetlw0jZcSgMw0qSkfq3?=
 =?us-ascii?Q?WvQ9eOlpouoxRnf13tdAR78k9+fxS3lFqtH/GlEv+Vnk7r0cTg9TEV6M/5u0?=
 =?us-ascii?Q?lHepMXpHzJZ5gCdC1415tLEdLrq2pL0G3gKhDU+mQ7EWPaFxVv4pwkTNUjxV?=
 =?us-ascii?Q?LjDMvEQf8bl5/4eS4U04iDHlv92qOIn/U9AJaoUgBUY4UrftKhHa8xijNJ+i?=
 =?us-ascii?Q?k7S1qU/VL+T3Ow79CBub/fBfoyFohcLJOoDmp0+uYn4mx+a9q/4J6vGztIME?=
 =?us-ascii?Q?PF599wZobTxiEa5wz2d8UtzT5MyCzV0sOAm1gB9DZN5ldC3lZaQgCsZUZPA/?=
 =?us-ascii?Q?5hi85IGAcRfDIlUUi1EeWeUpF17feSJoOGEsXSOgN0DggsuJjbrAc/JStj9e?=
 =?us-ascii?Q?1GpvtCpIC9ZsbfboayGRnlOlRJP5TbRgDsDg7SzUaws+kFav71Rrq/533Fib?=
 =?us-ascii?Q?TDEr8K8DDxccSBvqsX+Vr2Sryl8A2DKchtxX19eRfGeUj0VmJePnKspNwPH/?=
 =?us-ascii?Q?mHuOo+sq6s3MFmtA3N8xZRXaMP7pKxIa7uiNwzNAd8GVUdUnwyVvIx/k724S?=
 =?us-ascii?Q?jO0QxGLyIrQ6rIMH5rLKj9tF5bXWzRv7hNSR/nLjiXicVEo2m1mh/taenRlg?=
 =?us-ascii?Q?zZG4ouXQr8tQW0A+m1gd+HPUOx0NpvZz0nkSwN5+zFz8zZlwNy1pMko4+IZB?=
 =?us-ascii?Q?XZ3H/69Hz+Ovks714gxThDydP4DTQHs8gBExZjQKC0gEiU0EXFLH+99HufC7?=
 =?us-ascii?Q?gxhI+M5H+jsnbjF3/QGHw/wbSo9RwgWIr7asRhmjPuqbsyfn1xzkNnKXeI4G?=
 =?us-ascii?Q?tjCXU6m1tk5p4VOrYYZ8PdkGO810T/wkuicCnNvonOmo6OVdwzzsaj3wH/EV?=
 =?us-ascii?Q?hw+Q9B1XHN+PIEuZHA/5Lj/m?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <817C36672BB4E440BE9EABD328C77B9D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac83c2a-4652-4b6a-cded-08d96c0f6b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 23:39:33.1612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2e/J/icU6NpgaXgFTiEgnqivIQoj+bND73kpf5DyOb5YfoFrEZ1R5YVVKgfCnFfKgosaHGqYOv3StDY/gYYblpT/S/Fsyrvw+59e/Qj85HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2021, at 10:45, Hansen, Dave <dave.hansen@intel.com> wrote:
<snip>=20
> On 7/30/21 7:59 AM, Chang S. Bae wrote:
>>=20
>> +	/*
>> +	 * The minimum buffer size excludes the dynamic user state. When a
>> +	 * task uses the state, the buffer can grow up to the max size.
>> +	 */
>> +	if (mask =3D=3D (xfeatures_mask_all & ~xfeatures_mask_user_dynamic))
>> +		return get_xstate_config(XSTATE_MIN_SIZE);
>> +	else if (mask =3D=3D xfeatures_mask_all)
>> +		return get_xstate_config(XSTATE_MAX_SIZE);
>=20
> Is this just an optimization?  It seems redundant with everything below.
> I think that adds to the confusion.

Boris suggested to remove the below instead [1]:

    "So leave only the first two which are obvious and are more likely to
     happen - the first one is going to be the most likely on non-dynamic
     setups and the second one is on dynamic systems."

>> +	nr =3D fls64(mask) - 1;
>=20
> "nr" is a really, really, confusing name for this.  "last_feature_nr"
> might be better.  Otherwise, this might be read as "number of features".
> Comment might have helped, had there been any.

Yes, it seems to be the case.

>> +	if (!boot_cpu_has(X86_FEATURE_XSAVES))
>> +		return xstate_offsets[nr] + xstate_sizes[nr];
>=20
> Doesn't xstate_comp_offsets[] also work for non-compacted features?
> setup_xstate_comp_offsets() says so and __raw_xsave_addr() depends on
> that behavior.

Yes, but I think using xstate_comp_offsets[] for non-compacted format inste=
ad
of xstate_offsets[] here just makes confusion.

>> +	if ((xfeatures_mask_all & (BIT_ULL(nr + 1) - 1)) =3D=3D mask)
>> +		return xstate_comp_offsets[nr] + xstate_sizes[nr];
>=20
> OK, so this is basically saying, "Is the size I'm looking for already
> calculated and stored in xstate_comp_offsets[] because the mask is a
> subset of xfeatures_mask_all".  Right?
>=20
> I guess that work.  But, that's a *LOT* of logic to go uncommented.

Boris suggested simplifying the function by removing this [2]:
    > But it might be better to simplify this hunk for readability. I
    > suspect its call sites are not that performance-critical.
    That's *exactly* what I'm driving at!

And I applied on v10 [3].

>> +	/*
>> +	 * With the given mask, no relevant size is found so far. So,
>> +	 * calculate it by summing up each state size.
>> +	 */
>> +	for (size =3D FXSAVE_SIZE + XSAVE_HDR_SIZE, i =3D FIRST_EXTENDED_XFEAT=
URE; i <=3D nr; i++) {
>> +		if (!(mask & BIT_ULL(i)))
>> +			continue;
>> +
>> +		if (xstate_aligns[i])
>> +			size =3D ALIGN(size, 64);
>> +		size +=3D xstate_sizes[i];
>> +	}
>> +	return size;
>> +}
>=20
> OK, so this finally reveals something important about the function.  It
> is *trying* to avoid running this loop.  All of the above is really just
> optimizations to try and avoid doing this loop.
>=20
> That makes me wonder why you chose that particular set of optimizations.
> It also makes me wonder if they're even necessary.
>=20
> So, first of all, why is this a new loop?  Can't it share code with the
> XSAVE setup code?  That code also calculates the amount of space needed
> for an XSAVE buffer given a mask.

This runtime function uses the recorded values for offset, size, and alignm=
ent
instead of performing CPUID. The loop in the setup function references CPUI=
D
values.

> Second, which of those optimizations do we *need*?  I worry that this is
> trying to be way too generic and be *optimized* for being generic code
> when it will never really get random masks as input.
>=20
> For instance, who is going to be calling this with
> mask!=3Dxfeatures_mask_all with !boot_cpu_has(X86_FEATURE_XSAVES)?  That
> seems rather improbable.

This function is considered to help the dynamic state allocation function a=
nd
some others. Avoiding the loop might be helpful for the future, especially =
when
some other dynamic states are enabled.

V10 has a much-trimmed version [3] now as that optimization is not needed w=
ith
AMX enabling.

Thanks,
Chang

[1]: https://lore.kernel.org/lkml/YRzSuC25eHEOgj6h@zn.tnic/
[2]: https://lore.kernel.org/lkml/YRZDu2Rk+KdRhh1U@zn.tnic/
[3]: https://lore.kernel.org/lkml/20210825155413.19673-10-chang.seok.bae@in=
tel.com/


