Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F090140F170
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244667AbhIQEqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:46:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:65222 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhIQEqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:46:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="308266242"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="308266242"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 21:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="611148548"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2021 21:44:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 21:44:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 21:44:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 21:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA5MAcylazeLwRHmqMeYLIJ32lwrcX4Rn7bj9yEfJyc/W/1Z6cxzyecNzoIpsvJrmG4yIe1Wig25+iSB6/jRcictww0yBVv6DJ610246/uxEykUKFcd+aS6rKKCmepm1I2AgEHKsU2Q/s7amqw+Non7d086kDBruAxjtXsU7LCTu3jTLu5GZ27Z5+6WAW5yIv7bsvEuzq618D28z41ERM7sOyexSKqLWixLxyLBgTFgPf4Do8fIpJ8Jamu6JrmFg8AdJ0Hzs71Yg1OzgxNl3C9j5c+at8RwVqrxcMHtIzKzfhKBGzxz95AF7hYgT92bnBlre+en1E4KIRp+eAZNm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XiEWDngL0J8IwtQ7wEU9yjGjS6gQeEfTVsBkKwdDc2g=;
 b=mSYc23bcYThwWEVAWQfqLdsW2JbMUA4lL12lVISVO7LD1ur4DMu9W1fG2uLyZ+Nnphni1rJHlBdmGzPt4Sb7hpKglhiqqQbao1zAw1aYigWfMak7+2UwU3sxvrD8OMDd9bm5EwmiuDNw3bp0HQ7TEnxLxbaOwaYArJK5H6ciycSYRe3ax0m2UgN7wfldwrTW40os5vCHIbKMgsrxBx7Tpol3p4JaWQDXzKJ5q+h/zMoSrs3B/EHBefUfTXnmYLpYHQD6YDfYMW5gCjzRNkTHcbAg2NP/Ksf57Vl2r5akuch4VXynTxX5PCQyagp7DG8+E0Oy/XxkRkfh0iyVzmgGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiEWDngL0J8IwtQ7wEU9yjGjS6gQeEfTVsBkKwdDc2g=;
 b=ekvH9Rwg/Z7F8ea+laMkUV46KzonU57U7bApXRPXRd4Eb37xF4LgAqesZS+AjLCohrhNoqKCFsug6CW5i2AhTybc9ODKsTf448asIi3ChAvJ1qd+IUndYd9d2Dq7S+8o4MOw5awkZ0B22eW5S71OCsOEzUko8wY+ZD8szlJVipA=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 04:44:13 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::a5c1:3436:6dbe:f14a]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::a5c1:3436:6dbe:f14a%5]) with mapi id 15.20.4500.020; Fri, 17 Sep 2021
 04:44:13 +0000
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
Subject: RE: [PATCH v7 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v7 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHXqMfNL5OqpoLD/Em9Sy8AMwk1fKunGTIAgACSNjA=
Date:   Fri, 17 Sep 2021 04:44:13 +0000
Message-ID: <BYAPR11MB3128D11263BA332DC03D2A95F1DD9@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210913174955.32330-1-shruthi.sanil@intel.com>
 <20210913174955.32330-2-shruthi.sanil@intel.com>
 <YUOiKjfSLm7DHoXG@robh.at.kernel.org>
In-Reply-To: <YUOiKjfSLm7DHoXG@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85a31a69-6e23-4420-dc62-08d97995cc74
x-ms-traffictypediagnostic: BY5PR11MB4500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4500F319D0142AC336CC8632F1DD9@BY5PR11MB4500.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7MtojnEEoS2TWpJrpfIyw3LBvJh3bjbrkwdOLcC6J3Cwx13mFYUA+2AMTMm27L8KDTlDXSSJlTfu0oq9LlNoHJvs2oz3uHa9GejFsR+k8Ec0HiWq5dV4toWu1sz2J4FcrU+S6WpB0OyN57tlrLaMhqNG0+602eZlPxIRB2sbH6rbBbAlkuOgiwUREIMv7qfik8GfRB5vn+b6dDxQ8zCBwvyg087Id5AT45LqFiB5Wi1oG8gI/RN3U5+5zNNWIwpHND/Cdpm14H/rJ9FPAFrdWE5g2rO/AysHpU0Nkq+fw848JfcR0O9ng5ki5DzJvspORUnY7U9F4p/LphJpV5SH1Pq7+ftxRKuh3TKOz7nIUFP470T+KavBuvbSafkBwTdbcFt045IndNL6P9AAOIqoGrZ8G51Ls4R09lVfXLdcurq6LWZGGFbq6k3fsFhL7tf6XjRX934IJi4uW1DDi2NSsrh6R+6F3yXStuLYWo8pkhPpiwQGsQSxqzgP7FMxppodgL7EAmbx6sdfWYFt1PzabKDhbpf794VD/At5381OsEXHXmg4blEtevVE80VXwgaCb6aJ7Q1vumahTs3WcFkgBiFAkCtd87d8i9+HIj9xZ8UojEvUCL1yonpZcSFCiYcLrGrvtjHwQF0S+XGJBcLGL/ULVaaVSE0uzy8dZgPM+b4lKR3Y39LXxTTzmGw910/wlovydKktloOGyxatpxBDgcD5n2541IwukjQ7sJJYNjv73DI90ugRmqWsgWlV2B4GYj/WKMPBDXKpMQqjy9Yj/7bFogFa/S3n9okUO7LP5zrhFca3tFHB21UWXm5pMTcHt5dWpscSIbIzL6u+v5Z2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(966005)(33656002)(54906003)(86362001)(71200400001)(4326008)(55016002)(26005)(316002)(38100700002)(186003)(53546011)(6506007)(9686003)(2906002)(55236004)(122000001)(7696005)(478600001)(66946007)(8936002)(66476007)(38070700005)(76116006)(5660300002)(83380400001)(6916009)(64756008)(66556008)(66446008)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K4E6Nk+4xLd0u51TeVIxM7OrbRUD3hWpCLgwvX17FsPPAx4b/YVXvfccfC5Q?=
 =?us-ascii?Q?TKqd/DuoqDpr5eAakB24eKh9+F+E2N5L2Pf/vwWqmHNy6BaQoamLnnRfa+2H?=
 =?us-ascii?Q?ESAMIbj0ZeG64wPQkLQkj+74wyH9tQETy+STCbZ73yzZ77cfLvfQBJRJhxFu?=
 =?us-ascii?Q?OBFSmZCFxlPMrXHbCiB5GPfadEId6BmrRZIaOPOTO1RJtuO59JNhdQBe6Ap1?=
 =?us-ascii?Q?pxU/p1QcrrYJ8EK/SSycA08zpWvOa2aM8fleRCMbKYNbpC0Fjwd6QWhTdGed?=
 =?us-ascii?Q?EerzDChuvBS9P1pwIx/tTBm5wlqEXDMw6KZS6VkkpVEm+gTek5bKBX3jDXh+?=
 =?us-ascii?Q?rCNJFZPll2y9K6MLPh+m0TZUIiLGDpnCIy8RBnlrDXo8rjV296am7xhcsH84?=
 =?us-ascii?Q?0XODiZ4iYSvK0kXERFl1sWQC7TdeQc38xKDPrzb/Pl+jAoF0Ry+d74c+Ng5v?=
 =?us-ascii?Q?wun8LHMvT76kE9KPAK/bom8aKbk9tTnSPLbQ3JymURm/c7bvqFX9aegUn2N7?=
 =?us-ascii?Q?YCCJLmgzEX8+g1aTn4MJt6jOn1lV0n/zNpFYRXEhvPf3NL+O1YHMGia9wEZT?=
 =?us-ascii?Q?8J8EWksSJPH68ZqwkHKEimgW/bNIcG81+zGlKobJFuB3P4AwxIkiYR3nVRiV?=
 =?us-ascii?Q?yYhKJYmW0SS9bsvRYlZ0aWlrntQM0ikBYUjStBxflyq+wIR+IK4kWGnT3n5a?=
 =?us-ascii?Q?Ba+Bi/NE/PrPpN3WH/wsYiW66rIGxVn5GGeNH4Fsyymwx7wNKPakMy49wiuh?=
 =?us-ascii?Q?CZnfS73mfYLd1HTEKtLuq92/tNicWZVMIYCSvhq/jWrNPZpNTLCWNTFDpqWA?=
 =?us-ascii?Q?h7UOOTIvIam3qJdNXEMBe6+vPgv+MVLdkXbrh9ESvU8jV3f+kSuXBrSghun0?=
 =?us-ascii?Q?LgcdLHF09w5vm8fPpkDZnztx/n1I8IoPhrF/ieS3pUM33YZWhdF/5nP5Rl53?=
 =?us-ascii?Q?RLtBwbu73GWn/7ba5e+iwn+IZsLzzD6Xo5uE3QPEpn8RBZdLga4UpYmQ3aIP?=
 =?us-ascii?Q?t1wuEaSiHYo7K+1uSAMD7PV+tar8nuKFTF20LM3oFFz0JhNBaqR47WIwBlgl?=
 =?us-ascii?Q?wvzc5Rq5mft4b1KvHtGXToIFQke/3tie0vJnRRrjbT96cr7233DDlTLg+McT?=
 =?us-ascii?Q?S0JDm8Do3cSIUEVNHG2+We3f40qidYzXxWpbb/LYxANzvkDvqusIZHuh5+X3?=
 =?us-ascii?Q?AOTDj/9USN6yS3NuwWUoSKvOxYeZGalCEvERSADTCN/CdrqPSuDIkqX+W+o6?=
 =?us-ascii?Q?FvmzvECBcMCNqbVsJAEBh8AgZsr2wPvnCGqlYcQSoW09p3zykNaXlHUgB8cZ?=
 =?us-ascii?Q?yHIxLa+34V/JWStS7LZ26G0v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a31a69-6e23-4420-dc62-08d97995cc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 04:44:13.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9B7LOCuJNQuBDnLj5ap6RadPuwM2nZUuoOcklSSrw9Tz66FNZMstsgX0rCA6Vb7AmwA45nyFVg66VY0SaICmQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4500
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, September 17, 2021 1:30 AM
> To: Sanil, Shruthi <shruthi.sanil@intel.com>
> Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v7 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> On Mon, Sep 13, 2021 at 11:19:54PM +0530, shruthi.sanil@intel.com wrote:
> > From: Shruthi Sanil <shruthi.sanil@intel.com>
> >
> > Add Device Tree bindings for the Timer IP, which can be used as
> > clocksource and clockevent device in the Intel Keem Bay SoC.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> > ---
> >  .../bindings/timer/intel,keembay-timer.yaml   | 172 ++++++++++++++++++
> >  1 file changed, 172 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> > new file mode 100644
> > index 000000000000..80e7785845ac
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/intel,keembay-
> timer.yaml
> > @@ -0,0 +1,172 @@
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
> > +  compatible:
> > +    enum:
> > +      - simple-mfd
>=20
> Removing is not the right solution. What you need is:
>=20
> items:
>   - const: intel,keembay-gpt-creg
>   - const: simple-mfd
>=20

Thank You Rob! I'll update accordingly and submit the patch.

> > +
> > +  reg:
> > +    description: General configuration register address and length.
> > +    maxItems: 1
> > +
> > +  ranges: true
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
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
> > +            compatible =3D "simple-mfd";
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
