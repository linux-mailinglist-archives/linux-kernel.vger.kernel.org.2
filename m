Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714A23BF292
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGGXok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:44:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:18731 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhGGXoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:44:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="231158477"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="231158477"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="648110368"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2021 16:41:35 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 7 Jul 2021 16:41:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 7 Jul 2021 16:41:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 7 Jul 2021 16:41:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsGU3sGl0Hkkh9DQj94qyRNBUBihAAnAtMCY+Bxh9KbH2rweeGon1OEsaEvDJJphyic797K9KVhAipOJFYC89QKSlGWEs6Rjf/DW/1WH9Y9BJKJ6G9oCxCe8w9/x5pCGW1Kq5tTO5nVUpe20N+IGJmChsvyY8iwSIGaisE9v9TWbf949jnYIMdTDVu5c86dCnqjgAbtYYG7DI8ZCDHtQGxewpvHYszZu9KaYFZ6nvOGYNpyBdib2PeQBgL43yEU/HQiVX569v35sLnRyNx/fsr2tzIaurRpENV9q+BaEliCoWuyizTK4jEuyj4zZyvEQeud3sEq3DfHHQ/7sUW06uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q70m6NcLKoASNKPs8oMFt1+g+lmgQt6JAuTrxIYxh10=;
 b=KtA4QVLjve4rUHC5K2FB3A/YFlGqe5D/1cmQFHpD6pYx+Zc51swfPEkiBqnb6/nbqD+I5Ia/ppkpt+BbZmOaFZuCJ849YrvAUUrFRJIxzyRoEa+UgPqa9mSXd4khUF/gyBwydwjU/8jRmwNtFx46jIyOGeshNpaZEjZvgMTwOnv5Pfq9ofTVIQzVq8qrR45a5Ftm2hAinQMhTIkH/G4C8p6DeV1jmvoY8c+nDhO+rxQWNbH/uaus3qjn5NEL0nsqEIa0GUNnBQji8Ae5Z3h++/Hve4M+eCI/H4bpVI0FXo4xbQcQEb2AGpgZruXBWlFoW5BNvRTJpeQNf/E2JCoDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q70m6NcLKoASNKPs8oMFt1+g+lmgQt6JAuTrxIYxh10=;
 b=DVOVA3ghLRwmQc54LiOo3zMumY4r3sHYR8H9lqQkuKx929Wzr217Wa6a0NHK4vb/LnrixMN3U6GYtDJYbxPj2NuyZFMpRL42FUGZdQFBfF1YF0yHFuoCjWoMOnW61J4uYMablzRXdzt14x0EkZG3sFw5QvEXHokMOqD6zIa/Fro=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 23:41:29 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%7]) with mapi id 15.20.4308.022; Wed, 7 Jul 2021
 23:41:29 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "Dey, Megha" <megha.dey@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: Programming PASID in IMS entries
Thread-Topic: Programming PASID in IMS entries
Thread-Index: AQHXcudPJhGspKhxxU2RxzF5lUOu3as3NJIAgAA5QgCAAL7EMA==
Date:   Wed, 7 Jul 2021 23:41:29 +0000
Message-ID: <BN9PR11MB54335A35466B511231F0EC638C1A9@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de> <20210707121548.GA4459@nvidia.com>
In-Reply-To: <20210707121548.GA4459@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b483d545-749a-4844-b6d6-08d941a0be41
x-ms-traffictypediagnostic: BN9PR11MB5322:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5322E3E5D2652E44790FF26A8C1A9@BN9PR11MB5322.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNFKCpLIPJFJwD23+p9q02qELNQhH7J/RWN/NoPo8MHycBByoOr1VrZepLaVeFrttkXnqOP2p99jwaV7uK/9FaelVRLQ6O5TxDV3HLacPoDZt3kn3nANW0m+SjmhHzlKUBb/t6UMvStZLh0g1Lo/Vrw9+YScMkj+KCkkOTwDCf1LA090AHtfZVjuzZFdYntm5u6s4RqIvvlotQ/pnjKITULAfwJiPbwCbk6oAm0BEGl9Q0o30tNXqCiO4WCY6Kn/quMVr8ATMxXHJjpWU+QaFHsowM4qoxo/SVTPFyVSedcI2fYpSYJEFfFeUJ6TgPCAkZxLCUhN9PfklPjhgKWLqmipB9iG7qkM0y7N4QYM78L645HLki5cqPuBpg5cWIo6nMNV4NDfjrMseysRjak0w+6Up2176vLS4BcLu0SX0DbSsN4piYtvYP137bbBh1UG8BU+Z/B2ddO6KCHHq3U4RSZFPrJdFOcDti4bsAc9BissHgB/WjgAlevr0WLxeo5ZXqN7WjAHxaBkMzcyNpshMo3ACDV2EVLbRKgowwI0JMlKC3EK/ronSP+PIZAeH/YNkPwi7Niy6RnIAw5nH28ZmokptvClGt9hvqReHJ4/ZbVgPu8+M+rWDmg5qmCXEJOV7tk29fqPOU+SJyZh5Oj35g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(366004)(376002)(122000001)(5660300002)(8936002)(7696005)(38100700002)(33656002)(66946007)(186003)(26005)(76116006)(66476007)(6506007)(9686003)(8676002)(64756008)(52536014)(55016002)(66446008)(66556008)(2906002)(110136005)(86362001)(71200400001)(54906003)(83380400001)(316002)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y5IvS23qttE/Sn2coPspsU+TzAJV2WrgBw7lNHpjth8j0ICr+MXku6lBYzFC?=
 =?us-ascii?Q?7zN6XUK2kHP8Gve5jgr2gfaPfSfbdWFJdyAiwptamApXscM9o0hyJUi2FhHh?=
 =?us-ascii?Q?YQjlA78in6YN4YHLEgVtWriuVwoK3CkEjl3zNLRntD8If/rJSdcqeEUywIsO?=
 =?us-ascii?Q?/XoEaSaF+naERMsfdyl5Gs7rvm0Vb7nzoGiLcmiMcvOxLjK4b5cw2wsmNyH6?=
 =?us-ascii?Q?o6k2udRtXQtuCJWsEGAuxYiVtArymyZ9T3kECaxueqPBXdV++iZrqct2na6s?=
 =?us-ascii?Q?wspvRcpS9mc3RL5cLqFly0QK+RGHLolTGTVq3hJYJ9UsvYogy+N4wTyzcv+n?=
 =?us-ascii?Q?f13X3Kv4sAfPnYamZ3t7H2tBr+IOkDx6M0JA8bQuXL7kSHG8TJG8M84fNly2?=
 =?us-ascii?Q?UroDQldflFiimV5zU2+fBxou83jr2ka2cgoXMO89RulY/lQ2U8RaRQGSFY0w?=
 =?us-ascii?Q?Z3CByZZNgtW8EotgUC1GWuD23ZjlejwbB70SK2J9KyLrofRtv2yhNBdC54Ip?=
 =?us-ascii?Q?+RAE+a6GWBRvZCZXN71LMg7HQegBQvUkAG1axbDx3jkbqe3aeD7NLUUGzlw6?=
 =?us-ascii?Q?32L6PlepQ4cxjm9ycy1M3JAI45EH5sK7h1+1TK+uwPDC89UIcbk8XwB6ZClZ?=
 =?us-ascii?Q?+GwepdIonGlNfwk/BtRvAFvfmMTSz2irLiAkYFDtcz55uP2GATIRv44QAiqa?=
 =?us-ascii?Q?sE1MxBuAG64NHBmGyNUHUCzcq/J3srRD7z7VjE1a1FKo+fBaszjvvXVmXqnn?=
 =?us-ascii?Q?pLfnvOAq9shqLcdqEinl3AbutmYV2FPKggFDavmKRM3jGJeHH2qjseBjqtiY?=
 =?us-ascii?Q?2uU7dE+cD6GDpSaPq0b66OWRHhW8XWV44m6UPnHBK+u2cJZJ2Th1QKQeCmc+?=
 =?us-ascii?Q?LQIuBEt5cIxSvsGSKpdNu7D863iPtWmlFKkfzeyfzcenZb9LcAPJmRsl0afM?=
 =?us-ascii?Q?r6pEeIgeI578MRzeFhSIg0WQBcXa9bBdqz8LLcQaqopoyigd2e6KZASD9IO5?=
 =?us-ascii?Q?ZG6dwH0G277gKW/nXCGyamNCrube3gs9FRY5WLZ/oWxSBYWbFfOr7U8Xh0Br?=
 =?us-ascii?Q?GB0sERC/ZP7JkFVvb7RMvUjg5ImAeJ9PfpgReoWEC4rjglhqUJr9rzUiESMk?=
 =?us-ascii?Q?Au5ZEVGtjUDQXDex8N53zYTixZUI586uO+lCDL/6GPAf8kmVj76V0SesW4II?=
 =?us-ascii?Q?50TSXtp3zqXLR59/YfqJcIOF20x57EoDm8Fs3hReyhhSwScgi5qkqo5v7kGc?=
 =?us-ascii?Q?rRrHyfqgS/uEOzEFuRC2WdHIrHRkySiEJwLpM/M14R2WEj9F9iPdxSSuaeFz?=
 =?us-ascii?Q?vZFxZoNtxyuuKTa2tRGm1NcG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b483d545-749a-4844-b6d6-08d941a0be41
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 23:41:29.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGQAA5RKW+99RyrjEkUgpkWPhBHDLeJJCeXHwjeAgeuYg+TXmqBijGdHcbCr69esssdxFvq+w/X15HTb6Z0zmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, July 7, 2021 8:16 PM
>=20
> On Wed, Jul 07, 2021 at 10:50:52AM +0200, Thomas Gleixner wrote:
> > Megha,
> >
> > On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
> > > Per your suggestions during the last meeting, we wanted to confirm th=
e
> > > sequence to program the PASID into the IMS entries:
> > >
> > > 1. Add a PASID member to struct msi_desc (Add as part of a union. Oth=
er
> > > source-id's such as Jason's vm-id can be added to it)
> >
> > Yes. Though we also discussed storing the default PASID in struct devic=
e
> > to begin with which is then copied to the msi_desc entries during
> > allocation.
>=20
> This seems like a pretty good idea, though it requires that the
> device's IRQ code cast the struct device to some driver specific
> subtype, like mdev in this case.

it's not necessary, if in the end we still need a helper to set PASID to
struct msi_desc. It doesn't matter whether this PASID is default or for
vSVA. Just let device driver to pick whatever ID is necessary to mark
the entry.

>=20
> > > 2. Create an API which device drivers can call, to program the PASID
> > > (PASID provided by the driver) on a per-irq basis. This API is to be
> > > called after msi_domain_alloc_irqs and will write to the correspondin=
g
> > > msi_desc->pasid entry. (Assumption: For now, all devices will have th=
e
> > > same IMS format). for e.g:
> > >
> > > msi_desc_set_pasid (irq, pasid) {
> > >
> > > struct msi_desc *desc =3D irq_get_msi_desc(irq);
> > >
> > > desc->pasid =3D pasid;
> > >
> > > }
> >
> > That interface should be opaque probably with an u64 argument so it can
> > be reused for Jason's VM-id. Jason?
>=20
> Well, I certainly wouldn't put any IDXD specific words like PASID in
> the general API. The comingling of PASID with the rest of the IRQ
> registers is entirely a device specific choice.
>=20
> Most likely something like mlx5 is going to want to associate a
> pointer with the irq, and I believe it could use a struct device just
> fine.
>=20

Agree. Better call it source_id or cookie?

Thanks
Kevin
