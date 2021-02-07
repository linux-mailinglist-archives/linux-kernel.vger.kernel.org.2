Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB631270C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 20:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGTFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 14:05:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:52045 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGTFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:05:32 -0500
IronPort-SDR: F4ecqpHzXyXVhvB1E5A+/p+yRrsG3ASEK3LN1Fhgx+PPCO++XDRmPr0LjUaZo6eXTJmbTcOJBD
 Vl61n9TPHhDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="161378619"
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="scan'208";a="161378619"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 11:04:51 -0800
IronPort-SDR: GMp86bEeNPC9zfjq7mQgUZq921VzzJ7oPwsuC1k1SoS1a6Et2e5NHtnwAr4RKzxEsq5HQuu05d
 TAW/pHZMg+uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="scan'208";a="410610162"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2021 11:04:51 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 7 Feb 2021 11:04:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 7 Feb 2021 11:04:50 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 7 Feb 2021 11:04:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPB/zqQwlHe9fvWCs8D1FNMVoFhuv0Uv0UMxo8nUjbpRBCGOWldQLqULHYOqX6WAO+vetzipTx6/kpbXvJxRV+hWyCHNUjJfl10Vz/C4RjWVIOzU23q+4eQCPXxw1TZsWwkpUqus+XQbdUfYzFxGBz5+xT68P5zhBldJoW+wf6oAg1bmQ7dbt5OeTKEI1qjaW+SYJ++3duGGCxzKPTMcXYv8sU+xOI9zS0wzLiUMO/i0T4aERsQRDRM33xUHV99ngHC23ronos34tr+l5lt57ORXJIZrYWDLKA6vvSnBEqLrXxfEjlkNUzrEsejL2jkiOukYSGitlyqvhD0eAnaM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjx/g8PtAdmYx22t3oT6ETEYiUudfYNpm5aEV8vXXts=;
 b=RbZDCtT+b6QiZJsdFUvMIf1d0t3uBu+HyIgM0M/A14nYKbHR6TXdJ1gOn36L34PDNx1/uh2E7YMQmGIQ08nYc5azYCyr7ct0wbr5X2mVmtd3FEUhRznryc6X9/KQirjG1cYgtnxILuzovKnZAnV3d9F884LsPOTRofPyKmykwKjsNSF6NOyXsW5wm2kQC+Fw2euNfrv3IfqdB8RDqLLXzr+NBxt18QF/0+bl6DiKDt8XZ10/RUG8Ik1oJZthGd6PN1vKeeu62WfGMpaC4LcwKvJHsVRWxxz8O13zxNLReA3lCENNCK9YGYNoIBAVSBm97Hue+rbtEYVoXTUdiwZlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjx/g8PtAdmYx22t3oT6ETEYiUudfYNpm5aEV8vXXts=;
 b=MNu7f1uXlGvBJzKNX7Nx5bK4/EY3XWXjh0uL69LFRi82/I/z+2nUb18CFQC6qfslvnW6VMeCffroqPozvBDbgLALD/pxFREXa92E8Fbqf3ZMdbJvicfkRL7+N7Aybh68wBcKnNh7bxidPJ0CQoIczf/dGVoD5ZJqw9EC/dQbJY8=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SN6PR11MB3119.namprd11.prod.outlook.com (2603:10b6:805:cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Sun, 7 Feb
 2021 19:04:46 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::1971:ccda:cd8b:a1ac]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::1971:ccda:cd8b:a1ac%2]) with mapi id 15.20.3825.030; Sun, 7 Feb 2021
 19:04:46 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: RE: [char-misc-next 6/6] mei: bus: add client dma interface
Thread-Topic: [char-misc-next 6/6] mei: bus: add client dma interface
Thread-Index: AQHW/JZ6zfy6g0Lzl0WlwNIsjRgFAKpLE28AgAAknRCAABmFgIABaTKAgAAIgICAAElxIA==
Date:   Sun, 7 Feb 2021 19:04:46 +0000
Message-ID: <SA0PR11MB4752FDA7D0500511C3FE3E43F2B09@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
 <20210206144325.25682-6-tomas.winkler@intel.com> <YB6sIi61X5p6Dq6y@kroah.com>
 <2a9b40090acd41438fc6b1d2fb49f38d@intel.com> <YB7EIciZrmBrEqUA@kroah.com>
 <8223112ef8504a31996c2c1bd386d1fe@intel.com> <YB/6QWo/e6UVsNuj@kroah.com>
In-Reply-To: <YB/6QWo/e6UVsNuj@kroah.com>
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
x-originating-ip: [77.124.201.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c4222fc-8e42-4327-ab33-08d8cb9b3c86
x-ms-traffictypediagnostic: SN6PR11MB3119:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3119932F338B15A096B44E1EF2B09@SN6PR11MB3119.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 07nQvZlyJKLg5a5yZsCx716jVJzuVIy2dG8l+oHMgUzUtCAIY5aAdV7zF+nAIViL2b8B66yFpUSLR6j9VGgNFXOZuLQbwB0GyFZhPUfAri5QVZ+pTR6lT/pAu33HcHsezIFX3Mhyg4YY+7Dj0/2upzC1dBPcGvLcccJoxuYB5jJ3E2cOWVcZEJFtNuwQf1Q7A6y47oImwWdg3SOXJIT8Kaph/9mOi2kI7L+1XY2U4miy/bUoPDwpL0BO0ZBJLBpQMEabodeVSHd/7+agartglZUXgH7T6OJ/jAZcN3wciOTCygjqED0umiSmc0xF/NOaVH088tOgwbDkDuuf2CBIe1y0MC+xaME7Y+zCMOTtxz5eo0LLMbWA35ptB+k+NnWbPLlZDcLM0O3HSev6N3ztsno80cKSTIIHcEESDjK/IdxVH1jPln1ThTSt9+QuoCC0StKWSICddgLn7tpKbPR/Y8QwxtjSPGAHwZlIXoYPxLh/Z67yXpd05+UmOsmKMn9Nh17atVKHaDkXMjlTEKsc8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(346002)(396003)(66476007)(5660300002)(6636002)(33656002)(66446008)(4326008)(76116006)(66946007)(186003)(52536014)(7696005)(66556008)(8936002)(9686003)(110136005)(64756008)(26005)(54906003)(8676002)(71200400001)(6506007)(316002)(478600001)(83380400001)(2906002)(55016002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ronIFynpOGyqEaLvX3lfaB9OSZcP3WxwUGCwPBKJiT5ZAOZZgDp0doEQiiHX?=
 =?us-ascii?Q?8DIjRdKucCz7sIyldsl4wUsbF38JzgiyH4YMYSSi7LEyh14kOueXB/DRBkEM?=
 =?us-ascii?Q?FrgiCPX5MJreF+dRI9+YgW5impgETpFC+TDiFqhUD1qCtZwZ9Im/wG2sj3us?=
 =?us-ascii?Q?rG89jrHOVB9x/QG8bM6Ppkfd6770KqYTmM0h2OpikFFpQSZy46KtD+RzMrwp?=
 =?us-ascii?Q?z87ZKHPGmCFAiAwld1uYvvLmmSRLkd729+Sc4cvDTnSm6ww09q8LzbsHmuvt?=
 =?us-ascii?Q?rC/PS1ldMDqRnJYIeH00IW2HEDcg0fgvXHYohc4FzNmeaIenXytJNJCKgatr?=
 =?us-ascii?Q?QfhajWWodrbIOlGuFhOXH4NlGOolX5ZkDz77soKH5+XdUMME7OBgcvTawcPA?=
 =?us-ascii?Q?KxZVX88dprOiLM1cpbdwp3YPc/yN5BHDOqBawPn4kPeTb2DxXpVBdIfKs0no?=
 =?us-ascii?Q?DKvwjQx1ph3x4UUYm0I6MRi0u6lcKKRHsUFCWzuk3yftK2ZbDDVp0Adx8XL2?=
 =?us-ascii?Q?9tipaYBcPRYDWoTI+iAX3HIOYeAsDWPnDutwT6J9td96HASmhKM/3tNzg+7N?=
 =?us-ascii?Q?/K6sJzIMQk0pzhZLAnAy4rBwyLlYfcTF4X4wEDy3wwNKVr6D3/H5r5wpBR/W?=
 =?us-ascii?Q?mmRfjyNUthQ5jnp6AeKevWVuJb1TNuNJFsmP48pspXyb33baSGzFebhL0J0V?=
 =?us-ascii?Q?p4ZyMulURhUNDZhLHl+o6hk13UsJn5Njrx0ccqLBvgRwJXHiTkgYgi9WRA6a?=
 =?us-ascii?Q?QW/SHsLkZizjLyF0pRj0g/AvV2kwIhgsSKkD1KGGnpiFhscGksrMU39U7LVV?=
 =?us-ascii?Q?gPCf9vVr5+EarOJodX+6dlETl0inrTt2dvCOZk8l9cmqb6xoYBHAH7yc2cRS?=
 =?us-ascii?Q?lMxmrCBwRf2vsI6+takh7kC/ET6CyUPQoIgDST2B/9nzDyTB7noGLKK9zIak?=
 =?us-ascii?Q?bTuljksCkg7IJgM5NPLYkhuYch2n34DkgMBtwYbaKJNyi+vIFOqiVvEgT/Fp?=
 =?us-ascii?Q?NQI2ZE/3jRttlbBq2NshfNLdThwr2p3tn7UTpUO4ZAxCSWdX9n59ERhfe6H2?=
 =?us-ascii?Q?/WafPNxF5aPfrh2Wd1qOOIo1BKR2J+l5zJZBGljr1pNYZAEnnWuAJT8Qn504?=
 =?us-ascii?Q?QfDDRhVl00mbKjvcv9OCvtPcXbpm7xVs7/EsuwFpnrD2pH5uBa6zY3Kkaujj?=
 =?us-ascii?Q?kJ37Fi9B+taBYTLRUeOx5nA0RZmr/sl6G7UZqfHWWD0oyRPBy2sn7h0jB1m/?=
 =?us-ascii?Q?abVc+G5ourshQgNtCFTAC68Buu50Ka5LGZ74VQm0uSkMyW5feFCn/q+CI91P?=
 =?us-ascii?Q?TKBMXBDDzxfZqIwc1uN3ARE5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4222fc-8e42-4327-ab33-08d8cb9b3c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 19:04:46.3715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXhpaluIr3I/1T0MIg1RvKSj89zZdOF5Ox2r/3ZsprDqkp+19OmWfn4myfih5XeM0yZPdNoHY1tne40qVZi1I1xhRxbzZQpDSpAJ3vfEMoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3119
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> On Sun, Feb 07, 2021 at 02:03:11PM +0000, Winkler, Tomas wrote:
> > >
> > > On Sat, Feb 06, 2021 at 03:04:34PM +0000, Winkler, Tomas wrote:
> > > > > On Sat, Feb 06, 2021 at 04:43:25PM +0200, Tomas Winkler wrote:
> > > > > > From: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > > >
> > > > > > Expose the client dma mapping via mei client bus interface.
> > > > > >
> > > > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > > > ---
> > > > > >  drivers/misc/mei/bus.c     | 46
> > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > >  drivers/misc/mei/hw.h      |  5 +++++
> > > > > >  include/linux/mei_cl_bus.h |  3 +++
> > > > > >  3 files changed, 54 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
> > > > > > index
> > > > > > 34fb5e541fe5..d430710a5fe5 100644
> > > > > > --- a/drivers/misc/mei/bus.c
> > > > > > +++ b/drivers/misc/mei/bus.c
> > > > > > @@ -636,6 +636,52 @@ static void mei_cl_bus_vtag_free(struct
> > > > > mei_cl_device *cldev)
> > > > > >  	kfree(cl_vtag);
> > > > > >  }
> > > > > >
> > > > > > +void *mei_cldev_dma_map(struct mei_cl_device *cldev, u8
> > > > > > +buffer_id, size_t size) {
> > > > > > +	struct mei_device *bus;
> > > > > > +	struct mei_cl *cl;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (!cldev || !buffer_id || !size)
> > > > > > +		return ERR_PTR(-EINVAL);
> > > > > > +
> > > > > > +	if (!IS_ALIGNED(size, MEI_FW_PAGE_SIZE)) {
> > > > > > +		dev_err(&cldev->dev, "Map size should be aligned to
> %lu\n",
> > > > > > +			MEI_FW_PAGE_SIZE);
> > > > > > +		return ERR_PTR(-EINVAL);
> > > > > > +	}
> > > > > > +
> > > > > > +	cl =3D cldev->cl;
> > > > > > +	bus =3D cldev->bus;
> > > > > > +
> > > > > > +	mutex_lock(&bus->device_lock);
> > > > > > +	ret =3D mei_cl_dma_alloc_and_map(cl, NULL, buffer_id, size);
> > > > > > +	mutex_unlock(&bus->device_lock);
> > > > > > +	if (ret)
> > > > > > +		return ERR_PTR(ret);
> > > > > > +	return cl->dma.vaddr;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(mei_cldev_dma_map);
> > > > >
> > > > > Why are you exporting symbols without a user of them?
> > > > >
> > > > > That's a sure way to get them removed by someone right after
> > > > > this lands in the tree :)
> > > > >
> > > > > Please only add infrastructure for when you have a real user.
> > > > You are right,  the user is coming from wifi tree. We need merge
> > > > before
> > > they do.
> > > > If you prefer we can merge that all from the wifi tree.
> > >
> > > That wasn't documented well at all in your changelog comment :(
> > Note taken.
> > > It can go through whatever tree needs it.
> > If possible please merge our changes already here, and let the wifi guy=
s to
> finish their task in their tree, in their own time.
>=20
> I took some of these already, patches 1 and 6 I can't take as-is, sorry.

As Tomas said, 6 is needed by iwlwifi. I understand you want it to be route=
d through iwlwifi-next.git. I added Kalle so that he gets a heads up.
1 is not related to iwlwifi.

