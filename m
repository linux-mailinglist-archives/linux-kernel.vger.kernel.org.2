Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CC345EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhCWM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:56:28 -0400
Received: from mail-eopbgr1310104.outbound.protection.outlook.com ([40.107.131.104]:28000
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230439AbhCWMz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:55:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEXeOxhk1KctIQFYQ9u/EJepl9ARuZQQs9SfEZJdV+0oQw4FG3LEKh7CRVtInTOmlCVSECsJNdk4cLZ6DFN34vfVyLRPGIZbsuzBL/Mr8dkMo+ksQ8T/m2sfmrdgdtwOcgE6asp/Dym1u+oPauwdHouuRYjlwbrRF8L94hxYVZvsViXmROKzftVydyBChMxBBCjTUtRPLA4IuHvnj+RorTWPfQSlkR1MWUPkwsXNxIE+FfkpLDUzr/MEucl163A3dKOjeb+/E1B1qvleYDBfO/JI7hiuOzn9JxSbjdZp9FthRIfaOJZTBue2FJ2WnEOGqqyUkgN0EBIMnp58xs5FZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0MoBBq9EEdh67cphB4Ykb6Fht/r3oyQQGv6l7szdeY=;
 b=fiY2YYl+dxSapltzuFdjp30LkKJ/0lFE+XI0nuGUmsWoUaf+QwlINspH5neTunDbdgEZWl5GawLBQK3SPjRv/IDJCYxg/plcmlTeSt+3iZ/MaSFw3kMVWi3HQUoLWM8Jn+ZmYOEkIH3xbXStn7HApbUlay/5ByR7S1gM1upAYqu8o73vqtIf8SQ5U+pNUhs0lHa7ZtEiWsWaTOYao2xEbHvK0ENw/AL6IrWnTCOjHvYY8kw4/c3uRXivbKpakJIfEKdFxASLbz2V4NQoi4vBb28AEt8/U5/9wbYgaeZFB9jWPqH4pXLl0ekTBWSeN9xyz89vMKrNKE1xmZKFzKadkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0MoBBq9EEdh67cphB4Ykb6Fht/r3oyQQGv6l7szdeY=;
 b=d71JiKzx0Uk9yMGs9ANo/xPEmH4o90Lw+IcZuXDhxM9zthYvUHvF40bHmlCNYNG+k0J75WNNorlfCVSNvhlxd/K+mjqN9pE1AyllzGqEy+mUMLsNk75OTBVnBXR+O2jBqGhMvwt3DE03pyJdt1lCBTSUWoVc2lf2BjbiJJsYk9Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK2PR0302MB2451.apcprd03.prod.outlook.com (2603:1096:202:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9; Tue, 23 Mar
 2021 12:55:52 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3977.024; Tue, 23 Mar 2021
 12:55:52 +0000
Date:   Tue, 23 Mar 2021 20:55:45 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] usbip: tools: add options and examples in man page
 related to device mode
Message-ID: <YFnlUaF2njDjIhfM@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by HK2PR06CA0012.apcprd06.prod.outlook.com (2603:1096:202:2e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 12:55:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aacdb5b-075f-4367-e623-08d8edfafd80
X-MS-TrafficTypeDiagnostic: HK2PR0302MB2451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK2PR0302MB2451208191113A8B68A45C81BC649@HK2PR0302MB2451.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCnTSNDjvrQWgcJeNTKOEYv6ALmZEIHjbaJ+MxmY95Ks0/OugI7zzoyjqYwP0qR5sqSCqMBfRmQPj2bhbYLTU2ABNOwO70YyPprR/nYsEu9+gOCBXjYpq9cH6nayPloEiRbxisieVRO9vmS96nNslrCdbLmtLDIL9zgRDzqI0+g6bJUCuJ+6Oc6stdMdB+yBClfAcRyykYe0w/80GY+t1pepzbJa3fpRJIxjf+nmrHa+smdV2mbcO7mz9p+deOZG83DLvFhsLDt/P79zxunUbseV2qPHGL/rfBaHdhnY3yiKfiqJUzNyBDIx4RDmvj6warqXj++yLDPUzwkKZ6oqZq+BZ8tJWrOdtEqI6nJflIV/1EdhOjAcASG1ca/I41uUre6VCS2PjNhIfl3qWLr0mILfGZ2ikih/X9U1iwbYAZxE8SUISm5VnbU8S4TzJHd5JwVVrK7pfRJFl7B9EkTZIz0riGF9OkDAmhspxj7uAcp8HHwJxUPUgzvZZMlsHNjCrr9s3ciTFsnffS46MGWNP89J/Remz3mT7F04taUpsjbCo5EXIc4Vt4dOKmQQctm6ueWTFr8dVXenNFEL1AG0C8Ju//LW2YCjrw0tW4H6+BXs9tLdNl5U+Qj5tKRtQrVrRjkbiDNlEcKzaU7T/QD23goO8HqxQR8YyNFZTOfiD2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(396003)(366004)(346002)(136003)(39830400003)(478600001)(83380400001)(52116002)(66476007)(8676002)(66946007)(66556008)(6496006)(86362001)(2906002)(33716001)(110136005)(316002)(786003)(6666004)(9686003)(5660300002)(6486002)(4326008)(8936002)(38100700001)(16526019)(186003)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oGs1p1s0tHyl/JM2UzCi6WC+XvRbpcRb/4NgoQMRrvdFPTy0miANev9k1vjK?=
 =?us-ascii?Q?Xln5p/RHljcqXyEqwUslCdCYFhwIfJAJMWJYKT1jskFr93Eb49Q9AuiuK//w?=
 =?us-ascii?Q?ojEruIcIyle0X/OqkGx6oqRZlDSVaz5cW+1D18rb7z29RObDwk1JzGuq813o?=
 =?us-ascii?Q?FiiG3R4hdfQmMsSZ/OjOiOFUFdvWrfbV0GDf4MbTORGsU3S4VJ2mG4WY4ZB4?=
 =?us-ascii?Q?27N+QRPto32DryQORwKYouAfMCMKStXD8a7807Lkbh0jZm0w9y1ln+eHTq72?=
 =?us-ascii?Q?vIha98QKznRdQCbB+PYiZCNiNSWkf4YY6cWYT2VE++S6nmFBy12fDIMLG2Z6?=
 =?us-ascii?Q?xYnW7BP1cXktQ0K6BxTzLdPdpLJz/h//x3dd1quntVuITle0CNwpl39E0tJi?=
 =?us-ascii?Q?qMvIdWUUL7OIU88xCzgHqHDS8wistYOjNx+ClD5CElT4xM4MU686rjOhdYLR?=
 =?us-ascii?Q?j8VT8ZhP1wADjno9O08g4xZG499EL40CsXxtI50+8L3IrIZ25DLXERsqqo5S?=
 =?us-ascii?Q?dD8rDbZmpZtB9p0I5y793Mef+uiCnJbFwV5kApjpgtH6MqvdFuIfDEdSKgc0?=
 =?us-ascii?Q?hk1d967z0LIDv7FRn+8Xu3Iy/eKWEJ2zNkX8cGFxkpRrwokEQAduWRRlaowa?=
 =?us-ascii?Q?0iwupN7U5kwy7QjUydGlquFN9pDtLD6fbH1YCRhW7a5goM2q24Kc63Ix8O3M?=
 =?us-ascii?Q?ddHk8gM/uINwebeVLvJJFh3vNHFXffFFdoVm2BpVeMu/7y/lmpujPf12TTE/?=
 =?us-ascii?Q?s3/Mj3O+tdDxxiQ3yU81m7UTNd0X/EPoUjjUihVNmcIbx5vW0HAT3/7MlZTf?=
 =?us-ascii?Q?UKrTKcBudDRblHMikwvSUJu7CTyERLhhNGz6vSQzRh5ok65HpwsWg5+HdAxe?=
 =?us-ascii?Q?ofVOhA5duBhup0ccn3mWmVCVWKLmUb+rMN+XPrIEKwmAwuJjGhb4s6IZ6pH8?=
 =?us-ascii?Q?X8wTOOF/exzUdht669EcpUHtfoJnTSdXVkekCngeAws45f8/avd1mJ3NFcqM?=
 =?us-ascii?Q?1Kdz1rxiLykVJ3jqAwozTcM/Otra8FsNGBlrraWPVGISkmKYwt2zfJ1kFFkx?=
 =?us-ascii?Q?6Jb0d757GN/iQDXk1CjxDKjMl+X1DEw/Inae4E2XLrV05yLF3JuEyVVLhuqc?=
 =?us-ascii?Q?au0Xc7PKwQ4tVLorm0Gg1xB2SRshm5kBBxkHRR1bRvpfT1ZIwZoArCtFiqQj?=
 =?us-ascii?Q?QthTk3FV7BcJ4JObcQpwF7Jkhyig8Y4AbbIv7HBdy2pjDRdF++PByTR5hhnK?=
 =?us-ascii?Q?5y96lGjmx7B/Y4fzyMfNkKLpqUo6DcO2M1wtYs1TNQEKqkTlso0FUyQS9rP9?=
 =?us-ascii?Q?ew6+4Q/21Eb0JhH8va8MTR911GdUodu9RCHtS56WBpyOEQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aacdb5b-075f-4367-e623-08d8edfafd80
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 12:55:52.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFrq24nsbIzxNBtBR7jejxen67yEia/r7iH/CUD6s98Z47YgnlOFsCnNW7Ea8B+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e0546fd8b748 ("usbip: tools: Start using VUDC backend in
usbip tools") implemented device mode for user space tools, however the
corresponding options are not documented in man page.

This commit documents the options and provides examples on device mode.

Signed-off-by: Hongren Zheng <i@zenithal.me>
---
 tools/usb/usbip/doc/usbip.8  | 25 +++++++++++++++++++++++++
 tools/usb/usbip/doc/usbipd.8 | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

PATCH v2:
    Add signed-off-by line

PATCH v3:
    Move patch changelog after the marker line
    Remove nickname in signed-off-by line

PATCH v4:
    Use commit short hash and message instead of long hash only when
      referring to commit in the kernel

diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
index a15d20063b98..385b0eda8746 100644
--- a/tools/usb/usbip/doc/usbip.8
+++ b/tools/usb/usbip/doc/usbip.8
@@ -49,6 +49,13 @@ then exit.
 Attach a remote USB device.
 .PP
 
+.HP
+\fBattach\fR \-\-remote=<\fIhost\fR> \-\-device=<\fdev_id\fR>
+.IP
+Attach a remote USB gadget.
+Only used when the remote usbipd is in device mode.
+.PP
+
 .HP
 \fBdetach\fR \-\-port=<\fIport\fR>
 .IP
@@ -73,6 +80,14 @@ Stop exporting a device so it can be used by a local driver.
 List USB devices exported by a remote host.
 .PP
 
+.HP
+\fBlist\fR \-\-device
+.IP
+List USB gadgets of local usbip-vudc.
+Only used when the local usbipd is in device mode.
+This can not list usbip-vudc USB gadgets of the remote device mode usbipd.
+.PP
+
 .HP
 \fBlist\fR \-\-local
 .IP
@@ -93,5 +108,15 @@ List local USB devices.
     client:# usbip detach --port=0
         - Detach the usb device.
 
+The following example shows the use of device mode
+
+    server:# usbip list --device
+        - Note this is the server side
+
+    client:# modprobe vhci-hcd
+
+    client:# usbip attach --remote=server --device=usbip-vudc.0
+        - Connect the remote USB gadget
+
 .SH "SEE ALSO"
 \fBusbipd\fP\fB(8)\fB\fP
diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
index fb62a756893b..53c8d5792de6 100644
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
@@ -86,6 +92,22 @@ USB/IP client can connect and use exported devices.
         - A usb device 1-2 is now exportable to other hosts!
         - Use 'usbip unbind --busid=1-2' when you want to shutdown exporting and use the device locally.
 
+The following example shows the use of device mode
+
+    server:# modprobe usbip-vudc
+        - Use /sys/class/udc/ interface
+        - usbip-host is independent of this module.
+
+    server:# usbipd -e -D
+        - Start usbip daemon in device mode.
+
+    server:# modprobe g_mass_storage file=/tmp/tmp.img
+        - Bind a gadget to usbip-vudc
+        - in this example, a mass storage gadget is bound
+
+    server:# usbip list --device
+        - Note this is the server side
+
 .SH "SEE ALSO"
 \fBusbip\fP\fB(8)\fB\fP
 
-- 
2.30.1

