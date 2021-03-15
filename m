Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4242233B366
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCONNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:13:49 -0400
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:14944
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229506AbhCONNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:13:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls4MMpPPUt4OHz9nO6GLJPfqHAS1PNjWeZgtIFJ4UNOzq87cVvKp8gBGOFIa5vglhqiiwX81DZIn07Jx8h6syfc3wa5iC0AHnBvrBMtwTcAm3EDkp/sag4ljJn4CU6A9IOv68fVvSNSThmyLlQFHWvdfEjpiKTZ/Yue2nQR/XSLrj7muZdm2oqjcUfB/uNdsZj2rQjXJ2+mdpEjGd8tLlcVBX8wGQgt8EQtk71dkWwOOqnTuxlSasruEOv3bHOizWXcx+GlE0igdr4+JmaH9EbEiy7aTbrgglngJ0nvtEMiLYl4xrauw9D4iUfNNWZN37O6I6u7PF9ILoeK3Xgz2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klQ1NfsFX40ya5Aq4rdU9dFmKP9rpMMK74ls1bm/WqM=;
 b=dk6y+zeRHJNj0V7knoP8ZJidnOd2wVFNDudiUYlJ+kVBxMdUY5CGKaA0sBkt4F2G3IH0eE4kctXWS850TPiuDb+9rMui3F4ryx5g98aYgKDvZD5rS/O1FDA+gkWXoOU6TpAYQl9R3SwohRT4y/fS4zt6j6+bS1BIjWTLrawGhdbXaVAomtNgslS+B8Mc4B3B2lBdyUIsgjSiP4Dxl+sd4tR9VoRFHBRC6eaijzp/Q0ajy41xhEuQt7jYpVN3N9m+3HpFRFVffcV9vpmGqkf3QLaZAE9cI1xsR3gomKYQ0Zm9XONQIvdLEx0VlrUZHR0i9xGKGstDFP/GuZHoQSTy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klQ1NfsFX40ya5Aq4rdU9dFmKP9rpMMK74ls1bm/WqM=;
 b=nSL92wVNdjimsLDSAuLnPhoni4HFq8ySewApFSJO0d4UmnFEoCTftl/dO24G8R5h9Z9Wes47ZgioNz6sQcNlH4lib/Q+W/Oz4RMC8zxIAYFNbwhkTmCj7LAselWdGlQQvYnteC5es7aq9tbOECmPfdWG9wWJ3+MGsJSRxQhChMY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB3156.apcprd03.prod.outlook.com (2603:1096:203:4b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13; Mon, 15 Mar
 2021 13:13:30 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 13:13:30 +0000
Date:   Mon, 15 Mar 2021 21:13:18 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] usbip: tools: add options and examples in man page
 related to device mode
Message-ID: <YE9dbrWjL5DZ8Hm8@Sun>
References: <YE9Vyrs+Z8MusjDM@Sun>
 <YE9Wo8QZ/0XU8Mzq@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9Wo8QZ/0XU8Mzq@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by BYAPR11CA0050.namprd11.prod.outlook.com (2603:10b6:a03:80::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 13:13:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2740c7f-e1ba-44fb-2da7-08d8e7b4209b
X-MS-TrafficTypeDiagnostic: HK0PR03MB3156:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB3156F725B46FD1C9DFEC9E49BC6C9@HK0PR03MB3156.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFtodXED8GOBVfP2HvYYRpy0nzFpP+XknKH8WaIfbHkLMHSibdNj6WJvZpF1Xu7RK61IwvEKuFlLEay7Sg5bZPJpnX60D8STE2VsZ7b6VtGBqZzVDmsXrejI4zv650wvdcLgjkCE00VQGT/PuMPGuEp1wDp891tc1SkV2BKEzH++ikWBR1alQnE+Oim/cPzfDv0wJIsiGvzC20AKnTTLSUnksu7/51RiBPF+2PpKnwv3GVZgGrt2FpqrxnKCqtbaLQfjXKUzthRodCiOdg6F02yN3T7RzIV/GQ8QzXNaJChIL1lvyaoY1+EZx7z8yGbYkkG+8MdsQdpwRLi1E8smdzwfjNsk5zuBqyHTy9oH1FJv2Y7cLH2t3jvQRfb1reI+Z7mO6/JByZ54jTpeIG2T0S+JaPegUIq7dRFNO/qlAhv+oqXa8TIWS6VrENH8FXgZH3gcNcpL+KkN9CytgLLTJlX7AjuGnChlqk3Dtojo4V7Q4tpFxIldtbirw/dvJ5rm2QP/3V1kdDz0fLl4I/VdiJ4Pw0Hbp5uScTT3A7I+hR+T8+Trm+mb1VzNbysmmpkRCJ4UelWZwSAPQnDabS4S6qZ2b47ZQ+tEmAgzBFR+KSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(366004)(346002)(376002)(39830400003)(136003)(316002)(66556008)(110136005)(4326008)(786003)(478600001)(52116002)(6496006)(2906002)(186003)(6666004)(66476007)(5660300002)(8936002)(66946007)(16526019)(8676002)(33716001)(9686003)(6486002)(86362001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pNDVJAHFvG2xcLXzakYNMK240kdw3GwIj/vvgEQMNkz1KZT7mXSe+1Vu7OY0?=
 =?us-ascii?Q?+WAQr0s1Vmguuj/y7EqAAkHEO3Kv9zcQdwXY9aMHXcIhKjcYwAUhtqWOY02I?=
 =?us-ascii?Q?e9D54VZr6yp3BfGhjP2walYyqRp5+XB1Aiadtc5lfpQe9UjJZGCKwwbQHks6?=
 =?us-ascii?Q?j3p+UkS8mlCn5mNgE/xQiLjNPeo5kYn0fAatbUcwojunxezBtGYC7yXlgCcW?=
 =?us-ascii?Q?rDc/n8w25vzxH8UIA+2FB7T0TcKmiErVHS1yeUaSIxIaIsRACtb/OGE3G+eQ?=
 =?us-ascii?Q?j+KNMVL3QAad8OcVpkQmoYLudkZnUFv9yylvCUOALdpdWqII/U+uYwjaWHIl?=
 =?us-ascii?Q?QE6pGITxyNnNnXPcjSCSPdTj82H9qU7dJ6F4AuxLr2TonZZxVSoKDl+jUYCJ?=
 =?us-ascii?Q?Nhp9HZbTz5exPpvdFSMbggcKCGv4ETZ8WGKOQQKjcNzxHMxQ+oPG6A1IEv5B?=
 =?us-ascii?Q?l2zlIjJJzoPR/ZyqGlWrJrxOb6AwW1bmKrvXIJcMdVy10OzfRQh3TKb5xB2T?=
 =?us-ascii?Q?43TXr7nADgWJCabvqL3B+upIHBFXWoGRfKbw8OWO9WqnM/V+ZxSHcEpoVKmg?=
 =?us-ascii?Q?O1L+onGzlUnfkFpNWg73qTy4xzsC0qlApvBVJCkOMqTqAgwUv1WFwjpQFx89?=
 =?us-ascii?Q?odGAbQwWtCDntZrs+xHEA2C4BsUo0ve07lLIJInAqK+qwxCrOoPAybhv2mVk?=
 =?us-ascii?Q?/CnwKzjpuFKkFOSRtuYNVfoAOqxvRj9sa+YZHOPCaXuIxDWGZ3hjMRoWpJAK?=
 =?us-ascii?Q?2eOL2qYfY9RqLaVDbQYa+AeEzyHv7L/0j1Ju3Cqy9jBwe2WLiRDtZ8jogm/a?=
 =?us-ascii?Q?VJQQygqqrwrZn9etpFutKuySjwN4IPhIhinWqPVLAEcJ/zc3aFwvi0ieyZRk?=
 =?us-ascii?Q?BWbSm/oudDTiWy58MbAxsUxff3gbh2olH5CeTHNyS6Z4JMob6EIpl2lPJa9Y?=
 =?us-ascii?Q?M4QU/Rz33dJTYEEAOSHX2kNhr6rWu4wFbZdGzDDUbVBxsQK6SlwUqPLzaxRP?=
 =?us-ascii?Q?+iPsZKQAHDjrk+ZAiJu4h+QMuKMMsjfDScGdoJfXQBNXG/jGwhvt7ahxZjy+?=
 =?us-ascii?Q?PDwsa/eNAg/BIy5x2JmzTg+2kvEg+xFhFa2w4W7T0WkGUlRQVVUjDzhkG1Tb?=
 =?us-ascii?Q?il9VbJhO6KDwZt3kbg1K85Mkv0hIsYd56wTVZ4O+ulK58+EQIu/OJOsyBK+B?=
 =?us-ascii?Q?StfneVt2G1vwmbPf2RBjkpAtUs39dXMneeZf4PJgXkmjEz8C2Og03h4anJny?=
 =?us-ascii?Q?ZbWCOezdxJzm3u7Weo9Se9YRoPld4Y4zimjlgwkL9qkZ8Fha4V82K9YrUYOB?=
 =?us-ascii?Q?O9PFgSHywWz5YYbWVdr/Wez6qGVQUIBTskY8VcMMgl0ouA=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: d2740c7f-e1ba-44fb-2da7-08d8e7b4209b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 13:13:30.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC8OYDjzZjGNS0h7fCQuzOgznZIj40DT8C2XMSbRat6OluaXI1D/XVY9AAuU0srI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3156
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e0546fd8b748b19d8edd1550530da8ebad6e4b31 implemented device
mode for user space tools, however the corresponding options are not
documented in man page.

This commit documents the options and provides examples on device mode.

PATCH v2:
Add signed-off-by line

Signed-off-by: "Hongren Zheng (Zenithal)" <i@zenithal.me>
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

