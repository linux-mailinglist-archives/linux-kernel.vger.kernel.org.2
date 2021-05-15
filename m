Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67259381AD8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhEOTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 15:49:18 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:47685
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231334AbhEOTtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 15:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZzAqouJEjOiZD0kgEFe0X8xSDryrwp10TAktxWcJ7UZo58F9b0VNRfHNyF7z87TLGhljVNg3Xp2S9mj3tyGESY84AXsfF6iDTNFXlG4oneTZknuCPM5iX/gc7ZH+BQ7fzZ2m3BMXaXRCNdKUO97Y7GHAs91yUpwHFh7534PwkoPNukTqmlyExanFZujIGtuwTc+HGXMplPoy+GFmb6Du4vIxYF96/JGLE/XgFL+mWzMUrngFRrvR1yHc4oMMTXxxkWY59XzwmC2l5zAg7sVypyNhi22tlkPyERU+c0V7DWE4hnTY8Bqr34MbfFK6/wMn2bev1daq45ai/zRPJTPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoOyCvyrlU01BhC4tiHWNCek5sDAGsjQI3rLSA0qm6Q=;
 b=KB+v0zxnpmIRQp7UQ/dXsc44+j9neDm4yJVX9h0Z5jVSHPGlgIwOzjl6/snSP2yuSOOOiRBnAVKbqyygLhn/hV/8kVqKV3q0kKjh39fhim1bi0mFapi7ZZOWbKMKKPBTYOxMJ337Jy+9steLBzdQ+gmBV7iMSubFpC95XsCzyxiPE1h9WoM0EWdkJuLQ7wkU00CUqV2XNxmjdiXazFiMPTrqTczna05iuMjipDql9upxlpQ2GpyeSUjTrf8TxAC3zhNqXtrHqyic0w2YfOVPoZvezTyOvLuVgiDpr/rNwJ3tIkgKgEzmaFCtvCMY4Z6GukwtcXqrV6z/w7YCsy3SAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eckelmannde.onmicrosoft.com; s=selector1-eckelmannde-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoOyCvyrlU01BhC4tiHWNCek5sDAGsjQI3rLSA0qm6Q=;
 b=J4iVNkNI/p31n8111E2ttdv2Ztu9y2zvu2t+3J8w0Y6kZ0seldsrqBKSIG8fbP1gmQci/6J0+vb9m94MGQtf1szBfeh8kM9TpxSqZgdz+wYr7/BOKzdA24TRiuMDUEN5dKhwe3q8jgVlHkMrVb6xyXf5q9eZ4pLo1g3rHEdgRls=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=eckelmann.de;
Received: from AM9P189MB1700.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2fc::15)
 by AM9P189MB1617.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Sat, 15 May
 2021 19:48:00 +0000
Received: from AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 ([fe80::596b:839e:9150:5307]) by AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 ([fe80::596b:839e:9150:5307%5]) with mapi id 15.20.4129.031; Sat, 15 May 2021
 19:48:00 +0000
Date:   Sat, 15 May 2021 21:47:57 +0200
From:   Thorsten Scherer <thorsten.scherer@eckelmann.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] siox: Simplify error handling via dev_err_probe()
Message-ID: <20210515194757.fgknanqjhtbl7ydh@ws067.eckelmann.group>
References: <20210515082017.1127580-1-t.scherer@eckelmann.de>
 <20210515180047.mmwhm4wajf6dr4kt@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210515180047.mmwhm4wajf6dr4kt@pengutronix.de>
X-Originating-IP: [2a00:1f08:400:4::2]
X-ClientProxiedBy: PR3P189CA0085.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::30) To AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:2fc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws067.eckelmann.group (2a00:1f08:400:4::2) by PR3P189CA0085.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Sat, 15 May 2021 19:47:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e27332-ccee-4521-6a7e-08d917da5812
X-MS-TrafficTypeDiagnostic: AM9P189MB1617:
X-Microsoft-Antispam-PRVS: <AM9P189MB1617D76FDD46555D87E1B0629F2F9@AM9P189MB1617.EURP189.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TCBjGKntJgClt/Is0SmU3sWyLai8VIae3Ph9jVK+i+bwZ/Sm0JBwDt1ck+363nxvbaeRjvZhOatRhSLAus/JO2hEKFUNRb48Kh4N3j6XIL3evJ6YZ8X1Ssz+Z+DGh51+i5DpUyXRTuq+Tm+u2606ZoxyhXDTxb8+gzITPDf0jWarTPvNzOF7wziW5xMfB6tyAfvU+73Eiv9x2imL1R2MMdGG3jfQ+Ja9FwHfA7alUEMjNlee7WkHfMqODCRodIiVSyB2ffze+3ifv0dI6OB8APPNMLmiYd7epTRnhQqgj7tJ0MOh7H470y+tpkVAi6kC2zr6/G3hDoYFkmy4VvMRTxJwNzK/xeEARNKmeeoolrnUxh1s/M5wDfcjnxvrq5YrgKN8FMjI5glhhGCXaSQ9x0wdXTMpgIM4nrlOQGoqDThijx9R6Ua2cpFhhsT0ef5rMeE25Pdhuj/XaoPbQOf6gz6R53e8wPtrDkX1zq3BVbtH6zktYlQXZ0m/2KvfXsGHPb7g53rLH1eb+Wnz3r+ZpFGbAusTb3rA1nAmZCnKSoJFksqXVHR/9S1HNatcAI2RiqIajd5YpymXIIzQnSC3LYMr4YVVGlyN9G7xAipfWHO96jwXCtM/rsLFdgG85/dOn+BqPbe58C67GnBxcDK4q7k36fuf/mGx8mEruJQ6tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1700.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39830400003)(346002)(136003)(366004)(376002)(52116002)(66574015)(966005)(7696005)(83380400001)(16526019)(186003)(38100700002)(478600001)(9686003)(8676002)(55016002)(8936002)(4326008)(44832011)(1076003)(2906002)(316002)(6916009)(66476007)(66556008)(66946007)(6506007)(5660300002)(15974865002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnFVOUdWYXZGeXJ0WlV4MUtSSFVaaCtOSXJxSVY1UHNUL1hDc3JyWm1STlBM?=
 =?utf-8?B?cXNianNpTmFBVEFIMTBFQ3BJaG9iLy9QeUl3MU84ZGRMcytsNXB3anNiK1l3?=
 =?utf-8?B?RGU2SlZHNitwOWJvZWlsUWlabmVlaW8zTGlDTmo5QzZkQWRlQldvT09DSHVR?=
 =?utf-8?B?bE1Sa1d6VGE2TnZESklHQkJTL3lQL0hHZFQ3VXcwV0RjR1BaV01Lcjk2MU9a?=
 =?utf-8?B?QjJDK1pRYzNhZGFjU05jZjlkNFFlSVhpRTRJamgzdnZIbnFpeGZNV240QXl6?=
 =?utf-8?B?VDd0MmVFVTBEZkxvaTNLaHJ0YVpLZ1ZGUElMVHg2dG0zSWJpOW1PUHNCbXQz?=
 =?utf-8?B?anpIMjhZZGZIM0JKem54eUh3eW5lYVlhRnhYbmpaMlFseGRVM0NITVVmclJI?=
 =?utf-8?B?VExNT1JxNzhycXpFOFpMN3pJVVlSdzVYampTamlUTGw3QTdpVElQNnJ2KzVl?=
 =?utf-8?B?V1M3WllydUxDQ2dodVFHdjRsYTBxanh6cms5c1FCRzUydUpXekxJRzVZWlNs?=
 =?utf-8?B?LytkRGxBYnpseTM4VE44eFQ0M3l4ZnZEY3dSL08va25xR3BhVUxzUDdQMHpL?=
 =?utf-8?B?a1E5UWNoU3RIV0hCVzVlaVA1YkpoWEQxWm8zdUZ0bUgvSlVxdVY0cnZiQW1k?=
 =?utf-8?B?MWt2cmdCcTlYSWc3bnhkbUQwZzBybGpERWMreFJLcWxGSWJ2RVlKeFZtZUpa?=
 =?utf-8?B?ZVp0TFJQNjVvM3FOM2RlVjlVWnlKbnFWVVd6b1N0dCtVQ1djMjB1V01rdWVS?=
 =?utf-8?B?ZEFCSjc0amY2V2xLZEtsV2QxTVp2L0dlRkYxNHpJS1hzbHEvZG43aEtDTHZZ?=
 =?utf-8?B?OUIrQmk5NGl4S3M5YTV3MU9Nb1dqd1VkQ0orSWFlOGZCUlVuajdQT0FnWXpu?=
 =?utf-8?B?SE1SZlpHU2NqajdLdzhNTi91R3M3dklmZElvNzRwR2pDMlk1V2Z5b0pPYTEy?=
 =?utf-8?B?ZG5uS1hQSmpTRWkwZ0N1SGdHeEoxV1lkVG55c1c1TDhkQjIxMGdpbG03Q0Mr?=
 =?utf-8?B?Y3dia3BaMW12ejVoN0ozeDhkb3FMUXM4QTFpMXNJQlArL0JxSEYxekgxZTc5?=
 =?utf-8?B?dmgvN2tpWktITGE4bTUzMTlmQjRiR2RqbjZ0NkxuQkVBcDZDbE5QKzJvTGhM?=
 =?utf-8?B?dFM3MmhvUEtMdkFOdEJNS2p1MjFSZ2hFY2lBOWZ0ZWNxeFRaM0I4T0pBUVJC?=
 =?utf-8?B?ZExiUHY0YmIvemxOUVM4bm93SUlyKzV2NTdEY0NHS0I5MXNhOGhwV2RjekVB?=
 =?utf-8?B?bDBYZ0NUSXVKV0ZseE8rZUpLY0hHUEFmSG9xUHlxN0pkbTdrTEwrQWpjcVhr?=
 =?utf-8?B?SmVYSmRHOTdWUkNXLytsNmY3MDRjZWt0Vld0aVFHd3M2TXlLcHJ4U2Q3dVVx?=
 =?utf-8?B?RFJKRXBlUnJKcnB5d3lScVAxNnlZMWhGQUJxcWUzQU96SnJrQmJyMTBSVUVG?=
 =?utf-8?B?bnRzNExrM0lDR3NmeU1nR2dZNkR2cGExTDJYNkxLOTIvcUVHLzRGSmlPVzFm?=
 =?utf-8?B?MEZoc2lMTkRoWndaempWY1Jjb0U5NkJ6blREWHZDS0s2czlreGhuQ3pMLzVY?=
 =?utf-8?B?UVVCQUFTWjlZa0dQY2VKWEU4SlJHQ1R6VUJYZFBkU0NjOW9qWWtWcU45dG9j?=
 =?utf-8?B?RC9rbXpwT1I5OEU1MU9xRWUxY0pjOTZ2ZWJ5b2h2YndvcEt1ZVdiam5CUjJn?=
 =?utf-8?B?aklpVjNlbVhFTjVDRGw1WklZdEdFd1dXb0FoVjRpZnJ0UTRHKzRoanROU2FC?=
 =?utf-8?B?RExka0FVdkxQaHo3S2hYMHRPdGJyY3RPU1JXRTQ0VFFDMlZ1OUx2UngvMTY1?=
 =?utf-8?B?U01pZWQ4Z1NpeURZcmJ4Zz09?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e27332-ccee-4521-6a7e-08d917da5812
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2021 19:47:59.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+LuhKcGkQ9tIKV7oTrrpiYZmgwEcV/q1fmicXVBCliRjycXKXteVBafMoEyd8VcZs1gQb1ZXR8NXmdiwp+mJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P189MB1617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On Sat, May 15, 2021 at 08:00:47PM +0200, Uwe Kleine-König wrote:
> Hello Thorsten,
> 
> your mail is whitespace damaged and cannot be applied directly. As you
> used git-send-email this is probably a case for Eckelmann IT ...

I will resend the patch as soon as the issues with our IT are solved.

> On Sat, May 15, 2021 at 10:20:17AM +0200, Thorsten Scherer wrote:
> > a787e5400a1c ("driver core: add device probe log helper") introduced a
> > helper for a common error checking pattern.  Use it.
> 
> Please test your patch using scripts/checkpatch and fix the issued
> errors (or argument why you chose not to follow its recommendations).

I will fix this.

> > Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
> > ---
> >  drivers/siox/siox-bus-gpio.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
> > index 46b4cda36bac..aeefeb725524 100644
> > --- a/drivers/siox/siox-bus-gpio.c
> > +++ b/drivers/siox/siox-bus-gpio.c
> > @@ -102,29 +102,29 @@ static int siox_gpio_probe(struct platform_device *pdev)
> > 
> >         ddata->din = devm_gpiod_get(dev, "din", GPIOD_IN);
> >         if (IS_ERR(ddata->din)) {
> > -               ret = PTR_ERR(ddata->din);
> > -               dev_err(dev, "Failed to get %s GPIO: %d\n", "din", ret);
> > +               ret = dev_err_probe(dev, PTR_ERR(ddata->din),
> > +                                   "Failed to get din GPIO\n");
> 
> Huh, I'm surprised. I did
> 
> diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
> index aeefeb725524..b97fde71a6a0 100644
> --- a/drivers/siox/siox-bus-gpio.c
> +++ b/drivers/siox/siox-bus-gpio.c
> @@ -103,28 +103,28 @@ static int siox_gpio_probe(struct platform_device *pdev)
>  	ddata->din = devm_gpiod_get(dev, "din", GPIOD_IN);
>  	if (IS_ERR(ddata->din)) {
>  		ret = dev_err_probe(dev, PTR_ERR(ddata->din),
> -				    "Failed to get din GPIO\n");
> +				    "Failed to get %s GPIO\n", "din");
>  		goto err;
>  	}
>  
>  	ddata->dout = devm_gpiod_get(dev, "dout", GPIOD_OUT_LOW);
>  	if (IS_ERR(ddata->dout)) {
>  		ret = dev_err_probe(dev, PTR_ERR(ddata->dout),
> -				    "Failed to get dout GPIO\n");
> +				    "Failed to get %s GPIO\n", "dout");
>  		goto err;
>  	}
>  
>  	ddata->dclk = devm_gpiod_get(dev, "dclk", GPIOD_OUT_LOW);
>  	if (IS_ERR(ddata->dclk)) {
>  		ret = dev_err_probe(dev, PTR_ERR(ddata->dclk),
> -				    "Failed to get dclk GPIO\n");
> +				    "Failed to get %s GPIO\n", "dclk");
>  		goto err;
>  	}
>  
>  	ddata->dld = devm_gpiod_get(dev, "dld", GPIOD_OUT_LOW);
>  	if (IS_ERR(ddata->dld)) {
>  		ret = dev_err_probe(dev, PTR_ERR(ddata->dld),
> -				    "Failed to get dld GPIO\n");
> +				    "Failed to get %s GPIO\n", "dld");
>  		goto err;
>  	}
>  
> on top of your patch and the binary size increased (using ARCH=arm and
> gcc 7.3.1). So no objection from me to get rid of this idiom.
> 
> >                 goto err;
> >         }
> > 
> >         ddata->dout = devm_gpiod_get(dev, "dout", GPIOD_OUT_LOW);
> >         if (IS_ERR(ddata->dout)) {
> > -               ret = PTR_ERR(ddata->dout);
> > -               dev_err(dev, "Failed to get %s GPIO: %d\n", "dout", ret);
> > +               ret = dev_err_probe(dev, PTR_ERR(ddata->dout),
> > +                                   "Failed to get dout GPIO\n");
> >                 goto err;
> >         }
> > 
> >         ddata->dclk = devm_gpiod_get(dev, "dclk", GPIOD_OUT_LOW);
> >         if (IS_ERR(ddata->dclk)) {
> > -               ret = PTR_ERR(ddata->dclk);
> > -               dev_err(dev, "Failed to get %s GPIO: %d\n", "dclk", ret);
> > +               ret = dev_err_probe(dev, PTR_ERR(ddata->dclk),
> > +                                   "Failed to get dclk GPIO\n");
> >                 goto err;
> >         }
> > 
> >         ddata->dld = devm_gpiod_get(dev, "dld", GPIOD_OUT_LOW);
> >         if (IS_ERR(ddata->dld)) {
> > -               ret = PTR_ERR(ddata->dld);
> > -               dev_err(dev, "Failed to get %s GPIO: %d\n", "dld", ret);
> > +               ret = dev_err_probe(dev, PTR_ERR(ddata->dld),
> > +                                   "Failed to get dld GPIO\n");
> >                 goto err;
> >         }
> > 
> > @@ -134,7 +134,8 @@ static int siox_gpio_probe(struct platform_device *pdev)
> > 
> >         ret = siox_master_register(smaster);
> >         if (ret) {
> > -               dev_err(dev, "Failed to register siox master: %d\n", ret);
> > +               dev_err_probe(dev, ret,
> > +                             "Failed to register siox master\n");
> >  err:
> >                 siox_master_put(smaster);
> >         }
> > --
> > 2.29.2
> > 
> > Eckelmann AG
> > Vorstand: Dipl.-Ing. Peter Frankenbach (Sprecher) Dipl.-Wi.-Ing. Philipp Eckelmann
> > Dr.-Ing. Marco M?nchhof
> 
> Another issue for your IT department: Tell them please to not append
> latin1 encoded footers to mails that don't declare an encoding (and so
> are implicitly ASCII only).

Will do so.

> I didn't check but I assume this will earn
> you a few spam assassin points ...

Thank you for pointing things out.

> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Best regards
Thorsten

--
Thorsten Scherer | Eckelmann AG | www.eckelmann.de |
