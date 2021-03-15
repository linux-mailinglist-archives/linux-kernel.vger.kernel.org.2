Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124AD33ADBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCOIkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:40:35 -0400
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:26544
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229652AbhCOIkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:40:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt5+SIdwuzq902KLBOfr8Dj1OlEFFX8vkAYk8dyz7A1BpLlUbL8fju5v26KAk45YUU/E3YlZKQAMWgSL5Ls4BdxcrCN7kKNT0S2M0NDTJkgYWic5Vz+Z+gDoTicAN8iC6r4RoK8R1id1KHjeapeY7N+nC1mpcvS+khG58ZJNJlExyr+1p+hviQb28awC+DJ98uF38O3MnM7Pv4qgoZFtbb9XM9Nn7iV/xUqSC9VlbuWIGJQ2DQYZya3wRLcdMdmDLrVw8siGwCsHJxC17umFGjcvuJ4+ZnEQOQdFVRWfgOb9O4Ix/XbEFFILuVniApSAaOyy5ZQaFwi9V45o3dfywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbTgZ7T+yaLF6fVMmx967BdGHqEhQlx1okb98Jnl2JY=;
 b=MkkO8bSxRQLa2goeC1rdw5dcott7wVrix/pgTHy89b4dOsDb7FKBVNC8ioRiBiQLHjsRj0tmaegwrHZElvc0HHxRC97NjYkIX27/UaCTQrXylTKDF6mtWb+C35yyexTUNlWRJrQQPVFCROELfnqcH07HUlTjfjgQALySyIj9eHkG+TKmufM/1l6OfV0GlaXQHr6gApYLkm03k9ob8WLwgbld6/jHNq1Xt8Q4Cy0nalIqWGVlwyePFhKUgsm/Gpa+zeZe+Kmt//lmQppZYxaym8S+if34OZB2BYkqf3syxjFtLGteUw1fOTDHbrdDa7LXiLDn1pBeiwd5EPvDRqBuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbTgZ7T+yaLF6fVMmx967BdGHqEhQlx1okb98Jnl2JY=;
 b=sY4k2GfPqyYWRirkFpMCKWe/OhQowX3TzqvTWwOasaMUGmymiHQ4FiFydf6xWRuWrWiPq4Lb4VP8DIEdgwx+K9EdKysBUBhp0/Q6CBCBUEE3UaulDJvqMCQEdHxwFErPaF0T6c2QcZe+nENcmQqD9U1bJp7+FeN4djL9qL+NWq4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB2836.apcprd03.prod.outlook.com (2603:1096:203:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11; Mon, 15 Mar
 2021 08:40:20 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 08:40:19 +0000
Date:   Mon, 15 Mar 2021 16:40:10 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Alexandre Demers <alexandre.f.demers@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        usbip-devel@lists.sourceforge.net
Subject: [PATCH v3] docs: usbip: Fix major fields and descriptions in protocol
Message-ID: <YE8dakf3nIn0jJew@Sun>
References: <YE6/HQoxkraowTI7@Sun>
 <YE78SRefRe1trldP@Sun>
 <YE8Oan2BmSuKR4/p@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE8Oan2BmSuKR4/p@kroah.com>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by BYAPR11CA0091.namprd11.prod.outlook.com (2603:10b6:a03:f4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 08:40:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f629c9-d016-4158-87b5-08d8e78df6f8
X-MS-TrafficTypeDiagnostic: HK0PR03MB2836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB28363A8A3A63EAA959E0ADEEBC6C9@HK0PR03MB2836.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pi5EueK6RrchV6jN2/N04R+/u4u/6PN7uiEyoHY41bnAD6QKS/beDlZ21RIJD1gTtbTPYSt0BR8LObYntkUM2aUcCGsm3KXEJaovPz+i2iRq2Xx4t4BKxz8BQFi9z3OIK8nFCxru1+Mp3CS22u4veRbkfYJnbiK439HnKCkJkBXvN1EiGkoCTrXZU5LmtRDr2M7i5hRHMYlz95DYvsktNtZSqctCX//YXEY5qJ1ZTRdBDI0y2ldmx2s82CBjql1M3cOnmDMi6tjCgwj1mMz+G8YAUZQX57g5D2MzYJN0alDiAJyk+rHZ7MAivb7dtqSzNIiK3dNOlt78A8WQG1k6pgV5ftSkF5hOHN/3L9TV9gimpViNyHtbymweG2KNs+1VkR5oAVJ+ctsMDuz8YpOGmazi/zLHwx8C7+n54yRG/xiqRjAdYv+MA13tebuKX9m35rY/vgDqFO3rVxcuP90FXkSL4RiWzI4lIg576+ppm3l/1TA8vMSgHS4H1ArF3ATjXpezjO7xRFIvmju3niIzlLbZukeEKDGUgIIdP2nbicW12tOOe5VXv40csePpN6T/sSjhYYtZTpQPnjQ3/ET21vLF/COKBChV2orS1eRcLcqYnK10UpygI11PM6j4f7w9DuhzEJj+gUyELMusvKQKbyq6ihf+OhvJDkl/ruYPiT0Qxq8Q3ohWeqaV8IzrLGmO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(39830400003)(136003)(376002)(346002)(396003)(6486002)(186003)(16526019)(5660300002)(33716001)(30864003)(786003)(66946007)(52116002)(6666004)(2906002)(110136005)(66476007)(66556008)(9686003)(7416002)(316002)(8676002)(8936002)(966005)(83380400001)(86362001)(6496006)(4326008)(478600001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CEX3dTVI+31LfqsYx0AJe84qTCmALQF3jUTjpx6jrd+jveDuSqw5nJVzwDfQ?=
 =?us-ascii?Q?ifS0Emrp3+O72VbAo37aIodh35X+eTKyG8NlqMd/WBKFKi4m0n2W120zJMK+?=
 =?us-ascii?Q?V2M9n5naYnYtZkHcsVD+8FE5VzxRPnbKCdFn6R9bUcD2thmzmuEk506E6bKx?=
 =?us-ascii?Q?qS/fiy9NjOk4qzKBaMDOMcL/kXfE605pJCx9pv3pW5PRmoJksenZpCCiUDWn?=
 =?us-ascii?Q?NzBxy/beOu+WnelAdyUtDW/aemxqYxDYBlskARWr/t0y6W/aUBSaCdVlNv04?=
 =?us-ascii?Q?S2PyxNUd/vG64doJjU5ouB7PtZFQyq/Zu6mh1v45us7Z6+Or66IZeEllnoXe?=
 =?us-ascii?Q?6zBrz+LLoOs4VgE0y09OZTmH0sZI3rXtfOVEMmg88EtW0GDWMNj2zPUeTH+d?=
 =?us-ascii?Q?e6fvXAiUPqDzpgA/0ky9TZ3Acn1MstcfrlvKjnkSkfgPtrr/bPL36jgrDSmw?=
 =?us-ascii?Q?lRR7Ap/IY/CrK1szU9IljkZOHDDgP13ucUS6o6838fuVCNVvI55i+FHng1a7?=
 =?us-ascii?Q?O7eyfDzYTSArK+YXJ3qVnaEL3cYZO3X5kWZNwe7/c4Ka0UGLtsIa68d1yM1f?=
 =?us-ascii?Q?FyZQuJ8k78Xti3bBUikp4X7tBNiP023PsB4vthirTyeAAOHd9ibTTperAdHg?=
 =?us-ascii?Q?R4tYL1iYvy1vRZYEbJO3ibTS3JLVxa1WBVN3AX5hwn5N8N6288OkgmBY8Xs0?=
 =?us-ascii?Q?AF4YvZx0FfUQMyxd1uMoxI1IZmwVpkRmyoPU0+/EIhm2ahPx1oCC3VaBvkD9?=
 =?us-ascii?Q?Jj1sUrnOPQcfuMB8nzYbGGwc0B7viJxXxQSt57x51EGoMGiujBugN5LidCRo?=
 =?us-ascii?Q?KlZQO1GsK3Ght3zEvg4U7O77MbhL1IjZ7a04Q00PAjq1dazDZqY3xU2mgxvY?=
 =?us-ascii?Q?Lwpoopx8CmXmcyGgtXtUX5v84nXAx8LntARjtSZ1z7CpyPLBN/Ak+ixr1dRl?=
 =?us-ascii?Q?KrU6Tx2RpPZB783Bc4EdVnw6Z2e2K0eyt2XJU7LC2Zaot0Arn9Crr9cyZU35?=
 =?us-ascii?Q?hUCAK+E5QaeAgwuQ3ochpq5paAHYEMDc74B3mNA6Xl1ApBHTV2Ux4CcAs2ze?=
 =?us-ascii?Q?nMDXUU7bTFFYYWKah7b4QeOYfL9chdYJZvoDKmnnOyBw98IAelQKMt6RIY+B?=
 =?us-ascii?Q?FHGGvvtHovSus3s4aJKM00Ci74Fs6/kTIvep/dVw8sdHyqBBbERCOWnImn/4?=
 =?us-ascii?Q?kAMCvSvufasBosAbyIu0z/nScY5od3b+/V2wpNu9TdquhIAx6VuCLuu6qGhP?=
 =?us-ascii?Q?W34PF9fwhmZBoqGNwwVTwCTVrqv/6WeS2Y/+WZ9XnOztVJO0f+RpnvtNqEXL?=
 =?us-ascii?Q?91DbqvAXvefghmk80AVqDuSQFp2XJnUnmKV1lVC4QYoyVw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f629c9-d016-4158-87b5-08d8e78df6f8
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 08:40:19.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fKbJYqfzU8tpE7tkO/KdCgUmX3ONjpLOuiV7R8ntLIl2BJP38mPV1Fl31zGFyJu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB2836
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
  * Remove date in doc as these are tracked in git history
  * Remove 'mistake alert' as all data fields are documented properly
    now. However, docs on possible values for some field shall be added
    in the future

Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Hongren Zheng (Zenithal) <i@zenithal.me>
---
 Documentation/usb/usbip_protocol.rst | 288 ++++++++++++++-------------
 1 file changed, 155 insertions(+), 133 deletions(-)

diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
index 988c832166cd..ed423cdda236 100644
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
@@ -254,65 +283,75 @@ OP_REP_IMPORT:
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
@@ -320,92 +359,75 @@ USBIP_RET_SUBMIT:
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

