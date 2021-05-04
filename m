Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BBE3728D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhEDK0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:26:23 -0400
Received: from mail-db8eur05on2136.outbound.protection.outlook.com ([40.107.20.136]:14544
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230153AbhEDK0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:26:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba+2TTQ5YqYrA3bXPGEtojET/zQNXt+HGi4M2J5Rrf78TQyJ18KjazM5h/yST2rY4fCOQIGdVD6PSMpLUWwXEsvd90nVTygZQs2uBMhqPOt9O9w1Zzb1StUCinMKTWGU9y7xkloyH0UPd392jioW31SoRVNvIb56/cXKs7gdenNafgB3DymiMqHNOeoNeACKvCpO80QayiZLYZbh5JaxzBBRaMny9JmrXvT2+89P1+NpIBvnt3dSUh06e0UgqZ8eRdliifvC5vMc8XPw+IB2hjAd4qtc0QgGTvGENZp9Imla1IUrGlRWVBhqMXZ7EpBIcbHA7pup3piFkTT5oSo8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeDXaaOQbgfhbNJ6Rs76NG1K3oIS9143j6eY9am+iiM=;
 b=LCqLS7pOI/BrAp+Gt9fEzsuTCT1Aooi12OD+fzVABmEY1SYfsBn8nfJhdGJ3UlCYiZio9seoHvHErxY8F9emSbDQPF3Q9VRqhhov/K+LGotILTLUO/q8suZQo/p0wPv71fceLua8fjh2zUzL7hbFZt1V2SeIRV1NBSp1QGckCP1FvwxFrgSosAa5oLV3oBRdXOwR8WnE99awarI00tF1aBQhv+XRrMvIvgw7ReYzELy/MQnDnTEx91HdzddUneHIBE5bGxSUkhywxVMsEKnZjLVpf3GG8S9khiPhn/pAuo7UVBLO5fJNHuJFXecO7MyGQN55HoCMerCJeyYvH+NR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeDXaaOQbgfhbNJ6Rs76NG1K3oIS9143j6eY9am+iiM=;
 b=Yk0g/366YFHGIAP9KXUe2AmlgHMAmCRRcKITIuq4nnRs/9oEZlucBVG6Ltv9c07iLUtm/SWMCRfAeH5fcauAuFe0CbQfBhkQEZ9neUpukhjOuxZGEfQA7BXg1lCYh/3e5Ypp51YZihh/RfwNtSSjKy/Zwry9NoHLDAQVAU8Kd3A=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 10:25:23 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 10:25:23 +0000
Subject: Re: [PATCH V2 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
 <20210430052746.10815-5-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <a175b195-d7dc-8865-304e-9c3a5795f6f6@kontron.de>
Date:   Tue, 4 May 2021 12:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210430052746.10815-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.177.213]
X-ClientProxiedBy: AM6P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::47) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.177.213) by AM6P195CA0034.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 10:25:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26389b9b-5e18-45b4-78e4-08d90ee6ed21
X-MS-TrafficTypeDiagnostic: AM8PR10MB4625:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4625AFB8D031D707E0D10641E95A9@AM8PR10MB4625.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9kKIRm8Ohy7fdHLd/AeU6+8rvgHm3j+dlcn2Mkj1VoWrwhNLbE9I7OP7v6074C72U1Po7D8e/+AncMPN0KPFUdo1GXx0g/okHixiyD/RrcsGb1Z41/IPGyOZ2s5aXY0WeS1HNTT1T1YDuccUZiL1wdyCo+DC+w4aIQJQ9kJ0wuwC3Tp9WlY5NzwUi97CcVhtzWA5XqZ1lYsIecK4SmrQdZYek9rGR4WYuBJ8YwcRjxFvf1TgkkXpOfwWxKDCIcmYrQoFwO7PVsSzzmT0mYf7gkmZTHuKxTZklu9KTlQ9NVxLLho41yIuQmsc8eukvy+xDe9M4VaGag/NP0vGp7alEJSJpyTLlVVRkf5JUoAccRl9hksbPKV3NEIfVk0Paplq4R7hOalkYOwChHczSMBpVbbiak23I6XJo9d4Ptg9SWLZVqhrshAE1acr6AYE6Zu0Dz9LVkwswpUw1WMRk9WUm84ucQjC6xbHwToDVDNC/fMcKCFSnuQkuow1ALU/59sirEQzq0QqVxHrR4r2JRSnRSM5yHuW7fwezqbwvsvlbRT6o/To/iApOdvRurwWHI0WHemCuBkUFSZO+pj/DWs2sGmgv+GzJ1klxYBv60jlIWqA5WSWIvbfFg0EsSOifmAeWYgwUboKoRjrEM4slW3CVXHJWIIp2gvthHLjE7R7m6qlm8qczLtHrJPPET5q7ZR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(7416002)(4326008)(6486002)(31696002)(66476007)(498600001)(5660300002)(66946007)(2906002)(66556008)(16526019)(956004)(186003)(36756003)(26005)(53546011)(31686004)(38100700002)(8676002)(2616005)(16576012)(8936002)(44832011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TVlrdFNiUzU4ZExYcUNlMXhRSHNaRWtiR2F5bTFpR3YvSVhCcUREbC9VeGFq?=
 =?utf-8?B?b3YwYllzK0lUM0cwbEgvWDBmbXJyczVmK3RuQlRFeURNcjFoS0JibzNpMHhj?=
 =?utf-8?B?Sm0yb3M2Q1VvMXNQVVlDYlp1eDAyZGFnRi9LVUxBUXc5MVBDdURYN01rZ09k?=
 =?utf-8?B?d3FVV0xaV1VOZ2lkbVV0bHcrdlFsOXRjYlR0ODRqL2NocDVyS1dxQnNCamN6?=
 =?utf-8?B?RUhDNTdpV3pQa0h1ZEo0NnhUa2JtZzl5RU1KNVJNbkl4b1d4bzJtR1EwdzBy?=
 =?utf-8?B?bzhYRFhkNHhYZFZTQW5ONjRkaElNamVnSDl5eThaWWtNY201cW9GYjBUYTNt?=
 =?utf-8?B?NHM2Z1F6eVNrN3pWQnF6SnhpamNjRWczL2tkcHpnRmxHM21JeTN3RnJ3NnFW?=
 =?utf-8?B?UVhiWjFPODVSOHVhV0ZuVElZQkNMcnBKbTYyTHhxN1h3eDZnT254ZGdVMFl4?=
 =?utf-8?B?Smp4bmxSSkZQeE41Q0pKTnJJVXh3MFQ5STFrOGlhN09RdGM5OU5YWmxpOWVu?=
 =?utf-8?B?dUtvWWpnUmprQ3pBQ0wxeXRSdlU4MStMaFBPMURBN29jTVhadCtiaFFlY2JO?=
 =?utf-8?B?bHdrMExxb2tTSHl2ZENrbTgwMUEwK2J0YXlHWlRHYmlGRllZOUk5d3lxd1hu?=
 =?utf-8?B?MFJoMm5uM2ltMnFtbFNBQzVvQTNIcG10Tm9kUjF4dVdpS3JVelFZN1JJMjJE?=
 =?utf-8?B?OWNwRHBYdUdFMmVjVFpLc0lTTmNnMFRuV1cyZDdibUgvbnBNcGViU0o4UVdM?=
 =?utf-8?B?aW1FWmk0ZjZHbkFNeEI4MHYyL2RsOGcwZHBMQWt4bEdUTmxCRXJMaVZxalZw?=
 =?utf-8?B?VTAxRlZhclo1cFhVTDgvTklnSWU4WmJlSFZKZ3kwbDFycEZvSEdTaFFwTUdw?=
 =?utf-8?B?UVd6OVRDWnJpaGVyeW5OZ2JLZlNxOVBSemhoYzdnaFF3d212emtMTXhhRGpv?=
 =?utf-8?B?UmdrMEM1YzA5Qy9lTURSOW1wUytjUm54NEVldlVqaEtjbHc1WTJKK0VYSVlW?=
 =?utf-8?B?WXFmWFhPb2ZjaFN3VE5McVFjeCsxSVY0eXhCbkZZa3pZQ1NpRmh6VUFuaElr?=
 =?utf-8?B?K2l6TkJkL3doMnN2LzlFSjNVSG96amFVelJQWFZ2dmJlU1BuU3J2TC9idGlM?=
 =?utf-8?B?OXlKUmxCVXMxTE81Z1oxY0lEcjJPZks3VWRPODJhVjZ5NHJlOEZFOU55YkVu?=
 =?utf-8?B?MFFHcjJ3aXF0TEV1MzVLRlVRZzRISG1nWUp1WDFUWEpUbk5SRHlLbGlHNG1U?=
 =?utf-8?B?LzdOOGRHUUJtNlZ1bE1FWWRDbjhseXRNZEJLak0vT0JndHlXUWJyUDlqVWJx?=
 =?utf-8?B?allqaHRYV2JubzdMWktJdWNOTnRidlFUTmdWNlRLNWlBUUpNZE40M1Z4SVVO?=
 =?utf-8?B?MlJqOW1JRFZhclV5R2ZDSGFFV0xEU1E4RkRxRGJlZDQyY1dFYkQxOUFCR0dD?=
 =?utf-8?B?U2tOT3JEZmxmeG43Tmsraytzd1I4cmtnUGROMDVyRmZ2TmN3VTdXOFV3Rm00?=
 =?utf-8?B?eUJLZmZRT3hSdGtyMC9tVzBSTXNSVm5ncjFnR3UwemEyTXY4SHBOZk53NS92?=
 =?utf-8?B?ajRJek0rWEMzRFFaU3B1T1RzbWJoNGswRU1QMVFrVzlhL1dxSlpjSVFueDBT?=
 =?utf-8?B?djNMMDYxTVpNZFJxcTlaYmVkdzhkK083MUNiS3FFeGYrUkh4TEtkQUNjWERB?=
 =?utf-8?B?b29nT0w2ejV2NjJNbm13YUhWNTZoT0R4UmlLK2pXeTA4clJLSkltOEtBNEl6?=
 =?utf-8?Q?yibW0ugjiLwAFK54rTYq640Sdu7FdFlsWIQ0fxK?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26389b9b-5e18-45b4-78e4-08d90ee6ed21
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 10:25:23.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4Q3jgczwoK4TJb+c12HYfl6E5fM97xO3FvKqfeS/UBvSsxQDWQsbb4pkhwSaAb8bDUgw2+ZWVtlGji9oFCEx4D/k7mCLn52siLop46rwLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4625
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.21 07:27, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
> that support in this driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/soc/imx/Makefile         |   2 +-
>   drivers/soc/imx/blk-ctl-imx8mm.c | 138 +++++++++++++++++++++++++++++++
>   2 files changed, 139 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index d3d2b49a386c..c260b962f495 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>   endif
>   obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>   obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o blk-ctl-imx8mm.o
> diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c b/drivers/soc/imx/blk-ctl-imx8mm.c
> new file mode 100644
> index 000000000000..77e0a5d3fdac
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl-imx8mm.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#include <dt-bindings/clock/imx8mm-clock.h>
> +#include <dt-bindings/power/imx8mm-power.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +
> +#include "blk-ctl.h"
> +
> +#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN			BIT(6)
> +#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN			BIT(5)
> +#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN			BIT(4)
> +#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN			BIT(3)
> +#define MEDIA_BLK_CSI_BRIDGE_SFT_EN				GENMASK(2, 0)
> +
> +#define MEDIA_BLK_BUS_PD_MASK					BIT(12)
> +#define MEDIA_BLK_MIPI_CSI_PD_MASK				GENMASK(11, 10)
> +#define MEDIA_BLK_MIPI_DSI_PD_MASK				GENMASK(9, 8)
> +#define MEDIA_BLK_LCDIF_PD_MASK					GENMASK(7, 6)
> +#define MEDIA_BLK_CSI_BRIDGE_PD_MASK				GENMASK(5, 0)
> +
> +static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] = {
> +	IMX_BLK_CTL_PD("CSI_BRIDGE", "dispmix", IMX8MM_BLK_CTL_DISPMIX_CSI_BRIDGE, 0x4,
> +		       MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
> +		       IMX_BLK_CTL_PD_RESET),
> +	IMX_BLK_CTL_PD("LCDIF", "dispmix", IMX8MM_BLK_CTL_DISPMIX_LCDIF, 0x4,
> +		       MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
> +	IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_DISPMIX_MIPI_DSI, 0x4,
> +		       MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
> +		       IMX_BLK_CTL_PD_RESET),
> +	IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_DISPMIX_MIPI_CSI, 0x4,
> +		       MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
> +		       MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
> +		       IMX_BLK_CTL_PD_RESET)
> +};
> +
> +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
> +	IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_G2_PD, 0x4,
> +		       BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
> +	IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_G1_PD, 0x4,
> +		       BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
> +	IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_H1_PD, 0x4,
> +		       BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET),
> +};
> +
> +static const struct regmap_config imx8mm_blk_ctl_regmap_config = {
> +	.reg_bits		= 32,
> +	.reg_stride		= 4,
> +	.val_bits		= 32,
> +	.max_register		= 0x30,
> +	.fast_io		= true,
> +};
> +
> +static const struct imx_blk_ctl_dev_data imx8mm_vpumix_blk_ctl_dev_data = {
> +	.pds = imx8mm_vpumix_blk_ctl_pds,
> +	.pds_num = ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
> +	.hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, IMX8MM_BLK_CTL_H1_PD, 0x4, BIT(2), 0, BIT(2),
> +				 IMX_BLK_CTL_PD_HANDSHAKE),
> +	.config = imx8mm_blk_ctl_regmap_config,
> +	.active_pd_names = (char*[]){"vpumix", "g1", "g2", "h1"},
> +	.num_active_pd = 4,
> +};
> +
> +static const struct imx_blk_ctl_dev_data imx8mm_dispmix_blk_ctl_dev_data = {
> +	.pds = imx8mm_dispmix_blk_ctl_pds,
> +	.pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
> +	.hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, -1, 0x4, MEDIA_BLK_BUS_PD_MASK, 0,
> +				 MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
> +				 IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET),
> +	.config = imx8mm_blk_ctl_regmap_config,
> +	.active_pd_names = (char*[]){"dispmix", "mipi"},
> +	.num_active_pd = 2,
> +};
> +
> +static int imx8mm_blk_ctl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +	struct regmap *regmap;
> +	struct resource *res;
> +	struct imx_blk_ctl *ctl;
> +	void __iomem *base;
> +
> +	ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
> +	if (!ctl)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);

This could be simplified by using devm_platform_ioremap_resource().

> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &dev_data->config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ctl->regmap = regmap;
> +	ctl->dev = dev;
> +	atomic_set(&ctl->power_count, 0);
> +
> +	ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
> +	if (ctl->num_clks < 0)
> +		return ctl->num_clks;
> +
> +	dev_set_drvdata(dev, ctl);
> +	ctl->dev_data = of_device_get_match_data(dev);
> +
> +	return imx_blk_ctl_register(dev);
> +}
> +
> +static const struct of_device_id imx_blk_ctl_of_match[] = {
> +	{ .compatible = "fsl,imx8mm-vpumix-blk-ctl", .data = &imx8mm_vpumix_blk_ctl_dev_data },
> +	{ .compatible = "fsl,imx8mm-dispmix-blk-ctl", .data = &imx8mm_dispmix_blk_ctl_dev_data },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
> +
> +static struct platform_driver imx_blk_ctl_driver = {
> +	.probe = imx8mm_blk_ctl_probe,
> +	.driver = {
> +		.name = "imx8mm-blk-ctl",
> +		.of_match_table = of_match_ptr(imx_blk_ctl_of_match),
> +		.pm = &imx_blk_ctl_pm_ops,
> +	},
> +};
> +module_platform_driver(imx_blk_ctl_driver);
> 
