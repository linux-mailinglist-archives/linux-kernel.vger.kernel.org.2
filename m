Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115463C994C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhGOHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:03:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:20271 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhGOHDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:03:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210473383"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="210473383"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 00:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="630640999"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 15 Jul 2021 00:00:51 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 15 Jul 2021 00:00:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 15 Jul 2021 00:00:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 15 Jul 2021 00:00:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 15 Jul 2021 00:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBYo5uUF7mVO2ofdGmV/SuK5hYLN6l+CHjQXBMYLkrhjK249MmsM1OrlORS5kt2A+T5RvWWWT/0aak3b/2YVyGnohcZKE15dFmzDfE1a880T49S4kFl5sLZV/j2Ag9Qjvn7UhZWeOjsotkfBqZx460P7VTgOuuwAx8nYNalHLU1KRmZXEFOI6AZ/hD2JXLJQMe/FpPp51kGRdqaIKMTzjKT8WNP8EPLTWxB48S02d/LpTm5SabWWtYBemTqUuqOoq2pv70BSGmeI+TEICiNFkAbh0gnilYxOCjAzCkjZnzEAxWA7O+vlkQuoSuhS+7LbKH9balswn4SuibLbA8D8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXNoMlx0+wzVRLOryrd2JwPTJlsNn0OIq1m39XKR6S0=;
 b=CO9vJkFBMQkbGzzzWhfEr6mgruM2yK073gRIJA9blS2fF33Zd8x2tSDdasIE/RcKeYWvbF3KEVaKsQctpY85IEGajHrX37/Aa6Q3dazyHKUiCaId1sehsyu9KNE1I8UjVeLscsDoG4LER26TJ+TpI8o+bvd7l5hlRROR9VrsA68wfJN0ZuJ8+Z6alvCDHyXpc/125FEp4RNN0OIsKWQeQREPIBLU6mKm+dla/s9XpQ+CRn22of/cWGIuYFZl3CVRKE/XTgqasfCpLz8iI2sa/32GNfZB36UwjTP2+rhhFyvTNzXs2F1LPrLIE6xdP16gN+4GGTzJcUO9T/ylzvsOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXNoMlx0+wzVRLOryrd2JwPTJlsNn0OIq1m39XKR6S0=;
 b=xOLg9z08eRL2ZUtam2EJDD3t/KoRA6CakvRDbYsdLBUkA8xiRMcWB5Nwdi7BzK6YiZBlQ+O6OS1WkWN2O1xbgf5+lwg9i/4KtYfYSb40dd/2XjcxfzIl1rY/qANFxEs68DdxFb825dPWoMZs7qtJbo3XCeGPdB4wvTe6mX+10wI=
Received: from BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26)
 by SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 07:00:13 +0000
Received: from BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::b945:edd0:ebd5:12f2]) by BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::b945:edd0:ebd5:12f2%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 07:00:13 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH V5 1/1] misc: NOC Probe Counters
Thread-Topic: [PATCH V5 1/1] misc: NOC Probe Counters
Thread-Index: AQHXd7PdZivYur/1kEWpwYZUnXcrZ6tAeXqAgAMVBiA=
Date:   Thu, 15 Jul 2021 07:00:13 +0000
Message-ID: <BYAPR11MB3528AA1CD11585D2BC94DEB9E1129@BYAPR11MB3528.namprd11.prod.outlook.com>
References: <20210713065347.21554-1-pandith.n@intel.com>
 <YO05g5JiOcF/bFza@kroah.com>
In-Reply-To: <YO05g5JiOcF/bFza@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2be38b06-9d49-4053-a09c-08d9475e31c3
x-ms-traffictypediagnostic: SJ0PR11MB4893:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB489337C8D658537A88C6AA46E1129@SJ0PR11MB4893.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ktaLTwlZ+w5fRShPw6gtxzNQ2VNyJBfdU9WImCRDIDG1o3xPWm1UZ/teTI5L2+n35tYvbmmTrxQVXmvJnNIzbm+X8xcnSLaOLeh5LZLwM6Enh1DivGaWb3yucNjmPMIDaLNz6D5wNf3tY2eVaspeDXUlAiRPVfBNXDVscN15VsGjZXSuic3KuIqLrdWvNjn6+HIohmuqeWbml5sneq+VCk+nc02cqNFkA5Esltc0UQ6pdGEgRHeNJV5837f2NhO+rFJPY1qjqYh8bwdnJz4wlT8Q5y0Uhidm2YG7cs5jspFXLJVyWRgAPXGDFbrDrN5guBZDUkC33AzRbklevIeDt4pHwzdZyzaRy5HNEZ1Lhpj/XxRslhl77TFGnd+eFwqLCniS0vTgtTb3xbA6irW+3CEoG5PzhsfZO8x2c9LHT5ZY5TruKp+8RK2d53BGiaUjMqriCh8YUkE1KVUkRzKGgmWC5f8fgBcEjcSqVmslqjXKyBM5oPdYCpHULYcOrGWhp1jYk7airGGCdgPVT2BIIFU5pjLSv+76WtepEoL5b7o7vYPdVJjEvUr5Olj0uGLIV2JCrk77B5k+MArZO4O/Y0FIj1xmkdYC1/AAuFjVfplQ5Ch1nEwYiqRzg08CHXLtI1HNu74lJtKkEvOtORvDqhEhF8Y1mq3jPsZ7ae5ChJDEYVIqWhHlH7QnUaIYg/vzRqtaHZhqaFqj8RGb/NeXrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(86362001)(83380400001)(33656002)(66446008)(186003)(26005)(53546011)(55236004)(6506007)(7696005)(54906003)(66556008)(64756008)(66476007)(76116006)(66946007)(4326008)(52536014)(5660300002)(478600001)(71200400001)(316002)(38100700002)(6916009)(122000001)(9686003)(2906002)(8936002)(8676002)(55016002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RYy7JUoHb4Is7+ou3k8+q1dfKTR28QxdgFZdvQS7K3OGXKqTNRkAtpXJjmAI?=
 =?us-ascii?Q?j26dHWTBzbNP/bkvpWKuwpS38C2/xV1yR09aCR7t5L+/cK8bqSIGrviJDqXn?=
 =?us-ascii?Q?LvCpLtwxJcs8isIDKjvGdtHMZbYl0TezDGgbnADW3/4hM1FRz4Nxb9DYXsQd?=
 =?us-ascii?Q?HS+unBvh7g7rBQ2rXv6luEAOVcjiORt2PDCyA6KHewsH6mejPNBe1b7Xw+5h?=
 =?us-ascii?Q?GNNCfSEEj0yE0CoiemNP91Sl9D2sjRdKsGCUkjlcDjrMBFsgW6J3mMJhSG2t?=
 =?us-ascii?Q?WhkDOqms3aGe69aiOzlv8raRXu42Zz889D/8E4qU8VJF7+7/XNL1zFrKYzce?=
 =?us-ascii?Q?+jNgPwzAPDuA9OxemMQjwArW1hkl8fhrbdgnjTY5N01/GFpEbiysgrRsnaQW?=
 =?us-ascii?Q?RbPqdyxyQBel7VHItziqVOAoOJq3sL32tXjIhXbhCrsd4ecdADDV8cqpTFtI?=
 =?us-ascii?Q?fua73OchLfKSdnPd2Gm0vXrQ4IUXTy0mQyc/T8Q5WRZtWnXT+mryt/JquHvn?=
 =?us-ascii?Q?jXlxAzhxl4tmtAC2TIWENgFFUewIxA9aJiFHauVGH9cDGZcR1A2WnCp+ham0?=
 =?us-ascii?Q?NO84jEQ67IQmdrBuGJ8tbbwxna7e89altWxPaIVhvJpc1IECKMm/89tWChEG?=
 =?us-ascii?Q?zFaHSmx2ahUNBsHixr98rlscyEiP/7HV1J68RY4E82nTMoWTGvxJbD0FGqxD?=
 =?us-ascii?Q?z9xsxznmW4z/t0jQOyqFNL/aVJrvL8nCHyG6JcLzu6WFsmZt9UDdVWGkjAB5?=
 =?us-ascii?Q?5KJr5cvY5Nmib5cP+1KUGKrL8Y/IYSypAOX7W09zfA8VrvQV0bzUKOzP8mpd?=
 =?us-ascii?Q?6mutZS1BIBGJ6Pbum465f+EiKfptyVV0YEQmHj8vMQNj0d+QYzb/JJi9+6EL?=
 =?us-ascii?Q?NCtMAVup44QRbJhOIzrBaHH+zmqhqagm+Oc5Ayh6Ww5eIupTDXgxOuTej8as?=
 =?us-ascii?Q?ybe75bXTuI7rXVVSB26SHMioO9jluoJ95OHAmNuhIqsLsXwPGFu93YWwyVez?=
 =?us-ascii?Q?XfeyATTQ33S66NeAecwVDy+QvmX57fNmItzytpdVWQ9u9+KYwhT5s6fCgq/4?=
 =?us-ascii?Q?3emjr8rSpm21L8iHDpFPjTDnDQ8FmgfMh3RmnZSuoGzF4trs6HCKIdIWnkie?=
 =?us-ascii?Q?+wko09zqPsJDpSx5OK3QoqmAUij+7jvIwjT2Z3C7JWGOGwGF3biRZcsfp5RV?=
 =?us-ascii?Q?Y3Y+U+N5hmTnapQknQnofglE8/Z6Qlwzh8T1f1o1s/EuEnxMIyFcAWE6/UbU?=
 =?us-ascii?Q?kpxaBHfcW9Utm37E9l89x/uDqvX5JY/FCpaL0fhE6y2QxYzdDonHweQ4k8Dh?=
 =?us-ascii?Q?chw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be38b06-9d49-4053-a09c-08d9475e31c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 07:00:13.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ50zVXNs1jytgcxQEJExKEOa0IeMbnbLFscX74PyRE0dkpseubwONdMzCf1/VFp5ctyCIyrp40Ps1nVs/FJEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, July 13, 2021 12:28 PM
> To: N, Pandith <pandith.n@intel.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org; Zhou, Furong
> <furong.zhou@intel.com>; mgross@linux.intel.com; Sangannavar,
> Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> andriy.shevchenko@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
>=20
> On Tue, Jul 13, 2021 at 12:23:47PM +0530, pandith.n@intel.com wrote:
> > --- /dev/null
> > +++ b/drivers/misc/noc/Kconfig
> > @@ -0,0 +1,16 @@
> > +# Copyright (C) 2019 Intel Corporation # SPDX-License-Identifier:
> > +GPL-2.0-only
> > +
> > +
> > +config NOC_DSS
> > +	tristate "Enable DSS NOC probing"
>=20
> Please be more descriptive of what exactly this is, it does not make sens=
e to
> anyone who does not know what DSS or NOC means.
>=20
Will rephrase and add more description about DSS, NOC in help section

         tristate "Enable DDR profiling using NOC for Intel Keem Bay"
        depends on ARCH_KEEMBAY || COMPILE_TEST
        help
          Enable this option for DDR bandwidth measurements using NOC

          Add support for Network on chip (NOC) in DDR Subsystem(DSS).
          DSS NOC has capabilities to enable and get statistics profiling.
          NOC driver enables features to configure and capture NOC probe
          counters, needed for DSS bandwidth measurement.
          Say Y if using a processor that includes the Intel VPU such as
          Keem Bay.  If unsure, say N.

> > +	depends on ARCH_KEEMBAY
> > +	default y
>=20
> You only use 'y' if the machine can not boot without the option.
> Otherwise it is left alone.
>=20
Have removed default 'y' =20

> And what about CONFIG_TEST ability to test build this code?  Without that=
, you
> will get almost no one every building this code to see if anything breaks=
 over
> time.
>=20
Have added COMPILE_TEST option as below=20
depends on ARCH_KEEMBAY || COMPILE_TEST

> thanks,
>=20
> greg k-h
