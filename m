Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB537682C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhEGPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:39:50 -0400
Received: from mail-dm3nam07on2062.outbound.protection.outlook.com ([40.107.95.62]:24801
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237951AbhEGPjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjOuDrrVxbo0xiAAcsFApyCJyvyzbUli8GqklWyK6dYahNFQxzaAmu6VizBaGV2r62zgP/S7UFPtCUkxyEmZH77X12BSqVMjVKXqRZ4D1Ych8DFqqrKH/FqpNrbguUzMe5U1aTyjwkX4XNUf471MWz+9XbFTE/1WDI8nFcYrQMtA1Wb5J3rx8OiT44pfDuZmd5MrMQ+khnA9iJk8vSE7OXIx3ntnfFsvgnNCk1W9HqdjI/oHshsQD+sT3Z1zT3cF7UfxZLPf7IXYzwnOTeTqvRVvbk5R1UaAVlv7mASUtAaqiMxKMMRL06MuiYhUY0mUUOlTNtGBvXwA5t1mGWhpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49fV9V4ii53To7kF+6pdv9N/QuOT/Z6gr0QLV5fVLSk=;
 b=m14rSTNLmfxReJG4sh9M3BSIOSSVAK7iT6UVF5i5JjZQAxilzLTNgKasJGGX69OLeCC48ZsAZ+fMsrKiKx/s/TJpMssTlFL/Rjdug99ufoEUy8et3WQ/Ij6mqowj4hnwaV0fOhxGs9zRuEhY7uQCiivbDpqoebrkSCh8gJgqmKFbvbq1fpGznE140DnmLvPmrbHTzif9XZpreKI5QVaIZO6DhxCADvjghYzKiPBkooyvyQZZL0KAr/eS+/kGzt75vnd6vkdObDPISPwTx/UkSOxaJ578u/BaghWx/QsfkPTI2lvMbfom1JSaNJLBU7GK7LHSHOHM2UL4mSPFkEcGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49fV9V4ii53To7kF+6pdv9N/QuOT/Z6gr0QLV5fVLSk=;
 b=uE3e4aTF1emtnwX+IlE07bNoXSIQWWSFFHVOiJ5ceBS6HSle1VLB+6haBLU0UTdeKssogbUqwkhZvaxv//opG8CKVOfrFEoPCnNmVomTa9dwBSdBrm5cA7qQX8wGLzNXJNIK4v0DOV7UoVpO7CrYVnC0z9xkKJ5k8CxzlGFHy8jPL1FKWpXISjyhSZ0GtMS8dWuDNZ+zP5msdqp57h41UcQ31vMryKWg6Gu2HvpAaZOY17sfamk3wiGj2hwyd4VQAzRhpNi2LTzuNToZ9wTP5vswh3nTX9uV8DVSCafUxM6HVHfAIqgkLJlWXy6WAtKNRXxJi9Fux3W8/JEslcqbSw==
Received: from DM6PR12MB3898.namprd12.prod.outlook.com (2603:10b6:5:1c6::18)
 by DM6PR12MB3290.namprd12.prod.outlook.com (2603:10b6:5:189::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Fri, 7 May
 2021 15:38:43 +0000
Received: from DM6PR12MB3898.namprd12.prod.outlook.com
 ([fe80::dce6:427d:df17:3974]) by DM6PR12MB3898.namprd12.prod.outlook.com
 ([fe80::dce6:427d:df17:3974%5]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 15:38:43 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Liming Sun <limings@nvidia.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a memory
 barrier issue
Thread-Topic: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a memory
 barrier issue
Thread-Index: AQHXQ1RdUjtajmzQJUmA3Sb603ZA9qrYJvVA
Date:   Fri, 7 May 2021 15:38:43 +0000
Message-ID: <DM6PR12MB389868EDF9F7B1607E6E1BF0AF579@DM6PR12MB3898.namprd12.prod.outlook.com>
References: <177d12443460bc613aa495fbdbabbbeef43ba7ff.1620400475.git.limings@nvidia.com>
In-Reply-To: <177d12443460bc613aa495fbdbabbbeef43ba7ff.1620400475.git.limings@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [46.117.116.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83b85837-2dd3-43e7-88fa-08d9116e31fa
x-ms-traffictypediagnostic: DM6PR12MB3290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32902F99ADC9B42CEBFDA6CEAF579@DM6PR12MB3290.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXBqkgy1/PXiDRNVEPCWVPe6eKOaddJBoba2WVKnE/3Bk4fJiX65MCs1afCbL02JnEq6WSuIVPyy0V0XKg4aoSx4Wdr3MVMvAU5CuhH6aJ/KUhydmEUtb76waZhySWUYQKz1zz0ChtxrPBfNQgphS/QpGeYR2jQZYvxFXY47gGwZPOt2N6M7bhgUn2Fd/yJH0tyBpReqbG50xYwPczDENO6Sl40wQl1d6zPnOGX3m6/wpzQhQPKZA69AEO1dfEysoJ0zGREfqq6u697OXeJZWYTW8UAuu+voN9GrzITeeN1TPO6XfS2F4z+6eS2AU7bOcZJMY7XLrBcjsNJnD8QkQVAC5YlMOGBEaaQEAAHrE9luJlGLMb8wKuOmrfxHdMWvPMtqy5d/9b+E74odvV5Rh+i9bLSLbx4I27Va4ynaUTFfA3oySjoeEpFBj++LXQ8AH1gx79/yDsFhcAoriEMIL5eRWLbkV+aL91HpIb0ZMjsF1inTlVK8jl9f1nB7+4uuoAWpr34KNm5DJQK3Oi2kzv9W4Dkl7Qmz1QOEsAgTNoR++1Zsd7MUypUi0Av/CIdnF06l3zA001/ocThIvD8OUXotCJeMMSnu1E1VMru6/qA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(33656002)(8676002)(71200400001)(316002)(83380400001)(66946007)(5660300002)(6506007)(53546011)(9686003)(4326008)(66446008)(8936002)(2906002)(26005)(55016002)(52536014)(478600001)(186003)(66556008)(86362001)(54906003)(38100700002)(66476007)(64756008)(7696005)(76116006)(110136005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/ET1p4dnSWx5iFgjUqQBjhA1itkVL2LHlaqOydhW8ni4SmBDI6e+kC+Tgjh1?=
 =?us-ascii?Q?d5Ww+PjjtJlyLOL2ZoSLTj0ViM6P/UxDMqqZrRf7s2Mhl0C4SKlV7RxOMJju?=
 =?us-ascii?Q?cuhVQnwU0wDmaIcIG0JO7ralVHZbPfB4FlE4XTmqOJKTWgZeesktTbwuHe//?=
 =?us-ascii?Q?OcS29FeEyb9IG1FRafTsnsadQAtX+Ky/QYn0PCRvwPrjVVSUPgw0L7gaYdaY?=
 =?us-ascii?Q?Ifvjspy0wZK0X0nshixn1lGccrFvtAxD5ZFfsTTRhQ6TxBZ31pl9ZRnLIXXu?=
 =?us-ascii?Q?83x+4lWkwplixDwudkdfm5rr0bBkXgA2HluEA3qLKDdAlIK2WePqqurdu0JF?=
 =?us-ascii?Q?JGgFj3zuVHcsSQhTCOduH3ercBePCrqth6SDMzB3qQdMLvLrId+RnZM8sA7W?=
 =?us-ascii?Q?Lvd7uUV4nZ6QdHZJVpZbMhY7b8QKDJT6eRtIDVY/IYIyIVKR62/zM4cer9id?=
 =?us-ascii?Q?VhGtNiGbL8BTg07yghJ4L0zjpwS/5z8W/hbnIKpHE3HuzpEJN0rn47dIYDIX?=
 =?us-ascii?Q?r7MufKeEkSwg3CgUoSdWnulAdKfi3bFCKtiaZBvSP+yHVEVKFLInv3pXlzwM?=
 =?us-ascii?Q?J43k5kSH883FGMc2oTMaBjiV/lKNuqnNKU0hi6mp1EAkkd3SfeZObhsV+Rhq?=
 =?us-ascii?Q?t0hR3q2bvlRT2zXEVPGxCTbf2RZ/bUWVUrK0jv8MrxDPQgw6gSXPmNsgtbsC?=
 =?us-ascii?Q?GTX2DdYlUS/8OuikujgIf6nx7+i4u/6ZLGNPbrLj54TSUPVFy+gm0UlUQz5x?=
 =?us-ascii?Q?uKLXlOaHsqRUBPvhXaXfNjfzP2zzSiNlNcjOqTWtAzUNPVrEhLK5v1r6BpZY?=
 =?us-ascii?Q?oODGYpO3VbUQ3yJEHeVbpP4QglV7VIiGh+bU4hoZ1KXJ0EmJhJ/dtHEarC4h?=
 =?us-ascii?Q?MiavrkxQTakF+tUGwKbdrCIdyJwkQVMw7QIU/Ez2Z1kBBiOjOcxZRzb+gKnd?=
 =?us-ascii?Q?7QTOA+elODemJZQ5+EbFmYf8uX6W9W83CVf5EkBHJ1Ba/mG28PNCx8AlPMiC?=
 =?us-ascii?Q?w++ViNsAyS8EWHAaESfE2aqh18IG/tdsN+uQvJUWGkpoQocre2d3zgSd5MNy?=
 =?us-ascii?Q?Yrzsom88+xXAKofYUAp5NjLxbZfW+taM2OKw2F3W+SP3D5KGQY0t5xW7IAq7?=
 =?us-ascii?Q?8gxDtQzG6cKPgADjWoRsHBExGsFn3dt4k/I5tPTLSuPgT/891nwCZv8GnBvc?=
 =?us-ascii?Q?1AotxzT2bq5mxrH4atEK2VaHXjNF9baYUoe//QE1769VbckSH+8yfjFSmGIu?=
 =?us-ascii?Q?1adGPiuIK4rfgvt1qLwBhlMzGEUmC9mSRk5AtVJ6Teqq7UFqX+Ekok1o5+65?=
 =?us-ascii?Q?gI9oMYRdPorW7Rhq44EK8ZAE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b85837-2dd3-43e7-88fa-08d9116e31fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 15:38:43.1083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itpSmblLuWTpR9uE4azZAPEuZw3ZPtwOF07yhddOo3SPLTVsOy2mnU41bNG4/4Ypzw/txRwoVMFcW3qVDVdb+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3290
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Liming Sun <limings@nvidia.com>
> Sent: Friday, May 7, 2021 6:19 PM
> To: Andy Shevchenko <andy@infradead.org>; Darren Hart
> <dvhart@infradead.org>; Vadim Pasternak <vadimp@nvidia.com>
> Cc: Liming Sun <limings@nvidia.com>; linux-kernel@vger.kernel.org;
> platform-driver-x86@vger.kernel.org
> Subject: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a memory
> barrier issue
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

I suppose it should be sent as Bugfix?

>=20
> Signed-off-by: Liming Sun <limings@nvidia.com>
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

