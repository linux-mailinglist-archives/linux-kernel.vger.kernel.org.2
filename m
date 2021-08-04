Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D223DFB08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhHDFZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:25:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:53156 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234486AbhHDFZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:25:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213580370"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="213580370"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 22:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="568906032"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 03 Aug 2021 22:25:33 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 22:25:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 3 Aug 2021 22:25:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 3 Aug 2021 22:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7lB6HeYLlo3DxT+P/0auEUsMixLIatjKag38NTexphMXzb6Z2yUjDEj0fyrJRWUZ2UjZw1olVrlOHCgk6nS6hv0liUnW0YOlD8SB2EuDIvbT6EvUdChNOrXlaKjb3pdfU5JemmCeevk8Cbm1888JTn5ThHAZJREgFemndhApksikHtg3x+IneGEXTO4CN3sW94HePBYCHXBhs/FnPS+ceLKpCyFha/AABCkISGOTc+/dQZ4V8apxKqz+cANr/orGWqT1aBAR+V3D9rqSWwRG2W06k7UZIK75+/82vH6IgEM4wB2x9Y420Q9bRHlKAMUW3K/WhrOc1kbkCil4YOqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjsflkylbJyLxTl5ASHO6b+cns6O66g30OWzhOb5h/c=;
 b=jOFdG9heAe0/W3fNrWRsMjuvatRQHUwLhJ6Ig8YchbQLpyVUpzETOqmC15jPE7/F1XRqo3HVyz5TuQNdMY2cxLKb5mWzLYEftVE58Lc4GMeXLvDQIfN4SQMHmbTcsDSew18n+4bQIqnFoahVrw7AwKMMLDQacwDWuyKUDbA8ThGnEICowMTK+FX8At0q0bw5prpWIQVS2HUdcDX5wO5mJfbdRo+DPgvRPxaEdMFLzhCRAVgZk7O4pE8r7NKGSKyD0PX5aa+hP2Q+gtgOy8N04gP4VSGobLgpJvMVC/+A92XStCXWf5Sn+92OjXnY+W4y39SchM7uEga4PZUs9EvE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjsflkylbJyLxTl5ASHO6b+cns6O66g30OWzhOb5h/c=;
 b=SM5PpZRgFonuaimvR8aEpCkZiwdDLm2TYIeseR3QlTcu9fob35YNNgPL5pxUG030wZroDAj8Ch2QpCJt7EyfJdbckNx7uDez0yPOTpOlPoxuaH7abq8DZY5ZYIEhM0yewJ7gvlfVHHY+teBT4qNRV9C3Iq0yJMzgbkRvxqHt3BE=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Wed, 4 Aug
 2021 05:25:24 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4%5]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 05:25:24 +0000
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
Subject: RE: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHXhDwnISnVoEGfdkW14/liUG7Tv6tg1zUAgAH+PcA=
Date:   Wed, 4 Aug 2021 05:25:24 +0000
Message-ID: <BYAPR11MB31281638EBA0C2B815DF56F9F1F19@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210729053937.20281-1-shruthi.sanil@intel.com>
 <20210729053937.20281-2-shruthi.sanil@intel.com>
 <YQh1HMMkJyO8g/RP@robh.at.kernel.org>
In-Reply-To: <YQh1HMMkJyO8g/RP@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ac4d7e-f187-4e94-e2ab-08d957084316
x-ms-traffictypediagnostic: SJ0PR11MB4925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49256D327DD1FE41AD914021F1F19@SJ0PR11MB4925.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PCqYIiH8kQL2r9PFbMaWoaoTk6/1LB/XQvc+fRusDGG4SUS8pTQZmrX+2mRKsbf+eM4JtIVcC65zy/CGLcCPRc1BbOHi8gEaAiJVWBFENnyDgFoW6QWuO5+kbI8GhKYKF+pk5WZGnw+GtSsR05l8+IdSneNUtSIVPX9uk+MK3UhNVrKW8mpYQ64e0Up511AiiJtej95guj86rlXieKsg742NlXDLDgi5lX9Y3CA2plEHyBj/yeaIYkEHrTIDOWykatIKYYWuHqt3nK6G4SEKwudZy+aCAuTTZKxBSgnt6k8YMujH2b5hB635+fJk74rPdbDxknHi+q8BE6gEXDBApS4GQvfW4B+Q6kw4ywyNTW0EjaFKqaTd8D35d++Xpxd45saSXHknMYyfZe+ibUt/upyHaEAOgmKHnTwvJ8TGrO50g+m26iBW5l38MkMocu/X7d/7iJxTZPoq2FQFPWjXoO7TDreWrTMplDeHVCl6D0Tmo/5HcKQ5WTesk0nsiHZ1sjZOdTaX2CoZDTVfaE/BWVYspwn3qSKBZ5EBJHZm/kbaMP2wD8zVbFNf/fo+VjDYzMBlTkRMbw8G9ii590xJvVKOXOTN1R1rLOyXwhTaCVQIDjcecKwHNSyXwkQXww4z7Q02IdObn31nxwMK7ttD2bjMXd4wijIDt0W06CunnhvNAeKlKHlqucLwSKSLI2TBSvJ5+oB737lc+foIl7iX/LaGLJUPYkdALbC5q8GpFUdGzZ1yKdaxWG+k4O2W8MPb0K1cfK3Z/i6R0UEs1mc+f+zR7d88gxSMQvasgJ17ns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(122000001)(2906002)(316002)(38070700005)(38100700002)(64756008)(66476007)(66556008)(66446008)(186003)(66946007)(7696005)(76116006)(6916009)(53546011)(26005)(6506007)(4326008)(71200400001)(8936002)(8676002)(86362001)(52536014)(9686003)(5660300002)(54906003)(966005)(478600001)(55016002)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cq7veWTjti4DtGs1SVzSk1HaqbhefmiUiqT/42L9aGz4Ct0NTFNpOOtS/FXv?=
 =?us-ascii?Q?s2SBqZ16AU1pBPIw6S53YOR91wIym28BghP+a17YBbbfX9dDzm0COc3ecCcz?=
 =?us-ascii?Q?GGJ+wy7ytlpU+dwA2zfgXxVYXCTZJyA2mOa9agwVY3a3yJnIThGooIKQqkgU?=
 =?us-ascii?Q?27TmlcodWae7VGsg+mBKPXk1INg2napXbirrDp2zQNaC2eQpUFUjebC4xlkC?=
 =?us-ascii?Q?nSmZc7m/Lpwxru0Yh7ojfK2cevLCl4NnuQhd4ND8XK4OSHZjWd/tKFFY7guT?=
 =?us-ascii?Q?e2zFTK29lMgUlK7Lnc0uEbIqXZ6ksubXVLtDr4On2EfEXtMFw22NelWO8v5l?=
 =?us-ascii?Q?quY2XlKrO/q+667Qw0e7A3GqdhzPtwUiXy/d+9nuMMEEKtwKFoezgBsREw4O?=
 =?us-ascii?Q?ckJUwRZjJX7PV0t8HzpQYTk87flbU2lOK/CEOQHU/Qty8vJdT5/GsOg4/7ni?=
 =?us-ascii?Q?rS8KKw3GGRmVp7N093OnMPGI1VT0yLW6BQlEtNPI4L494sOuLs1YONbLkRc6?=
 =?us-ascii?Q?CCt/GqNLMt385jMSWPY0LuYxWj2oIJoXeWIT3ErWMQGM18ezzSRm03r8BgXB?=
 =?us-ascii?Q?O2Ih+toIGMKV8TfTQ4nKFaktYQL21AlNOgYH2ePzPAztXuD27ko8aN1ykdHw?=
 =?us-ascii?Q?iJNdgY7z3ROCC33nsXZhmqkfiXw7j7KsD4MBNRw3fRfNM7rXdi6vERmYwdys?=
 =?us-ascii?Q?0wS80UeMuMST+BKUVar4DInlYP+6Pls41szf3eGXnk/aWjAJvjozH844ngy2?=
 =?us-ascii?Q?/Go1I0n2I2Z3prE1PouDf53j9YtE6fkN8kM08BRLvGgZDdFp37JYqc/QO2DY?=
 =?us-ascii?Q?/38B0c/APEutP/LiIpzykDncJQAyqdZOLLFWCXH4OOd+9RixAK3BQV6uAOYZ?=
 =?us-ascii?Q?LlElUOGx3CLWDaZHS0c7vWqPU58IczsimD/31NDOO52la1JtznaxHXDlHPWP?=
 =?us-ascii?Q?CTEeIa3S8nbhuoTz8vRsrkQOxTSmxrPImwjKRvEdupL92qddf+4NB27Skfju?=
 =?us-ascii?Q?oh74BYtpv01hgF8zR7yk4WsDhnxnLpuViuMycCY9hLx6CViY4e0rFjILpKd+?=
 =?us-ascii?Q?d3JTNt6EFBvZ6Xnm/hU7TzsEufpEKXEeAH5SJhBQztNaZWVBwKgGDhUCv9kH?=
 =?us-ascii?Q?NjJkHli/5FE/hLcATHew5nWPag/k8X0KC9RT6R5hVBJkIT3K6Uvz6G0npb8Q?=
 =?us-ascii?Q?We3Ife5MmLEcILOObw1y8vkUAS0Sjz4+wEW1uVDSv6CqEwMTGKhIT08R26PI?=
 =?us-ascii?Q?ODbtQefO/oTKTaIQpKf6kH66SMc2e2orEYvAQcRCyk3SGMIeABEGB0ShOAu8?=
 =?us-ascii?Q?eiX96+azAc17OAkbldUvtGwy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ac4d7e-f187-4e94-e2ab-08d957084316
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 05:25:24.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8W8M1zHPn0MWLvFnT9MkqMi56k4OOXUl1Bc4taD3PFwOcaeg3jE69EjW1KxiNPjA+ZheMTgU6BLpWBd571cRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, August 3, 2021 4:14 AM
> To: Sanil, Shruthi <shruthi.sanil@intel.com>
> Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> On Thu, Jul 29, 2021 at 11:09:36AM +0530, shruthi.sanil@intel.com wrote:
> > From: Shruthi Sanil <shruthi.sanil@intel.com>
> >
> > Add Device Tree bindings for the Timer IP, which can be used as
> > clocksource and clockevent device in the Intel Keem Bay SoC.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> > ---
> >  .../bindings/timer/intel,keembay-timer.yaml   | 166 ++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > new file mode 100644
> > index 000000000000..b2eb2459d09b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/intel,keembay-
> timer.yaml
> > @@ -0,0 +1,166 @@
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
> > +  The Intel Keem Bay timer driver supports 1 free running counter and =
8
> timers.
> > +  Each timer is capable of generating inividual interrupt.
> > +  Both the features are enabled through the timer general config regis=
ter.
> > +
> > +  The parent node represents the common general configuration details
> > + and  the child nodes represents the counter and timers.
> > +
> > +properties:
>=20
> You need a 'compatible' here. Otherwise, how does one know what 'reg'
> contains. Also, without it, this schema will never be applied.
>=20

This is a parent block that has the common configuration register address d=
efined which we would need during the initialization of the child nodes. Th=
is block in itself is not doing anything. We have this because, we have a c=
ommon register that is required to be accessed during all the timers and co=
unter initialization.
The child nodes have the compatible string, which is used in the driver. I =
have validated this on the Keem Bay HW and see that the timer probes are be=
ing called and the timers are functional as expected.

> > +  reg:
> > +    description: General configuration register address and length.
> > +    maxItems: 1
> > +
> > +  ranges: true
> > +
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 2
> > +
> > +required:
> > +  - reg
> > +  - ranges
> > +  - "#address-cells"
> > +  - "#size-cells"
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
> > +            ranges =3D <0x0 0x0 0x20330000 0xF0>;
> > +            #address-cells =3D <0x1>;
> > +            #size-cells =3D <0x1>;
> > +
> > +            counter@e8 {
> > +                compatible =3D "intel,keembay-counter";
> > +                reg =3D <0xe8 0x8>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@10 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x10 0xc>;
> > +                interrupts =3D <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@20 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x20 0xc>;
> > +                interrupts =3D <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@30 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x30 0xc>;
> > +                interrupts =3D <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@40 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x40 0xc>;
> > +                interrupts =3D <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@50 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x50 0xc>;
> > +                interrupts =3D <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@60 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x60 0xc>;
> > +                interrupts =3D <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@70 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x70 0xc>;
> > +                interrupts =3D <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@80 {
> > +                compatible =3D "intel,keembay-timer";
> > +                reg =3D <0x80 0xc>;
> > +                interrupts =3D <GIC_SPI 0xa IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks =3D <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > --
> > 2.17.1
> >
> >
