Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0539EECC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFHGhP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Jun 2021 02:37:15 -0400
Received: from mail-eopbgr670074.outbound.protection.outlook.com ([40.107.67.74]:64224
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229507AbhFHGhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:37:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyzt+nbQe3K1JyIWl+b/8gF/hqgO7zNtpRk9FM8F+Oiq8aF/0NCZlyZ4zZZqSWCsZ7aGhe88+tKTwxL4HJkWRl9dtYhavEAhlJYYkjEbXrmJCnw5+dTFs/p1Waf98btUrBu/qv1x1dQohTr3PoszlVx/6Qo7UmPPUunino/xGqQBZsMhizkeFFaooDfQTX3QHtnk32vx4TN5MbQmk4BjgNBHYDfPtBMT0pvqFH/9HIHQpRAuTXSQETSlcVq7padUlTFs9r8MjjBSptvht1mcmheye9iCyb8cq670QjSNdxG6P0uU1Dfg4YlYVO29gyWJVMyMuLiMmWyfs8N9jfd6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E88rt/rcU8KJQzYrauX2KMCvgO32lij5xymqVMBYAU=;
 b=dPl5T/1b6ENH4wX7kUF0dID80y13NfHlcauB+ko1xAbC95FnJo9gFM3CataL7nLi8wXXCAxV51cErZjNCfxWzrUpAz9r1JiAjupYbR0VwSkqhPMzBqIxExdQ84NCxqU+pbinT37Xckt/181f1WggJ59s7Uw/kn8wavbYMSN7toV5FO5tkwT+x1Glgfi66m64RoaXlznn0KTnwXj3tAVz6BE/8EWmz1bS6gb10RAyfE2DhMjH/ShNXXfHQHVxSgpE81Xy2/sxs2Dde+V7g09z/FfIr1YMqdzqyw7A/YmC1BJLFzBMYu1peJ1OcGAsKRsIHLt5AwFBWjI3LHqWsUSnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQXPR0101MB1893.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:16::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.30; Tue, 8 Jun
 2021 06:35:19 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 06:35:19 +0000
X-Gm-Message-State: AOAM531xWa7QT2iPUDXO8DGnCyMP251XkFBjmc5uVwfzQbk62ipaIcwD
        grKkOnSvha5sGoTHo+tAWmLMmgdNSQU5NieqH2U=
X-Google-Smtp-Source: ABdhPJx0qzBzrVLoVm9n90u/hbWE+kSRjwsLV4ouR4icLpdk4XVfB3GHHiwvRKhfnQGP9fQdDbRbrjJgxdNC2/Bdza0=
X-Received: by 2002:a05:620a:2942:: with SMTP id n2mr20058554qkp.412.1623134115928;
 Mon, 07 Jun 2021 23:35:15 -0700 (PDT)
References: <7256195.zb9d8qvCYo@linux.local> <20210606184638.13650-1-wlooi@ucalgary.ca>
 <20210607083542.GP1955@kadam> <20210607084642.GQ1955@kadam>
In-Reply-To: <20210607084642.GQ1955@kadam>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Mon, 7 Jun 2021 23:35:04 -0700
X-Gmail-Original-Message-ID: <CAKe_nd2-z+=6FnoUhSW0H_HZFu0MzUaBnvBg8P1eN0SjH+JG_A@mail.gmail.com>
Message-ID: <CAKe_nd2-z+=6FnoUhSW0H_HZFu0MzUaBnvBg8P1eN0SjH+JG_A@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: Fix uninitialized variable
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [209.85.222.179]
X-ClientProxiedBy: BL0PR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:207:3d::35) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qk1-f179.google.com (209.85.222.179) by BL0PR02CA0058.namprd02.prod.outlook.com (2603:10b6:207:3d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 06:35:17 +0000
Received: by mail-qk1-f179.google.com with SMTP id f70so3986744qke.13        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 23:35:17 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70955480-945e-4c49-84f7-08d92a4794e6
X-MS-TrafficTypeDiagnostic: YQXPR0101MB1893:
X-Microsoft-Antispam-PRVS: <YQXPR0101MB189374F9B21D9BC705927785B2379@YQXPR0101MB1893.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52tuOguBUO4PuO3cZmrDU1ppVOIR5BbRXLIQVP3noy5XC6yzyo7b1g4ZFENLfSVftZXAwPrLK45STXoDdix2TOKgOXs8j4E6lK5DdClRaQlW9/APiJVTmye1A/vBS2kCFhpE0COJo67qJ7c7BV5qE4DSOnRVyJz4g9vm/8GDfft0/HkXdX7cWbKJYlTgXB6aSNvCJzpggHvBUSolYS55C20F0o6IpDLp4/NmjLU5/2JMD1cMFOekotM2jnSh+s9ESZzpL5g5btEivVmbKyxAFDCBLbiBUcuqHvWpsqi1i8ixB024COqQGm+EaxnTUiYgiCINwtCEnw1o/7RVFu2R9qAa3dWTSg7KHUJRHrCji0cjt4nftp/IvblyXEQ+N/4VY9UsxiegBVOjiEOROpRzldL9XVkhCRRZc91MGQuFp5u8lDbIrDBqaFqwRS3+y/DoXR0VK+4331V5s6DHI2GzhCeHPU+vQhyJVe3Oi+X55CKSQ+YPPaluryQi/Qp+391YhI7naZd/8p+H1FhAP+IUqBBm5996Hs/24jB4yO4pzZSy3bMZqrpP1OD16BtK/qH5xtIbCEg2k2aciUJc2PHeoo4bJbBvfQ3g0Qt7JWcHJNyMLRHRj1bQ75DzsnjTSpE6CjFgSV14JkaF2tL8WCjZatyiU6Lvb5hmAa2Gkak/JwGNDY8ZypfJ6MNklaySviOd8E4bk4KmMJLP8Uh5sWijQP7/UB4bgLAQvAE9dYE5/1qYYKqnoZ0xFp8i9ns9mXJ623oWEMv4Wsv8ZbPxbP6wWCxtRo9by9gpsNcam+Xc0V2rxKukGIpjNFRLkozXAp83
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(6666004)(55446002)(5660300002)(966005)(478600001)(4326008)(8676002)(6862004)(66946007)(66556008)(66476007)(107886003)(86362001)(8936002)(786003)(54906003)(42186006)(186003)(2906002)(316002)(9686003)(38100700002)(38350700002)(26005)(53546011)(83380400001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cUR2VCszUnF0UWRjZGcvZ1BRdW1yc1M1Y1dkN04zTTlPemtyUkFOUFNKWnZx?=
 =?utf-8?B?bm5xck9lL1FiNFR3MEtEQ2g0cXF0aUxEZG93TUZmMkJLQWE5N1o1RWhLQnVG?=
 =?utf-8?B?aTdxUFNya2hPaXoyVEN5TjNGdUlMT1J1MDloQmlnMjA0cVRVdm8xSTlDSnND?=
 =?utf-8?B?ZDZTRXFBVk9CejB1RU9TeDNid2ZDdlllNUU0Rm0yM3h1L3FqeFoxZmd1UWxK?=
 =?utf-8?B?aXhPZzZDTWZaQlNWdkVyYTdDQVJUMUs4WGhQanU0L0liRXoyTWpRTlNQMGRz?=
 =?utf-8?B?RXFnOGgvc3Rob3MvSkJYSTI5aTJKZVcvMjB5RCtvTnlvcUxXNis5cDlqT1F1?=
 =?utf-8?B?TXFib2lxaUd1SWxZYSs0dEVqYVFUL2pEcDg1VmE3bnpoaERjTWFBcHhGUGJH?=
 =?utf-8?B?ZTFydUwwR0N5aFRHNDU3ZDNKdGtWelVsZzU2VjNnQTcrSHpGcEdDRDg0S0RQ?=
 =?utf-8?B?SGphODFRKytKZWlJdFJJSG9vWlVPelBTcFFXTDdFbHJsNEFaS0U4bXBaSStk?=
 =?utf-8?B?dDUzVUdDdktpR1RqS0dVcy9kQWhibkgwYXhxb1duSXlRY3F3Sk96QzA1bmdh?=
 =?utf-8?B?djFvaW9BcGhYZXQvaGJvVmRnUEdjZVlHZDRiVWxNWlVUZjZLS3JBWm9FSFR4?=
 =?utf-8?B?QlhZY1NuWTNvb1Q1TTBueWE5b3kydEUwWjVndjVTY2gvRkUzRkZPRlNaVjNS?=
 =?utf-8?B?UEozT29MU3k0Qmk3M3JvUjZtNUlLUXhHU05ES2tEY1krYzR4Ym9pNjhxcisx?=
 =?utf-8?B?ZmxGMHFpTzFIMjdWbUlhTXdOZmIwZ3ZwRGk0My9ua1VSSWxPWlE1ZzErQnI0?=
 =?utf-8?B?WjRMMXJWK1o0Mkdkd0gvTGFkME1DUWZNNURwL3BiQnpET0tGcjloSkVNUGRs?=
 =?utf-8?B?VHU2aWdZeTZKQmhFeW45bzdlMzJyTjh4SXRINEFnL1l3QzEvSjNvemVmZ1hi?=
 =?utf-8?B?YzVtbzZMU09xRHFlTi9SS2R0bG9MOGZOcElvbWVjVlpjMFhUcUxVZ0ZqMS9T?=
 =?utf-8?B?aXRQcXU1enB0UHRKT0hPS0NiU09wdFhlTTZvM3R0WTI5Y1ZzZU9rZXFKazgw?=
 =?utf-8?B?LzZxSWxXOUpQZm5KdlVUc2E5VVBySWpsQkcwUkxXQTNXMmVuR0MwZmhOejRu?=
 =?utf-8?B?eWduVzhOaS83VmRCVWxJbno3Si9nU2dZUHpaa0htaGNiNlBTWUI4ZzNmdTEw?=
 =?utf-8?B?Z2g4VG8vTnd1eG4zS2Zack8yczhRWW42YmtGUE9aNHRibm5OMmUyWmpzb24y?=
 =?utf-8?B?S0dJVVQwQ2Z5bm02dmJWQ2F2VEhtN2VLaVFFREVIOWFUTmppY2FpTGFzUnVZ?=
 =?utf-8?B?azIvekhucEtIYnBTY1R6YnhhKzdwKzZaUHJMTTM4UUFoVDVWbHRDM0JzMzNS?=
 =?utf-8?B?WEw5anJReTFpRUZQMExIUFFURkV2QkkvdCtBRGFOM1d3bU9lSm5yQXVUN0V0?=
 =?utf-8?B?Y0taRU1lME5TRWh6bjZOYml0b1BmQ1pTbTZzSUI2cm5OTDZUN1dmNnFqdzBM?=
 =?utf-8?B?Z2wrVnhPTnZXRWc0WnRydy9zTEpPdkFKL0RVR1c2NllhQUlxTHY3MWY3K3JT?=
 =?utf-8?B?OGh6SEc0bjcxNzhnaUt5K2V6YkdxWUlZdDVvL3pLSkZMdlhSMFp3WUROdERK?=
 =?utf-8?B?cGhGVXRnbHdUdmhVb3FLZTRKT2xBQUpNY1BtMDVqUDdZamhtQkJlQ2Z4WUZK?=
 =?utf-8?B?dlk0UDNHeksyenBQc3M5bU5KRGJSd3YrMDhqUWM5ZVJMRVpNZzEzKzNac1k4?=
 =?utf-8?Q?V5dWObnqV1Jlxw3nJH+wqiIx9omi5ia0POmBAIH?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 70955480-945e-4c49-84f7-08d92a4794e6
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 06:35:18.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06QPlTtzaO/yV/UVAOkztOJdCsc3fOa8C1OMdNkJLG3YS4FDhfIfkidoYqM3VPuOxsGOySuGOtlhReRIR25wVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1893
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will resend the first patch. Thanks for your insightful comments. I
was wondering why every other driver seemed to be allocating "struct
station_info" using kzalloc()

On Mon, Jun 7, 2021 at 1:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> [△EXTERNAL]
>
>
>
> On Mon, Jun 07, 2021 at 11:35:42AM +0300, Dan Carpenter wrote:
> > On Sun, Jun 06, 2021 at 11:46:38AM -0700, Wenli Looi wrote:
> > > Uninitialized struct with invalid pointer causes BUG and prevents access
> > > point from working. Access point works once I apply this patch.
> > >
> > > This problem seems to have been present from the time the driver was
> > > added to staging. Most users probably do not use access point so they
> > > will not encounter this bug.
> > >
> > > https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> > > has more details.
> > >
> > > kzalloc() seems to be what other drivers are doing in the same situation
> > > of creating struct station_info and calling cfg80211_new_sta.  In
> > > particular, other drivers like ath6kl and mwifiex will silently return
> > > when kzalloc fails, so this seems like the right behavior. (mwifiex
> > > returns -ENOMEM from the place kzalloc is called, but if you follow the
> > > chain of calls, the return value is ultimately ignored)
> > >
> > > Links to same situation in other drivers:
> > > https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/ath/ath6kl/main.c#L488
> > > https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/marvell/mwifiex/uap_event.c#L120
> > >
> > > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> > > ---
> > >
> > > v1 -> v2: Switched from large stack variable to kzalloc
> >
> >
> > Nah, v1 was better, it just needs an updated commit message.  See my
> > other email for more details.
>
> I read this again and I thought I should provide some more information.
>
> This sinfo struct used to be huge and that's why people used to allocate
> it if kzalloc() but now it's only 224 bytes so it's okay to put it on
> the stack.
>
> And the problem was never whether the variable was on the stack vs on
> the heap so changing that wasn't part of the "a patch should do one
> thing."  If you want to change it to kzalloc you have to do that in a
> separate patch (don't do that).
>
> And you were reading Greg's questions as saying the patch was wrong, but
> actually they were just questions.
>
> regards,
> dan carpenter
>
