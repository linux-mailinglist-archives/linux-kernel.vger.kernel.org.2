Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60534F997
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhCaHNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:13:24 -0400
Received: from mail-eopbgr20132.outbound.protection.outlook.com ([40.107.2.132]:9901
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234016AbhCaHMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jjd8K/yGsM25ykGKgX0LwmE4GhCTJ3DSVHGdMgmS4CeXJ01bcLBSUHw62fmy72z9e1OV4fWRoVUAb8FS+aF/w5ppQnpjJ9lxenuyliN6O4ym3usLUV98o7xiAn457soIYmlPH5qPseGmzDkZwVBTMhZkeiqmP89rdVQX+62CTWhzXE0qufOYS3lYr92xiomeQrVre3oS+V3bmPRVwWEQFDRaIrCcs/gTKu/viLMetUjYvzXNpjyBN80SyNpptHzS5xjwjOG4fCLkztfAS/L6Z69iovaFTRK8aODU+lZXB8wdyQbHS8SaPysjGxdBHBOfQ/TuN2AqbU/9VOkOhhlLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wrpRGHWb0aWY+Q8v/l+eVmi6rk2MbnIK1NHx038OU=;
 b=F2FRMlYdZhXU86ln/K9DvYNojVN8Sl09Vgm+UCgo2HVYiwadRifwEOFeUpzINlMJxEqa6rqHWvjoYxt1pxP+xJWNseLMgigwpXL3o/7x3RHAQNpbC8Jt+hbz2feENc1oWr1foEaD+YCIZZtGiWbavt1mBnbb82KQbYyZj91OihdOO84O0bVTyLDh2Pa/EyRVTAdZVO/Tgj1oLV28bD0RKg3HLWz6gG7w1DGJZSYitvjsTTdcyGzznicTKXLcIuIQqzw8b2LMliA3oUASTSdhSYl5b2h9BtpDWffsagKb1nsClQCWpKDJpco/78OL/H2SFFu+XnNgShr8l2a/raSrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wrpRGHWb0aWY+Q8v/l+eVmi6rk2MbnIK1NHx038OU=;
 b=SekKvW8c28Upphk1Mh8JkT8bhdTOBY3z1TaKSM3BCQlPuwp/aIrNba4gBN7RMTq3s8s7A5pHgxmH6qg5O/CiLt7jcAqr3FR7KG3gqRD5/x+HfifuYZZlIeac/PsZBio9bq9ww4okNWYerWuF5hRnQH58TLkrxkCYLzJ6U4NKsLA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2725.eurprd02.prod.outlook.com (2603:10a6:4:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 07:12:49 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f945:54d7:845b:de92]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f945:54d7:845b:de92%6]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 07:12:49 +0000
Subject: Re: [PATCH v2 1/3] mux: gpio: Use bitmap API instead of direct
 assignment
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210330193325.68362-1-andriy.shevchenko@linux.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <983be0af-d4dd-2873-ce63-1c7644b81bac@axentia.se>
Date:   Wed, 31 Mar 2021 09:12:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210330193325.68362-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR09CA0060.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::28) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR09CA0060.eurprd09.prod.outlook.com (2603:10a6:7:3c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 07:12:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56774203-8a01-407c-f950-08d8f414640c
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2725:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2725AA2B880D091C9D7A1F95BC7C9@DB6PR0202MB2725.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhCr3uMriyPUOVejjwU3yD4XCEBlj2RBIAbNWogJWUgEjEdrLtyRPoQhdyHMx/hQfwwXHAFXTet/0Er/eaEhurygNqKJ5cCuv7o4WP7tjqpdhTFI27FAR9yimuXl7uH9xZZMSwgX+0Qmfs1KRpT1iY1pDW05sCTtr/B2H6G6VoaoXpjGULtkyjz2A3QJt8OA+DpTp3XhN7pTIQzVXfBaimQYc/rD3Jckgmmo2VWmdgqQ0f2TVGzQmRCJzzXx6GgceWjDDZsdbiiVSds1HM9DRGj8Md4q5RkS+h2utmvgZ0EgbDj+P02lK7V+at/bwiZywjTt2Uq/5wsBRqfhrDCG5pu8dvBJDDqA0dKRFPQaFQVdfKCPFQNODk3LEfJMdy7i0mglOqSnjz0ZyA0ATHkcPX39DOqQ3Np54DQCmB4eGBr9rIYTV6jld5Nwrked8FQM4mtysCa5LKupB9ZFHXZQKn/C6aSfuk2jHEBFvyP7bbkWjHbY5kJabbhMSvkaog0kmlgoboI0j7Z7TRW/fQBztf8bBdD3p3oZeQ0fCUjXEv1lk7/6iQZacmQu3I+jYzYvP5OrVQeik4x/5seWms+Ki9KmIXei1URGiXkp5mk8LCRn9nvMQek3Z8JffEWkVgb84N5b2vvaWEoKSDghCilLEbboxmeQaILEfQrG49j5KaSEdjf6AmmEOo9F7sZiY6grNJ+Kh/LN1HHzgTxBziNSwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(39830400003)(366004)(376002)(5660300002)(16526019)(31696002)(2906002)(186003)(53546011)(4326008)(26005)(36756003)(31686004)(6486002)(83380400001)(38100700001)(956004)(6916009)(2616005)(8936002)(36916002)(66946007)(66476007)(66556008)(6666004)(478600001)(316002)(16576012)(8676002)(54906003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TmRIUmpCZCtkM21yRzVzVm5qVzBhLzVlY05FcTlyZnlWUVdKV2lxWjlQVWRM?=
 =?utf-8?B?M0RDd2NoVEN0QzNGRTNnNHBYWW12RVZ5bW5kZVFLNFlHN3UxWndHbEp2SXJp?=
 =?utf-8?B?YXVDMTFVMmROMU1HVUtaM0pGUVlOREhhTWcvdXZPclh0b2FQTUxOTDJtYStz?=
 =?utf-8?B?WjVGS2tnVmRNeC8yZG1tVHVORlE3TjFtTk9XWFRKV2RFQ0lyWkpYL2prTFcz?=
 =?utf-8?B?OVFkbVBmU1RIb01sc1d6TlU2NXZXU3BVUFZzalhNTDl1eVBMaEJWSkZkeENp?=
 =?utf-8?B?MXYrazVzY1ltRjJSd3VIellQVkhhclh3a0ZpcXNzRWJ4Nml1SU1XUUd0TGw0?=
 =?utf-8?B?ZjI0VzVJNG5VNHZaaThQRnh5azVEMU05T080RHQvVmZ4MGEzbEJWUnpPVGpv?=
 =?utf-8?B?NGJPanREU214SW04WEREQnBLRGRwQUVxdzNxOTZHSVJhUnFlNjV4OExMaHpq?=
 =?utf-8?B?OEFZQ0R0MjVpaEVCTmszRWoyRUlFTFpyVmI5UW9BTy9DazQ3Q3ZNVHlWVUs0?=
 =?utf-8?B?aGlveXg2cSt2UWJjT2c5eFV5ZjJ3VDZDM0M4UVIzUDlSdmo2RHBkRnF3clQ4?=
 =?utf-8?B?eVRkNVZrUDFicVE2R2gyMHdyem9kMVlyQUlweGErSHA5ZlprMmlkTk5WU1FL?=
 =?utf-8?B?VkQ3RDcrbTMzMW9NMCtUMWtnc2ZJZU95emN1RDFCbFdweFhaVDhhaU44VnI1?=
 =?utf-8?B?NWhLdlMzR1dZMDJFMERxRkVqaXNHM0FvQzV5VjBIR3BkL0FmNnM0YUo4YVRj?=
 =?utf-8?B?Q3ZGeDh5T2dtelliMGxpTlhqK2dFUGwyZU40aUFtOHM5eE9RZTF0MWNlK2Zx?=
 =?utf-8?B?cUFVU3Zoc2hWSiszQVlyeU9URDE5a0UwdkJ3aGoxMFgxaE5DU3Q4Kzl0YWYz?=
 =?utf-8?B?cEdKWmN2NUZJV1FYYlNPN2xWei9KOFIvdG8xSWs3YndkMEdHUlFZYytUeFhm?=
 =?utf-8?B?WG1hdk9BK3RRcVJDMVg1eGNaVnRpSFVtM1ZNSlJFVnN5Z2VOdlhZd3lUY2xS?=
 =?utf-8?B?QkdIWTUyS0srOEdnTzZlT0ZpWjNuMTBsc1AwWnpPTkxnQ3dpcFMrRlBpV2Zz?=
 =?utf-8?B?SHREZHB1a2VjdE1XRmlrZEpVU0NnZGFiNUZJbG5icFJBVmRhcEozekVKbHNF?=
 =?utf-8?B?THNzNHViL3B6R0hNMkZrUlByT0RkNFZjVGdXL1R1eTVMVjFPZTg1SXhrdXNp?=
 =?utf-8?B?SCtPNjMxaVpHVU1LM2g5cm9vUUJ3QkZ0dVhVZzJVTm5zUThMaGFHMDhZNytl?=
 =?utf-8?B?cWZKNHQ4UW5TWXd2RWFxVjhQOXZrTCszenVIdk1NK05RWUNkRERiL0UrQTdG?=
 =?utf-8?B?U0V1QUVEQWl3Rm91MzN6WFF3MDEyeUpQV2JMRno4QWN5RE9ja0txWm5FTmlk?=
 =?utf-8?B?SmRtNHRyQjduaE1DUWZpVDVDSi9zUkVCZy9GUkd0QXpXWEFQdlJZL1ByZngv?=
 =?utf-8?B?RFZLMnRQbktFQzd4TytiTVdTV2Q3ZnNmNUVPc3B3MFlmcUdmTmp0QU5LUC9n?=
 =?utf-8?B?UU9wYWhFd1p0L2VabXlmSXRONUowdjc4dWxQMjAxMWJuYVArK1ZOd3V1R0FZ?=
 =?utf-8?B?cGNwUEpYcURzUWYzS3M4dFdTaHNDRzJOd2l4a3VYanJ2QzNHODBLdC9Gc2gw?=
 =?utf-8?B?eDVhMEJlVWdZSlRScno4MnR1NmNyeVNCVDQ1WXgzQm1wTW5DUkE5OFBVMDBx?=
 =?utf-8?B?eWRDellMNEM5S3UxR3ZkamdWWXVHb0dXUWlvYkZMcHliVXBYVUR6MVpEbWFn?=
 =?utf-8?Q?8SLKTTm8dbpzIFkqmtP7/AybhRiii3wtU2Be/tt?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 56774203-8a01-407c-f950-08d8f414640c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 07:12:49.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bScUn65aN6lXoI9ZcrIU2u261WUdQYqitKVOg3BeNEtKz/Bzu0RQ4OdF9rmeY0P+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

You can pick this series directly, right? I don't feel a compelling need to
add the patches to -next before you take them since they are simple enough...

And drivers/mux is otherwise quiet, as usual.

Cheers,
Peter

On 2021-03-30 21:33, Andy Shevchenko wrote:
> Assigning bitmaps like it's done in the driver might be error prone.
> Fix this by using bitmap API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Peter Rosin <peda@axentia.se>
> ---
> v2: left blank line untouched (Peter)
>  drivers/mux/gpio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
> index 02c1f2c014e8..d1b4aa923657 100644
> --- a/drivers/mux/gpio.c
> +++ b/drivers/mux/gpio.c
> @@ -7,6 +7,7 @@
>   * Author: Peter Rosin <peda@axentia.se>
>   */
>  
> +#include <linux/bitmap.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> @@ -23,8 +24,9 @@ static int mux_gpio_set(struct mux_control *mux, int state)
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
> @@ -71,7 +73,7 @@ static int mux_gpio_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  	WARN_ON(pins != mux_gpio->gpios->ndescs);
> -	mux_chip->mux->states = 1 << pins;
> +	mux_chip->mux->states = BIT(pins);
>  
>  	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
>  	if (ret >= 0 && idle_state != MUX_IDLE_AS_IS) {
> 
