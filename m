Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88523471AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCXGg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:36:26 -0400
Received: from mail-eopbgr1320093.outbound.protection.outlook.com ([40.107.132.93]:42752
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229548AbhCXGgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H21ymyoqibJwsHJWnQ4v6fct6zQs/55HMquyHtGA/SM0Zivx4PTnygZCpyXr/cGRgI0FyWyROQqblhBNbDd1jJSnGqRLCkFiOEvPTtuwWZj+FTLv6S4hmnT+qZ4RxSZX7uu9W3Ci0DzmWDsfR3ItavfnmvBHCfXKldCFIxAT86i8DxPAGjseRYDTwyK4MoIhmYTQxUR1+GB1C4rsYJyLR6VefOnNjHRfShFvv1+BSY+2qKEv1+VG5Z7/uJCgHQ4W0LE83tJ9BVTzsD3SqVbbo2J1jGigYX7Qmail0xdT7l0Ha8wpW1rQO+CLx7BHxa3ZcR7TlpORNpDz6Q5C5oglTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcvk6kwtyus4t9MsVWrtIbXn+BjZvBcf1TlRlM9T5JA=;
 b=l8EPffmmCq8miY9QuNmx0c/s052VBvAFnFX09RtM/kJUjLlM8oIRg19Z1f7pLV1h8oTr6BL6V5DelzFm+JK7NfSvjXP1WJOktW4m0e6pBInacNCiyPpghs2RkKuSbKXjcI/elvXHEayiHb5lWqm4J0OwkZOAPmx9kkMI8p3iPyeE2yKSoyHQXpJahbmu8BxqKXmPFmN9Ok9Ei7VdCBU0y0S2Spm1n0x6eKmMPCrX0IovKne7m3v9YEmGZaICR5/aUIs4MJpipBvTycEIA7NSrFknStWvGSw57aIJKDrgkd+Ww0HD1A6epFIqiNbLuvY1lsF77NK+aMJlDFVhyEMLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcvk6kwtyus4t9MsVWrtIbXn+BjZvBcf1TlRlM9T5JA=;
 b=Qa0OG22Jg6eU2IxjYc9esoY8N9ldjch9Jk3dA3IDJbqbrToxCkM7foTpOfIXYj5NXHptT1T3zWmkgiCjV8O61htgUIKXMrxgEJ1OJCZO6iy5bp+wc55IHsq5Xy44BRQbmZ4Uhv15v0MeI132CxtnuW3UkjmF6/q+/ggQqG0eCvk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK2PR03MB4546.apcprd03.prod.outlook.com (2603:1096:202:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9; Wed, 24 Mar
 2021 06:36:05 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 06:36:04 +0000
Date:   Wed, 24 Mar 2021 14:35:52 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] usbip: tools: add options and examples in man page
 related to device mode
Message-ID: <YFrdyKKx1nx8bktm@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFrBz6dvTip9+wm7@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by BYAPR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:40::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Wed, 24 Mar 2021 06:36:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a633e9e8-5245-4ca9-7cd3-08d8ee8f17e9
X-MS-TrafficTypeDiagnostic: HK2PR03MB4546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK2PR03MB4546BF475D4C24F95DE18BF8BC639@HK2PR03MB4546.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV9QfIbrN1JY/zCumW/Gs3ytypS1lzTzRv2b6yQIrVnSwNKbtBWZiWI8SNjmoHr5L2WtGfgAHwLfJ6eRQloOxFL6ZA9Zot/LnwiPsJWpDwnE4S4x97oq4WKKh2dPKzqkkIRjVVfIKGxLWl9fPTEOo+VI3zOCuT+q1ll7HPl54sAMJ7Ujd5BiC/+YeRFolRV17al7OaAQaTqacIyClIxkY4McaB9PCSEcHVfdgHP9DRUukdpH9cHCeDwzZklBPqlAbmQbNRy73uR/k1n9/8jrwMc6tww8c1uzBD9LoX57U8XoMcuqJ2dqnp7j16P8l0SzAA4ANxBFtm2uXSV7tYlWI7QLe1aqlPV3UgGEHV9+HhRadErNjW7ypG28a0qZ7XcfzZnPU175XCtKCSz5aDf8hhYTNfs9gC5zaU+BDV2nPUbD6MUywCU+QsrBHqxnhZikdw4y/bZNI/Dv2fYEEPz7lkjaaBKdAG/viiSfGv6SbzErVs5tinuKOygMfOT9NBBSOdQvWHUS6KCVxjJAgzP/08p7UQVQSKpOL3yLsTyW8DPUoirOPrQ7iy/FHiwerRfXPEOILIoiM5IxRdCKKzGSzsZv671iofWIU/SmLpsZmz76mXK5MPIw7g0VcHIdmlvnf+kaLgX2b75A62jKqUtDw/fP44dAR4rAOGkZ/XlvC3ZdWcQlFqLI0G+c79hv0gIG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(376002)(346002)(366004)(39830400003)(136003)(83380400001)(6496006)(86362001)(8676002)(2906002)(5660300002)(9686003)(33716001)(6486002)(16526019)(66556008)(52116002)(478600001)(66476007)(186003)(66946007)(316002)(8936002)(6666004)(786003)(38100700001)(4326008)(110136005)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PVh0gXhqqgFPV0YT9Uxf8yN2KEfS27+MDxRbJAfYnWbtb4mgzKWnGdPUzxVh?=
 =?us-ascii?Q?SWmgglbXMY9vtTSl2uHG79/WUOMWa5NqBG/9Rw9nmxPx3jhtQVJUIgX8A1Dl?=
 =?us-ascii?Q?bhQgj2bP/2Sx++52WQgQRXXbU8Y1KrxAvCKppskfzayhVCVXkF0DyJGt7s9b?=
 =?us-ascii?Q?uoCMHrLqOzVnvIXNuJ50jIbI43ayrUDvN8toVSfEfQ7V29GfL9p999qy3kfe?=
 =?us-ascii?Q?D36NAhpr1+mCIwDOOYVZVmLEDalF28jlhw83YFaUfJ/p3Sm4h3HXDns5POqc?=
 =?us-ascii?Q?ybyoABderfOmftGGltm7LkGzjF3estY85cjr+JYG8q57li8ZkAyPKb9Sppnm?=
 =?us-ascii?Q?qJ5ZARjZpWSii3EFgkkZz/AHcxoT+JAR1JcBwYqDXz0hqCLt4QAmUQ7yp2xU?=
 =?us-ascii?Q?/wrbeWPFxwc99pNxOB6YU4hF1oUyDjzxB/FdUlCke+YnP3fGICpY2YWzD2Zk?=
 =?us-ascii?Q?3Ip8DURWqPxqGwvBG4s3p2HH032txyIxtgFpKkCaiJd5un9JpUqp1WIeFBDP?=
 =?us-ascii?Q?0I8tNe1C/d3+yu0/74czOpXUgiPtju4h2dIveLhzTpE172I2xaIEh1JbspXF?=
 =?us-ascii?Q?UvvOWJnuf1tqOFcxnCsOpdnYbtAbXkurgVt6PRQuEizv9RNy8DA8ePIWGvtj?=
 =?us-ascii?Q?iDYdzG7+9f2r2LtFv0BOWwGiyHfL2f6/ohW4Ur121SYBLCqj/RFxBPt/D62G?=
 =?us-ascii?Q?t4bpVqWc2goce2sCzWmvbtpkUuREhUkoUI2atM+ikxfPTW1DI9afhEXqBVl2?=
 =?us-ascii?Q?Ad3IZxp0ZHH2NG/gm7TV42qUV8x7fhGqZo+RM76YUXacfKnql5URalG2gPJa?=
 =?us-ascii?Q?Q4RlvKJnNWvJKdo1yHKyERmJaz31r+a7C1TbmnI3/22eVRXbxY9qnQ7wtC93?=
 =?us-ascii?Q?LASxrA2687Q4s1DcGM9d11YlSv/xZqOmS5qOXqB0zZjeEfIeujZebzLIts/L?=
 =?us-ascii?Q?dO+djcGSXuMdfoWPhMQ3Y1gcAlTQnNeU9qYiqo5HTHwWBM+qYIBSYlEF6g5i?=
 =?us-ascii?Q?Mxu/YLFHBA0KIpuRr1agDTL+zihqtcbgjXEYeK9RKjmVNc2njTJM4nuHb6aY?=
 =?us-ascii?Q?+Wb0a6P2tnXfPLMDC1LHjZL4D4D6IFvw1ysidoW/n5zfvxztRVd/vdQakdKY?=
 =?us-ascii?Q?ATNu38z6mr5ri7o0puLNmOnl5Jxv+Ifq2l+fE7CHqYpvZHTi6Cpl+z9aCLnI?=
 =?us-ascii?Q?L33vdYE4xdgjTaZ4B12+t+MCsnnod2yT4w7a4jsUGfmTCGGB9AvkmkWACDQQ?=
 =?us-ascii?Q?ioK4Ko8Xo+vO1ibVMrSt5nRH5HZxC2RUK7TeyLsDzFqtm4UTbsCYhvEc44bQ?=
 =?us-ascii?Q?i4jXFwErlvsa1aCMlEniRxu+jPxQNr0J5Er73sOZ+fUZOg=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: a633e9e8-5245-4ca9-7cd3-08d8ee8f17e9
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 06:36:04.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNDz6ghySqlKSCzrhxnf6SrT3mj6zz0Y5BUysiw3nYjPi/WNRsVvwd+OWwLrTL/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e0546fd8b748 ("usbip: tools: Start using VUDC backend in
usbip tools") implemented device mode for user space tools, however the
corresponding options are not documented in man page.

This commit documents the options and provides examples on device mode.
Also the command `usbip port` is documented.

Signed-off-by: Hongren Zheng <i@zenithal.me>
---
 tools/usb/usbip/doc/usbip.8  | 42 +++++++++++++++++++++++++++++++++++-
 tools/usb/usbip/doc/usbipd.8 | 26 ++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

PATCH v2:
     Add signed-off-by line

PATCH v3:
     Move patch changelog after the marker line
     Remove nickname in signed-off-by line

PATCH v4:
     Use commit short hash and message instead of long hash only when
       referring to commit in the kernel

PATCH v5:
    Add documentation of `usbip port` and its usage in examples
    Add flow of detaching in examples
    Rephrase some description and add punctuations
    Fix typo of `usbip attach --ev-id` to `--dev-id`

diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
index a15d20063b98..1f26e4a00638 100644
--- a/tools/usb/usbip/doc/usbip.8
+++ b/tools/usb/usbip/doc/usbip.8
@@ -49,10 +49,17 @@ then exit.
 Attach a remote USB device.
 .PP
 
+.HP
+\fBattach\fR \-\-remote=<\fIhost\fR> \-\-device=<\fIdev_id\fR>
+.IP
+Attach a remote USB gadget.
+Only used when the remote usbipd is in device mode.
+.PP
+
 .HP
 \fBdetach\fR \-\-port=<\fIport\fR>
 .IP
-Detach an imported USB device.
+Detach an imported USB device/gadget.
 .PP
 
 .HP
@@ -73,12 +80,26 @@ Stop exporting a device so it can be used by a local driver.
 List USB devices exported by a remote host.
 .PP
 
+.HP
+\fBlist\fR \-\-device
+.IP
+List USB gadgets of local usbip-vudc.
+Only used when the local usbipd is in device mode.
+Note that this can not list usbip-vudc USB gadgets of the remote device mode usbipd.
+.PP
+
 .HP
 \fBlist\fR \-\-local
 .IP
 List local USB devices.
 .PP
 
+.HP
+\fBport\fR
+.IP
+List imported devices/gadgets.
+.PP
+
 
 .SH EXAMPLES
 
@@ -90,8 +111,27 @@ List local USB devices.
     client:# usbip attach --remote=server --busid=1-2
         - Connect the remote USB device.
 
+    client:# usbip port
+        - List imported devices/gadgets.
+
     client:# usbip detach --port=0
         - Detach the usb device.
 
+The following example shows the usage of device mode
+
+    server:# usbip list --device
+        - List gadgets exported by local usbipd server.
+
+    client:# modprobe vhci-hcd
+
+    client:# usbip attach --remote=server --device=usbip-vudc.0
+        - Connect the remote USB gadget.
+
+    client:# usbip port
+        - List imported devices/gadgets.
+
+    client:# usbip detach --port=0
+        - Detach the usb gadget.
+
 .SH "SEE ALSO"
 \fBusbipd\fP\fB(8)\fB\fP
diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
index fb62a756893b..d974394f86a1 100644
--- a/tools/usb/usbip/doc/usbipd.8
+++ b/tools/usb/usbip/doc/usbipd.8
@@ -29,6 +29,12 @@ Bind to IPv4. Default is both.
 Bind to IPv6. Default is both.
 .PP
 
+.HP
+\fB\-e\fR, \fB\-\-device\fR
+.IP
+Run in device mode. Rather than drive an attached device, create a virtual UDC to bind gadgets to.
+.PP
+
 .HP
 \fB\-D\fR, \fB\-\-daemon\fR
 .IP
@@ -86,6 +92,26 @@ USB/IP client can connect and use exported devices.
         - A usb device 1-2 is now exportable to other hosts!
         - Use 'usbip unbind --busid=1-2' when you want to shutdown exporting and use the device locally.
 
+The following example shows the usage of device mode
+
+    server:# modprobe usbip-vudc
+        - Use /sys/class/udc/ interface.
+        - usbip-host is independent of this module.
+
+    server:# usbipd -e -D
+        - Start usbip daemon in device mode.
+
+    server:# modprobe g_mass_storage file=/tmp/tmp.img
+        - Bind a gadget to usbip-vudc.
+        - in this example, a mass storage gadget is bound.
+
+    server:# usbip list --device
+        - List gadgets exported by local usbipd server.
+
+    server:# modprobe -r g_mass_storage
+        - Unbind a gadget from usbip-vudc.
+        - in this example, the previous mass storage gadget is unbound.
+
 .SH "SEE ALSO"
 \fBusbip\fP\fB(8)\fB\fP
 
-- 
2.30.1

