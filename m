Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBF44D534
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhKKKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:45:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:59528 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232922AbhKKKpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:45:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="212925690"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="212925690"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 02:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="583309621"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2021 02:42:14 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 02:42:13 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 02:42:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 02:42:13 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 02:42:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd0+xXnHdAbqD9AvfN0ZWRu3vgQKMNuLIi7PRtcBOA4phJfTs6fjazvZ5eyAU9ubkacoC3fipI89zkaD5Md3o5DzJ6AgD/4PLPyCmZu/qJAYbL/SMkNPQt+IdSyNG0dWOkfQM4Ie6W4iUj7JkN95ZVIZvvDwTc2qRIdhYnLmSAzdrPLgDGrgZ6iFCxvgBbCrzo9/BOXNaGfoM7uJOYf3GY1OQYjtPdytyxlbkDu9X/YbwUKoC9RFbHDeQpCajT+KzF0jlrOeYHuu2SYI0qTrerfQ9aUkICrAU5lFOss3Ux7R9tG90WgEw+2qNo/U2ABz15rOCcY+C6SpCllesQiceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ0zp83//tQMYu3nmqkJqwjwgBz189G6d91NlQvY6Fk=;
 b=fPI+jm5mQ93M7VxX3YdGHH413hoLZec08tb1FxjKA6T7SXUp5uRaoN35AscyHfI2PxvaO1XSaYPAntHTDMhb/wBZC9Bo5kQtJu3YGnnR0mf5egABJQJJXLvyGg70DOD23e6PwzKu/xBsZj3eOZN8NPY6mVgGGargD2GAz5kM761qUloVLReKOQvAQBEJ8kb/dxQV9iwclHAv58+okQQcenn0AK8TZZqugAVmTzkfCYoNPm88SqUMS1c8OHNq8GeUOCcChgMJsxGEJkF646bEBA4tXTnGd7Rk79tAH+sP6+5JUhdbM98YXaaBmNQmdTRrlMqrJE8muqCSvq6SikwAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ0zp83//tQMYu3nmqkJqwjwgBz189G6d91NlQvY6Fk=;
 b=NjoTg8OI2bf6v0MaCuY8O989Biy6nprfAd0UdSIzYU0MIIRIG/y9aIwwWdKD98pQeReXKfi3JzwBvZVRX0iddBFaLm3/TXg9crqWKhX0Vn6wZW0T5arA5OfQ3faNmPZbLwTzbXTlrAkcHmpj2whstbzmkMhCvhcsplZ0/0M4ryM=
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by BN6PR11MB3938.namprd11.prod.outlook.com (2603:10b6:405:79::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Thu, 11 Nov
 2021 10:42:08 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::90a1:220b:beac:ac75]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::90a1:220b:beac:ac75%6]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 10:42:08 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHXo04llJrmCe8xQUyA5dZSwoZB/Ku29+AAgEeN80A=
Date:   Thu, 11 Nov 2021 10:42:08 +0000
Message-ID: <BN9PR11MB5545F024ADB86394FED085BCF1949@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20210906183621.21075-1-shruthi.sanil@intel.com>
 <20210906183621.21075-3-shruthi.sanil@intel.com> <87lf3jaubj.ffs@tglx>
In-Reply-To: <87lf3jaubj.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56022bbf-f737-416d-c1ab-08d9a4ffe959
x-ms-traffictypediagnostic: BN6PR11MB3938:
x-microsoft-antispam-prvs: <BN6PR11MB393825F7E0CA0B11D62E811EF1949@BN6PR11MB3938.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8khLh+H6tPk9PCqS1TJXX6K+kje2+VeQL4j7Pfc/v/ktHdxxlXvu734Eo+0456YUQsBGxOPT4BSA/J0kYDWYRM02K3BbYXkhUPILCAZdjw5dyZcIkX1Lm/cEu1e392rrPDXaE11dl23QqcOeI6jQyUGMyP7IYi3yeL7J4N8AlVWOZSXQ6vWnpTDeZUAizRYd8ds4wQKDlldpB4vZjcXns/Sq3Mkyl0cXRQ2QkptkUMvdT6ZkT9DBiFbPGYY8/0SUs6YS9gKgYxocLmUjzJ0LFgJO/flKKsnaVE9y8Gh+1pwACxoh26xKrQ7LNtvBi5f2UBI2eundlevTBQLtuiOInnm6+7iS0GIso4B6Y8jgwOHrBTY1e0T/TXjLmAM8fhRcLXPpnWMLuqzF2xR5n08PsqevD7P+Thxr0TdHjAxxKML+koET6yyxqriyUSZv2w58lJRB0A/i8RrgvhMoagG/EG9Ud+8DL2lPDjspZNMjhp2LNLRL7aoITyXXejtXk+CSPEI0QfXuLB/B4m2JnXJzPc2AtKT+nrL4QNA9w4cQD/SQbXZcWhRg7TW5BEsWrd+z2p/ujIuuwvg93Sy7EFltIZX2T/dyaEQ/6rJfFyCDiSuIN3DwyZbDNZ9FGP0biKs+x+PVyvusichpFpf58/M084h/D8PtGX7GuXni844Jf2FYxtreX9eKQ6ATJOAP6milk0mjcENdrPkE8HG07nzDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(52536014)(4326008)(82960400001)(66946007)(38070700005)(6506007)(83380400001)(86362001)(8676002)(186003)(76116006)(66556008)(66446008)(8936002)(66476007)(38100700002)(64756008)(53546011)(26005)(71200400001)(55016002)(54906003)(110136005)(9686003)(33656002)(5660300002)(316002)(2906002)(508600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FA5/nvIdSGSYM53oHAQF9RxE7QYxO5tWFMXCy3Q2zKlEJowFazPHNzV7PYfV?=
 =?us-ascii?Q?x5kUuC+eDwYyYVlCIeXyzLLMb25RftAqkLsr79n/dOuYqIQQTeU71TdJC7BC?=
 =?us-ascii?Q?oElJ2gUI1WL9BkEGaK7INsvFeii7UbwSQCZ1RPSXOvEqbSErZ1yZoppNIuZf?=
 =?us-ascii?Q?Vn0WMHm7+Z5sSO7a3ieDkTLQcri9bl/dneMW67eRsKeo03V/zEzg5hceFtJW?=
 =?us-ascii?Q?E3DWKBITTgGaQbuoJvOEejJsb+iil1sIeSusLCh61MrCqQrZGz9fvQFeSFrB?=
 =?us-ascii?Q?Iu3INQTDYEVHLrnUm8JJO5S7qWeD9kYzKMW5W26AlM1U4v+bxKcljqfTVr5G?=
 =?us-ascii?Q?mCauOvUXnb3qdjE3orLkmQzts6dXKjCEOiIpUWwBJqYr0X/w0HsF1sjbeZ76?=
 =?us-ascii?Q?UWm/NdTNh4m25AnXNuoYoeSKWSKf8D5oBT2IMd6lcEX0Ye5W6nqu8z6tTeNC?=
 =?us-ascii?Q?W2/aF6hk0gKz0V58niUWPc4JdHsDlM953vR5xbXRJK6ELmjTJg7scCLKcOpM?=
 =?us-ascii?Q?crMqZyStec704isj3FAI5Tm9uHinkj1vZudp8Fjm5m3QvCxmJf/FPFeUaF1y?=
 =?us-ascii?Q?Uy9znpHIs9Cz4GpodQYlzPXKufX+R68QRp40Dp9h3ndeBSzR1rKj6j0WLBRe?=
 =?us-ascii?Q?TrEo/AoLAVoPy/BA+C2ubD+ghlDVQ0D9Uc05fRApBZhuwHyFT+iQS7UtGOi8?=
 =?us-ascii?Q?GWRrfLeOw6SdZcGt/tyN/1V4byXnUiSiPm9O5cvw+R4E7buFDDqgUe/JGftd?=
 =?us-ascii?Q?b8iwffqOxpTBCy8k9IrekVIHYfsCLSd+UFVseYJEQ3bUYcoiCcG9RAf8aY1G?=
 =?us-ascii?Q?zH+/bbj0U7LXkb5ozEbXLWFOQY4hGFoS76FjjfDBEwXpopiMZw9V/1qPY4tR?=
 =?us-ascii?Q?Uuq3kQJql4MDzMkubA5yfJfXfLlCnjwxNFY+OLhhACbLrB5qrYY20KygpB8X?=
 =?us-ascii?Q?dj2WQbkXcIR/8JoKHqz64DlcLeLkED+9SOchE4g9OLtuTIQA68p4yI4VG1Ep?=
 =?us-ascii?Q?K1iNnkxOyxmoGEJHfGKcCI9YW1P36TgaJfzEkh3GmX+JLw405D0+bd42M9KP?=
 =?us-ascii?Q?pOjkdd9cxNW4kJhknT2+z1oqnz5fjdwJugHQ51QvKSXVk8XGgmBEc1R9ca13?=
 =?us-ascii?Q?KdvxpEwqCy4pFZ90l8rUH336MqnDvDXgqAxUCzFfYVzuaDzVk6p0DxRpF5Wp?=
 =?us-ascii?Q?xbkdGRPTPctnbLwtUmLL52YE0/rogqogdj8Wn38EqOW5xl3I8RcYUbEdjwPP?=
 =?us-ascii?Q?YchBd4fA96h0k938WwzqZ9M4k+n6Aa1P9IJ+uMLLwsvu/tn4qiehyBcRqjZH?=
 =?us-ascii?Q?dlBNM/9ExbrAcZJ7lLSEDR7LihvDJxJzlNwtXuiNF2dCu0v+mwUdGCw65Yuw?=
 =?us-ascii?Q?Cmh23pgjK/6b0beJpJJyDNaFgKo7MIMB5iBR0QiUxqXrZIO0LsoG3jvZcPaP?=
 =?us-ascii?Q?rK9TtFbXMoA1os4i2KAib35FCa+4c4kvPmkZuGyFWk8gmOQxdXnaSEGLBLBy?=
 =?us-ascii?Q?/HXMFQq0jLVPw+5vCKlpiKrptbdZwImDa478c8hu1OCn35GWIa/Pl47CUezi?=
 =?us-ascii?Q?PmQ2ydenGT2uvPjLcb5dyAQVdeZPF425VHl9gszAtcU6WuSA4y9CXpW64m2e?=
 =?us-ascii?Q?Ngax5prrT8TLkhShBy6KAeY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56022bbf-f737-416d-c1ab-08d9a4ffe959
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 10:42:08.6532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLfKNA8u1UcbPazTj9EKfboPInB/TKfNLhDpR+22F0pbh8P79XaJmraTbK424l94B0nJUy+t22/zu5YSU0V9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3938
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Monday, September 27, 2021 3:11 AM
> To: Sanil, Shruthi <shruthi.sanil@intel.com>; daniel.lezcano@linaro.org;
> robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> Sanil, Shruthi <shruthi.sanil@intel.com>
> Subject: Re: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
>=20
> On Tue, Sep 07 2021 at 00:06, shruthi sanil wrote:
> > +
> > +/* Provides a unique ID for each timer */ static
> > +DEFINE_IDA(keembay_timer_ida);
>=20
> > +
> > +	timer_id =3D ida_alloc(&keembay_timer_ida, GFP_KERNEL);
> > +	if (timer_id < 0) {
> > +		ret =3D timer_id;
> > +		goto err_keembay_ce_to_free;
> > +	}
>=20
> May I ask what the purpose of the IDA, which is backed by a full blown
> xarray, is here?
>=20
> AFAICT all you want is a unique number for the timer name for up to 8
> timers.
>=20
> > +	timer_name =3D kasprintf(GFP_KERNEL, "keembay_timer%d",
> timer_id);
>=20
> So what's wrong about:
>=20
> static unsigned int keembay_timer_id;
>=20
> 	timer_name =3D kasprintf(GFP_KERNEL, "keembay_timer%d",
> keembay_timer_id++);
>=20
> Hmm?

Yes, we had initially implemented it in the similar way,=20
but in the course of review it got changed to use IDA.

>=20
> > +
> > +	clockevents_config_and_register(&keembay_ce_to->clkevt,
> > +					timer_of_rate(keembay_ce_to),
> > +					1,
> > +					U32_MAX);
>=20
> Aside of that what's the point of registering more than one of those time=
rs as
> clock event? The core will only use one and the rest is just going to use
> memory for no value.

Instead of
keembay_ce_to->clkevt.cpumask =3D cpumask_of(0);=20
can I update it as=20
keembay_ce_to->clkevt.cpumask =3D cpu_possible_mask;=20
so that each timer would be associated with different cores?

Thanks,
Shruthi

>=20
> Thanks,
>=20
>         tglx
