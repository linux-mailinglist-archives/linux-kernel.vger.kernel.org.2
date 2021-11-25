Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F5145DFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347753AbhKYRmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:42:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:63767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345423AbhKYRkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:40:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="298952590"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="298952590"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 09:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675317870"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 09:29:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 09:29:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 25 Nov 2021 09:29:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 25 Nov 2021 09:29:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TocKbF4DE0R+PeSrIYlHDpNBKgACp71iQJlVEmoFWn8xwePHP67/HMP0rRaFWwDI2+XVn2271FMy1+sHHU0k7ME2D1U8cxwqZxCEOQ05Wa+7kq+VqDUwFR+uvS/hFtgvYzgUzv1/F5EWLZ/OVlVYcGQVELFADFNmzZqf/gKspqY58nKjGCWnWhTNf8ajWo80a5hznUJevbI/a3CZpO6X0XBy+u0veiud5OFZW+FQiy4AMyOyV5QBq2OhRGag5kGfTMRMb+ZbFadvf0pY6lePDXhMS+L6S65YYbY0IzTlhHqagRFFXsvPWEOeTzOMNaeuf6qzhD7LiQgP5gY572JW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqqGMZ1jw2jcJRsIYLUMtzpXuEehbLL34C36dGYlLEw=;
 b=AiERzEu+5l8k+pER0uoTnw1a/reuKf+GUhqF9swSmDtxBlpFgR90YQUQs9WSxsbzFleCPJ83v86Pn0kvEK5Er0MnsbvlNzMsGv38K/oTnuO7oLofAmLLEXP+mlwXVvhTCiYNn08oM7KhMsyUvksKA6RBfF8iz9N02Wb4CqJKWdNSQm0KCYf3gem3nZEJpQMxSYm5fyfZovq8ByouP356KYGWXlwH3qcJrfVOIBcsvOP/NvJLV3HEU4QidN5leideAioPxIOgi1Amk3zAeeWCJQcFbJB9DkuBIy59Jt2+kh6UBbmpcjGtcBQ8uVEE/xpFA78CMcZvO7ztUuU07TWaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqqGMZ1jw2jcJRsIYLUMtzpXuEehbLL34C36dGYlLEw=;
 b=dBy5mpO6lTxDMQdW8oSY7QkK4rCy/sROhPnC3nkO3VbNmfxcycR8poX+WwiJUcNC2THQDV4F1xvHLfW1SRC5IEzmJ6h6bsWJE0JFlBXaPkrglooiz7b9nSaMRXVDYt7PTqcQxNI1uzaojlIOZnGHSB8kDf9+eFmnqY03IRAQKOM=
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by BN8PR11MB3715.namprd11.prod.outlook.com (2603:10b6:408:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 17:29:28 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::6533:7d95:6f60:aafd]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::6533:7d95:6f60:aafd%7]) with mapi id 15.20.4713.024; Thu, 25 Nov 2021
 17:29:28 +0000
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
Thread-Index: AQHXo04llJrmCe8xQUyA5dZSwoZB/Ku29+AAgEeN80CAFncjYA==
Date:   Thu, 25 Nov 2021 17:29:27 +0000
Message-ID: <BN9PR11MB5545B71113E29434FB5EA96FF1629@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20210906183621.21075-1-shruthi.sanil@intel.com>
 <20210906183621.21075-3-shruthi.sanil@intel.com> <87lf3jaubj.ffs@tglx> 
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
x-ms-office365-filtering-correlation-id: 3ec9716b-6a4c-4e90-81c9-08d9b039222a
x-ms-traffictypediagnostic: BN8PR11MB3715:
x-microsoft-antispam-prvs: <BN8PR11MB3715F327BA4BDDAA6ECD7547F1629@BN8PR11MB3715.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfbxablQA0+Y2NrBGLWRE+errgJ05DHnammQDoXxqb3Dc7m1/G8ElT3r8OKNpNUa5uMo56qla27eXupn5+5F8+5NZBegfwdeguvk/gvcf+7KIp/bQmyvIlfqDKwgr1rOlifWRLi1BVx1gTpygqriCXQ/dy9mhOneherBcqVSLxfbyT75pR9vpZgrdUH/W8YcRLhClrJqXnAuQE7Ez4oAEvVc0mW/+2FAeqtbpqMFcuqULIZQukZUysaiu3kOKUuq/KfBOgqBpmMl3Dd+yqQP0Sw/g6YYbek0MVO5m42J9d7P5K8EdfsJgyiZ3P92y8F22SPnpwXcB9HXVPXyL6pslFZBeucufovzj1QHwzkYvjuB3Cmz+DKqQ9e5yGPHoY2VE2WnRpFTYi0Ah+oTT83eVGqQWtwcWu8PuVzVDebU8xMYqXBslbRk6P+XGRaf0gVWNVUai1ODQGEVsmZq11ZGOOHgaIRE29dsb9beZg8TEA6/kut0Rjzg/0ZwfhW7iu6AHRtmZTCNy5MXR8X+vTbFOV/RX9lLhJ4AbIxbhqWrD9QaLx0HQSN8OkMveIydh/HIpNPG/i3xBOp+ZeszmPFWqhUjb4QGp5AWExgmrYigVbxl0ysR5gg1nLq7VLo42dUMPsx9RjHiu9emkhHaFWnmdfG/VPiwPINW1PJ7HSdFrYn+nm112xDaGhUIssNIY0c1rWxB8b+zp6F1WbKly2IRMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(38070700005)(2906002)(55016003)(26005)(110136005)(7696005)(54906003)(4326008)(186003)(6506007)(86362001)(53546011)(122000001)(82960400001)(83380400001)(9686003)(5660300002)(38100700002)(316002)(66476007)(64756008)(66946007)(8936002)(66556008)(8676002)(66446008)(52536014)(76116006)(508600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9AD1wY90bX7Ocn8rdgB4nSjgF/bN1K6Kf6kOCHtSQtOjhdXOprFIT3M/U+U4?=
 =?us-ascii?Q?h/rzI0PpfdxJRGlUY3VeM3fNONHXegr19zE8aYQyR1AV5bc2tobpmaTY4Gfv?=
 =?us-ascii?Q?bobQSaOQhD2E0gWL/YE0nHNkM3Znt3JQ/EzVKDWWWFRJv3p4y8C31ysXK0BO?=
 =?us-ascii?Q?teyKpOPwyZmQSpAZlt9U5C+AimyEef9CziXURZdXZoxxVnnY4PjnW9cZnyix?=
 =?us-ascii?Q?pfE0De4RNO8WPIqHBSalWShV6STgTZi7FBlSporzuSsULLMsxNRowFlBu66o?=
 =?us-ascii?Q?FqOonzAjLn8UNxbuLCp4FdymJEHb6D5+ArzZaoQDP1/jtQURQukP//hza8as?=
 =?us-ascii?Q?fA5+d54W4fFjV6PXhVvjvhUiphE9skb1L0mrWBLuLnrUkhKz043/dZ94vYh5?=
 =?us-ascii?Q?mPI7hwfZaCfCkrr7+6GWh7zngNKFls2M0NxkK1eWNQthqN//QVWNx6znUz4I?=
 =?us-ascii?Q?0XkL73nmSBMr9ThHN+zlvCt774Z+eqWldFR197v0rRoFw7aV7Od2n/Bfd0Pf?=
 =?us-ascii?Q?2T46awMGENuGd6t4kPcW9IV+3OhxkKh91Jf2b/01NH+uY37qNWHJeelbGbRH?=
 =?us-ascii?Q?ArG3hRgLj0KZp/FLLlebh/QUvoYMqoTAz9saRPt9HO7QjgiPGK082QFo1mez?=
 =?us-ascii?Q?nH6nkzmyXAstsjN1sx/hF6zEzbowPe9lVOxQxZ+CK9vkvdMlbPRLVcInCjZC?=
 =?us-ascii?Q?dSwc7lB6BNRMWv4DEbdg0yMm1jI/+S8pwmoMhH381x8KKV2BTk9caEAMzOGQ?=
 =?us-ascii?Q?miTWTvXsqq67ShoCQvpqBKAD6pXC8tDgHtYXeDEg5ld6uXcvF4BmosLLXfJt?=
 =?us-ascii?Q?EcbM+lH3h2B75YSrfxVCwGVKW+sTwX5VoCxyHxVfwUuXWp08TxS4xMkvO24m?=
 =?us-ascii?Q?bCTHVY2Pz2by9kEqdUUNElnRALVnPyxDfqmn0aeS5nwatqQ5YLBFkTz90+g9?=
 =?us-ascii?Q?Iqs3nFILRVWmDDG6n2LG25r0oKsyWfztdicNtcIrxCq7EsZpbLg6Xtp1Tf36?=
 =?us-ascii?Q?BTq/I8FnRvgLnsYfmb38N6C2QBsoWKa7g+XP7RkgU3nKeKJpBne82/uHm0dx?=
 =?us-ascii?Q?e6STtsgjr6tgri2KUZ7tcjZ/O7PGlL5r8nfgpfm5foXzUbK4pbKAiABRxCoy?=
 =?us-ascii?Q?KXef88BCBN/2I/eJ0+Y6OjZBnj20KJeJWYHFN9eTj6cyCfIW4FXwiKmXusgu?=
 =?us-ascii?Q?PPzwaExZb2948V8U4Izf9lRlNjCfP8frS7aTCWbMUekFCsXmnJKqZwgoViCS?=
 =?us-ascii?Q?AdrbqrCGjUfXZlnrxtOalNLkY5KfrWkSnBL/Ijx2+FqreJWPzr8uCW+hvZwS?=
 =?us-ascii?Q?vh1XjrrcULOry2hkS38oXn0J6C3SDxhoc+5JOPBoXBfanz4bgTzMVaVq0c5p?=
 =?us-ascii?Q?FcIvOozDpOfUknPe37ySdWLrymba6O9tefTI3rNq77uV+MkgleQoHXcVqchH?=
 =?us-ascii?Q?Nntuo2bKfcq8J/DZzv4l5bCKIlhys12UOqsr12GLMOsaoffvVZbTa0sUKclS?=
 =?us-ascii?Q?S6SSZQRpKq2EU94FerSBQUT0I6OqzPpfAdD6ASJW99KZNfvIQdyoZnXBqPyD?=
 =?us-ascii?Q?LvJs0dAytzEuJT7FbhYp4o9+gUaAconaUuiQ1F6ts/IGVzyXlohfwGQ9zMDg?=
 =?us-ascii?Q?YXi0sADlC+2pe/jznDum9Yk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec9716b-6a4c-4e90-81c9-08d9b039222a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 17:29:28.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ild0oYKhkSxyJEEY2GGJvvYM5x/tB9Gk5/VtzPLzaKAPHB8P0RZXlNqcq0JzCBYeiQlrzZraStP99mRgi3HnDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3715
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

> -----Original Message-----
> From: Sanil, Shruthi
> Sent: Thursday, November 11, 2021 4:12 PM
> To: Thomas Gleixner <tglx@linutronix.de>; daniel.lezcano@linaro.org;
> robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: RE: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
>=20
> > -----Original Message-----
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Sent: Monday, September 27, 2021 3:11 AM
> > To: Sanil, Shruthi <shruthi.sanil@intel.com>;
> > daniel.lezcano@linaro.org;
> > robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Cc: andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> > mgross@linux.intel.com; Thokala, Srikanth
> > <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>;
> > Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> > Sanil, Shruthi <shruthi.sanil@intel.com>
> > Subject: Re: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer
> > support
> >
> > On Tue, Sep 07 2021 at 00:06, shruthi sanil wrote:
> > > +
> > > +/* Provides a unique ID for each timer */ static
> > > +DEFINE_IDA(keembay_timer_ida);
> >
> > > +
> > > +	timer_id =3D ida_alloc(&keembay_timer_ida, GFP_KERNEL);
> > > +	if (timer_id < 0) {
> > > +		ret =3D timer_id;
> > > +		goto err_keembay_ce_to_free;
> > > +	}
> >
> > May I ask what the purpose of the IDA, which is backed by a full blown
> > xarray, is here?
> >
> > AFAICT all you want is a unique number for the timer name for up to 8
> > timers.
> >
> > > +	timer_name =3D kasprintf(GFP_KERNEL, "keembay_timer%d",
> > timer_id);
> >
> > So what's wrong about:
> >
> > static unsigned int keembay_timer_id;
> >
> > 	timer_name =3D kasprintf(GFP_KERNEL, "keembay_timer%d",
> > keembay_timer_id++);
> >
> > Hmm?
>=20
> Yes, we had initially implemented it in the similar way, but in the cours=
e of
> review it got changed to use IDA.
>=20
> >
> > > +
> > > +	clockevents_config_and_register(&keembay_ce_to->clkevt,
> > > +					timer_of_rate(keembay_ce_to),
> > > +					1,
> > > +					U32_MAX);
> >
> > Aside of that what's the point of registering more than one of those
> > timers as clock event? The core will only use one and the rest is just
> > going to use memory for no value.
>=20
> Instead of
> keembay_ce_to->clkevt.cpumask =3D cpumask_of(0); can I update it as
> keembay_ce_to->clkevt.cpumask =3D cpu_possible_mask; so that each timer
> would be associated with different cores?
>=20

Could you please help me with the above query?

Thanks,
Shruthi

> Thanks,
> Shruthi
>=20
> >
> > Thanks,
> >
> >         tglx
