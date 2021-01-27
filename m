Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5B3067BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhA0XVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:21:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:41629 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235467AbhA0XQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:16:43 -0500
IronPort-SDR: pveqXPoVAiaQPwfGn+0w3sx7i8CpoBx9PMRKzA2sfiTaIzuT1nFyXwkwsvbjmfZoBYT4LtQPZ2
 pv1FwvrZJ3wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167824939"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="167824939"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 15:15:54 -0800
IronPort-SDR: 96ZWEw03Yhd89+ZoU1J8g3zpxTBffVpbYK6NPnoK8lPFO8yenNdhvqQsmulFu60HuaGTClzBx9
 tBztXVHaEygw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="574532280"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jan 2021 15:15:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 15:15:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 27 Jan 2021 15:15:54 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 27 Jan 2021 15:15:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQpCPiUKDVUVVeN8c1hqBBoMSagirvvXqnqRs41PcJypvR/OUzJzNLb5qlHUHnIwW4uLISRIX1LLfMsJO71GQd1vM0/iOiUt14gwAVItjPQTXnuHDENZ1/fZl/Opca+3BGuk67XjCWACjVE/oBm/zLgEZymAn2nHPfjLwThXddBtsSpwKlihMJTGxJKWSgnj3ilCPXrHm3dEXdpSkMpoUEALd+1klSTPb1gwnpMxAP26MGEga+Lo+2NQ1MHp2nIZoqOseiPXBx0hdKm08BDgXWsmKv2VEwsjgZNW2hNZcxkOYEX9iiu+ZDvKOQ0GUAgdBVSPxOogK8iflld+2crfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQorr0CItgY8FW5vJKLlGs6TL2unVARF7Gc+ikgzKcQ=;
 b=oEpzR8451+aWkx9v7D4TT7Ki2dKbrEDuFwFFROnCnlyUyTuoAkIOgnfTtsZXJPDexCXQDh8qbgJrUL3ycEInJjEIVR+HEYnl1PuMtEgkEHM3aSChhg9WsxR1DN8pVvGZ+EIQ1x5T4lI0GCXdbhbTocD8bPBvDo/pME64Pi5qo/gi2bBF5EgYk3NCBGiAv7KZvbuVmpT8zQ01Tjs3TpAz4qsv3gYK/sKIivpz6cVR5JYrragBf/Td/qmf7rvy3zeRMLayO8JNzmbucQtKJSyph+F66aY8pa1yZsvbQj+Q2X/KpGzse1M5WjINGp0At9odrAYn1FyiDH46tizFE11HjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQorr0CItgY8FW5vJKLlGs6TL2unVARF7Gc+ikgzKcQ=;
 b=ZgM5tXzqcgf4B9b0UEEBn5y/JMTbIUQka0JJpTmiWezMNO8VfzUoPw9y+E8fn4m3gmqTLUSRz6uktuNJoqHUE3j89uZnydhaFNVLkS7u80xA8wr6+85iDo8Dx6MWdI4zHh6Td2RxIlBnqIr0OuuBMP97kNecRZ9jHDcK/6OWZUY=
Received: from BYAPR11MB3095.namprd11.prod.outlook.com (2603:10b6:a03:91::26)
 by BYAPR11MB3511.namprd11.prod.outlook.com (2603:10b6:a03:84::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 27 Jan
 2021 23:15:51 +0000
Received: from BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::2839:b0d:ae50:7342]) by BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::2839:b0d:ae50:7342%5]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 23:15:51 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH v9 04/20] dlb: add device ioctl layer and first three
 ioctls
Thread-Topic: [PATCH v9 04/20] dlb: add device ioctl layer and first three
 ioctls
Thread-Index: AQHW8PD5TAmGwDLZxE+DNb4sUF8XFao7bh0AgAAWa2CAAAQXgIAAmUNg
Date:   Wed, 27 Jan 2021 23:15:51 +0000
Message-ID: <BYAPR11MB3095E255E6496FD310C747B0D9BB9@BYAPR11MB3095.namprd11.prod.outlook.com>
References: <20210122190138.7414-1-mike.ximing.chen@intel.com>
 <20210122190138.7414-5-mike.ximing.chen@intel.com>
 <YBFckMGGRKZBYXRd@kroah.com>
 <BYAPR11MB30958F6A70E6B7C005F7B8FCD9BB9@BYAPR11MB3095.namprd11.prod.outlook.com>
 <YBFyzX87hvpaYJWK@kroah.com>
In-Reply-To: <YBFyzX87hvpaYJWK@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [69.141.163.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51b37311-f1da-470b-a622-08d8c3197d70
x-ms-traffictypediagnostic: BYAPR11MB3511:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB351133EADC2055602B077258D9BB9@BYAPR11MB3511.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NI7yaqYvIiLnKC08Uo3yeX3p7npIC2kLKgR46E7yvx1OY6zXIacjD0nwAOBhCBX7tkDBlKNwzMuliIXjDAHp20Lwa8xRFnQVpYDIFCeJmYPGlQ6M4GLukdOHhMkXbTBxYe468Cz5Bq9bS6ZGmTPaXeRRHHhloejKUqMT/TRC4RtZ+e3WV74smNOZZMDNV3DDkiV8kPK2W0sx9mFqRczzD0PuLcunaLT7YSVjn2JWWioCdLQPC1daWjNxLva4+QJ62Uiks3HIXXB5f2d6mQaNfPNWItz2OzYb6X/7/fpH9olRQG8VExsB/x9YNbl+wpVh78Xk9glcIWoXqVQE5amqP6Y9EuvhDofv5+xGuwLiFTmDb7NXpscH5jGR7EogSNtECx8TCx4FFsZ3r9Ku/Vfjatb67LiE5LZDfW8PE1FSd06VVheGos/yCz5KKD0wq+cNjHbPNv+JXdYUdV5pvtgYkvuNXlsMQdrYMO4MVHBtkoNVT9+AdcUgWf2PhfXyiYi/NXg5gqV0xJsewMVo+cDI9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(2906002)(66556008)(66446008)(76116006)(6916009)(64756008)(66946007)(66476007)(86362001)(6506007)(8936002)(54906003)(478600001)(7696005)(55016002)(52536014)(26005)(186003)(71200400001)(83380400001)(9686003)(316002)(33656002)(5660300002)(4326008)(53546011)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nG+EyHpAbHEMbGKCLlhzdD4BDlS7k3FN5x+NUu1z8ScGPaUAmgNuXBAa4FJb?=
 =?us-ascii?Q?97dgNLFc0Kt+UnGAXEcmBkmJ31TW1oabIGLAzHac/Is5Bu2uQr4GWunCvAYA?=
 =?us-ascii?Q?W2qAKDh6IRBptwtMHQOp0EPxwjJSiWgRvkbWmyvqhagjyQ0jx9jI0SuBrvko?=
 =?us-ascii?Q?ptka7088iGDmPHUTen8OlK446VFDnbXZPsXZiBTEWL1BGQ2KnuXqEQqYgkIN?=
 =?us-ascii?Q?EQCSdJFHA4PbqYmCM9mD0CStpLhlnnzl2nQRwd3KXGo8E5bSKGos/leUnC9C?=
 =?us-ascii?Q?BpS9exYHb5NotnbYYPM/tLWKlkWGkxxPJC84y3EP5Z96tKcMrU990EnUElby?=
 =?us-ascii?Q?tGmfeFgMlKT+BpXi7J8FtW4OGpTR3jebIQi/irhim3WTgnuqcKz2RrtNg1qO?=
 =?us-ascii?Q?USzFWk16OgYke9m6tIJ7ssDgWHe9dmcaLo2uSUEHk3A1T2Sp7fgNq3tIhFPd?=
 =?us-ascii?Q?Vn3rLqIZWj5GMyLSgZPx3AqjnLfrjlLjTffrfwvYJiw/OnCr5H/50tVgO+QN?=
 =?us-ascii?Q?yN0h2x4YePEVM5FimT1U1nCpKZSwwhje/tfb1vRxBUB042vWQQl6ZYl77tt1?=
 =?us-ascii?Q?f8orqGC3mC4LyqBm7nhoGji9xSdkire+pIHy83ryQhroUvBroXcbc7DQjywD?=
 =?us-ascii?Q?bZ3dYyH5jtuPKhDQTQ47VLA4QutcLYtUhCIE1Za0Mam+gLvKyR1CnWtb04/h?=
 =?us-ascii?Q?fYzFawlojzxCkVH8DmoKcLTfCi/HPQxmFXa9tQdOHzMFukCYJsvent0fXHpx?=
 =?us-ascii?Q?/oslpBHEgr8d1uG8fIsBqF1X8yGBu/tQCtJKQAT3FNjJrWT1RAn8044zCkJG?=
 =?us-ascii?Q?Aup0gL/oZwCMn7ObLB+CGfABF3cGNgmIBw2U4JYnxNvKnF8EKdiKhSqoKbJt?=
 =?us-ascii?Q?mhK0oDHxNhzStro6sk4iasRnr7B+Kt06qEfjZhRxBGzWBtICn+3AwBjx1dy6?=
 =?us-ascii?Q?KnLBMIkxthGxoJffT0J1EkXng9lTHQTZog/pbXeQfCAvT0UXd9vTTTwU02FD?=
 =?us-ascii?Q?mUovhpLv9CM6W24w/Fd0XugHcL9T5PeLrPJrUJSh2ylm0bxfCkU5Du+kShJh?=
 =?us-ascii?Q?AJR5cwXM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b37311-f1da-470b-a622-08d8c3197d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 23:15:51.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGrpwtVmDcCujJMqyjBF8tE3YZiz5OBNFxWql5j9EaULMxC3W88BFx7lEU2WpTwi6HUyFhDDiP9L38uM7ps4YxLdUr5K8sRisvx98yl84CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3511
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, January 27, 2021 9:04 AM
> To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com
> Subject: Re: [PATCH v9 04/20] dlb: add device ioctl layer and first three=
 ioctls
>=20
> On Wed, Jan 27, 2021 at 01:59:50PM +0000, Chen, Mike Ximing wrote:
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Wednesday, January 27, 2021 7:29 AM
> > > To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> > > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> > > <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com; Gag=
e Eads
> > > <gage.eads@intel.com>
> > > Subject: Re: [PATCH v9 04/20] dlb: add device ioctl layer and first t=
hree ioctls
> > >
> > > On Fri, Jan 22, 2021 at 01:01:22PM -0600, Mike Ximing Chen wrote:
> > > > --- /dev/null
> > > > +++ b/include/uapi/linux/dlb.h
> > > > @@ -0,0 +1,167 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > >
> > > As the bot points out, this is an "odd" license for a uapi .h file, a=
re
> > > you SURE about this?
> > >
> > > If so, I need an Intel lawyer's signed-off-by on it as well, so we kn=
ow
> > > to talk to in the future about it.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Sorry, it should be "GPL-2.0-only WITH Linux-syscall-note".
> > Should I correct it and submit a new patch set (v10) now, or wait for m=
ore
> feedback on the current patch set?
>=20
> Please consult your corporate lawyers when picking licenses for your
> kernel files.  I doubt they want me telling you what to do :)
>=20
> good luck!
>=20
> greg k-h

OK. I submitted a new patch set (v10) with the fix on license.=20

Thanks for the help.

Mike
