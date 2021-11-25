Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8745DFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhKYRor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:44:47 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:34625
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349418AbhKYRmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:42:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp7BtWfFh9CT9xQQtDCcCw11YoLaCpbtK/dPwEsN1O2jfDfumxh6ahNoeRfoW3pcLllpko0ELZgXu7XXiHjEzOzoEJmpEquqBnr5Esvhp9LMzwqhwebG07mrsz+cTdIL4GrdO2tlw0F1BkajLqc8Iv9/YSXJr04NK7LtF/Us/5SB/SkEw2ltFWxPMJ7bnwemZXYP+q9vnbjec+1LAThEUoHHgbAARZ7GXNlXF7HmDbz87EYw6gjS1Y9qCAccfyL2ZsXlCxKlkTmLK2fZzhsFFx8dgZrjXkwxFTEFBUKcn5OGKlyuaeQJ2ycx/agcK2Msaw67f9X89NQTKVmR//P9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUMYJMjPChfbMuA1CruTIvRS7DfMVKwb4qJtao6pzBw=;
 b=VDwdIzzzdAGhWTyfFmhM/LJKyGzXh79/1zuI8IFNmHxebEZu5iFkoCMY4X1qSYzriaAUL/w22sjMSRNiyhzQ8NGoBmbUJryZnAJbl9MEyXeiBwtSjUVJQRoL8mRjfr45MVdzrBdyjI10XDKKpplzZNQcFMZMve/x4au/Gu1hzMpTAHVx14u5A6pQMYGF/+9Urhr7Zgb2+aKtUttveu3JDip7D0aReL8a367btwtc2jmbsQjgupBuG9GVE88V8JDktsCmJ9F/1xjC1cNMVnaNDfCPdXFPOw2dEtVf48gVD2yQPX8xua1XbANZ/6dWQxMIXi+xqVzHkVVI/L2FOLeaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUMYJMjPChfbMuA1CruTIvRS7DfMVKwb4qJtao6pzBw=;
 b=UiqpfjRhzWGJZBkJZk8gLGbQYd6jpXpBeMY4XE0ReKaX5xR+bq94t22dzX+ohxQVsij/9QGgErL+iQGx2Z8nhS1ZntjMQyFAuzmfxOc2hQCJXKSsWvHXwWK2Qzrh5lKv85q+gdodE+o0z54r1ushzCt94wnI7S96MUNsDMt8QCT87L+fLrai+nDpYUuLoh+IJSppljVL1JFoEHgohp2TCI8B1/wW+sHo9sPv8iV9D4we+bPqv0TaNRhPFiXSdLwI9qPMWrpWg3plRh78jThwv+VY7U9a6lCJnTposjvF/0F7hAd+araXfv/1UBnEDWiRNNwzzcsn5rQ5mk4GZumMyg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 17:39:42 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 17:39:42 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should '(((1)))
 << (mdev->id_table[i]->device)' be a 64 bit type?
Thread-Topic: drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should
 '(((1))) << (mdev->id_table[i]->device)' be a 64 bit type?
Thread-Index: AQHX4cqcCgOc0Z4NNkeu+HNF/OFQ86wUa8WAgAAWjlA=
Date:   Thu, 25 Nov 2021 17:39:42 +0000
Message-ID: <PH0PR12MB5481637D2D18E567C2AC21EFDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <202111250317.VUsGtdox-lkp@intel.com>
 <20211125111511-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211125111511-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f7f7197-f92d-44ae-eaa4-08d9b03a902d
x-ms-traffictypediagnostic: PH0PR12MB5482:
x-microsoft-antispam-prvs: <PH0PR12MB5482243BDCA54F7AA1828781DC629@PH0PR12MB5482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:183;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9UiDxpJR1B1tDS19UZIAlwnfd29vBOvRCysyiajeF+QXC0Vmo4+icj6HtxeMPeh4P3SPNrGjFkhNPqH/DmfCMYawDIIZaI6/LuRK7k4jqz74A3LZ0myTkitk23Gsxv3QbLrTmMQpbQYbHl+BL11kYG8+RpAZIJR8kJ0NptLeFHmZJQr1VNrFvoK9yjqq/CQKguLBhrinAx2GpEXI0JYOTRwpu+SKtRVr+/ZpMrSNvmisHBVOeR5p4+InKN6yW50eUN5wW8Po+f9zfKy0ugEzSwHZ1I+gsOZLPOy/gG+n0QwXcnB/J1QWfPBNmuB+0ljOZADT+DykOiXmBYfiqJZsMQvKtORT6Yogp+MoI7lJSH31Y3QiZ/tu+ihZuDVohUeVBIqPjlC7SmKwy5jRU9wmOVOL9xK2o42IoFxajsV7VBXOiXZwk4yVVig4iFfW+f0/wKMRakR83RKhFvTzBZp3MXdFmAMLN/2yj0eHAfH1Rwxm1hjKa2AWsHuwF3t6QhysdQRj3rZh78CxFCBqYU5jqyNZKprd6TRCld28rbpkT/Tu7hrJnVgbzTOS/tWyClU5rZ/gOgr0MbGGfLCiiY73jyYAkxvtu+n/uFyZ/8+irWCktLfbGFBP9CvKLeq3VfZTK34OUhB/DpmX+ezVFbLz4EwvPNMoD4NCqHO7529DxUnKK9NZk+Yd8xUELvE/E0hRxKd4IRC95yxdjHpRiHnFFYJ1I0LIAh7VVEELR9RBwVs6akAgBv8tBjjAN13k1+ZMr+j/uQMwMRF8J4clDPWVVlD7wlj/Lnm2jhkBMWgQYEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(5660300002)(33656002)(83380400001)(76116006)(966005)(19627235002)(38070700005)(6506007)(64756008)(66476007)(8676002)(7696005)(66946007)(9686003)(66446008)(316002)(2906002)(508600001)(54906003)(71200400001)(186003)(52536014)(86362001)(8936002)(55016003)(110136005)(122000001)(66556008)(26005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gmrrf3VCHrpKZ/fp/0SpNqVfK8H/RyOZZ03L/7XdvDgOQGRKkFyaH/gAQtAO?=
 =?us-ascii?Q?uAPFRkcO4BaI144SJ5HTW8fCmVrJaA5qpiWNmfLKetaM2lkNdGrfq1N9MfJ1?=
 =?us-ascii?Q?mirlnkm/Q/uWlMVDUcF8JU0+MvHeUaKaMRnbVX+DnVS1/cC01rRV89FAW9yt?=
 =?us-ascii?Q?QVNBCzPbd2xfyi108NbzrHl1yorSZa1YCuKOq2zwQkyVlIFhbQYiJVnLzbyF?=
 =?us-ascii?Q?VAx6iIj46uvcw/0gIMoC5yoE6vR9KHqRm8uUkeLIAOYa0S8YTsA82tRDwKUt?=
 =?us-ascii?Q?UQ8v1YX+86bGniMEQvr3hA9Po5W560YK/YrclQYLkBwxY3HWblv0unO9Rciq?=
 =?us-ascii?Q?KqZQLubGOUyJ8mvRNe84NWFbvM7QHL9W/cguixPu/bO9avyh4+ank7Z7Y6P/?=
 =?us-ascii?Q?v0nMJORTl+JnNDyfn14F095DtOy5n+n3ELeQti1EU/axcU2QTQJeBtLyHQ5g?=
 =?us-ascii?Q?Fh7vJu11MNNSqg3Gu9M8PkkkOsEI2+mjyGA5L9t3b65e2yY42XX6R/nJs6b+?=
 =?us-ascii?Q?lGXeN6Z+9dZnhja6QWRPK3E5fapvA3jnjXsqvgTl9C21rKRft4Rj3BJ1OpIa?=
 =?us-ascii?Q?GR9UqAKNfqQKxoGOGr5375ZMz9j1kGL6p82782DPYZOrBe/bXLeFnslQD+Rr?=
 =?us-ascii?Q?RX4CuSb9fuMnJPg9Jz6frxOK9BLArIA90p8ZVSULvWP/mQqR40qyY4HNl64r?=
 =?us-ascii?Q?UZJA7rrwn1eIMY/2CpJ2m7oJ1G6tmp1j2IQcKVEjZy3vy2ezTTH05YkG/zAb?=
 =?us-ascii?Q?Xo8Hn4yK3XMifB+g9iXS04Oz0fKaNWw/GvLhgMWIt1Prr16eEljKZ/Y1M1wi?=
 =?us-ascii?Q?WllgEKsTgk5+q1Xr30cSh71MVrelGmTr6jlRQmEi5jtMhgxuMO2Mbkfpv0Kp?=
 =?us-ascii?Q?CmlQ8a9YB7Yx1rUmWk6kvfkIyt1FuKnywH9pNya2uJzto3PmDj+x76FsTuRV?=
 =?us-ascii?Q?WloSnmfaHdQALDmWNyMNu9+IhIt/2cpnMlr2aD142zAKGyjkEz3DQmy4Gyeu?=
 =?us-ascii?Q?O2/Mroa0VEs2zzus2ZxCcHyr1sVenVueizaiKSsNfi3d0+TB1Wq6XNIyUiJ3?=
 =?us-ascii?Q?8yIdA1rwnFEeJux1dZCaq4aV4md8yhWb7gvqfqKBDUFaHXngHbz3Q3i91Wq2?=
 =?us-ascii?Q?cLzGHDgWPIulRQI1W9Z0ALH/sZhBER1K6p3ZQSUVWu+1EapWL6rJcEbLgvXL?=
 =?us-ascii?Q?vKGikViQAfbgWfiz+qari19jAswRPTut32VMv/Cg/4o/ZRhfbUlygfgsoni6?=
 =?us-ascii?Q?9lIKYCVlwq/cD0P3PsRh3Vk7RyGrHiVGYAFLoX0fciK1MgaJoJvtWa0WIsba?=
 =?us-ascii?Q?tO0hU6qieRg5hok6P78j3xIXkRcebOMc0CMDsHK0PnQpdvf7b/5mbIZHW0F/?=
 =?us-ascii?Q?70yz6MTztqm0q8r3MVyv9dHNgGQDNf052WeW4GeSD4GMaKBMxynL+2CVzEGr?=
 =?us-ascii?Q?FA9OEDz6lNcXmHTFe/vtq61MV40X1lAXOjE8xlERASQRdAP4nZkZDkmAtnon?=
 =?us-ascii?Q?aNM6ZWrMuGHPynZFIN+CI4nNUIT2kv0o69y8LRESlrq07cvzK+XxIlJ7la54?=
 =?us-ascii?Q?1aNdmdYhvaJOxiibjEAS+3Y7AS9JhBy8ONroE5haOCS7EGKz6/7gkeqnNZ7D?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7f7197-f92d-44ae-eaa4-08d9b03a902d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 17:39:42.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6W6CY6g79Zq+QfdTHtuXLENWc4oWkCJauZ4hvPu8aKU5WZgeYc0EcyU8DV5i5Vav4swv9LncaSFWj88djpFgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, November 25, 2021 9:46 PM
>=20
> On Thu, Nov 25, 2021 at 10:03:28AM +0300, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git
> master
> > head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
> > commit: 33b347503f014ebf76257327cbc7001c6b721956 vdpa: Define vdpa
> > mgmt device, ops and a netlink interface
> > config: i386-randconfig-m021-20211118
> > (https://download.01.org/0day-
> ci/archive/20211125/202111250317.VUsGtdo
> > x-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should '(((1))) << (m=
dev-
> >id_table[i]->device)' be a 64 bit type?
> >
> > vim +296 drivers/vdpa/vdpa.c
> >
> > 33b347503f014eb Parav Pandit 2021-01-05  280  static int
> vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
> > 33b347503f014eb Parav Pandit 2021-01-05  281  			     u32
> portid, u32 seq, int flags)
> > 33b347503f014eb Parav Pandit 2021-01-05  282  {
> > 33b347503f014eb Parav Pandit 2021-01-05  283  	u64
> supported_classes =3D 0;
> >                                                 ^^^^^^^^^^^^^^^^^^^^^
> > This is a u64
> >
> > 33b347503f014eb Parav Pandit 2021-01-05  284  	void *hdr;
> > 33b347503f014eb Parav Pandit 2021-01-05  285  	int i =3D 0;
> > 33b347503f014eb Parav Pandit 2021-01-05  286  	int err;
> > 33b347503f014eb Parav Pandit 2021-01-05  287
> > 33b347503f014eb Parav Pandit 2021-01-05  288  	hdr =3D
> genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> VDPA_CMD_MGMTDEV_NEW);
> > 33b347503f014eb Parav Pandit 2021-01-05  289  	if (!hdr)
> > 33b347503f014eb Parav Pandit 2021-01-05  290  		return -
> EMSGSIZE;
> > 33b347503f014eb Parav Pandit 2021-01-05  291  	err =3D
> vdpa_nl_mgmtdev_handle_fill(msg, mdev);
> > 33b347503f014eb Parav Pandit 2021-01-05  292  	if (err)
> > 33b347503f014eb Parav Pandit 2021-01-05  293  		goto msg_err;
> > 33b347503f014eb Parav Pandit 2021-01-05  294
> > 33b347503f014eb Parav Pandit 2021-01-05  295  	while (mdev-
> >id_table[i].device) {
> > 33b347503f014eb Parav Pandit 2021-01-05 @296
> 	supported_classes |=3D BIT(mdev->id_table[i].device);
> >
> > Which suggests that this should be BIT_ULL().
> >
> > 33b347503f014eb Parav Pandit 2021-01-05  297  		i++;
> > 33b347503f014eb Parav Pandit 2021-01-05  298  	}
> > 33b347503f014eb Parav Pandit 2021-01-05  299
> > 33b347503f014eb Parav Pandit 2021-01-05  300  	if
> (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> > 33b347503f014eb Parav Pandit 2021-01-05  301
> supported_classes, VDPA_ATTR_UNSPEC)) {
> > 33b347503f014eb Parav Pandit 2021-01-05  302  		err =3D -
> EMSGSIZE;
> > 33b347503f014eb Parav Pandit 2021-01-05  303  		goto msg_err;
> > 33b347503f014eb Parav Pandit 2021-01-05  304  	}
> > 33b347503f014eb Parav Pandit 2021-01-05  305
> > 33b347503f014eb Parav Pandit 2021-01-05  306  	genlmsg_end(msg,
> hdr);
> > 33b347503f014eb Parav Pandit 2021-01-05  307  	return 0;
> > 33b347503f014eb Parav Pandit 2021-01-05  308 33b347503f014eb Parav
> > Pandit 2021-01-05  309  msg_err:
> > 33b347503f014eb Parav Pandit 2021-01-05  310  	genlmsg_cancel(msg,
> hdr);
> > 33b347503f014eb Parav Pandit 2021-01-05  311  	return err;
> > 33b347503f014eb Parav Pandit 2021-01-05  312  }
>=20
>=20
> Parav? Any patches for this one?

Thanks Dan for reporting.

There are no in kernel drivers today that can register vdpa device with dev=
ice id > 31.
But I agree that this code should not assume that.
I will shortly supply a patch to fix this warning.
