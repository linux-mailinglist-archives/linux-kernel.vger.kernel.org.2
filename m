Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3079B33AB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhCOGTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:19:32 -0400
Received: from mail-eopbgr1320114.outbound.protection.outlook.com ([40.107.132.114]:29216
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229948AbhCOGS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z19u9jhbG1/Q4a05LodptlgSo60pQJ95cle8kPD+XwU5mRfD/MZ/CTVTq7R/PAMBz/9bUjwXgg9vqggX3P3NJXWID8qgANe2/VrVNDXZIVi+jcqHNaAk/w3w3usNR7TWxMWrFobq4v3rwH9W0gijFNrW7MAICV9T0ztuS6C76hlNDlohIxt8JRtwHARHFeaY8DzK8dX1ZXL/vf8U95QkvlKrV/RHyV7uZhPNUbvYrrUNQrrBFcYc+0rQT17hIJO3FffSiJ/dAFp+TXaAKfTv+PowzcQBewVX54GVSDPFa/CtLasYLlqaY4IAMLXOHj5T0JP2N1xFcuj1XeIFfgOQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sRAfe7x8OShMKfGORrqMPA+j8JpffFyGtpyZsAeXW4=;
 b=C8KPhAG9i51PlLATnZO99emLXtaBA0mx2z/G481Zh6mAttwFo8tukEmdzMcPys/c+GgiixRO0JJChwWUT4pMgotDAT+Msl5MCG++G4VSsiOP4gqlKuG2P9aipI1uM6DKM+S2cmO8dtIIeNg39huxxA4jhedjpuqYMNtgoaTVbhi8dkBnysST8An+VzZnphXbFbPoQ+05zHHIH0uXMGCo5irwyZRrHp0LsrnXQKpXO/nU4qCUfVyV0IGF0D0IusX7XMlgJ66B1O0ghvmZDrT2C8NcbB3SEnfWB6NVPJlsdgqfE3Bnlin9wWXg+UNbeJLOKDP8mNZ8BRhmswySDQbiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sRAfe7x8OShMKfGORrqMPA+j8JpffFyGtpyZsAeXW4=;
 b=jOk7qOu5vj2Th7VrkWtaNttxC+kTIO053wHmt/f2UUv6VKBHAqDxUdpAkSZHOGm8iamNBVnfTg7AsI4gXtKhvwYVHg/ZsmHsWcGT2rKbtIjws4FCCB4a8yxOqQH75pqe1ir/Abqu+i41TICmMU573k9xO60uouS+93nZ2AxI5WI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB3154.apcprd03.prod.outlook.com (2603:1096:203:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13; Mon, 15 Mar
 2021 06:18:51 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 06:18:51 +0000
Date:   Mon, 15 Mar 2021 14:18:49 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Alexandre Demers <alexandre.f.demers@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        usbip-devel@lists.sourceforge.net
Subject: [PATCH v2] docs: usbip: Fix major fields and descriptions in protocol
Message-ID: <YE78SRefRe1trldP@Sun>
References: <YE6/HQoxkraowTI7@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE6/HQoxkraowTI7@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 06:18:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2dc7e41-fb32-46d6-2fda-08d8e77a3357
X-MS-TrafficTypeDiagnostic: HK0PR03MB3154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB31545491720BB0669BC93E8FBC6C9@HK0PR03MB3154.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odX45aK1IRdTCVBoiAntyixkPjXe6sMvyY5BAhjUhmOGIajhk5PCbWtL2SiuGS6/FSmsBM6etPPY5oVtXPTiffUjR5zls3s7Kc/ibyfe8aRVvTB8KNfDwaIYRhHmnFLcVOSpSTTKta6MeKcWo9/9nAXpkTh7zzUoqEFFzsd45B9pR2JcpX1EFLxeS+Sm5I5Hsqw3WTs/uEEID2nu/X3uhGWuF+AopUd4Aq0s5FLBZJAXW7JHTHPRNg3fboJwdbEL9kv1vrxwUbrQic2f4S5HnKjkk4Rq4+53xjsQ+91bresZWx7IyrmCM+lIz2g2UmZvMZVErK31iIo4g9bXJhZpK+MhYYFiAtzFkeuIHSMOOzBHO2Rpe1skKqKRQJz48iG7fYYmWnLHat62AjNOgN3kux6wRJ1IuH3N7G3M0hdiQCvVlu2oQhPb5wOkN9bSw+8n4FVJbhzvxj6fTwwgc2BYYmNksJLGhCeNxVk+lPHNS2r32b0FWfXQMpLFNr16R2GBT28beEf8P9QiQUoF02HcTQJ23OgrKxCYQ+rY4kmaAkENTeQ9oBQYuYExbKQuFysjLsh3KpOMfpZceyRRTidTrLwuoCYb6mtTChYfyn0Xbb3CB7gHzggKMU6RSFaJjRFkI2pJiGuxtWMCkool1zEAaSB5Dv9ii/fDet3zgCgEUVzPZqRNx9vFcjQNj3fDUMim
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(39830400003)(376002)(396003)(346002)(136003)(66946007)(8676002)(66476007)(6496006)(186003)(8936002)(83380400001)(66556008)(6486002)(9686003)(52116002)(16526019)(33716001)(5660300002)(86362001)(478600001)(2906002)(786003)(316002)(30864003)(966005)(110136005)(4326008)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k4TsViaGp2oku0i+PZMh3cLgGNXyyJleNoXZf/zQav9lcBA6kw/uGw3NHTCN?=
 =?us-ascii?Q?ShxyL8J+MYJWHQf2Q32Uwel9wQXmx+gK3sfDbezQeo0Y60t7RYLYzUycL+Eu?=
 =?us-ascii?Q?oBpUmmu7CvhXpdbJ08EyoQaR5o7siCoLeqIHAkMcVf7J80wawDsIGbXa/QKA?=
 =?us-ascii?Q?i/2bYvNUGEXocTyHOecHEllDR8jRjz27nX2cmeBy0BPZBlXw56pnyothaVns?=
 =?us-ascii?Q?UD5s/GOX5PS1zedEU6A73tvVFpl9A17sKW0mrqExpyXkNKE5aHl8N9DYDuae?=
 =?us-ascii?Q?gTNrGjre70v3oVMMrjd5WLfkRcjAWR6qQFHPejeNvZ0wHBslC9Td7p4iNwW3?=
 =?us-ascii?Q?ljqAz9mSeoGZK9fYcEb/wQfEYgF/3cketajqnPnJ7qeaBkGsQTf3nLaVACcY?=
 =?us-ascii?Q?lRyvi8HsB1yykz4+Dr/0KqybTc+3HbRpTv8YQePNnh2RYcPlMwPBPwWAYayE?=
 =?us-ascii?Q?RVrqx7PgMcBCOnvXPZJRqkHMP5293OXUtJzcgGDo6Adcjbi98LKFYS7Cd0bF?=
 =?us-ascii?Q?I3DCreAb79Xsug+oW2ChrSuEQk3UaWdCoDl9SuRxrLXE9kVxePGpSV6bhPCl?=
 =?us-ascii?Q?R2OCooAB6mcQj9QFi7UYZ8yoWyY9HPPddal1If0E6K0czwRj0iu4/LllCccS?=
 =?us-ascii?Q?1k25gmW/8w8w8less0CL3ILiIfVfOlr3GKPeXIBvHELCJP22uABYRFR6AQz/?=
 =?us-ascii?Q?XEpfsEPvJUhvmOEU2K6h89kVetNOdsyLZxpwM6IFyR2vcezfPgkB+FjNoH6i?=
 =?us-ascii?Q?+DdehODRNLsYZRVKDCMYPd/YYfGwp31r0q3cKf/URZqexacRFoK/CTWlaBaT?=
 =?us-ascii?Q?bY1Gaid4Yv7EYo+vlPw+A/moQE4D7TQqp2zKiE7pkBU4r/gMVQTvppwY3Z/q?=
 =?us-ascii?Q?gg9Hym7m2850uK8jEAJya0gRdMz0cQVn16FgNiy2Bwdy8uiM8b2A2yk5f0g1?=
 =?us-ascii?Q?SOCNuAIrCrL/aaUP9g8fc3g2PElu8wKEbbvnJrvCavL7Y0HcujPu2NJ+9TRu?=
 =?us-ascii?Q?v8u+GrwO8tkCG8xRIaa7YxSk9VCm8CtzBCG0dBIrpy6G3Muvx8Zq0YZiplBL?=
 =?us-ascii?Q?+tE/pZvOVrJ7pNQ6ykPi7Ykan1YINYDiQUlUOfLqkeLE67jUcAaOaOwGwJw/?=
 =?us-ascii?Q?pUkaiudol9oRa5xR/1F0vSQiNw9b1FozEEDZOssXwmhBLhCX4j4uSFY+O6gj?=
 =?us-ascii?Q?8REBBOj7KW6FGOqlvJIP5cXfpj8syQS0ODq6litySj3Vazd2yIlevPc4xNzF?=
 =?us-ascii?Q?D+EcVhhCPEVYG/PR9cYap1FA92rzPmoI/X5ahsLOEkiNK1rz69r9wyq+niLS?=
 =?us-ascii?Q?M/wzYLBLlsraZ+RJT5XVQ2lTfkV+ARmkZumfucA0hEiSVg=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc7e41-fb32-46d6-2fda-08d8e77a3357
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 06:18:51.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJNKKibgbb5HlkjEIRz1DeYPnsFtJbkGn/E5Ey1zmz9glOeA5408OW56sLogfN/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old document for usbip protocol is misleading and hard to read:
  * Some fields in header are incorrect
  * Explanation of some fields are unclear or even wrong
  * Padding of header (namely all headers have the same length) is
    not explicitly point out, which is crucial for stream protocol like
    TCP

These fixes are made through reading usbip kernel drivers and userland
codes. Also I have implemented one usbip server.

Major changes:
  * Document the correct field as described in the codebase.
  * Document the padding in usbip headers. This is crucial for TCP
    stream hence these padding should be explicitly point out.
    In code these padding are implemented by a union of all headers.
  * Fix two FIXME related to usbip unlink and Document the behavior
    of unlink in different situation.
  * Clarify some field with more accurate explanation, like those
    fields associated with URB. Some constraints are extracted from
    code.
  * Delete specific transfer_flag doc in usbip as it should be
    documented by the URB part.
  * Add data captured from wire as example

Also some changes suggested by a previous patch in
https://lore.kernel.org/linux-usb/20180128071514.9107-1-alexandre.f.demers@gmail.com/
is adopted in this patch.

Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Hongren Zheng (Zenithal) <i@zenithal.me>
---
 Documentation/usb/usbip_protocol.rst | 290 +++++++++++++++------------
 1 file changed, 159 insertions(+), 131 deletions(-)

diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
index 988c832166cd..a15d9c1254e2 100644
--- a/Documentation/usb/usbip_protocol.rst
+++ b/Documentation/usb/usbip_protocol.rst
@@ -5,8 +5,14 @@ USB/IP protocol
 PRELIMINARY DRAFT, MAY CONTAIN MISTAKES!
 28 Jun 2011
 
+Update: Fix major fields in protocol
+14 Mar 2021
+
+Architecture
+============
+
 The USB/IP protocol follows a server/client architecture. The server exports the
-USB devices and the clients imports them. The device driver for the exported
+USB devices and the client imports them. The device driver for the exported
 USB device runs on the client machine.
 
 The client may ask for the list of the exported USB devices. To get the list the
@@ -37,6 +43,9 @@ to transfer the URB traffic between the client and the server. The client may
 send two types of packets: the USBIP_CMD_SUBMIT to submit an URB, and
 USBIP_CMD_UNLINK to unlink a previously submitted URB. The answers of the
 server may be USBIP_RET_SUBMIT and USBIP_RET_UNLINK respectively.
+Note that after successful USBIP_RET_UNLINK, the unlinked URB request would not
+have a corresponding USBIP_RET_UNLINK (this is explained in
+drivers/usb/usbip/stub_rx.c).
 
 ::
 
@@ -85,16 +94,42 @@ server may be USBIP_RET_SUBMIT and USBIP_RET_UNLINK respectively.
           |                        .                        |
           |                        :                        |
           |                                                 |
+          |            USBIP_CMD_SUBMIT(seqnum = p)         |
+          | ----------------------------------------------> |
+          |                                                 |
           |               USBIP_CMD_UNLINK                  |
+          |         (seqnum = p+1, unlink_seqnum = p)       |
           | ----------------------------------------------> |
           |                                                 |
           |               USBIP_RET_UNLINK                  |
+          |        (seqnum = p+1, status = -ECONNRESET)     |
+          | <---------------------------------------------- |
+          |                                                 |
+          |         Note: No USBIP_RET_SUBMIT(seqnum = p)   |
+          | <--X---X---X---X---X---X---X---X---X---X---X--- |
+          |                        .                        |
+          |                        :                        |
+          |                                                 |
+          |            USBIP_CMD_SUBMIT(seqnum = q)         |
+          | ----------------------------------------------> |
+          |                                                 |
+          |            USBIP_RET_SUBMIT(seqnum = q)         |
+          | <---------------------------------------------- |
+          |                                                 |
+          |               USBIP_CMD_UNLINK                  |
+          |         (seqnum = q+1, unlink_seqnum = q)       |
+          | ----------------------------------------------> |
+          |                                                 |
+          |               USBIP_RET_UNLINK                  |
+          |           (seqnum = q+1, status = 0)            |
           | <---------------------------------------------- |
           |                                                 |
 
 The fields are in network (big endian) byte order meaning that the most significant
 byte (MSB) is stored at the lowest address.
 
+Message Format
+==============
 
 OP_REQ_DEVLIST:
 	Retrieve the list of exported USB devices.
@@ -102,7 +137,7 @@ OP_REQ_DEVLIST:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version number: v1.1.1 |
 +-----------+--------+------------+---------------------------------------------------+
 | 2         | 2      | 0x8005     | Command code: Retrieve the list of exported USB   |
 |           |        |            | devices.                                          |
@@ -116,7 +151,7 @@ OP_REP_DEVLIST:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0.|
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version number: v1.1.1 |
 +-----------+--------+------------+---------------------------------------------------+
 | 2         | 2      | 0x0005     | Reply code: The list of exported USB devices.     |
 +-----------+--------+------------+---------------------------------------------------+
@@ -165,8 +200,8 @@ OP_REP_DEVLIST:
 | 0x143     | 1      |            | bNumInterfaces                                    |
 +-----------+--------+------------+---------------------------------------------------+
 | 0x144     |        | m_0        | From now on each interface is described, all      |
-|           |        |            | together bNumInterfaces times, with the           |
-|           |        |            | the following 4 fields:                           |
+|           |        |            | together bNumInterfaces times, with the following |
+|           |        |            | 4 fields:                                         |
 +-----------+--------+------------+---------------------------------------------------+
 |           | 1      |            | bInterfaceClass                                   |
 +-----------+--------+------------+---------------------------------------------------+
@@ -177,7 +212,7 @@ OP_REP_DEVLIST:
 | 0x147     | 1      |            | padding byte for alignment, shall be set to zero  |
 +-----------+--------+------------+---------------------------------------------------+
 | 0xC +     |        |            | The second exported USB device starts at i=1      |
-| i*0x138 + |        |            | with the busid field.                             |
+| i*0x138 + |        |            | with the path field.                              |
 | m_(i-1)*4 |        |            |                                                   |
 +-----------+--------+------------+---------------------------------------------------+
 
@@ -187,7 +222,7 @@ OP_REQ_IMPORT:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version number: v1.1.1 |
 +-----------+--------+------------+---------------------------------------------------+
 | 2         | 2      | 0x8003     | Command code: import a remote USB device.         |
 +-----------+--------+------------+---------------------------------------------------+
@@ -206,7 +241,7 @@ OP_REP_IMPORT:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version number: v1.1.1 |
 +-----------+--------+------------+---------------------------------------------------+
 | 2         | 2      | 0x0003     | Reply code: Reply to import.                      |
 +-----------+--------+------------+---------------------------------------------------+
@@ -254,65 +289,75 @@ OP_REP_IMPORT:
 | 0x13E     | 1      |            | bNumInterfaces                                    |
 +-----------+--------+------------+---------------------------------------------------+
 
-USBIP_CMD_SUBMIT:
-	Submit an URB
+The following four commands have a common basic header called
+'usbip_header_basic', and their headers, called 'usbip_header' (before URB
+payload), have the same length, therefore paddings are needed.
 
-+-----------+--------+------------+---------------------------------------------------+
-| Offset    | Length | Value      | Description                                       |
-+===========+========+============+===================================================+
-| 0         | 4      | 0x00000001 | command: Submit an URB                            |
-+-----------+--------+------------+---------------------------------------------------+
-| 4         | 4      |            | seqnum: the sequence number of the URB to submit  |
-+-----------+--------+------------+---------------------------------------------------+
-| 8         | 4      |            | devid                                             |
-+-----------+--------+------------+---------------------------------------------------+
-| 0xC       | 4      |            | direction:                                        |
-|           |        |            |                                                   |
-|           |        |            |    - 0: USBIP_DIR_OUT                             |
-|           |        |            |    - 1: USBIP_DIR_IN                              |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x10      | 4      |            | ep: endpoint number, possible values are: 0...15  |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x14      | 4      |            | transfer_flags: possible values depend on the     |
-|           |        |            | URB transfer type, see below                      |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x18      | 4      |            | transfer_buffer_length                            |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x1C      | 4      |            | start_frame: specify the selected frame to        |
-|           |        |            | transmit an ISO frame, ignored if URB_ISO_ASAP    |
-|           |        |            | is specified at transfer_flags                    |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x20      | 4      |            | number_of_packets: number of ISO packets          |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x24      | 4      |            | interval: maximum time for the request on the     |
-|           |        |            | server-side host controller                       |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x28      | 8      |            | setup: data bytes for USB setup, filled with      |
-|           |        |            | zeros if not used                                 |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x30      |        |            | URB data. For ISO transfers the padding between   |
-|           |        |            | each ISO packets is not transmitted.              |
-+-----------+--------+------------+---------------------------------------------------+
+usbip_header_basic:
 
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++===========+========+===================================================+
+| 0         | 4      | command                                           |
++-----------+--------+---------------------------------------------------+
+| 4         | 4      | seqnum: sequential number that identifies requests|
+|           |        | and corresponding responses;                      |
+|           |        | incremented per connection                        |
++-----------+--------+---------------------------------------------------+
+| 8         | 4      | devid: specifies a remote USB device uniquely     |
+|           |        | instead of busnum and devnum;                     |
+|           |        | for client (request), this value is               |
+|           |        | ((busnum << 16) | devnum);                        |
+|           |        | for server (response), this shall be set to 0     |
++-----------+--------+---------------------------------------------------+
+| 0xC       | 4      | direction:                                        |
+|           |        |                                                   |
+|           |        |    - 0: USBIP_DIR_OUT                             |
+|           |        |    - 1: USBIP_DIR_IN                              |
+|           |        |                                                   |
+|           |        | only used by client, for server this shall be 0   |
++-----------+--------+---------------------------------------------------+
+| 0x10      | 4      | ep: endpoint number                               |
+|           |        | only used by client, for server this shall be 0   |
+|           |        | for UNLINK, this shall be 0                       |
++-----------+--------+---------------------------------------------------+
 
- +-------------------------+------------+---------+-----------+----------+-------------+
- | Allowed transfer_flags  | value      | control | interrupt | bulk     | isochronous |
- +=========================+============+=========+===========+==========+=============+
- | URB_SHORT_NOT_OK        | 0x00000001 | only in | only in   | only in  | no          |
- +-------------------------+------------+---------+-----------+----------+-------------+
- | URB_ISO_ASAP            | 0x00000002 | no      | no        | no       | yes         |
- +-------------------------+------------+---------+-----------+----------+-------------+
- | URB_NO_TRANSFER_DMA_MAP | 0x00000004 | yes     | yes       | yes      | yes         |
- +-------------------------+------------+---------+-----------+----------+-------------+
- | URB_ZERO_PACKET         | 0x00000040 | no      | no        | only out | no          |
- +-------------------------+------------+---------+-----------+----------+-------------+
- | URB_NO_INTERRUPT        | 0x00000080 | yes     | yes       | yes      | yes         |
- +-------------------------+------------+---------+-----------+----------+-------------+
- | URB_FREE_BUFFER         | 0x00000100 | yes     | yes       | yes      | yes         |
- +-------------------------+------------+---------+-----------+----------+-------------+
- | URB_DIR_MASK            | 0x00000200 | yes     | yes       | yes      | yes         |
- +-------------------------+------------+---------+-----------+----------+-------------+
+USBIP_CMD_SUBMIT:
+	Submit an URB
 
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++===========+========+===================================================+
+| 0         | 20     | usbip_header_basic, 'command' shall be 0x00000001 |
++-----------+--------+---------------------------------------------------+
+| 0x14      | 4      | transfer_flags: possible values depend on the     |
+|           |        | URB transfer_flags,                               |
+|           |        | but with URB_NO_TRANSFER_DMA_MAP masked           |
++-----------+--------+---------------------------------------------------+
+| 0x18      | 4      | transfer_buffer_length:                           |
+|           |        | use URB transfer_buffer_length                    |
++-----------+--------+---------------------------------------------------+
+| 0x1C      | 4      | start_frame: use URB start_frame;                 |
+|           |        | initial frame for ISO transfer                    |
+|           |        | shall be set to 0 if not ISO transfer             |
++-----------+--------+---------------------------------------------------+
+| 0x20      | 4      | number_of_packets: number of ISO packets          |
+|           |        | shall be set to 0xffffffff if not ISO transfer    |
++-----------+--------+---------------------------------------------------+
+| 0x24      | 4      | interval: maximum time for the request on the     |
+|           |        | server-side host controller                       |
++-----------+--------+---------------------------------------------------+
+| 0x28      | 8      | setup: data bytes for USB setup, filled with      |
+|           |        | zeros if not used                                 |
++-----------+--------+---------------------------------------------------+
+| 0x30      | n      | tranfer_buffer.                                   |
+|           |        | If direction is USBIP_DIR_OUT then n equals       |
+|           |        | transfer_buffer_length; otherwise n equals 0      |
+|           |        | For ISO transfers the padding between each ISO    |
+|           |        | between each ISO packets is not transmitted.      |
++-----------+--------+---------------------------------------------------+
+| 0x30+n    | m      | iso_packet_descriptor                             |
++-----------+--------+---------------------------------------------------+
 
 USBIP_RET_SUBMIT:
 	Reply for submitting an URB
@@ -320,92 +365,75 @@ USBIP_RET_SUBMIT:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 4      | 0x00000003 | command                                           |
-+-----------+--------+------------+---------------------------------------------------+
-| 4         | 4      |            | seqnum: URB sequence number                       |
-+-----------+--------+------------+---------------------------------------------------+
-| 8         | 4      |            | devid                                             |
-+-----------+--------+------------+---------------------------------------------------+
-| 0xC       | 4      |            | direction:                                        |
-|           |        |            |                                                   |
-|           |        |            |    - 0: USBIP_DIR_OUT                             |
-|           |        |            |    - 1: USBIP_DIR_IN                              |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x10      | 4      |            | ep: endpoint number                               |
+| 0         | 20     |            | usbip_header_basic, 'command' shall be 0x00000003 |
 +-----------+--------+------------+---------------------------------------------------+
 | 0x14      | 4      |            | status: zero for successful URB transaction,      |
 |           |        |            | otherwise some kind of error happened.            |
 +-----------+--------+------------+---------------------------------------------------+
 | 0x18      | 4      | n          | actual_length: number of URB data bytes           |
+|           |        |            | use URB actual_length                             |
 +-----------+--------+------------+---------------------------------------------------+
-| 0x1C      | 4      |            | start_frame: for an ISO frame the actually        |
-|           |        |            | selected frame for transmit.                      |
+| 0x1C      | 4      |            | start_frame: use URB start_frame;                 |
+|           |        |            | initial frame for ISO transfer                    |
+|           |        |            | shall be set to 0 if not ISO transfer             |
 +-----------+--------+------------+---------------------------------------------------+
-| 0x20      | 4      |            | number_of_packets                                 |
+| 0x20      | 4      |            | number_of_packets: number of ISO packets          |
+|           |        |            | shall be set to 0xffffffff if not ISO transfer    |
 +-----------+--------+------------+---------------------------------------------------+
 | 0x24      | 4      |            | error_count                                       |
 +-----------+--------+------------+---------------------------------------------------+
-| 0x28      | 8      |            | setup: data bytes for USB setup, filled with      |
-|           |        |            | zeros if not used                                 |
+| 0x28      | 8      |            | padding, shall be set to 0                        |
 +-----------+--------+------------+---------------------------------------------------+
-| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
+| 0x30      | n      |            | tranfer_buffer.                                   |
+|           |        |            | If direction is USBIP_DIR_OUT then n equals       |
+|           |        |            | transfer_buffer_length; otherwise n equals 0      |
+|           |        |            | For ISO transfers the padding between each ISO    |
 |           |        |            | between each ISO packets is not transmitted.      |
 +-----------+--------+------------+---------------------------------------------------+
+| 0x30+n    | m      |            | iso_packet_descriptor                             |
++-----------+--------+------------+---------------------------------------------------+
 
 USBIP_CMD_UNLINK:
 	Unlink an URB
 
-+-----------+--------+------------+---------------------------------------------------+
-| Offset    | Length | Value      | Description                                       |
-+===========+========+============+===================================================+
-| 0         | 4      | 0x00000002 | command: URB unlink command                       |
-+-----------+--------+------------+---------------------------------------------------+
-| 4         | 4      |            | seqnum: URB sequence number to unlink:            |
-|           |        |            |                                                   |
-|           |        |            | FIXME:                                            |
-|           |        |            |    is this so?                                    |
-+-----------+--------+------------+---------------------------------------------------+
-| 8         | 4      |            | devid                                             |
-+-----------+--------+------------+---------------------------------------------------+
-| 0xC       | 4      |            | direction:                                        |
-|           |        |            |                                                   |
-|           |        |            |    - 0: USBIP_DIR_OUT                             |
-|           |        |            |    - 1: USBIP_DIR_IN                              |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x10      | 4      |            | ep: endpoint number: zero                         |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x14      | 4      |            | seqnum: the URB sequence number given previously  |
-|           |        |            | at USBIP_CMD_SUBMIT.seqnum field                  |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
-|           |        |            | between each ISO packets is not transmitted.      |
-+-----------+--------+------------+---------------------------------------------------+
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++===========+========+===================================================+
+| 0         | 20     | usbip_header_basic, 'command' shall be 0x00000002 |
++-----------+--------+---------------------------------------------------+
+| 0x14      | 4      | unlink_seqnum, of the SUBMIT request to unlink    |
++-----------+--------+---------------------------------------------------+
+| 0x18      | 24     | padding, shall be set to 0                        |
++-----------+--------+---------------------------------------------------+
 
 USBIP_RET_UNLINK:
 	Reply for URB unlink
 
-+-----------+--------+------------+---------------------------------------------------+
-| Offset    | Length | Value      | Description                                       |
-+===========+========+============+===================================================+
-| 0         | 4      | 0x00000004 | command: reply for the URB unlink command         |
-+-----------+--------+------------+---------------------------------------------------+
-| 4         | 4      |            | seqnum: the unlinked URB sequence number          |
-+-----------+--------+------------+---------------------------------------------------+
-| 8         | 4      |            | devid                                             |
-+-----------+--------+------------+---------------------------------------------------+
-| 0xC       | 4      |            | direction:                                        |
-|           |        |            |                                                   |
-|           |        |            |    - 0: USBIP_DIR_OUT                             |
-|           |        |            |    - 1: USBIP_DIR_IN                              |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x10      | 4      |            | ep: endpoint number                               |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x14      | 4      |            | status: This is the value contained in the        |
-|           |        |            | urb->status in the URB completition handler.      |
-|           |        |            |                                                   |
-|           |        |            | FIXME:                                            |
-|           |        |            |      a better explanation needed.                 |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
-|           |        |            | between each ISO packets is not transmitted.      |
-+-----------+--------+------------+---------------------------------------------------+
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++===========+========+===================================================+
+| 0         | 20     | usbip_header_basic, 'command' shall be 0x00000004 |
++-----------+--------+---------------------------------------------------+
+| 0x14      | 4      | status: This is similar to that status of         |
+|           |        | USBIP_RET_SUBMIT (share the same memory offset)   |
+|           |        | When UNLINK is successful, status is -ECONNRESET; |
+|           |        | when USBIP_CMD_UNLINK is after USBIP_RET_SUBMIT   |
+|           |        | status is 0                                       |
++-----------+--------+---------------------------------------------------+
+| 0x18      | 24     | padding, shall be set to 0                        |
++-----------+--------+---------------------------------------------------+
+
+EXAMPLE
+=======
+
+  The following data is captured from wire with Human Interface Devices (HID)
+  payload
+
+::
+
+  CmdIntrIN:  00000001 00000d05 0001000f 00000001 00000001 00000200 00000040 ffffffff 00000000 00000004 00000000 00000000
+  CmdIntrOUT: 00000001 00000d06 0001000f 00000000 00000001 00000000 00000040 ffffffff 00000000 00000004 00000000 00000000
+              ffffffff860008a784ce5ae212376300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
+  RetIntrOut: 00000003 00000d06 00000000 00000000 00000000 00000000 00000040 ffffffff 00000000 00000000 00000000 00000000
+  RetIntrIn:  00000003 00000d05 00000000 00000000 00000000 00000000 00000040 ffffffff 00000000 00000000 00000000 00000000
+              ffffffff860011a784ce5ae2123763612891b1020100000400000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 
2.30.1

