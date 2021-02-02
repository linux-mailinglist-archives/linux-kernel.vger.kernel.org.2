Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8A30B89C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhBBHWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:22:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:46233 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232202AbhBBHWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:22:21 -0500
IronPort-SDR: Wad/MuvawBnVa7AOQjypfK6MsFr+nQtNELwsAoZXaGvA+kmu6s/l5d8hU0TE1jg8qBoJcrVt6r
 LemhyV1hPLvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="178250952"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="178250952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 23:21:40 -0800
IronPort-SDR: GbmxlqSA0+ktzKQBAP//PDQWdnLuhb3CjjS0gvnJ/UwDPgghW1855yqUYw1JT+w4HBZ627KHf3
 o7dKHSsodKtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="371848994"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2021 23:21:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 23:21:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 1 Feb 2021 23:21:39 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 1 Feb 2021 23:21:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFBz8IIrPaI2bl+8jApueDRTjggeq49BdZxEKS90H8HTA+hwbQKvs4UJaKz0rEHQ80+PvIaQM3YJ5uTzPRSDJojJCDIMPMUvIxZ2H3IE5WZOT73Y0/+ptWevBVJqka2cwReX3n+xQnadDWbWAe7jQoiAMnHJqdl1VASZqCM/o6qkbQkR3rRlbiOs0IAHy4FYsKVoNoghEnad67Z1MptkF5Yd8M43jgxCnLzFewLimb7sHdeurBBV5u0OrO7+n1LFeG3+iDhzRNXZmMwpVsv45EYDVGFxq0Q7LrfzRYFf+Pae1OsZjshFQ8haZM/Po6B3dO0PY31QvlDJu1Px35JxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtW7S9QXosUJbW+7jercbtuNidJO4zbioOVDwa2oYnI=;
 b=djYdJZmh3kOl2jhmRH4rofLIazrJzP9n3oIbaM83gUypX1JEtOP4Ubctu6FqJFwT43meZeKYvWBkjj/FF/x+5dOaaTvS6Ud3Coa+rv32vUGSYZE9Kxw6VQpJQVG8WbaseuNWwcgPN1GZpuM79Fc6+fznnmWzdN4RMLZFu7MZdnWiRUYv8YJB5XElS6sI2xu/a0BsCxA/Vlndtkd84f4CrVr3JFHe1iag4IAXHu0ic6iWT0Gq1F1dr29c74pA3VYGZfxQA2AuJ/7PCzp2wzSaSoc6sjth6BVnfELe1P/T/3HZzMUAPAf5p9WIZOls6js1SmiNY02QD2ecAqUwpSx0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtW7S9QXosUJbW+7jercbtuNidJO4zbioOVDwa2oYnI=;
 b=KGK/Aa5aZ/PxXe8sZs9j8ml18erPkZsTHxxBWsIAYyLI1IInolXQ6w0ESoVIY6RcXW4M8tHtnO2vOhoMQsacb4l3rPZWFaOsonUZJJ10Dff4rR7n5lsOeSXHFcb3jP72HU+VfUrePAMCQDhbkQciBoowPCu/b7SpmxUfW3XGPNI=
Received: from BL0PR11MB3234.namprd11.prod.outlook.com (2603:10b6:208:65::14)
 by BL0PR11MB2882.namprd11.prod.outlook.com (2603:10b6:208:7f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 07:21:37 +0000
Received: from BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835]) by BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835%7]) with mapi id 15.20.3805.023; Tue, 2 Feb 2021
 07:21:37 +0000
From:   "C, Udhayakumar" <udhayakumar.c@intel.com>
To:     Joe Perches <joe@perches.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "C@linux.intel.com" <C@linux.intel.com>
Subject: RE: [PATCH v3 28/34] misc: Intel tsens IA host driver.
Thread-Topic: [PATCH v3 28/34] misc: Intel tsens IA host driver.
Thread-Index: AQHW9q6kKI7B3kdFz0maWNwe9FgDtKo/vhsAgAS6yoA=
Date:   Tue, 2 Feb 2021 07:21:36 +0000
Message-ID: <BL0PR11MB3234FB531897D8A012055F34E2B59@BL0PR11MB3234.namprd11.prod.outlook.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
         <20210130022124.65083-29-mgross@linux.intel.com>
 <5137ab3793f03c17a719445f14131c16e7766434.camel@perches.com>
In-Reply-To: <5137ab3793f03c17a719445f14131c16e7766434.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.172.179.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec1e02c5-e77c-4e8a-c580-08d8c74b2d57
x-ms-traffictypediagnostic: BL0PR11MB2882:
x-microsoft-antispam-prvs: <BL0PR11MB28821BD9EA80386C67B18962E2B59@BL0PR11MB2882.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K71VriyGtjanhyhYm2zwH/aSdkdReb6GtQ/bXImuaQamEe1XbmVhZ/cKc58j5KXzo4csSNLgIjfatFjuHpjq9rJu0JZ2jk/J2HxzWSVfj86v8LTZEXa1FcKiVON91u8XWvCjTbL8/Qb92Pt7up+DwCreWNbhUrdRVyOQCyPPjl/8Tf5mzj/4VDyg+3M4baSQR1uLh+IevVsPnIlsesxQIe6S8oX3DNOHTSCgB6dbvy/9p0/jAhPHLyey19zU7h4w6yCriXOVG2Pf37GxtYAGALQ/AJV6OcMiFK6YqUzwIAW9DRsHImuGrg/b103IwaxtuNAbCZzJJ7mmG3AicpHf550FlsKrkrAmUs9kJaSrHgPRnFf7kVuus/pTcLJRBExaefYlkOTmUKolygUomlzNtXcv2xUjsQXx/pG1GP+v4CdqhscJFBQmWHN7iSOlawNGJohQahV0oid8APx5mTXtCGmCzMale7fvFJ+RHp++azUxfC3XL7hhJyrt5Xb5BOabjp1ORICuZZnx1xuM2oDSwlT73aQniS/yzer1So2Ul5FULCSLFnqqtxRb9H06KHLF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3234.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(86362001)(7696005)(2906002)(7416002)(4326008)(478600001)(8676002)(55016002)(9686003)(54906003)(316002)(5660300002)(52536014)(71200400001)(8936002)(110136005)(83380400001)(66946007)(66446008)(64756008)(66476007)(66556008)(76116006)(921005)(6506007)(33656002)(55236004)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2+kjWIa8GEhjZ8x3j+5TiwBRHkjbym68YZY7/bsV0Hh7YEzbPsEsfYXZh9Y9?=
 =?us-ascii?Q?2ZzfccQuCZs0Z4OeMoXqJuZ2swvItXBdhGXIwlH8u+7UMpQz5uS/gh2hV97y?=
 =?us-ascii?Q?59vqoU1vMhakwRFuImHt0zD6ytf0d417VM0LU8q3sRFyQs2XZRT2D3rckWKY?=
 =?us-ascii?Q?8pjBIijn2iVbtXYB7j1Za5UUKlTApSO/YG8m1YTgxvMQv4is6Iw7xm1+UtCm?=
 =?us-ascii?Q?DCFbRcB43syytismoHFxJUDZ/fVLv6xlaVY+MTjAeaMH+LVPTBXbvh1C/+4b?=
 =?us-ascii?Q?H640FkaZbYrFpCKZEeiJ/rtF8KY1npJ/BOMynuEdedO8V/XUTMmGnEc1wE61?=
 =?us-ascii?Q?nJnJjZDd+m+WplN+DbZCNMUfXf9m/X+vu9gpZrxg6B2UmyP3CZyWT7kbQXwZ?=
 =?us-ascii?Q?GSCGopQEnC24bnleTAay0tJt85hfJBpOPiqex7lOGRCJ95iE0eNWhR9Wqhb+?=
 =?us-ascii?Q?w3SI5S6vMLxxL/oMR/84KoUb05bfbMlQgCjhXnGxAW46lW7DwV1AyvV8ajZY?=
 =?us-ascii?Q?3FYilnOb75Ufs4UNXGeGE33e/XWUsLXgmqIoEjy6fK6z2zKH5ltwcbU3yfzW?=
 =?us-ascii?Q?qNQ/E9WSKW024jKo9/aXWkwONSPNW9nZCxf4Hk1iK+rzp9zah4u192rQebFe?=
 =?us-ascii?Q?NVAgRlAM2y+31VNwsA/Jg14ID0x5WCwuMI6dtXhkHTRb8watcgOZR+hw0zvi?=
 =?us-ascii?Q?DfPxuepNl+wTf322dw2Vuf2/QIbRAGnIKUsSY+j8GeyTXJf/ehHzDgXtxoWm?=
 =?us-ascii?Q?/mi3kqto+K/IjXcWJwxKj3RTWvTn8oPkvYxbYYu3CkpiGJM0aj+ExTwnELTz?=
 =?us-ascii?Q?Ef0Nv4aQ65GfRQ4WDPDqQIg3qF7qWil6AFT5D2790pKdcSgRH8xMnj5WgsIH?=
 =?us-ascii?Q?Od562aJRCpdrborrvlYLN5pWcDeD/6ScQofbKtQjbLfOSstDzxLqURbcIlUN?=
 =?us-ascii?Q?By7k30U8J60bRh2FAz8/tebhuCUy1hlDQcPXed8FAIKLbtJKFgdZokfE5ry2?=
 =?us-ascii?Q?dWEwePLR9dHCjVWolYTWk8iUiBEVVmt8xXOpcaR9+BzQfCQKFqiRucOJVVrX?=
 =?us-ascii?Q?0FtTQIuD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3234.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1e02c5-e77c-4e8a-c580-08d8c74b2d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 07:21:36.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4vgGqdqX0IITPK7/ragF330PtNtqLC0IYeqXOCMtpiJWckRVRKU0L3whMfEh1oDHmdDyrfenfB9t3MxlCcveA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2882
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2021-01-29 at 18:20 -0800, mgross@linux.intel.com wrote:
> > From: "C, Udhayakumar" <udhayakumar.c@intel.com>
> >
> > Add Intel tsens IA host driver for Intel Edge.AI Computer Vision
> > platforms.
> []
> > diff --git a/drivers/misc/intel_tsens/intel_tsens_host.c
> > b/drivers/misc/intel_tsens/intel_tsens_host.c
> []
> > +static int tsens_i2c_smbus_read_byte_data(struct i2c_client *i2c, u8
> command,
> > +					  u8 *i2c_val)
> > +{
> > +	union i2c_smbus_data data;
> > +	int status;
> > +
> > +	status =3D i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
> > +				I2C_SMBUS_READ, command,
> > +				I2C_SMBUS_BYTE_DATA, &data);
>=20
> this can fail
>=20
> > +	*i2c_val =3D data.byte;
>=20
> Is it appropriate to set the value if it failed and data was not initiali=
zed?
>=20
Thanks for the feedback, I will update as below in next patch version.

if (!status)                                                           =20
    *i2c_val =3D data.byte;

> > +	return status;
> > +}
> > +
> > +/**
> > + * intel_tsens_get_temp - get updated temperatue
>=20
> Might want to use codespell on all files.
Yes we have ran codespell before submitting, looks like codespell dictionar=
y doesn't have replacement for ' temperatue'.
It has only below words.

temerature->temperature
tempertaure->temperature
temperture->temperature

--
udhay
>=20

