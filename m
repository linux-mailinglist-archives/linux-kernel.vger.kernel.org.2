Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B9844FD19
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 03:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhKOCXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 21:23:03 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:58718 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229790AbhKOCW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:22:56 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AF2DFaL016295;
        Sun, 14 Nov 2021 18:19:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=QffTKuiij8tF1rauYcgDRaI9xAuSnBLxC+x+CvQMEZU=;
 b=G6tXgKShiv8GpZ4cK1gEzcMt+ZbgqaJLel+LIQ+BZNj4sPyP6UBiSFW1jVNI/hbHCVBO
 lG8isff27fV0IOEa13yo6X4yU8qYCOo8v6fUzVvgWg33FiZMguvG+PIDoZ32mPK495ll
 Y4W0g97Ob+FXV8JSRezBrhrRBLB+jNuYHbhKVkyeClaLdvhFl/YftBn9L75Zcx/pJx8S
 66C6/HY6UauDaUyyiVRSTZFcJ/lt8rW0MqegN2qLt+GukidovtAqRcQZ5Qd3Q+fUnB8Y
 2PJLPrNd1UZDqRz8TYgG4qDsp5aCjolVv0ZqFQ91LRyMwpZVsXrqYXB0GGJCQrhDF78f mg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ca9h8178u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Nov 2021 18:19:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOy4d0s396SNtu1lTDzBNGBi2tMfPHNUJaCjEGUTFWB32Xx6qvxIiryrRjqRWG46JpD5uhZ/UoZtpqfY9aop+/Y6E4kmrp7DBLHuqVo2wYioXhSvjWq58bbrfQRi/YNDj6CSKstkp/nzDrJEGgEdwnpTYnMoUYjJcZwepl/5+PJvPiFn4lWoti61g506vHevEKoVnR8N5Upesiw4HMPhjoN0gJqe0TSJXzVI8qcC//95QohhQRRfLs7KKZHRib25Wue1A1+P5fdMcaYKH+TCiVOGIrFkVeY6id8mJJ0AdiFpCYQUcERKamevG9smBky9LfdY59m4seW00ETmBnWHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QffTKuiij8tF1rauYcgDRaI9xAuSnBLxC+x+CvQMEZU=;
 b=cn3YT8SkuDM2IGyTwrCZ6BLS2K4mU4/mLH0wMGzxQRk5bE911QWam0q5nqLbYzNmTAhV5nb8uC+BwNycFTkO5chfr7p2wNIqwgF/HchzZjylSmesIbNB/QwTEhZOYfHmXnoBI8LTVBXPUBd5lONxh5eUmDXbAjVoJCfvhGLsRAgwbNGM4Ly4T6kRYDtv3ybjTASaSTHs6Caq2KRXHDCBVxn0KfuAdmCb5H2+/3fRkCUIt6+lO5yF2gMy4eQDH3HEhwvN7Sqq2BZQH7hpH8SoA2w1O6yNcKtW4aQFq8wyaDHxz5G5uJsDu2txQ2fQtHly7jJ0S1unhBOfY+qLYhNgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 02:19:48 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 02:19:48 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] arch: arm64: dts: add delay between CS and CLK signal for
 flash device
Thread-Topic: [PATCH] arch: arm64: dts: add delay between CS and CLK signal
 for flash device
Thread-Index: AQHX0GRWh0F5UroaoU6nw30jLZ/2zKwD7Z+g
Date:   Mon, 15 Nov 2021 02:19:48 +0000
Message-ID: <PH0PR11MB51919E776D51FFCCE81586F6F1989@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20211103033838.16015-1-Meng.Li@windriver.com>
In-Reply-To: <20211103033838.16015-1-Meng.Li@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b35dd384-8eda-4c79-b15e-08d9a7de65c6
x-ms-traffictypediagnostic: PH0PR11MB5109:
x-microsoft-antispam-prvs: <PH0PR11MB510964B8FB31E3128DF4AA29F1989@PH0PR11MB5109.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lY1F9GfIQAw24tsuprMztOShoTduDpVT/9gmFY2FpSxnpszRRkmci2u72RxJlDnNcadw+eOCUUz1/S8PVZImxCXbb4TAd4GH56LnQCa6TsakH1/j+tU2j9lOyp07x5WN35YnP0rGu+k/cBIvzrEAUbTuNE0n7VMxfp1PeaevUJaotH12git+9hN0qcXODgvTmt+nXZIN3s/4VcU8kYlzUi1DUOVygVf6TA7wumCbviyROWxn6p3tFaJ4w38NYYMUvdzg8Fzj4M1h3Y+oWsVcQVv3yAYffBMomB9q40aK0V+k+ejd5L1lJ+aYdwZbDmig8DiVil1Knh5Lx7kwIL123GyUxx/8ZGwlBgaB4mtmptnhNCIDLK3Hkg/sn7wAH5W14WUIzmlKCKMyyfF6nAwvrpr3G2xz8q7IbqSh5iUZt36jBqpK96JR7A6WLyOINnocYl1qnCP2iPb7fX07Z8qZ1Vx1APhfLYygK9H9F3I2d0zgBU+d6s2CiULeGlZxnQvZcFT80e1rFis5KlW0W79IhGdYufF3QMZxOtYdoSbcpPahV5cB4HQ0TjTdnMN3vpszwKcP0j3K3QXFV9omD0tVtYqjUniWYHDw4axybMGkHUdjiHW7aInWRoFwDOVqYC/+SdvtXOfvGfiuYYEOwS1tiS1uBSxrlrubz+ZyqpBvdtOQ+3JNF+taaISMCIVx4e7e6Fpi3QBZXNMroRxOANnN1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(53546011)(7696005)(2906002)(26005)(8936002)(508600001)(76116006)(66476007)(38070700005)(66446008)(66556008)(64756008)(6506007)(110136005)(66946007)(122000001)(83380400001)(4326008)(86362001)(316002)(55016002)(52536014)(54906003)(5660300002)(38100700002)(8676002)(9686003)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IfB0+rQpdUm1WVLEENBGqWEVb5wdOFp+P0E6YPFn1xJzo6Ic4uTMNeOXoftt?=
 =?us-ascii?Q?pNJv6TbNm9gfajVdpSD7ZI/9f3vMqZaO/JGa72ry4lJw0bKTyRIX3PEHrJyq?=
 =?us-ascii?Q?wQ+i3Xnf0Oj+yHrr8quVO0DoDVM+9HZLhHN2vI0KDX60gkzbiM00MRCa7JWs?=
 =?us-ascii?Q?B3JvAkxMZR5hBE6P+v15ajtt1FzM4X0BW0EVBUM5wb65QdvUPpSvXVtzJI1C?=
 =?us-ascii?Q?TiHm8qPL+82Lx/O0FlVQmLpaLDh0jf/nqhkebZsh5r1K/Jw3d3aUtk+Ai/mq?=
 =?us-ascii?Q?K1YgFbagPpL9NJLrklyO7YdvzPf+QK56o0ikyeHurC3K9aPLaVrWRcJcccrE?=
 =?us-ascii?Q?wWF+BdC7QMww2Jo8IxgJfwijJr0yrEpHPbXQMuhgla68ehrcsFSCDMmLASb+?=
 =?us-ascii?Q?g3dfVb9/ryD+WoCFnjp6HI3qk+nYcKLNNRM1WDJARiAMcYRq8szwl76XG3OQ?=
 =?us-ascii?Q?9wjWma7kQGG4AIgYWD3btiCN+CqtkNONe7nGpYRStFJFUEXmIHCy0ddvqeD6?=
 =?us-ascii?Q?HvrMscc3SYE/X5da9BeVKVdUyavGibq8znppFsI3OlnhO0xtxxFDmet4KdlM?=
 =?us-ascii?Q?NfVmujuYE7OLhNQMPWqat6Q9cr0JzBkFNxNljsM4fQSCuXCeflH/BzVR7xuV?=
 =?us-ascii?Q?n0+yYRw9ojQEziSEZ98JLH/RL2EhoXUQgw1FRmHOEYGlHYh7VcOhdc60h5oK?=
 =?us-ascii?Q?N3YYO8Ko1utq9JhiiCtGC/IKZXpPPMkI8eIAi2pB9jlh/XtJ5nketPyiHAfo?=
 =?us-ascii?Q?LYh0ZotgUGvM9RiaobCOr5C1ktiPpPjaDyaWGecJUvIkTHj5Lh/nLirxbjsX?=
 =?us-ascii?Q?gMlO4hrVDXz7GimIb02S/2bCcKdJfUjL6HXr1JXz4pd1qRb0fuVXXrk+q1bB?=
 =?us-ascii?Q?bKiIc79h8hcEHaN2GtUPHgmm01gV3lew5z835id/gtFQ2p6ZQ5V2nefs8jFD?=
 =?us-ascii?Q?6ipfKwr4FxrBDwq6miCu0VV0x5+lDNv93FvMGSdN+m1OY72PS59c3HPBjHxL?=
 =?us-ascii?Q?vUOwYkdMwM/kX5QZeaOe82d5eZ8Wif0Nw4BpNqSGbh/kKOKHB7WE3FvNSMi9?=
 =?us-ascii?Q?TejgGb59gq+wdLcgsK7kX8Gw76Oy7NfHjBV3U8o8Iij8yGqW3tr47O8qZOy3?=
 =?us-ascii?Q?k995oJD/BpiENf1xllUN4geEj3tdKv/VzJ/EvomEHpipACkyjwwdt/pZf1hH?=
 =?us-ascii?Q?DmTlGIZGPQjI018kwfNc/BRdBVgYaPgWSUPQ0sEwMMwOVmxvPHdBbGuTxSxY?=
 =?us-ascii?Q?NKXb8TaHKEznj9QAJCvrvtemkKCbnfwh8Y8Jj92ghBVBiscc/ByQSbKu66ZP?=
 =?us-ascii?Q?166rbuE//OD12YuuEkJ4GmGKhDkbBBDT91rGwej0mhjfDWu/wUELqnpk1XxA?=
 =?us-ascii?Q?ulFYEbHqf2nuIItjuNXDAobRDpzzhTbELPSxBttcCDxJ7sMNVbd7j6p+VOI1?=
 =?us-ascii?Q?qMr7EVtRv4AVlZzDrrG/1Bvj2nzeKtQWCXJ1XA9RBT4Glgo8cf/GSoTTyAAW?=
 =?us-ascii?Q?YJPnlkxyrXsVKJGZxONnuAQQmO63xSoQeZe/ZBRLHBI1iqKqi7/CK+b8H+1w?=
 =?us-ascii?Q?Yv5JohNVSFYb/2wGSBuQwSpPRHah3uUTj1Pw0aWAzmdh1aUzy329qcKqKnmC?=
 =?us-ascii?Q?rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35dd384-8eda-4c79-b15e-08d9a7de65c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 02:19:48.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhdGGepdlpWlvOq7cOqYLzz3j6KlSnbAK5ZJ+qmDNqgmTNV9tpOI6A/2UQIO7D2hnReow/StYsqtwppzm5KbTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-Proofpoint-GUID: 8TvEGEjZ19Hc_i9qF2HYeTM5b2Tf0rqB
X-Proofpoint-ORIG-GUID: 8TvEGEjZ19Hc_i9qF2HYeTM5b2Tf0rqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_01,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111150013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any comments about this patch?

Thanks,
Limeng

> -----Original Message-----
> From: Li, Meng <Meng.Li@windriver.com>
> Sent: Wednesday, November 3, 2021 11:39 AM
> To: shawnguo@kernel.org; leoyang.li@nxp.com; robh+dt@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Li, Meng <Meng.Li@windriver.com>
> Subject: [PATCH] arch: arm64: dts: add delay between CS and CLK signal fo=
r
> flash device
>=20
> Based on commit d59c90a2400f("spi: spi-fsl-dspi: Convert TCFQ users to XS=
PI
> FIFO mode ") and 6c1c26ecd9a3("spi:
> spi-fsl-dspi: Accelerate transfers using larger word size if possible"), =
on
> ls1043a-rdb platform, the spi work mode is changed from TCFQ mode to XSPI
> mode. In order to keep the transmission sequence matches with flash devic=
e,
> it is need to add delay between CS and CLK signal.
> The strategy of generating delay value refers to QorIQ LS1043A Reference
> Manual.
>=20
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> index 3a669238a0b8..3b1a31a063c6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> @@ -98,6 +98,8 @@
>  		compatible =3D "n25q128a13", "jedec,spi-nor";  /* 16MB */
>  		reg =3D <0>;
>  		spi-max-frequency =3D <1000000>; /* input clock */
> +		fsl,spi-cs-sck-delay =3D <100>;
> +		fsl,spi-sck-cs-delay =3D <100>;
>  	};
>=20
>  	slic@2 {
> --
> 2.17.1

