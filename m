Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5B3BF2A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhGGXyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:54:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:53406 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGGXyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:54:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189094061"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="189094061"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="628196360"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2021 16:51:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 7 Jul 2021 16:51:31 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 7 Jul 2021 16:51:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 7 Jul 2021 16:51:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 7 Jul 2021 16:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeIWpxyJUrY6ZMGRgzLh+aTXQ4QYlhvgwykHg5ctrVPiOHtyCqCSvk5wEW8Pt6/ZgUJBFtNz732uP3gxuDajljKWCbIJXQNLBON2pfZZU27xY8V1K0qHoPNHsKkGFVkPDqNOVdUoy0G0DoRROgqA6jOq4ocShHh6hFVeltPVayx57Ikyk740WXambM+q8AQY5cZsaQ92+dpeN01zR9Fo6WinggjvqW5XZLAhwsmbbL+hS0cw/mo0kA9eNRo94eoJaFxwphCsvUr6QfWuP4YG7oR7xWJOey85egcaqm1uCE4vJSBnl5Ea/Rlhlqt+iVaHgL8wEiqtI0JGUszXiYAVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zcLMrMjaHyuvctBQCttmUsGicU0QS2y83CF4PjNU1Y=;
 b=lk9mg6SuU2aDMyD9sDK1q38O+8VPKgWm8wU0Sv5rxyfrMRSMXlwwCaBI5Y4VADMVU+XnhuEh9WdWJ8c3KwlFuTklRrcYabK1A7HEurC/H+762oNyoxBCAMi+gp4omPdLc3N8H43klLuOeY93ytQYaHATmz/yHcKwM8ZFi2y+RIVzNvbl8FVocoGXRxc+yB7uURmoKRQg2hPknDYJI0TpkItN8sbnJZowTkqvRW4NvR06q1Q5qldCwKOx/FNauxE7Z3eCIk4Ks/RmJGNZbaS/xSSMptMgcsQ46kkzgDIrXgwCgzQzlHlrdVNHqZyWyghTgZIxac3XLEqrtkGf+wo81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zcLMrMjaHyuvctBQCttmUsGicU0QS2y83CF4PjNU1Y=;
 b=qkNYYtEAFAHBWy6+5uG4KQk2I61kwxOFqEo8aHsGnXB/kV8eWYR4EByPI2hnOrfRu+But1LGFqr3tRLvi3m9xRTDLcUV+h5oN1bYCGXousa1mHlaXEVvzTS50xARiPmWQqsM/xU8qkpUUPyoNlarTEtvBnWVAwjjp5r8rv0EXTo=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1617.namprd11.prod.outlook.com (2603:10b6:405:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 23:51:22 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%7]) with mapi id 15.20.4308.022; Wed, 7 Jul 2021
 23:51:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Dey, Megha" <megha.dey@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: Programming PASID in IMS entries
Thread-Topic: Programming PASID in IMS entries
Thread-Index: AQHXcudPJhGspKhxxU2RxzF5lUOu3as3NJIAgAD46SA=
Date:   Wed, 7 Jul 2021 23:51:21 +0000
Message-ID: <BN9PR11MB5433A4B8031D696A61BB43378C1A9@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc1daa82-1476-452b-8506-08d941a21f8c
x-ms-traffictypediagnostic: BN6PR11MB1617:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16179B6C04A33AFA8D6565018C1A9@BN6PR11MB1617.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IEMpKwNS1r3N2Efd1b8CwHNDj39VZQwc9+caUnkUZb8+Vle8ZjesMKJdUU4QuR4kygUFV1YkXSuaefYD5pfGuAk0CduvRba5lV8MiexpqTrTqRfnSySGrVDA2M9U2Uyy1bU4M+XkuUb3fsp9NXky9wfsB2dus2i8LfkhM8wN58ZF1XiaBg4dfVyLJ57ARbfIYACqi1rWDiKz6n+4AZsT7C2wjgIHTx387bBahfY+noSTus2xld38QUigoZGLt7WnkORuFN/iNZdzwsfUV0YkFiYmxzE0NaDSgmDayVPZEy+WCpA4YlSFNjV4m5MsS7Gy7f/gtUBG60Rf0wimvgO7Z3jBhiAH6+IxFKlfQ0BkHCudVOg1oXIRIGQUOMGrHbkOnzR80i+a1O3ralIf/RBOednFOyRFG9fGKzvgviEWvoasz+vnJm6G+oZ/vnxswZLnc9l68uB1EaDM8YVN58TpzuIVQcXFEbH+uq63mfhuftxujKN7hx/NsEes6QW0TQxp5ceNkdL7oW5Bz/DpTR36oxKmWHc6pzWMXSu4QATLQLy42WyXa8aXdCwNndhQUDitS6BOjWk2YHFJyDG+ZF/s2LWSCLOQ6pxmLhfioBAodiUZ0B/IszeYBKKZzoC9140EM+V55h485a1NEGeUkLQf8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(5660300002)(54906003)(110136005)(64756008)(316002)(4326008)(71200400001)(7696005)(8676002)(38100700002)(76116006)(9686003)(8936002)(186003)(26005)(122000001)(66946007)(55016002)(66556008)(66446008)(66476007)(52536014)(33656002)(478600001)(86362001)(6506007)(2906002)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rJHbd9b1w/K7I2sHSg6I4r+Z89ti6giTW4HIfTB3nIGN6stXb2gApF7Fqil+?=
 =?us-ascii?Q?MeXE4VBWu9FdHuBpGlu1Zz8fAr7/HUJ3aF6K+HGA8tWB39CDl04lMCWcqsJb?=
 =?us-ascii?Q?5g2d8ENqSDXokDawvUwJ/dNds/SpvlGiMuvZ9SYfAT0NiC84NCQ4TSHfA3zu?=
 =?us-ascii?Q?tcm0QjeEbsIvYmAJHvBrXxaKdT8c1b3Asn/u47bto8n5cSKFUxgDyrwPVBXw?=
 =?us-ascii?Q?kJA5+xXO/y/WFDlknRULu4fiHccMS6weas17kH4wLEVfPf0Pdfv9wXJQkU4N?=
 =?us-ascii?Q?R5ad+v24bP0XOVC/EAc7BE1HnweQ9Ke+0GW5M57AIecVrRm/EOuKzqlSfC4C?=
 =?us-ascii?Q?1wN2pirKwsSkHtaUcKWrTyltd7lCRWOSisY7nPAlBoOdrc+jmtVRSBVfomzg?=
 =?us-ascii?Q?sp5eHcRDUK1bU91LwHt+gEEhdkHjMLBZvQGB9i934zgASPZFf9gfw7nDUAR5?=
 =?us-ascii?Q?eqoRAHIBUdA7sWKflu877g72pkrbMCS24HaVQo9h0EHpGqNrN29+yPWrnSZD?=
 =?us-ascii?Q?KLXeALwZUYkx1zlLI8OTl0HkixW+J124yhaH45fLuLG9uJoRI+yJ+r/x+M+J?=
 =?us-ascii?Q?etZ5JPzFqKueZQLkKbed7HG/pwsAPlXsp8EbD0/7uZLVgs9AYs1agcQ67GWa?=
 =?us-ascii?Q?rMKxQTFucgeXWuVaIt1xGtsW+fMkHY0VniiK/a4hgF6vOpds9CRRT8Vl/Pyg?=
 =?us-ascii?Q?On0lz+zY5vjy7UGcoGcV2e99CTpNTtN70MGyajT3jiiM+2uMD/lE+R04nqJI?=
 =?us-ascii?Q?zCiCThFDzss7Md2FyJ4YVtCjXlyls6DMjSbBSb08h9PQhygI+H9344TUpYeb?=
 =?us-ascii?Q?dgFkoQjHL3c7sn3GaS1FGE2P3aheegZybShwtJ0mA4jZwSyJJ+xGG/RqzM7P?=
 =?us-ascii?Q?D+LGg/OGYMlwFM5L3P1k2n0vdENQbmkVUWiqFNO+66RPXZMJ3S/VBOVtMSso?=
 =?us-ascii?Q?k8MQnGcL2Sq2t5u7P98RUqKNGMD8YMvhXbWqLxFNRHxpr6zzg3U3nXVtt44z?=
 =?us-ascii?Q?HgFulrwTseJFrHmY2VltVx3z+k9XgezxHlh4FYBjXZxVok3wytD60AION6dS?=
 =?us-ascii?Q?S1UOXvOE5M3n6xo5eeRAvIsttqXVwIh1GAJ9CvZEu9ZWiukpub2OF0gr2O4y?=
 =?us-ascii?Q?pEsHpFhkiEPNsSezNQJOLJ3xaMP6WtsZCaTfz0e3d2uYJs63jagIGOhGIdXY?=
 =?us-ascii?Q?gJcoR+jATfwmdvsQCBI3musrAGVVYeWByMym031gxtN7jXFYTaER1GIFYqcB?=
 =?us-ascii?Q?D7WCyJMEYrzazkzv8gp0ougfAKaFn4Ij5KQs9h+r8nPaQIMZ1KTXWeDjFmqC?=
 =?us-ascii?Q?c/VCH2rBtUw4bzf48JupArkO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1daa82-1476-452b-8506-08d941a21f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 23:51:21.8400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CScWuTnSKjpeoFk0hofj0jjo+HxX0HnS7r0Y6cGanWhiIQz2WkEZDKoUoFCuJn0HaLQ4HRp6mxaL5YvHPJiIuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1617
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, July 7, 2021 4:51 PM
>=20
> > Also, from a previous discussion [1], we want to make IMS more dynamic:
> >
> > Given the QEMU behavior it doesn't ask for all IRQs upfront. It only
> > allocates 1, and when it unmasks the 2nd, it wants to dynamically add a
> > second. This will allow adding a second IRQ without having to free all
> > the old irqs and reacquire the new number (as it is done today).
> >
> > This dynamic behavior is only for MSIx/IMS backed entries. For legacy
> > MSI, QEMU will allocate everything upfront. Since it has a
> > "num_vectors" enabled, nothing can be dynamically done for MSI. Kevin
> > is looking to have this fixed for legacy to stop the dynamic part for
> > MSI. We are pursuing this change just for IMS first, and once it
> > works, we can replicate the same for MSIx too.
>=20
> No. Fix the existing stuff first and then IMS just works.
>=20

Does below sound a plan?

1.  Fix Qemu to allocate all possible irqs when guest unmasks MSI/MSI-X,
    instead of freeing and re-allocating in the fly. This is an improvement
    for existing kernels which don't support dynamic resize.

2.  Extend MSI-X core to support dynamic resize. Via VFIO_IRQ_INFO_
    NORESIZE Qemu can enable dynamic resize if the flag is false. and
    from your comment dev-msi resize will be covered too  with this change.

3.  Add hypercall (or a pv irqchip) to provide feedback into guest in case=
=20
    of irq shortage. This is also necessary to enable guest ims.

Thanks
Kevin
