Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54633C7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhCOUhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:37:23 -0400
Received: from mail-eopbgr1310129.outbound.protection.outlook.com ([40.107.131.129]:16512
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229549AbhCOUhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia0xuSfVTu7KmfezcWToWjd7xpIp4+Phs3h2miypP5PM7lnH4elrnlhRxJAU3JnlBLVjuRb4LcyhVeJVqF+U35wuxyM9zwN+ORq2fHvLEoMwi6zA3QZI4ZvW+i21mqffHiMV1QPKaobbHFY5t+8Gxce5X9zLN1y7WLTOV1TobOuK2R5e3HZDY77/4tscbS7B8Kc0Y5UQPbO4UA6vb94ntFFxBN6kbtoekweEz1ckCiwvxAlJSHLAzX+HttdUaWqnAqsj94wd8b+BqRq0DKlH6wV4W3cI5hfD1He4gDHWYFA13onAQ/x8nB7E0CIXHvnVjlC3kCpIL0uJbhyqtbr5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idzyL5RcvUGUkAobA5qTlyqwYYwQ+dIAd08gf2ofVyM=;
 b=dXVLJtgo0dq0jJBwJ0XGFL/cg3auQZCrLWATta0ZYpfkiCf+8XaAfpA1Bz/SSpj9sNQnFjasIp+IsXMWyGYhplKLpBrt+8YU+sA1lHY4t1R2vGVza4H4BaaOFh/x6+w19NS4qop+bliccfeOsLLMBYTh91Zvi3YmWeFKLS+u4ENS8ApEu/OipQFtLRUToda5e6hjzvCd9U36ejJowSHu9lOB0yuK3vdGWFvFC/hhaiFczu9LVPeV3aF0DAt3tr8ejn1uj3VXTers7GDht7GqYAfWPT06Xo8sD+7htnMtQv5QR6WVep+x+CzToiKBZfxLXf6WwCnJ1QxWfTun1RrlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idzyL5RcvUGUkAobA5qTlyqwYYwQ+dIAd08gf2ofVyM=;
 b=tLkGI1AjUq8TM9owIGV1L9tv1DDl6h/cJMoDpihzghvBTLthdnburUijbfzVotXG5+DUJ9fN3rK9VKtDVkUoIsSMfPXAaYFbdHsjmLSGbKk8Zwt35Km1BAAyK7B8h9Yh+ztDqyiPYxK7xnXOFVKlW9eJz2udihUxle5QPoFYnAM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB4754.apcprd03.prod.outlook.com (2603:1096:203:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11; Mon, 15 Mar
 2021 20:37:06 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 20:37:06 +0000
Date:   Tue, 16 Mar 2021 04:36:57 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] usbip: tools: add options and examples in man page
 related to device mode
Message-ID: <YE/FaQxejKplWwyL@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.10.19-1-lts 
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: BYAPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::26) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by BYAPR07CA0013.namprd07.prod.outlook.com (2603:10b6:a02:bc::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 20:37:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94288790-ab16-4641-5ccc-08d8e7f218fa
X-MS-TrafficTypeDiagnostic: HK0PR03MB4754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB4754F2C1CA96BC179DD47A9FBC6C9@HK0PR03MB4754.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GICZgc+TU88WRXxi8O/fnEt/er4ep3VEbq/BAiMWaQpYFS65NA3friYcVTFvajMUn+WlqSL2YhF/C08rNEB3dgL3T1UaN9VmpBeIb3enQK+idfbvobJTb5oKl9kHtX4BsS+Ih3fD8H98PZT+hPcqFLGsPidJRHiQN63qxCaIolIqxM3hYUVNsfIHl5OFybp4kYMl5gwpkioU+Qu7Rvl/1G3AkYGBCv35OXSs+zZnY0rOa4TDr3e51Ls5FHh6+SeL6jPuBY2QIAp0BBgDoIR8qiOdJsw5yLNZJt+CQcrj9S3YXFhnID1xB6GWFSB1P5OUS820YsqXKeZf0W/cTSZv3c62gXc+ncqF+aO9pwK68vWajDaA5fwL6CtfW6zXM1WBNF0kAcB4fhZxFC4gs+BPsMmst4DyKqDl3bT7Ceqf/7JxjBYJZJh5lRJnMX0sVCyBVxh3FIhbFrqoFDiwwvSjW/iMiaalJ3U5zF+LgsEDQEX5ZhAb200lly2vVTgWyly95rgpbl75dR0nyFiLoSTNlTm1AT5V/B6jSSgiYxDrGB8plxKbMuE2V46H2KHyfIuvHP9e8tKHSsh5aO7Du0wFieYL8RUVLlbwlylAJvC4k8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39830400003)(396003)(346002)(136003)(366004)(376002)(316002)(8936002)(86362001)(478600001)(4326008)(6486002)(2906002)(66946007)(52116002)(33716001)(786003)(9686003)(8676002)(6666004)(16526019)(66476007)(186003)(66556008)(110136005)(5660300002)(6496006)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u4GJLv2X76xCSsBzRGzuuZQy6+x++F/xalVOo9Oc+mFN8/I7ED5hBC0RAf1N?=
 =?us-ascii?Q?8f3gRsr6rCu2uD4J0ge8rF9VeBiIGygp9BT7zAU1u+0brU72UPpCua97qtPi?=
 =?us-ascii?Q?gr6oJqXNOrGtEt/wyVfy0f4ZWJjecrmDy7IbN+VgY5nzAjfYFhl7zQ6YGpNR?=
 =?us-ascii?Q?50Zq6d4FkYunz4O21Z23mBw3LuTrE7pMFyv855PNWTRyFYoS/qSPDmMDVQ1h?=
 =?us-ascii?Q?DylQ5r8wTnVcp4r0g4T/dqBwzwgE49DJO6zjX39id4mMgPI/cM36j046T9ej?=
 =?us-ascii?Q?j04HUrw7bCXEeZcltsz8s2UXP6cjWbWlwt2hau5B4hJWPWG2Gl8QjUep6yFt?=
 =?us-ascii?Q?A850t1//YRHPbBpf7K+/5J40yEy5bZWqcUvCdQI+Vr+TCrC0UD0vBbr/Ui0o?=
 =?us-ascii?Q?aOfrz+eCuL7OqcqegFjsJVDjf0gqQIUu/FBYE2BVTIyNZsXDMs6BXefhbfds?=
 =?us-ascii?Q?CTbtrAxjRS3LVY46K/uDnkb98wmFfZUmSJFrAkuwZoFjtbaEpcsnlFClwQ3y?=
 =?us-ascii?Q?UXJKRkZxtFeLxYNeqvza94cJ114OLzpjWYi7A5y7OrtQVGoQLYSIrSQbKMb7?=
 =?us-ascii?Q?GHAvqMVe4yBog5O2AseUevNt0/3t5OaEw3ZSmxj/8q4iaIZHb8vMUsPxlMKl?=
 =?us-ascii?Q?JGs6xwOeLeMhqh/sOHo6jCAUKUUgZ6Iwg1srbYxdH7lGpcl/TaSGWB+bIjAg?=
 =?us-ascii?Q?hsoDDTvMWlDxGC0/nLq2qiSoMSUexTMUVI3drFiVJERG5B4Mh5ZoviBzzn4c?=
 =?us-ascii?Q?hU0nfZoy7k1JoVGC8SGmDOTuk1xRsIIDHluRO1/+mFWlTokAH/g3dhdpUAm2?=
 =?us-ascii?Q?Ivlr80OY7XVM1a9xkmqGlCL+3fLVEtnqgA4HOB2V5Ha3gfl6HG0yVRKGOL5+?=
 =?us-ascii?Q?iK/PwfFLlSxe58TFXFpAD7jFfHid87ENd4XhFYmtCBF+RCC8QA3Xes9bFAdJ?=
 =?us-ascii?Q?iqyluc6L5oIW+UJnU7mtxgdcYGcK/pKzNCf9FM7OCqn9x1zua897rF8l/LR6?=
 =?us-ascii?Q?RbGZXsZf2XXZJwh0f6yPCdofFi58bectKp6FrHmS3Fm+f0xCW+1rNmqHOXQQ?=
 =?us-ascii?Q?hu6fMCq1YJNXoMNpBQ9E41K+9142F48GtCLtTz9orZaUGxM83BV6yrCe5bkv?=
 =?us-ascii?Q?RIHJqmaWyxwMIECYTG2/svZgGFaLtYsGub8mVfrdLg7bcK6mKu/Oum82MRHA?=
 =?us-ascii?Q?VsqmyuYBehA4Lw+doHkQ1p0okvV09rudCCJQpCWENXYVjsNSJ+WJtZ9KIIbv?=
 =?us-ascii?Q?I8GAESMdpCVaQ677ssz/cehYxYc1oDnr4SNzS0Of4ERXW9WCGTLl2WzoHMAS?=
 =?us-ascii?Q?iy5m1PyRyh1UDrKUPIpe0lEVVU/vWl5HULlN8/alIpA12g=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 94288790-ab16-4641-5ccc-08d8e7f218fa
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 20:37:06.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7whGa1dE+NPVFnd1WWCdSwEsR3m/If5TBQtQxTcXnvetMBLnAYoiIX2XUznE3o2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4754
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e0546fd8b748b19d8edd1550530da8ebad6e4b31 implemented device
mode for user space tools, however the corresponding options are not
documented in man page.

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

