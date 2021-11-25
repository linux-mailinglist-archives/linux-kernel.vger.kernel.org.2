Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7545DFDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349357AbhKYRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:38:35 -0500
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:15425
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234671AbhKYRge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:36:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+iBexnZ2J9yG+JFszzavhlJzCOqlqPh3YVz6zkMz0nivdm5OU7vxPSHvJCBV0c5s5BE49RfznQ+MmAYRbtyHxcmUxVMIv2etWs3q94IvUtSvdLix9+A4bNLRD54NByekV9PD6NAVf3L6MbXj4rxgtb8NB9Be5Re+D4VPtOW9+20jLz17Llt6D4ID3r/bVx37nj2fb6bjDe+3iluBGLdqO3UzRywc8d1NO+GgpfwTVmaxQHzZMS2InbSk7XVZ9h5V0oco2h0zims5dUW6bGDsqw8TvSXPRKsWVvrrzY1fAwOmlION9QoLhpkRJIvswFDtfbZI34OrSnpxEx6MOlZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ/mFsGmLUfG5gbeyGeg016atpROzPDqzBUOKOPSpd8=;
 b=MGOH4JZ43WotyIV5K5OHtUlPxm5Eaeu2xBbGq1Q0oPZNeqRWf1b8LCo6tUu6CglM8fYBjz1KZt+hKg1EwsM3GGcDgwDGl1mYeCgY0hPkk4EvvyJS7ZeTpqGEBwhy8h84Unk2bqHs2T4vcjh6MEfAFQuLjR4O6DrcIJj+T5ieh3+YcUWaAjLVkSRbGXwx2dIcec8PpOrriApra7oJbylgTZs7M9NTPjLcNuO4j+8TsZiqcy3susSx1rEmbAMamfBY6QIhKzEU9LlZQJccYzMMrwDeu4VoPNKBj8vkJgyXaf1MeqAxSrd0D3v2S8gVckdD/VAlZFBh9TcpdBD75oH5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ/mFsGmLUfG5gbeyGeg016atpROzPDqzBUOKOPSpd8=;
 b=ON3hU3eufkkisbvuDKCqTfMRGxOOOZN07M0PRPQ+MW6aSaNZ/X16rNWS1IbF2OiYIU+YUCAjGgBFFMoF3l5q+ntFMLZFXk9gv/acDsclYetMIyHRF+LWuXzI7jnFeYRM+NJsF1yvdC/T9R5ax6W9wPOvVRQfepY7HUzzExeaXp5AYrXN3g2TcVpNCWAeSbyTABESNMa3n8+vCqZXNxgU3MZhe7ToS4VPAdSiEh2tYSSkkDZ2kSoxLYooe+LTHxvZAhUJklyGp53y6k97c0ysQ5qt9XtqKUpdCN8F6360dXOEWqaJRQnT+THcqQKjcpigEJcseQ7MEvo1gQKNcaNXIw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 17:33:21 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 17:33:21 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Joe Perches <joe@perches.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Thread-Index: AQHX4cqcCgOc0Z4NNkeu+HNF/OFQ86wUa8WAgAAKbQCAAApyEA==
Date:   Thu, 25 Nov 2021 17:33:21 +0000
Message-ID: <PH0PR12MB5481D135FD1034F371FFF938DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <202111250317.VUsGtdox-lkp@intel.com>
         <20211125111511-mutt-send-email-mst@kernel.org>
 <44a56ee66e1d635306f674d5646b19d059c5252b.camel@perches.com>
In-Reply-To: <44a56ee66e1d635306f674d5646b19d059c5252b.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75efc53-0b72-4e5c-bac1-08d9b039ad31
x-ms-traffictypediagnostic: PH0PR12MB5403:
x-microsoft-antispam-prvs: <PH0PR12MB5403CEB24E157E4136CD585DDC629@PH0PR12MB5403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p93Sr7zWjrItUYB22PipJuDiGxXi7A6RaOtmlgKFH7aYZA1HgAQa+dQNVtJLA3N5UnZjIBNCuVO4fARzbTExOFaOlVtqKvEz2782GZgAiJFvhuMWrNwygZRjNm/OWXpPjDjAR8sqt6FlPdjBFmw8p1ZW6xJ7jaxZT4dTR7ZV1Rjgm0d+0MLfUwGl4m0cY5SgJRRu+NwiG9MYvX+EAw7aozCdEwlxCR/87edzGiTfI8ynRGRFEtAw38FunMeDK/gVgeIfOBSaKi4v/MnDLVXSsqdXf7HOI9pzqVHcOnSFbk1T7ZV84uKhqPLmpFdTT8EgOHw+EIn4QuzW2dF2Pj1Kvz3q+Vel0IaiHf81CxGJrHaMJF+e9jTi3/rtE32/+LmXzRB6OyQbpDfQXLNaa7tTGRnbpn6L8Wh5Smr8xe/d3sfhHHXEow2oHzlfuQz0n78K/EB5CEp/KY+87rkTASj05XJ0FnlmYHIXQJ8vKNvwstef+H44I6o20enn47RsbO7adptZ6YZRbFZMfKWhDx8TzP7d8yo5DlCYLgvNN0J/L3Rj2PBGyXEywwKDHZXootPrrRZ9g3ZDPYkuzD/X/lNcTM8bEAz9F30xL97Hm+2TGZJJNZ3KfiXa7ITG9IR5MN+j6ow6WUwcpTlHczNfGRulK32vCZzWg2uvqJYJfm7h0wQAgLC5dpwKhsdPWbC10T5Nan1P8hftMDasdAYR4JUb/8AGR+8KqF0tT9Y1CSTauptwby0PV0CJOTZjpJRGB+H37HlcIeoZD9cv3WfJt6i+/8w+FktkRAD1e/r9xx/4O0Caj2fgcSxhgOz1VLqQdh6MLWVhsCgcChRggHVhG/2hjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(6506007)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(2906002)(4001150100001)(45080400002)(7696005)(966005)(83380400001)(76116006)(4326008)(55016003)(122000001)(9686003)(71200400001)(33656002)(508600001)(52536014)(8676002)(8936002)(5660300002)(38070700005)(38100700002)(26005)(186003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bSUTaQxmyuADKa96hyc3aWl8e0HDS6rAL/Tn/pnKLdzcGdqHH96N8Ux8K1hW?=
 =?us-ascii?Q?A0NBXGbXxc5feetQYa1AzNwPxffGqEDR5VzPaa6YX4aXI2svU6GyVW7pVBnl?=
 =?us-ascii?Q?yQXcdPIGsJnqlsC6nleNqrvvQsLX5Jxt2L/wWmWekd4Vk+7MXC1UpySVwX7A?=
 =?us-ascii?Q?uWcQc1s30aw/KCJGSwoY9VaqRVE0aEue6e+8UgDIfd1hVXKtOAPFhiv7tYFk?=
 =?us-ascii?Q?uC+bW0uasHiYyK/LW0+ZFBLWjODjHA7+hSLTSliTz2suYCaB237DTGIo/wKc?=
 =?us-ascii?Q?A+dlM+A5Au2KrKGsZKcz/POjJoqbjqIqdNp957iMMs5NeNVul7CZHsIiqNs3?=
 =?us-ascii?Q?JOGsewdIywpR6NwlxbQsp9aAhRvewSwnfgDdRJZdRhtjlKk9zCfPu4xlzCq9?=
 =?us-ascii?Q?MBFsuMnjhig807E5C5gp+vjBPH9lIHaS+9UjkdBhQl1Hyts6J29jOMS1v4sU?=
 =?us-ascii?Q?l5jy6OeUWbBqB2+mB3edzetaICDuD9MEKO6wk8px97uYrEGohA4i8rdQ+1ou?=
 =?us-ascii?Q?xb4C8yo5cMChzZFInOgPiIJp5Aprw4zbRahOCwuFop4acDXJKyyX7YUsvrEd?=
 =?us-ascii?Q?DwgDdvM3TwU87ppENK1W4kQM8Emgb+0q+PSj15pJ9f1evDv7kXHZNj2Nwk6/?=
 =?us-ascii?Q?Bwb+VlHojCR3pFD9RTyJGLxlVgs8auxfLwt+YGxVdW5c5bGIA6F6XX6yl1Kv?=
 =?us-ascii?Q?GacdNie6g+GN5R+mhcKOsVLt9xEQ0CWMB2O0CXT5e8ooxBYBrf40LgRNvkGy?=
 =?us-ascii?Q?N7FQw5ZxMHG5p2UfegkJ+dT+ILbmO7OO25Y1vQFebROROQPmxZUXfMNgNJc1?=
 =?us-ascii?Q?WOSh54iZDGkO87noEPIReZ+PUs+ps0kig2twXx/aRwU+5jpqFLWxwZurgI3k?=
 =?us-ascii?Q?7OJDliep/jIbWCt0TrLD2Kd1M3LZdBMnYex4XicaIcMuJMVEe75HI3VxAo/f?=
 =?us-ascii?Q?63Cd8+rEvBqqjXnGvxQpN9e+75mg9gWUy0/AJ+al1ZPSlDLn+tzEUsIKb+aP?=
 =?us-ascii?Q?/W+bh0V2PjOqyc5e7Yo/19RZn9UGSQP8GSV9sDNJhMtOvVazWFAnrd1a48cQ?=
 =?us-ascii?Q?41fxKcvwOCTBYFu1NdqRZ6H1I32kpUY5FrpBKjvSIQ2eua6Is7RHvDSM6fxb?=
 =?us-ascii?Q?uLRn2Upkw5VXHJ6+6KqVUjooO0gBV6GD75VEbcla4oOu1WftBnDdr0P1NHfi?=
 =?us-ascii?Q?bPK0pz3zUOZIcX+TbN5BmIOwV7zN/GeO2lWhKhEGVRKdruivnhW2RpnopsPo?=
 =?us-ascii?Q?NCF9c0j3uBg/70TsdZiH44xLgoDoX94/ELGycwA4fqqtdBljX+Cm/9FZC4Iw?=
 =?us-ascii?Q?yIiS2sOkYXfHMXXsLbkL4h2ESCJv2Fo3b5JK5xkvF3vJI/VHJldkETJrX7w3?=
 =?us-ascii?Q?lRgnfr6yDkRY6S/c5HGnMm6oM52Zr9u9IK9mtTg/+W1bfjRP3MyPbaJJhh2L?=
 =?us-ascii?Q?4gAh+XsSgBLUkDDuVAr5uKStXookF2Xp8Gs6G8oNp+2J/aw7Oaj/y7edIMx2?=
 =?us-ascii?Q?JCwttHQgrpgAGPU7s3xzEGGJbUkPZ5szqb0yDlvXLORn1BZdDno1iveVE5bf?=
 =?us-ascii?Q?FUOxdSR8IYK1mf/lunGZR1zoRw1ivih5HS2IK/64eCTb63eliSeHCUeegkDJ?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75efc53-0b72-4e5c-bac1-08d9b039ad31
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 17:33:21.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jm0pMQMd/BLbYoA9LJK0n4L+N/LRuV8th8DB7Rruh4o04YJva7WtC+Bo+M7oCzSmBOc4//7K4cIrZhKVfP5v8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

> From: Joe Perches <joe@perches.com>
> Sent: Thursday, November 25, 2021 10:23 PM
>=20
> On Thu, 2021-11-25 at 11:15 -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 25, 2021 at 10:03:28AM +0300, Dan Carpenter wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
> master
> > > head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
> > > commit: 33b347503f014ebf76257327cbc7001c6b721956 vdpa: Define vdpa
> > > mgmt device, ops and a netlink interface
> > > config: i386-randconfig-m021-20211118
> > > (https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
d
> > > ownload.01.org%2F0day-
> ci%2Farchive%2F20211125%2F202111250317.VUsGtdo
> > > x-
> lkp%40intel.com%2Fconfig&amp;data=3D04%7C01%7Cparav%40nvidia.com%7Cf
> > >
> 4d5aa1e5dfe431788f908d9b03408a1%7C43083d15727340c1b7db39efd9ccc17
> a%7
> > >
> C0%7C0%7C637734559803525095%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAw
> > >
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sda
> ta=3D
> > >
> 0XNeoKTYFnhqSH7Zc3MEVYoz00Ox2XAwrRSShA9XpdM%3D&amp;reserved=3D0
> )
> > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > smatch warnings:
> > > drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should '(((1))) <<
> (mdev->id_table[i]->device)' be a 64 bit type?
> > >
> > > vim +296 drivers/vdpa/vdpa.c
> > >
> > > 33b347503f014eb Parav Pandit 2021-01-05  280  static int
> vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
> > > 33b347503f014eb Parav Pandit 2021-01-05  281  			     u32
> portid, u32 seq, int flags)
> > > 33b347503f014eb Parav Pandit 2021-01-05  282  {
> > > 33b347503f014eb Parav Pandit 2021-01-05  283  	u64
> supported_classes =3D 0;
> > >
> > > ^^^^^^^^^^^^^^^^^^^^^ This is a u64
> > >
> > > 33b347503f014eb Parav Pandit 2021-01-05  284  	void *hdr;
> > > 33b347503f014eb Parav Pandit 2021-01-05  285  	int i =3D 0;
> > > 33b347503f014eb Parav Pandit 2021-01-05  286  	int err;
> > > 33b347503f014eb Parav Pandit 2021-01-05  287
> > > 33b347503f014eb Parav Pandit 2021-01-05  288  	hdr =3D
> genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> VDPA_CMD_MGMTDEV_NEW);
> > > 33b347503f014eb Parav Pandit 2021-01-05  289  	if (!hdr)
> > > 33b347503f014eb Parav Pandit 2021-01-05  290  		return -
> EMSGSIZE;
> > > 33b347503f014eb Parav Pandit 2021-01-05  291  	err =3D
> vdpa_nl_mgmtdev_handle_fill(msg, mdev);
> > > 33b347503f014eb Parav Pandit 2021-01-05  292  	if (err)
> > > 33b347503f014eb Parav Pandit 2021-01-05  293  		goto msg_err;
> > > 33b347503f014eb Parav Pandit 2021-01-05  294
> > > 33b347503f014eb Parav Pandit 2021-01-05  295  	while (mdev-
> >id_table[i].device) {
> > > 33b347503f014eb Parav Pandit 2021-01-05 @296
> 	supported_classes |=3D BIT(mdev->id_table[i].device);
> > >
> > > Which suggests that this should be BIT_ULL().
>
I will respond to this part in reply to Michael.
=20
> True but it seems all of these tables have only 1 or at most 3 non-null
> terminated entries.
>=20
> It looks as if mdev->id_table itself could be NULL though:
>=20
> drivers/vdpa/virtio_pci/vp_vdpa.c:      .id_table       =3D NULL, /* only=
 dynamic ids
> */
>=20
Below is not possible, because above id_table is for the PCI driver table a=
nd above id_table is per mgmt device for id table type struct virtio_device=
_id.

> which _might_ cause a null dereference.  Dunno if that's possible.
>=20
