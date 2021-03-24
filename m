Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92604347082
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhCXEgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:36:54 -0400
Received: from mail-eopbgr1300113.outbound.protection.outlook.com ([40.107.130.113]:16703
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232680AbhCXEgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:36:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL6hFftvvWtFCYGTMbyOYbvjRIzQda2lHgIwmKdE4ud6poxkh2nQ0cTIuBHNvWAB1B6jlYnn5OUCf762KzwVXC0Tf8kHvdot70GbNLQUSyqRCkEGoh3X5EIvwtUryeiQLxMEkKO0I/Bhtwbdsbcdk+NsyPxcPrFZwwG7gRIh7lyVu8R4cqIjgk9l7qZ7Xavo307b+IxfjlpeCQwIeWswQg6ISOK20yCrJQXCtM7/h20pQMReNBBuvm0mjS/6v6Hzz8ugq0zKmZStef3vAysevAlMJzciWssA1F1lKJd4BVM1WQ3RMQYWKYQAqJaZgHlWqfkZMlJM7gklwhi7ORbgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOWTlmjmlUuuZEGgGSSf2vnQp+BYRtxjcha3BFypPIQ=;
 b=JU99j9bk41VitCFgl/PKALFEc/Nx9htPji/14XNj+KoENs9Xa8EZgk2c1ow4c4Xwir9kNCW1ix4uJCT1fvRIrvMPg+gsIZX1Tt2YE0G/qQ+zX70x3c3v3h3pu3bYwTo4IfgbQY9vRss6w43Oz46OTVXXX1M4A2rah5ktOIFjHZQjmFBKhFym9WNdMcspSXJ3CmX0twfLcKBRTkO4QVFC9SD8QvmMAqw422S2R+LVlumm0CTH18XS3rrBKdivKsfkG3+7B448Vog5kvZL4XXNKjp1tRW5DvQZw4lQAHopY0AJ8QMV2E8NMqo6wuKchC7siyAaArtaHQ3qwyWo4fre8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOWTlmjmlUuuZEGgGSSf2vnQp+BYRtxjcha3BFypPIQ=;
 b=owHto1JilzIh2gukLmEo59h6+7rC64L0ox3f9NQ7ivl2cBDRXN/y2zn3d/BJFTKXJ4p6DoJM/ObJbk1qrzAb37WJ90KzEjndg1x8TdLRVlFrKGuEOGZRrI1jIOzd2+Xvj3C+Dzg7k04vbIYs+8oG/+93jWJjA44+Z/Y50VdmXKU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK2PR03MB4548.apcprd03.prod.outlook.com (2603:1096:202:21::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9; Wed, 24 Mar
 2021 04:36:42 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 04:36:42 +0000
Date:   Wed, 24 Mar 2021 12:36:31 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] usbip: tools: add options and examples in man
 page related to device mode
Message-ID: <YFrBz6dvTip9+wm7@Sun>
References: <YFnlUaF2njDjIhfM@Sun>
 <1a2c79b7-1cc0-9ddd-f2ec-fa7b222113ec@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2c79b7-1cc0-9ddd-f2ec-fa7b222113ec@linuxfoundation.org>
X-Operating-System: Linux Sun 5.10.19-1-lts 
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: SJ0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::23) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by SJ0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:a03:39f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 04:36:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615e8541-817a-451f-45c8-08d8ee7e6c07
X-MS-TrafficTypeDiagnostic: HK2PR03MB4548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK2PR03MB4548A8025F4E7F7DBFE42442BC639@HK2PR03MB4548.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Fdp0Tjh7PCQiUwxBXdIlM4ZZNgCGClMIJG2CocDzJPH08eU8AbXvRE2ZtzCRaxJkulhOHLVzqxm+3JJ9aZE6UrEtU0iT8QMYd33BbUcmCwfAOxprOOLPFbppBos5mRY7VhrMU+dPFp7IwFrN0BCTHe3IXrZLbwCs17wUIAvFRN/TIK5LWD5rBuNVZqmX1h+XR1oGcj0vRMQGwPpIW0c11kVpG91k58U2Lw4EwGz33lwXkd2wniFtcS5bZ7F0apwVP1IJht0lxCJYzWnVXum0wifyk1TiKtclQC5nTJnnY7Htuj272/3z9V2JNan1lGulclpxvABhwRaCCAL6jl/McPCRcE57d84IBztdsP3pN33yS+cRWD+z6PacBRQEVQj503yv9Nd11SKE0M5aNnWl7ZEIHiQlJ8vYfVGVvoMATGEbXWCUSUU3m6w8T7A+pBHSg5tFRgTkTmj41CWiVdvQJcMdwqIa2eWaYt44HLiH7nDUzMKczYjLnwOtvg0xDyAzEdnd07EhHOY55hpo5xOzXjacCh01jkz+zltWUb6n9L5PcGA6tkpnUP06P5TE++53boz0zswQ8//CXxUaCufZHFK+76t26OZPwchPbMR6ikDFpRq3EJcHuzPZncIG1BsIGSU0Fz2BOKPWyKuaoPNBA/yxxaQc88k4ZRoNfk1hIDsxcoOCFMqlZYstGJs8xqXeW1jF2mdpQYR7XSHbwIpyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(39830400003)(346002)(396003)(136003)(376002)(66946007)(66556008)(6496006)(38100700001)(8676002)(5660300002)(66476007)(16526019)(8936002)(83380400001)(86362001)(6486002)(2906002)(52116002)(4326008)(478600001)(110136005)(786003)(186003)(53546011)(9686003)(33716001)(316002)(6666004)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E6nZiXrej1vWxkOR4xhfK8/aGT67Mh2XTk2ivtb+khiA85mx20N87d8mkFEE?=
 =?us-ascii?Q?S6o2MPi0erf/U9ivF22WP4nvqm9s4ss858ZgWOgs1Rhf/7DeYfRvdHdxO1bd?=
 =?us-ascii?Q?wAJalNViK2rWrzdV5b4UgfvEjIYX/sFJXiU4JlGdlPU82LNdftKB/quTZqOL?=
 =?us-ascii?Q?bbiTUHQXXCWJPxdVnCQCVSe/o5uw6SeRDs7htE76GcjjbiBUrPtcVID/fGTr?=
 =?us-ascii?Q?7r5QPfE0zHdlgEJbZvnNWDD21Hi9iHqmb8AXE3eXCdlkz8FdAnU/OJnnNU4F?=
 =?us-ascii?Q?RNJExdvZ/XekiQ4qSaRxJAW3LAJHiDOewhtbVVq9rWmTJU9ZCqjzRsFMfwjc?=
 =?us-ascii?Q?Zv9vjVaPef4eW6aTsd0lp3uXZ0COiyqvD6idqYtNK5JOTWfH7OQX9CdzFLhZ?=
 =?us-ascii?Q?H5xG4frgd7sRFOQMC418KsGeHqsNjCvgbWa0igN1IDFG/EqEh9I8s0U9pNte?=
 =?us-ascii?Q?phYqqaGXb66y+RhjYC9cbfNysklFFGh0I5rGWBMDrJQJCC0u173rB8WGsJ1g?=
 =?us-ascii?Q?gEo26HAETmv5CCrHV7yx4o44vH2m8HmjqE+0Fp1gSH9d0iQ66JbeJfgUtgLy?=
 =?us-ascii?Q?uydtO1a/hjTwbtZdaiE1z6jzyd68jW15XHJlAXQnprKXRU+jsiDKoEWsUzeR?=
 =?us-ascii?Q?+XPxRFGvTo0nWcKVGYl6P08L4wpAKxV8tWMKtgbw4qtfaFfmG2k3kzjjKfOa?=
 =?us-ascii?Q?nxZ7PMg0HmowSiLNyizh+p/2Tb5fNp+MYLTS5FbLlUrghEOr6KGljcWRlVIj?=
 =?us-ascii?Q?QqWOcL0HTFaDxR6zfZXgyGUtS7YMRG8rf2N7/4MPB93GPeDghCjdnzfTUvYE?=
 =?us-ascii?Q?h8r8Zetcm6ztgwqVEOpVOet4lEElHoNYA2zp5Q+uKQjboK2kqF8TV/J8HXLN?=
 =?us-ascii?Q?AOh1AY/UIdbA9DBa73NwOtueVZPvzbKDOY6H9lEeG2Kk0UvLIWMaFzx+eYqm?=
 =?us-ascii?Q?fTGdA6W+FTm2LC44oPzzEA2X5WTZDxbdX2sdsC9fGjON5u3wIDWdcLcrBDUu?=
 =?us-ascii?Q?GGm628rJ1mEwcqzQueB0XemIK01mSwZ5v6Sz26wA1NijL/epmcb0UibFy8Pb?=
 =?us-ascii?Q?Svu7/2gw7kIgaVB/iNLhb6jD8e2QdjBJQyG8W/ELrBXR3Ioong8zbW18HSgG?=
 =?us-ascii?Q?katdYtGisoR+k5qWqB+ReNl5X5zwiw00pwPClTue/iCPRcM5q89/jJAXl/VK?=
 =?us-ascii?Q?d/P8cfbT1wNT6V5SBGTxgKhn0crtxbR1GEgyAtx9Ywj2RX0NqfN6EoZJSj/w?=
 =?us-ascii?Q?stknJObatZ127y8b60Wx8mFZuVlwQUj4IWVIADBJ8hlP70rJX8LAZl9nzdU2?=
 =?us-ascii?Q?eiZWUua866ZeMFDV8/hRFnIo449BQuMk0VytqyMEmpKHsQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 615e8541-817a-451f-45c8-08d8ee7e6c07
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 04:36:42.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlPugg7aOf4DYgkM5UhNGYHNT6/x+A80EEXplNpBnIhFpLHP7ZJBcC4zBp7u4r6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4548
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 05:12:00PM -0600, Shuah Khan wrote:
> On 3/23/21 6:55 AM, Hongren Zheng (Zenithal) wrote:
> > The commit e0546fd8b748 ("usbip: tools: Start using VUDC backend in
> > usbip tools") implemented device mode for user space tools, however the
> > corresponding options are not documented in man page.
> > 
> > This commit documents the options and provides examples on device mode.
> > 
> > Signed-off-by: Hongren Zheng <i@zenithal.me>
> > ---
> >   tools/usb/usbip/doc/usbip.8  | 25 +++++++++++++++++++++++++
> >   tools/usb/usbip/doc/usbipd.8 | 22 ++++++++++++++++++++++
> >   2 files changed, 47 insertions(+)
> > 
> > PATCH v2:
> >      Add signed-off-by line
> > 
> > PATCH v3:
> >      Move patch changelog after the marker line
> >      Remove nickname in signed-off-by line
> > 
> > PATCH v4:
> >      Use commit short hash and message instead of long hash only when
> >        referring to commit in the kernel
> > 
> 
> Thank you for the patch. Please see comments below:
> 
> > diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
> > index a15d20063b98..385b0eda8746 100644
> > --- a/tools/usb/usbip/doc/usbip.8
> > +++ b/tools/usb/usbip/doc/usbip.8
> > @@ -49,6 +49,13 @@ then exit.
> >   Attach a remote USB device.
> >   .PP
> > +.HP
> > +\fBattach\fR \-\-remote=<\fIhost\fR> \-\-device=<\fdev_id\fR>
> > +.IP
> > +Attach a remote USB gadget.
> > +Only used when the remote usbipd is in device mode.
> > +.PP
> > +
> >   .HP
> >   \fBdetach\fR \-\-port=<\fIport\fR>
> >   .IP
> 
> This is a bit confusing. Please add a separate section for
> Attach a remote USB gadget complete with attach and detach
> instructions.

The detaching of a USB device and a USB gadget share the same detach
command. You attach one USB device/gadget use either one of the
above attach commands, and when you need to detach one device/gadget,
you first need `usbip port` to show the port of imported device/gadget,
for example, 

client:# usbip port
Imported USB devices
====================
Port 00: <Port in Use> at High Speed(480Mbps)
       Netchip Technology, Inc. : Pocketbook Pro 903 / Mobius 2 Action Cam / xDuoo X3 / PocketBook Pro 602
       3-1 -> usbip://localhost:3240/usbip-vudc.0
           -> remote bus/dev 000/000


then use `usbip detach --port=0` to detach the device/gadget.
Since they share the same workflow for detaching, a separate section
may not be necessary.

Meanwhile, in the example below a detach command for device mode
can be added. With the example I think the complete flow for device
mode would be made clear enough.

I will send a new version of this patch with this command added in the
example, some description rephrased and typo fixed.

> 
> > @@ -73,6 +80,14 @@ Stop exporting a device so it can be used by a local driver.
> >   List USB devices exported by a remote host.
> >   .PP
> > +.HP
> > +\fBlist\fR \-\-device
> > +.IP
> > +List USB gadgets of local usbip-vudc.
> > +Only used when the local usbipd is in device mode.
> > +This can not list usbip-vudc USB gadgets of the remote device mode usbipd.
> > +.PP
> > +
> >   .HP
> >   \fBlist\fR \-\-local
> >   .IP
> > @@ -93,5 +108,15 @@ List local USB devices.
> >       client:# usbip detach --port=0
> >           - Detach the usb device.
> > +The following example shows the use of device mode
> > +
> > +    server:# usbip list --device
> > +        - Note this is the server side
> > +
> > +    client:# modprobe vhci-hcd
> > +
> > +    client:# usbip attach --remote=server --device=usbip-vudc.0
> > +        - Connect the remote USB gadget
> > +
> >   .SH "SEE ALSO"
> >   \fBusbipd\fP\fB(8)\fB\fP
> > diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
> > index fb62a756893b..53c8d5792de6 100644
> > --- a/tools/usb/usbip/doc/usbipd.8
> > +++ b/tools/usb/usbip/doc/usbipd.8
> > @@ -29,6 +29,12 @@ Bind to IPv4. Default is both.
> >   Bind to IPv6. Default is both.
> >   .PP
> > +.HP
> > +\fB\-e\fR, \fB\-\-device\fR
> > +.IP
> > +Run in device mode. Rather than drive an attached device, create a virtual UDC to bind gadgets to.
> > +.PP
> > +
> >   .HP
> >   \fB\-D\fR, \fB\-\-daemon\fR
> >   .IP
> > @@ -86,6 +92,22 @@ USB/IP client can connect and use exported devices.
> >           - A usb device 1-2 is now exportable to other hosts!
> >           - Use 'usbip unbind --busid=1-2' when you want to shutdown exporting and use the device locally.
> > +The following example shows the use of device mode
> > +
> > +    server:# modprobe usbip-vudc
> > +        - Use /sys/class/udc/ interface
> > +        - usbip-host is independent of this module.
> > +
> > +    server:# usbipd -e -D
> > +        - Start usbip daemon in device mode.
> > +
> > +    server:# modprobe g_mass_storage file=/tmp/tmp.img
> > +        - Bind a gadget to usbip-vudc
> > +        - in this example, a mass storage gadget is bound
> > +
> > +    server:# usbip list --device
> > +        - Note this is the server side
> > +
> >   .SH "SEE ALSO"
> >   \fBusbip\fP\fB(8)\fB\fP
> > 
> 
> thanks,
> -- Shuah
> 

