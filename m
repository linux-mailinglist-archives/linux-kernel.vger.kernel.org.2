Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6734342C314
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhJMO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:28:33 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:58720
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233857AbhJMO2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:28:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6l3I9NbH+TKfCe6wlehWZ16+hZpbGXIyn9tQyAI96EpJLC5xD8uf9f1/x7CUbZ0I+QwvTFqBVa0me6tUgumIr//CidItV5pMHojSOqRpoZSbCojk3KqQiaA3yXAdwDEjoJpQKK/yl5tRHXDsilTPeQ7x+X7r2MOVStxaXB2PVsE5E5dl5CKJi570TxJEiT/GJmyGOq9cPT50VFHb+qI29JWhfSq5UEcYv1hWOcwgazEtdraWAi/PXmFlhDvcydlwYV6SYtgVz0uuCFyqMKBL+dlCmHBQ8jN7LaVq8Db+DZ/vtzw1JH7RcYwYBKdpWlh2DzyNoTb0WEdJbrL7/ELCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lja+jM+f8S1PN4RF1DOGmDS6H8NZg9K/BJ3h1u/Djg=;
 b=nag6Wqktfcs4FsyFOeILFX8E7ZEuUK96acBIuQfD86Usi/ywn/yqExKjDj+jloHIiRJN2zbfHX0AcAkwEQdL0ZGE7zgbV3M9JGHkcrPhCzadejEhrnF4L04paVyrf1rNq+0WEcGp4IkoCUJn8R0rsNsFvX1hxbP7hdf+sToLU42iyMKr4bsZJNctiXA0I/FsgThvx0/alSStWIyRcXDcIpIQD5KlwBF0RnufOby14yQa9s2eOoLVjF6ctTWA1ycOF6ZrSjlxTDQygVHHpMJCNW6IdOZKJOK+/zNORHnX28D8IhkOqn4E0w6nvvs9xWwzxw/A20Zr0Dr238XVRSTrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lja+jM+f8S1PN4RF1DOGmDS6H8NZg9K/BJ3h1u/Djg=;
 b=psjQ4+J7HbT9dIKwPlrxaoMefN0MReNmD4YUWtyR3Ih+p97UzsSK9PE3gopslaV4Xx12UpWsQk6j2MqmxKQGkGO0Om7fHB8X0sF42wqBzTiZp0xFIDivmHSNZjSANvgqdgFBo72oH8ZfxnSZIDplFa67RHImTSjrfV9DV4iMdEM=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SN6PR02MB4048.namprd02.prod.outlook.com (2603:10b6:805:2c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 14:26:25 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23%7]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 14:26:25 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 0/6] Add Xilinx Event Management Driver
Thread-Topic: [PATCH v4 0/6] Add Xilinx Event Management Driver
Thread-Index: AQHXqjPsj2n6NIOYSUC8o2qDqfgxnKvRBXFQgAAKboCAAAG/AIAADkYwgAAD9YCAAAIsMIAAAYSA
Date:   Wed, 13 Oct 2021 14:26:25 +0000
Message-ID: <SA1PR02MB85924628E9E361C219A21E8AA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
 <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com> <YWbZoPHDzc4e5Nme@kroah.com>
 <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbo660XPKlwDZH0@kroah.com>
 <SA1PR02MB8592EB312091543A1D564D70A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
In-Reply-To: <SA1PR02MB8592EB312091543A1D564D70A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bd756fc-5999-42d3-bd7c-08d98e557025
x-ms-traffictypediagnostic: SN6PR02MB4048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB40483D192BD2A3778D9A0959A1B79@SN6PR02MB4048.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wjflcUcxnqjqLZZBlgDhEHvnq0qYrW8xtWaTy42TdbQkTOQaoYt87CXgDb/6imkWGMNyMo7G36o3eXbSRB1KUDwwl0T3Vht1AiBvFGcEYqk2C2Qb7eLWKyhyFnHBIK5DELmUFmAakOPhUMXZn3firzpBJ6cC0HE2v2XvKSfEGI0I8xGvWrbyyVKU+q/P6N+ZvPQGl01TzhxW4pEeeOqytOa8LFzL37sNTJ8u0VqaqqliTe1nQYSiACPupUt951DswsGgv8WfMPATrJzoCnBe7H3j8cORSHVYzb3e2csw0XvksnQdloKIDw26C0mqyPr0WIMOihsLFDy5OKHGEJsuK4/RY7USE3wnVMUnZk5P6cnSwxBVzHK2tJdGHOn2zSNLzcqdAbw2zgedFpR5TlDhVCewJUhTi4XtZtgw6A8WzHBuSnRsbiiyGSk7itw4hnVruATs2iSuv8NIS32o0IzBuUX7c94WZBJhTWeXPK6azkaDnqvmbnL9BlKzMuv5D/88QhF1bRE11XRyij1sdGMlq4BG59ALADyLS+0OIt1GccjKBN7/Cru2UV1dYkSPq8EXZd4v42rlAhbzZaw5vO5fQbX7dPPdXV93fjEwzjeM9RKcyZpfxEvJY44p2fT3jFq0zrTyShGqyCZx98BWRGpQL1RdpZ8TqGmN4BsfTn4CVp3ri0PzwPaMEXs7l+LJ+FTJsdDWn1/WZby3atyJmwp99Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(2940100002)(38100700002)(4326008)(6916009)(7696005)(38070700005)(52536014)(316002)(26005)(66946007)(66476007)(54906003)(66446008)(64756008)(66556008)(122000001)(76116006)(2906002)(8676002)(186003)(83380400001)(9686003)(5660300002)(8936002)(33656002)(508600001)(6506007)(71200400001)(53546011)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1urlYHOhUc8XeV/5tRkrmZ9R9e7x1V0sR0Ey9DXqYuUdNgTz65srjY3m/s6J?=
 =?us-ascii?Q?X3mA6R+wooVNJTA9YJ5KZPqCRAvvJWu8rTLF5x3oESmY9LDwtzq5MjW9IXRI?=
 =?us-ascii?Q?4FZb0897P+XH7mVs/1/HXyH56h3Zu2opCELTCym8x/ADEyP+57i/E0+i2Ros?=
 =?us-ascii?Q?6fkxKSTaIg/JPLyGuRv7SBpSMxnUa5lz1QcAI/6TI8l6Rg1rYFNySu0wwLfJ?=
 =?us-ascii?Q?bTruFXnQhLp7GqfIcP0luCRVVA8fbcJBMLutZyvgP4muOr1GeKs3qE/6XyZr?=
 =?us-ascii?Q?kIysMb8g2HzxtPULnxXmdxJe5nlxAAqKTJlc1mV/w2JB0fxg66nFN2JdFM6T?=
 =?us-ascii?Q?HzMrjWlX+ls8IALeF4INgIlpgllc02Dq2LljYNND2rOxDMefuRu2yYEunTLz?=
 =?us-ascii?Q?ge5ET2iElJE6l3vn1DuLLkWzwVIACLPTOaIu7B3eaDrMPKqbzaXC1TXxkYly?=
 =?us-ascii?Q?qwvY0ajE+GRNaBcnJ1ghXfak9m2l8lMdWqGeuzLp9v7UU8rUFOdAUl0Xwe7+?=
 =?us-ascii?Q?9JoNxA4xMQwvHgBUhvWgM2nzACF8/CLPzt6rnpJbFtgkw7w7lWBKMXtOKSjA?=
 =?us-ascii?Q?c579zZdIQCoRB9yJoYsZRkwUKPLqYEdZl20xh3qx/C32jvHe3UVfgTcv2kbC?=
 =?us-ascii?Q?3+ROCPpqGBJzwKS7bD07KdGdCmmhQjQ4ffd3fipx16XpMzMprmapdYrv/dou?=
 =?us-ascii?Q?+coqhEYiXhxQ7FovnhN4Etc9TV69OAdtX2kS7VUs2plgwFOg2Dotmnm4Pyz/?=
 =?us-ascii?Q?+0vsFS169ZVe+r7+IJdgX0hSqvhulvabs0E8ekrmh/ZQ7KKudKjTQmgMRSyA?=
 =?us-ascii?Q?DtriO5V9AM6tXDCtQsWoLgLW01clQfO9VSW2Dg9jtIOWN16uA8BVW7NJkIJd?=
 =?us-ascii?Q?EqfdpHUfiDz5acDmWTXyKH0jSAhHczF8AXRYo/zTcQQt9XVRNR863cmSXqob?=
 =?us-ascii?Q?0W6S/jHVIb7lBIDKgKpkIM8VmsYfRBedIzmEN0KF45yRUDTZ5gxh1o0X9gsk?=
 =?us-ascii?Q?Y5hlatmTiVCHErbSt0FB83+ub9L0YPzAK4MNA18HJDasOPGBsQ8tBvfqzEA2?=
 =?us-ascii?Q?f6z/DxNBObPV96NCZp6MjhfvJhna/L1+M/ZQdkqM6AD+2lobax0ZwiagMxUN?=
 =?us-ascii?Q?Zap5EyP9mFxuJ2KEH/SAlUEPkm3lxV7s2HStclDn8ZugfKE2JmV45jcT0cp4?=
 =?us-ascii?Q?Mx3WHqXueddTOalOO1dKNq1lnYNF5v9HLmlrr0V3l9mZ9+4TaeKcXIKN3pa6?=
 =?us-ascii?Q?hRe3hImqjnISkd9Z2wcTex1IoeVv5Hg1/QemIuUBrPchFv2RHUCeOCrs93sZ?=
 =?us-ascii?Q?k9fNoes15eWjN5WyUvQoRlVr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd756fc-5999-42d3-bd7c-08d98e557025
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 14:26:25.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EoiDwX8cilAq/jGVK0uqybCjrEzIcFyf9WjiIohT5kpoRo/1ro/r7aqb68QyVDscEHiB8ia++iP+VJw0rasqEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Replaying inline,

> -----Original Message-----
> From: Abhyuday Godhasara
> Sent: Wednesday, October 13, 2021 7:51 PM
> To: gregkh@linuxfoundation.org
> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH v4 0/6] Add Xilinx Event Management Driver
>=20
> Hi Greg,
>=20
>=20
> Thanks,
> Abhyuday
>=20
> > -----Original Message-----
> > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > Sent: Wednesday, October 13, 2021 7:41 PM
> > To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> > Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > linux- kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> >
> > On Wed, Oct 13, 2021 at 01:57:59PM +0000, Abhyuday Godhasara wrote:
> > > Hi Greg,
> > >
> > > > -----Original Message-----
> > > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > > Sent: Wednesday, October 13, 2021 6:36 PM
> > > > To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > > > Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
> > > > <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > > > zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>;
> > > > Jiaying Liang <jliang@xilinx.com>; linux- kernel@vger.kernel.org;
> > > > linux-arm-kernel@lists.infradead.org
> > > > Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > >
> > > > On Wed, Oct 13, 2021 at 02:59:21PM +0200,
> > > > gregkh@linuxfoundation.org
> > > > wrote:
> > > > > On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara
> wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > > > > > Sent: Wednesday, September 15, 2021 6:46 PM
> > > > > > > To: gregkh@linuxfoundation.org
> > > > > > > Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > > > > > > <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> > > > > > > Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai
> > > > > > > Krishna Potthuri <lakshmis@xilinx.com>; Jiaying Liang
> > > > > > > <jliang@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > > > > > > linux-kernel@vger.kernel.org;
> > > > > > > linux-arm- kernel@lists.infradead.org
> > > > > > > Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > > > > >
> > > > > > > This Linux driver provides support to subscribe error/event
> > > > > > > notification and receive notification from firmware for
> > > > > > > error/event and forward event notification to subscribed
> > > > > > > driver via
> > > > registered callback.
> > > > > > >
> > > > > > > All types of events like power and error will be handled
> > > > > > > from single place as part of event management driver.
> > > > > > >
> > > > > > > Changes in v4:
> > > > > > > - Rebase on latest tree
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Update the commit message.
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Removed updated copyright year from unchanged files.
> > > > > > > - make sgi_num as module parameter for event management drive=
r.
> > > > > > > - Use same object for error detection and printing.
> > > > > > >
> > > > > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > > > > [Abhyuday] Michal suggested to merge this via your tree.
> > > > > > Please have a
> > > > look.
> > > > > > Please let me know if there is anything required from my side.
> > > > >
> > > > > Ok, I'll pick it up, thanks.
> > > >
> > > > Nope, I can not as for some reason it all did not show up on
> lore.kernel.org.
> > > >
> > > > Please resend this, with Michal's ack and I will be glad to pick it=
 up.
> > > [Abhyuday] Sent v5 with Michal's ack.
> >
> > Sent where?  Do you have a lore.kernel.org link?  Did you cc: me?
>=20
[Abhyuday] I added linux-kernel@vger.kernel.org and linux-arm-kernel@lists.=
infradead.org in CC. also added you in "To" for v5.
Please let me know if require anything else.

Thanks,
Abhyuday

>=20
> >
> > thanks,
> >
> > greg k-h
