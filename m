Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23143EAB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhHLTu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:50:27 -0400
Received: from mail-eopbgr1400098.outbound.protection.outlook.com ([40.107.140.98]:16798
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232647AbhHLTuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRCM0JGt1w0DovRdWdDFugsDhuYaP0y93rTHC3dHtyxLUNljTWQ6NWjncL2+iDbjsPaVg7c/KErCIj4Jbj9AJ3FpdnQBwkrLAgtANcots60nlumKts6Nc+UxikNVISUQiHIcN+sbNbcVBdtWhuNrSVDxU90rwkyaR23hCZ4XWp68n/+EbBQtXTkKDLRSxMC9KbzJU4uFzLBa0dpUxvnOLZZ8QnV43tiDJxhkYPXqzlbLLdMKuSoh2Uk+h3PGuLyH5OFhwy93nKE4CEqXXihQNc7/kHTPfakdYSrOsBUE5pJkji7MON7rUHf84Ttaxcaqs/hHCbrNjZrPcl+vWMt2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nCijEY34q5qh0trooCoKV6X5lZwrR4YdOoh0P5vFfQ=;
 b=HUg3asEHZaGZzTzdi0N25Ti1EmIygvDNazRqJhiaJgNF4X/DwKYXuRGy1aCbVgWcCw7fFRsuHE4p7MPq1nQX+iroKgBu8eA/WRcqazNvX0teUtWq0vsp3zmt82wFsCVN3aDTBKRB2TI75ShNb+HScED+xKTTV1TM3JUqMxBI0sUmPtskOZwoO5jLUFwnplkAfJzz0dVW62UaTG0aYpRz4r69TFDsGgiqMzWEdMnDJ6SlkGSb933bD+BGY85Azx+IUio3SBwJJpEksWRfnGDbvpE5PJG5St+fyPFhSYE2gFi9nnuo8cOr13zYGPO79lm0UJOBfMKKkh9WbBF4HVZWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nCijEY34q5qh0trooCoKV6X5lZwrR4YdOoh0P5vFfQ=;
 b=OBZY1aafdncZSK45/8RFYQEbhkN2OJw15oRLrAANOkDJkoH6b6Y3JpTVivXGH/aY3TGDa3aVRxd4Qo3ZvXKRUXbBEW03HV1jGyDqEtNZl37EVLNnLVcnVLiRaZbXOYUOUg+RG/J1CATI3b7jCeKlvYhY4Zs1op9FHYOKLSby2Fg=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB5575.jpnprd01.prod.outlook.com (2603:1096:604:c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 19:49:57 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::d466:8655:85d2:1ed5]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::d466:8655:85d2:1ed5%7]) with mapi id 15.20.4415.019; Thu, 12 Aug 2021
 19:49:57 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Min Li <min.li.xe@renesas.com>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v3] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v3] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXZGBI73dhrC6Hl0qCeqEere9Wyatwm7wQ
Date:   Thu, 12 Aug 2021 19:49:57 +0000
Message-ID: <OS3PR01MB659329DB91410939ABEB5621BAF99@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1624034232-7952-1-git-send-email-min.li.xe@renesas.com>
In-Reply-To: <1624034232-7952-1-git-send-email-min.li.xe@renesas.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f96c516-3ce0-486b-39c7-08d95dca5ce3
x-ms-traffictypediagnostic: OS3PR01MB5575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB557525B03A9E8D358F53A350BAF99@OS3PR01MB5575.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNUfuPMrlQZ2vjzjkvP8U7FQerUe05iB6H03stCnDx9lMAAs/uUQ/+Pg3x1CRjlreanmpKxEhkfiVI/yF4RNa0Gfc3ZU5f1snp58Cmgeh8xC0nMk2KQj7ehJlmoqMCsytDioUxDUf7kdoA/SVog9plodiAqherFZecVHPD8iHt15zx0bZTPg2HGMI1SbMqLikcb5PsFuRc9Gt6IrzYYC685S8CwiQD7fjkeTNU6hq6D9DYjaAFpc58EvBjkYwis7lkXRqhftJ/gn8pSRBXPaVUbKi0wt0UBPghFfDAotT//ZGJW60HcrwqcKDa7HQK3/c0IdT/gBQMqfiRvdUy/TcX4HuggkXjv1FvQxbcAhuVGKh+hO+C5jlV19jYJROduP45Xa+kVuW34K+NEtxz9i+Gzbz3ZyahYRRBK8Nl+kNR0pfw1adGsWHCrYnOYlfMuvdpl7tSDvW8VHkhMwWTzc758mKWLLee2IrPPhmiXercssPJAudTAipyr4RHAW/VvgfwTelCL6qf81iP3Syp60nVpvaZEKsDRIuHSLUmhEFbl8uM8CiIIVgTKRSBIdCe96NBbT60DGm33SDBQgwhlhoonpIkjyWFwHPex6tUxK4QvFMKXOJ3QDdoh3Q6/bYY6AV/Pw9eHIuiGpDVEE6dBs+esXqbJQI6acu3kimvBmmt2WXIx2fZzKUUtEYa+s6/BjMBQ3EXNF9Fm/T/pWmGnknA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(376002)(396003)(136003)(366004)(83380400001)(38070700005)(5660300002)(2906002)(38100700002)(4326008)(122000001)(55016002)(8936002)(478600001)(26005)(186003)(8676002)(9686003)(30864003)(86362001)(53546011)(54906003)(6506007)(110136005)(19627235002)(66946007)(7696005)(52536014)(33656002)(64756008)(76116006)(71200400001)(66476007)(66556008)(316002)(66446008)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DGWySAmC7nLpDXK3cNFJF92A8TTYuX8CkVk1BVBgsAKOm4f0YbjJaqh0esV3?=
 =?us-ascii?Q?R4dYIYNJQ30YsWeB+paYFbt+Onq4mlMNh7iHI1hQYJasnznbW7+RgZFQKNQD?=
 =?us-ascii?Q?bD99fHs3i7TAgtvXaxH3g5EoK6Xn6vY5NR9unJMzxJbrpxvpFCRKA9CJ0GWg?=
 =?us-ascii?Q?Y5NkGiMMk0W38O9WNkugNcgSbknH9yfwF/Kwv+UCyIPAMdhaG3lbHsi/Z/Iv?=
 =?us-ascii?Q?tdIT5+6l0zSsYHTptBH6o+7o8bLONWSp7/XrHCBUaBPcsJwHmAfK/DpIOA+p?=
 =?us-ascii?Q?krc5WEnaeUSOIFNTKJ+gFOMnPDoK86aGAkEDc9tiDf/anb759g29E4VXr3Jl?=
 =?us-ascii?Q?1BKdNk5Q3FZ10xWOd+eDshFPrd3ZX5Q7sJY2GZgNefndXFXY2C5ee7ELvu1B?=
 =?us-ascii?Q?6ZTc7HoujVex3eandEbx9hEPIpU/IxiYe992Pd8HRPRaPZKWfOi3yt9Ei4Kr?=
 =?us-ascii?Q?1WFEg3h3B89e9T6SxdpCVansLIveBZX7CT1ypoWv/+GbdZTM/z/IHjKPfvW2?=
 =?us-ascii?Q?UO5b9ZbihILVWfDHPIMHg64mXWv1zNwYeFXkRfGLIp3k/vS1q5kODg//IeH6?=
 =?us-ascii?Q?rEt2qceFa/lBaphPj4r1Cfz2zqrx3HiPFn6WervYuK+DvmGmZA/4mQVYNAYU?=
 =?us-ascii?Q?RS7XXc/EeZgIpRCOnWSrxMiXQCIEReoyptFX6zH8/mkujMq7cQ3dYXb2qDUt?=
 =?us-ascii?Q?AeAPGRR4/3AxHnf5gpmDdxKtTLfwubwkRNQUkBkkDu+i6UIMy5Tv58eig9Wl?=
 =?us-ascii?Q?3vS1dRk1rcMxTq1HQDqce0/UGQP2Fm8rDuj/CaQvqDh3+BSGHtGd+PjjFBAX?=
 =?us-ascii?Q?s99CmPXAizz8ljUnZGd/ouz8TIwIa73CaTlshrW7IGoTF3Ux9Yb9BAOODm0a?=
 =?us-ascii?Q?uMkxF9Ok6MYWIJcLdBm/Pk0tncdOSzK7Q9f3n2GhHCF+GEtFhymNkEQA+HB4?=
 =?us-ascii?Q?IwxOoz/uqOlWjk2S6E7dNbY7aysrZOYkL/6+EHFmyoWV/1cElQiiwBRWBe8T?=
 =?us-ascii?Q?bgiXv3ofpH7kxv7u7abnE77OIF1KbAYrSUwRhQ+T+nmeftoc658fAJx7fA4V?=
 =?us-ascii?Q?KJlwufs37j6wOHJV+CnWGUiDPpVajqA9IweSfzd28TSeAQmUMxDI7sqyN5Q+?=
 =?us-ascii?Q?y6MTQUSVwJSOJH+/Uctccb4jajvTjv7OtXl/Jsi+ePTvwWp2VNappeogXa8Y?=
 =?us-ascii?Q?N6NYCEKsvfLM1xAk+0rBfR08L0qWhPB7HEOjWOIxuLZXy+Jr1ulgvbpKAofO?=
 =?us-ascii?Q?bh85/UJGmZAMhSTf8Ji0UbJcMtTpaj/PQ+gviDahc4W7jvMv1lLFocznPdNc?=
 =?us-ascii?Q?k/Q8LTI4QgcW9EdNlGP7sVs+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f96c516-3ce0-486b-39c7-08d95dca5ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 19:49:57.0697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: larJSIxunFsFCVqXWadAQu+Ey6hKTCGqT/Wxh+EDxZEjd86idJLk9WQsKOA1W96f+fWqXrUxRy05nRb5PKi9YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5575
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

This is Min again. Any chance that you can review this patch next week?

Thanks

Min

> -----Original Message-----
> From: min.li.xe@renesas.com <min.li.xe@renesas.com>
> Sent: June 18, 2021 12:37 PM
> To: sameo@linux.intel.com; lee.jones@linaro.org; grant.likely@linaro.org;
> robh+dt@kernel.org
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Min Li
> <min.li.xe@renesas.com>
> Subject: [PATCH mfd v3] mfd: Add Renesas Synchronization Management
> Unit (SMU) support
>=20
> From: Min Li <min.li.xe@renesas.com>
>=20
> Add support for ClockMatrix(TM) and 82P33xxx families of timing
> and synchronization devices. The access interface can be either
> SPI or I2C. Currently, it will create 2 types of MFD devices,
> which are to be used by the corresponding rsmu character device
> driver and the PTP hardware clock driver, respectively.
>=20
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> Change log
> -create the core driver suggested by Lee Jones
> -export rsmu_ddata instead of platform_data suggested by Lee Jones
> -add support for 8v19n85x chips
>=20
>  drivers/mfd/Kconfig              |  28 ++
>  drivers/mfd/Makefile             |   5 +
>  drivers/mfd/rsmu.h               |  16 +
>  drivers/mfd/rsmu_core.c          |  88 +++++
>  drivers/mfd/rsmu_i2c.c           | 203 +++++++++++
>  drivers/mfd/rsmu_spi.c           | 273 +++++++++++++++
>  include/linux/mfd/idt82p33_reg.h | 112 ++++++
>  include/linux/mfd/idt8a340_reg.h | 729
> +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rsmu.h         |  36 ++
>  9 files changed, 1490 insertions(+)
>  create mode 100644 drivers/mfd/rsmu.h
>  create mode 100644 drivers/mfd/rsmu_core.c
>  create mode 100644 drivers/mfd/rsmu_i2c.c
>  create mode 100644 drivers/mfd/rsmu_spi.c
>  create mode 100644 include/linux/mfd/idt82p33_reg.h
>  create mode 100644 include/linux/mfd/idt8a340_reg.h
>  create mode 100644 include/linux/mfd/rsmu.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 21a131d..b919267 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2172,5 +2172,33 @@ config MFD_INTEL_M10_BMC
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>=20
> +config MFD_RSMU_I2C
> +	tristate "Renesas Synchronization Management Unit with I2C"
> +	depends on I2C && OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Support for the Renesas Synchronization Management Unit, such as
> +	  Clockmatrix and 82P33XXX series. This option supports I2C as
> +	  the control interface.
> +
> +	  This driver provides common support for accessing the device.
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
> +config MFD_RSMU_SPI
> +	tristate "Renesas Synchronization Management Unit with SPI"
> +	depends on SPI && OF
> +	select MFD_CORE
> +	select REGMAP_SPI
> +	help
> +	  Support for the Renesas Synchronization Management Unit, such as
> +	  Clockmatrix and 82P33XXX series. This option supports SPI as
> +	  the control interface.
> +
> +	  This driver provides common support for accessing the device.
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 4f6d2b8..8739043 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -271,3 +271,8 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-
> m10-bmc.o
>=20
>  obj-$(CONFIG_MFD_ATC260X)	+=3D atc260x-core.o
>  obj-$(CONFIG_MFD_ATC260X_I2C)	+=3D atc260x-i2c.o
> +
> +rsmu-i2c-objs			:=3D rsmu_core.o rsmu_i2c.o
> +rsmu-spi-objs			:=3D rsmu_core.o rsmu_spi.o
> +obj-$(CONFIG_MFD_RSMU_I2C)	+=3D rsmu-i2c.o
> +obj-$(CONFIG_MFD_RSMU_SPI)	+=3D rsmu-spi.o
> diff --git a/drivers/mfd/rsmu.h b/drivers/mfd/rsmu.h
> new file mode 100644
> index 0000000..bb88597
> --- /dev/null
> +++ b/drivers/mfd/rsmu.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Renesas Synchronization Management Unit (SMU) devices.
> + *
> + * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas
> Company.
> + */
> +
> +#ifndef __RSMU_MFD_H
> +#define __RSMU_MFD_H
> +
> +#include <linux/mfd/rsmu.h>
> +
> +int rsmu_core_init(struct rsmu_ddata *rsmu);
> +void rsmu_core_exit(struct rsmu_ddata *rsmu);
> +
> +#endif /* __RSMU_MFD_H */
> diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu_core.c
> new file mode 100644
> index 0000000..29437fd
> --- /dev/null
> +++ b/drivers/mfd/rsmu_core.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Core driver for Renesas Synchronization Management Unit (SMU)
> devices.
> + *
> + * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas
> Company.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rsmu.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include "rsmu.h"
> +
> +enum {
> +	RSMU_PHC =3D 0,
> +	RSMU_CDEV =3D 1,
> +	RSMU_N_DEVS =3D 2,
> +};
> +
> +static struct mfd_cell rsmu_cm_devs[] =3D {
> +	[RSMU_PHC] =3D {
> +		.name =3D "8a3400x-phc",
> +	},
> +	[RSMU_CDEV] =3D {
> +		.name =3D "8a3400x-cdev",
> +	},
> +};
> +
> +static struct mfd_cell rsmu_sabre_devs[] =3D {
> +	[RSMU_PHC] =3D {
> +		.name =3D "82p33x1x-phc",
> +	},
> +	[RSMU_CDEV] =3D {
> +		.name =3D "82p33x1x-cdev",
> +	},
> +};
> +
> +static struct mfd_cell rsmu_sl_devs[] =3D {
> +	[RSMU_PHC] =3D {
> +		.name =3D "8v19n85x-phc",
> +	},
> +	[RSMU_CDEV] =3D {
> +		.name =3D "8v19n85x-cdev",
> +	},
> +};
> +
> +int rsmu_core_init(struct rsmu_ddata *rsmu)
> +{
> +	struct mfd_cell *cells;
> +	int ret;
> +
> +	switch (rsmu->type) {
> +	case RSMU_CM:
> +		cells =3D rsmu_cm_devs;
> +		break;
> +	case RSMU_SABRE:
> +		cells =3D rsmu_sabre_devs;
> +		break;
> +	case RSMU_SL:
> +		cells =3D rsmu_sl_devs;
> +		break;
> +	default:
> +		dev_err(rsmu->dev, "Unsupported RSMU device
> type: %d\n", rsmu->type);
> +		return -ENODEV;
> +	}
> +
> +	mutex_init(&rsmu->lock);
> +
> +	ret =3D devm_mfd_add_devices(rsmu->dev, PLATFORM_DEVID_AUTO,
> cells,
> +				   RSMU_N_DEVS, NULL, 0, NULL);
> +	if (ret < 0)
> +		dev_err(rsmu->dev, "Failed to register sub-devices: %d\n",
> ret);
> +
> +	return ret;
> +}
> +
> +void rsmu_core_exit(struct rsmu_ddata *rsmu)
> +{
> +	mutex_destroy(&rsmu->lock);
> +}
> +
> +MODULE_DESCRIPTION("Renesas SMU core driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
> new file mode 100644
> index 0000000..dc001c9
> --- /dev/null
> +++ b/drivers/mfd/rsmu_i2c.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * I2C driver for Renesas Synchronization Management Unit (SMU) devices.
> + *
> + * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas
> Company.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rsmu.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include "rsmu.h"
> +
> +/*
> + * 16-bit register address: the lower 8 bits of the register address com=
e
> + * from the offset addr byte and the upper 8 bits come from the page
> register.
> + */
> +#define	RSMU_CM_PAGE_ADDR		0xFD
> +#define	RSMU_CM_PAGE_WINDOW		256
> +
> +/*
> + * 15-bit register address: the lower 7 bits of the register address com=
e
> + * from the offset addr byte and the upper 8 bits come from the page
> register.
> + */
> +#define	RSMU_SABRE_PAGE_ADDR		0x7F
> +#define	RSMU_SABRE_PAGE_WINDOW		128
> +
> +static const struct regmap_range_cfg rsmu_cm_range_cfg[] =3D {
> +	{
> +		.range_min =3D 0,
> +		.range_max =3D 0xD000,
> +		.selector_reg =3D RSMU_CM_PAGE_ADDR,
> +		.selector_mask =3D 0xFF,
> +		.selector_shift =3D 0,
> +		.window_start =3D 0,
> +		.window_len =3D RSMU_CM_PAGE_WINDOW,
> +	}
> +};
> +
> +static const struct regmap_range_cfg rsmu_sabre_range_cfg[] =3D {
> +	{
> +		.range_min =3D 0,
> +		.range_max =3D 0x400,
> +		.selector_reg =3D RSMU_SABRE_PAGE_ADDR,
> +		.selector_mask =3D 0xFF,
> +		.selector_shift =3D 0,
> +		.window_start =3D 0,
> +		.window_len =3D RSMU_SABRE_PAGE_WINDOW,
> +	}
> +};
> +
> +static bool rsmu_cm_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case RSMU_CM_PAGE_ADDR:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static bool rsmu_sabre_volatile_reg(struct device *dev, unsigned int reg=
)
> +{
> +	switch (reg) {
> +	case RSMU_SABRE_PAGE_ADDR:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct regmap_config rsmu_cm_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0xD000,
> +	.ranges =3D rsmu_cm_range_cfg,
> +	.num_ranges =3D ARRAY_SIZE(rsmu_cm_range_cfg),
> +	.volatile_reg =3D rsmu_cm_volatile_reg,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.can_multi_write =3D true,
> +};
> +
> +static const struct regmap_config rsmu_sabre_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x400,
> +	.ranges =3D rsmu_sabre_range_cfg,
> +	.num_ranges =3D ARRAY_SIZE(rsmu_sabre_range_cfg),
> +	.volatile_reg =3D rsmu_sabre_volatile_reg,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.can_multi_write =3D true,
> +};
> +
> +static const struct regmap_config rsmu_sl_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +	.reg_format_endian =3D REGMAP_ENDIAN_BIG,
> +	.max_register =3D 0x339,
> +	.cache_type =3D REGCACHE_NONE,
> +	.can_multi_write =3D true,
> +};
> +
> +static int rsmu_i2c_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	const struct regmap_config *cfg;
> +	struct rsmu_ddata *rsmu;
> +	int ret;
> +
> +	rsmu =3D devm_kzalloc(&client->dev, sizeof(*rsmu), GFP_KERNEL);
> +	if (!rsmu)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, rsmu);
> +
> +	rsmu->dev =3D &client->dev;
> +	rsmu->type =3D (enum rsmu_type)id->driver_data;
> +
> +	switch (rsmu->type) {
> +	case RSMU_CM:
> +		cfg =3D &rsmu_cm_regmap_config;
> +		break;
> +	case RSMU_SABRE:
> +		cfg =3D &rsmu_sabre_regmap_config;
> +		break;
> +	case RSMU_SL:
> +		cfg =3D &rsmu_sl_regmap_config;
> +		break;
> +	default:
> +		dev_err(rsmu->dev, "Unsupported RSMU device
> type: %d\n", rsmu->type);
> +		return -ENODEV;
> +	}
> +	rsmu->regmap =3D devm_regmap_init_i2c(client, cfg);
> +	if (IS_ERR(rsmu->regmap)) {
> +		ret =3D PTR_ERR(rsmu->regmap);
> +		dev_err(rsmu->dev, "Failed to allocate register map: %d\n",
> ret);
> +		return ret;
> +	}
> +
> +	return rsmu_core_init(rsmu);
> +}
> +
> +static int rsmu_i2c_remove(struct i2c_client *client)
> +{
> +	struct rsmu_ddata *rsmu =3D i2c_get_clientdata(client);
> +
> +	rsmu_core_exit(rsmu);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id rsmu_i2c_id[] =3D {
> +	{ "8a34000",  RSMU_CM },
> +	{ "8a34001",  RSMU_CM },
> +	{ "82p33810", RSMU_SABRE },
> +	{ "82p33811", RSMU_SABRE },
> +	{ "8v19n850", RSMU_SL },
> +	{ "8v19n851", RSMU_SL },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
> +
> +static const struct of_device_id rsmu_i2c_of_match[] =3D {
> +	{ .compatible =3D "idt,8a34000",  .data =3D (void *)RSMU_CM },
> +	{ .compatible =3D "idt,8a34001",  .data =3D (void *)RSMU_CM },
> +	{ .compatible =3D "idt,82p33810", .data =3D (void *)RSMU_SABRE },
> +	{ .compatible =3D "idt,82p33811", .data =3D (void *)RSMU_SABRE },
> +	{ .compatible =3D "idt,8v19n850", .data =3D (void *)RSMU_SL },
> +	{ .compatible =3D "idt,8v19n851", .data =3D (void *)RSMU_SL },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rsmu_i2c_of_match);
> +
> +static struct i2c_driver rsmu_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "rsmu-i2c",
> +		.of_match_table =3D of_match_ptr(rsmu_i2c_of_match),
> +	},
> +	.probe =3D rsmu_i2c_probe,
> +	.remove	=3D rsmu_i2c_remove,
> +	.id_table =3D rsmu_i2c_id,
> +};
> +
> +static int __init rsmu_i2c_init(void)
> +{
> +	return i2c_add_driver(&rsmu_i2c_driver);
> +}
> +subsys_initcall(rsmu_i2c_init);
> +
> +static void __exit rsmu_i2c_exit(void)
> +{
> +	i2c_del_driver(&rsmu_i2c_driver);
> +}
> +module_exit(rsmu_i2c_exit);
> +
> +MODULE_DESCRIPTION("Renesas SMU I2C driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
> new file mode 100644
> index 0000000..fec2b4e
> --- /dev/null
> +++ b/drivers/mfd/rsmu_spi.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SPI driver for Renesas Synchronization Management Unit (SMU) devices.
> + *
> + * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas
> Company.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rsmu.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +
> +#include "rsmu.h"
> +
> +#define	RSMU_CM_PAGE_ADDR		0x7C
> +#define	RSMU_SABRE_PAGE_ADDR		0x7F
> +#define	RSMU_HIGHER_ADDR_MASK		0xFF80
> +#define	RSMU_HIGHER_ADDR_SHIFT		7
> +#define	RSMU_LOWER_ADDR_MASK		0x7F
> +
> +static int rsmu_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf,
> u16 bytes)
> +{
> +	struct spi_device *client =3D to_spi_device(rsmu->dev);
> +	struct spi_transfer xfer =3D {0};
> +	struct spi_message msg;
> +	u8 cmd[256] =3D {0};
> +	u8 rsp[256] =3D {0};
> +	int ret;
> +
> +	cmd[0] =3D reg | 0x80;
> +	xfer.rx_buf =3D rsp;
> +	xfer.len =3D bytes + 1;
> +	xfer.tx_buf =3D cmd;
> +	xfer.bits_per_word =3D client->bits_per_word;
> +	xfer.speed_hz =3D client->max_speed_hz;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	/*
> +	 * 4-wire SPI is a shift register, so for every byte you send,
> +	 * you get one back at the same time. Example read from 0xC024,
> +	 * which has value of 0x2D
> +	 *
> +	 * MOSI:
> +	 *       7C 00 C0 #Set page register
> +	 *       A4 00    #MSB is set, so this is read command
> +	 * MISO:
> +	 *       XX 2D    #XX is a dummy byte from sending A4 and we
> +	 *                 need to throw it away
> +	 */
> +	ret =3D spi_sync(client, &msg);
> +	if (ret >=3D 0)
> +		memcpy(buf, &rsp[1], xfer.len-1);
> +
> +	return ret;
> +}
> +
> +static int rsmu_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf,
> u16 bytes)
> +{
> +	struct spi_device *client =3D to_spi_device(rsmu->dev);
> +	struct spi_transfer xfer =3D {0};
> +	struct spi_message msg;
> +	u8 cmd[256] =3D {0};
> +
> +	cmd[0] =3D reg;
> +	memcpy(&cmd[1], buf, bytes);
> +
> +	xfer.len =3D bytes + 1;
> +	xfer.tx_buf =3D cmd;
> +	xfer.bits_per_word =3D client->bits_per_word;
> +	xfer.speed_hz =3D client->max_speed_hz;
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	return  spi_sync(client, &msg);
> +}
> +
> +/*
> + * 1-byte (1B) offset addressing:
> + * 16-bit register address: the lower 7 bits of the register address com=
e
> + * from the offset addr byte and the upper 9 bits come from the page
> register.
> + */
> +static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u16 reg)
> +{
> +	u8 page_reg;
> +	u8 buf[2];
> +	u16 bytes;
> +	u16 page;
> +	int err;
> +
> +	switch (rsmu->type) {
> +	case RSMU_CM:
> +		page_reg =3D RSMU_CM_PAGE_ADDR;
> +		page =3D reg & RSMU_HIGHER_ADDR_MASK;
> +		buf[0] =3D (u8)(page & 0xff);
> +		buf[1] =3D (u8)((page >> 8) & 0xff);
> +		bytes =3D 2;
> +		break;
> +	case RSMU_SABRE:
> +		page_reg =3D RSMU_SABRE_PAGE_ADDR;
> +		page =3D reg >> RSMU_HIGHER_ADDR_SHIFT;
> +		buf[0] =3D (u8)(page & 0xff);
> +		bytes =3D 1;
> +		break;
> +	default:
> +		dev_err(rsmu->dev, "Unsupported RSMU device
> type: %d\n", rsmu->type);
> +		return -ENODEV;
> +	}
> +
> +	/* Simply return if we are on the same page */
> +	if (rsmu->page =3D=3D page)
> +		return 0;
> +
> +	err =3D rsmu_write_device(rsmu, page_reg, buf, bytes);
> +	if (err)
> +		dev_err(rsmu->dev, "Failed to set page offset 0x%x\n",
> page);
> +	else
> +		/* Remember the last page */
> +		rsmu->page =3D page;
> +
> +	return err;
> +}
> +
> +static int rsmu_reg_read(void *context, unsigned int reg, unsigned int *=
val)
> +{
> +	struct rsmu_ddata *rsmu =3D spi_get_drvdata((struct spi_device
> *)context);
> +	u8 addr =3D (u8)(reg & RSMU_LOWER_ADDR_MASK);
> +	int err;
> +
> +	err =3D rsmu_write_page_register(rsmu, reg);
> +	if (err)
> +		return err;
> +
> +	err =3D rsmu_read_device(rsmu, addr, (u8 *)val, 1);
> +	if (err)
> +		dev_err(rsmu->dev, "Failed to read offset address 0x%x\n",
> addr);
> +
> +	return err;
> +}
> +
> +static int rsmu_reg_write(void *context, unsigned int reg, unsigned int =
val)
> +{
> +	struct rsmu_ddata *rsmu =3D spi_get_drvdata((struct spi_device
> *)context);
> +	u8 addr =3D (u8)(reg & RSMU_LOWER_ADDR_MASK);
> +	u8 data =3D (u8)val;
> +	int err;
> +
> +	err =3D rsmu_write_page_register(rsmu, reg);
> +	if (err)
> +		return err;
> +
> +	err =3D rsmu_write_device(rsmu, addr, &data, 1);
> +	if (err)
> +		dev_err(rsmu->dev,
> +			"Failed to write offset address 0x%x\n", addr);
> +
> +	return err;
> +}
> +
> +static const struct regmap_config rsmu_cm_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +	.max_register =3D 0xD000,
> +	.reg_read =3D rsmu_reg_read,
> +	.reg_write =3D rsmu_reg_write,
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static const struct regmap_config rsmu_sabre_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x400,
> +	.reg_read =3D rsmu_reg_read,
> +	.reg_write =3D rsmu_reg_write,
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static int rsmu_spi_probe(struct spi_device *client)
> +{
> +	const struct spi_device_id *id =3D spi_get_device_id(client);
> +	const struct regmap_config *cfg;
> +	struct rsmu_ddata *rsmu;
> +	int ret;
> +
> +	rsmu =3D devm_kzalloc(&client->dev, sizeof(*rsmu), GFP_KERNEL);
> +	if (!rsmu)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(client, rsmu);
> +
> +	rsmu->dev =3D &client->dev;
> +	rsmu->type =3D (enum rsmu_type)id->driver_data;
> +
> +	/* Initialize regmap */
> +	switch (rsmu->type) {
> +	case RSMU_CM:
> +		cfg =3D &rsmu_cm_regmap_config;
> +		break;
> +	case RSMU_SABRE:
> +		cfg =3D &rsmu_sabre_regmap_config;
> +		break;
> +	default:
> +		dev_err(rsmu->dev, "Unsupported RSMU device
> type: %d\n", rsmu->type);
> +		return -ENODEV;
> +	}
> +
> +	rsmu->regmap =3D devm_regmap_init(&client->dev, NULL, client, cfg);
> +	if (IS_ERR(rsmu->regmap)) {
> +		ret =3D PTR_ERR(rsmu->regmap);
> +		dev_err(rsmu->dev, "Failed to allocate register map: %d\n",
> ret);
> +		return ret;
> +	}
> +
> +	return rsmu_core_init(rsmu);
> +}
> +
> +static int rsmu_spi_remove(struct spi_device *client)
> +{
> +	struct rsmu_ddata *rsmu =3D spi_get_drvdata(client);
> +
> +	rsmu_core_exit(rsmu);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id rsmu_spi_id[] =3D {
> +	{ "8a34000",  RSMU_CM },
> +	{ "8a34001",  RSMU_CM },
> +	{ "82p33810", RSMU_SABRE },
> +	{ "82p33811", RSMU_SABRE },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, rsmu_spi_id);
> +
> +static const struct of_device_id rsmu_spi_of_match[] =3D {
> +	{ .compatible =3D "idt,8a34000",  .data =3D (void *)RSMU_CM },
> +	{ .compatible =3D "idt,8a34001",  .data =3D (void *)RSMU_CM },
> +	{ .compatible =3D "idt,82p33810", .data =3D (void *)RSMU_SABRE },
> +	{ .compatible =3D "idt,82p33811", .data =3D (void *)RSMU_SABRE },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rsmu_spi_of_match);
> +
> +static struct spi_driver rsmu_spi_driver =3D {
> +	.driver =3D {
> +		.name =3D "rsmu-spi",
> +		.of_match_table =3D of_match_ptr(rsmu_spi_of_match),
> +	},
> +	.probe =3D rsmu_spi_probe,
> +	.remove	=3D rsmu_spi_remove,
> +	.id_table =3D rsmu_spi_id,
> +};
> +
> +static int __init rsmu_spi_init(void)
> +{
> +	return spi_register_driver(&rsmu_spi_driver);
> +}
> +subsys_initcall(rsmu_spi_init);
> +
> +static void __exit rsmu_spi_exit(void)
> +{
> +	spi_unregister_driver(&rsmu_spi_driver);
> +}
> +module_exit(rsmu_spi_exit);
> +
> +MODULE_DESCRIPTION("Renesas SMU SPI driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/idt82p33_reg.h
> b/include/linux/mfd/idt82p33_reg.h
> new file mode 100644
> index 0000000..129a6c0
> --- /dev/null
> +++ b/include/linux/mfd/idt82p33_reg.h
> @@ -0,0 +1,112 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Register Map - Based on
> AN888_SMUforIEEE_SynchEther_82P33xxx_RevH.pdf
> + *
> + * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas
> Company.
> + */
> +#ifndef HAVE_IDT82P33_REG
> +#define HAVE_IDT82P33_REG
> +
> +/* Register address */
> +#define DPLL1_TOD_CNFG 0x134
> +#define DPLL2_TOD_CNFG 0x1B4
> +
> +#define DPLL1_TOD_STS 0x10B
> +#define DPLL2_TOD_STS 0x18B
> +
> +#define DPLL1_TOD_TRIGGER 0x115
> +#define DPLL2_TOD_TRIGGER 0x195
> +
> +#define DPLL1_OPERATING_MODE_CNFG 0x120
> +#define DPLL2_OPERATING_MODE_CNFG 0x1A0
> +
> +#define DPLL1_HOLDOVER_FREQ_CNFG 0x12C
> +#define DPLL2_HOLDOVER_FREQ_CNFG 0x1AC
> +
> +#define DPLL1_PHASE_OFFSET_CNFG 0x143
> +#define DPLL2_PHASE_OFFSET_CNFG 0x1C3
> +
> +#define DPLL1_SYNC_EDGE_CNFG 0x140
> +#define DPLL2_SYNC_EDGE_CNFG 0x1C0
> +
> +#define DPLL1_INPUT_MODE_CNFG 0x116
> +#define DPLL2_INPUT_MODE_CNFG 0x196
> +
> +#define DPLL1_OPERATING_STS 0x102
> +#define DPLL2_OPERATING_STS 0x182
> +
> +#define DPLL1_CURRENT_FREQ_STS 0x103
> +#define DPLL2_CURRENT_FREQ_STS 0x183
> +
> +#define REG_SOFT_RESET 0X381
> +
> +#define OUT_MUX_CNFG(outn) REG_ADDR(0x6, (0xC * (outn)))
> +
> +/* Register bit definitions */
> +#define SYNC_TOD BIT(1)
> +#define PH_OFFSET_EN BIT(7)
> +#define SQUELCH_ENABLE BIT(5)
> +
> +/* Bit definitions for the DPLL_MODE register */
> +#define PLL_MODE_SHIFT		(0)
> +#define PLL_MODE_MASK		(0x1F)
> +#define COMBO_MODE_EN		BIT(5)
> +#define COMBO_MODE_SHIFT	(6)
> +#define COMBO_MODE_MASK		(0x3)
> +
> +/* Bit definitions for DPLL_OPERATING_STS register */
> +#define OPERATING_STS_MASK	(0x7)
> +#define OPERATING_STS_SHIFT	(0x0)
> +
> +/* Bit definitions for DPLL_TOD_TRIGGER register */
> +#define READ_TRIGGER_MASK	(0xF)
> +#define READ_TRIGGER_SHIFT	(0x0)
> +#define WRITE_TRIGGER_MASK	(0xF0)
> +#define WRITE_TRIGGER_SHIFT	(0x4)
> +
> +/* Bit definitions for REG_SOFT_RESET register */
> +#define SOFT_RESET_EN		BIT(7)
> +
> +enum pll_mode {
> +	PLL_MODE_MIN =3D 0,
> +	PLL_MODE_AUTOMATIC =3D PLL_MODE_MIN,
> +	PLL_MODE_FORCE_FREERUN =3D 1,
> +	PLL_MODE_FORCE_HOLDOVER =3D 2,
> +	PLL_MODE_FORCE_LOCKED =3D 4,
> +	PLL_MODE_FORCE_PRE_LOCKED2 =3D 5,
> +	PLL_MODE_FORCE_PRE_LOCKED =3D 6,
> +	PLL_MODE_FORCE_LOST_PHASE =3D 7,
> +	PLL_MODE_DCO =3D 10,
> +	PLL_MODE_WPH =3D 18,
> +	PLL_MODE_MAX =3D PLL_MODE_WPH,
> +};
> +
> +enum hw_tod_trig_sel {
> +	HW_TOD_TRIG_SEL_MIN =3D 0,
> +	HW_TOD_TRIG_SEL_NO_WRITE =3D HW_TOD_TRIG_SEL_MIN,
> +	HW_TOD_TRIG_SEL_NO_READ =3D HW_TOD_TRIG_SEL_MIN,
> +	HW_TOD_TRIG_SEL_SYNC_SEL =3D 1,
> +	HW_TOD_TRIG_SEL_IN12 =3D 2,
> +	HW_TOD_TRIG_SEL_IN13 =3D 3,
> +	HW_TOD_TRIG_SEL_IN14 =3D 4,
> +	HW_TOD_TRIG_SEL_TOD_PPS =3D 5,
> +	HW_TOD_TRIG_SEL_TIMER_INTERVAL =3D 6,
> +	HW_TOD_TRIG_SEL_MSB_PHASE_OFFSET_CNFG =3D 7,
> +	HW_TOD_TRIG_SEL_MSB_HOLDOVER_FREQ_CNFG =3D 8,
> +	HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG =3D 9,
> +	HW_TOD_RD_TRIG_SEL_LSB_TOD_STS =3D
> HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
> +	WR_TRIG_SEL_MAX =3D HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
> +};
> +
> +/** @brief Enumerated type listing DPLL operational modes */
> +enum dpll_state {
> +	DPLL_STATE_FREERUN =3D 1,
> +	DPLL_STATE_HOLDOVER =3D 2,
> +	DPLL_STATE_LOCKED =3D 4,
> +	DPLL_STATE_PRELOCKED2 =3D 5,
> +	DPLL_STATE_PRELOCKED =3D 6,
> +	DPLL_STATE_LOSTPHASE =3D 7,
> +	DPLL_STATE_MAX
> +};
> +
> +#endif
> diff --git a/include/linux/mfd/idt8a340_reg.h
> b/include/linux/mfd/idt8a340_reg.h
> new file mode 100644
> index 0000000..92d7632
> --- /dev/null
> +++ b/include/linux/mfd/idt8a340_reg.h
> @@ -0,0 +1,729 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Based on 5.2.0, Family Programming Guide (Sept 30, 2020)
> + *
> + * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas
> Company.
> + */
> +#ifndef HAVE_IDT8A340_REG
> +#define HAVE_IDT8A340_REG
> +
> +#define PAGE_ADDR_BASE                    0x0000
> +#define PAGE_ADDR                         0x00fc
> +
> +#define HW_REVISION                       0x8180
> +#define REV_ID                            0x007a
> +
> +#define HW_DPLL_0                         (0x8a00)
> +#define HW_DPLL_1                         (0x8b00)
> +#define HW_DPLL_2                         (0x8c00)
> +#define HW_DPLL_3                         (0x8d00)
> +#define HW_DPLL_4                         (0x8e00)
> +#define HW_DPLL_5                         (0x8f00)
> +#define HW_DPLL_6                         (0x9000)
> +#define HW_DPLL_7                         (0x9100)
> +
> +#define HW_DPLL_TOD_SW_TRIG_ADDR__0       (0x080)
> +#define HW_DPLL_TOD_CTRL_1                (0x089)
> +#define HW_DPLL_TOD_CTRL_2                (0x08A)
> +#define HW_DPLL_TOD_OVR__0                (0x098)
> +#define HW_DPLL_TOD_OUT_0__0              (0x0B0)
> +
> +#define HW_Q0_Q1_CH_SYNC_CTRL_0           (0xa740)
> +#define HW_Q0_Q1_CH_SYNC_CTRL_1           (0xa741)
> +#define HW_Q2_Q3_CH_SYNC_CTRL_0           (0xa742)
> +#define HW_Q2_Q3_CH_SYNC_CTRL_1           (0xa743)
> +#define HW_Q4_Q5_CH_SYNC_CTRL_0           (0xa744)
> +#define HW_Q4_Q5_CH_SYNC_CTRL_1           (0xa745)
> +#define HW_Q6_Q7_CH_SYNC_CTRL_0           (0xa746)
> +#define HW_Q6_Q7_CH_SYNC_CTRL_1           (0xa747)
> +#define HW_Q8_CH_SYNC_CTRL_0              (0xa748)
> +#define HW_Q8_CH_SYNC_CTRL_1              (0xa749)
> +#define HW_Q9_CH_SYNC_CTRL_0              (0xa74a)
> +#define HW_Q9_CH_SYNC_CTRL_1              (0xa74b)
> +#define HW_Q10_CH_SYNC_CTRL_0             (0xa74c)
> +#define HW_Q10_CH_SYNC_CTRL_1             (0xa74d)
> +#define HW_Q11_CH_SYNC_CTRL_0             (0xa74e)
> +#define HW_Q11_CH_SYNC_CTRL_1             (0xa74f)
> +
> +#define SYNC_SOURCE_DPLL0_TOD_PPS	0x14
> +#define SYNC_SOURCE_DPLL1_TOD_PPS	0x15
> +#define SYNC_SOURCE_DPLL2_TOD_PPS	0x16
> +#define SYNC_SOURCE_DPLL3_TOD_PPS	0x17
> +
> +#define SYNCTRL1_MASTER_SYNC_RST	BIT(7)
> +#define SYNCTRL1_MASTER_SYNC_TRIG	BIT(5)
> +#define SYNCTRL1_TOD_SYNC_TRIG		BIT(4)
> +#define SYNCTRL1_FBDIV_FRAME_SYNC_TRIG	BIT(3)
> +#define SYNCTRL1_FBDIV_SYNC_TRIG	BIT(2)
> +#define SYNCTRL1_Q1_DIV_SYNC_TRIG	BIT(1)
> +#define SYNCTRL1_Q0_DIV_SYNC_TRIG	BIT(0)
> +
> +#define HW_Q8_CTRL_SPARE  (0xa7d4)
> +#define HW_Q11_CTRL_SPARE (0xa7ec)
> +
> +/**
> + * Select FOD5 as sync_trigger for Q8 divider.
> + * Transition from logic zero to one
> + * sets trigger to sync Q8 divider.
> + *
> + * Unused when FOD4 is driving Q8 divider (normal operation).
> + */
> +#define Q9_TO_Q8_SYNC_TRIG  BIT(1)
> +
> +/**
> + * Enable FOD5 as driver for clock and sync for Q8 divider.
> + * Enable fanout buffer for FOD5.
> + *
> + * Unused when FOD4 is driving Q8 divider (normal operation).
> + */
> +#define Q9_TO_Q8_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK  (BIT(0) |
> BIT(2))
> +
> +/**
> + * Select FOD6 as sync_trigger for Q11 divider.
> + * Transition from logic zero to one
> + * sets trigger to sync Q11 divider.
> + *
> + * Unused when FOD7 is driving Q11 divider (normal operation).
> + */
> +#define Q10_TO_Q11_SYNC_TRIG  BIT(1)
> +
> +/**
> + * Enable FOD6 as driver for clock and sync for Q11 divider.
> + * Enable fanout buffer for FOD6.
> + *
> + * Unused when FOD7 is driving Q11 divider (normal operation).
> + */
> +#define Q10_TO_Q11_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK  (BIT(0)
> | BIT(2))
> +
> +#define RESET_CTRL                        0xc000
> +#define SM_RESET                          0x0012
> +#define SM_RESET_V520                     0x0013
> +#define SM_RESET_CMD                      0x5A
> +
> +#define GENERAL_STATUS                    0xc014
> +#define BOOT_STATUS                       0x0000
> +#define HW_REV_ID                         0x000A
> +#define BOND_ID                           0x000B
> +#define HW_CSR_ID                         0x000C
> +#define HW_IRQ_ID                         0x000E
> +#define MAJ_REL                           0x0010
> +#define MIN_REL                           0x0011
> +#define HOTFIX_REL                        0x0012
> +#define PIPELINE_ID                       0x0014
> +#define BUILD_ID                          0x0018
> +#define JTAG_DEVICE_ID                    0x001c
> +#define PRODUCT_ID                        0x001e
> +#define OTP_SCSR_CONFIG_SELECT            0x0022
> +
> +#define STATUS                            0xc03c
> +#define DPLL0_STATUS			  0x0018
> +#define DPLL1_STATUS			  0x0019
> +#define DPLL2_STATUS			  0x001a
> +#define DPLL3_STATUS			  0x001b
> +#define DPLL4_STATUS			  0x001c
> +#define DPLL5_STATUS			  0x001d
> +#define DPLL6_STATUS			  0x001e
> +#define DPLL7_STATUS			  0x001f
> +#define DPLL_SYS_STATUS                   0x0020
> +#define DPLL_SYS_APLL_STATUS              0x0021
> +#define DPLL0_FILTER_STATUS               0x0044
> +#define DPLL1_FILTER_STATUS               0x004c
> +#define DPLL2_FILTER_STATUS               0x0054
> +#define DPLL3_FILTER_STATUS               0x005c
> +#define DPLL4_FILTER_STATUS               0x0064
> +#define DPLL5_FILTER_STATUS               0x006c
> +#define DPLL6_FILTER_STATUS               0x0074
> +#define DPLL7_FILTER_STATUS               0x007c
> +#define DPLLSYS_FILTER_STATUS             0x0084
> +#define USER_GPIO0_TO_7_STATUS            0x008a
> +#define USER_GPIO8_TO_15_STATUS           0x008b
> +
> +#define GPIO_USER_CONTROL                 0xc160
> +#define GPIO0_TO_7_OUT                    0x0000
> +#define GPIO8_TO_15_OUT                   0x0001
> +#define GPIO0_TO_7_OUT_V520               0x0002
> +#define GPIO8_TO_15_OUT_V520              0x0003
> +
> +#define STICKY_STATUS_CLEAR               0xc164
> +
> +#define GPIO_TOD_NOTIFICATION_CLEAR       0xc16c
> +
> +#define ALERT_CFG                         0xc188
> +
> +#define SYS_DPLL_XO                       0xc194
> +
> +#define SYS_APLL                          0xc19c
> +
> +#define INPUT_0                           0xc1b0
> +#define INPUT_1                           0xc1c0
> +#define INPUT_2                           0xc1d0
> +#define INPUT_3                           0xc200
> +#define INPUT_4                           0xc210
> +#define INPUT_5                           0xc220
> +#define INPUT_6                           0xc230
> +#define INPUT_7                           0xc240
> +#define INPUT_8                           0xc250
> +#define INPUT_9                           0xc260
> +#define INPUT_10                          0xc280
> +#define INPUT_11                          0xc290
> +#define INPUT_12                          0xc2a0
> +#define INPUT_13                          0xc2b0
> +#define INPUT_14                          0xc2c0
> +#define INPUT_15                          0xc2d0
> +
> +#define REF_MON_0                         0xc2e0
> +#define REF_MON_1                         0xc2ec
> +#define REF_MON_2                         0xc300
> +#define REF_MON_3                         0xc30c
> +#define REF_MON_4                         0xc318
> +#define REF_MON_5                         0xc324
> +#define REF_MON_6                         0xc330
> +#define REF_MON_7                         0xc33c
> +#define REF_MON_8                         0xc348
> +#define REF_MON_9                         0xc354
> +#define REF_MON_10                        0xc360
> +#define REF_MON_11                        0xc36c
> +#define REF_MON_12                        0xc380
> +#define REF_MON_13                        0xc38c
> +#define REF_MON_14                        0xc398
> +#define REF_MON_15                        0xc3a4
> +
> +#define DPLL_0                            0xc3b0
> +#define DPLL_CTRL_REG_0                   0x0002
> +#define DPLL_CTRL_REG_1                   0x0003
> +#define DPLL_CTRL_REG_2                   0x0004
> +#define DPLL_TOD_SYNC_CFG                 0x0031
> +#define DPLL_COMBO_SLAVE_CFG_0            0x0032
> +#define DPLL_COMBO_SLAVE_CFG_1            0x0033
> +#define DPLL_SLAVE_REF_CFG                0x0034
> +#define DPLL_REF_MODE                     0x0035
> +#define DPLL_PHASE_MEASUREMENT_CFG        0x0036
> +#define DPLL_MODE                         0x0037
> +#define DPLL_MODE_V520                    0x003B
> +#define DPLL_1                            0xc400
> +#define DPLL_2                            0xc438
> +#define DPLL_2_V520                       0xc43c
> +#define DPLL_3                            0xc480
> +#define DPLL_4                            0xc4b8
> +#define DPLL_4_V520                       0xc4bc
> +#define DPLL_5                            0xc500
> +#define DPLL_6                            0xc538
> +#define DPLL_6_V520                       0xc53c
> +#define DPLL_7                            0xc580
> +#define SYS_DPLL                          0xc5b8
> +#define SYS_DPLL_V520                     0xc5bc
> +
> +#define DPLL_CTRL_0                       0xc600
> +#define DPLL_CTRL_DPLL_MANU_REF_CFG       0x0001
> +#define DPLL_CTRL_DPLL_FOD_FREQ           0x001c
> +#define DPLL_CTRL_COMBO_MASTER_CFG        0x003a
> +#define DPLL_CTRL_1                       0xc63c
> +#define DPLL_CTRL_2                       0xc680
> +#define DPLL_CTRL_3                       0xc6bc
> +#define DPLL_CTRL_4                       0xc700
> +#define DPLL_CTRL_5                       0xc73c
> +#define DPLL_CTRL_6                       0xc780
> +#define DPLL_CTRL_7                       0xc7bc
> +#define SYS_DPLL_CTRL                     0xc800
> +
> +#define DPLL_PHASE_0                      0xc818
> +/* Signed 42-bit FFO in units of 2^(-53) */
> +#define DPLL_WR_PHASE                     0x0000
> +#define DPLL_PHASE_1                      0xc81c
> +#define DPLL_PHASE_2                      0xc820
> +#define DPLL_PHASE_3                      0xc824
> +#define DPLL_PHASE_4                      0xc828
> +#define DPLL_PHASE_5                      0xc82c
> +#define DPLL_PHASE_6                      0xc830
> +#define DPLL_PHASE_7                      0xc834
> +
> +#define DPLL_FREQ_0                       0xc838
> +/* Signed 42-bit FFO in units of 2^(-53) */
> +#define DPLL_WR_FREQ                      0x0000
> +#define DPLL_FREQ_1                       0xc840
> +#define DPLL_FREQ_2                       0xc848
> +#define DPLL_FREQ_3                       0xc850
> +#define DPLL_FREQ_4                       0xc858
> +#define DPLL_FREQ_5                       0xc860
> +#define DPLL_FREQ_6                       0xc868
> +#define DPLL_FREQ_7                       0xc870
> +
> +#define DPLL_PHASE_PULL_IN_0              0xc880
> +#define PULL_IN_OFFSET                    0x0000 /* Signed 32 bit */
> +#define PULL_IN_SLOPE_LIMIT               0x0004 /* Unsigned 24 bit */
> +#define PULL_IN_CTRL                      0x0007
> +#define DPLL_PHASE_PULL_IN_1              0xc888
> +#define DPLL_PHASE_PULL_IN_2              0xc890
> +#define DPLL_PHASE_PULL_IN_3              0xc898
> +#define DPLL_PHASE_PULL_IN_4              0xc8a0
> +#define DPLL_PHASE_PULL_IN_5              0xc8a8
> +#define DPLL_PHASE_PULL_IN_6              0xc8b0
> +#define DPLL_PHASE_PULL_IN_7              0xc8b8
> +
> +#define GPIO_CFG                          0xc8c0
> +#define GPIO_CFG_GBL                      0x0000
> +#define GPIO_0                            0xc8c2
> +#define GPIO_DCO_INC_DEC                  0x0000
> +#define GPIO_OUT_CTRL_0                   0x0001
> +#define GPIO_OUT_CTRL_1                   0x0002
> +#define GPIO_TOD_TRIG                     0x0003
> +#define GPIO_DPLL_INDICATOR               0x0004
> +#define GPIO_LOS_INDICATOR                0x0005
> +#define GPIO_REF_INPUT_DSQ_0              0x0006
> +#define GPIO_REF_INPUT_DSQ_1              0x0007
> +#define GPIO_REF_INPUT_DSQ_2              0x0008
> +#define GPIO_REF_INPUT_DSQ_3              0x0009
> +#define GPIO_MAN_CLK_SEL_0                0x000a
> +#define GPIO_MAN_CLK_SEL_1                0x000b
> +#define GPIO_MAN_CLK_SEL_2                0x000c
> +#define GPIO_SLAVE                        0x000d
> +#define GPIO_ALERT_OUT_CFG                0x000e
> +#define GPIO_TOD_NOTIFICATION_CFG         0x000f
> +#define GPIO_CTRL                         0x0010
> +#define GPIO_CTRL_V520                    0x0011
> +#define GPIO_1                            0xc8d4
> +#define GPIO_2                            0xc8e6
> +#define GPIO_3                            0xc900
> +#define GPIO_4                            0xc912
> +#define GPIO_5                            0xc924
> +#define GPIO_6                            0xc936
> +#define GPIO_7                            0xc948
> +#define GPIO_8                            0xc95a
> +#define GPIO_9                            0xc980
> +#define GPIO_10                           0xc992
> +#define GPIO_11                           0xc9a4
> +#define GPIO_12                           0xc9b6
> +#define GPIO_13                           0xc9c8
> +#define GPIO_14                           0xc9da
> +#define GPIO_15                           0xca00
> +
> +#define OUT_DIV_MUX                       0xca12
> +#define OUTPUT_0                          0xca14
> +#define OUTPUT_0_V520                     0xca20
> +/* FOD frequency output divider value */
> +#define OUT_DIV                           0x0000
> +#define OUT_DUTY_CYCLE_HIGH               0x0004
> +#define OUT_CTRL_0                        0x0008
> +#define OUT_CTRL_1                        0x0009
> +/* Phase adjustment in FOD cycles */
> +#define OUT_PHASE_ADJ                     0x000c
> +#define OUTPUT_1                          0xca24
> +#define OUTPUT_1_V520                     0xca30
> +#define OUTPUT_2                          0xca34
> +#define OUTPUT_2_V520                     0xca40
> +#define OUTPUT_3                          0xca44
> +#define OUTPUT_3_V520                     0xca50
> +#define OUTPUT_4                          0xca54
> +#define OUTPUT_4_V520                     0xca60
> +#define OUTPUT_5                          0xca64
> +#define OUTPUT_5_V520                     0xca80
> +#define OUTPUT_6                          0xca80
> +#define OUTPUT_6_V520                     0xca90
> +#define OUTPUT_7                          0xca90
> +#define OUTPUT_7_V520                     0xcaa0
> +#define OUTPUT_8                          0xcaa0
> +#define OUTPUT_8_V520                     0xcab0
> +#define OUTPUT_9                          0xcab0
> +#define OUTPUT_9_V520                     0xcac0
> +#define OUTPUT_10                         0xcac0
> +#define OUTPUT_10_V520                     0xcad0
> +#define OUTPUT_11                         0xcad0
> +#define OUTPUT_11_V520                    0xcae0
> +
> +#define SERIAL                            0xcae0
> +#define SERIAL_V520                       0xcaf0
> +
> +#define PWM_ENCODER_0                     0xcb00
> +#define PWM_ENCODER_1                     0xcb08
> +#define PWM_ENCODER_2                     0xcb10
> +#define PWM_ENCODER_3                     0xcb18
> +#define PWM_ENCODER_4                     0xcb20
> +#define PWM_ENCODER_5                     0xcb28
> +#define PWM_ENCODER_6                     0xcb30
> +#define PWM_ENCODER_7                     0xcb38
> +#define PWM_DECODER_0                     0xcb40
> +#define PWM_DECODER_1                     0xcb48
> +#define PWM_DECODER_1_V520                0xcb4a
> +#define PWM_DECODER_2                     0xcb50
> +#define PWM_DECODER_2_V520                0xcb54
> +#define PWM_DECODER_3                     0xcb58
> +#define PWM_DECODER_3_V520                0xcb5e
> +#define PWM_DECODER_4                     0xcb60
> +#define PWM_DECODER_4_V520                0xcb68
> +#define PWM_DECODER_5                     0xcb68
> +#define PWM_DECODER_5_V520                0xcb80
> +#define PWM_DECODER_6                     0xcb70
> +#define PWM_DECODER_6_V520                0xcb8a
> +#define PWM_DECODER_7                     0xcb80
> +#define PWM_DECODER_7_V520                0xcb94
> +#define PWM_DECODER_8                     0xcb88
> +#define PWM_DECODER_8_V520                0xcb9e
> +#define PWM_DECODER_9                     0xcb90
> +#define PWM_DECODER_9_V520                0xcba8
> +#define PWM_DECODER_10                    0xcb98
> +#define PWM_DECODER_10_V520               0xcbb2
> +#define PWM_DECODER_11                    0xcba0
> +#define PWM_DECODER_11_V520               0xcbbc
> +#define PWM_DECODER_12                    0xcba8
> +#define PWM_DECODER_12_V520               0xcbc6
> +#define PWM_DECODER_13                    0xcbb0
> +#define PWM_DECODER_13_V520               0xcbd0
> +#define PWM_DECODER_14                    0xcbb8
> +#define PWM_DECODER_14_V520               0xcbda
> +#define PWM_DECODER_15                    0xcbc0
> +#define PWM_DECODER_15_V520               0xcbe4
> +#define PWM_USER_DATA                     0xcbc8
> +#define PWM_USER_DATA_V520                0xcbf0
> +
> +#define TOD_0                             0xcbcc
> +#define TOD_0_V520                        0xcc00
> +/* Enable TOD counter, output channel sync and even-PPS mode */
> +#define TOD_CFG                           0x0000
> +#define TOD_CFG_V520                      0x0001
> +#define TOD_1                             0xcbce
> +#define TOD_1_V520                        0xcc02
> +#define TOD_2                             0xcbd0
> +#define TOD_2_V520                        0xcc04
> +#define TOD_3                             0xcbd2
> +#define TOD_3_V520                        0xcc06
> +
> +#define TOD_WRITE_0                       0xcc00
> +#define TOD_WRITE_0_V520                  0xcc10
> +/* 8-bit subns, 32-bit ns, 48-bit seconds */
> +#define TOD_WRITE                         0x0000
> +/* Counter increments after TOD write is completed */
> +#define TOD_WRITE_COUNTER                 0x000c
> +/* TOD write trigger configuration */
> +#define TOD_WRITE_SELECT_CFG_0            0x000d
> +/* TOD write trigger selection */
> +#define TOD_WRITE_CMD                     0x000f
> +#define TOD_WRITE_1                       0xcc10
> +#define TOD_WRITE_1_V520                  0xcc20
> +#define TOD_WRITE_2                       0xcc20
> +#define TOD_WRITE_2_V520                  0xcc30
> +#define TOD_WRITE_3                       0xcc30
> +#define TOD_WRITE_3_V520                  0xcc40
> +
> +#define TOD_READ_PRIMARY_0                0xcc40
> +#define TOD_READ_PRIMARY_0_V520           0xcc50
> +/* 8-bit subns, 32-bit ns, 48-bit seconds */
> +#define TOD_READ_PRIMARY                  0x0000
> +/* Counter increments after TOD write is completed */
> +#define TOD_READ_PRIMARY_COUNTER          0x000b
> +/* Read trigger configuration */
> +#define TOD_READ_PRIMARY_SEL_CFG_0        0x000c
> +/* Read trigger selection */
> +#define TOD_READ_PRIMARY_CMD              0x000e
> +#define TOD_READ_PRIMARY_CMD_V520         0x000f
> +#define TOD_READ_PRIMARY_1                0xcc50
> +#define TOD_READ_PRIMARY_1_V520           0xcc60
> +#define TOD_READ_PRIMARY_2                0xcc60
> +#define TOD_READ_PRIMARY_2_V520           0xcc80
> +#define TOD_READ_PRIMARY_3                0xcc80
> +#define TOD_READ_PRIMARY_3_V520           0xcc90
> +
> +#define TOD_READ_SECONDARY_0              0xcc90
> +#define TOD_READ_SECONDARY_0_V520         0xcca0
> +#define TOD_READ_SECONDARY_1              0xcca0
> +#define TOD_READ_SECONDARY_1_V520         0xccb0
> +#define TOD_READ_SECONDARY_2              0xccb0
> +#define TOD_READ_SECONDARY_2_V520         0xccc0
> +#define TOD_READ_SECONDARY_3              0xccc0
> +#define TOD_READ_SECONDARY_3_V520         0xccd0
> +
> +#define OUTPUT_TDC_CFG                    0xccd0
> +#define OUTPUT_TDC_CFG_V520               0xcce0
> +#define OUTPUT_TDC_0                      0xcd00
> +#define OUTPUT_TDC_1                      0xcd08
> +#define OUTPUT_TDC_2                      0xcd10
> +#define OUTPUT_TDC_3                      0xcd18
> +#define INPUT_TDC                         0xcd20
> +
> +#define SCRATCH                           0xcf50
> +#define SCRATCH_V520                      0xcf4c
> +
> +#define EEPROM                            0xcf68
> +#define EEPROM_V520                       0xcf64
> +
> +#define OTP                               0xcf70
> +
> +#define BYTE                              0xcf80
> +
> +/* Bit definitions for the MAJ_REL register */
> +#define MAJOR_SHIFT                       (1)
> +#define MAJOR_MASK                        (0x7f)
> +#define PR_BUILD                          BIT(0)
> +
> +/* Bit definitions for the USER_GPIO0_TO_7_STATUS register */
> +#define GPIO0_LEVEL                       BIT(0)
> +#define GPIO1_LEVEL                       BIT(1)
> +#define GPIO2_LEVEL                       BIT(2)
> +#define GPIO3_LEVEL                       BIT(3)
> +#define GPIO4_LEVEL                       BIT(4)
> +#define GPIO5_LEVEL                       BIT(5)
> +#define GPIO6_LEVEL                       BIT(6)
> +#define GPIO7_LEVEL                       BIT(7)
> +
> +/* Bit definitions for the USER_GPIO8_TO_15_STATUS register */
> +#define GPIO8_LEVEL                       BIT(0)
> +#define GPIO9_LEVEL                       BIT(1)
> +#define GPIO10_LEVEL                      BIT(2)
> +#define GPIO11_LEVEL                      BIT(3)
> +#define GPIO12_LEVEL                      BIT(4)
> +#define GPIO13_LEVEL                      BIT(5)
> +#define GPIO14_LEVEL                      BIT(6)
> +#define GPIO15_LEVEL                      BIT(7)
> +
> +/* Bit definitions for the GPIO0_TO_7_OUT register */
> +#define GPIO0_DRIVE_LEVEL                 BIT(0)
> +#define GPIO1_DRIVE_LEVEL                 BIT(1)
> +#define GPIO2_DRIVE_LEVEL                 BIT(2)
> +#define GPIO3_DRIVE_LEVEL                 BIT(3)
> +#define GPIO4_DRIVE_LEVEL                 BIT(4)
> +#define GPIO5_DRIVE_LEVEL                 BIT(5)
> +#define GPIO6_DRIVE_LEVEL                 BIT(6)
> +#define GPIO7_DRIVE_LEVEL                 BIT(7)
> +
> +/* Bit definitions for the GPIO8_TO_15_OUT register */
> +#define GPIO8_DRIVE_LEVEL                 BIT(0)
> +#define GPIO9_DRIVE_LEVEL                 BIT(1)
> +#define GPIO10_DRIVE_LEVEL                BIT(2)
> +#define GPIO11_DRIVE_LEVEL                BIT(3)
> +#define GPIO12_DRIVE_LEVEL                BIT(4)
> +#define GPIO13_DRIVE_LEVEL                BIT(5)
> +#define GPIO14_DRIVE_LEVEL                BIT(6)
> +#define GPIO15_DRIVE_LEVEL                BIT(7)
> +
> +/* Bit definitions for the DPLL_TOD_SYNC_CFG register */
> +#define TOD_SYNC_SOURCE_SHIFT             (1)
> +#define TOD_SYNC_SOURCE_MASK              (0x3)
> +#define TOD_SYNC_EN                       BIT(0)
> +
> +/* Bit definitions for the DPLL_MODE register */
> +#define WRITE_TIMER_MODE                  BIT(6)
> +#define PLL_MODE_SHIFT                    (3)
> +#define PLL_MODE_MASK                     (0x7)
> +#define STATE_MODE_SHIFT                  (0)
> +#define STATE_MODE_MASK                   (0x7)
> +
> +/* Bit definitions for the GPIO_CFG_GBL register */
> +#define SUPPLY_MODE_SHIFT                 (0)
> +#define SUPPLY_MODE_MASK                  (0x3)
> +
> +/* Bit definitions for the GPIO_DCO_INC_DEC register */
> +#define INCDEC_DPLL_INDEX_SHIFT           (0)
> +#define INCDEC_DPLL_INDEX_MASK            (0x7)
> +
> +/* Bit definitions for the GPIO_OUT_CTRL_0 register */
> +#define CTRL_OUT_0                        BIT(0)
> +#define CTRL_OUT_1                        BIT(1)
> +#define CTRL_OUT_2                        BIT(2)
> +#define CTRL_OUT_3                        BIT(3)
> +#define CTRL_OUT_4                        BIT(4)
> +#define CTRL_OUT_5                        BIT(5)
> +#define CTRL_OUT_6                        BIT(6)
> +#define CTRL_OUT_7                        BIT(7)
> +
> +/* Bit definitions for the GPIO_OUT_CTRL_1 register */
> +#define CTRL_OUT_8                        BIT(0)
> +#define CTRL_OUT_9                        BIT(1)
> +#define CTRL_OUT_10                       BIT(2)
> +#define CTRL_OUT_11                       BIT(3)
> +#define CTRL_OUT_12                       BIT(4)
> +#define CTRL_OUT_13                       BIT(5)
> +#define CTRL_OUT_14                       BIT(6)
> +#define CTRL_OUT_15                       BIT(7)
> +
> +/* Bit definitions for the GPIO_TOD_TRIG register */
> +#define TOD_TRIG_0                        BIT(0)
> +#define TOD_TRIG_1                        BIT(1)
> +#define TOD_TRIG_2                        BIT(2)
> +#define TOD_TRIG_3                        BIT(3)
> +
> +/* Bit definitions for the GPIO_DPLL_INDICATOR register */
> +#define IND_DPLL_INDEX_SHIFT              (0)
> +#define IND_DPLL_INDEX_MASK               (0x7)
> +
> +/* Bit definitions for the GPIO_LOS_INDICATOR register */
> +#define REFMON_INDEX_SHIFT                (0)
> +#define REFMON_INDEX_MASK                 (0xf)
> +/* Active level of LOS indicator, 0=3Dlow 1=3Dhigh */
> +#define ACTIVE_LEVEL                      BIT(4)
> +
> +/* Bit definitions for the GPIO_REF_INPUT_DSQ_0 register */
> +#define DSQ_INP_0                         BIT(0)
> +#define DSQ_INP_1                         BIT(1)
> +#define DSQ_INP_2                         BIT(2)
> +#define DSQ_INP_3                         BIT(3)
> +#define DSQ_INP_4                         BIT(4)
> +#define DSQ_INP_5                         BIT(5)
> +#define DSQ_INP_6                         BIT(6)
> +#define DSQ_INP_7                         BIT(7)
> +
> +/* Bit definitions for the GPIO_REF_INPUT_DSQ_1 register */
> +#define DSQ_INP_8                         BIT(0)
> +#define DSQ_INP_9                         BIT(1)
> +#define DSQ_INP_10                        BIT(2)
> +#define DSQ_INP_11                        BIT(3)
> +#define DSQ_INP_12                        BIT(4)
> +#define DSQ_INP_13                        BIT(5)
> +#define DSQ_INP_14                        BIT(6)
> +#define DSQ_INP_15                        BIT(7)
> +
> +/* Bit definitions for the GPIO_REF_INPUT_DSQ_2 register */
> +#define DSQ_DPLL_0                        BIT(0)
> +#define DSQ_DPLL_1                        BIT(1)
> +#define DSQ_DPLL_2                        BIT(2)
> +#define DSQ_DPLL_3                        BIT(3)
> +#define DSQ_DPLL_4                        BIT(4)
> +#define DSQ_DPLL_5                        BIT(5)
> +#define DSQ_DPLL_6                        BIT(6)
> +#define DSQ_DPLL_7                        BIT(7)
> +
> +/* Bit definitions for the GPIO_REF_INPUT_DSQ_3 register */
> +#define DSQ_DPLL_SYS                      BIT(0)
> +#define GPIO_DSQ_LEVEL                    BIT(1)
> +
> +/* Bit definitions for the GPIO_TOD_NOTIFICATION_CFG register */
> +#define DPLL_TOD_SHIFT                    (0)
> +#define DPLL_TOD_MASK                     (0x3)
> +#define TOD_READ_SECONDARY                BIT(2)
> +#define GPIO_ASSERT_LEVEL                 BIT(3)
> +
> +/* Bit definitions for the GPIO_CTRL register */
> +#define GPIO_FUNCTION_EN                  BIT(0)
> +#define GPIO_CMOS_OD_MODE                 BIT(1)
> +#define GPIO_CONTROL_DIR                  BIT(2)
> +#define GPIO_PU_PD_MODE                   BIT(3)
> +#define GPIO_FUNCTION_SHIFT               (4)
> +#define GPIO_FUNCTION_MASK                (0xf)
> +
> +/* Bit definitions for the OUT_CTRL_1 register */
> +#define OUT_SYNC_DISABLE                  BIT(7)
> +#define SQUELCH_VALUE                     BIT(6)
> +#define SQUELCH_DISABLE                   BIT(5)
> +#define PAD_VDDO_SHIFT                    (2)
> +#define PAD_VDDO_MASK                     (0x7)
> +#define PAD_CMOSDRV_SHIFT                 (0)
> +#define PAD_CMOSDRV_MASK                  (0x3)
> +
> +/* Bit definitions for the TOD_CFG register */
> +#define TOD_EVEN_PPS_MODE                 BIT(2)
> +#define TOD_OUT_SYNC_ENABLE               BIT(1)
> +#define TOD_ENABLE                        BIT(0)
> +
> +/* Bit definitions for the TOD_WRITE_SELECT_CFG_0 register */
> +#define WR_PWM_DECODER_INDEX_SHIFT        (4)
> +#define WR_PWM_DECODER_INDEX_MASK         (0xf)
> +#define WR_REF_INDEX_SHIFT                (0)
> +#define WR_REF_INDEX_MASK                 (0xf)
> +
> +/* Bit definitions for the TOD_WRITE_CMD register */
> +#define TOD_WRITE_SELECTION_SHIFT         (0)
> +#define TOD_WRITE_SELECTION_MASK          (0xf)
> +/* 4.8.7 */
> +#define TOD_WRITE_TYPE_SHIFT              (4)
> +#define TOD_WRITE_TYPE_MASK               (0x3)
> +
> +/* Bit definitions for the TOD_READ_PRIMARY_SEL_CFG_0 register */
> +#define RD_PWM_DECODER_INDEX_SHIFT        (4)
> +#define RD_PWM_DECODER_INDEX_MASK         (0xf)
> +#define RD_REF_INDEX_SHIFT                (0)
> +#define RD_REF_INDEX_MASK                 (0xf)
> +
> +/* Bit definitions for the TOD_READ_PRIMARY_CMD register */
> +#define TOD_READ_TRIGGER_MODE             BIT(4)
> +#define TOD_READ_TRIGGER_SHIFT            (0)
> +#define TOD_READ_TRIGGER_MASK             (0xf)
> +
> +/* Bit definitions for the DPLL_CTRL_COMBO_MASTER_CFG register */
> +#define COMBO_MASTER_HOLD                 BIT(0)
> +
> +/* Bit definitions for DPLL_SYS_STATUS register */
> +#define DPLL_SYS_STATE_MASK               (0xf)
> +
> +/* Bit definitions for SYS_APLL_STATUS register */
> +#define SYS_APLL_LOSS_LOCK_LIVE_MASK       BIT(0)
> +#define SYS_APLL_LOSS_LOCK_LIVE_LOCKED     0
> +#define SYS_APLL_LOSS_LOCK_LIVE_UNLOCKED   1
> +
> +/* Bit definitions for the DPLL0_STATUS register */
> +#define DPLL_STATE_MASK                   (0xf)
> +#define DPLL_STATE_SHIFT                  (0x0)
> +
> +/* Values of DPLL_N.DPLL_MODE.PLL_MODE */
> +enum pll_mode {
> +	PLL_MODE_MIN =3D 0,
> +	PLL_MODE_NORMAL =3D PLL_MODE_MIN,
> +	PLL_MODE_WRITE_PHASE =3D 1,
> +	PLL_MODE_WRITE_FREQUENCY =3D 2,
> +	PLL_MODE_GPIO_INC_DEC =3D 3,
> +	PLL_MODE_SYNTHESIS =3D 4,
> +	PLL_MODE_PHASE_MEASUREMENT =3D 5,
> +	PLL_MODE_DISABLED =3D 6,
> +	PLL_MODE_MAX =3D PLL_MODE_DISABLED,
> +};
> +
> +enum hw_tod_write_trig_sel {
> +	HW_TOD_WR_TRIG_SEL_MIN =3D 0,
> +	HW_TOD_WR_TRIG_SEL_MSB =3D HW_TOD_WR_TRIG_SEL_MIN,
> +	HW_TOD_WR_TRIG_SEL_RESERVED =3D 1,
> +	HW_TOD_WR_TRIG_SEL_TOD_PPS =3D 2,
> +	HW_TOD_WR_TRIG_SEL_IRIGB_PPS =3D 3,
> +	HW_TOD_WR_TRIG_SEL_PWM_PPS =3D 4,
> +	HW_TOD_WR_TRIG_SEL_GPIO =3D 5,
> +	HW_TOD_WR_TRIG_SEL_FOD_SYNC =3D 6,
> +	WR_TRIG_SEL_MAX =3D HW_TOD_WR_TRIG_SEL_FOD_SYNC,
> +};
> +
> +enum scsr_read_trig_sel {
> +	/* CANCEL CURRENT TOD READ; MODULE BECOMES IDLE - NO
> TRIGGER OCCURS */
> +	SCSR_TOD_READ_TRIG_SEL_DISABLE =3D 0,
> +	/* TRIGGER IMMEDIATELY */
> +	SCSR_TOD_READ_TRIG_SEL_IMMEDIATE =3D 1,
> +	/* TRIGGER ON RISING EDGE OF INTERNAL TOD PPS SIGNAL */
> +	SCSR_TOD_READ_TRIG_SEL_TODPPS =3D 2,
> +	/* TRGGER ON RISING EDGE OF SELECTED REFERENCE INPUT */
> +	SCSR_TOD_READ_TRIG_SEL_REFCLK =3D 3,
> +	/* TRIGGER ON RISING EDGE OF SELECTED PWM DECODER 1PPS
> OUTPUT */
> +	SCSR_TOD_READ_TRIG_SEL_PWMPPS =3D 4,
> +	SCSR_TOD_READ_TRIG_SEL_RESERVED =3D 5,
> +	/* TRIGGER WHEN WRITE FREQUENCY EVENT OCCURS  */
> +	SCSR_TOD_READ_TRIG_SEL_WRITEFREQUENCYEVENT =3D 6,
> +	/* TRIGGER ON SELECTED GPIO */
> +	SCSR_TOD_READ_TRIG_SEL_GPIO =3D 7,
> +	SCSR_TOD_READ_TRIG_SEL_MAX =3D
> SCSR_TOD_READ_TRIG_SEL_GPIO,
> +};
> +
> +/* Values STATUS.DPLL_SYS_STATUS.DPLL_SYS_STATE */
> +enum dpll_state {
> +	DPLL_STATE_MIN =3D 0,
> +	DPLL_STATE_FREERUN =3D DPLL_STATE_MIN,
> +	DPLL_STATE_LOCKACQ =3D 1,
> +	DPLL_STATE_LOCKREC =3D 2,
> +	DPLL_STATE_LOCKED =3D 3,
> +	DPLL_STATE_HOLDOVER =3D 4,
> +	DPLL_STATE_OPEN_LOOP =3D 5,
> +	DPLL_STATE_MAX =3D DPLL_STATE_OPEN_LOOP,
> +};
> +
> +/* 4.8.7 only */
> +enum scsr_tod_write_trig_sel {
> +	SCSR_TOD_WR_TRIG_SEL_DISABLE =3D 0,
> +	SCSR_TOD_WR_TRIG_SEL_IMMEDIATE =3D 1,
> +	SCSR_TOD_WR_TRIG_SEL_REFCLK =3D 2,
> +	SCSR_TOD_WR_TRIG_SEL_PWMPPS =3D 3,
> +	SCSR_TOD_WR_TRIG_SEL_TODPPS =3D 4,
> +	SCSR_TOD_WR_TRIG_SEL_SYNCFOD =3D 5,
> +	SCSR_TOD_WR_TRIG_SEL_GPIO =3D 6,
> +	SCSR_TOD_WR_TRIG_SEL_MAX =3D SCSR_TOD_WR_TRIG_SEL_GPIO,
> +};
> +
> +/* 4.8.7 only */
> +enum scsr_tod_write_type_sel {
> +	SCSR_TOD_WR_TYPE_SEL_ABSOLUTE =3D 0,
> +	SCSR_TOD_WR_TYPE_SEL_DELTA_PLUS =3D 1,
> +	SCSR_TOD_WR_TYPE_SEL_DELTA_MINUS =3D 2,
> +	SCSR_TOD_WR_TYPE_SEL_MAX =3D
> SCSR_TOD_WR_TYPE_SEL_DELTA_MINUS,
> +};
> +#endif
> diff --git a/include/linux/mfd/rsmu.h b/include/linux/mfd/rsmu.h
> new file mode 100644
> index 0000000..6870de6
> --- /dev/null
> +++ b/include/linux/mfd/rsmu.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Core interface for Renesas Synchronization Management Unit (SMU)
> devices.
> + *
> + * Copyright (C) 2021 Integrated Device Technology, Inc., a Renesas
> Company.
> + */
> +
> +#ifndef __LINUX_MFD_RSMU_H
> +#define __LINUX_MFD_RSMU_H
> +
> +/* The supported devices are ClockMatrix, Sabre and SnowLotus */
> +enum rsmu_type {
> +	RSMU_CM		=3D 0x34000,
> +	RSMU_SABRE	=3D 0x33810,
> +	RSMU_SL		=3D 0x19850,
> +};
> +
> +/**
> + *
> + * struct rsmu_ddata - device data structure for sub devices.
> + *
> + * @dev:    i2c/spi device.
> + * @regmap: i2c/spi bus access.
> + * @lock:   mutex used by sub devices to make sure a series of
> + *          bus access requests are not interrupted.
> + * @type:   RSMU device type.
> + * @page:   i2c/spi bus driver internal use only.
> + */
> +struct rsmu_ddata {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex lock;
> +	enum rsmu_type type;
> +	u16 page;
> +};
> +#endif /*  __LINUX_MFD_RSMU_H */
> --
> 2.7.4

