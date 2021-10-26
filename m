Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B619143BE16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhJZXtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:49:47 -0400
Received: from mail-eopbgr30054.outbound.protection.outlook.com ([40.107.3.54]:59486
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234225AbhJZXto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvdLvhXHoy5W0tq4Y15FyiyC43QWW+Y2qDkGhD8q+ofj0z6usOs6nDtZ8bZXYfGKsxzGQaf+IJV47b5yypyIV52J9tmPhK5VJaXFGh3Cj2V4bqaHaiXZYfzSzl8FHf59YPx+tSe0rkbj/WXOVpE8JIfLFW0kmsGrgrsRfV8vSaadWTi4MLHLNBHlgnXYDtg4rF7JDBrNLFXIEokXQz+EXZawEK9u9Ayzl0BA8j7lEv3DqOqi+oLbCXnjarlA5QRGr0966scrvCUo+iYzcXcfVIRNGUsYlhl1ohDFvChlSnypj1uIksb2W0dyQ35t/TMchVOT/hJEa7zKJ0mJSL5kMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IhYiTzXS1cfq4WiioTmm8iVdGjru/MgzGYdCE3YEEw=;
 b=ml4nz1KX596ewPkeajfXcDADCLdwulZ2gUeUBzT5sl0mN+k+GhtvlExwnh8n2QsTa+GbxMdzLbE2z2p5gYzWW+PjDJc0mnI95Nb7HpJ7EVF/sTWofEXbeTarY94jD+mjmmtzqm6a9jPZILDgq4DH0PjG+R/X/cWdhx45OQjR3mFOAmFuFkc4yPraYk+3ytFlMUsZsNrMU2psHnKShlxK/W2nE/NbZ8Thtt+I8jf3it7Fc/CgvqT6kTm7qoMdIppK8cKBd2NskYOp+pAqUhR+yvVPv3GN3Cc1R1WaXUsZNncnpZizUp0I0J0Yq0n9B9lhA9dynxK4XLzpzVwbPRM2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IhYiTzXS1cfq4WiioTmm8iVdGjru/MgzGYdCE3YEEw=;
 b=ikB2+PDit2qYZDPjg1ESFRhnKGVUvaHjUnbOD1jYx87KfNz//0EtfVtiQtRSWKvX7OAbaEzTtD9TSig9oxQNRu0Gqo7GLHl+jkkgNkxj1CoqXzDlpzMlc0vUanzD9riLmmnX1UfS+G0k7q+/I/wzc7wF6MgG3CdB67y69A4RkYw=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8737.eurprd04.prod.outlook.com (2603:10a6:20b:42a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 23:47:18 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%6]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 23:47:18 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Diana Madalina Craciun <diana.craciun@nxp.com>
CC:     Youri Querry <youri.querry_1@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH 4/5] soc: fsl: dpio: fix qbman alignment error in the
 virtualization context
Thread-Topic: [PATCH 4/5] soc: fsl: dpio: fix qbman alignment error in the
 virtualization context
Thread-Index: AQHXxDJcQzXRP2ZQ6EKg60CnRbWkUqvl/pfw
Date:   Tue, 26 Oct 2021 23:47:18 +0000
Message-ID: <AS8PR04MB8946734C740B202DC3CA88F08F849@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211018151034.137918-1-ioana.ciornei@nxp.com>
 <20211018151034.137918-5-ioana.ciornei@nxp.com>
In-Reply-To: <20211018151034.137918-5-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea7f482-6bb7-499e-758b-08d998daf247
x-ms-traffictypediagnostic: AS8PR04MB8737:
x-microsoft-antispam-prvs: <AS8PR04MB873702CDB85D771D25D35BAC8F849@AS8PR04MB8737.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tmn2AjF6D++a2Bdf8uoxBmCpYiAlRBuBXEA81W1TynL5UXasyq2AO9sBqAujHp1OJ/a01ZbhI4JPGpqK6qS1l6t3x71XroDk3EQu8r54f/PSpuhDUd2i4ettqPm/j6OvyCIV/O/7qBTV/AlwMwGXotJP1AXE0/dPr/t5bzCbtcz2WtiERTeTJnR4fzEGaulHxZoH37y7DgDWMjw7DKMeWKzVqRp34MGaezeet+/2M0luGaf3j2cowzDTJFYnXKSvhs3Sb6PVvdW3DvFjn0Y8E8vi5bW9DyYQMLVNTGeW8NPdSvU8YTo5vLGxBwJoOS7P6sFMzMVYIJRYqHksPW+ju3atR4WmTLlAB/ukHrVDyax+T5QyCCeI9cztgWUoyDbzxr7BWVnOb9jwomWs8xRYuxU8By87UtQNtP8yy2+7mBiKx0/gSVsuqKyjx3hr2AkAZK1hKkfXDdyGgBRXjAKPrPOPDZ/JHCxlZXfbYrm1z2Q1X8YGkN0Nd+aPj+as7uHuIAd39rqmlKeM1XE+OqCDhlKkA5f3VPGHIu+4Nd0fVwyCxoJYAeUwN5Z0+AsZWKpOE9cTJ3hOQDceCAwqwYFqH6I1kmwwDGtD/RXLuK7DJtNaP+a0GEVumjsAPq7HDCDhm+AurZ6z3ZwnADPhJWnyawy1NqOq2F/kBRA7rjFwNdfG49AW+XNF4BlGxdm07Lid+oSVzFkas4sqlr4xFbWnIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(33656002)(122000001)(508600001)(8676002)(2906002)(7696005)(52536014)(8936002)(9686003)(86362001)(38100700002)(6506007)(53546011)(71200400001)(186003)(26005)(55016002)(83380400001)(6636002)(76116006)(5660300002)(4326008)(66946007)(38070700005)(66476007)(66446008)(64756008)(66556008)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tMyTPbwtG73Q8jFRJouD8B4WOz+LvEGZU6ADFv0PcUbLbZTGaY89PwMf40qF?=
 =?us-ascii?Q?KkPvBfcnh8amCU7Htv19Q8qxjgzumwULRdWmM2GZRCOaBhRnZlqYKqvBWGM7?=
 =?us-ascii?Q?BDdIE8q3IHYd45P7xwhpmxCa63xi4vqz5NP1aPaq/Q0lQc0EkHVHMN1iVLog?=
 =?us-ascii?Q?vRBnvDMo4utSrAowNzw+ARwjmOBugWew8ODC/rerIiHGYj6Vbya1RwxpIn1z?=
 =?us-ascii?Q?h1Re6SoMwXHOSh0Ec9AIzdjmVMIyqg09gyr8O8AFCv7Ra5SxH9by/fufaogs?=
 =?us-ascii?Q?7e7fkEC2755yW74v43QqPazDTN/rWV2dNl5VbOVJu8ghsT2EQgUHUbH2o3ti?=
 =?us-ascii?Q?FYF1X0ZAfaOxA8vAVhH0e/2sKv2VASxC3lb817OPpKV9K8bFlPKZ1AcPC3AF?=
 =?us-ascii?Q?H3DmP8JhuklnrM+IzNwIXzyh0ZfNthjSRJ5v0G2tcUK3dAgxVtWVbIC12JOR?=
 =?us-ascii?Q?KX3/6H2LyyJpnFHLzolSaHE+Wm97M+WPA283LA/C/D+fJ/yrpRDlisii2NRA?=
 =?us-ascii?Q?FUaHlp6l/mdRjGqtXXkZHVfXggRALb7YBUTEMqaDjsLB83bCnpePIC3T7gV1?=
 =?us-ascii?Q?H60ICXuNVFNrV+MRXqfmtV0xFbzU6CyzTbpuNMgWhgmGUKJKVA/3+QDZHknV?=
 =?us-ascii?Q?xVWu497bRRVGUOKCvC4GN6w5bcGs3S+Pl7go8HSO3+8votssLTDZOA33B5vh?=
 =?us-ascii?Q?HBkoNOesR3RrD1njDfa5SFFKYoRk8hNabO0KTd6b8gGvQbr9nFwy2TWUhhcC?=
 =?us-ascii?Q?BAypWOZtu8LLyVL5waKO2TRBbX9lZuCJ7zjbpcQj+8zTYm4CII9uxlqa455h?=
 =?us-ascii?Q?4QChDwCBGA1izFd/2BTQ16GBzSiCNX42aVvyqLuYV9uE8nVDHcfejjiqC38P?=
 =?us-ascii?Q?5qvt4aIvaCRpSUpHoiuKT02BN+hsjqD94L5jytH6k6fXOEkxAHkQseCmwx6Z?=
 =?us-ascii?Q?wsfvBbTntTRBgrxDG6+2MURoM5mhJNPZcgDS3DDL52IGrEX6qoEY9q4kVsPp?=
 =?us-ascii?Q?1Z6VPZiIwEeXVTSi8H5Ae1H/q8fD8VN74eHwGXu7n0RA07vO6zcAQIv2Ld1y?=
 =?us-ascii?Q?i7OdOuioKhKae2T125wC8seYkOg3u0Ex7g6PDy7jq47qjuIxa7G9v5IALJQH?=
 =?us-ascii?Q?jJhNOB3cEMqCJ67aCXdncS5ULSleuiCYeC3Tzm0Ynk/JxmGslNav4x8OIbUW?=
 =?us-ascii?Q?90iZtjQEpldQvBFqPYZJhg11GH/efvy5lW/LUg54+NmXxzFBq7Y+sTEAk+fF?=
 =?us-ascii?Q?dYR01Yy1BaAVq0DsKQZouLx3jP5+gE+e4FrCqv2RociS2IbEPby+C4X+0HIf?=
 =?us-ascii?Q?QXYnAWS+WFqSSlFiytZEgG5vjtxhoX2c9FzxxAHuwjJGdX6LQ8psH1KHBtnN?=
 =?us-ascii?Q?xQpTlzmaaPVT3qSj6vrf0ebgu6aNLOVJbp/BnCIyLyGIBl23mPPYKO4X65gW?=
 =?us-ascii?Q?TN+qjTMDjyCwV45QXSCYCr8Bkiu5w3hQ7IXlmh5jI4RjedQjvzVxvtR5lTHu?=
 =?us-ascii?Q?u+uQtkWwMwaGTLE7WSm7Tbt3ojqqYwYWk2OezdAPxDJxrBh3DuNnvAmnVkTv?=
 =?us-ascii?Q?0WQzm0h0Q+5lpQz9pPn2iOtOsvG33F2NOZarIuR2skx+us/H73pmV/lY38OW?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea7f482-6bb7-499e-758b-08d998daf247
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 23:47:18.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfDTQ1ilWhzmFiDlf5EeCuwBnjMCOVfQJOrc9LD6wTwcjxkGCb+nw/ea4fQS/3E9P8A44mGFL/n31//E06hS6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8737
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
> Sent: Monday, October 18, 2021 10:11 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Youri Querry <youri.querry_1@nxp.com>; linux-kernel@vger.kernel.org;
> Diana Madalina Craciun <diana.craciun@nxp.com>; Ioana Ciornei
> <ioana.ciornei@nxp.com>
> Subject: [PATCH 4/5] soc: fsl: dpio: fix qbman alignment error in the
> virtualization context
>=20
> From: Diana Craciun <diana.craciun@nxp.com>
>=20
> When running as a guest, under KVM, the CENA region is mapped as device
> memory, so uncacheable. When the memory is mapped as device memory,
> the unaligned accesses are not allowed.  Memcpy is optimized to transfer =
8
> bytes at a time regardless of the start address and might cause alignment
> issues.
>=20
> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

We get the following feedback from Arnd about this patch.  Could you respon=
d to the comments?

"This patch looks very suspicious to me, I don't think it's generally safe =
to
use memcpy_toio() on a normal pointer, as the __iomem tokens may
be in a separate address range, even though this currently works
on arm64. Adding the  (__iomem void *) cast without a comment that
explains why it's added seems similarly wrong, and finally the
changeset text does not seem to match what the code does:

According to the text, the pointer is to a virtual address mapped as
"device memory" (i.e. PROT_DEVICE_nGnRE or PROT_DEVICE_nGnRnE),
but the code suggests it's actually write-combining normal
(PROT_NORMAL_NC)."

> ---
>  drivers/soc/fsl/dpio/qbman-portal.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c
> b/drivers/soc/fsl/dpio/qbman-portal.c
> index 3fd54611ed98..ef9cafd12534 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.c
> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> @@ -679,9 +679,9 @@ int qbman_swp_enqueue_multiple_direct(struct
> qbman_swp *s,
>  	for (i =3D 0; i < num_enqueued; i++) {
>  		p =3D (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi &
> half_mask));
>  		/* Skip copying the verb */
> -		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
> -		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
> -		       &fd[i], sizeof(*fd));
> +		memcpy_toio((__iomem void *)&p[1], &cl[1],
> EQ_DESC_SIZE_WITHOUT_FD - 1);
> +		memcpy_toio((__iomem void
> *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
> +			    &fd[i], sizeof(*fd));
>  		eqcr_pi++;
>  	}
>=20
> @@ -763,9 +763,9 @@ int
> qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
>  	for (i =3D 0; i < num_enqueued; i++) {
>  		p =3D (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi &
> half_mask));
>  		/* Skip copying the verb */
> -		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
> -		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
> -		       &fd[i], sizeof(*fd));
> +		memcpy_toio((__iomem void *)&p[1], &cl[1],
> EQ_DESC_SIZE_WITHOUT_FD - 1);
> +		memcpy_toio((__iomem void
> *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
> +			    &fd[i], sizeof(*fd));
>  		eqcr_pi++;
>  	}
>=20
> @@ -837,9 +837,9 @@ int
> qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
>  		p =3D (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi &
> half_mask));
>  		cl =3D (uint32_t *)(&d[i]);
>  		/* Skip copying the verb */
> -		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
> -		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
> -		       &fd[i], sizeof(*fd));
> +		memcpy_toio((__iomem void *)&p[1], &cl[1],
> EQ_DESC_SIZE_WITHOUT_FD - 1);
> +		memcpy_toio((__iomem void
> *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
> +			    &fd[i], sizeof(*fd));
>  		eqcr_pi++;
>  	}
>=20
> @@ -907,9 +907,9 @@ int
> qbman_swp_enqueue_multiple_desc_mem_back(struct qbman_swp *s,
>  		p =3D (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi &
> half_mask));
>  		cl =3D (uint32_t *)(&d[i]);
>  		/* Skip copying the verb */
> -		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
> -		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
> -		       &fd[i], sizeof(*fd));
> +		memcpy_toio((__iomem void *)&p[1], &cl[1],
> EQ_DESC_SIZE_WITHOUT_FD - 1);
> +		memcpy_toio((__iomem void
> *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
> +			    &fd[i], sizeof(*fd));
>  		eqcr_pi++;
>  	}
>=20
> --
> 2.33.1

