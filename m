Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD32D33C857
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhCOVQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:16:19 -0400
Received: from mail-eopbgr1310120.outbound.protection.outlook.com ([40.107.131.120]:51904
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232414AbhCOVPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:15:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy62XoUB2cAsmS6bootn2xBpdtWQiIn9CpmYCxp3L0wNfZzjCCa9Be2jZwomDcgtNR6tZC0s1U3idfELfdtRgW8ujuvL8CnjNr8YnR0X1awhm5/XsZJsE7drJbmw6bqOqVWaW99UzoK542BKlf4l/hh1dWTgBeWatI5If1Nc984DOCEqloXH2Ds2Ya54ZuRd0pwQS+O+u9grxJ3pnCJSgiPxdNH0//QIYVzpP7drtXLzYKJARbd7XVpODIIGJnv5qFqqEhiXdXP6IlDg3KPsP7WuQ+jUrpQ6Nhgb3nzlpJKXLUbc7pTRQs0DS5LvCekIkMOh5sZCc8Z2VuCglOtPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n/Xv1BhIzDaQYkVv5sDmXsSyLJ+L6d1uixCeuOr8xk=;
 b=E6WKDD/5ZTJPnmcakT9pUWBeyNPqU34w3WB9GytM4trGIjhwzayzbpIFTERzSr/zFJOvAkxNdDuBx4ZBd1GjLxghwFvclfiQr8NMxx4XOx3eeD146Ir0Z7UgeWr9Us1BnbdCNxlAPFEvCQBX/GBQQwzxnuQEdklMUvgdxGRyV/oX+IF/SE6dookbj3j98uoFfhECK/5YxpAMtskyVGpDZLSISxB8UvNGJXpZx/RI+Q2Ko1fbLhKA6hY+HO+2K3CFWyI0ei6OOOGuO1hA7ukDTjGYMzMK54Cdy/fDVI2HHO8WmYFx0LA635JYQMTpNUbKdn/hMLBqVpZIxv0Wha2h3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n/Xv1BhIzDaQYkVv5sDmXsSyLJ+L6d1uixCeuOr8xk=;
 b=KVdreos+aqyNPfreKNT4TO12y33YTVeYwoMT/NKUw08zbMcFK9QBdTjzJcvOUHON8HEtLE0Bebqj8xKndF4J/IGzZYgnVejNknjY/RwGyyelQV+f23uNc9Fb06L/JcsO+vyzFAqzV1HFKPHNSFHGQa0ccwZLWnyROOeSJJ2PRVo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB3553.apcprd03.prod.outlook.com (2603:1096:203:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10; Mon, 15 Mar
 2021 21:15:46 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 21:15:45 +0000
Date:   Tue, 16 Mar 2021 05:15:35 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Alexandre Demers <alexandre.f.demers@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        usbip-devel@lists.sourceforge.net,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4] docs: usbip: Fix major fields and descriptions in protocol
Message-ID: <YE/Od9WNg3Prw1/h@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE8dakf3nIn0jJew@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 21:15:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f60a153-7474-4d72-e68a-08d8e7f77f42
X-MS-TrafficTypeDiagnostic: HK0PR03MB3553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB35533133BB326802061A1D45BC6C9@HK0PR03MB3553.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5ryeEkkR9gLkT5I8eSvg8npvQqFWkoAWNPgDNPQCF7ZgdjBgB9PCDtVtCfmwrn1farAst9lDNXj7onMV1GiGqw4MLD0WM5J+6Q3GykaLktwZsBNuJDPImeU0/h//YackDJgNYrMsMVYSQDPRmkcywfF2UITc/L3V2AKSLrOSQEWOPLxaShgsDsGFoqpsY1ndsOiaImxZxggGi0RBIx9npM0JRGO/atL990a55BNJFTPSaVVH16a/hPyzqf8qRmcL6aT/0d2pPjnLwJ8u1AiuZ9GRxOzTk+7ObxBAMianCOfsxbHb26TreS/DMPtNNha7tWAQxYhaEgLIVzSMMUGM/u8vZQthhXX8pRamSRr9smy7yxlFWUi3ivTpdkE5srzMNBUQ7by8tUOrTa2AoobsDf5H9ClxDxLSVWN/uRQEkpFnsacKCL8BStj7QTBl+/WNaGOGh/QQCLoHY9SRuxCg3z6pghpLwMFmdBTWjCIzYCnXgc/TbljfVbPP+aSS1OTYPdvy6mcHCEFYQXAPJeF8roHmG6xdysT/8ei8xGBj4l9OEiTDXGK8SFY2fICC1MFI/VgcLmeRKglaTBSP1KAeSNFDko8ZHUinuGkljtyb/wGYqM0Z65KrIuCEmh21WnrgDCCLghrqNcWY9PEmqT6JvwmFLwX3y6l5qc+zf7PhPo2157fgwPPfHHomWstS8Ct
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(346002)(136003)(39830400003)(366004)(396003)(54906003)(9686003)(52116002)(186003)(66476007)(786003)(966005)(110136005)(6486002)(6496006)(316002)(8936002)(478600001)(33716001)(6666004)(7416002)(30864003)(83380400001)(5660300002)(66946007)(66556008)(16526019)(8676002)(2906002)(86362001)(4326008)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W15gVagdCYl901yBw+61rp3GIzvGKbzM+Y8/7hIumnUgt+DasmK0km+VoCY+?=
 =?us-ascii?Q?FWu/GRt5yryCJz7LJcMFIqo32ZijfS0Q3YEO3+6RLRfZJmqOLLPEtiOjmsru?=
 =?us-ascii?Q?pdKQCFyVxztygIDGPRfpGYmtOuFZsJqfT5fbPX6dw2v71hdIgYA7m6AqY/BO?=
 =?us-ascii?Q?PDkJedbN0HkOCH5RSKn+eCVaM6UK9FLfXlk8KHQqJYokV+YJw9+6HC7+xF8Q?=
 =?us-ascii?Q?4/jHoYlq3SwJG19tScdiwSzqCt3ZaRTRCZE3g/9mMZ1+p7WKm94caACO8oLN?=
 =?us-ascii?Q?49eOOzNQy8a2LPa7pCTIKHRX0fpfG8P/UWe2hsk6l5zH8kKQi5QFTK4lBAzR?=
 =?us-ascii?Q?k3id0UQ4FdWF/fllhP6KzkHdofHhxnTfXiFTn5uI4eqohaN2lu6zcYHMJG5d?=
 =?us-ascii?Q?LKaQtW2JAaaIY0kMynx3wTNoIfYKd+bOd9VVZXdYIKGDAgr5gGFxK23Igo6d?=
 =?us-ascii?Q?NmstcWfkK2s1qbZMjkePmzKqc5nARpCjdfFih0mkAcO5EcsUHC7mpHcqYVct?=
 =?us-ascii?Q?PaNMSk5SGZ+Ci11Lgvk/0f+WYYRvGL0IfHtwXSLIPsm3gU7LwhcQ4TOC8EB9?=
 =?us-ascii?Q?upPuaPGTdPLwBieE9M5qvoWxacEK68Tn2bkCk90eRCuE2busazK4QmyVDUSF?=
 =?us-ascii?Q?wBNGjmJURGO3n9uSt6semEOS+MlYMWxHfGxwt6yolxF4e2reY/UXorLDxMuN?=
 =?us-ascii?Q?a7lCIKY1YQBootJ23EjqYBHuDeIsW2Cd52vE5z2IXXigDZWBn68F43yzdBxZ?=
 =?us-ascii?Q?WUgUwovEPA2+v4Sn0SXJf1/+yuiV4jrCK94xRSOms2nS4TQ2eK630BXMdREy?=
 =?us-ascii?Q?fCcrfreINSV3KiXcUKdFsSuZSaLY/bTW+tAgRHjCjJ3dOu66YJv0iB5HxV8g?=
 =?us-ascii?Q?OLax4AwvD0bDUePtY9wV1FA0Jg+bLwu6FeA3sUnk16o0wzfgvdq73fTZHa8W?=
 =?us-ascii?Q?3aIvELurAdc2s1MusjWEzB6ygWRxuOodaVn639jZjUdpNzdDuNiFR20gXMJx?=
 =?us-ascii?Q?9gHecae+jOfzzYBetanuPlWPCDWRiCKxcvmduEgNQzVkJ+1fRw3JldsinKNu?=
 =?us-ascii?Q?HT0S7/6W/THYUyVg+8bOpKSoYvteSh0mJ+N3fdpSR8t4gR/c+gAR+nQJo57d?=
 =?us-ascii?Q?pinCWNcHVoxD86/8aJ91uoCLk6cuQqVDyM2f8KCaaqwG2hWb/2KG1fg0C714?=
 =?us-ascii?Q?HsWR+9Rh48fMBdMfkhpdYrxr7KmTdcKoGq7I3nEO5GTmKa6WNFLA5x0pSljn?=
 =?us-ascii?Q?M6lzP+q/tLtikWD1ua9qWI7rJ7YxEj2Ao+yl/WrWGetxqLqMMJJDOglp9o6F?=
 =?us-ascii?Q?sYEe5DTHOaS3uCsBiV/eNBIhWUx6vzwYA6ygVxxAAz9vQA=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f60a153-7474-4d72-e68a-08d8e7f77f42
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 21:15:45.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRlUiz2AgJ4WmeV7+DmGgVOXOTXjq+HFM8gD9pKUw3GMRKCdUiKhtSQb0q8f4gLx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3553
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old document for usbip protocol is misleading and hard to read:
  * Some fields in header are incorrect
  * Explanation of some fields are unclear or even wrong
  * Padding of header (namely all headers have the same length) is
    not explicitly pointed out, which is crucial for stream protocol
    like TCP

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

Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Co-developed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Hongren Zheng <i@zenithal.me>
---
 Documentation/usb/usbip_protocol.rst | 320 ++++++++++++++-------------
 1 file changed, 171 insertions(+), 149 deletions(-)

PATCH v2:
Some changes suggested by a previous patch in
https://lore.kernel.org/linux-usb
/20180128071514.9107-1-alexandre.f.demers@gmail.com/
is adopted in this patch.
  * Fix Typo: duplicated 'the' in 'the following 4 field'
  * Fix incorrect field: in OP_REQ_DEVLIST, the second dev starts with
    field 'path', not 'busid'

PATCH v3:
Suggested by
https://lore.kernel.org/linux-doc/YE8Oan2BmSuKR4%2Fp@kroah.com/
  * Remove date and changelog in doc as these are tracked in git history
  * Remove 'mistake alert' as all data fields are documented properly
    now. However, docs on possible values for some field shall be added
    in the future

PATCH v4:
Suggested by https://lore.kernel.org/linux-doc
/40351ed6-2907-3966-e69a-a564173b3682@infradead.org/
  * Add punctuations for readability
  * Move patch changelog after the marker line
  * Remove nickname in signed-off-by line

diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
index 988c832166cd..54c5677adf4e 100644
--- a/Documentation/usb/usbip_protocol.rst
+++ b/Documentation/usb/usbip_protocol.rst
@@ -2,11 +2,11 @@
 USB/IP protocol
 ===============
 
-PRELIMINARY DRAFT, MAY CONTAIN MISTAKES!
-28 Jun 2011
+Architecture
+============
 
 The USB/IP protocol follows a server/client architecture. The server exports the
-USB devices and the clients imports them. The device driver for the exported
+USB devices and the client imports them. The device driver for the exported
 USB device runs on the client machine.
 
 The client may ask for the list of the exported USB devices. To get the list the
@@ -37,6 +37,9 @@ to transfer the URB traffic between the client and the server. The client may
 send two types of packets: the USBIP_CMD_SUBMIT to submit an URB, and
 USBIP_CMD_UNLINK to unlink a previously submitted URB. The answers of the
 server may be USBIP_RET_SUBMIT and USBIP_RET_UNLINK respectively.
+Note that after successful USBIP_RET_UNLINK, the unlinked URB request would not
+have a corresponding USBIP_RET_UNLINK (this is explained in
+drivers/usb/usbip/stub_rx.c).
 
 ::
 
@@ -85,16 +88,42 @@ server may be USBIP_RET_SUBMIT and USBIP_RET_UNLINK respectively.
           |                        .                        |
           |                        :                        |
           |                                                 |
+          |            USBIP_CMD_SUBMIT(seqnum = p)         |
+          | ----------------------------------------------> |
+          |                                                 |
+          |               USBIP_CMD_UNLINK                  |
+          |         (seqnum = p+1, unlink_seqnum = p)       |
+          | ----------------------------------------------> |
+          |                                                 |
+          |               USBIP_RET_UNLINK                  |
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
           |               USBIP_CMD_UNLINK                  |
+          |         (seqnum = q+1, unlink_seqnum = q)       |
           | ----------------------------------------------> |
           |                                                 |
           |               USBIP_RET_UNLINK                  |
+          |           (seqnum = q+1, status = 0)            |
           | <---------------------------------------------- |
           |                                                 |
 
 The fields are in network (big endian) byte order meaning that the most significant
 byte (MSB) is stored at the lowest address.
 
+Message Format
+==============
 
 OP_REQ_DEVLIST:
 	Retrieve the list of exported USB devices.
@@ -102,7 +131,7 @@ OP_REQ_DEVLIST:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version number: v1.1.1 |
 +-----------+--------+------------+---------------------------------------------------+
 | 2         | 2      | 0x8005     | Command code: Retrieve the list of exported USB   |
 |           |        |            | devices.                                          |
@@ -116,7 +145,7 @@ OP_REP_DEVLIST:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0.|
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version number: v1.1.1 |
 +-----------+--------+------------+---------------------------------------------------+
 | 2         | 2      | 0x0005     | Reply code: The list of exported USB devices.     |
 +-----------+--------+------------+---------------------------------------------------+
@@ -165,8 +194,8 @@ OP_REP_DEVLIST:
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
@@ -177,7 +206,7 @@ OP_REP_DEVLIST:
 | 0x147     | 1      |            | padding byte for alignment, shall be set to zero  |
 +-----------+--------+------------+---------------------------------------------------+
 | 0xC +     |        |            | The second exported USB device starts at i=1      |
-| i*0x138 + |        |            | with the busid field.                             |
+| i*0x138 + |        |            | with the path field.                              |
 | m_(i-1)*4 |        |            |                                                   |
 +-----------+--------+------------+---------------------------------------------------+
 
@@ -187,7 +216,7 @@ OP_REQ_IMPORT:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version number: v1.1.1 |
 +-----------+--------+------------+---------------------------------------------------+
 | 2         | 2      | 0x8003     | Command code: import a remote USB device.         |
 +-----------+--------+------------+---------------------------------------------------+
@@ -206,7 +235,7 @@ OP_REP_IMPORT:
 +-----------+--------+------------+---------------------------------------------------+
 | Offset    | Length | Value      | Description                                       |
 +===========+========+============+===================================================+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version number: v1.1.1 |
 +-----------+--------+------------+---------------------------------------------------+
 | 2         | 2      | 0x0003     | Reply code: Reply to import.                      |
 +-----------+--------+------------+---------------------------------------------------+
@@ -254,158 +283,151 @@ OP_REP_IMPORT:
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
+|           |        | only used by client, for server this shall be 0;  |
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
+|           |        | initial frame for ISO transfer;                   |
+|           |        | shall be set to 0 if not ISO transfer             |
++-----------+--------+---------------------------------------------------+
+| 0x20      | 4      | number_of_packets: number of ISO packets;         |
+|           |        | shall be set to 0xffffffff if not ISO transfer    |
++-----------+--------+---------------------------------------------------+
+| 0x24      | 4      | interval: maximum time for the request on the     |
+|           |        | server-side host controller                       |
++-----------+--------+---------------------------------------------------+
+| 0x28      | 8      | setup: data bytes for USB setup, filled with      |
+|           |        | zeros if not used.                                |
++-----------+--------+---------------------------------------------------+
+| 0x30      | n      | transfer_buffer.                                  |
+|           |        | If direction is USBIP_DIR_OUT then n equals       |
+|           |        | transfer_buffer_length; otherwise n equals 0.     |
+|           |        | For ISO transfers the padding between each ISO    |
+|           |        | packets is not transmitted.                       |
++-----------+--------+---------------------------------------------------+
+| 0x30+n    | m      | iso_packet_descriptor                             |
++-----------+--------+---------------------------------------------------+
 
 USBIP_RET_SUBMIT:
 	Reply for submitting an URB
 
-+-----------+--------+------------+---------------------------------------------------+
-| Offset    | Length | Value      | Description                                       |
-+===========+========+============+===================================================+
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
-+-----------+--------+------------+---------------------------------------------------+
-| 0x14      | 4      |            | status: zero for successful URB transaction,      |
-|           |        |            | otherwise some kind of error happened.            |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x18      | 4      | n          | actual_length: number of URB data bytes           |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x1C      | 4      |            | start_frame: for an ISO frame the actually        |
-|           |        |            | selected frame for transmit.                      |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x20      | 4      |            | number_of_packets                                 |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x24      | 4      |            | error_count                                       |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x28      | 8      |            | setup: data bytes for USB setup, filled with      |
-|           |        |            | zeros if not used                                 |
-+-----------+--------+------------+---------------------------------------------------+
-| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
-|           |        |            | between each ISO packets is not transmitted.      |
-+-----------+--------+------------+---------------------------------------------------+
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++===========+========+===================================================+
+| 0         | 20     | usbip_header_basic, 'command' shall be 0x00000003 |
++-----------+--------+---------------------------------------------------+
+| 0x14      | 4      | status: zero for successful URB transaction,      |
+|           |        | otherwise some kind of error happened.            |
++-----------+--------+---------------------------------------------------+
+| 0x18      | 4      | actual_length: number of URB data bytes;          |
+|           |        | use URB actual_length                             |
++-----------+--------+---------------------------------------------------+
+| 0x1C      | 4      | start_frame: use URB start_frame;                 |
+|           |        | initial frame for ISO transfer;                   |
+|           |        | shall be set to 0 if not ISO transfer             |
++-----------+--------+---------------------------------------------------+
+| 0x20      | 4      | number_of_packets: number of ISO packets;         |
+|           |        | shall be set to 0xffffffff if not ISO transfer    |
++-----------+--------+---------------------------------------------------+
+| 0x24      | 4      | error_count                                       |
++-----------+--------+---------------------------------------------------+
+| 0x28      | 8      | padding, shall be set to 0                        |
++-----------+--------+---------------------------------------------------+
+| 0x30      | n      | transfer_buffer.                                  |
+|           |        | If direction is USBIP_DIR_IN then n equals        |
+|           |        | actual_length; otherwise n equals 0.              |
+|           |        | For ISO transfers the padding between each ISO    |
+|           |        | packets is not transmitted.                       |
++-----------+--------+---------------------------------------------------+
+| 0x30+n    | m      | iso_packet_descriptor                             |
++-----------+--------+---------------------------------------------------+
 
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
+| 0x14      | 4      | status: This is similar to the status of          |
+|           |        | USBIP_RET_SUBMIT (share the same memory offset).  |
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

