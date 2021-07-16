Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41B3CB0DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhGPCs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:48:59 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:18454
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232046AbhGPCs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:48:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbx94SyUqVcO2zOhxJF+ch3+Ar/bdsKpII0R1Odo3B8T1q7sgIt1Lwdn1JMbPRH1NiWh4GFRyWe9m15QuMsoSFs2e3zBHSkDiJHDEj6isSvF/UgIPPkoG94mjyUQ19Nexfa3v4kl+R6LFGDzg8NJf3TbtDD6Te4t7u3/IRqdfhDoh126syTqhzjc7VVbdMZG09tiQF3yCMro/yQoYVoIErpQt2OqeVYf/5oWQpFoWDMEYgW/GnbpbpkSXvvjnfN1z6RMzWAEtNovb73F4tHKv3NE3Fp0mrVby5G6kmKP3EglZiR2axIn+MtR2diEJV+1Gc987mGmMLxyrSTkyFprfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq5MVBDDbywGe5+POO+6W01JHR5x7tcD/V1cNfWQbwk=;
 b=k4dJ4iHk//RPb1G0sHpgf1FJ3Ag8trF7SWNQmyOUcbFwlEWE6ReOAH3joq15swYxftr7FFwEEpxomCvj4TecgnMF0wrD7BxNP66uS6moga/7BoVUWVulWuWIuBniktnVy5gb4NMXw4yxXjg/iuU46c9r6arEX4gnytq2VG1zQVFRQEBLCv5SdxI3KquQUmgIqEo4e8tkbpVD7QtrX7R99TkODT7s0keO9qqiNl+cYTss+sOoAksd+fcZp3oJAOt0oiFaHGYd1vqDj+Ll0MyP5sq9E4m/wK/8ongFU3O1cuHC3GyHzcSqJ/IRlvurJeSwK29pvwvYOX7mzfIKRTmSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq5MVBDDbywGe5+POO+6W01JHR5x7tcD/V1cNfWQbwk=;
 b=ofyXz1CCAc6ha3wcI3mvjiOil/mS7FKRh30yxVho5gHnqoMOvgHvfbphir+tEQWOG9GTLVCx2p6bewTzE5c3g/6LOE75cySFDVzQ4xm5Whev9nQgbMNCwWcrqmTVUomLF6NVA+saGZzxVYaMD8qYjIIfkmTwnijdSnpcnQQ1sPk=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB4454.eurprd04.prod.outlook.com (2603:10a6:20b:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 02:46:00 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27%7]) with mapi id 15.20.4331.023; Fri, 16 Jul 2021
 02:46:00 +0000
Message-ID: <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com>
Subject: Re: [PATCH v1 2/3] clk: fractional-divider: Introduce NO_PRESCALER
 flag
From:   Liu Ying <victor.liu@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Date:   Fri, 16 Jul 2021 10:43:57 +0800
In-Reply-To: <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
         <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0076.apcprd02.prod.outlook.com
 (2603:1096:4:90::16) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by SG2PR02CA0076.apcprd02.prod.outlook.com (2603:1096:4:90::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 02:45:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 234cd87e-fbe7-44a4-7c39-08d94803d86a
X-MS-TrafficTypeDiagnostic: AM6PR04MB4454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB44544DBC8920A05A54140EB298119@AM6PR04MB4454.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYd2oKSZJ/3kFrhQ2KZq1Z8YkoO5fmyW8JiIY++y4rik5R5V2HkXS4SvJwZqACmDcVKJKpXpgb2HaN02JJkfx3u47S9f/Zbdn7B2mnepWKvI19KihhqYq/Ub1lhXl0xTCaZBqdZn4UnxTxddAv3HBPUo9wy7jnwngJPCZMICNV72CRcK9dI61Q3iRCEeeHQHYiVSpR859/dgu1LBlKneRD2JBjRHYEUjR9iMekvBCcDNwLDzwV7ywJK0ItxdothKEPipljYoIEuf+vIOL2qwvfwPRS7uoJFqWEKn6+XFSocfYEWj7dZGtXb2cFwf53G2GskVAKKvLsf3tpjEmnnZet8RLClg8u/RNo6zZvRSJ1XyzhZzEJhKLRRsljDsTQenxnG3W4ksbmLM2BPyUHgX8ubHBu0jedRU/wqYcXXaTuLae1e+QquZ4shgeiXHPi1hbIoCJ6Kx+ixDZtJ8+iu+7J8Am0+Y0YlGlAtFSXmqvR4jy3a0/fr2vhegcTr+0LFtKfSTwgmsQbe2EayTZEmDNOUb+v1wzBzLQoc06II2B9/PUU1DXMmkFtb2Mk3qI/jeqzpBJQR4QW5M74O2LX5FpsoB6STi2KsC043x2hPAkbgK9GcYkQp1Q2mboD++ByGMtd4FpZgvRQ9Q1OhFTd90n+EXXsB+OggbTxlP6GPk9Im2V/xboXLA7FFWbhRvlKeEvfBvESbPd7QR1Te2PgZqHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(366004)(8676002)(66556008)(8936002)(66476007)(478600001)(5660300002)(66946007)(52116002)(6496006)(110136005)(186003)(2906002)(316002)(54906003)(26005)(38350700002)(38100700002)(86362001)(36756003)(6486002)(4326008)(83380400001)(2616005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWh2SHl4S1QwSjRCS2lYYTkxakIxSXdwWXIvV2grQndRWStDUS9sdjJlbWFw?=
 =?utf-8?B?N3VwTXgrQnpUTTNnNUtoUDQ1UlF2WGJ2UzhwRGpMbVFrOXdQaDVpU08wU1pC?=
 =?utf-8?B?UzJHU3B4cCtxM1hZNzFUeXc5bmhhYk5qWjliNEFNOU12M2ZJOGJkbk42VHlL?=
 =?utf-8?B?R1ZZNUhJOGc5VVAzQURjUHplNlMxUXhPOUpVUEtKaGNVU0QzMVMxbGx3Qm5s?=
 =?utf-8?B?Z2U3VG5mK3UzNHdqZEhqZ2huRzU0eGVnWGxCRFFZQTdjNTdPejYyS1IyZHRJ?=
 =?utf-8?B?RWdDVjd3TTArQ0ZBSEhXWHRFdVU2NnhiQXozR0xwb0Vmc1h5SXVkbERaU0g4?=
 =?utf-8?B?d0l2SXhmYnBnZEVUekxoUXJ2czE2TXgxcS9BUlM5SCtlZmtGWDdoekFUZlZK?=
 =?utf-8?B?ZTZaZ3lTZy85N1NuRVlKTjRhUkdIKzVBdFBSUkFodDQzODNtenNCNHpNd0tR?=
 =?utf-8?B?YW0rMUpEUnFtRUxZc05iOEpHYS9Pc0dvc3Q2T01GWGhIVnN0UC9mMllKdUVl?=
 =?utf-8?B?Z2FGSFJGVE1OUysrQUZJVktIWWhjMUc5TFRBSHZGT3FETnUwV0xYUjJWcE9k?=
 =?utf-8?B?Z0NJUFZmenZ3YjBxajNySzJjaUc4ZllOS1J1SnFVRmJLeHRJMFNsVFR0bllw?=
 =?utf-8?B?NDBITkNmY2lJVzJpb2c5V0xveWRNOHJYbWFmcGFYTnVCUHZQUmtRVnYzRE5l?=
 =?utf-8?B?TEtreUFMRTVnMHFpTGplaVFUMVFQRFYrQ3lQalhGL1czc3E2TW9zaVdRektW?=
 =?utf-8?B?eGJDM0lXbVV3RVozQVMyK1paUkdlZk5tK1BiNG1WL25mU3Q3T2xGSHY3SmhN?=
 =?utf-8?B?VUdxVjFSWEIyMWRpRG9YalpZOTJyZVdlMEhabEVCSzdWMmVPYlhRWUlmc0pB?=
 =?utf-8?B?UG8xeFhsUTRVN21YenhIcDhlOEFOeXlCNm14QXVmN1RuMzdGQThkeDA3cm1k?=
 =?utf-8?B?ZGpZSXBmMzdsUThCalZkN2g5SGhkYVdJS2UzbCtXR2thM1EvV3gyd1VmZVN6?=
 =?utf-8?B?M1JZNFFPMzBqU25jN2ZuMWlKZUErYTdrSVNYYXEzZUNNMHBTRTFMdE1KSnNC?=
 =?utf-8?B?SFJ3b2tYS2NJaUFpc21HMWlDSTlxeFRidVpPL25MaG5taUE0SkZqd0Q1S2l1?=
 =?utf-8?B?UFFYd2E3WlkyMEp0eXlleXNDTjc2VFBHVlh3MHJQZTJRTVRGTUhYUUhiQkNl?=
 =?utf-8?B?YjVZNERBTVFsek1SUVdGdTZndDI2ckZIUkRhTFR5MDNVWXliZmFCWEpKS1BO?=
 =?utf-8?B?UUpvVXh0V25TVDNidjkvQ3RiSmpzVnVuZ24rdTZNOVVLOStvcnIvSGUxdmdt?=
 =?utf-8?B?NUpDa3MxRzJGOTdaZEpjZmc4RTlwODM5L3ZGcGowTkFpTFl5T1c1cTZ0eHlT?=
 =?utf-8?B?ZnVDbWk2RmdINi9keVZ2Rm5lUWZCZDdtZ0R0NVRpbUpFMTBScFVibDRCVXdC?=
 =?utf-8?B?Ukp1N09ncHVkMURzeUgydkg2a3VxYXBZSHpnOEErZkdzT0FQNFhEVUxJVWpL?=
 =?utf-8?B?RnNOei8zSzRqazFyK01MSXk3eUtJMVlXeGhSYkIyK2VhTXFzc1VOSTUza1JP?=
 =?utf-8?B?c2dFS2FvOTZUZS9jdHRSWGpUUGFMc0VvbUtqQ2lmelpGLzg5TDlZWFNhMXUx?=
 =?utf-8?B?dU81SWNlK3RqR01nZ0YrZmV1Vkd2eWF0UHRsNmdUejIyN2hBbTlRRCtMdWlu?=
 =?utf-8?B?SUF4eFpFYkxlYzBLT0M1UTdiU3ZaOUszdTVDZ09RSTg5TjQ0QXZkZTVaanp3?=
 =?utf-8?Q?FHTOdvbjvJz5i7wPFK+j/a8CZTYcw+Tvsij+RQj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234cd87e-fbe7-44a4-7c39-08d94803d86a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 02:46:00.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGyyX7Ky+x5Da33rrSisLkwOrflOlFxMntxv83q3WI+2Obl/JIZIGOhXe22jKzulQ8MdiT4RcVoSzuHVMqWuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4454
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:
> The newly introduced flag, when set, makes the flow to skip
> the assumption that the caller will use an additional 2^scale
> prescaler to get the desired clock rate.

Now, I start to be aware of the reason why the "left shifting" is
needed but still not 100% sure that details are all right. IIUC, you
are considering a potential HW prescaler here, while I thought the HW
model is just a fractional divider(M/N) and the driver is fully
agnostic to the potential HW prescaler.

> 
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/clk/clk-fractional-divider.c | 2 +-
>  include/linux/clk-provider.h         | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index 535d299af646..b2f9aae9f172 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -84,7 +84,7 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
>  	 * by (scale - fd->nwidth) bits.
>  	 */
>  	scale = fls_long(*parent_rate / rate - 1);
> -	if (scale > fd->nwidth)
> +	if (scale > fd->nwidth && !(fd->flags & CLK_FRAC_DIVIDER_NO_PRESCALER))
>  		rate <<= scale - fd->nwidth;

First of all, check the CLK_FRAC_DIVIDER_NO_PRESCALER flag for the
entire above snippet of code?

Second and more important, it seems that it would be good to decouple
the prescaler knowledge from this fractional divider clk driver so as
to make it simple(Output rate = (m / n) * parent_rate).  This way, the
CLK_FRAC_DIVIDER_NO_PRESCALER flag is not even needed at the first
place, which means rational_best_approximation() just _directly_
offer best_{numerator,denominator} for all cases.  Further more, is it
possilbe for rational_best_approximation() to make sure there is no
risk of overflow for best_{numerator,denominator}, since
max_{numerator,denominator} are already handed over to
rational_best_approximation()?  Overflowed/unreasonable
best_{numerator,denominator} don't sound like the "best" offered value.
If that's impossible, then audit best_{numerator,denominator} after
calling rational_best_approximation()?

Make sense?

Regards,
Liu Ying

>  
>  	rational_best_approximation(rate, *parent_rate,
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index d83b829305c0..f74d0afe275f 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1001,6 +1001,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
>   * CLK_FRAC_DIVIDER_BIG_ENDIAN - By default little endian register accesses are
>   *	used for the divider register.  Setting this flag makes the register
>   *	accesses big endian.
> + * CLK_FRAC_DIVIDER_NO_PRESCALER - By default the resulting rate may be shifted
> + *	left by a few bits in case when the asked one is quite small to satisfy
> + *	the desired range of denominator. If the caller wants to get the best
> + *	rate without using an additional prescaler, this flag may be set.
>   */
>  struct clk_fractional_divider {
>  	struct clk_hw	hw;
> @@ -1022,6 +1026,7 @@ struct clk_fractional_divider {
>  
>  #define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
>  #define CLK_FRAC_DIVIDER_BIG_ENDIAN		BIT(1)
> +#define CLK_FRAC_DIVIDER_NO_PRESCALER		BIT(2)
>  
>  extern const struct clk_ops clk_fractional_divider_ops;
>  struct clk *clk_register_fractional_divider(struct device *dev,

