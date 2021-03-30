Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F295034ED46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhC3QNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:13:17 -0400
Received: from mail-eopbgr40106.outbound.protection.outlook.com ([40.107.4.106]:28427
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232001AbhC3QNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDER+yAxv0Fo9Aoc0OokorunSjLYrEMO8UKr+9aL8eXLWf4N2BemeubMLg6UlsnA3Bb65SC/0muh7kSN55H4sSM+Pklcp8pJV42OwUf5xPGds6B8ej2kXJFSsKRkfWZFfzoWSFMjP0IKYTSMqskcddcUDxKuOhrIFzc8ghvbRRHPMfaXxN44AFGyigJzpzg2nJmIcyt5yEZI+u9t3XEpZ2C5er88HLmGO7Pgaaxty7DJDchnPb4jM3wxbOTUji7UYNHtDCRCKbh4gAD5n8BSOCnSoGZhkAXtPt2ktH9ZY9CgrhwyBXtW3csbd0eCHgVNmMRRGHLiovI9qCYjBalH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PoFkhpbE9VLDnyDVid764+3XoazD+gGJAlTHbUQgvw=;
 b=QyDXlzzARkt/yYd/nQqQ8bH9xtb7H/vZPT3gPIY6PUsuHEE/A64QS48Hcfdf/ddUI567AWnZVe6Hb5mKp81JeCXpjaYuRO2UZiDFUK46MR0P94lBvau+cmp/rUERGnTHgvx5+93SzeA67aDnod4KwtJr0TEiI/dAUV1z15zx++YZo8kHi6s1YCdomHBTkdQuHRkbEvP5oBDAcetAG5yvd1bxfVwn340CRuMCY1ClPzI3WF3LxAKJw2CYwVctpRvrEkk5Txkl2pblmTd8lkVmH7AKyr+2gXOyySBT1LZQF/zfCpLq1B188G4d6zgFVcMnAb9iTix+eaRP3wznP1wG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PoFkhpbE9VLDnyDVid764+3XoazD+gGJAlTHbUQgvw=;
 b=Xo3k2KPnnyJ2dZttoxXA7tSqFdH3sVyY/UznECc7i8TEt5LqdR5psRPFKY4xpi0QhaJqjyLsqZcC3jnQS8aZXQdCktqTOah9OPwpeOTkcYJGDQLjoBQDRA1G4xjNUoHQCTQT+raI9prlmL4AC56toV6MoutEodiAw+ozEsRxyDQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4601.eurprd02.prod.outlook.com (2603:10a6:10:60::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 16:13:05 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f945:54d7:845b:de92]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f945:54d7:845b:de92%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 16:13:05 +0000
Subject: Re: [PATCH v1 3/3] mux: gpio: Simplify code by using dev_err_probe()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
 <20210326172401.33685-3-andriy.shevchenko@linux.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b01d838e-e306-389f-cab2-b445fe339250@axentia.se>
Date:   Tue, 30 Mar 2021 18:13:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210326172401.33685-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::33) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0502CA0023.eurprd05.prod.outlook.com (2603:10a6:3:e3::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Tue, 30 Mar 2021 16:13:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f3847e-f262-43f4-02db-08d8f396b36f
X-MS-TrafficTypeDiagnostic: DB7PR02MB4601:
X-Microsoft-Antispam-PRVS: <DB7PR02MB4601D82AACF8F2C9ABD3BE1EBC7D9@DB7PR02MB4601.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:246;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2Z4vhCeZUwnJPHybCcbJH/8u4N/YADe52BlbFKhf3iYPU8ZU+R+P7BHCXjJ3nb+Z+M6YKPgrSGy7CkbsYoJX6SX4Zjbzrwsz3dveSiLjZPz8ErBn53EIcjTf/iK/a+Eor2TQURP1lDYexXzC6EKDHggZ0y7ojqzl2NcyYgjN0mq0Fgd3QED8+0pbs9n4Zluicc8nrgDpuvrApthmAGTS0f+Xp73eP4w5BoFXVwh+hS9F3X+OqX1wcOEzAdy+QpkYjOHN5v3lwfukTIJvKIgNv/QcMBSVW3fH+PuN3n5RVzaJhauCt3bxGLlkqgrkU/DZ5XgJ7u29+2SQ6bwOSN9KeOs7/NKN3gQY7ksUR04TzleeXnD147Af9u4mOulqrPBpLHcHgDgbfBEuvwD2XMoPmXcOAk+hoRt7Kfrm+TGBauzkky77WYVVY/JSfj865ET54MCfbd6h42by9CPEWY0Jv7DYR1p+2ePxR1GG+NyTfGB8rO2ixx0AP3yEvPb8zbrmLxHAHqHdtajkVxIwDjRoWfVp/IsLPnhmvPXcPu9F0zEMB4iUn0W8tN4GwSuV0Pi3fPFzppLLZPFccNjcBerh1Ch1kcnHCaAaf8fkFShAyaalApXFM/tfip99Xf9R0dzuI+rthOfD+N0Q7rXpifjsxv3ytFtteq38210thjeseMHtqEEkAKYhtEN8K8pHhrQcX/OItvLCPRN+5R9baring==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39830400003)(136003)(366004)(478600001)(956004)(5660300002)(2616005)(31686004)(8676002)(66946007)(8936002)(66556008)(16526019)(66476007)(36756003)(38100700001)(36916002)(53546011)(16576012)(83380400001)(2906002)(316002)(86362001)(26005)(31696002)(6486002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OENhdlVhUUd4TXRISzFDU0p2SmNsdUVUY09COExtRGpHc2t1ZjBua0xQK0Iv?=
 =?utf-8?B?RXpKQ1NZQU9oVVhpdTBXbEU1eHk1QnVQVXBGWTg3ODV0cGxJai9oUUVYcFo4?=
 =?utf-8?B?RUYwbjkyRUpQMml1QXYzbmZXYkJDUUtlTU0xS21CcjgzV0R4ZjRaTUU5LzZ4?=
 =?utf-8?B?TmVEZlZxaTNOWngzSDZnbkZyc1pHSXBSVXQ4bXBYS2o1K0F2N3J1MThqS2U3?=
 =?utf-8?B?WmJJR0VGbncvN2ZjQUNwaW1NRmdOZDc1WWZDanlab3Blakt6ZHdzQXgybHps?=
 =?utf-8?B?RmZTYzdoWHEzUzQyWm9wY0lTTU1sTjd5a3VqNElOWDNxV0hhZkRMbVFyWmZz?=
 =?utf-8?B?aTUwOWQxeHRFRTZxV0c4ZXBEMUVwOUlOVmF2YWU2YmFUWHVteUNFQXRKLytp?=
 =?utf-8?B?NnFpZUQyZURWeWJnczZacFRBeWo3dFZYU1hnTURWMEtBWlJYVkVqRjhmY3Z0?=
 =?utf-8?B?eVlBbGVyenpQN29yS1didXJnelBIOHpzdVU5TzVzQXdOZGZ5N2VhVzh3MHpv?=
 =?utf-8?B?ZkhQamUvekxvM0JVZjQweVlJRWxXZUFKUjA1SzRFdzNycXVSOE94eXNjTmxt?=
 =?utf-8?B?bGJzR1A1UW0vYWN1UXBIUWQ5NHdJVXA2bjdPK25MVTJaTlgyMThyVk1HQ0N5?=
 =?utf-8?B?YmFwL3lyT0RBTGMyT09hSVVSLzE5Rit6dFdqN1NPRklBREZsdmhpcnp3N2RP?=
 =?utf-8?B?THNlTW96MGdteTc3c2dkdlV0ZU9ZTHJQNW4vZDRIWmpiUytxdlRUVzNTZlpv?=
 =?utf-8?B?SkdBcmd4K0p3bmlsdVlWYXh3cm9lOGJ1TzFmdFdzMG5kMkNhRHkxclBSWnhZ?=
 =?utf-8?B?djBTMXhBRVdkT1VMRkJGY2huYkhneXZyQzNNWk5COEhsQ1d5M0oyV3hWdXdo?=
 =?utf-8?B?TDkwd0c1bDNxeHQ0aVJsTnlpWDR3OWVJdThxcWxqS3VZNWxJb0VJQW5kOTI4?=
 =?utf-8?B?OTdYRDFpS2tNVXBCTHRXajVMR0tyZHFtMnpFQkI4T3ZhQ0t3L3grNWcvcG5h?=
 =?utf-8?B?VDhxdHhwQ0RqUk8zekhzcVNwc3BXemZxMkVHSUlVNmdESitzOGtSd01VU0VT?=
 =?utf-8?B?eE1zcWZkTWpmbm5XRHhhVmgrMWdiYzRzUU1jSE41ZWtKeFVNZUZVL1lHMEM1?=
 =?utf-8?B?QkRGVmVodjd5WGRvTWZ2R0tEYm5vZFlMSVpoREpKalE5UXpVK1lqQnU0NlNM?=
 =?utf-8?B?NVFYMW1xOXlpRHp2QU53M0tid0VxRmRzYW4zVHozK3d5YTNkSG9WelczSkdB?=
 =?utf-8?B?a0R6Q1cyK1ZvbWtRSjB1dldQc1BEOGczWWVQWDAvZzk4ZkZiTkFCWUR5S0xN?=
 =?utf-8?B?eGFQMzZqNmliNW1iZ0JQYU0xbDRXVDQxYW5ZejJ2dUFIWnBGR2pQaVFEYlpY?=
 =?utf-8?B?RDJldlNIWTZFcExxbEVsZ0hhNzFVNkhDN1pXSkRwKzVWLzdjTXhZVDJBRnNz?=
 =?utf-8?B?OWVhTmFyYnpBMTkxdno4MnI2L0wrWUMyR3NqY21TUXpabXRzS2NJRHJnMXYx?=
 =?utf-8?B?alpSTjEvSjhlbWlQSDBoVXd0UFRRek1yV0ZNb09vdzIzOXZVaFZoZkhmMzJk?=
 =?utf-8?B?V3JwajJ1M2hnZE9jbWdFdXJSQ2VLeTg4MEcxVENrQ3ZFb2ZSTGJpZmV6MlBh?=
 =?utf-8?B?K3l3cnRubGdCc0FSeVgrYjZiYzBzNEcxcFJ4Y2JsMVRjWkxoUjhCSVZBRC8w?=
 =?utf-8?B?VXBZMmRPelVHVkJEQkVwV1o2cHRjamFDbjlXY01sNnBlekFZK3pSRUdYak5j?=
 =?utf-8?Q?zSSys3FG8P1w5TSmMIgoeOJLLfWbInzdQBQUjJs?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f3847e-f262-43f4-02db-08d8f396b36f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 16:13:05.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rgexXukE9RT4vCDV6/yGm7mK6sQq0O1nzgLBDcOZ1FrXHnaYblrVVbumkUcTzDP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4601
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2021-03-26 18:24, Andy Shevchenko wrote:
> Use already prepared dev_err_probe() introduced by the commit
> a787e5400a1c ("driver core: add device probe log helper").
> It simplifies EPROBE_DEFER handling.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mux/gpio.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
> index e5ef9284e2b4..c3036bfffd50 100644
> --- a/drivers/mux/gpio.c
> +++ b/drivers/mux/gpio.c
> @@ -65,12 +65,8 @@ static int mux_gpio_probe(struct platform_device *pdev)
>  	mux_chip->ops = &mux_gpio_ops;
>  
>  	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
> -	if (IS_ERR(mux_gpio->gpios)) {
> -		ret = PTR_ERR(mux_gpio->gpios);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get gpios\n");
> -		return ret;
> -	}
> +	if (IS_ERR(mux_gpio->gpios))
> +		return dev_err_probe(dev, PTR_ERR(mux_gpio->gpios), "failed to get gpios\n");

Please break this line, keeping it as one line does not significantly
increase readability. I know many people think long lines are super
nice, but I'm not sold and am stubbornly sticking to 80 cols. I'd rater
have room for one more window instead of wasting loads of screen on
mostly short lines and a long one here and there. Sorry to be a pest,
but coding-style.rst agrees with me:

"The preferred limit on the length of a single line is 80 columns."

So, with that changed,

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

>  	WARN_ON(pins != mux_gpio->gpios->ndescs);
>  	mux_chip->mux->states = BIT(pins);
>  
> 
