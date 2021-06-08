Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B951B39EE58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 07:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFHFsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 01:48:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:8428 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFHFs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:48:29 -0400
IronPort-SDR: sgReARHP2H2VDBSCycfLYuKITL/iYvD3iuacasqLD0Rj7sd8lbdpuKHH4ju2bjBWnxEF+MaBc+
 bskWZqisQ8ng==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204799642"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="204799642"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 22:46:36 -0700
IronPort-SDR: +YAM7PXx1V7Gypk4+S4wnTUWdU6CmCVmtHuFT9YZEFEvEvvGpW0YAZf0GkqyFQXOzxQkVAxy46
 RFzC38e0DskA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="481816129"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2021 22:46:36 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 22:46:35 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 22:46:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 7 Jun 2021 22:46:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 7 Jun 2021 22:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVLFzmtREIZTa0a7qw9E6pTihBXVUeQuvFRUU6D9+FdJ5n54kL5pTDmhRjUPc0b2zKakVqrsIEH3qJKyMaYXnzcOy+iJsZdE6bGlgrtqXFZ9wWHp0Q2um61iVsJBssLqjXsrjYkNumHbUtbdjZsiJSTS5gmOO+vI4j5NB+KF97LANZw+84685dkkdcXumUG253jraiyPbOGohkQvm9ktJc7nn/1RnsPB81jZ+/SjNjECHeYUkbDurmP6k2evps8d2xbQimskCFF81E06+jSxftSW8LHifNc/DWUtcIUIscG936dX5oaOTIm6Ev4iiw3QAmDHNSWrGDWvfHhOqIlE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5/R2Kl8s7qnqzJIQTxSDL5WOxIfobJUEtQlmdShAsw=;
 b=WIZaDemOIzmBqSYFXZsH6EiT3j/klEK2SgE9dEPZLVH6D1EQqG7//vMVyrXEpHB98ZOeumK3/iIogICHGyQPukxh7qNFXqd6HbnzlNgAztRQW+cPcFaZRoizXuy6/bE3k8TkdikKwVWlbPZfxGL9kPOmauEfqfWOPSuaMnfwEj2EFEIMU/TrHqIXUysFTEU3b4LS2JvpAKnqWNAJvnkhFPgv4u4aaBvfShpjmGPIQQq45VT7A58UtkPqV9NNgUbcTNzOo90HgzrZfFgulweTuQIAVs5TUSi9lPYpN380r1jkp+ij4O2AilUN+t4A/mrHAkAdt1iFjiHCOMNvkdShfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5/R2Kl8s7qnqzJIQTxSDL5WOxIfobJUEtQlmdShAsw=;
 b=cGLGt9EUfBCl20kRL/gHEjUZJ2qEopc1Siz6cvcgeArxMUtSiarcu3iawEE1q+KJ+GqrJq5JhRDptVv4Y15nqUvreBrrrOjE/MTXHLFnjkYixVh72ZrVJ3k/u6PatTVTlcGmcU20oh70fKa0wSjz4fzJT2xdCBgr+57N3krPdx8=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB2936.namprd11.prod.outlook.com (2603:10b6:a03:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 05:45:35 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::c34:1c49:28df:c09d]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::c34:1c49:28df:c09d%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 05:45:35 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHXUsMHqKFo19ik00WR9uYdYCHeTKsBI4aAgAEKGHCAB30gYA==
Date:   Tue, 8 Jun 2021 05:45:35 +0000
Message-ID: <BYAPR11MB3128D33181EE6FB862258E15F1379@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210527063906.18592-1-shruthi.sanil@intel.com>
 <20210527063906.18592-2-shruthi.sanil@intel.com>
 <20210602192145.GA3800420@robh.at.kernel.org>
 <SN6PR11MB31337B2646C812ED2B88DFA2F13C9@SN6PR11MB3133.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB31337B2646C812ED2B88DFA2F13C9@SN6PR11MB3133.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.179.4.103]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aab8f6c-8c0d-48f4-bdea-08d92a40a343
x-ms-traffictypediagnostic: BYAPR11MB2936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB293656EFAC3ADAED87F51088F1379@BYAPR11MB2936.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cAY9KzkGHFKo2nTskrfyjoxo6fnuqZN8QqzhBNv8DZCJtRJNVLvZ4WH6eytUAry2er3m2jIptZJDwQfqKe3wLiPEnxhD+zDj8CH1Tx0Y/0E6aSFP/uM+gKneZ/8AGLjTMdE6O/kB3w7fvaEwehVoSD2+6dUG2NBMbqGhb4aBhUsPzD6ap3wLRZyqb3PaFro+LOcjO568c2ZcQEURF69orsn/x1NfKUht26GErPnLEXVrxt+pr/5vbqUhEm4F2Hc33/cx5HUo1SP4ALzOlAEqWF5QVj2+xxwuDN3XuoUobPXqm14o0w8CLRtX3SJFgw2fAZSl42htfmUVxT1Wvqs2Tn9xTg4DT5SKe8PkJjWlpWCzHyevJc+5+kJXMv20PQY2zvQKfqz99ntTqAMrgObQV180kx6CztrDKiS0zpzr5BDLLvqA4/0QGkZUB4FK4G3H9obN/sgEwRJCctUUndEMTn3y4iZ2+wLtwqjttz2s46QWNJm8aY2y7xjg5dCSpA1p+hNRCxGtz4xKy8GdI0OxEGter+9Fjz5vT99wbJi+R0c89WbCKPOKgaMPYcl2yCEjqmTRAZhXHtjpjkrLLizbfvd5LcELl/bXH0MtShPZPUs+sq1ug36uBJH0HzIOKzUYk2A6dYiRfzv3b26LToovEx8kPcrtLNfCfdccKSjJSWwdV4frgsF9WZmiDlI/H1SXqNfn6NpCBbHXnd429iyyIo2/HmtZxxySl96k7FJGjSsTfpZs8Tu1LJa9i0FMNcEl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(66946007)(33656002)(7696005)(6506007)(76116006)(9686003)(26005)(71200400001)(53546011)(5660300002)(55016002)(186003)(52536014)(64756008)(66446008)(66556008)(38100700002)(122000001)(66476007)(2906002)(86362001)(54906003)(6916009)(316002)(8936002)(8676002)(478600001)(966005)(83380400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZiRlQQ9PUbED8N/02ROzOb4cTxye+kgYA4Ux41aGZSsSkOHTeJH/XM/amkSt?=
 =?us-ascii?Q?T2GisbIUnL1L/vs0FxmWrka9vEYC8TpfC52yHzEvt/O/cmwpEKPykSorxvIe?=
 =?us-ascii?Q?PyB2h522rNivnm+aGgEb/qHSJ1jserJ4pPOPlvdpLJx5Z5OV9WjbEprZWuNz?=
 =?us-ascii?Q?MV3XOBuss03drxBQBlSlhEe8K0n+tk6CJH1vINqkBzEEVwbMsMGFkaJYhVgj?=
 =?us-ascii?Q?e3QEYKYlmkjdmuHtZDjYOrqJ9ruPopVrYPo5dPAYwl5ZrtoewiOLi9OzE1lY?=
 =?us-ascii?Q?q2eOGYngmvHWPqBJs3QNdZ2BzwtlMK1Hq5HpWRgod+eU6+elqw8clsRGpdnF?=
 =?us-ascii?Q?TfXycyxaMcBxNBZCLIIyJ0LwQ1G31PIJsebjeGqMvlB4VA3UbsVn9e1/Rvyj?=
 =?us-ascii?Q?ZLfXy2Oa4y2QtJPWQCdu+QrYcjRfcXGzNu8Zq6TId3Ln3CxNtOgkv79S1yZE?=
 =?us-ascii?Q?s9lsZ1nxCKwH650kDz+KG9FnSe5LkEDFpwjGXC67GfWP5CdoMBUrGLD+yz3g?=
 =?us-ascii?Q?k0YsHNu/cwebQNrdfJZzDd8sZzLUkcvqIaUZORV+D870nk6Aa2T5H4TgdmO0?=
 =?us-ascii?Q?RRPK+Mlfc6Wy9z9GgS9ZjFS10EjQUKJYS7d0L+1WLXrEL4IrBHIoZ1e8MQIK?=
 =?us-ascii?Q?Qzsw3F5pFREIT1GYEOJIGPehlEvb/tvVb0V9+CgroFjObEaNIRWn1QeGkX41?=
 =?us-ascii?Q?LC7H9sfvlP1/5gSEpJza0XxIVyqkYCsmctvAJ3/8nRWHqXZFeEg0IEYwuWPq?=
 =?us-ascii?Q?YuEWFaEabR28LrLGgc0+ae/CG27XBlLMIT7ETByDe3qIdwuHqwyT5KAY5szT?=
 =?us-ascii?Q?ncKswZyppwjbZp08sa761nvHSIp/8+VWaxKCMx9/fAVlCQCtshVVZhG6IRMb?=
 =?us-ascii?Q?yisYAMHJ8BjALzFnTNLfGZlHG7+pSYs2pVvCTE2QrPLb5vM/+ysDG2tJwlgg?=
 =?us-ascii?Q?7F2YK4MInerTEoxCnFr+UuD/xdRs4Y7ybULOTeyXFpCkxoVkpcke7ZF4ssp3?=
 =?us-ascii?Q?gyytVsl3N5dw8xIIoaU39Ps7tF1kk7Y8fqjSjosiw6soW8oqJZSxp47YZmJ5?=
 =?us-ascii?Q?fhk4GQ4IH5VPeAjsFyHAFG6pnPcNP31SQjc/3tUaigLumIqXGSKk+WWtKPVB?=
 =?us-ascii?Q?IhP+4xxIxkrjGTu3uzTS1iq1s3YlV5CNB7E3QRt7MMkOj55o7gBxu+c/Fm90?=
 =?us-ascii?Q?WNqbRGzonMl1aVHWsR2jMfh9slsJCGyWXGwLQ7JtqtMmtl/ejotG7wmeF/wV?=
 =?us-ascii?Q?rgBEcM4PvMd65M7OG7cMwBMd0w1wlMTyOfj6MG9d19PPHLLsPsuDp1gGrcop?=
 =?us-ascii?Q?LbXPFTUEroJ7jWzmpK0uC/cU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aab8f6c-8c0d-48f4-bdea-08d92a40a343
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 05:45:35.4005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u03Mcwq1toCzXxPMmB0ss5p8eqb2Kipz/lzcaeOlWc5Od6oIesyz9hVx8wOwn3lWnwOR0FqRUMZy6josXnkfxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2936
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Could you please confirm if the existing approach is OK. This has been vali=
dated on Keem Bay evaluation HW and its working as expected.
Also please suggest if we have a better way to handle this.


Regards,
Shruthi

> -----Original Message-----
> From: Sanil, Shruthi
> Sent: Thursday, June 3, 2021 5:02 PM
> To: 'Rob Herring' <robh@kernel.org>
> Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> mgross@linux.intel.com; Thokala, Srikanth <Srikanth.Thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: RE: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> Hi Rob,
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Thursday, June 3, 2021 12:52 AM
> > To: Sanil, Shruthi <shruthi.sanil@intel.com>
> > Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> > mgross@linux.intel.com; Thokala, Srikanth
> > <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>;
> > Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> > Subject: Re: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel
> > Keem Bay SoC Timer
> >
> > On Thu, May 27, 2021 at 12:09:05PM +0530, shruthi.sanil@intel.com
> wrote:
> > > From: Shruthi Sanil <shruthi.sanil@intel.com>
> > >
> > > Add Device Tree bindings for the Timer IP, which can be used as
> > > clocksource and clockevent device in the Intel Keem Bay SoC.
> > >
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> > > ---
> > >  .../bindings/timer/intel,keembay-timer.yaml   | 180
> ++++++++++++++++++
> > >  1 file changed, 180 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > > b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > > new file mode 100644
> > > index 000000000000..e0152e19208f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/timer/intel,keembay-
> > timer.yaml
> > > @@ -0,0 +1,180 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/timer/intel,keembay-timer.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Intel Keem Bay SoC Timers
> > > +
> > > +maintainers:
> > > +  - Shruthi Sanil <shruthi.sanil@intel.com>
> > > +
> > > +description: |
> > > +  The Intel Keem Bay timer driver supports clocksource and
> > > +clockevent
> > > +  features for the timer IP used in Intel Keembay SoC.
> > > +  The timer block supports 1 free running counter and 8 timers.
> > > +  The free running counter can be used as a clocksouce and
> > > +  the timers can be used as clockevent. Each timer is capable of
> > > +  generating inividual interrupt.
> > > +  Both the features are enabled through the timer general config
> register.
> > > +
> > > +  The parent node represents the common general configuration
> > > + details and  the child nodes represents the counter and timers.
> > > +
> > > +properties:
> >
> > There's no compatible, so this schema will never be applied. You need
> > a compatible to identify what the block is.
> >
>=20
> This is a parent block that has the common configuration register address
> defined which we would need during the initialization of the child nodes.
> This block in itself is not doing anything. We have this because, we have=
 a
> common register that is required to be accessed during all the timers and
> counter initialization.
> The child nodes have the compatible string.
> I have validated this on the HW and see that the timer probes are being
> called and the timers are functional as expected.
> Please suggest if there is a better way to handle this scenario.
>=20
> > > +  reg:
> > > +    description: General configuration register address and length.
> > > +    maxItems: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 2
> > > +
> > > +  "#size-cells":
> > > +    const: 2
> >
> > Not really any reason for 64-bits of address space in the child nodes.
> > Use a non-empty ranges.
>=20
> OK, I'll remove it.
>=20
> >
> > > +
> > > +  ranges: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  - ranges
> > > +
> > > +patternProperties:
> > > +  "^counter@[0-9a-f]+$":
> > > +    type: object
> > > +    description: Properties for Intel Keem Bay counter
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        enum:
> > > +          - intel,keembay-counter
> > > +
> > > +      reg:
> > > +        maxItems: 1
> > > +
> > > +      clocks:
> > > +        maxItems: 1
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - reg
> > > +      - clocks
> > > +
> > > +  "^timer@[0-9a-f]+$":
> > > +    type: object
> > > +    description: Properties for Intel Keem Bay timer
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        enum:
> > > +          - intel,keembay-timer
> > > +
> > > +      reg:
> > > +        maxItems: 1
> > > +
> > > +      interrupts:
> > > +        maxItems: 1
> > > +
> > > +      clocks:
> > > +        maxItems: 1
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - reg
> > > +      - interrupts
> > > +      - clocks
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #define KEEM_BAY_A53_TIM
> > > +
> > > +    soc {
> > > +        #address-cells =3D <0x2>;
> > > +        #size-cells =3D <0x2>;
> > > +
> > > +        gpt@20331000 {
> > > +            reg =3D <0x0 0x20331000 0x0 0xc>;
> > > +            #address-cells =3D <0x2>;
> > > +            #size-cells =3D <0x2>;
> > > +            ranges;
> > > +
> > > +            counter@203300e8 {
> > > +                compatible =3D "intel,keembay-counter";
> > > +                reg =3D <0x0 0x203300e8 0x0 0x8>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> >
> > Don't show status in examples.
>=20
> OK, I'll remove it.
>=20
> Thanks!
> Shruthi
>=20
> >
> > > +            };
> > > +
> > > +            timer@20330010 {
> > > +                compatible =3D "intel,keembay-timer";
> > > +                reg =3D <0x0 0x20330010 0x0 0xc>;
> > > +                interrupts =3D <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> > > +            };
> > > +
> > > +            timer@20330020 {
> > > +                compatible =3D "intel,keembay-timer";
> > > +                reg =3D <0x0 0x20330020 0x0 0xc>;
> > > +                interrupts =3D <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> > > +            };
> > > +
> > > +            timer@20330030 {
> > > +                compatible =3D "intel,keembay-timer";
> > > +                reg =3D <0x0 0x20330030 0x0 0xc>;
> > > +                interrupts =3D <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> > > +            };
> > > +
> > > +            timer@20330040 {
> > > +                compatible =3D "intel,keembay-timer";
> > > +                reg =3D <0x0 0x20330040 0x0 0xc>;
> > > +                interrupts =3D <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> > > +            };
> > > +
> > > +            timer@20330050 {
> > > +                compatible =3D "intel,keembay-timer";
> > > +                reg =3D <0x0 0x20330050 0x0 0xc>;
> > > +                interrupts =3D <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> > > +            };
> > > +
> > > +            timer@20330060 {
> > > +                compatible =3D "intel,keembay-timer";
> > > +                reg =3D <0x0 0x20330060 0x0 0xc>;
> > > +                interrupts =3D <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> > > +            };
> > > +
> > > +            timer@20330070 {
> > > +                compatible =3D "intel,keembay-timer";
> > > +                reg =3D <0x0 0x20330070 0x0 0xc>;
> > > +                interrupts =3D <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> > > +            };
> > > +
> > > +            timer@20330080 {
> > > +                compatible =3D "intel,keembay-timer";
> > > +                reg =3D <0x0 0x20330080 0x0 0xc>;
> > > +                interrupts =3D <GIC_SPI 0xa IRQ_TYPE_LEVEL_HIGH>;
> > > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > > +                status =3D "okay";
> > > +            };
> > > +        };
> > > +    };
> > > +
> > > +...
> > > --
> > > 2.17.1
