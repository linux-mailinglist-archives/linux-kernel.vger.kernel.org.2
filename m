Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B27399FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFCLdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:33:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:54255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFCLdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:33:21 -0400
IronPort-SDR: nlesB7swwD4wLrZADgWt4yx8gI94YCfNwhNsxASmuzZluxiX/N95SpWuCkvfAexYNpXhTAkz/w
 s+c/Al3Oon9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="183704849"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="183704849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 04:31:37 -0700
IronPort-SDR: aQooy8VRH9hCMO4AAuLBhJeoRgsXf8OU8qygfj7gUq6FXYTWmNEnYSoug4qwle/GJVTXkB0kgT
 Fy4+2MPIcy2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="400413630"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2021 04:31:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 3 Jun 2021 04:31:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 3 Jun 2021 04:31:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 3 Jun 2021 04:31:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alCMlpgo6yvbSMrst5OgI+AF/wwqP029N83xc0hBvQaQFier6c50k5/Ljp8dCFsLNEaWRFGog9dNrfB1G4Nz4UgJSwKJS48TIGMl6cJxnzOg0AiGBO9rX1eTxWSy4v/8pA549+lVmZvPbSIIWDnzolpJi9jkBM9HU9mOY5jAroXmtjpJwAJakR0HdVXBg1Mn+ZeBZq+sIspaJiU0T2ZE6Ffn6Fw2dAjTl1JIzFVijM7yMdw5KwUviOpMUbo2f8mc1jM2SCEvln8Y+2SoZKR50ap6BxtD3RmPgmb6dVUyRDrrwg5OLKc1Pp9dYespvPtUcrOmHPISU+1o9GAr+uuGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMH6BOw2zAq51CR+IDbh19jzsHi0cLBpwYK245sCcK4=;
 b=EhoFMK+wT+6jQ1O9D7Z7G6X0sIlWehB9uKEu5NyrdOns3pDlVXKCzLjwDmp/gH68EPOIMrSprfPnuINGKxcUQmM3KSVK4i4omfbUJygc18C3/UUaQxUJ22kyocAmxsvYnMi/HohnJMXHImrd7tm2JcWUs2lwhy/U96jiV6XBsTR/Q5LAYFJKUuh64Z+cdHQxfIJ8ewIfIuFq78b/q1+srYKzsAFy2xvZeKrc9OB7bQ+Zj0hq0ofprxe34sfkPW3zdHMM4RgXaENjTyuuI8/fi3W6088VLpfbNVCM88isZVgKXFwavx40BFhyerbaHxux4pS1FELTRIcTTamz7bj+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMH6BOw2zAq51CR+IDbh19jzsHi0cLBpwYK245sCcK4=;
 b=ODL86Ueps6t4m21MOxHBNRd6pidaGxSt26SYEweDTM1ZLngL8CDhf1MHGAKuQ3MbfrBwO1dXiX1/kGMOy9/ZKYaBdot3X9lEJhv9D+LD3Dhw7Y3yeLwYaYsYJVjE4JrzjOLNhYjjEeZ/1oP74oEY7Sk26xkKtRe2PLrgOgZeazM=
Received: from SN6PR11MB3133.namprd11.prod.outlook.com (2603:10b6:805:d2::14)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 3 Jun
 2021 11:31:32 +0000
Received: from SN6PR11MB3133.namprd11.prod.outlook.com
 ([fe80::c1c8:a16d:8e1c:6380]) by SN6PR11MB3133.namprd11.prod.outlook.com
 ([fe80::c1c8:a16d:8e1c:6380%5]) with mapi id 15.20.4195.020; Thu, 3 Jun 2021
 11:31:32 +0000
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
Thread-Index: AQHXUsMHqKFo19ik00WR9uYdYCHeTKsBI4aAgAEKGHA=
Date:   Thu, 3 Jun 2021 11:31:32 +0000
Message-ID: <SN6PR11MB31337B2646C812ED2B88DFA2F13C9@SN6PR11MB3133.namprd11.prod.outlook.com>
References: <20210527063906.18592-1-shruthi.sanil@intel.com>
 <20210527063906.18592-2-shruthi.sanil@intel.com>
 <20210602192145.GA3800420@robh.at.kernel.org>
In-Reply-To: <20210602192145.GA3800420@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.171.223.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9c65932-8bee-400d-4ed7-08d926832398
x-ms-traffictypediagnostic: SA2PR11MB5196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB519685C4820DAD81B5814249F13C9@SA2PR11MB5196.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwDOBX1QNEn6Lq1LspFCLMNoWugcvuh3A404eM9AE8qy58b/4t9yv69S8COutTui0CqAkpRGM/UGIbVKDINwbubDlNas5YgBgs16dckPAHkZMj8OiM0slbbqczoh1s8k9Z1N+X3zpaUgDcHZ12OcRVGxalFnFSYE68kI9J+IGh0UyaWF0UJPzGlz4pSt0XN917QuRp8mEAh+67RqVrVo5GdK8IQki1tlviCC4/ojxyqT85TRTf3vqxkCFdIojVfSZgWe6pnh9qPoo03w4TisjZwM63noyc406E08Hv9zcezycJJPIQeeTVujaO5MhLhPIP2S7Q7tHPhymgXDFGdltoK2dJhssDrnDilkkJOygELViw6uJliaMrn1rLe8ZYQqAuv+Su49LnFyYDu7DJQUA1b1H6BOyisAoe1vfOsnDThqPOPZ7HXKVIrZmlY8X6q0UwkrhKZHFq9lZYIRbI7LnD8SUaEMatUuRmLgFy7O/U6Kj1t//hpJsrghZFTEdppClWR6qgle8rLHeNfurWqGv7OPK2bPtVud2uqFsGcHjR4n8kHUMU7wEYAipA00xBQVv4BXiLCR8gIYegpm5k0JoPX1h/PDHhf75Ek78/7t1Wsa/sA3LLvfLaSCqRma88W1+eORE4iO0J+CZZd5mub6wMUDyGOUI0auP66JmLIXpB3gNkR8g5uY2fgGKHVyFMfU3XYWboM1c820YOpks2rLQ3ck/NRDHyDjXT5s4+Ve0sMkyiP7BYZVRrTzcxsyl9cl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3133.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(6506007)(8676002)(53546011)(66446008)(26005)(8936002)(478600001)(2906002)(186003)(76116006)(66946007)(6916009)(55016002)(71200400001)(64756008)(66556008)(66476007)(9686003)(966005)(4326008)(5660300002)(52536014)(7696005)(86362001)(54906003)(122000001)(316002)(83380400001)(38100700002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Mrv4hEFmfYsLRkc0RctEqAypa9cIADbh7faqlhASUZjLOUO/Mk1EeSxj7dTb?=
 =?us-ascii?Q?U/QlMxbBQxLJnQ84JmsqUBM9VX0CaTcUe9gxUyiSoGv1q5p+mpDHk2M1jnnO?=
 =?us-ascii?Q?7gFCCkOiVG1MLy1ASGnLC4fLYJHq6FcAsZIH8lNDXLGouR+ivUefAelDeues?=
 =?us-ascii?Q?JqA5gUKke5Hk52v3MZ3wHk4Fu/QAaabgBnNpkQNo4JuYKOHETHdjNj1qBVdP?=
 =?us-ascii?Q?AvhLkhs88yVBkQyyk1vfG7eKeaWCnbn/R189r712gPmehIxAYiZB5GT+xsKf?=
 =?us-ascii?Q?qRxDuv1n9zqUhGjiC6wB9QTiw/XsIdVrd4WWT6GRaC1aBcdX+s3Mew5r+HfK?=
 =?us-ascii?Q?76Vo6504X+Zlgx4zd2KxDt1ObLOQFhfDoLDYpRxSRHxcW6dQnlyNLrG5Ycx+?=
 =?us-ascii?Q?ePXlpo0VZ5visYVaWp2F/woUWO2FIoRravpll6PcKUxO3K89MBKXXiLZNBRf?=
 =?us-ascii?Q?nR9fYprTa3Xmu7SsgKp3Fg/wYND/tFUnEfQGmbmkkBZJEuAS/XjGD0L9FQwR?=
 =?us-ascii?Q?SG925kBVcW5zqqPnfG2qhJFmTaSvshiYvvufybKYCO3/sgh5jYrDZj8ATM+g?=
 =?us-ascii?Q?OaUNlrJYMLbgb52iP6IifDtIC2rJct8hGcthmroY3aY7R2t0Tjc8j4mLHX0Y?=
 =?us-ascii?Q?V1aLXMAHNEZIfIW2bpL7VHCegR6TKJ9iSZxlHNl/3cZWsUgG7m4qC891z4oA?=
 =?us-ascii?Q?Lq2hMyJDkVwdiAuU1o2miT8wWg97KkUwKCOkvcWjg7erZC4DAmcmP9ZpkeKO?=
 =?us-ascii?Q?TJYILL5jz0xgA0vUHpbc0nCwl1ErYtYifPusyJHW+tUnZ8+XjvzzKyy1E4Yk?=
 =?us-ascii?Q?6KVmOMvyg+7qecTUro1qeWnFJBJFKFFRl6BoDMHHtclDW4cbQcVR0PVQdmD4?=
 =?us-ascii?Q?zfLDLtW1W7R8Mu/N4ywIaSsjaWW76WMxYS2N3NXH4e6ceSqrvYBIUF8vuZ1A?=
 =?us-ascii?Q?HZMo75kFgqFKecupDaqdwQQl6nyLbojLwreSWt1/wvb940lyGMjTH/Gh79Ei?=
 =?us-ascii?Q?uU8WV6fzmTB337dCHVp4ZqFsiLxVk6JqMCVlP+bY0gu+rS3Wh3h2LLxN1Ro1?=
 =?us-ascii?Q?vMXDTqJXcxtXmG+usTABD/PJPFVgO+/VMcPmC88gDeIHKNdeVY0YgMFuwQ7K?=
 =?us-ascii?Q?n2+EoeLtn691s1Lm0+P2BMfW4iBaMBo65yrn3cM9ZeqM8vpqKqitKv2xPKhD?=
 =?us-ascii?Q?UOcoFtM5+ZGOzbGDWEhJL2BCrSRbKkNK86VCOa6cKRMNiq3Iao/v4AJ4C+6C?=
 =?us-ascii?Q?nQ4A5LL6tJiDlI9J68MCpV0XrPtjr5yzBTkR87X4uTcp9MVkSDDrfUYdC4oV?=
 =?us-ascii?Q?mvUbqXNtMwkZE1eUd0PqZ3l8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3133.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c65932-8bee-400d-4ed7-08d926832398
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 11:31:32.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qY3/OIg6Gb/LigVJkMQ/MGWPPg3wefwJlbf4dwqoWAYWTRg8bM+ic6iF2Y9XBrJbD4+ZE1oZto34YXpKbjJnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, June 3, 2021 12:52 AM
> To: Sanil, Shruthi <shruthi.sanil@intel.com>
> Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> On Thu, May 27, 2021 at 12:09:05PM +0530, shruthi.sanil@intel.com wrote:
> > From: Shruthi Sanil <shruthi.sanil@intel.com>
> >
> > Add Device Tree bindings for the Timer IP, which can be used as
> > clocksource and clockevent device in the Intel Keem Bay SoC.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> > ---
> >  .../bindings/timer/intel,keembay-timer.yaml   | 180 ++++++++++++++++++
> >  1 file changed, 180 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > new file mode 100644
> > index 000000000000..e0152e19208f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/intel,keembay-
> timer.yaml
> > @@ -0,0 +1,180 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/intel,keembay-timer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Intel Keem Bay SoC Timers
> > +
> > +maintainers:
> > +  - Shruthi Sanil <shruthi.sanil@intel.com>
> > +
> > +description: |
> > +  The Intel Keem Bay timer driver supports clocksource and clockevent
> > +  features for the timer IP used in Intel Keembay SoC.
> > +  The timer block supports 1 free running counter and 8 timers.
> > +  The free running counter can be used as a clocksouce and
> > +  the timers can be used as clockevent. Each timer is capable of
> > +  generating inividual interrupt.
> > +  Both the features are enabled through the timer general config regis=
ter.
> > +
> > +  The parent node represents the common general configuration details
> > + and  the child nodes represents the counter and timers.
> > +
> > +properties:
>=20
> There's no compatible, so this schema will never be applied. You need a
> compatible to identify what the block is.
>=20

This is a parent block that has the common configuration register address d=
efined which we would need during the initialization of the child nodes.
This block in itself is not doing anything. We have this because, we have a=
 common register that is required to be accessed during all the timers and =
counter initialization.
The child nodes have the compatible string.
I have validated this on the HW and see that the timer probes are being cal=
led and the timers are functional as expected.
Please suggest if there is a better way to handle this scenario.

> > +  reg:
> > +    description: General configuration register address and length.
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 2
>=20
> Not really any reason for 64-bits of address space in the child nodes.
> Use a non-empty ranges.

OK, I'll remove it.

>=20
> > +
> > +  ranges: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +
> > +patternProperties:
> > +  "^counter@[0-9a-f]+$":
> > +    type: object
> > +    description: Properties for Intel Keem Bay counter
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - intel,keembay-counter
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - clocks
> > +
> > +  "^timer@[0-9a-f]+$":
> > +    type: object
> > +    description: Properties for Intel Keem Bay timer
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - intel,keembay-timer
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - interrupts
> > +      - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #define KEEM_BAY_A53_TIM
> > +
> > +    soc {
> > +        #address-cells =3D <0x2>;
> > +        #size-cells =3D <0x2>;
> > +
> > +        gpt@20331000 {
> > +            reg =3D <0x0 0x20331000 0x0 0xc>;
> > +            #address-cells =3D <0x2>;
> > +            #size-cells =3D <0x2>;
> > +            ranges;
> > +
> > +            counter@203300e8 {
> > +                compatible =3D "intel,keembay-counter";
> > +                reg =3D <0x0 0x203300e8 0x0 0x8>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
>=20
> Don't show status in examples.

OK, I'll remove it.

Thanks!
Shruthi

>=20
> > +            };
> > +
> > +            timer@20330010 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x0 0x20330010 0x0 0xc>;
> > +                interrupts =3D <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
> > +            };
> > +
> > +            timer@20330020 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x0 0x20330020 0x0 0xc>;
> > +                interrupts =3D <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
> > +            };
> > +
> > +            timer@20330030 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x0 0x20330030 0x0 0xc>;
> > +                interrupts =3D <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
> > +            };
> > +
> > +            timer@20330040 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x0 0x20330040 0x0 0xc>;
> > +                interrupts =3D <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
> > +            };
> > +
> > +            timer@20330050 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x0 0x20330050 0x0 0xc>;
> > +                interrupts =3D <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
> > +            };
> > +
> > +            timer@20330060 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x0 0x20330060 0x0 0xc>;
> > +                interrupts =3D <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
> > +            };
> > +
> > +            timer@20330070 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x0 0x20330070 0x0 0xc>;
> > +                interrupts =3D <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
> > +            };
> > +
> > +            timer@20330080 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x0 0x20330080 0x0 0xc>;
> > +                interrupts =3D <GIC_SPI 0xa IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +                status =3D "okay";
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.17.1
