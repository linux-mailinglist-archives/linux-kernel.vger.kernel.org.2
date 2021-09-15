Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D4D40C179
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhIOIPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:15:02 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com ([40.107.22.117]:55841
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237089AbhIOIOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:14:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inGKvqsxqAiIlc0orw9e0P09vA3egthP8wEr4USJmhwtB3858EzTj5QQY/zFW9h4bv1XLI+lO5Uz2CFoLFLpZ1w4Q3Z6b/Jrloj9DtdrmGOVgMvEKEvjm6cM+PdFo5g2BNNCUr0a7Iek1CzhJZSw4m49cTVktfYc3hfi9oFpIB/oaalrnxz/2kR4mrBJEkEB79Hz/NoLUOBcKP4YOAyL2YiKX871Zu+d86JFEbDbybq3clHO826/ELkqxV5sTLT52GI3aD/OkrP+zIscOrHTEeWDAHT23reTwy9jzfAsQ0l5RUWSgMDsrsh468R+2OBJ1WNJqKJ0eMOSG2femNEoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sSKAqkDQTwe211zrbFfw/eBgRMJl3t+iqZ/x+kByZD4=;
 b=fCBDYENd2bEqji9TnplJUjAcIx3iGYms8RTBAjXTaJWhsHPb7O0ejQce92i9Jcq5QZ7Cqa8lKlelGYC0negHfqESMOa4oeoGUR4wpy2IPQlJkZxNNymzh6vU1SlDqR/gxjfXFv3d2kS4PuGHVfkj1TjPws8JDg5722cmOYh06kt30iJQtclBulqneAJ6ZJQYB4PsNavuydKUfGtTXKrJPe9cgv6+Dbpx2P0ytaYWeSZzL/k+bvkXwHfwfnCgV2wnrIQn7Bg+XwAaCpjh2QUREf1IqGLGh7MvJgrSGSkCo9L3W508PNHRHDXxSy/iHGmxM11uhm2P8L8Z9wCExfl9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSKAqkDQTwe211zrbFfw/eBgRMJl3t+iqZ/x+kByZD4=;
 b=hlTaS8v1wxDn1Tmt7SriYIwnQp+Yn21wJKTBtIh4cZG9yKsKTZVhcQts+D4mgR4MQ6GXs5SFNFygwhgGqWoNJdR/WztaXXAeqOhVIpeoTnO4dmNsTeOhAiwhQcbiIrA5FjY7/nGiu2iIUOi0UqCblM6E4uQ+5p5eDLVVEjZYy9Y=
Authentication-Results: biot.com; dkim=none (message not signed)
 header.d=none;biot.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 15 Sep
 2021 08:13:13 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5%7]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 08:13:13 +0000
Message-ID: <879e35bd-55ff-f43d-5780-24918d82bc5a@kontron.de>
Date:   Wed, 15 Sep 2021 10:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] mtd: spinand: Add support for Etron EM73D044VCx
Content-Language: en-US
To:     Bert Vermeulen <bert@biot.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20210908201624.237634-1-bert@biot.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20210908201624.237634-1-bert@biot.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0088.eurprd04.prod.outlook.com
 (2603:10a6:208:be::29) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.31.128] (80.147.118.32) by AM0PR04CA0088.eurprd04.prod.outlook.com (2603:10a6:208:be::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 08:13:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bf2537e-d757-4158-b537-08d97820a9f0
X-MS-TrafficTypeDiagnostic: AM9PR10MB4370:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4370927E846AA74F0D21C218E9DB9@AM9PR10MB4370.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeDmtpIkyZIE/jwbsycuXL9bUc5UEcXfRxixuFJ9Rm0dAhC6m+/T9LnPVy8SrP1cfJFX+ed5ZWBvt5LZg4c3lVL82CPsrbv912rLv3Z6Emuwtgn0F/OgpomaimfryaE3dHuXOglS1hY4ZW6yNnxzZYtyTRyhoiUZ63F67WS2aeqdlHbCxed41vO30eOPtZ5tdM6+H3P45Ybg7mcJRSCNXvG5sWTcwL9FAFsIgv1wk/vOgJOWMKJngWLna8PYfbqnlUoTiBjOrIomcAXiFS8TT9nXggxblfHfzLxN0nMwwAaefPmC3Y+03uwwlynfh7OcaWBdGQAClUZW7kuYOfMzkEuzLaOkGVdpUcl/qP2wBrFGZMk7IB25pAbb5rq9oOOsJr3xpEap16iJPM/XuUSQcdCCXfdz0TrA2zS7T9CxWl6KUPyBLe56uxa6z2wXeaF0MPFg8YXikJ7rCZwUQlKmoB2B+PUWtsO5oBJTMmCMiZl7QPXvks6gxLT5d57xbc+4uv7/lZ1fnmnXZE+7wcoRVIGFwPLIzBFQOsdQMsY9SogOuC/NPWalvPL6wc864gDw6XgoG7lvz8GcvxZMw0CmDTrU7FiKkOCuDKN2t2xmoErw5AwOfsrbpMGrgIiQ+Mf5cXF5kwd+H65fm+8hXdHJiM7EmaGhCC7UgBT5mSiRwuiy0/kRz1UMTNieXBfNIdh0bgbZ5sP90VOVA5KNsUzcFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(186003)(66556008)(7416002)(53546011)(26005)(66476007)(8676002)(31696002)(2906002)(45080400002)(966005)(83380400001)(86362001)(478600001)(44832011)(31686004)(38100700002)(316002)(8936002)(36756003)(110136005)(6486002)(921005)(5660300002)(16576012)(66946007)(956004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmNzamZNUzRBMHhGNWxtbEpldjdKRTBWdUswUEFwOThUYWtXNWNyMUMwVjdD?=
 =?utf-8?B?WWhacnN2aFpjNkZHeTJNZmdVd0w1UHN6MTVydFVhRmZDTVdXQWRsK1c3QXhG?=
 =?utf-8?B?OWtUc2FTRForVlFENkxWaEt2MWpONmlTajZTQnYvMm9YbkxqVWhCSS9POHph?=
 =?utf-8?B?U3Evd1prdjQzVCtxQWZtZC9QQTcrZUxINWZWeHZtTjRMakhlM0MrYTR1S1B1?=
 =?utf-8?B?MW9FUVUvSFVGT3VNaWhuYlVvWUhRSUhyY1JJVnkvN212SGVSZ2RBbitVNWxh?=
 =?utf-8?B?aVhqTkNGQjFKWTdzdG9ROEFwdWh2YzdRVzg1bllPamNKM3NRTDBmSUNlRUh3?=
 =?utf-8?B?Sm9NVzA3RVg3Rnc0UDNjYmtaR0FJZXBOczFXNHdZSkMwRUtuaTdWbWdsU2pI?=
 =?utf-8?B?eFB0Z0pvUE5RK3lueWtQM21uQzJzc29aK3AyUVpQS2NBcFZVdWhPQmJKTUNV?=
 =?utf-8?B?MXYwamZuZ0hrakFMZ2V1d20rV1QwZkVEL1l6NDljZjhqb250ampjSU5aQ1dJ?=
 =?utf-8?B?N3FBbUgxSllOZkdFRFdrc2x0Z01oNlBqc0o3TTlqVVB6NUllbHdjS0JTNWor?=
 =?utf-8?B?aWN1bUNMR05LN2gwRG5Pa3c0RnhQRlBPK2hyMHg1ZzYvZElDQm14RGFhMlZk?=
 =?utf-8?B?enBmUEI4dWZVSU1xS3BSeUxjbSt2TnlNbmNCUllLWC9BdEU3S2x4dmVNMlJh?=
 =?utf-8?B?dENiVHVPME55dU1ITmVTQ3NBamZKd29JUC9naTN4dThVeDFMTHl2cStiTldZ?=
 =?utf-8?B?LzAwUzMveWxIQXR1Qm5wZ2MzMldvb29weTdvdW9YMWhxVWRQSEhLS0FNMUFZ?=
 =?utf-8?B?UnpvcUNmWm9OZmtKLzdDU2hrd1BTV2NlV2N3T0VXWnFRVnNHbUNESzVjaG83?=
 =?utf-8?B?NFlTYzZnSHYwRnRVNlV4VDZHd3c2ZWFUOFJDYjBIZE9xTWUwd0ZxR0UwQW1l?=
 =?utf-8?B?MkJCSXFMdDZHRTNuUDJ1REVaWU1sMXhuS1BDdEpRZ1o0ZlNwMlBFdldVQjJx?=
 =?utf-8?B?ejl0eFY1L0dJa3poanZaV0VjWXB2RUt4cnZiQkNJcWZSOHYvTFBtdmRURXIz?=
 =?utf-8?B?QUNqTXBLZm5BVnhYTUJSK0llM1FZZEx6Z3ZRNFVZUWdHTm9EaU9rWHV0Slgy?=
 =?utf-8?B?OU13UVZyZ2Y3Y0wvTXV2Zk55d0JvRERQNHdNV0d0eGxLUGczdXZnRjZuTjBT?=
 =?utf-8?B?Y2NXbjMwSFN1Vk5BbE5kL0RWYllzNHZxN1JOd3BYeXJQM0dtelFOS25pUy9G?=
 =?utf-8?B?MXNjb0tCbHh4UlhpU3hXbGovSmgvRXBlWHU3SkRxVGdwL0IrQ00vbzhoREpu?=
 =?utf-8?B?c2loWC93ZlNDWHJFS1NhYjdHaWxiemFISnh4QnpESUR1MFgrNzBTbVg4M3Qw?=
 =?utf-8?B?ZmFmb3ZYanQ5ZExrcUtlNnRreGtBUCtXSFVTazMxeG9UZlZGOEVRSzVWamZP?=
 =?utf-8?B?L0h3S25oVzhVZm5zc0VZVVlYTXpZZjhmSW54NkM3eHZqUkxXSFVhMVdBd1ZE?=
 =?utf-8?B?UHQ2S3JsRVhUK3hmeVFKM2ZUaVFRV0hBTHdTUDhxaVMzMURTcW9Ndm1KbHRF?=
 =?utf-8?B?R28rS0ZmL0NVN3VmaGtRNFA1U2NlYjdTVkl4K3NwdmtJbllrS0xmK1pxaURh?=
 =?utf-8?B?VXRSZWZlMEc3NktGUlpyVkZyQVF6QTJCVnAxaGRpbmRmaUNQUWtxVExtZEF1?=
 =?utf-8?B?R3JyczFRdXhTQ3pZNjZqT2p3Rkgvdy9ZNm9kWU9jMTZ6cTc1eVNpVWRvY1JH?=
 =?utf-8?Q?4GoWANU+aXymn/L8QS3BUz/OhCnab2lnZR7qjuk?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf2537e-d757-4158-b537-08d97820a9f0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 08:13:13.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OYX/ph9+pQdhk6fZvmcT9lLvf0hhWcoG+LljuZxtidHaEoY6pwyEtsyld9UtWdRl3u4oHvDriznC0rase68iLjBo1oCq59FreDtPhR5SHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4370
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bert,

On 08.09.21 22:16, Bert Vermeulen wrote:
> This adds a new vendor Etron, and support for a 2Gb chip.
> 
> The datasheet is available at
> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.etron.com%2Fcn%2Fproducts%2FEM73%255B8%255DC%255BD_E_F%255DVC%2520SPI%2520NAND%2520Flash_Promotion_Rev%25201_00A.pdf&amp;data=04%7C01%7Cfrieder.schrempf%40kontron.de%7C871fa2a364d8484bbc0d08d97305f2f4%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637667293724201439%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SeopP6Mvu1CHj6eB22XlO78NGnMc3hCFzM%2F5jKmJZxU%3D&amp;reserved=0
> 
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
> v2:
> - Made ooblayout_free/_ecc depend on chip-specific parameters, instead of
>   hardcoded to this 2Gb chip only
> - Fixed manufacturer ordering
> - Fixed minor formatting issues as reported
> - Removed debug comment
> 
>  drivers/mtd/nand/spi/Makefile |   2 +-
>  drivers/mtd/nand/spi/core.c   |   1 +
>  drivers/mtd/nand/spi/etron.c  | 104 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |   1 +
>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/etron.c
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 9662b9c1d5a9..cc3c4e046ea9 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
> +spinand-objs := core.o etron.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 446ba8d43fbc..2cbf25b8caa2 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -894,6 +894,7 @@ static const struct nand_ops spinand_ops = {
>  };
>  
>  static const struct spinand_manufacturer *spinand_manufacturers[] = {
> +	&etron_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/etron.c b/drivers/mtd/nand/spi/etron.c
> new file mode 100644
> index 000000000000..1a92b9cf3043
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/etron.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_ETRON			0xd5
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int etron_oob_spare(struct mtd_info *mtd)
> +{
> +	if (mtd->size < 0x10000000)
> +		return mtd->oobsize / 2;
> +	else
> +		return mtd->oobsize / 2 + mtd->oobsize / 16;
> +}
> +
> +static int etron_ooblayout_ecc(struct mtd_info *mtd, int section,
> +					struct mtd_oob_region *oobregion)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->offset = etron_oob_spare(mtd);
> +	oobregion->length = mtd->oobsize - oobregion->offset;
> +
> +	return 0;
> +}
> +
> +static int etron_ooblayout_free(struct mtd_info *mtd, int section,
> +			   struct mtd_oob_region *oobregion)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->offset = 2;
> +	oobregion->length = etron_oob_spare(mtd) - 2;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops etron_ooblayout = {
> +	.ecc = etron_ooblayout_ecc,
> +	.free = etron_ooblayout_free,
> +};
> +
> +static int etron_ecc_get_status(struct spinand_device *spinand, u8 status)
> +{
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		/* Between 1-7 bitflips were corrected */
> +		return 7;
> +
> +	case STATUS_ECC_MASK:

I'm not sure if using STATUS_ECC_MASK here to check for the 0b11 pattern
is really a good idea. I'd rather introduce a vendor-specific define for
this as other drivers do (see toshiba.c, paragon.c or gigadevice.c). As
this seems to be a common pattern among vendors we could also think
about introducing a new common flag like STATUS_ECC_HAS_MAX_BITFLIPS or
something like that and use this instead.

> +		/* Maximum bitflips were corrected */
> +		return 8;
> +
> +	case STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct spinand_info etron_spinand_table[] = {
> +	SPINAND_INFO("EM73D044VCx",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x1f),

According to the datasheet, the device id of the EM73D044VCL is 0x2e and
not 0x1f. Am I missing something?

Best regards
Frieder

> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&etron_ooblayout, etron_ecc_get_status)),
> +};
> +
> +static const struct spinand_manufacturer_ops etron_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer etron_spinand_manufacturer = {
> +	.id = SPINAND_MFR_ETRON,
> +	.name = "Etron",
> +	.chips = etron_spinand_table,
> +	.nchips = ARRAY_SIZE(etron_spinand_table),
> +	.ops = &etron_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6988956b8492..d7c0a0439652 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -260,6 +260,7 @@ struct spinand_manufacturer {
>  };
>  
>  /* SPI NAND manufacturers */
> +extern const struct spinand_manufacturer etron_spinand_manufacturer;
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
> 
