Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093EB33B2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCOMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:41:07 -0400
Received: from mail-eopbgr1300128.outbound.protection.outlook.com ([40.107.130.128]:12653
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhCOMk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:40:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fogYbbbd7Y9pg/pbrPowU5qwlkSKnIw6UVUS8aE0zMhT+w8nRyJhByZ2q6GYVdpc+qowszV0GikRcteruL6mbyZ/DZY2H7GfYfXACbilkFp2WDVB6YGZTPkwxPFIu/2QpWZwA6E3rFIoQ//GCrKoMpuMJ9KGc5FGG1giaw/4uRraToO4yG65LQfpksDfyLCntkXkCsNhhyAMun2NggklXAbzEbYb2m7UgLLy/db/jmis6t/w5SBH1gs+HHmFIAmdRxF6d7WAIG9iqmXQuYNkap6vuwVNNpIUMuhLlqvRsH3sHXXPPfQVZ2A6SOarI3UYOQksbOWQWcLqqdtVFWyknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9aaBHrb6uLyhXAGQ8QIN8V4QPUIajTTdzI9fvoN7vs=;
 b=ZSLjdS6FV8B1bnueUbIk3Qm1xhEwqbY1Y8fZTrVASUsppCpe11kmUqlbU2C8+S5ndJVvnH1HrqD2ishRMbnuxkli3yWvK/z1I+GGrmw+k1RiIj9ZyIOs3FMdX+zk22XJE4YHVVvu9znPJp1A3jo5mUNITPd4G6F2rARnQC7j+apB3yDpPxk7/csvPSbAenU2WVK80OR4fMlSe3GuRnXX2Y94qlW7a+8G0xTpjZfE2Uw3nqKe29EVn9XEorU2KVfN03pBdqGekVA8RZULvOO5wzL4R82/JCiYPkSuvAF2NtFXN+Gaasjsw5HCpUwIHSMlQ67pufWYQH3+uV/k6B1HmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9aaBHrb6uLyhXAGQ8QIN8V4QPUIajTTdzI9fvoN7vs=;
 b=T2/GuXZjL/2Is20OR//E5z/DS55I08X38BV0zWk/uODt87dU3Y1lc2nP+Ui+owzK5jbGQYbIVf4E1wgkqQOdMIh+AYYgOfJ9oAeBcQ3ziMWLwHkW+suExTSOydLws7k2KMk5H87KHL+/f9xxpbjfn6LdX5zGm+WWm1W6TiiHQso=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB3554.apcprd03.prod.outlook.com (2603:1096:203:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13; Mon, 15 Mar
 2021 12:40:54 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 12:40:53 +0000
Date:   Mon, 15 Mar 2021 20:40:42 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usbip: tools: add options and examples in man page
 related to device mode
Message-ID: <YE9Vyrs+Z8MusjDM@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.10.19-1-lts 
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 12:40:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 324276a6-06d0-416b-91fb-08d8e7af923a
X-MS-TrafficTypeDiagnostic: HK0PR03MB3554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB3554954739D5606AFF5A72ABBC6C9@HK0PR03MB3554.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3XxOODzyLI8jKr5d7VHz6jNm7M+CBGkdFKeNOSnbyNYMj0Q/Fvk4a4YBsciyrrz4Vu/60uRAZaupz7c+c4Q1fDAVvFD/4F2PQ5wqSlVc/GYV+t1FXVy1+50CaZpKdc5fq5tJFYsYbEXJ4nS3Jts31BzFHt98zQqskSTqgkrEkSJnJ9BeSgHw5O3W+PWdE4cVUzo2Gnz1cZxR5I/CTP6fto3udw6Qnvjz1xRYdwpTjeyL3H8oYUj0rgFr6ie3nfy5BmYP2YSeNIF/GYsKUzivPNHt3Gr6gWp/7SNmATFG4sH5BDAOSyWwrZe2v29DXQB8OEHEScPneuoYHhLXj4y20HZmyprlZ3k3BUJi0IrtmFqF9+8X2BSKvpYb0k7Xu65nyI3q4Bvhy1zOr9eIZJRK3Yt6z8RMT8EGSblkEReEf6K0y//6bf9W3cN3gaYhQ5+MNdsJI5JrVYiOz9aoyT2YxPcKQwzBZMCUGj8hZVBMaE/460aPxoUa75Skkh4JLjyFTwRgXVqGD6Arz/Q4FsdvKeTzUlJ7sPcE87/00qiN6WpA3oYXtQ0gSUKPxbPvDQ7QXW6h+MHeYxcBq6GAIXBIawEdiMBCp0vXVRqFPKZt6aewx8r2Bcd3KvhnmErkKYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(346002)(39830400003)(396003)(376002)(136003)(5660300002)(4326008)(316002)(110136005)(6666004)(786003)(2906002)(6486002)(8936002)(16526019)(186003)(86362001)(33716001)(52116002)(6496006)(478600001)(8676002)(66556008)(66946007)(66476007)(9686003)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qszyQ5AWShqFwWLdfdCcgOG7OdnFHy79r8jTZkaQSPul9HLCSFs6RkIJxcBe?=
 =?us-ascii?Q?DEs7ghxkGSkyDqxk9Q3YuKGyu6Yt590mopcT0cFOoXTyd2b8b/5HDtbPUGh0?=
 =?us-ascii?Q?K0hnGpccWU+NF52S8973CIqoZkuEyGD7e/NRkKRoI5nolqB6KNNlsgMMxudt?=
 =?us-ascii?Q?Dfdo5z/uHw1lm584QFA5t4XACsGdoU2KV68jEQQ5upUKNVoOGhfKm5vn3ECN?=
 =?us-ascii?Q?TlGVsfGPnXquiMcxSRUInd0mbunT/liJmGo9SJQeZJrZsaoLEFQpyetsXZiE?=
 =?us-ascii?Q?v1YR8zEAhXsXAMLDQGFpXMCWeHIOJHI9xIzmgEKwdX/7cmfqpi0srY8yu1mE?=
 =?us-ascii?Q?gjIql7XmwS1AhwFbNy0guDuPTKrgJv4J2URrUANZuK6eTKC7gLRy3IpKKaVR?=
 =?us-ascii?Q?EybkUO6vrbhGbncKf629k7XW5u3sflwmlXdW9YCUbMqGCs52Z/rp42Bb1ws4?=
 =?us-ascii?Q?oEIuR+MSLXXBz1yJX2SRDGv91o4FMyddlrC5x8Fz0JnNxIfkmFf+vSw3KCvV?=
 =?us-ascii?Q?CegH4DO3+HqMzcr5iixatPU8OqY2eaiKsy03RSvTqvWz4RVlVctNW/oLe530?=
 =?us-ascii?Q?ZQKjeJ5v3I8YYywzrgvcQRLExGRx1kkqPz2Pl3+BRsX2tlOPe5ljbtNP3B0p?=
 =?us-ascii?Q?veaY6IfG7aNe4M3FC16wC9IBg03XyWd+BLrm9zv6d3EFt4hbZNBieqDayssV?=
 =?us-ascii?Q?f5Vu1LMCoDVRKFYgDyGk8WJy5Uzcv//uI7cZayQJYaCn9VjfBJwTOzzW16QT?=
 =?us-ascii?Q?qmTaJr0/aZJZn7vtzN5bTB0Z253vaSxAxz/NxJ+ERqcTKtGmxbDnM1RKldQP?=
 =?us-ascii?Q?lOozykE+MDbP+yY672aVvDLlTZrtqwF33hd74Lf85XrWaM1PHCnPeyw0prf4?=
 =?us-ascii?Q?w8HVzMX+XnC7VbEXyb6UTGJ7TCFkkVG0BQ1uscTadd2cmwn28aCqbLSZqiGb?=
 =?us-ascii?Q?i9cZrjFAoJTsqrXivcDZlGeOeOTxuWJRzWbpuvsfvRFTgD+9GVWcPr9c92xV?=
 =?us-ascii?Q?yUoaTrcuz+v9/WLw2fBatT8UfZvOkk/TdvjtUXmm8+OfV+lttdv2IZReQY0t?=
 =?us-ascii?Q?+M/uv9BZgbX4ZCnZlEjOlR1uSWusUFZ1Q2vn04FMWqqYegX/orGqOXeMFVBx?=
 =?us-ascii?Q?Ko+1pckB9iP2Lkhwale3CCKwns4P9Gm1I1Ab3Npto6+FKl3RR9qCM0kIkzmK?=
 =?us-ascii?Q?vNp6/GMRNbejSuY7jWvHYm1Ezas/VG/Mlk218egCSiob6FZpB+le2IZEDa8d?=
 =?us-ascii?Q?/osqE/y5jogIMudEW578rt8BXoS5QJB2KMfvZGlYXE+hG5FD0II+uCvNgNLi?=
 =?us-ascii?Q?TY7WpkrxjPpB9jz9JmbnE1r0V6RZa9qlJPOic99vO2wYNw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 324276a6-06d0-416b-91fb-08d8e7af923a
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:40:53.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDpd/ZPvL/v7LODCFVoCt7eC0K1EuOWCyUB6KHlp9HxE0OJcDAZ+c51fTSJA/Ob4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3554
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e0546fd8b748b19d8edd1550530da8ebad6e4b31 implemented device
mode for user space tools, however the corresponding options are not
documented in man page.

This commit documents the options and provides examples on device mode.
---
 tools/usb/usbip/doc/usbip.8  | 25 +++++++++++++++++++++++++
 tools/usb/usbip/doc/usbipd.8 | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

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
