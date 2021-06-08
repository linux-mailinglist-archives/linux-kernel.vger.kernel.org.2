Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD8B39EDDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 06:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhFHE5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 00:57:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhFHE5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 00:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623128155; x=1654664155;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bZmRgqRxw+CeUtsEExgF2h5V96Ev6Bpn44cR0MXhWP8=;
  b=YtVx0gwoapEPXeGRtquuck6ocTsf1QE991f5/5DIYzOL9geWWVixtFcq
   pgaLT0QFZoPCwsrL6eEZJgaBukYADNtNU4E/KNYieyXpYJdKYTeGl2XKb
   AKs8MqIQeUFGuWAOd0CzWLneBuNHESCCxIbE6tfNXtkfrZtCgJvQdb6Nt
   n1Ea3VKqxBG3+asdEA7uIRzgaMGUOz1mr5tQnSnS4Kn0fSc9k5gn/g1K5
   ksN/ymJhvNXm403SrnNfJDv+48CxTqddZ/13XLSeHZAVpxITo+imCMo37
   D93PVX5RtfCGB2cnd/i6lrMZFFg4Y3fIprc+MjRB9WC0OUx65JhV1WLaM
   A==;
IronPort-SDR: 3p0HB4nfuGhoFgE+7fA6A84q6Kmm/V0yg3qRawl1tHIVQuf+yHkFf4txMPKRiIbdFlgMu5j8N9
 uERL4cPA34jJRWxyjfYKUOH0kthb5YCHblyRcSqrfhnTqyvKa3ZsbJGChdmiG8RyeVPM/n8Z4K
 677Vdvvti0O9evEnFpy6ST8s94nSoZ59MfQv6ZwaeBzoaP68Atb+jpccPpwcN7nW8c3u2EO7s/
 p//3OQ8OeHipeE2+RgvQlueDcd4XqjE0hSvIb1YpsUsefTPiED+Q9pjPexJfHixphMTTljZY7H
 CKw=
X-IronPort-AV: E=Sophos;i="5.83,256,1616428800"; 
   d="scan'208";a="175863719"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 12:55:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqlv3fOQT4jDhxwlRXSM3Z4iZtq+hgX8wxWViaE1wnlVAqWVoMp6iru2rSkLaiTo+Aq8uz4sL0YGoQUJbR2dXGU2Uw5tE3B1b/o7J0xcHnFCimk8iw2rDBEoov71MjrrRhlEI/9qkW0qTGVV/uOJpUrhdK25RJG/PVZLBHXecVSe8IBZAY8PY05WFOtMYhG09PITf6c9Cgozp3ykthdbJP2lw/uzE0BtkyXTad94FHkKbM+g9LXzjfyFy75VcEH7Q7iSp/ixiQ+v/91AtoY5bzpT9o5HgoIKTKobF9CjL/LNCKYiaKcKDjODmPSUFKDAmy8DmMnWOxdGpH3APNnZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZmRgqRxw+CeUtsEExgF2h5V96Ev6Bpn44cR0MXhWP8=;
 b=Gc+dQVOYhHGtIgwtN2cQXtCoabR0LJoCYNui+x4kQ4liDlpAGiEonRkbamjHMHvpvPtJpLhoX9ria/GXR40lLNDk771xhk8luy1tSNsmXUbK46y1qpPE8NJg/L7kr2l3FgLtTf9w9umXWreFedMgrtAj3CmuLQOtSczksIaMPjtUSZwpfi7LzZ/HclQ9nC/mp5fwLt1OjRMYJSdkBox1htTzgX5khAkAcHnLIlFyTMn/afqlgRtqc1rC2EjLHo4Nh1chWfJJv8xNPpLWAFyzDvjX4ZONHAcB7xbJ7X8U96wIu9geLW/P0qGhrjmSTyQRnZ6f0mlfkUw3LJB2TUzaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZmRgqRxw+CeUtsEExgF2h5V96Ev6Bpn44cR0MXhWP8=;
 b=MUgLrNa+jk/nOw82F9pIefJoKi7TFQbXuXIigUbFSE59O+Roa107QWJHX6Gjj9TSQiABYtvDo0uOUJPMFWr21bAhZvlTd0R/Bn50FLqrajMShEgAvZrTQgXhRXSBlPnUbEdnyKNtMapr0r2TeAjAimP5IgeUJ4uLR3jycv77Keo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3782.namprd04.prod.outlook.com (2603:10b6:a02:ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 04:55:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:55:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Wu Bo <wubo40@huawei.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] nvme-multipath: combine grpid and ANA state checks in
 nvme_parse_ana_log()
Thread-Topic: [PATCH] nvme-multipath: combine grpid and ANA state checks in
 nvme_parse_ana_log()
Thread-Index: AQHXXBqmyVn0k0yHLken2rUcMLjRJQ==
Date:   Tue, 8 Jun 2021 04:55:52 +0000
Message-ID: <BYAPR04MB4965B1255EFAA2987414EEA386379@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95e37c5b-7521-4275-3f86-08d92a39b149
x-ms-traffictypediagnostic: BYAPR04MB3782:
x-microsoft-antispam-prvs: <BYAPR04MB3782E1FDACF25D21E00D573C86379@BYAPR04MB3782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2EFhLYLd9O9VXJEgePK1E4pNEWHq/Rzyl9tP3+fHyH9pYqbkPTKf1reJUVuyl9PYnKZxk+0eBL7RsO5UQXtVe2zYdZp7mSJ2Pu1EJnyUf2iAe5VIVqPHayNdZbW2FMpst5DcZtVIw13ld155+MyLY7WDKoK8Me9YBvMGzWB0hbQhZodfWMUiaMb0x6cnXsGNpEpU7xnciokga/RpX1PdzihFVHnxpEROlLDaeDgfQd6gZfVI6u3hQ46te3P1Tq4kYX0tpvyfvFiFJSDQcvYzyxSVxqTWt8+oONx+UOG6CN27d1pUIvy/3X0HVMJk+6iS50j2bckVH73P/u0TVCUxt2c4vBy0BCrMZwKfNRy1mZfneA1c3ao9LmoPggk2dtJbptFg1dvTuhyQrAqbGmyJBXGZagH+2Xv7ces+n1573ETYTVKeABSlqrrLEAXTxFvamIrfrelMYYRLUd+/EsALa9gu0ecKmrOnZ0tdv8X8PLC58XZuOaUPzv39WSXbA8zhOimE2sCSqSSpE1dw07Rf/+Xea5oYXP8BG3tUqRJfyV2ElR9bxAZuhjoMhNYzJAeJYw/tWNu31/W2KDyplR5tqxV3HCu68OIWXcsT9n3xAE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(71200400001)(33656002)(26005)(8936002)(66946007)(91956017)(316002)(55016002)(66446008)(64756008)(66556008)(186003)(558084003)(478600001)(110136005)(7696005)(5660300002)(4326008)(86362001)(53546011)(2906002)(6506007)(38100700002)(52536014)(122000001)(8676002)(9686003)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?93DZtD2nAUQwSHE6P7Pw8C4cqZhksDn9+w2TNLOOtDZvHWsc2X0yKoP2TIYm?=
 =?us-ascii?Q?iYHY8iahlizUQwuuG9H+sSXApNeYP4nEpaCDxI2mB3Gm+pQ40zoUWSrmUwp1?=
 =?us-ascii?Q?75DbR2xNrygK5zosSLFVmbSzN+d72shax6FgNwsvFMMjvXSImdcT6+enNQ2G?=
 =?us-ascii?Q?PP9P4jyLmcTpD3/TKmbkC3dTwiuEZXWfa/PNfss54qgVGQicTQP+YBU1Bvek?=
 =?us-ascii?Q?bFPuTUm+V+gb4Od7OzpgqS+DdRtrQRODwj8kxpf5D7hqYO9Iz62x93/vh+JF?=
 =?us-ascii?Q?AcBSc4qUO5t3rny+7Ew83I73MslR2bUhswGksMzb0uuqqoX++Gq+49/1k+zr?=
 =?us-ascii?Q?MMzHfKegXvvL/fwrMHSMTmQ/SzCBUXZlyrs7Y8yxtV78d8pNeK5BaGuFssML?=
 =?us-ascii?Q?Fj6aqBUcbU8Wj1ObB5Y/sFiVa2s+crpewO7+z+xiheyKSsaU4dBFv1AZIzoj?=
 =?us-ascii?Q?jPGQbLwczrjmNAZEcZDgyhV6xcRmkFqMAvWZkQseoZzK9SRw6mbl2F508qTm?=
 =?us-ascii?Q?96JGuIflbixbeE15fhmBhj7uFelzanD5z+34YBQBeHp6xOXfmfwHEY2qPD6j?=
 =?us-ascii?Q?5+2oX0j0kXXKu476J3aDtGudvRv0ci2VU+pZfI3uqya/W5onAiiRGhBEkk8m?=
 =?us-ascii?Q?ipQe82huJyiKbXmIfCJzpn0tEnjfUljqMSC9Za5lJ6oLI6dblwzhdDt0FW+8?=
 =?us-ascii?Q?FR8fytxZnw/v+1cuNkCESzIs6V9D17yoaYmQ9lZs8skVch7od82lwKpeymqz?=
 =?us-ascii?Q?ANDGThE9mKj7dhIpUcHLUR+MIOcpA9H8mB/ts6CNO6fTngR0JM6ipag+9NF4?=
 =?us-ascii?Q?h75iLfsJ77gMtK3weM4LTc4IkWwKtqoDrmvn0loJ4NaKYZGCl/6Xj0mwVlIS?=
 =?us-ascii?Q?j8lIXjIVntGfNgr9wZw4qcz9gGhVCSi04kfw0gAkYjTsLCzpjOYL92ORyRBJ?=
 =?us-ascii?Q?IOfWzFH8bN8Ou3yblAjqq6/YwwtJj3vy8/5RLi/XBC9wh9KT1pkEmUnM3+Zy?=
 =?us-ascii?Q?JDpTI4KnbKno/2Z3n3YL4JWi5x/JFDUub+fJzHpZRHch1dnmZZgcSj6mIZG0?=
 =?us-ascii?Q?5zldeqQKZzHHgclYvBe9NQVLDnzjA+mFXGdjAVi/wOElCNR1Vr4pr1Xpb6Od?=
 =?us-ascii?Q?W70GiqZxJJ31rgGDsxF8RkJBlgWbmZ7l5Ad0IIxH0xwtTsEG49m5hHiXhfU9?=
 =?us-ascii?Q?krEPLjzFjwJ5UodbOySTBNzp/HIyTAoivfVhsAyP+XIUBDurHZmPxhwoqSAa?=
 =?us-ascii?Q?lU8ek0MzjWH5MQEYyo/+06FuNu+97LowaPH9Wh+Q/Q695Sy5pVbO6PTis7up?=
 =?us-ascii?Q?+57qx1ZvFao/FtOZx8Fwm2jm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e37c5b-7521-4275-3f86-08d92a39b149
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 04:55:52.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9n1HkxrthSNznHrMO0KTGkPpzqgShYM1EE/GoIBMvVAmPbZ8VrNQANKM/U+K2PDTgwBmO7f5EIaJgxVV90+8wyXWgH8DZNkWRUIhsKvX/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3782
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 20:59, Wu Bo wrote:=0A=
> Hi,=0A=
>=0A=
> Combine grpid and ANA state checks in nvme_parse_ana_log() to=0A=
> reduce repetitive code and more intuitive meaning.=0A=
>=0A=
> Signed-off-by: Wu Bo <wubo40@huawei.com>=0A=
=0A=
Existing code just looks fine...=0A=
=0A=
=0A=
