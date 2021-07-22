Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D783D216C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhGVJRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:17:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:54607 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231587AbhGVJQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:16:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="191198177"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="191198177"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 02:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="501727299"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jul 2021 02:57:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 22 Jul 2021 02:57:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 22 Jul 2021 02:57:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 22 Jul 2021 02:57:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 22 Jul 2021 02:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnG6ae+QPuTclnH7e+VddnxCyvMaAgYCM0elicyFVXF/UgShzKpTz+XSI8awHG2aXzIzzLaF2ypI966sBAu8phbCoaRw5jKSgJDrM75QT7dpsmo+x1EJgdD0SCUZ9mfuY8eSSZQ6ZH7JXPxtPGoFMlOtObWhzjfhxrnHEOkiIblJMr2AfjvkwdOIhNLiEiVkBrZerLX6gI48K0NNoY09a/MmNn7DEzuuhMxTvXrrVaRF9XPCpA8nGLSARI/kV2OP3LGtVYiWYxN++cSizq1NS3pKHwHeiB8AeTGWZ9xP82TSLLd5Tg2NNOy5mJxfvf329pFCIllVUt/gN6XDCr4yCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RKwcqK51EVDZ3H8AXEIZSMC3RlBi4uTfjZyjNgS0V8=;
 b=bIC3zuGH84YgQkWUZLbd2OotBoO+80j/45INlF/F1HPv13ET1sy6/qwpPv2tp5T7To/woFY5S67+UN70Fw5qUcd+1ztYFD96fMsLKz4TIp5jJMQer8pdubPIeKyMRY8bUfgtJ4LdpvjHzIX333Slx+tUBukcVXH6PZzAm8SA01eiO1xBS/kNNCUXA08fVyZaX1q0hbc5F++P3LE5+55Cps7Zv0uPtRmiaGVBJkuZZ2joIGOD/KYTHuoVA7y+LyOioPeozRXIYEcOsVbraqzB075b0u4pdWHN7n3MHkaWSUe7BHAJwP7TwxYV685sOPUyINkhSru8LXZMAZX9iOTpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RKwcqK51EVDZ3H8AXEIZSMC3RlBi4uTfjZyjNgS0V8=;
 b=V0xvFzgh/ub4IaceXnQqN9GH1mtAAqG8ghjGoZVhEcLpCcHTSSv2n0tC6Jv3ib263RiDcBNXYdI+xADxvRU1UKWL7Gpi/l/v1DR+KcnP/Y9GQWy20tXiQ2+lbaRR7dAceOUAnVy6qxdjPh0mYvPVjbK7ZrJYg5wrhdPTkY9a4tM=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB3175.namprd11.prod.outlook.com (2603:10b6:a03:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Thu, 22 Jul
 2021 09:57:24 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4%5]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 09:57:24 +0000
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
Thread-Index: AQHXa+TdwSm7KYczykCeLwkWAogkAqtB3YIAgABpMICAAFS/AIAAA6sAgAEgkYCACtxz8A==
Date:   Thu, 22 Jul 2021 09:57:24 +0000
Message-ID: <BYAPR11MB3128DF809CEF3EC126F97BC8F1E49@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210628061410.8009-1-shruthi.sanil@intel.com>
 <20210628061410.8009-2-shruthi.sanil@intel.com>
 <20210714024756.GA1355219@robh.at.kernel.org>
 <YO6ome7Opd6kjqua@smile.fi.intel.com>
 <CAL_Jsq+4vEfL5ZQzREXU7Mo1AUx1ZbdHTmJDwauEL890O7S7qg@mail.gmail.com>
 <YO7yxEgdzobD1jeu@smile.fi.intel.com>
 <BYAPR11MB3128B4529B81129ABD79313EF1129@BYAPR11MB3128.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3128B4529B81129ABD79313EF1129@BYAPR11MB3128.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: ae067bcd-6847-4c5d-feec-08d94cf71b07
x-ms-traffictypediagnostic: BYAPR11MB3175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB31750643D8E831A965A495A5F1E49@BYAPR11MB3175.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ylc/1YHZxOAzc0GrygeVvY+gyOayj9VjsWnSYMPvgdTP4Pqveq5t56AKtSeQd8eL/hj/7c+QrlCoh4oAIBVUiyEk2uak2b9UcvGBi1Cjg5XH94GvU5VaSH35znNUBSGs7OR48JcAJVb55OSAhWLmb8SX/srN8kecSA9WkVZwN5dHRK+7JX119/1u8hkMKGoZW5XNlE6sOrsXXa8ZqnXIJV8mOgDqVU+f1AFfRzF8O/79Gd4CniBzq0XP1HtH65lFctpGAjC3nMOFyxgAWsNGW71c0JqFiD/OYpwpTlRBb7PB5yN/Xsce9KooKgBeS+1Mt3+TJ+za0I50V9l1YZv6evlJqfTD3nqlXFiF+xATVWmBWbE+t8coUa2rnhnVRmOTIIrYOmXS+mn1VsECwL4JjMPSkba9034LsfX4HATCYH/alh91m5pXzVwdJ8CNWNfV4l0xdOwIAwiiJD2M5qSi+85v/iySU++zjKu8vszwtUehxx81Ow8FPv8oRV0CrL9iB3NC4vnPyAWBkjzBxcuSzDivQNMFfAkZPquseTJDIS7SGu+EKyfOawzodoxD8Vpvb1tUAILY1+kIIBuOVCp1BDvYPVTNDKeFcsotK/1UolFf3GKf1IsyC+NiUkoGJEoUVcsVshJ69tHKGs5oZAR++/GNDBB3dl/DQuN3OvWhoKJv9o00D4ZZVoh4K9Us9lOEAPLwdSYx/0XUh59cnj+2mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(6506007)(478600001)(33656002)(4326008)(53546011)(86362001)(8936002)(52536014)(186003)(8676002)(110136005)(71200400001)(54906003)(66446008)(66946007)(9686003)(64756008)(66476007)(66556008)(38100700002)(55016002)(26005)(7696005)(316002)(2906002)(122000001)(83380400001)(5660300002)(76116006)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1AhZ344YEdua0N2Votp132nt39nke8pmHyx3ixQ3Qr4GzU5slWmBpBjNEQKg?=
 =?us-ascii?Q?csRL8z07wjSR+JGTdiWkICHMHZ0Rvj46Q606+yP1xyVRq5RVC2IRG0cOqr+7?=
 =?us-ascii?Q?fSAvyFVMkvii1Gd9w6HglB+Nxn3CUOKYtoVB/2ngQYlJHt8OMOP1PBlhcr84?=
 =?us-ascii?Q?BSvMORh7JZW4Y/mQI5+xepLukJycPuHehASE7UaUhdD1UngzFUENMyKWj4Hp?=
 =?us-ascii?Q?+B1uhLi4vcQnQbKFwLTJKJTNleW8ZxCU1orvZDa1p5mTbJX8kQEGqXo63+kx?=
 =?us-ascii?Q?wjjAT+HhXWJNturgNx8xUvX3PHTaQ1eTOU3wm3thW9MsteaZysWaAb5NRzFl?=
 =?us-ascii?Q?WD17vY2l8BGmt1IpQOQygsfdvmwEBjOqxZLoyo+cxdzQv7bei6IbcnxsROTM?=
 =?us-ascii?Q?E1+GWRmsfZlvvfd/2o0MqGrEJO2bhDHZ3lzZiPDbTeimTRL8Ze/sGjYqaiUa?=
 =?us-ascii?Q?saUO6AbCyCpVFcjbE0L8WQ4etx7LU1Y6rGufZW0NHJIO9BCLmT9mCV0M6RlG?=
 =?us-ascii?Q?HqRtWuY1FpwKITrGO2BDZPhGTv94D0HlOsdWFAZsMnxXl3UZhbKv+q0dPoOm?=
 =?us-ascii?Q?ShMPai24y0p/1p/+JHNGzmvBrXN/GsAKPikfq+ol+Ug5jjT8A2omllu09/H1?=
 =?us-ascii?Q?gXghDH5jezAadpJdtgh4Z6VotOfrN6OdW+dYsIq4XuL9mUP3/he7w6Y0Yii8?=
 =?us-ascii?Q?1lDufyfvYmsolJ+Y99csJCBtVzCmUy5PBRPXigFZvWRIEc1BoKIWt6JECFak?=
 =?us-ascii?Q?IEJzPVoznTi0atcEoKfv+9z/SvePQNQD9HibfcA4U5nre419yD2Xl5g6AJIo?=
 =?us-ascii?Q?LIC/aD1XtDADGLFixtdWM6ZDhfVOASSrVB8RGUoAvPpcdZWlKdtnIG5qs+wC?=
 =?us-ascii?Q?W17WGo6eGXbuPparrED9riaP14u1JewaGZuUqJZ/YbDjrB/JCCxbGw7ZQJi2?=
 =?us-ascii?Q?uxRWryUhrYikh9cV0lRuYZpr7ev46rXqd347D5A5Egrj7lyOfU0XzS3NYLFH?=
 =?us-ascii?Q?vWTgSNclqkDLBp+PMDQnmTXRVQoep8/mMMSF3N/c/vXTBQZmUpUOMtleNYcg?=
 =?us-ascii?Q?KzIfrxGesWYaTwJaN/qoLSbbBaPSGWOYM7q6BpPJ2n+tCa5Vbvv4RM8QXgtE?=
 =?us-ascii?Q?CaDL6pwQhbprfkkg/p1pg31v9GcWZcIVCkJ+p+m8tqr291J20NcgG0qa8cxA?=
 =?us-ascii?Q?4acD1IILXE2hVo8TuoixsDfGBU9viUR3h+VFbIUAOAdSz3XIW61NO064THyW?=
 =?us-ascii?Q?NrL5KYuh3KzganPJt9ejs0vYonh0dqAKTa+ZZl3/lyraupU22lN7Th3i/GVS?=
 =?us-ascii?Q?v4vDL3DCpyGCjZVoQ2mz+Ev8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae067bcd-6847-4c5d-feec-08d94cf71b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 09:57:24.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsVEVZGTMVVyB9B1BVLEKp0s4Kyx8qcM5V9wEYGTbPeuut6trUok6CnlNjVX5r0le8GvVxM336lN0lmdx7o9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3175
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sanil, Shruthi
> Sent: Thursday, July 15, 2021 1:32 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Rob Herring
> <robh@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
> <tglx@linutronix.de>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; kris.pan@linux.intel.com; Mark Gross
> <mgross@linux.intel.com>; Thokala, Srikanth <Srikanth.Thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: RE: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, July 14, 2021 7:51 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: Sanil, Shruthi <shruthi.sanil@intel.com>; Daniel Lezcano
> > <daniel.lezcano@linaro.org>; Thomas Gleixner <tglx@linutronix.de>;
> > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > kris.pan@linux.intel.com; Mark Gross <mgross@linux.intel.com>;
> > Thokala, Srikanth <srikanth.thokala@intel.com>; Raja Subramanian,
> > Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
> > Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> > Subject: Re: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel
> > Keem Bay SoC Timer
> >
> > On Wed, Jul 14, 2021 at 08:07:44AM -0600, Rob Herring wrote:
> > > On Wed, Jul 14, 2021 at 3:04 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Jul 13, 2021 at 08:47:56PM -0600, Rob Herring wrote:
> > > > > On Mon, Jun 28, 2021 at 11:44:09AM +0530,
> > > > > shruthi.sanil@intel.com
> > wrote:
> > > >
> > > > > > +  The parent node represents the common general configuration
> > > > > > + details and  the child nodes represents the counter and timer=
s.
> > > > >
> > > > > I don't think all the child nodes are necessary. Are the
> > > > > counters and timers configurable (say on another SoC)? If not,
> > > > > then a single node here would suffice.
> > > >
> > > > If you may notice the children may have different properties that
> > > > can't be known ahead, such as IRQ line. On some platforms it may
> > > > be this mapping, on another it maybe different.
> > >
> > > What I noticed is it's all the same clock and 1 interrupt for each
> > > timer can be just a single 'interrupts' property with 8 entries.
> >
> > This may work.
> >
> > > Is there a platform that's different or that's a hypothetical?
> > > Because hypothetically, every aspect of every IP could change. But
> > > we don't try to parameterize everything in DT. It's a judgement call
> > > between implying things from compatible and explicit DT properties.
> > >
> > > > With all respect for the simplification I think we can't do it here=
.
> > >
> > > You can. Any data in DT could be in the kernel. It's a question of
> > > balance, not can or can't.
> >
> > Not only, it's also matters of what exactly hardware is: 8 timers or
> > timer with
> > 8 channels. If it's the former one, I prefer to have DT exactly like
> > originally suggested, otherwise I will agree on your proposal.
>=20
> Yes Andy, its correct, we have 8 timers in the hardware which are
> independent.
> Also the timer framework provides option to parse all the device tree det=
ails.
> In this case we would pass the timer node to the framework and get the
> base, IRQ and clock. If we go for a single node approach then all these n=
eed
> to be handled in the driver, hence making it complicated.
>

Hi Rob,
Yes, the counter and timers are configurable on another SoC. Do you give a =
nod on the current design?
Shall I proceed with submitting the next version addressing the other 2 com=
ments of yours regarding the description and the unit address update?

> Regards,
> Shruthi
>=20
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >

