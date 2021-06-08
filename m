Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88639EE92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFHGPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:15:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:10586 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhFHGPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:15:31 -0400
IronPort-SDR: 4l+vAK7fbp7CuiCBUMyFnQkJzvXZC4LpO+pXIax/gMAUGhTTVTJegau+J85lzVMVl9AA0U6C0i
 8kFC0kRuSN4A==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185153380"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="185153380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 23:13:39 -0700
IronPort-SDR: 9OqVDPUXy9ObuBswqg8djfNVQa9rUn/Ny+wDlZhEVYnKuhkffDNm3yPSY3AEXIbzTqhxGun88d
 ZxW4JjQmfsZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="552152287"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 23:13:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 23:13:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 7 Jun 2021 23:13:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 7 Jun 2021 23:13:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 7 Jun 2021 23:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltNth2sNSdBCYpreLpam/NgTXyrMKVpyf2XYPc/leDIsy7GyINShPwfU5nYQ3EmUSQpdZ0eXl3FiQZQsc+5HMt//HeTmR4r7Px7uxjK7SaHP2Hsz5G7js1TmXHGN+XnS8Gf9bi/9iwC6R7UCM9W719ojFbFbdnZ5IL338hsmwiwbFGLSxCqmFkUQQFUbMkDhXRtcl6Y0pGsyZgT32bFjLJoou7t9cuUU1sMbT/jFINk045cQOPAa2rH24QZO6EDD6nvrBYPSW6A/nSYvP6ayNyO8wroa/AWkUuaYh/qvFFqsnc4zqFltRA+hSGK2feRXipF8XuTYQ83dLo+2gQfQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhB//jyo9UIpL+asHaJjwSRinnVTZYNlSZQzmbnvNgQ=;
 b=aEElOdgaEA6IeH3Jlp/vM3zMqtJ0GnT6iHnmwkPgtOk1qwEFhe7jjcnETGJhc3FH1yCtncGLxNnMM0QR5S+pz+FrTU/+HSlaGcRPCxErnC2sDYANTk1ZnoE55pRUSj4R9YPdnUCmgDeRI6nRbMYKIgXXViXzdXLVsQCaDIWJaQZbBJavAg3xPvVqDKSZ4lkBkiP0ZpHhuOt3otoc8DgfOo7jZ2vpDM5ik19Ar+zK6Ds+v1XGINfTTElhtQv6TD1RtLlbuTcg1UUP/TmHs8nZ/pdVSUcBJOIat0dWE0VWIwMd79GvCd8GdN1YX1aImztrLj7gTdPh+Tdp6gRfPLI0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhB//jyo9UIpL+asHaJjwSRinnVTZYNlSZQzmbnvNgQ=;
 b=iN47Wr3zJ2vKflBWs+uglFGJd7BSGReUzlySJtbuH6bdGvjWHRn13CiKi5+xJohZwBGzoGXkeNidoKKNPyZM+zQueeGq3Epls4plbesHWYyP6Q3UswhnE9pvTkOR5foqtlydPbZwFyXykc7M0cVPL5pm7tgP0ynjfDs5XFc+AMQ=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 06:13:35 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::c34:1c49:28df:c09d]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::c34:1c49:28df:c09d%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 06:13:35 +0000
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
Thread-Index: AQHXUsMHqKFo19ik00WR9uYdYCHeTKsBI4aAgAEKGHCAB4cyoA==
Date:   Tue, 8 Jun 2021 06:13:35 +0000
Message-ID: <BYAPR11MB31283CF1C76E27F7D8C2F444F1379@BYAPR11MB3128.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 28291f81-263e-4c1f-f14f-08d92a448cbd
x-ms-traffictypediagnostic: BYAPR11MB2824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB28241AB22A164EF91DDA36B0F1379@BYAPR11MB2824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OUL2NoKH8JhJ9rrfsx/La1o7qNc+xsJszGqs22XLBx1jKnysppLkf+OVm6CVj5z4K083D82GbmjzOayQ53Mjk25NL1SuhHl7FSTB+wnDK2+6IuU4sBDftJkFIO7RZtsBIbKWKBuMXIEY4/3lM9HSRI4EAS/rRheXWIoAGWE1BdzL8M3Q8I2a46EZ8pADgMV3ieqP9n3ecvgZODgDrRCxpITTQbH1MnE829R1M5bidQ1bw21sWVTYSv2uocH4E07jCPF6v9nJpin5TYGxZXyrv9YvvuPcSeekPMCfsqohOHSWTQb+cm6vwOLqrxf1Q3QYYqlDwtbfMbw8+C4UTrunNYkeFKJbjk+ZSOmMGO5hSvQpv+do9h0qCC6rGrZ3ZbshQ85xxgC+q954Tpbad1XO+j5+qP0dE+RSJe66YmAi60dsf3vSXgMxzXrQXjlkDLtzd0TD3ax6e+HFwuCY/5U5SkoFfRhWCQxWzKfDyusMM9BKiVOe6rbw0ybHaTWE4gZYjZpbDqa57Gunj6tAitro4Z8ECaHeT3kb8Y13XT337EgIpEfsr/nGjfMwAkXfHNksKkyAbbiIS6O9yMkdAz1Ne7U4NwBisdrz4J0l6zxOlimR3w6gaCEHGXAMw6a62+ywZap28OxwP7cz6LoLS8hYVT9W+T9dro41PETHy3t0sFIIEu+P5xCx2E7mc8EykISBvvPYp+9g3LmSJ+Wp2nefUMYfVFwkO/qeAMWho+3ihR3Z+EjklLRMp5YSE2NbvS3+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(396003)(39860400002)(26005)(8936002)(86362001)(83380400001)(54906003)(2906002)(316002)(8676002)(6506007)(9686003)(55016002)(53546011)(52536014)(71200400001)(38100700002)(7696005)(5660300002)(122000001)(4326008)(76116006)(6916009)(186003)(66476007)(64756008)(966005)(66556008)(66446008)(66946007)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 0Gv8IwidyQAzazQNEX4ybPMGPFiHMRDfdfasm3IwKfE5ZKF6ZwQ1cHbpXkl1p8FX2+Hqu2QVItWBwlqc3Xj8qosagFmyjCDlEovhTXPIsYWdhf4mZKJRqR9ZEwejL7MWoVRyf6D/o3xB1PSb18YSDinSnpGVinqB4gnDPgsZXrXLJCTxrQdvCpteQ7wMEtRHYVwBWJsYxehqKWnvAnZZEHRX1gQpmTp8/CdVRJPM1F04rRGyoiYyfdhFfSQiwOmVxY+oF1TbOOpl2FRitttyBvxg75f8MYZTS3R4iOH8amdKWGGu4Yho5hq3rULuey9GwMUr+7+cZ0/RqSZmqJUO5f0vYqQog6pzS8vsod0ELAmOznGDHMjt9o8rYfOQr4owUwxCkMYXgz2JIGLOEf6SNRjZSOpxiPK67NMbQCevy97ZysY9vOwMTnuAHBkkxXI9K3cobyevISxvyasNPyFNMQaZ2ikSw5i8RaAZez5Shs3Qkga2pgQ2NEw0zOl/F4WdCrJZ+DaLrDOaO7oaBp06GtJnGOHOZ2N+/gqMtinauxG93Ub4ZiM61LmxHPILeFRlUT4t6+ZSo4IM84tsxjC/UzSKZbgx2pE0TmkFkO4vrfwIkg5gPyqO8Hvee9ygDocI8u/Kn0WUeP/wmAEXyRL+Z64RLxjlbPHOsbZB6zYA+NINGrcGwBv9AhatGO8CDbkjQpbWE++XRdILyR5aKod9Akc1cuGWCrkv/hEYzsY7EiQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28291f81-263e-4c1f-f14f-08d92a448cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 06:13:35.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDln8zHn4zXhwOBbHGXbgin1CF7W7Dx/wEbIXbYm+Rt44+LhNBDxBpAV7mLUh5cuNw3W2QP9TjqXVu78vU4riA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2824
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Could you please confirm if the existing approach is OK. This has been vali=
dated on Keem Bay evaluation HW and its working as expected.
Also please suggest if we have a better way to handle this.

Thanks & Regards,
Shruthi

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
