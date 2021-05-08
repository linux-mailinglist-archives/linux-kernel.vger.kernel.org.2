Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E92377168
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 13:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhEHLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 07:23:47 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:36896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230234AbhEHLXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 07:23:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeOD+0Ij8HzrScElGEXqjU5lsQnl33+Ip+a7/lDwyHK9jAQRDL4uUI/bPEeFIMVar1q76Z4rscD47tqZVqAgn90N19sAvqksRATLTkIqUdvcSnYb7DATuD66mJTCIP0SPtgNq96ts6eKAwXaknSN/hH/c9XQjnUPAKJtAqv4xurFx3uIaAQpUNYasZTlgTUeFXiTitCJmaPUqidKZyKlcKeIAi9/hQt6MUSdSpi5V3o1biBSqAEa68Rq+SYKCtwWaS6XuZehAX11F4kxr0t8cMMSiqXu6AfqhfDqbCk1LfaI4x4VLkPwdCYNYkkBR0cQ8Y1tAPhxAYGTWBaYJ1HWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ooCUj3ZAR8cZ48Xy94q+clt1Ia4IqpqbGNJ82WrcI=;
 b=YVZXoByJjKc48EFPpcOyaKd5KiGLBSDMta29hc8IKx48BzHM8HX0zpC1QYL6eFoVqYCIxJVrsi4ciF6EghgzJPI1xcu3OTgw6m8bCRcoHddkYgEWBt83KDRvw5pTf3VFxs318yqah8gWrnwDX+Ys2r7hKnaFFPfe4oziEvFXm2NfnZ4tAV3hzyJlV2ifN11YWyJRtg4p5+6e654t4M+SriyJb0yWaaU3fkZO5TWEiDOshPJhjDpXUomIAKNRAQzljk0QLwzaiwSV4S40fwhV16TL4asJijZFBeQUp5oIgjVfMaCqwF1P4b2Z35/u6Cmrd1qpkTUYcXKqIiTAQDx7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ooCUj3ZAR8cZ48Xy94q+clt1Ia4IqpqbGNJ82WrcI=;
 b=g1f876EmWJLRJac70s2POnW7TRalMCqvX2SqIUnD59dG8HJMvW7WaRRg4BlTWbGlwdurJ47TqZrnX2nQrGHClKppEbBHatIyeT56xvye7da+S/3SgwllhMhUwLksr0Ai/we+YKO5GQStV5ML0PoTUlVli6Y/eEvZiUaDxI+agqOgI8W6zsfHoypmRuLQicANyyRB/bq9/aA13sBvL2DjdCfu/453bVuQMd6cyq8V/e2UYhQrMMTVMQZhfRHTXHypcToL4Hscp+0NxDaYHbrh+n4D0lEJQ6Ff0oLHXwmQuN+mN5od0diV7AQaY9wqLamIKM2v/30dVdZ3k5aQyGwfCA==
Received: from DM6PR12MB3898.namprd12.prod.outlook.com (2603:10b6:5:1c6::18)
 by DM5PR12MB2536.namprd12.prod.outlook.com (2603:10b6:4:b3::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Sat, 8 May
 2021 11:22:43 +0000
Received: from DM6PR12MB3898.namprd12.prod.outlook.com
 ([fe80::dce6:427d:df17:3974]) by DM6PR12MB3898.namprd12.prod.outlook.com
 ([fe80::dce6:427d:df17:3974%5]) with mapi id 15.20.4108.029; Sat, 8 May 2021
 11:22:43 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Liming Sun <limings@nvidia.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v2] platform/mellanox: mlxbf-tmfifo: Fix a memory barrier
 issue
Thread-Topic: [PATCH v2] platform/mellanox: mlxbf-tmfifo: Fix a memory barrier
 issue
Thread-Index: AQHXQ6FYEXJKkcU5D0+EAyr87e3wUKrZcIGQ
Date:   Sat, 8 May 2021 11:22:43 +0000
Message-ID: <DM6PR12MB3898873FD11A71E9D30032BFAF569@DM6PR12MB3898.namprd12.prod.outlook.com>
References: <177d12443460bc613aa495fbdbabbbeef43ba7ff.1620400475.git.limings@nvidia.com>
 <1620433812-17911-1-git-send-email-limings@nvidia.com>
In-Reply-To: <1620433812-17911-1-git-send-email-limings@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [46.117.116.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 584ba631-215d-4998-76ef-08d912139976
x-ms-traffictypediagnostic: DM5PR12MB2536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2536945A44FAC87935C92638AF569@DM5PR12MB2536.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nqKP7SUHwt4B1Sixr7eWSSBJ/QnwgJNfWIiuKpJ8KYUBFucesvGiiwkcEb14qcschxoTae5cztEuCEjjLHstH9TofItDJZS+bG6x2rahjyHGdW5QU2JiMrNYs4qmHrWfcBObcQ4OaZO2G0QJqD3sqcsZ9MSRxZvDCcOhjZfljK1H9IUB49PN1+oi5UXHoLsgdAxX5z4AwZpmjGzerspi6Gk4sav5HQqyhtELstKV22ypeR/8ReQx5kcWNVJTsC9J13IBev9inFp8zs4/b2eLvWEYX/BeM3vZr9xF6ZBbZ/egPnumYwvbJ34l3BFKKy/RzuALF9TFl50cGQqp98WcOLvqdLKdFpaWHJRT101fHmfkhVyASDYCQly+3JHx/nvIJaK8VTYAmRvLXrzGE3aaB1vameby7vbhnr3XNEi8Bas9x7CDKUPCxBkYgDHUOExQAFCs9lt7NzJ+LE/0bpEoxcRpvh9/heBeiAYfhuWTlzSEb9m+Kd+1lQHOiW9QiuUyUvL+iph2BKv5tnakVsq9j5l09s6DDgbunSQoBAqxRjLNMTbYOvZpxfNFJj2+LHOne0nAVb/uFVRG7Z8BYy/4Jyu/PBYP+JMyYY07i3h4ikI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(54906003)(110136005)(26005)(316002)(71200400001)(186003)(76116006)(7696005)(53546011)(66556008)(6506007)(8676002)(86362001)(478600001)(64756008)(66446008)(38100700002)(122000001)(8936002)(66946007)(66476007)(52536014)(2906002)(33656002)(4326008)(9686003)(5660300002)(55016002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pSiCpxaKS3JFRW8ztneUPIFx2xrXC+9/R7BW5LcjiBGJ8mQ3tNEdUXfXWm5P?=
 =?us-ascii?Q?Mr7DiXN9OWnc/j1OXNT8K6T0KjcgOeGxqXGWgEErG1HaUYWltKl8/vK40RuI?=
 =?us-ascii?Q?zMlvFKAlI2R/N5K63uCbX+6vXoTk9Qtrw1WPra6raLq40ySYy0pc3PaFJzhs?=
 =?us-ascii?Q?AAP/HMeim6b2CsjOKKtQ+mGtzYTCU5C6n1IBydLGZPdvvtnH7zwZ4yHHIkxt?=
 =?us-ascii?Q?W85kSzxInjhKHttJF4vfoVDHHx80kvPXKXuea2G1jLZhCOPJxaEdwNK7mPqt?=
 =?us-ascii?Q?tpG+wzrZ3fqjLxA159Yio+0pwdQq+NgZdKmpuKFsjRRVcyC0eeIf2ikP1sdu?=
 =?us-ascii?Q?RTcTv3UfWLMfrs3nzFIUEHvrNsIJ3+a80vQ2yT12jQvA5iup1vAeN8vAZSgh?=
 =?us-ascii?Q?byC1nkoiAiLQrC7HdyfDvVqhc3kRZKMzRQLbbkjVbNePpfcWbEeoOJisechJ?=
 =?us-ascii?Q?G6h+kiaoY7zKqoZapwUIAuj4xcOtOrQCrW1jtwxErQUDuuQNyEci6hUNENbW?=
 =?us-ascii?Q?9W9RYajfOFY+Ol/4LSbvDZVaSei8Nr0BuTKLRbXBkmSqDSOk3FaO2JAjn6Ze?=
 =?us-ascii?Q?i23dppRXeemMkrYuHpg+8gMzkCJjkg24lluaRfc8shEpYMtwGolZMMfWTE/4?=
 =?us-ascii?Q?o/vNiTo9U+GrIh4ng1XhuS5t6K407KPM6Sk028k4TJt+W0Rp+ToX7MtGV3k/?=
 =?us-ascii?Q?kcg+QIrPYEZ/Hvstr/cEVF7P6ANwrcWW7XycJvMoftdSHSetZT15FOH5M5yQ?=
 =?us-ascii?Q?/A68nlGCRRsd0L8RC/Z+rds2Av0XdPjNLM+MP3Pkt+rkZLz937OhcHOViRHV?=
 =?us-ascii?Q?PMDFHn/RxKK/l/UMiNIka+pd1SOjxu6BHHrtd6uocH70pN+mAdvMgaYDu95v?=
 =?us-ascii?Q?CVmyiB1PinPxB43nYScWzEc+FRt374o2Dtp/WCseJSPzMEeZyYmz4Z6jBTT7?=
 =?us-ascii?Q?C4kUHmQ3yEMRpI8Axytq/OI5R2iV6Bn45rqJ+pQhwhQK8pX32H+l1j2tYbeS?=
 =?us-ascii?Q?Sg3MV0Js57aPnmpSKfC/7XlizTz5nT6CPfLxxu+Ct9sIlWakjbor4VAwVJ49?=
 =?us-ascii?Q?tQvi1Qqe6UDJnHhoXTpr24uJ95NPXl3XwnC/w8TbGUcNY2KIF3n6oJd3DBgN?=
 =?us-ascii?Q?qbMl8mVvQ6qWQolgEpC2jY63pkQ0EM8SuXFNufDldXOjIBr93v27FZLXg9Vh?=
 =?us-ascii?Q?1+FX5Vp0nfTQzShdOIGSGVY3qbrE9s96NrmTfVZuMEhYhMHu+pdCn+teinbP?=
 =?us-ascii?Q?RpCqW4QZrkEQGghPLJwPIRVyuidL/auGdFkofPW+YiJ/CUKwzWVYAsSBnudn?=
 =?us-ascii?Q?t2QrGOIdcaYA3MIGqLRml2Ia?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584ba631-215d-4998-76ef-08d912139976
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 11:22:43.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4COXynrZ2wcuS2XX4kYL8uV/cS7y0BRbNW8T7+WxUONYVFNrUBTZNk2FsjdByCC6YkqyIaLnq0BWX72m+NbFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Liming Sun <limings@nvidia.com>
> Sent: Saturday, May 8, 2021 3:30 AM
> To: Andy Shevchenko <andy@infradead.org>; Darren Hart
> <dvhart@infradead.org>; Vadim Pasternak <vadimp@nvidia.com>
> Cc: Liming Sun <limings@nvidia.com>; linux-kernel@vger.kernel.org;
> platform-driver-x86@vger.kernel.org
> Subject: [PATCH v2] platform/mellanox: mlxbf-tmfifo: Fix a memory barrier
> issue
>=20
> The virtio framework uses wmb() when updating avail->idx. It guarantees
> the write order, but not necessarily loading order for the code accessing=
 the
> memory. This commit adds a load barrier after reading the avail->idx to m=
ake
> sure all the data in the descriptor is visible. It also adds a barrier wh=
en
> returning the packet to virtio framework to make sure read/writes are vis=
ible
> to the virtio code.
>=20
> Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox
> BlueField Soc")
> Signed-off-by: Liming Sun <limings@nvidia.com>

Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>

Liming,
Please, next time send patch to upstream after getting official approval fr=
om
our internal review.
In this case notes v1 -> v2 and version"v2" will be useless.

Thanks,
Vadim.

> ---
> v1->v2:
>   Updates for Vadim's comments:
>   - Add the 'Fixes' field in the commit message.
> v1: Initial version
> ---
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c
> b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index bbc4e71..38800e8 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -294,6 +294,9 @@ static irqreturn_t mlxbf_tmfifo_irq_handler(int irq,
> void *arg)
>  	if (vring->next_avail =3D=3D virtio16_to_cpu(vdev, vr->avail->idx))
>  		return NULL;
>=20
> +	/* Make sure 'avail->idx' is visible already. */
> +	virtio_rmb(false);
> +
>  	idx =3D vring->next_avail % vr->num;
>  	head =3D virtio16_to_cpu(vdev, vr->avail->ring[idx]);
>  	if (WARN_ON(head >=3D vr->num))
> @@ -322,7 +325,7 @@ static void mlxbf_tmfifo_release_desc(struct
> mlxbf_tmfifo_vring *vring,
>  	 * done or not. Add a memory barrier here to make sure the update
> above
>  	 * completes before updating the idx.
>  	 */
> -	mb();
> +	virtio_mb(false);
>  	vr->used->idx =3D cpu_to_virtio16(vdev, vr_idx + 1);  }
>=20
> @@ -733,6 +736,12 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct
> mlxbf_tmfifo_vring *vring,
>  		desc =3D NULL;
>  		fifo->vring[is_rx] =3D NULL;
>=20
> +		/*
> +		 * Make sure the load/store are in order before
> +		 * returning back to virtio.
> +		 */
> +		virtio_mb(false);
> +
>  		/* Notify upper layer that packet is done. */
>  		spin_lock_irqsave(&fifo->spin_lock[is_rx], flags);
>  		vring_interrupt(0, vring->vq);
> --
> 1.8.3.1

