Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14167376DA1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhEHAP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 20:15:56 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:3232
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229978AbhEHAP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 20:15:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO7Eb+KT26YXg8mNC8ElL14i7zJ8hCk60iqz4vWHN6Rrs2Eb+Zna24CF8v3ZqxvgsCf5FyHBKBtp45Yqd1sz4v+dUm2DVsJxdwllWbAFqoDdIevvKmw/7WK6BcrGmCC6w48zHE5qsWMMQYtS4HH9LEdXCq11CAqQovZogGwDFcFuu6H5ht6YVkNOnLYmd8g5Ju+99KoAGJ6Vmd1pJPnot1/HL3DS22bqE6PRG9FOhYZcIi33gVrKmEbBBA7EO9IaFDiTqE6hWQth/kTSuT5GTBZQnonCYRtY1c8uLcuHjqJmhr89HTssV0UIdlmuXsPWbaYPSV7sWFqYsc2hPa9/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr0u/enkvA8BN3YZV/TqopTo1YTU73VKV/MH55y6dqg=;
 b=O594N6V4Zwtu6cpfCjFkmh24B6XnyLUJgu3Ht6eTt5CZ7ClwLVjADTB3u6nMDQIAFxdZPxo9dAC2+Z0Hkz3scVMLHk7iH2prYcSVxlfEe7OtRg5S/YwA7UP1XwbVStoLdVpKtBmFu3TnQHpPVxGKrJL116BF7qO9khcDGIkcNlZ078v5xG7xCBn+7x0MV37r/UTQfqO+JLi9id0togZMwroXrB77oXmGR9LghbG5qqod/y5ZOZFfC4p4i8YsKzCDjYrwlGtSqpZrvCrzUC9hRPQ6DHboOiM2qGDFOrWu3TNjz9dNl6/NCAfm+XqZyyqoZvWuz4aqEj7aGLUpWZmQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr0u/enkvA8BN3YZV/TqopTo1YTU73VKV/MH55y6dqg=;
 b=Bzy+cK6XxqQTo1FkAdNygpOyHKOLlGIzVWAuQQCDtXtmpzGmWgcirap6kUHAjaNNAAUKGSW1wA3NhSt9csTT9atTtunLUvubx+OeMk5KsjZMxGBWYkyyvndR1+pcQR2dt3lrNUnMWIADv1nbTdNCO6Gx6DOLGeK1cABsJLUG3rOOoVJ3rjv/C37bZIhPujiHKIZsnbrRPJIk28Aux7T7plWE/fhK3aK0DEKMG5tmMI+wUlWgAt0RgD4Qhdp/WLXDpFVmNUEPBStRrG1e7UAVh0lQmum7buRCCUtiEJl6WmX+z863VHLrc7VLcjP7OFLN6PPHpK95S3o3HKZfFnjC4A==
Received: from MN2PR12MB3565.namprd12.prod.outlook.com (2603:10b6:208:c2::24)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Sat, 8 May
 2021 00:14:52 +0000
Received: from MN2PR12MB3565.namprd12.prod.outlook.com
 ([fe80::c52b:46f4:9962:3d53]) by MN2PR12MB3565.namprd12.prod.outlook.com
 ([fe80::c52b:46f4:9962:3d53%5]) with mapi id 15.20.4108.027; Sat, 8 May 2021
 00:14:52 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a memory
 barrier issue
Thread-Topic: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a memory
 barrier issue
Thread-Index: AQHXQ1Rd0aNDff8xpE27c3mU/0BwmarYJ3aAgACQCEA=
Date:   Sat, 8 May 2021 00:14:52 +0000
Message-ID: <MN2PR12MB3565DB8F08395AA14226AF9CD3569@MN2PR12MB3565.namprd12.prod.outlook.com>
References: <177d12443460bc613aa495fbdbabbbeef43ba7ff.1620400475.git.limings@nvidia.com>
 <DM6PR12MB389868EDF9F7B1607E6E1BF0AF579@DM6PR12MB3898.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB389868EDF9F7B1607E6E1BF0AF579@DM6PR12MB3898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [173.76.169.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f780dff9-30a5-4c1d-4cfe-08d911b64d28
x-ms-traffictypediagnostic: BL0PR12MB4881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4881A7A3AFDE8CB1ADCCEF8AD3569@BL0PR12MB4881.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbP/0dXKUTNHOjzDe6Cq9pPPnPl9vstLHH8vjTzzyXNarjDL2JzYqVniHiC2T1q92G+friSFsGXyYb//p0zxMreUVjb9VYmGTPL2YtzdpehXj6DlvDUP6Nc85DAJz13Un1GFWGv4Xtmhv4TLjXqzA4HTPJbbxcEBKtVELIMplPrmzd3fAtbU22eyw46IkxV99/HGN+h3p+FPe2/xacPrZju+FHvUfVl2EhvRAXhF489pxWkoGALnS4Ao5uQ4spAL4hqDc5aV1xS8zVY43uqp0EkHWzfKWz+Y10noyIw57KoRm+wSLeA3GV5kuB07Kr0pahVUhJdGDKlC/DMel5EZFxYeC9e1HXdrO3amcKoPjQYA17pKjwbaJUgyQllFHbDfLi2vkQMfUL3Lb/hPxL3qdp1XZH/imXUuvweqr1jyWAyVjaHk0N4y92HQCQT7GJnX8j/JEoQHzqUBkb2i6ePoaVqVRYbz5cO47xWAMDf3lE51rGsjIi36hdQKcKjX0F/i6NZWvO7YSm/OiZkBuNftocdpoOP4vSR8zCEl0LnPbsCI+DryCLHGV7ABBzbgMTb3JP9+FAUov9M/HxikTxVZ0GopnOVm/67f+JUgle6syyA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(9686003)(38100700002)(186003)(8676002)(4326008)(53546011)(76116006)(316002)(110136005)(8936002)(83380400001)(6506007)(54906003)(478600001)(66946007)(55016002)(5660300002)(64756008)(66476007)(66446008)(66556008)(7696005)(71200400001)(86362001)(33656002)(2906002)(26005)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gngJ1UWd9PyvNAIxx3dOOVB9IaboUuKf5IVLPj8xP6srjEs3YBslscYNcdwV?=
 =?us-ascii?Q?UTWfSBZTickEOzIhPEglKkQZYntxKl1E1SYQoSNPmLbsSR/9aFjLlkCqYr6F?=
 =?us-ascii?Q?YzKef61zCcdMUXaTiQOdZvRYmPcAn3JxZeofYK2K7ghS+av/cuSQakTjKhzP?=
 =?us-ascii?Q?MpaE4lEo4H0bqHyoJxF/D6rLCO+83Dx8vcmFFpk38HvjT1qh4NzbMLsDPSwY?=
 =?us-ascii?Q?mhJ+U4btNiH84sH89QysVHZvBvoqmC7Xn3Ypt2Tjk1Y6EVGREgYBkXKYY4B+?=
 =?us-ascii?Q?kcnpjUDJS/rs1ADuCO0rrqn2rJOnsvVRs10DQhMTzt4pwv/LIpYQuU0a59uv?=
 =?us-ascii?Q?kpe4d5HKfXKYIEx/FK95n26cin293R5esVeNe500ZT8FJoSPE8V8kt3q9jea?=
 =?us-ascii?Q?9yRU0QCYj8L0qF34Wa6GtrfcQvqssPbw2JkRdNXNuZP+gge9mM98MUz2q5S0?=
 =?us-ascii?Q?bJX79EJp4dBRC1UWFxuv5gjts01UiGh7oDVpGt/6UnAZ8Wv966op8rUT/7HO?=
 =?us-ascii?Q?kNAFigWO7lc8TeUSebLei1752IpagrQLa0krSW7/Vgemap0FC1vSVYf6/qQb?=
 =?us-ascii?Q?WmEMawBAwXi1lPyddPTZIRqxAOCXE7Csx1DWUgr4ikYcXQbq+lksLE2DPL4+?=
 =?us-ascii?Q?uBwFdVbbCUnKZlatsMFZfXrEkS25xol8ywirGf3M6muZryWFrk4OA0KP0H17?=
 =?us-ascii?Q?84ePBkdiyvbZL9Apz7ZwD5SgucfXy3qHA7V7L3B0Eh3UL+ZxhcwQ74WXubM4?=
 =?us-ascii?Q?f9H96NHKMQHmCFVhL1YSfEtgbNOCiyONZdN+NlninHutCTC4+207TU2wBb6d?=
 =?us-ascii?Q?Rnp3mEkN6S2GwuylAuKKSnHFsbNuxd4rJ0+35vGrU63GtA2zPZZgl/3TbQNL?=
 =?us-ascii?Q?qWnALZfuJXHWgGjID0yWOARqvZHp3KaOc22nJSGgVOAFCIam300T3rsgibMx?=
 =?us-ascii?Q?zfYi6zpxSojJVLMPocvCBc2aQOS4JsINx+Wuy/bEEl4jMyMw3uvjJ1LJez2r?=
 =?us-ascii?Q?oY2EzBrDhYe2OUs/pVHczD8DkIVEIhfLGV5T7WIQHGcT0YbVmahoT+v+ypZb?=
 =?us-ascii?Q?e5W37bwznW+eVF32zxwP0G70oi9cjG5irnD/HVnSx38lyly8Qd53/PUWB23+?=
 =?us-ascii?Q?BO8CED+Lhbl0SWlEEtG7zGztVecMTuHvcUszzb80LpQ+Part6UPsoDZEKGmn?=
 =?us-ascii?Q?PyuoER2vp2KA5ZHOakrhFbNyfR1wTWctkbawvPea9AA7GyahRCMSwPqKOnNH?=
 =?us-ascii?Q?ss6BbSch8qp5cFCapCMY7MDsETR+i9NaPpE9DxjNCQbaVIptF3Q76CYjH7Gg?=
 =?us-ascii?Q?Qu7pRRqnTT4OelmO7jw+goUo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f780dff9-30a5-4c1d-4cfe-08d911b64d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 00:14:52.4133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHbDwkc/r9a/SLn6LzF6vPmJtm1bsjnd43q/fR9hMS2fR3hi+JillTCKgH0RIIlWeL48d5CEuTrvGWVAW820DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!=20
Sure, I'll resent it as bugfix in v2.

> -----Original Message-----
> From: Vadim Pasternak <vadimp@nvidia.com>
> Sent: Friday, May 7, 2021 11:39 AM
> To: Liming Sun <limings@nvidia.com>; Andy Shevchenko
> <andy@infradead.org>; Darren Hart <dvhart@infradead.org>
> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
> Subject: RE: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a memory
> barrier issue
>=20
>=20
>=20
> > -----Original Message-----
> > From: Liming Sun <limings@nvidia.com>
> > Sent: Friday, May 7, 2021 6:19 PM
> > To: Andy Shevchenko <andy@infradead.org>; Darren Hart
> > <dvhart@infradead.org>; Vadim Pasternak <vadimp@nvidia.com>
> > Cc: Liming Sun <limings@nvidia.com>; linux-kernel@vger.kernel.org;
> > platform-driver-x86@vger.kernel.org
> > Subject: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a memory
> > barrier issue
> >
> > The virtio framework uses wmb() when updating avail->idx. It guarantees
> > the write order, but not necessarily loading order for the code accessi=
ng
> the
> > memory. This commit adds a load barrier after reading the avail->idx to
> make
> > sure all the data in the descriptor is visible. It also adds a barrier =
when
> > returning the packet to virtio framework to make sure read/writes are
> visible
> > to the virtio code.
>=20
> I suppose it should be sent as Bugfix?
>=20
> >
> > Signed-off-by: Liming Sun <limings@nvidia.com>
> > ---
> >  drivers/platform/mellanox/mlxbf-tmfifo.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c
> > b/drivers/platform/mellanox/mlxbf-tmfifo.c
> > index bbc4e71..38800e8 100644
> > --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> > +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> > @@ -294,6 +294,9 @@ static irqreturn_t mlxbf_tmfifo_irq_handler(int irq=
,
> > void *arg)
> >  	if (vring->next_avail =3D=3D virtio16_to_cpu(vdev, vr->avail->idx))
> >  		return NULL;
> >
> > +	/* Make sure 'avail->idx' is visible already. */
> > +	virtio_rmb(false);
> > +
> >  	idx =3D vring->next_avail % vr->num;
> >  	head =3D virtio16_to_cpu(vdev, vr->avail->ring[idx]);
> >  	if (WARN_ON(head >=3D vr->num))
> > @@ -322,7 +325,7 @@ static void mlxbf_tmfifo_release_desc(struct
> > mlxbf_tmfifo_vring *vring,
> >  	 * done or not. Add a memory barrier here to make sure the update
> > above
> >  	 * completes before updating the idx.
> >  	 */
> > -	mb();
> > +	virtio_mb(false);
> >  	vr->used->idx =3D cpu_to_virtio16(vdev, vr_idx + 1);  }
> >
> > @@ -733,6 +736,12 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct
> > mlxbf_tmfifo_vring *vring,
> >  		desc =3D NULL;
> >  		fifo->vring[is_rx] =3D NULL;
> >
> > +		/*
> > +		 * Make sure the load/store are in order before
> > +		 * returning back to virtio.
> > +		 */
> > +		virtio_mb(false);
> > +
> >  		/* Notify upper layer that packet is done. */
> >  		spin_lock_irqsave(&fifo->spin_lock[is_rx], flags);
> >  		vring_interrupt(0, vring->vq);
> > --
> > 1.8.3.1

