Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A760C39CDEF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFFHxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:53:42 -0400
Received: from mail-eopbgr660062.outbound.protection.outlook.com ([40.107.66.62]:41664
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230131AbhFFHxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:53:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rn7f77ri4zB+OgRkmRTKMpk2kAIVPxP4HkmdCLjP7cAnols+LliOwSk0iMFB029asrDS+lh46TscxugjzXWukOb0E0aG7WicJ44/jwNuZ/x68xctOLroGYblXzDZBjZQsXutKvs6gKTYUdbQRhuzOF5UfgMK073xy6T9PPiPYXhzWwvyFJVUHW1+eQfVFOptDu6w7+bKgXrZMJ3TdFwfKup+ewEl9Ete7qs4xPEuVngvV/e1lflSaXh9xlUL7IP+EJKs7niqRA4zPYIN6aLRp5Jcg/I3vJh1g73bgt1r0ltQwy04tjj8rh62nAhEnylvYhnNLUBerllTE48f+0a1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X46hjLiGsEx0qUDCCQ2XQ1npprGN9PETAX3OKH9OIBo=;
 b=g/WGsm4FtOU8KTJRpz6vh6f0cEY551lh3F3AGChVSdqButYBI/gvk3Vdzfhw9O6Am4F8Jl42BQwHUB6oh+mEpF03ZkoeFEeEk5lKVslrPWl7DeRzLtuQWe/y2pIcsHYVNRhayL5UfjhVL1K6SYkAjJewF3sw8mMiTLyuhYPN2F+tG+gkON9c9pCX3pQNvbu29PIypXNuXKiaKzFIed0Q9loY+zW/QLCnjkvV3MQA3hUMUsd1M+N30wDLUdqPFOldrLS8++hEJL2tz0QG9v87sShDac8zAtq1jgWKxIJppUcTzbRO1L6VxP5xb9H09acuCFspR7cPpl0EbXWgA587Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQBPR0101MB1074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Sun, 6 Jun
 2021 07:51:49 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35%7]) with mapi id 15.20.4173.037; Sun, 6 Jun 2021
 07:51:49 +0000
X-Gm-Message-State: AOAM5308ytpEjMYdkE8nMXPTRXhc4Al/7/+8ywftu1YwcGTEfHVZRIrz
        MxWMA398jJTh7T88n2sFc7QGpJhiqti8GyTPjy0=
X-Google-Smtp-Source: ABdhPJwgbWxir12ZE8NTmOXcY/D3mUeB/dnQldIYRZH8GX09Bh9I56+Cn0CCWjlQFmeOO9sUFaQuC2e2O7b0tVSgilo=
X-Received: by 2002:a05:6214:1788:: with SMTP id ct8mr12599598qvb.0.1622965906793;
 Sun, 06 Jun 2021 00:51:46 -0700 (PDT)
References: <20210606070021.116284-1-wlooi@ucalgary.ca> <YLx1oWQAFPYIFRkF@kroah.com>
In-Reply-To: <YLx1oWQAFPYIFRkF@kroah.com>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Sun, 6 Jun 2021 00:51:35 -0700
X-Gmail-Original-Message-ID: <CAKe_nd2q8caqND=z9Pq7Me_BtyuCd2-Nb_xyepsjDkaPkC8Few@mail.gmail.com>
Message-ID: <CAKe_nd2q8caqND=z9Pq7Me_BtyuCd2-Nb_xyepsjDkaPkC8Few@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [209.85.219.51]
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f51.google.com (209.85.219.51) by BL1PR13CA0210.namprd13.prod.outlook.com (2603:10b6:208:2be::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend Transport; Sun, 6 Jun 2021 07:51:48 +0000
Received: by mail-qv1-f51.google.com with SMTP id g12so7239459qvx.12        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 00:51:48 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d009eec-67bb-42ad-8f0e-08d928bff076
X-MS-TrafficTypeDiagnostic: YQBPR0101MB1074:
X-Microsoft-Antispam-PRVS: <YQBPR0101MB1074F3FE733AEDDDD6B3AD44B2399@YQBPR0101MB1074.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XECqyiFGxnRV6p+I9dggRHt42sGSK2gDnaL0YqMV+QMSkI6SY0P/UCU930N0Rz32a7coOXfbeQSr/ByBunF2x2Ynq2le1p8NBqs3R0NPnW+W840jBY/xZw6TDBU2g0OZm+deRBm5RqHkXXD4jsm/0dMr7WjiZrQl5uFmTMIW4S14qKxDkxQFXi8eGvV2p0Q/V5AOPbAynXx+Xn99UXcQ0BMCwCXvQpcz7rFRQMT5sRK0WbhowaPIMN3mjBQDBD8MmlGBxr0iP+JKH3fb9dhd+sp6tugQpno1ncXu4LKCm+4RHSSdXm13Mh8UZKBf8Os5a9pxGl+HCtLxlD04vR+SeWcpYXFWh/CUhdeyCWo9/zAs4DX8bpGIHr+8YRLgJ1tSzjG/yPySHpB+mMsPxvJEfaOJGiKDYMCPHq1oenewWkgnwCjnnMGyQlHWJU/yScfi4SOBaDQV2UeyDT/vGutYe9ah9a9V6hVjzjJzHzzw/fkR5x7hb/T1dUIveciDt0ybv1EE4n8IB6f+0XwFnAHqf+eybpqR87xWSYBH7YokxUX4/ZLcFK6h32fm84vkJj2Rz//qsrbUudA/MLzBajwZxB59IvQYYzgLJE0+SbtgbshEv+w5i4e2EllFYGD9OqVY8ZZyAVNA2EDUElsc651/LcsPwk4kNH2gvN2NS+KTNoUALzy9Ha0mKGKkZxR8RwB3z2TBTgSdlAcSgDKx1m/gsyeREdE1jU7nEwj/WT2uKMf+simK2Xm3so+w7VJb8E0/02F60bfp/1SiU45LP5+pyNBBROD015j8Mm6T8bWTZF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(316002)(26005)(86362001)(6862004)(9686003)(66946007)(6666004)(8936002)(42186006)(52116002)(2906002)(83380400001)(186003)(38100700002)(478600001)(38350700002)(55446002)(66476007)(8676002)(66556008)(55236004)(5660300002)(53546011)(4326008)(786003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YWZkbWNpTFVCc054YzN6VmQ4aWtESEM3L3I3dVFJVHNBRWl5MCt0Qzk3TnVy?=
 =?utf-8?B?REZXZGN0RFMwZ1ozODZQdWh0Q0dmaThNMzE0dEFGRUQvS2ZEVUtKMDdYY0k0?=
 =?utf-8?B?S2RndCtiQkkxN2tWMVFEdUVVN1F5U2RDb1lmTHlXeVBCOHl1TDY1ZU5KczEr?=
 =?utf-8?B?NzB2YUxSZXBvQkt4Sk11Uzg4dUZ1UVBTT1VaRGxQdVBaQVhYcXVaODZwOWNW?=
 =?utf-8?B?MFV2OWh6bTlERlpRZHBhTkZpR2pDQXVkcmZyc2RYNGlJN0hUS0FLdFF5ZkRK?=
 =?utf-8?B?bk5RQit2bWFpZmI2SzhXbS9VMWtacUpGMERrNGczTmZGLzgxZHpIVndtWjVu?=
 =?utf-8?B?NkVWVlQwTGRJUHk5c0xlUHBwWmpjampnTWFGczIzM1NDYjBZVFpkNDlhTFpG?=
 =?utf-8?B?eGxuWEd4cCtGanZFTGFGUWgvdjBiNURMb0RlZTZUcE1aMDNaeFE4cWJHWFZT?=
 =?utf-8?B?UEUrWUJqd0VMMCtvcit0bUJ2WUplTTc0OHd2SHVXZVllSXMzcVhpOTdkUERF?=
 =?utf-8?B?VWpPM1ZMb1dkMFNRb3l5bS9LN3VQQ2crZkNiakdIZ3RqS1RFVHRLWVkzaytB?=
 =?utf-8?B?VGRQMHV5NlNJUEFXb20xbXN3OWpNTGlWTzJDelJrRHdLS1lwamlNUXRkSHh6?=
 =?utf-8?B?Z082SnJLdjhWYXhHSmNRRXVqemVydlMwTnJCNW5yV1lYQU9CYmFzdHNENlND?=
 =?utf-8?B?QSt5RUM3QUR2OFhmbmcwUzZEUUJwMDdyeVg4UFh1TGFrQjN2NjE0M2IvUXFJ?=
 =?utf-8?B?WU5maWE5SVErU2tXWXdsZTJZWEVmelgxWTJ1cnpZL2ZGcmlwVjNoajg1b0ww?=
 =?utf-8?B?Qzl4MVFDSHFXRkc0ZXI5dFQwZkpZemhLNG1mUWNPL2RYcE83bWFPZTVPeDBl?=
 =?utf-8?B?UlRiSkdwMFVFZ3ljWHFDU3RWNUxqd0JzdjhNK1hEZnlYcHh6aDB4eWlJRkhJ?=
 =?utf-8?B?Wnk0Z2E5VzY1MkxsdEw1ekFnMGxxQklLS1JKZmFpdlBzNUtpa1AzR0Mrdm5n?=
 =?utf-8?B?STg4S1g5Ylo2OWt1MThqZFJBZStFanp0NDVLci9iUFI4N0svc3YveE1Fdm1n?=
 =?utf-8?B?TWNYWlprMkJmeFEyZEJkdnRiaVIxYjNNalV1RkdaVEdqcDVKMTgvckpaZTlH?=
 =?utf-8?B?ZTNpck5TWGVqcnhTREZkY1NLTVdMaTdmTlhXenVXUEthT2xEeUxvcDMzWjV2?=
 =?utf-8?B?UVNaVkMwdkM0eTFxN3lTQ0krdjI2SjllNmplZUdDOUJTTVBaTGFCajJ0Tmkz?=
 =?utf-8?B?VXJtRmZramZ3RzBxM1o2RzdlbjdSNks3aVhnQlQxUkhXeVhmKzJ3SS9tYmd3?=
 =?utf-8?B?aVhBa2E3UEVralB4Y3pHMGtLWjM2VjJnZzY1T1R1Uk9sSUo0em55UWJ6NDN1?=
 =?utf-8?B?TDJmUVNzZ2x3Y1Y3eC9BU1NySHNSQUNWeml5YTBFZ0pIeWRtazU3bzdhNGJx?=
 =?utf-8?B?RzdzdjhTdHJGYVBKSzl1ckVqZW1ZRHBzRzZjRFNPSVRIM2JVdTNLSW1TWVZW?=
 =?utf-8?B?cTl5YXdKWko1MW5VTUhkR0ZnUVJ4R2dLR0s4QW9hL3BVWmFuTkNhUGFzOWxW?=
 =?utf-8?B?Zk1EQ2ZrV1lTVE5ET1dBZlNQcVo0c3BtZGx5ekZqSys2NTBLVk9sZUlyWUlo?=
 =?utf-8?B?T2lwVDlsRmI0Nm5YSlE0MnVpeHYyTlM3Mzc3SXliMU1UZzloaGhMeFp2VXFh?=
 =?utf-8?B?NVA0YzBUL1RxSWlqSHdMMGZ5aXBjYUZFenV1TC9qT0x1cUoxN0RFckRnNVNM?=
 =?utf-8?Q?ZlVZWimEmNVfE/iOVMVJVKpqy0dYxiVl3hnUpuU?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d009eec-67bb-42ad-8f0e-08d928bff076
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 07:51:48.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOIAYduOuQaREJPFTSkqheqmSctEFRoHzGY6AUB8eLhEPCHasPoqWyptkw5Gq3r7cr1HtwJuGRzuhvAImatjzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB1074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 12:13 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Jun 06, 2021 at 12:00:21AM -0700, Wenli Looi wrote:
> > Uninitialized struct with invalid pointer causes BUG and prevents access
> > point from working. Access point works once I apply this patch.
> >
> > https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> > has more details.
> >
> > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > index 2fb80b6eb..7308e1185 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > @@ -2384,7 +2384,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame,
> >       DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
> >
> >       {
> > -             struct station_info sinfo;
> > +             struct station_info sinfo = {};
>
> What caused this bug to show up?  Did it happen from some other commit?
>
> Are you sure that all of the fields are being cleared properly here,
> what about any "holes" in the structure?
>
> thanks,
> greg k-h

I believe this bug has been present since the driver was added to
staging: https://github.com/torvalds/linux/commit/554c0a3abf216c991c5ebddcdb2c08689ecd290b

It's probably not necessary to zero the entire struct, only
sinfo->pertid, which causes problems with the code here:
https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/net/wireless/nl80211.c#L5919

You can see the following proposed OpenWrt patch
(700-wifi-8723bs-ap-bugfix.patch in
https://github.com/openwrt/openwrt/pull/4053/files) which sets
sinfo.pertid = 0; instead of zeroing the struct.

Looking at similar code in a non-staging driver, we can see that the
code there zeros the struct using kzalloc():
https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c#L6064

Do you think kzalloc() would be preferable?

Sorry, I'm not familiar with "holes" in the struct.
