Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F313C9A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbhGOIFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:05:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:21840 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhGOIFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:05:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190873353"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190873353"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 01:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="505634772"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2021 01:02:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 15 Jul 2021 01:02:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 15 Jul 2021 01:02:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 15 Jul 2021 01:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CisZHpu2lZc/vmW80VCkTsxd+/RC4U1bk2cfVUxO6kLurwBnTt0/OfQjcEbPwWaTW6t62sozO7eS6V8/53s/e1zLKFXPuLZwan46SmCP4f41iVaUMFej8Cw79vjVxg0ONW31bO5RertPJ1RB9uaoTmXWm2mz3XP51yVd1gMuigDhzge4zddc1OAboHdGkXNUSODYtbvYKAXAkj6/jWEjK1BzVJW3bud5q4MEYtQ2k3d5z+JE7LyvbonMzC3QQ6+IJ5ki9JxUdSrSEsDYLM71ouhfDhHzmcvoXPQLa6yAjDXUcDpeUvznbcCEEC14DnN7A89vMUaZaD1AoqV8PBtG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOXc3jasSn79DiktB78XzoA7nrQ6+/RroOLYRC4vdeo=;
 b=AmDSnPhhWwuorjX5s3xlcWM4TyCQk93xWOVzwhGYSfKL5r7n5neM/LJd9AtSENUSC2YcXsRv8A+hy8LdPi+JMvUZlVxQ+vkq2UXvMlhjysWOS+ixiB6EjzwtpWTsbIt8Yg8R7Xj9zbGbKMimE7G/1/Fx0Fqxh6tTrD0/QwU5C+16z8jtyBoqvnxEMjynL+BN/hzBMe1AbyTOwwVWeiaOyB8fRRfi9NL5R7/uFzzZwV9yR+SzHV/JZStb/iizNg0XcT9woT+gilqrC+hpVNeFhPh2/qiw5ybOWxajpRU1g4Qx9pCYIJFz+h1qZh6jA1v4VIiHy1+S2fa1Azr7mmk2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOXc3jasSn79DiktB78XzoA7nrQ6+/RroOLYRC4vdeo=;
 b=GH5E0swykx0/btqekUhpQp/XcdBXfbMFY13sN+fVOdkjCfrcqA1/YDhV04+nt5Ftt7mysvcIj3yFM/c8LgZ7gsVTKdF/1fnjtML9pr8EnOwDL5/8Z37Si8gF78wUYI9rNCSXqN3g2vcLqyyN3YsPp4OJCXwnLsWEDtwUb5lHxF8=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB3127.namprd11.prod.outlook.com (2603:10b6:a03:91::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Thu, 15 Jul
 2021 08:01:58 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4%5]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:01:58 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHXa+TdwSm7KYczykCeLwkWAogkAqtB3YIAgABpMICAAFS/AIAAA6sAgAEgkYA=
Date:   Thu, 15 Jul 2021 08:01:58 +0000
Message-ID: <BYAPR11MB3128B4529B81129ABD79313EF1129@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210628061410.8009-1-shruthi.sanil@intel.com>
 <20210628061410.8009-2-shruthi.sanil@intel.com>
 <20210714024756.GA1355219@robh.at.kernel.org>
 <YO6ome7Opd6kjqua@smile.fi.intel.com>
 <CAL_Jsq+4vEfL5ZQzREXU7Mo1AUx1ZbdHTmJDwauEL890O7S7qg@mail.gmail.com>
 <YO7yxEgdzobD1jeu@smile.fi.intel.com>
In-Reply-To: <YO7yxEgdzobD1jeu@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61b1b53e-c444-4ddc-9796-08d94766d1cc
x-ms-traffictypediagnostic: BYAPR11MB3127:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3127D8EBF1CBF7697916EED7F1129@BYAPR11MB3127.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PprWHaj9vDGK3z9hl42roHT4zGL+EZtRLBscpvrZg5NYMWI/r3dnslZTYu/YAeG56TbghNNl13ivKVJedfooxuHZ5Zo8E+iw0kUNfwaAJti3t1yGtI3X0ieY43BiErxMUizmMBwmCzHDQHkUyQvZTJRhVfGJhAvSq3S+x29z+QKYPPG7IUIc8QfUatPph0twjmSUBJr7PPSMVujAvqxd6s5LmCEEucQpHY/1IqDILWuhraqSiGzj+Y48o0JNSUQALnyhCAFoEEjJWMrUWvaaslqjZuu6jGnO9AeKzTYDo1bbKhYm9ZGgvpOhkpiAAHh2F6V9FO94XmGd+m67LrhKqRQlvzh+l9W5cVyWnjWGZsUzgtPBtmTXxSO5ibJxN4NfXYd9ORsM6Iuex1WVDKbU8R5qiOQSHTPLK/FpFCxwMfL1lVNdh0+1lmGDid0DmS/3Kab9azb0jZS3vu+VZsDTuujWIVIU9O4ThTtwbPZCgXNAmn9TRW2gEEEhnh2ys8Fvm3/zWUxic4Az+bbPqS8TbNj4+AKu5prxjXzH989qGGpDd0clzg4Os7ScdcH9OFsvNOBIqMVRtPu3D857c5K/rppRIgLrU6T9r3eXVflPfT80u2xNmyOs+fEPZ2PF9YaYQ1yO5O0OrMPwbpFlnJgyhQrPPJWpuqP/dqAmawHGuTI5mttEx1drbcjXafUKETuygFSyvQ83N1lGJ8HtcCtZyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(86362001)(186003)(26005)(2906002)(66446008)(76116006)(122000001)(66476007)(66556008)(64756008)(38100700002)(66946007)(55016002)(4326008)(316002)(53546011)(7696005)(6506007)(110136005)(83380400001)(8936002)(33656002)(52536014)(71200400001)(5660300002)(54906003)(9686003)(478600001)(8676002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6rZwHVSkg4LHDor+XqknEC63BQhaTxvxyQ4PJqzl7e0BeweQLP+iBlEJP0UO?=
 =?us-ascii?Q?8iFDcVUd7InpO9KziFn5aydzSJkqR3rS6Ok6iWOqo6JeHSmm1BcXb5x+xyAR?=
 =?us-ascii?Q?U2RjZX532EY+OX5jKJ0OMljOEk6EmT7f4PY58j2ddTIBVxf9mapNKS/YmHDe?=
 =?us-ascii?Q?U7iul3UFyqgp6hVdTXh5Cmmk5MtP7hxF+xtos847iJNxbgGaaBE4UMkE5rH4?=
 =?us-ascii?Q?fOsNeK0CTHsXG6V2Mcx5VyeWK4U9eNduY2sg6rfQ/btdWfd7xKH6b506h7G6?=
 =?us-ascii?Q?34DMqJeCAeED+2BeHH3IaiQSnRgjiETotvwRrl+K9QBJQZguwj1+fQz36I2h?=
 =?us-ascii?Q?fUfz4lyKC6LZSJu+UWmFs3PgZsjKkRc6WM5M/J7wd/bkuOlrJnata2pNIsqC?=
 =?us-ascii?Q?cn+3tpX80Kjwejih/0UeEvkDmXt/xU2MvCGDiRiyZ7g8MyOkQaahca7G1CJ1?=
 =?us-ascii?Q?Q0JTgzlwUpmyl1Og7PqIt2EhkzCWGOZucQU3draLtaDoACDOn/2iLbcaRUh/?=
 =?us-ascii?Q?vsR9ze8mwwV4gyOzbg9/H8bWWN3a3koyHL2d5Cn/AwOYhtDN3MAITNgP2HwN?=
 =?us-ascii?Q?5AmgVxF8y+RRh4Xc1Md5OtJh9FJj1eGK7eYmAg+UcK1yffstPwVgkB2SWQcv?=
 =?us-ascii?Q?6EOF1n+1kFAI2Rw0JqVKa02mpPvwSXIsYcqMxttWrX8Z1TTJds2pzSTBhGiP?=
 =?us-ascii?Q?SNL4lr5XvaupGMo14IMOvDQ09fD58Z5S3mp2e5j5BFRnRmUIdNadYk3tsJx+?=
 =?us-ascii?Q?Z7FNyYdhtL8cyehu7gsvGbuAKqRdpKkg/NKwxvjGY2671xtc7jWfkX9y0Z3H?=
 =?us-ascii?Q?OPkT8p/SnxrWw6JfSQwr72RbqRI6xlqJIlped4iXl7fg/cPf0HcfjGHug+AX?=
 =?us-ascii?Q?D0IdDR1nPHVud01vtFL/7ttjCKEoLK7nCiyZXIKUSE6SkQ1yla67GJ8Ky2IT?=
 =?us-ascii?Q?kqxwlfTT3sfqcC6Z863GlyUjuBb2jOuhIMhwD6xz38WaZdbqjRabhxshqy+W?=
 =?us-ascii?Q?HobOcEPiGo4Vj70xtS+IMtcyv7eWKJ3l5YHmjbzYsh2mqX2IfIbOO1cwjhOU?=
 =?us-ascii?Q?22dQp0qK2T4GgO7hfCFUUGyHDNx1gNLCDxysEpdLnTK+9b/r6t76F0eGijHL?=
 =?us-ascii?Q?MbDzyQR5XP+5mjQGwhM5a79XnStz9gR3c5tQP2hu661tnlyh1WljGqJDSrw2?=
 =?us-ascii?Q?txoNTzB2MzSKYG7dxwCABSNnMdDcbwUrUcnZDdJUNuc42QOaFR0LPNxthNiQ?=
 =?us-ascii?Q?ZLOCfPzVjF3KM0hVjHxjYFJ2c5YgS1ey69VDRtqtNVFan6v3T6RJ3Q2cVD+h?=
 =?us-ascii?Q?tzDUP/BuGXuCHbf1HfoK+s2d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b1b53e-c444-4ddc-9796-08d94766d1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 08:01:58.1068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4NlgMhE3LqRw3UHcmzbA4+Qny2I77Sla/aYAlGHmL8gNn6r260cXblvwYArj10vTlljPZI4i1UHKxEzU/nULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3127
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, July 14, 2021 7:51 PM
> To: Rob Herring <robh@kernel.org>
> Cc: Sanil, Shruthi <shruthi.sanil@intel.com>; Daniel Lezcano
> <daniel.lezcano@linaro.org>; Thomas Gleixner <tglx@linutronix.de>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> kris.pan@linux.intel.com; Mark Gross <mgross@linux.intel.com>; Thokala,
> Srikanth <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> On Wed, Jul 14, 2021 at 08:07:44AM -0600, Rob Herring wrote:
> > On Wed, Jul 14, 2021 at 3:04 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Jul 13, 2021 at 08:47:56PM -0600, Rob Herring wrote:
> > > > On Mon, Jun 28, 2021 at 11:44:09AM +0530, shruthi.sanil@intel.com
> wrote:
> > >
> > > > > +  The parent node represents the common general configuration
> > > > > + details and  the child nodes represents the counter and timers.
> > > >
> > > > I don't think all the child nodes are necessary. Are the counters
> > > > and timers configurable (say on another SoC)? If not, then a
> > > > single node here would suffice.
> > >
> > > If you may notice the children may have different properties that
> > > can't be known ahead, such as IRQ line. On some platforms it may be
> > > this mapping, on another it maybe different.
> >
> > What I noticed is it's all the same clock and 1 interrupt for each
> > timer can be just a single 'interrupts' property with 8 entries.
>=20
> This may work.
>=20
> > Is there a platform that's different or that's a hypothetical? Because
> > hypothetically, every aspect of every IP could change. But we don't
> > try to parameterize everything in DT. It's a judgement call between
> > implying things from compatible and explicit DT properties.
> >
> > > With all respect for the simplification I think we can't do it here.
> >
> > You can. Any data in DT could be in the kernel. It's a question of
> > balance, not can or can't.
>=20
> Not only, it's also matters of what exactly hardware is: 8 timers or time=
r with
> 8 channels. If it's the former one, I prefer to have DT exactly like orig=
inally
> suggested, otherwise I will agree on your proposal.

Yes Andy, its correct, we have 8 timers in the hardware which are independe=
nt.
Also the timer framework provides option to parse all the device tree detai=
ls. In this case we would pass the timer node to the framework and get the =
base, IRQ and clock. If we go for a single node approach then all these nee=
d to be handled in the driver, hence making it complicated.

Regards,
Shruthi

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

