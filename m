Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0739CE01
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFFITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:19:46 -0400
Received: from mail-eopbgr660062.outbound.protection.outlook.com ([40.107.66.62]:44189
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230003AbhFFITn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfDIwb7Ca+G6dJJ2025/sBHrxdE6+upUFoSzH+vCIb4JcQAnY2oqzttvGOzmnereH5yK63VPVdPK5zCKH7Wo9hnPyF9uFZifYyRW+a0jR/7D6JwDs7OyPehnVd9fUpnKgAzY/PQ35bv4VzECtvkZlMzxt4mJfyoytdZELo9o5XmYjnCd4JMARYzKCsm2otimHzqjluwLM8NoHchfnr55OUVn3F/GdIu4oiWbz2KKg38FR+o7qVbDH+uyEQ+l3zeAZ8bXzmhYGitODd1AuUQ8WHSkeXyKdX1u2kHycX4jvh0ihP51vY2qQywp0fsQSH2QXezkw+O3akDK0DwaUkcExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p+wwY0wCZNeev1ZYaY1Hg8bgohpBOhiCoCpkUAvpuw=;
 b=f3emYWhicRTUTx0oRKF/35mBIVWirezOjq6eyOEmlwr1iKomieip4gr8V+Cbdmm95P3KQdI2MqI5jQpGXNPt0Csc6IBqeQRFQd6qylgyse5gXhNX8dFVVyXB33+lZ3tMSy1IQFGL9ZZ+OLuJ9UP/UI0gAiV+98HNflsvR7Do2m0agnFYGEY86CFkivouEuefFOj1f2yZ+4yH6l3y9DjpeoSjw0UhDjaHkzVwVoBdR/MWvDJZzzbGnLdeOxhKO4E+invWiSZwPHeBllQrJhtNo+zsRXQekUozUl7qcwzM2Az0LlZtimfF77sl0JFymazWAJvneUivs3tTUxUFLOF0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQXPR0101MB0919.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:19::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.29; Sun, 6 Jun
 2021 08:17:53 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35%7]) with mapi id 15.20.4173.037; Sun, 6 Jun 2021
 08:17:53 +0000
X-Gm-Message-State: AOAM5307Lhp6qsl+WI5XHeMcIlrpa8Usj4JpnPaUUgrF0+xKSC4B40pT
        IuDwRZfYcaRmrRzRq/lpsRGtKh1rMLNGQbGCBi4=
X-Google-Smtp-Source: ABdhPJzQldXsY8Jr8F6sGeWFI84u0paBGn7ODmGirrqFvtBNNOO0Px0APDUr/PwLh8TKiAg2Jv3Luz4pwXecTKWr70k=
X-Received: by 2002:a05:622a:174f:: with SMTP id l15mr11699337qtk.141.1622966990690;
 Sun, 06 Jun 2021 01:09:50 -0700 (PDT)
References: <20210606070021.116284-1-wlooi@ucalgary.ca> <YLx1oWQAFPYIFRkF@kroah.com>
 <CAKe_nd2q8caqND=z9Pq7Me_BtyuCd2-Nb_xyepsjDkaPkC8Few@mail.gmail.com> <10029109.FgdUXNWx4t@linux.local>
In-Reply-To: <10029109.FgdUXNWx4t@linux.local>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Sun, 6 Jun 2021 01:09:39 -0700
X-Gmail-Original-Message-ID: <CAKe_nd0fNE=+CP4O0cUtOPO5vRC8_gHxjLtH80r_4GO2MW5u4g@mail.gmail.com>
Message-ID: <CAKe_nd0fNE=+CP4O0cUtOPO5vRC8_gHxjLtH80r_4GO2MW5u4g@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variable
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [209.85.160.178]
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qt1-f178.google.com (209.85.160.178) by BL1PR13CA0280.namprd13.prod.outlook.com (2603:10b6:208:2bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.11 via Frontend Transport; Sun, 6 Jun 2021 08:17:52 +0000
Received: by mail-qt1-f178.google.com with SMTP id k19so10426088qta.2        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 01:17:52 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 306939c7-0ce5-4a7b-7de4-08d928c394be
X-MS-TrafficTypeDiagnostic: YQXPR0101MB0919:
X-Microsoft-Antispam-PRVS: <YQXPR0101MB091981ECE987D6A8FEB4D96CB2399@YQXPR0101MB0919.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6t51d1KJKTl209WBGd7Q3AMR9WC9aar8uNluW+us4ebBzLexJnIlBSC0VyUrNAaCx9fuzs/aSWcZ28kKBrdRddRpvbDn+Ew046Sa1HmA4wb+qtt1LwfFuWCqN7btQovb3NJlpyJ4kAH6C5GAAYO2GAhwRIWSSaqbxgr+Bptyzo+paPSSqe5fnn/YW49WZDSmC0Gmr1yXkqCfvZDaof5SAq0QbzZm8gLYzm+Uv7cPTeJONYUECQvlVSH1+M29m/5uI2HppT6+dZyO0pJz5vO9ufO4pTKl4qfg8GK35t8fSrFdiel5GEfeQBgjC6dV5bqM6GLDsG/h8eG1QhD1uMNEIzk7byEDqdG5Z4ecSYnaaPufpOVRL2FFyqF7k8JHqyvzZLecOAUhM0e7u5Kua5F+vSDsiOXLQdzyIbQKVkdGctxIDTUa0mOm3eZDRPFYvhoQyohAM0jA6j5GtaSWsZN7KmHg+2O9GVPMyRa/e1jtgmkTk1ZJeKJGG7TUc+fpXn1QUfRbJpPjecTA4wWvgbdtmKGWA5SX6VqyoG7hrAcEOCYXHbQdgdAlmwrQHmsq813pUzoNgEOloqAPA3K9kTT+EgN5soGMFx59dbrHwdikh9f7ECOMUj6z9VnxGHlSphGSyKoXejp4QWwsjjoXxbGLNrFrXCNoBTltc2K/Mk58EhYeCe2ltQFz2u+JIzO+qiso4vefGa+LPWewgXXCzClb26mQkp/kDuFLqArSAWrd15d3pehw4YnVNGZJJwDZ4PKf8wRaJJNJRslj2o+z1YP59jVN1ptANyVWT79Dcgem5nU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(966005)(55236004)(6666004)(8936002)(55446002)(478600001)(8676002)(5660300002)(4326008)(52116002)(186003)(26005)(53546011)(86362001)(66946007)(66476007)(66556008)(316002)(786003)(42186006)(38100700002)(83380400001)(38350700002)(6862004)(2906002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZHY4YkVsMEJoWE8reStPS01xUWRtVHlNdm9PaTI2Ump1UElOZ2FHOERCUHAy?=
 =?utf-8?B?OXF0NVBNa2EyaW9XZHFaNU9QRnZlQnlEZDVsVHQrclppMUdzREkwbFk0R3VV?=
 =?utf-8?B?QmhiR3A3Q09mUFRFUGtRQ3RhSFBqQWdjelVqSk1rVjhza0VhelhDN3lZV0hQ?=
 =?utf-8?B?MEFIcDBtZ1VrSys4aFVhVm5yU29jdytlNFNQV2NFMkEwTWxYQWpkTnJkWHBq?=
 =?utf-8?B?SDBFcFVpY2dHb253ZWFLL0ZxSXA2YWEyLzBDMFJBQU1GaGRmcllOVmZlZDFU?=
 =?utf-8?B?UnVOTFpHaDRjVGtEdnJkYklSWVhsUW5RZm55a3FPemttUnE5bk9WUG9VQ056?=
 =?utf-8?B?N3gvVTM5SlRvL3ZRK1BVc0pPMitFc1JLcU5OZGo5NlRwWnl2Y2RNR21uczdz?=
 =?utf-8?B?MSs4TUtycGdyZlNzMG5jMHBrcmd4RmwrMHFzYlhKckZMM1VqOXVlUjJtOWdK?=
 =?utf-8?B?eU5ZdGJFU1lSTS9OQ0E2WHlBTkkwVUU5SkVZKzNDUnlTZGFnRFFHRENSTndK?=
 =?utf-8?B?MzNBNU9DUkZkMWpuY0I4ekRJRTlNMDk3eDJkSENZOXc0czY2SUMxdTFrTTFt?=
 =?utf-8?B?RHNBMW5MK3BESlhlUU5sYUhHWEZ6YVFTcjBtSitzUU55WHpDRUJNWGtSK2Zs?=
 =?utf-8?B?cis5RjBBaVpoelhUcmFMQjZnWnF3QUhKWWdZcklNTTQ2S3c0blB3UUlhUHFW?=
 =?utf-8?B?aXVQVmIrNy9IdnFTY21tam5ISHJiZlFsQ1lJbGo1MGgrK0FjWmV6dG82NWZn?=
 =?utf-8?B?bkwydUVmSjRydFlzN2pxTE1SUnpJYmhRRU52UTU3dkV3YW9zdWJrbkVPdEZI?=
 =?utf-8?B?RFdSRFM0TTFiQ1RaWkFiU3VIdmQ2UWkxQjFpeU53ZzNTMHh6VWMxckVxVlF0?=
 =?utf-8?B?TWR5M2RhN0FRWUtTVmFsdm9GeWRMTHVyYm12YW9QUThIaGkzVEtGQVZzcm10?=
 =?utf-8?B?NFFKbldxUGVvNVlPUnkyQzdOWitVaUNvWU44cFBpQnpPVFIybVk0WnoyRCs0?=
 =?utf-8?B?ODlSUXNUNCszMmdBbm42MnArS1dSQ2puc2FVeHRTR1F3RTE2SHRGd0JJcytR?=
 =?utf-8?B?Wk5NSlE4N1ZQcmNoQlFZVmUzQ05OWXJPQkp2cEpFeTlaZXNmWWFpVFhGcjBE?=
 =?utf-8?B?NVYwRHUzL0xiUXYxTDBUTm5iZVZOcDRBU2F2R01oU1dFS0t2elZWbXpZUEgr?=
 =?utf-8?B?VXdydCt6UEpYQ1p1UnRjeWE3RUJaQ2RNQmVPckJEcjhMdUJwSU1DZ2x1QThF?=
 =?utf-8?B?VE5GZ3BBZURHWXFjemVZVG0wRUVRaVZiUmlqTXdQSGRaTmo3OW4yZEFCYnFu?=
 =?utf-8?B?UktMdVp1eGRCSG5ZQndZWTZGK1JYbGNHaXliMDVJaEtPR01POXdYdkczZWFl?=
 =?utf-8?B?N2ErQ2xYMTRvZWxxVW0yZjM5MFU5OURpY25QUmV4aFRyeFc3SzZ2cUJiWUxr?=
 =?utf-8?B?Z2hRUVA1MGgrbGNpZXBIUkQxMTZmcXRUVTAzUzBLTW1JeVFBUzFwSlZFKzV0?=
 =?utf-8?B?cGZZT3FIOXNzMWRqU0J6cmp6QjVuMG9wamtDOXRrTVZocEhIbWIzbkErdFBY?=
 =?utf-8?B?REZBN2E5c1hnanY4VkFqblJoNGh6VkVUQ1JaOE5nUmxrNWpJcERCTTE5bEJP?=
 =?utf-8?B?WGdIUmdDTDl6NWFCbVRrRHBTazVQMldGRitxcTNVWlducnQ2QUprQnlHR0lp?=
 =?utf-8?B?T2d4cUtHaXI5TGZtR1dLVDdGMTM0OXVkemQ4TGtIWk9JZVAxRzZIOHNFMTQz?=
 =?utf-8?Q?B2urBZpkB3dQ1tUxJFV49npIms2JOmg9eNoXuR0?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 306939c7-0ce5-4a7b-7de4-08d928c394be
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 08:17:53.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3Rg1ol4yLDZvOiH2XEHWRwE/LRxWl1palzbQv7cjdrjLjz04f9QwRQKzFYi1g0hGNoS+NZ/d41f2yIwz443+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB0919
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 1:00 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
> On Sunday, June 6, 2021 9:51:35 AM CEST Wenli Looi wrote:
> > On Sun, Jun 6, 2021 at 12:13 AM Greg Kroah-Hartman
> >
> > <gregkh@linuxfoundation.org> wrote:
> > > On Sun, Jun 06, 2021 at 12:00:21AM -0700, Wenli Looi wrote:
> > > > Uninitialized struct with invalid pointer causes BUG and prevents access
> > > > point from working. Access point works once I apply this patch.
> > > >
> > > > https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> > > > has more details.
> > > >
> > > > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> > > > ---
> > > >
> > > >  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > > b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c index 2fb80b6eb..
> 7308e1185
> > > > 100644
> > > > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > > > @@ -2384,7 +2384,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct
> adapter *padapter,
> > > > u8 *pmgmt_frame,> >
> > > >       DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
> > > >
> > > >       {
> > > >
> > > > -             struct station_info sinfo;
> > > > +             struct station_info sinfo = {};
> > >
> > > What caused this bug to show up?  Did it happen from some other commit?
> > >
> > > Are you sure that all of the fields are being cleared properly here,
> > > what about any "holes" in the structure?
> > >
> > > thanks,
> > > greg k-h
> >
> > I believe this bug has been present since the driver was added to
> > staging:
> > https://github.com/torvalds/linux/commit/
> 554c0a3abf216c991c5ebddcdb2c08689ecd290b
> >
> > It's probably not necessary to zero the entire struct, only
> > sinfo->pertid, which causes problems with the code here:
> > https://github.com/torvalds/linux/blob/
> f5b6eb1e018203913dfefcf6fa988649ad11ad6e/net/wire
> > less/nl80211.c#L5919
> >
> > You can see the following proposed OpenWrt patch
> > (700-wifi-8723bs-ap-bugfix.patch in
> > https://github.com/openwrt/openwrt/pull/4053/files) which sets
> > sinfo.pertid = 0; instead of zeroing the struct.
> >
> > Looking at similar code in a non-staging driver, we can see that the
> > code there zeros the struct using kzalloc():
> > https://github.com/torvalds/linux/blob/
> f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/
> > net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c#L6064
> >
> > Do you think kzalloc() would be preferable?
> >
> You cannot use kzalloc there: 'sinfo' is instantiated automatically on the
> stack. The example you took had a pointer to the struct.

The stack variable could be replaced with code like:

struct station_info *sinfo;if (!sinfo)
sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
...
cfg80211_new_sta(..., sinfo, ...);
kfree(sinfo);

which is what the linked code basically does. I'm not sure if this is preferred?

>
> Fabio
> >
> > Sorry, I'm not familiar with "holes" in the struct.
>
>
>
>
