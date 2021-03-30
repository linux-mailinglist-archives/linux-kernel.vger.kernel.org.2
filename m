Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446A34ED3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhC3QLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:11:04 -0400
Received: from mail-eopbgr00092.outbound.protection.outlook.com ([40.107.0.92]:62360
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231794AbhC3QLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V36COB3qO8iOo46uD9mRvxjGwxg3sdo6KQvHA9V3o+ktTlxT894wSxigNfKUXdRv6/cEageplVXf0dFvDjccc3BZF9BcbKC7bsDgzpQk0qmMB0X2cZitpKCxLg7xLCUcjkiOzk+hquLv9P2oYcR4cpQJ9LoEn3WZRv/avi27+IQnWDlZ3Rkq50ubZdf+OmN/ce/7CFADSmqFgULL2TgzrirR1Pd+iDVjdgJKefML1KFzxLmUB+9NNdsVMamrln6WmILFugRMtA5udZSwKcGnt5unQpI4pAWfkVFPmlSVXp5LjIUZ+NsTP2lJMVmJkJ2PdMSVgJQTN0YQf13BY4Aypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA1gmoXVH8fCZhxF2OMcA4537nXXnNfeUNfEsr7bMCE=;
 b=OKg7SH2Tp/ROcjA7wKP1wVWYvVd4+Y/rdmPwIRPhjP39E02fNF+lQfH1iWnFTFGaV2OaJSZ+AlIVG/iqvDX3OQDKZVAuWKXSB+reEwr95F/m2b6rqPlI5xIR989DHwj/kj3yl0moXPbv6B5lOT4T7BjeeHB5WrkmEjkhBZRHbOv65rTr0HuRKl0sp2vmxtinLAvTUzyGygDEkpohBTSGmB7JZvua0LaT+H8/3YaSraIlxZ9mCuuik5PJigWFudATkmK/4Ru/RQ0CJPkVvGSLLkOqllYNTFYObER2dg6cQh8hrDqoUCNFTVI0Mjr4u7cioKTnhd0/ovEgwCvYLMdEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA1gmoXVH8fCZhxF2OMcA4537nXXnNfeUNfEsr7bMCE=;
 b=mhmkPGOJ2/TMxYADXUKpzLOxjaLtqkSsrl8qYwnmlXSZw/wEAJ9GqHdcEVuUmWLtlPRdNYRyitBk7JNuI2PgQwP00dN1XdBeF99LF1gx8laPWHlWxcec38FPbfEtjHO5QE0wmPwArLLNOeWvMV7jYpkLFFYPrRGhOBLMD31YW68=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7065.eurprd02.prod.outlook.com (2603:10a6:10:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 16:11:01 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f945:54d7:845b:de92]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f945:54d7:845b:de92%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 16:11:01 +0000
Subject: Re: [PATCH v1 1/3] mux: gpio: Use bitmap API instead of direct
 assignment
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <76ca2d4e-4c8a-45d2-94cb-77f0aa296daf@axentia.se>
Date:   Tue, 30 Mar 2021 18:10:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AM6P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::31) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 16:11:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa426e9e-eb3d-4d90-bb50-08d8f396691f
X-MS-TrafficTypeDiagnostic: DB9PR02MB7065:
X-Microsoft-Antispam-PRVS: <DB9PR02MB70657130E4586DBDD4D9C712BC7D9@DB9PR02MB7065.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /P7075KeWxIL9VgSu/uivN9/cpxOv0Ssi+ynqKou2CIZvFJ10/3P6minT9Cg+7jJWIWnVgyuMunwm4XQQDH4A3umFWgZufhABMqw6FtJa2AkfTqj3gxM1aG5prju6aVO+9gim9HfgJ8uWwq/pLiJ0B1EI1a+8YbS9pOUhiPShSsmIcsWZd8HjTF2lvpuUNK5pVhBdsjiDZLC6oaNFmfWgWd3CWDCPQvAl5aVwlz1jelHLRAyoEfol9EE2w+gCjSKtnD1v/yQvd3h/Pi9UN4mKvV+JjzoushHnSH+DJoju9qOK4nTiayQGaTiuoB6cHJKVtqZzUAygYFNBXg3q1h0Y0nydldIRJR80T4o83EGiMvRJ05a5vC6QwS4M8FB51sd4YBrUfqV1J8bjG0YrG+fe7217dyWoyu64Nn0iI5Dq20cgLGuVNoUzj1V6puc7Uvx7mfWftDH/vkmFh+qX4RA+NG5grnVQxEVHxcgwaq3tvxVJC5RgcSU2ScMuJwYJ+esrqTswUOctDvEIRaVAMi8u82t0GTM9XZ6yi/n6a542o9eKzx6RkcVmjorlP7jWTWooBx+PenN1eE7lDlJ5+XMr3Hr3VhqWKiV4p1UuXS43DVtPOmhbP60c+iy+HrAuQkXBgWkYBsmwh/N+XhUJ5CIiJwnosoujvqE5smZfH0ml68/cjkjbpk9cWAv9dsSQOB1RsEW+bl04IUx2yp42Ki7yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(39830400003)(136003)(8936002)(186003)(2616005)(316002)(31686004)(956004)(2906002)(66476007)(36916002)(66946007)(38100700001)(86362001)(83380400001)(478600001)(8676002)(26005)(36756003)(5660300002)(6486002)(31696002)(53546011)(66556008)(16526019)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K2hBOGVMUmFWdDVTLzlZSjRNUFRyM1dObjdSMWdHVDdSdjVYRjQ1ZFZ3RUxX?=
 =?utf-8?B?Mmd3S1dCRHJzRkthQmtHa1JvQlo0QzlMS29nZFRIcXI4YlZXZTJBTVg4Q2NT?=
 =?utf-8?B?NjY4ckdJSE5OTFBScGJVbzV2NVEzdVd1aXFURE9RaWY1dTJxSHZvbG9zc1ds?=
 =?utf-8?B?V1Y5R0pLM1gzSkVpb2dBZ29OQXc3cWhPNEZsRlU2S0FDK05pN20rOUp3ZzMz?=
 =?utf-8?B?cWliQUQrc0VaZUoyTlJnUGw2dFRtNGp0cGF3Z2llSmIzS2FEUVVLV2xJT2Zs?=
 =?utf-8?B?QSticXVIbXV6NG9saGthUFFLait3TmJDTnNMUFJkcnVVL0I0UzVwN2toeDBB?=
 =?utf-8?B?dTNGalFqL1BaSncxWEp0K3RSTllYYitVWml3dmVFd0l1Y1l0YlRLNmtOUmx0?=
 =?utf-8?B?VEI2RWRudlp5dWZBNnE5bUo1UUViSW1LUWxHYVhDb3kvT0RhaGhjeS94LzNO?=
 =?utf-8?B?TW9Kd1lTblp6ZW51akh0ZEkyNEMvc041bVRSTVowWEFBUmdrdTl6NlBUVnp6?=
 =?utf-8?B?djExckN0NnpDbm5BNnU0R0xDWDBHd3gyUGhTNFRwSXJMbElsOHVkUFBSRmpM?=
 =?utf-8?B?bFQrUndkZnU5YkpWcHo4bkMvM0lSOTNSWmU0NFNZUExiWWtXM0lKZXlGcTN0?=
 =?utf-8?B?Nk9RQ3BhYjZ0aEcxRllhOVdYcXViM09lQzJZUjNhV0RzRndOZ2Q3SjFQQ2Rj?=
 =?utf-8?B?UnJyNlYyUUw3REZiL09JVldBNWhsQStnQ3hLZ3NnWUhjb003QytIbWpXdUlB?=
 =?utf-8?B?Nmo2ZW5jQmNzU2pPcEhNaFFrNjhjV29QM3NDeVE4eHpkY2FpblY2NmZCK2hT?=
 =?utf-8?B?UytvUnVpSTlvVmdGKzcwQnBJZWR2RGZITkdRUWFKTjdLc041RDJkQVQzaUlt?=
 =?utf-8?B?Ly9rY0FoYUNpd3I1M3JHZEJUNGRHekFHTStEaHJhc1BEWjlNTitDdDZuSCs5?=
 =?utf-8?B?emh6SVFRWmU3ZElqbzA3Rzlqbm4wemttU1B3RFVjUmxYaFZQSWdNbGh4N1g2?=
 =?utf-8?B?bkNBWWhtOXdlcHdjQ2VWWDZ3RHk4MXdCUUxMVFBHNXF0eHYzanNZTUltTzhB?=
 =?utf-8?B?SzJ1R2RWZ01zRlJGMFYvRWZBOWd5NTNubGJRbW9iZC9wcU9nbmtHdlBEWjEx?=
 =?utf-8?B?WHdqR3dab1d6S3NpTDFtSFJhWWZ2V2pLQUoyYWRNOVZ6YWlIa21lQ2dLN2Z6?=
 =?utf-8?B?VGs0Nm5lQUVuK253eTczUEVwVDFYVFFIQ2JmWEoxSWN2T2RRSEdlMXRzWDJC?=
 =?utf-8?B?WFpLMFp4OEFhdTRDTW9nS2dwa3RLMjROb0VYUzl3UXpiWEp5T0JnUkgrQ094?=
 =?utf-8?B?YzY1K0dZNURzMjF1OHh6dHZBZ1VicE1wM0JQNGdOSFVjYnpUMHNXb2Z6cllL?=
 =?utf-8?B?MEZGaUx0UlNmZU56Y0E1d3d1R29PbG95Rzk0UlBBNW5HYXZlazJMQklGL21O?=
 =?utf-8?B?TExEYzlzbkNDQTdpRXJEcHV6UXczd2lzeVJJUzE5N2xYWWxjaFRxb1FDRmFs?=
 =?utf-8?B?Rm5qNGZJRkw1dHhKTDdadnVRUnVOOC9BZWlFcVBtNlJjenNIbTYxK1ZYTlBz?=
 =?utf-8?B?N3hIVGVIMHhSSjMwMjF6VG1tRkg0M2VxWTNCOXZKK0lKZEtyRzkxUStkQVgv?=
 =?utf-8?B?d0FvOE5wWDl4NDdnMFVlZGhjd0JaSlVDNkdyR3lHaDlKWnZ3NnpLMlRjVkVw?=
 =?utf-8?B?WlRRbzdFN05sdFBIZ1hkcGlZQk5DZ1ozK0hXc1V0NzB3UG4xRkVsTnBic2Jz?=
 =?utf-8?Q?t8OYlJPUCjCxtdP1rtaSCIN5YbK8aK2PNgZe8vy?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fa426e9e-eb3d-4d90-bb50-08d8f396691f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 16:11:00.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn19XYHt7Nk6pZpsQa/oWZOIPUBCZ85fZs6jJV71dtQVtyI3fD0l9WLdFQ4NQ18B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2021-03-26 18:23, Andy Shevchenko wrote:
> Assigning bitmaps like it's done in the driver might be error prone.
> Fix this by using bitmap API.

A bit strongly worded perhaps, since the size of a mux chip with
anywhere near 31 inputs and 2^31 possible selections is a bit
ridiculous. Please send a photo of that HW if someone is producing
one :-)

But there's always the someone-borrows-code-factor, so I guess it's
fine as-is.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mux/gpio.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
> index 02c1f2c014e8..891ee0274733 100644
> --- a/drivers/mux/gpio.c
> +++ b/drivers/mux/gpio.c
> @@ -6,7 +6,7 @@
>   *
>   * Author: Peter Rosin <peda@axentia.se>
>   */
> -

Nit, please keep the empty line here. With that,

Acked-by: Peter Rosin <peda@axentia.se>

And please send directly to Greg, that would be excellent, thanks!

Cheers,
Peter

> +#include <linux/bitmap.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> @@ -23,8 +23,9 @@ static int mux_gpio_set(struct mux_control *mux, int state)
>  {
>  	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
>  	DECLARE_BITMAP(values, BITS_PER_TYPE(state));
> +	u32 value = state;
>  
> -	values[0] = state;
> +	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
>  
>  	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
>  				       mux_gpio->gpios->desc,
> @@ -71,7 +72,7 @@ static int mux_gpio_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  	WARN_ON(pins != mux_gpio->gpios->ndescs);
> -	mux_chip->mux->states = 1 << pins;
> +	mux_chip->mux->states = BIT(pins);
>  
>  	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
>  	if (ret >= 0 && idle_state != MUX_IDLE_AS_IS) {
> 
