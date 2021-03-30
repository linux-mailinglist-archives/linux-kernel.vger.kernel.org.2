Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3034ED3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhC3QLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:11:37 -0400
Received: from mail-eopbgr00125.outbound.protection.outlook.com ([40.107.0.125]:55608
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232134AbhC3QL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:11:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHfh9iP3tgNLDfOefnzeQ0CiV59gkYkeXy8ysyYhDp/wQlHhQdHK9vLTIIE0DXLRnHQIQ9clB8Z+Fqys1SALyApBPcNjGkfC+z/JAJAxVgvY+xHIj7Xooz64ZoIamfgNXypOaWKYj2Z3+ad6P2hJAXlZ7BV4GQItXKPLUY6gQO1DQQHKGC7UHXakCnFTZIEgwxvkYO/kA8y6HPeVrcDD17GVy/0/yYfuIuy15rC0yDo/bqmwT47X57u7ZSKyVMdBmX5kERwY6pxQJIJF8ZSPV7Ixb1LTVn3m57WvphngtSU6Hr3uOBxIoCkTWALQIMLmPYRDzCyj/ghtQowWscyBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMdQu8Y2Y9YwdaQklPaORJmROxfFFbL28vaxN2xZLLk=;
 b=EFIVRihDBZG3rPPEwasFlM/Nh8Q4Q5j5dYWVz8ROjFxaBVAp64hcrzbBYbZFjoj+EVSzQ1DsFcjJQA5zRYWFwVzuC5dPfP+TGvMZjL+vCuBAFpPLwiZc8OWXanq6V0JPcyoyHBOPhUlKpWsv3A4XZezBz+tyrtLJr+6Eu3ar9tpsBKHTiuwWGJOwzRr/6ecZeEHBamHu65OMB8iDNOJ1D10f+GBSrXfONJMdvAHsY4iL/dEenVvFp2NP1cyV95v8UYNDVzTSboxmOkR7oR3pcj6he7acQ3hvc/eYlICyNpfSq+3Y4ESkejKZz1fJ0vT0EpKe1Tcjhc+Ejlgr5tUSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMdQu8Y2Y9YwdaQklPaORJmROxfFFbL28vaxN2xZLLk=;
 b=lGx6sPm5nF0hXxtaVZYXhfmqsv3/8Nd5Hx+b4Mnfc/f1ROz4lFz1jxzFp+QS5Bft2d/+F7VOC3a4a9FroMrEgIgDOtHhPrw1TcNsVGi9MjLVtr1bqgdpAkKSKFNTECbt++J5akylpZuSOkGNmbjxJFIamTAqV023ZTK8dlByWNA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7065.eurprd02.prod.outlook.com (2603:10a6:10:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 16:11:25 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f945:54d7:845b:de92]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f945:54d7:845b:de92%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 16:11:25 +0000
Subject: Re: [PATCH v1 2/3] mux: gpio: Make it OF independent
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
 <20210326172401.33685-2-andriy.shevchenko@linux.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <094336c9-7055-e3bc-f222-bd1d328405de@axentia.se>
Date:   Tue, 30 Mar 2021 18:11:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210326172401.33685-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AM6P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::29) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 16:11:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ba1727-6703-4785-cddd-08d8f3967785
X-MS-TrafficTypeDiagnostic: DB9PR02MB7065:
X-Microsoft-Antispam-PRVS: <DB9PR02MB7065B3C71CD114E4D5DFE644BC7D9@DB9PR02MB7065.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:192;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62p4ygjDY/eTf3YmoIETOoR/eZGhI42bHoq4Zm6U/K8xPiGt4nuysT3B36FMezEKqHgf0rcnWacjyCKcTU6U3Yg7Mkkh9luosqOBPAG7i5TmDvjm23YrM4RSlb6casgMFmiA0vTrVsMDG38DDgakjXfURl3CsyTQOIIwaCbVH24tMt3aieZzEI88810BDxVMr2EYsQXjYC06xOooDy6wLkTMSZB3kxBbXykUxtvUOSwW8B8D8aGZ74BV1+gcNc9IgnP5TcFwGKJRlnJcYQGTQgplhbQxQwdT8RPy7xjriU8fKll/kZukyMOMHZzcYdmghkQUf6E/AcufaQJ4gfOmCDefpi406qYKxvPFf/P/wN+cvWxQSDzDO0+YrBhd01hxdiIuJDKg9RnJxC1QmjvrUrBpW+ow5QpFSXaDdgCUj2RKgSNCtcfkA5YXNsWg8wQiDutDKt7I2HYUO8tq4p67wBrKremALu6noKQ65Jw5vau6YbaU8AxtYKa3ybp0bItDnMomK0NGl5SLCt6bP/yZfCDQG5Ryd+5/CASfMZrH/Gbsop2mYC8WskvP0fuhPoA7rZtX8+zqm5VUwJmfurq9Re/08hfos2A3RT0AH8UCP0J7Gxc+kU3pk8MCSsGpaI1F/U/d3GSZsF7S3aS8LsY9ZCKzgEWMz7HMcZXgkBEPJ20okkCfcmzB8iII7b/HjStZOROJsS2O3zNcjNj9HThiPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(39830400003)(136003)(8936002)(186003)(2616005)(316002)(31686004)(956004)(2906002)(66476007)(36916002)(66946007)(38100700001)(86362001)(83380400001)(478600001)(8676002)(26005)(36756003)(5660300002)(6486002)(31696002)(53546011)(66556008)(16526019)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OFl3WkVWQU91Qy8zY2xGd0ZyZUVOUlZubkY4RjdiQUNmMGRzSHVkZlZjMGpQ?=
 =?utf-8?B?K21uQzIvanNxeDV4K3NVTVBDNDIwV2V2Z1pPUGZJa3FuY21ENlZOUjZlZUhy?=
 =?utf-8?B?enpGTmhSZHRUTXp6QkR4WnlwbzZ5Yit4UlYyNi9SdE9oVE8yUUlqdXBKZmgx?=
 =?utf-8?B?Z0U5eU9PMCsxNEdqQlZLemh1SngyNXBNWVlWL0lPdFVrQUFpNEdVZW9tRWVj?=
 =?utf-8?B?QXVNSnFUMDcvN1M1NGNxUU4xK1dwWnBGOVNrQzdWRE1ZTWwrTk9wby9HVTBP?=
 =?utf-8?B?WStSL0NoVG42VDRzd3BTMENmNmZ0Rjk0UFdUWjhLQStFYlBoTnAvVUtWYjV5?=
 =?utf-8?B?L3AxUmNDaUNBRzI5L0pkS1JrVXFRZWI4SnMzWUVpTTlQV2EraU42ZkxlUXlX?=
 =?utf-8?B?NDVndDNocWZ0aHFZOUdKSUs5SFRzbmdrZG93RmNFeGZNTDlQbDluMXFPWC9L?=
 =?utf-8?B?VEhMb1A2WS8zbjdIZ1JkQ2xtNjEvQjdLNGRzTi9OU3UrZEd0cGFHS1I4ZCtk?=
 =?utf-8?B?eXJoMzk4SFM3ZTY3eU5BY2p4TUlldUtxL2N0WXdDanpvRWQzeVMxY2FRdWZS?=
 =?utf-8?B?alorNTJ2RnpFaEJXNHBURVFxRU16T2QzTG1XVGRrTWtXTDVkOHVGY05TWXph?=
 =?utf-8?B?M3pvU2VOR1F1RDlJYWVLeHpRb3V4eGxxc1hvazBSYjAreU82U01YUW80U3VX?=
 =?utf-8?B?Z1NQc1orcDNzWEEyYWpLWlVwejZSOCtmMGowRnJpbWgzN0xXRkcrRHJzUnFN?=
 =?utf-8?B?UlcyZ24yVFF2d2xjN0E4cHhySVUxYVN4Y0w2L1R1RzBFVU1qcm9kQzNTWlpT?=
 =?utf-8?B?SjMzZlUzOG9OQnRkdlNHVXdkU3ZVNGtzNGFyNWtaSUJ0ZTlTb0FBanlnUjN1?=
 =?utf-8?B?dHRLc29QM2pHS1lmVkhobWFQOWVVdDBMNUV0dEZkSDhJSmlPeU5jZjVPTG1q?=
 =?utf-8?B?Z1VCK1hrU3RlMDloTzcrZ0JrZk5vdGNteHNNZXR5MmYwcVovNWVUTHluTjNI?=
 =?utf-8?B?M2NFSmR4TzNxWGc1UzJTellFYjJEbWtOTVh5OS94QTZ0NTNlbHI3bFBlNmk3?=
 =?utf-8?B?dmtyQloyK0ticFNDb1ZCRnB3YW9LM3lIRm5zK2tybTdqejhPRFNRS005ejFs?=
 =?utf-8?B?Q2ZuM1BBK3dhTGlaNnZRQzRsbTFCVWFYbEtlaURPRkVuSDh3VkZqVmJST2ZD?=
 =?utf-8?B?alBFSDJ3NFZ1U3pQdGs5T25SNzZ4c0tZMjBZR2srZkR1TGFiQUg2dWtxOGU3?=
 =?utf-8?B?dzFxMWlsVUd2b1RyOVA1WnM5UEVTR2J3NmlsM3l1YU9YZVF3K2dwdUNtcGg2?=
 =?utf-8?B?bS9LMWtiVDlENDNKZjJNSXdRUktoa1UydW9EVzFlaGtYZk50K3A5RUVPNXR5?=
 =?utf-8?B?L1kxSlJXWTMxVlViakR0RHdWYno5TGdZQTFnNXdobXp2aDJvbzFHSkErQzN1?=
 =?utf-8?B?NjdLZ0I1dGY3RGxmNTJDbHF5Uno0aTRUaXdvRnMwUW5Od3QzekZqU1A5M0Jx?=
 =?utf-8?B?RnNvSDFveFpNSkRKY25zclp1RDh4cTExdEVhaFdTU2Qwb3MzWVk0N015Umgx?=
 =?utf-8?B?cGhuRWZlMXN2ZTl4N2JEc0ovejNvaDVwaG9tT0MrZ2dJcHArSFB5Qll3RXZP?=
 =?utf-8?B?b3RXQ3A0bWhMSDcvcVF0Nm45N3RjS2pOSkJSTlR6L3k1ZTlJWjBvcHU4V3Rs?=
 =?utf-8?B?cGFZWlpqcWFzZm9wZVpJbUhsNjVYRndzKzZERnNUQ29CMHJBTGJSaEtmT2NE?=
 =?utf-8?Q?udjxy1rAxmqqfW6U+uGZKePCoE1jkrgmYj627LR?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ba1727-6703-4785-cddd-08d8f3967785
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 16:11:24.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9H5Dj/VOwYVJ7PWjFKsCpI3Eh/T5Y9q98Bj5szVtH19qZJ0Z3zr4EMEl8bJDGBN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2021-03-26 18:24, Andy Shevchenko wrote:
> Module doesn't use OF APIs anyhow, make it OF independent by replacing
> headers and dropping useless of_match_ptr() call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mux/gpio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
> index 891ee0274733..e5ef9284e2b4 100644
> --- a/drivers/mux/gpio.c
> +++ b/drivers/mux/gpio.c
> @@ -10,8 +10,8 @@
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>

mod_devicetable.h sorts before module.h. With that changed,

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

>  #include <linux/mux/driver.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  
> @@ -97,7 +97,7 @@ static int mux_gpio_probe(struct platform_device *pdev)
>  static struct platform_driver mux_gpio_driver = {
>  	.driver = {
>  		.name = "gpio-mux",
> -		.of_match_table	= of_match_ptr(mux_gpio_dt_ids),
> +		.of_match_table	= mux_gpio_dt_ids,
>  	},
>  	.probe = mux_gpio_probe,
>  };
> 
