Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884DF3D62AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhGZPhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:37:35 -0400
Received: from mail-bn8nam12on2139.outbound.protection.outlook.com ([40.107.237.139]:58368
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237018AbhGZPVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:21:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRv37Bt5TgEYQbNc0htM5BNBqmG/DGaokdhpTipa+yK5DEiKW/xcOc1iSpnYegRgNvjd4Vn0q5oAkFiQ11S7MXxLRC4oov2T1f8bqWtuQShsa020lEThq53G6J8+z/lfYUA3FDun0/p7KoHmKIRxhGKGp8hk+8MVc7ypKB0mA3Uor4vRwSJT+jbZFyNwGlNEU5cYd7iLh3ErDvEdHUVBQaBuLw7ZHuMwIFBO1P7aF0MXf/jt9YC9DEGzJOng5He/hInaR4ZsFqVFn44FJVVUSgOYhBDuB/tAMdWoZZkh4JWbXUkDXGQ6a6A/ZyXJlEctcjHmQWvrOI4Wx3B/3E1usQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmliEOlsT49IQT8c1Xyo6wQwLPDxe1dLnHi5kzC3t3g=;
 b=e3ptanBBOB1PGPWTLBEIc9Xq/Is49wL+NFQT+q6iTPVHaLbbA81+sNCo7m48FlcGrxCjqF2b34xaci99HM/weU7ENcPVgGDHjw9ZiSS0G1sRUFEBt5yww638mmNtdkP2h5bMwZXeuPmgBJgwRqRP/hmuFhdBt6AhO+lcYbzFNsj2FMsVhhV2LPSueXapzcRaT/zWTGEeaRHUqyVkL+5UC5fuyM+oAZWQIpal0Q/jVMvUazpg1Lg0tXCEsfnRAPfYffZvTqfwR9LsEZA0xpghTL8MdYlImQANdmKjCWtzlGZke5JeZi1/icjetBc14+wXR1ZLePM3tTrhbXiPAKZECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmliEOlsT49IQT8c1Xyo6wQwLPDxe1dLnHi5kzC3t3g=;
 b=eLHiQxbO7FTUq0F4awa0MqiozaVm+D3+WNmIZnC0u4gnMxRjZZhC1WASRnIB7s7hEYmDXoI+Ouym29ISe/03OR0y8T3j5xOLGm2M7bWB+Oh13g9u/HQWEkPI25Yy47q3M+EmLnXyBLVMthgi38b6XHW8GnMWrhmqRprX6g9Fejs=
Received: from MN2PR21MB1295.namprd21.prod.outlook.com (2603:10b6:208:3e::25)
 by MN2PR21MB1198.namprd21.prod.outlook.com (2603:10b6:208:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.0; Mon, 26 Jul
 2021 16:02:02 +0000
Received: from MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::d569:ff41:b042:7290]) by MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::d569:ff41:b042:7290%7]) with mapi id 15.20.4394.004; Mon, 26 Jul 2021
 16:02:02 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     kernel test robot <rong.a.chen@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is
 garbage or undefined [clang-analyzer-core.uninitialized.Assign]
Thread-Topic: drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is
 garbage or undefined [clang-analyzer-core.uninitialized.Assign]
Thread-Index: AQHXgdD6Ro87Kooqv0+2nGYCAoEgiatVabXw
Date:   Mon, 26 Jul 2021 16:02:02 +0000
Message-ID: <MN2PR21MB12955120969469392059D597CAE89@MN2PR21MB1295.namprd21.prod.outlook.com>
References: <202107251901.GJvlsBLV-lkp@intel.com>
 <39c4fa80-f65e-50c3-5706-809d4a2a2c9b@intel.com>
In-Reply-To: <39c4fa80-f65e-50c3-5706-809d4a2a2c9b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=449c5818-7cc5-407a-8fb3-81355f222527;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-26T15:55:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 137799b3-69d1-46f1-be32-08d9504eb531
x-ms-traffictypediagnostic: MN2PR21MB1198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB1198115AF8A26CB5011A5263CAE89@MN2PR21MB1198.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9DJIqbQ3g2le/lGHyA+MX23RA1XthSzaGdRMWWR3ZHd1fqkMyqyNhyubI4iJzkzAyju9jYKkN+biKJ16jGPxhlocmnp+cfnBhfQ7u4zNJkS0rMczFa5wCQer7xkyuburtCbrsugF3mlJws3GC1YCDkWN1OKX0BdQgGnxGeypDImjmU1TIcWA+9hq5Efv3AYhh7dR3oYfv/189gAkYGmIlHb7pM7xb9gGeex0DE7zIgnMctxN3L4+gud68l9sV5SzT65IK7OzilCwtQ1bU3tSzuh8uZs6qRFARZ+eSW7HUiCoA2Xcco/oiusTeF4czpPd+cqjpTMNh0h8IOeuhKNThbyFmxtvftDwLKU4uHPeWCtlj5p+KkAdscAszCaZek/W5+mN7s3DpP5p1nQTSuijt80d+Zzm29dSoWOWjhiwWZRE7tyHwdDHacchhzHQx3A2MG/qZ2x/kWQBfiGXFhhOqd2W7RlOIVlkS9yjmU/jU+DTrvXbtHlGrEvX+M1lgfPwcYggn2D4PZvTvfkdD1HakGrJBYg2rSlihOcSpsqph8np8c0lQzb7GsRDlo836sBSCr6GIqykRkCOBkR8Crn1qglCkn9jk5vEkKs9kf9nJL4//YVb7X/m0ve26kTj5fUzyXdZ3hqo3lSF58KK2YGh5Rs0B82roSQvDX3HvhXFuiwWMFb9WD3/i41wYCONvfvmtqnOxsib5jbcU7adtvdAskme8L4UmpujFLTqv2oUDvqTA5CrE9DBKhxnqF/ZYt+xgiNlyDUM1xvn9/rUZf3L3DSJSB+x9Ll5YBOH2Do53g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1295.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(107886003)(7696005)(38100700002)(10290500003)(83380400001)(122000001)(316002)(30864003)(966005)(82950400001)(4326008)(5660300002)(54906003)(2906002)(52536014)(82960400001)(53546011)(8990500004)(71200400001)(8676002)(6916009)(8936002)(66556008)(66446008)(9686003)(6506007)(186003)(66476007)(64756008)(33656002)(66946007)(508600001)(26005)(86362001)(55016002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oLM5G/cye+9Bs4J2mGf7Svvml86sFoBMAVJ4G8Lm6owK4skxZPqe4TUuFDZM?=
 =?us-ascii?Q?wewyC/3q+q04spLNrBhZwwHSvrAv4NqCyWAeKp4YKncJHnC606WeWNlBWwzr?=
 =?us-ascii?Q?D13Fnrk4PnvTA0ID+gRLD8TMGxeUBlNIjXVIlNKtZ2a1t5Fb5SF37GmPGEQ+?=
 =?us-ascii?Q?Zxs53VtwYc34a+PL440gkbeT1IYNAZGXv4y3/6HOjQ5SJ7gPvmxe+H2T3eum?=
 =?us-ascii?Q?wwoEKpKupYucEkB74Msc3LCEmK44bU/zNwbaRP0pVZ9K9wg55nZz9SkstYM7?=
 =?us-ascii?Q?EdOV7e/Uwy72R72jLoVvUAcAAjsDxCogBasKRUao3mzQTMXKuN3mTHR9rt1X?=
 =?us-ascii?Q?synzNjj/MWK5Y3jSP8i9uLdFvTJXJftoKFAtjOEAEecqCl1Y/PuXlsGHHbL4?=
 =?us-ascii?Q?aWpAkP5ogzSNpFCiBv0+gVFv1nDlGgAavrKZ2P6nA0Qwxb3czOKnSXIuex0o?=
 =?us-ascii?Q?t5/fTzfGLmVhYGRtHoXGV52t3wJASH0sogBQQYeQeTpaR42bPwvaLguSq507?=
 =?us-ascii?Q?qNHpTrCBUtuA3j/Z3dF5Kgjy0EDw0vZuYDlbtnBBtVOsGrvLsx+wDgJYSLAY?=
 =?us-ascii?Q?ImjgAMOwIupz7qwy9etrFLJ9myGctNy6f6fjXHn6+vdCAK40v1X4NpSfkAN2?=
 =?us-ascii?Q?uLDZ1/P35riYVV2wM4atK7J04542wPMd05hm8HGb7fFe0x9OZhbWHdiCfoh7?=
 =?us-ascii?Q?QN4Txot/dObgVYTmqnrhfG1TOU1RbPPXAd5sOE7zrzCaEKXxALg1aHOtaO41?=
 =?us-ascii?Q?p5CWFXDrkL9fO/Uug33qgsUm22vdvK8JQtFqciOVH/N4k+6DnbEHUmgEydyP?=
 =?us-ascii?Q?n7xzki4k10BIjC941LLJbdrpILi/FFxE566Na/CvNcO9aT+B8/YBTO4/QGEt?=
 =?us-ascii?Q?Q+2i6KyyPDm9cctmz+7rP6RehLGfPB6bjI0r29e1qeUC1ayJACsO1eQzNUeO?=
 =?us-ascii?Q?yE1j+Uxa+lHtUbEcAoAZtpiJY3F8q3XY+XimlM+UrYrocCR2kIscspWfChnF?=
 =?us-ascii?Q?BdPtaK2u2dSD2vJ5V1nVcgirGyqCePpfziZCHr1m4VoARGM3MCuoNImk/zsj?=
 =?us-ascii?Q?hx4IdvvN80XIAJlUmG2/KkUb5uQcA3E5q63x9Q7UREq1FlgVkA70OeHu5o/0?=
 =?us-ascii?Q?gQPWb2+wSzY61aBpnYuXW/26PlPA2JMX2t7RzaUkDrIdBgAEe9yaSz359V18?=
 =?us-ascii?Q?MEwIhjVTGdU7TnUufRLZ4+a4GzVwXGKhtIIK2W4P+3D2B8r2JsJVRF6dTpVu?=
 =?us-ascii?Q?ToBQUDKSxU8eDAtb4B0KoeQzpmVcxmuQ/ZTQ+ZunrUCxNgJNSwSz9LA7yOKn?=
 =?us-ascii?Q?QOX5b0LX3DdxqGmAm/T/9xaU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1295.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137799b3-69d1-46f1-be32-08d9504eb531
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 16:02:02.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3Y6OCnBfdbjTzvA1BHq9FVRXjn868U2aWx3CuuoAK+S/AieE01fbcfIRbwSocoEYblA4W0V/mtmVffeAQGQTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1198
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kernel test robot <rong.a.chen@intel.com>
> Sent: Sunday, July 25, 2021 11:43 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: kbuild-all@lists.01.org; LKML <linux-kernel@vger.kernel.org>; Wei
> Liu <wei.liu@kernel.org>; Michael Kelley <mikelley@microsoft.com>
> Subject: drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is
> garbage or undefined [clang-analyzer-core.uninitialized.Assign]
>=20
>=20
> Hi Haiyang,
>=20
> First bad commit (maybe !=3D root cause):
>=20
> tree:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
e
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;d
> ata=3D04%7C01%7Chaiyangz%40microsoft.com%7Cb1a7f087851b48a29bf308d94fe784=
9
> 0%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637628680585035821%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C1000&amp;sdata=3D6LkKnX%2BXhjmhh4m%2BzJ7y0JeQcwvwHw8NZP%2B=
v
> aXSdZV0%3D&amp;reserved=3D0 master
> head:   d8079fac168168b25677dc16c00ffaf9fb7df723
> commit: 7c9ff3deeee61b253715dcf968a6307af148c9b2 Drivers: hv: vmbus: Fix
> duplicate CPU assignments within a device
> date:   6 days ago
> :::::: branch date: 11 hours ago
> :::::: commit date: 6 days ago
> config: x86_64-randconfig-c001-20210725 (attached as .config)
> compiler: clang version 13.0.0
> (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith=
u
> b.com%2Fllvm%2Fllvm-
> project&amp;data=3D04%7C01%7Chaiyangz%40microsoft.com%7Cb1a7f087851b48a29=
b
> f308d94fe78490%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637628680585
> 035821%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DMKdTDUGKunqVOWEwafejDKuW0mpe=
N
> aP1ssqiv4SBvzQ%3D&amp;reserved=3D0
> 3f2c1e99e44d028d5e9dd685f3c568f2661f2f68)
> reproduce (this is a W=3D1 build):
>          wget
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fraw.g=
i
> thubusercontent.com%2Fintel%2Flkp-
> tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=3D04%7C01%7Chaiyangz%40micros=
o
> ft.com%7Cb1a7f087851b48a29bf308d94fe78490%7C72f988bf86f141af91ab2d7cd011
> db47%7C1%7C0%7C637628680585035821%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dg=
u
> Hq8MagK88xMw%2F6ZxmhQExnmLoIlYLma4QR1gmUYdM%3D&amp;reserved=3D0
> -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install x86_64 cross compiling tool for clang build
>          # apt-get install binutils-x86-64-linux-gnu
>          #
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
e
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcom
> mit%2F%3Fid%3D7c9ff3deeee61b253715dcf968a6307af148c9b2&amp;data=3D04%7C01=
%
> 7Chaiyangz%40microsoft.com%7Cb1a7f087851b48a29bf308d94fe78490%7C72f988bf
> 86f141af91ab2d7cd011db47%7C1%7C0%7C637628680585035821%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C1000&amp;sdata=3DN24YX%2FPLzONY5gKOu1U93%2B7uK4jm%2BIQYZzfA6z8FPHo%3D&=
a
> mp;reserved=3D0
>          git remote add linus
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
e
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;d
> ata=3D04%7C01%7Chaiyangz%40microsoft.com%7Cb1a7f087851b48a29bf308d94fe784=
9
> 0%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637628680585035821%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C1000&amp;sdata=3D6LkKnX%2BXhjmhh4m%2BzJ7y0JeQcwvwHw8NZP%2B=
v
> aXSdZV0%3D&amp;reserved=3D0
>          git fetch --no-tags linus master
>          git checkout 7c9ff3deeee61b253715dcf968a6307af148c9b2
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross
> clang-analyzer ARCH=3Dx86_64 If you fix the issue, kindly add following
> tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> clang-analyzer warnings: (new ones prefixed by >>)
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/hid/hid-core.c:1601:3: note: Taking false branch
>                     if (field->logical_minimum < 0) /* signed values */
>                     ^
>     drivers/hid/hid-core.c:1605:44: note: Passing value via 4th
> parameter 'n'
>                             implement(hid, data, offset + n * size, size,
>                                                                     ^~~~
>     drivers/hid/hid-core.c:1605:4: note: Calling 'implement'
>                             implement(hid, data, offset + n * size, size,
>=20
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/hid/hid-core.c:1421:15: note: Assuming 'n' is <=3D 32
>             if (unlikely(n > 32)) {
>                          ^
>     include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
>     # define unlikely(x)    __builtin_expect(!!(x), 0)
>                                                 ^
>     drivers/hid/hid-core.c:1421:2: note: Taking false branch
>             if (unlikely(n > 32)) {
>             ^
>     drivers/hid/hid-core.c:1425:13: note: Assuming 'n' is >=3D 32
>             } else if (n < 32) {
>                        ^~~~~~
>     drivers/hid/hid-core.c:1425:9: note: Taking false branch
>             } else if (n < 32) {
>                    ^
>     drivers/hid/hid-core.c:1437:30: note: Passing the value 32 via 3rd
> parameter 'n'
>             __implement(report, offset, n, value);
>                                         ^
>     drivers/hid/hid-core.c:1437:2: note: Calling '__implement'
>             __implement(report, offset, n, value);
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/hid/hid-core.c:1400:9: note: Assuming the condition is false
>             while (n - bits_to_set >=3D 0) {
>                    ^~~~~~~~~~~~~~~~~~~~
>     drivers/hid/hid-core.c:1400:2: note: Loop condition is false.
> Execution continues on line 1411
>             while (n - bits_to_set >=3D 0) {
>             ^
>     drivers/hid/hid-core.c:1411:6: note: 'n' is 32
>             if (n) {
>                 ^
>     drivers/hid/hid-core.c:1411:2: note: Taking true branch
>             if (n) {
>             ^
>     drivers/hid/hid-core.c:1412:22: note: The result of the left shift
> is undefined due to shifting by '32', which is greater or equal to the
> width of type 'unsigned int'
>                     u8 bit_mask =3D ((1U << n) - 1);
>                                        ^  ~
>     drivers/hid/hid-core.c:1984:3: warning: Value stored to 'len' is
> never read [clang-analyzer-deadcode.DeadStores]
>                     len +=3D sprintf(buf + len, "%shidraw%d", len ? "," :
> "",
>                     ^
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/hid/hid-core.c:1984:3: note: Value stored to 'len' is never
> read
>                     len +=3D sprintf(buf + len, "%shidraw%d", len ? "," :
> "",
>                     ^
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     Suppressed 5 warnings (5 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     6 warnings generated.
>     Suppressed 6 warnings (6 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     6 warnings generated.
>     Suppressed 6 warnings (6 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     7 warnings generated.
>     Suppressed 7 warnings (7 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     4 warnings generated.
>     Suppressed 4 warnings (4 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     4 warnings generated.
>     Suppressed 4 warnings (4 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     4 warnings generated.
>     Suppressed 4 warnings (4 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     4 warnings generated.
>     Suppressed 4 warnings (4 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     4 warnings generated.
>     Suppressed 4 warnings (4 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     4 warnings generated.
>     Suppressed 4 warnings (4 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     4 warnings generated.
>     Suppressed 4 warnings (4 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     5 warnings generated.
>     Suppressed 5 warnings (5 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     4 warnings generated.
>     Suppressed 4 warnings (4 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     3 warnings generated.
>     Suppressed 3 warnings (3 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     9 warnings generated.
>     Suppressed 9 warnings (8 in non-user code, 1 with check filters).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     5 warnings generated.
>     Suppressed 5 warnings (5 in non-user code).
>     Use -header-filter=3D.* to display errors from all non-system headers=
.
> Use -system-headers to display errors from system headers as well.
>     6 warnings generated.
> >> drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is garbage
> >> or undefined [clang-analyzer-core.uninitialized.Assign]
>             channel->target_cpu =3D target_cpu;
>                                 ^

The for-loop before the assignment is always executed,=20
because ncpu =3D num_online_cpus() > 0:
	for (i =3D 1; i <=3D ncpu + 1; i++) {

So the variable is assigned before Line 785:
		target_cpu =3D cpumask_first(available_mask);

And, the following code ensures the available_mask is not empty:
		if (cpumask_weight(alloced_mask) =3D=3D
		    cpumask_weight(cpumask_of_node(numa_node))) {
			/*
			 * We have cycled through all the CPUs in the node;
			 * reset the alloced map.
			 */
			cpumask_clear(alloced_mask);
		}

So the robot warning above can be ignored.

Thanks,
- Haiyang

