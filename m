Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3378737A13A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhEKHy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:54:26 -0400
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:50240
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229917AbhEKHyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct1NoeuivRMkdE3UwAV1u8iq/ZmCGNNic65KZhl1RSB/JMsFCIDO2uOs6TOeMazR3lx6TgkAv6rPCdSjP4itjkR5NVwtuRZ/kktzrwND6SKbuSngb40DFnAFPBAr7Ghb1pHEkx3UmnCuT0BNJ945Dfmb/XOj1z9jrtlUI4sIllNDR/HX8PuXrU8PIdfJONUAtch9lqdDZmjpZ1lhlNBCVu932GEphmUvf49Njh+8tvHwnlZc8f+Oja5NXiZVkA9cJhTSfDRQV3eFZhX+XbNwOU6p5U6fwPPZ1wc00JJMIMoluGd0ys0Nx0rmXoxykgxc3F2oMqJsglrU+BX3qp/NmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jTccCSG1v6NdPO13+pxp2A7JULnoKd4YxjikWkJNQo=;
 b=hgzS2U/2PhroYcm2lxm6tY8CkZDCoMWNMngbed/DOgLbYU5pHaVR9pWh/P92TBM8g8/3FerujqoEpD+lpCH7g66itvuq/QV5kVv1Obo+6KG6wyKzJwY+YJPg4kjBG4YwcET3M+1GtJ3335fIEO99d6u7N5gyYSfMGz/2W+Env+5bU6a/NvKZ9ZusUEgQzba7bb+iALoJtR1UBCEp6HhIOAonMHzwrjAsS6DKg0ppJByj579LMvj3hkFHMZuZrQ8iARvYS1cXbqLMtoOr38mWT3u4RUyaKGQn0axK0Fnby02J2PG0wL+6/OUWFU3k96T/j6m29bvR+e3VmwWvS574Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jTccCSG1v6NdPO13+pxp2A7JULnoKd4YxjikWkJNQo=;
 b=Key0pbAk4dKiwQ0x04P0B6JVhxlFJpBrp33o9l6/nxHmnoVynzB/mV/l8rc0nSIYHWTdLteBopZ5GlhtXILhSOWjxXCVza3dPEb3Wh9MdTBvefGg7wj2klgWGcUreyd05CoSbE7R/lgxBnDsoCtPXFqCbbysCVPP6W5ZDNTqFf4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN3PR03MB2196.namprd03.prod.outlook.com (2a01:111:e400:7bb2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Tue, 11 May
 2021 07:53:18 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 07:53:18 +0000
Date:   Tue, 11 May 2021 15:53:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Zou Wei <zou_wei@huawei.com>, <mark.rutland@arm.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] clocksource/drivers/arm_arch_timer: Make symbol
 'arch_timer_rate1' static
Message-ID: <20210511155308.0f66b6b0@xhacker.debian>
In-Reply-To: <87pmxxoi71.wl-maz@kernel.org>
References: <1620715583-107670-1-git-send-email-zou_wei@huawei.com>
        <87pmxxoi71.wl-maz@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR05CA0106.namprd05.prod.outlook.com (2603:10b6:a03:e0::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Tue, 11 May 2021 07:53:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a5466a3-9659-4b0c-cfc5-08d91451d6ea
X-MS-TrafficTypeDiagnostic: BN3PR03MB2196:
X-Microsoft-Antispam-PRVS: <BN3PR03MB21968E6411749105B3A93D7FED539@BN3PR03MB2196.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAtAkgdfEQpcL8LMweMqOLTPwl35cQAmDHJez2v7CQ62EHCLHVsppHNmMQ281j1w8DLSRRReAG/kxCN1LEa4GIETv26t+QNYiqIGuS5vW+g+VHwyJL8VdzkMsycXs47UN9e6Ma0ipRADmztONner6XZlr05x3HFus+bIZ4NBmlUGeYndPO0cWs5XTwpVbiLXL+EKCOSzdHKo5Q+leMQOcjH2NboMP2alVbgMK50W+hLXVYks5yXkQGlo3RkAojyms5OCWDsltIqQyePvWpl2sZz2m1ZYIwndca81/WUuosYh33nf8hoGzR3W6QaYgfGVDRIADBqogoYuaLu+phcTVhcHTPlEpcCSvVjoxSUtRJfAbxaUskOKdHQnBm5BTGLPzVQ8IwUzaBTkUTgcjDiiC7DeG7DK9Af52962rMNj4rLMRiXShpAEZXYRL3+9fKqS5GViZqJ52y9HYPro6mflohIZM+cqKu5cM4L9g0FMh6kJcTBbXRioFheHmGSNVbHPrHYd0RLI1BYXiU9c3SNDkQ5xDAMDoVQfJewmab0YaP9gnXpUvdYSPXjVCx8B6kI76FlZGv5/+o9f3kxlRnlkjqbHhoTm66RQXNhYXwW9mg208Fjp3Td8W/irbYf+bTZMYdU7pVwHFygyhjITEEXlXB0fje3f0WXYUXeHImkgK1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39840400004)(136003)(346002)(366004)(66476007)(66946007)(66556008)(956004)(38100700002)(54906003)(8936002)(4326008)(6506007)(316002)(8676002)(6916009)(6666004)(55016002)(478600001)(86362001)(83380400001)(186003)(16526019)(26005)(38350700002)(52116002)(7696005)(9686003)(5660300002)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Tdg+TMJye91VXQI4N4BZik3er3/zW/9M0PcKq+cQpDakJ1HBw0ezWhDLu7f4?=
 =?us-ascii?Q?yJUPRxKk9WG4/bbLGU91/009qnA8Sv02dOLKIIhdTFcYqjOyLAVHnZ+GJXv4?=
 =?us-ascii?Q?lmrs87nnOzKl+qd0542bhmOsw3WqltcykK3adDxcqcCCECXOHRMuObvoTC60?=
 =?us-ascii?Q?6scSO3urZtBy90cN+ZvYoWYHO0I674SJrRHBkVHosKrMKSJIUwuzFuQjv4d5?=
 =?us-ascii?Q?B8GWtcYrPSNU/EESlvi+/tjK5nGrLtNskCjRBJK3Dh8EN3mVIk4rzzIEws2r?=
 =?us-ascii?Q?i9eSk2d3OV8i8BTv5YGNtFaJ10MFvf+yKsSnxTq3RPF6UmbmhECYSHdO/32T?=
 =?us-ascii?Q?KWsLRvFoxtLy69HgUIulCTucLRxIYtgLB09ZlVPnWb4H2MJdpV/g9xY0osRn?=
 =?us-ascii?Q?LlxChnr/5H1jC+DmNI55gs80rKsZKHTrFIk+cFK35qSl59iaveCK63fWUwtU?=
 =?us-ascii?Q?YO3g6TtQAcDHNcwo3jzToE9ZjMsMQTBX7bpY4pOj5IkpipPcTx+LnSgzrKGJ?=
 =?us-ascii?Q?GjZFhzDD6MCpe5EUl4WKQBmxGiHhxMw2Q6CuWiFo8s+OZxNP00PeEgZ7fbI2?=
 =?us-ascii?Q?Kf25oNZCD46cbpcCTHH6EFNX0MlxL/ivNKvZzs05fnEJdL7DjpAWSxiYQ0xt?=
 =?us-ascii?Q?i+cyBKoiLvJA65WI+AemibMrh+1C1oihBVXlp7XYwWRxODHTlK9Vddd6Jplu?=
 =?us-ascii?Q?9FHOawAWbUlt1doYuPCLcnEhiLv+7SdOgSTLSjCzGoJfRb429A3qXJfpDTJ1?=
 =?us-ascii?Q?arPgKidjIqvZvg3jwPSimr7gVXRhCOCKnvSFiHIoXCoP9qbL+oT/zBBZ1Mcg?=
 =?us-ascii?Q?jrSaSDgm6pIjAAfXh/FbdWWWaH3ynFQ+qm2hmr/oJSNt3tVNP5P0I0rp5/ra?=
 =?us-ascii?Q?I6s7EyMaDsV4F+7X3jS7t2tFqI8aTdFMkvONLal9SS/HrTb1xvUkeRWbe/sP?=
 =?us-ascii?Q?R1xAXwihm5SyWl29NtilgdFeX01dD8/1IGogz6aFEdwbREtEaOFWTIag9hTp?=
 =?us-ascii?Q?mWTea7MdQaH3LL/YMvxXSqLBaiOBWm7tXEsjeN6nDrVTvsGLhIBYnEzgCyQ3?=
 =?us-ascii?Q?EuO5744BZQ30ewM3YYA+CYAbk/dfVFQj75F9jAvH5TzEPVBLw5iHHDLHiP9n?=
 =?us-ascii?Q?6rzYte5LuTp5CjOcBfoHfrsM4BHsS8Xm7piaTRdUAXgtRsR5Ijfisxs9Zxcw?=
 =?us-ascii?Q?yvRTS4HjjEOBW1sTC2pu14MxJIeJKwtRMn2qSq/1NQ97IgPf4EAVllDoRG46?=
 =?us-ascii?Q?kTtoCEPDwi9R3nN1NZEG24yM0/LVxMD5F80kYqhE9k6Ww8GMxFR7JVG19O1e?=
 =?us-ascii?Q?cZngdZ6HW3G9EVOjD35/artq?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5466a3-9659-4b0c-cfc5-08d91451d6ea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 07:53:18.1718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP6TiTMCTl6hAxdhQwazsval4iXdMzhxaLxHWUtBxZTwhMvVGy6DQ08raBAP/JGelzIJTY2nclSLppHmnldP+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 08:14:42 +0100 Marc Zyngier wrote:


> 
> 
> [+ Jisheng Zhang]
> 
> On Tue, 11 May 2021 07:46:23 +0100,
> Zou Wei <zou_wei@huawei.com> wrote:
> >
> > The sparse tool complains as follows:
> >
> > drivers/clocksource/arm_arch_timer.c:67:5: warning:
> >  symbol 'arch_timer_rate1' was not declared. Should it be static?
> >
> > This symbol is not used outside of arm_arch_timer.c, so marks it
> > static.  
> 
> It is worse than that. This variable is not used *at all*, and has
> been added by e2bf384d4329 ("clocksource/drivers/arm_arch_timer: Add
> __ro_after_init and __init"). Not sure how we missed that.

Oops, my mistake. Sorry for that. IIRC, I added the __ro_after_init
marker, then want to prove the effectiveness of __ro_after_init with
a new and non-used variable. But later forgot to remove it.

> 
> Please post a patch removing this variable altogether.

Just sent out a patch to remove this variable.

> 
> Thanks,
> 
>         M.
> 
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zou Wei <zou_wei@huawei.com>
> > ---
> >  drivers/clocksource/arm_arch_timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> > index fe1a826..800aaa9 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -64,7 +64,7 @@ struct arch_timer {
> >  #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
> >
> >  static u32 arch_timer_rate __ro_after_init;
> > -u32 arch_timer_rate1 __ro_after_init;
> > +static u32 arch_timer_rate1 __ro_after_init;
> >  static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
> >
> >  static const char *arch_timer_ppi_names[ARCH_TIMER_MAX_TIMER_PPI] = {
> > --
> > 2.6.2
> >
> >  
> 
> --
> Without deviation from the norm, progress is not possible.

