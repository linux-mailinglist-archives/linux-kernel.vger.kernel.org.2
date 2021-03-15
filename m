Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BCF33A97F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhCOB6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 21:58:41 -0400
Received: from mail-eopbgr1320138.outbound.protection.outlook.com ([40.107.132.138]:18444
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229723AbhCOB6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 21:58:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv2+4tw2c3Nf4fmp6+YgDnEC1IbPF8/yPkDIuw9qDSxpgvJfVNf98t+C1ziKvTgtnE3mx99chtwyRWPRQdKGnNlaSOL8K2W8ZpmKIVxJoGRAIA3AQtt1nv0UAbQBwvMSh39Uf6NDDOMqGpGcZcc6Rd69B2GFihPF8C/gqp2pO289xA8QNmEKX0w/9pIRiWQAEUcQmLV1cJQKWDts+0/nxWPG3Euad9IgOUE1NUU+L1LrxiLU/hHmvrCsn9mGS8GH3K/3zp0Q00v8mO5sQB2DKYxaeijuBxWbVP+uwHFP3E2GI0TR6Li24bcByw5VYlj7G9t0Tpd/1MZzI7Mh+WTBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42vuCU3DBKC1ZchuqydqKGPRYGy97/HG7xFntnKsodk=;
 b=OzWsbuySfNPB53KP7RFWOR6Rsd2+fFqyQ0WhlVC5mcjREM7rtM9AjVeeCdkCiCoeYB3BOUzChKIloN4TBScsPkDUyp1Sx0nC5NnUZv/A6KkNxUvsa/NhG7y/36jL/owgKjmC+N2PtkeYcDaN4I/1G/E0Yi0jNGQNu/mRFvsqxZH2k8g4SxOseTTb3LZ9U70z9Kz6ETVKOpalO2nvIJJungOogHj1POZP0pi7jrbO3nLF6sB8E7Km1TVtobHYE06BscI3BIxopD0obKpcM8/igxUBaa2Orth1r6Vz89ySAkZtizc4Ui3prv59CLHXsarIGHcq23q74lcxEPG5D0QpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42vuCU3DBKC1ZchuqydqKGPRYGy97/HG7xFntnKsodk=;
 b=kTnOV2yX58GiAAz2nDIMRNmGYPvCBhvdFIXgLhnLuxEqHpBZc2VJxo1httPDZZaxX4xkz4ZHqE9qEUbEteGRxKIqbYu3pkAw0dUH19zSw0N06Nk8s1Wz9l1KXjGeOWaj3VCqhrz0sHZP4JcbW2hS2gOLFfDle5xrDqDK5K0jU7k=
Authentication-Results: gmail.com; dkim=error (no key for signature)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK2PR0302MB2451.apcprd03.prod.outlook.com (2603:1096:202:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11; Mon, 15 Mar
 2021 01:57:59 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 01:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zenithal.me;
 i=@zenithal.me; q=dns/txt; s=sun; t=1615773469; h=date : from : to :
 subject : message-id : mime-version : content-type : from;
 bh=oPYLN6hDpYh9p7b6msyQZK28T1pxhrccKSBeGtDEHs8=;
 b=ePff4HMDihmPmd96vTW+CwG3NEVv5yhl3UT4MMrV7jjrAYz1V8C0HDUv7AvDqYFUJbG/L
 3BRWcgnoluCryZMGw1FhDplKtCAVz+UqDnwWmhjkljDuxPBTu1RPJsAWVQtviIRDjRhhpCV
 tknA7GbsWAD3WZJVnVBmPDa1z+kMEdkUEzBFT4skMdXq8wouBmRJIgWubkzwge+J371s50T
 X6XBsYOffFAGxAT8AW3pjw44EjQW7Zns3MZRcIvkBNAhSjfO679DMFzEcsgYpobZz5LHeim
 zGdI3MnIKfMbBtkux6mrUYWnnGeZFybVyX+xDXz8em2ggydACn1zYfMZS2pg==
Date:   Mon, 15 Mar 2021 09:57:49 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: usbip: Fix major fields and descriptions in protocol
Message-ID: <YE6/HQoxkraowTI7@Sun>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vvFdbfCUPjbjK3jh"
Content-Disposition: inline
X-Operating-System: Linux Sun 5.10.19-1-lts 
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 01:57:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b91afac9-98bd-40b5-567a-08d8e755c1d1
X-MS-TrafficTypeDiagnostic: HK2PR0302MB2451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK2PR0302MB2451097425695AA00168D690BC6C9@HK2PR0302MB2451.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0jL6peXYy5DNJvdF2NGOOub6Fn0ySnzl9eLVF2sGwaQ3p8P2dmPkbZbSQqVQTa0Ht8YwBEX9zfGyApe9geVKgpJ4sS0Eps4qTtFH67gwlIzhvhIiVHU8YFMsko7mA9eiX8wU6y8rI+z4S9RN8xbSvUt1hYQisP5GhOQuTN/24Tz2hBD/GZVdLcNVJT0j/HbqyGkJcKAli27D6WM6y9udHUAitRlgvHzNelnxud2mmM0P14eeTAlIOedBmY9miZ+wR7S/zx1e8hwp1DVmn4+Z+sJgiJFAlf9cWrUQroJg9JPKq2QNdOZBAtoZyhuWHtPT8vWieiw8eYKhHlYQebfN8AghXKei94hWXhFQzd1f5QpAr1ot/W9gzJ+RXxOVOHOnlM7gdZgLz1jQJl19+FNHaSZj1iU4TwkG+mwGI7VlUO68WjFdjKJEv466iSM7NIz2j6xi7KDsIJrLUXPfMztexyplD3oA7G4DEfZn1c/NAeNZb1VB5WCBmtT8RWwd7Ef6kTqBwtQMkjEdb1StwCDzsMt2lVL1MyqoQ1LPyJb+lfAn0+ynY2M2vvl7upE/1nqRdZ6dU6HnB+B5DJqQYUufTcUGzzH49DhCreQk5wFQ2wsRQfl18j1htBxtZ/S9UD9g3tcTq5N5pUi5CseEciV3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(396003)(39830400003)(366004)(346002)(136003)(83380400001)(66556008)(66946007)(786003)(16526019)(66476007)(52116002)(86362001)(44144004)(9686003)(30864003)(478600001)(5660300002)(8936002)(8676002)(6486002)(6666004)(2906002)(186003)(21480400003)(6496006)(33716001)(110136005)(316002)(49092004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hlSp1/36rMa0ipYvDV2HFVni9HwpE2RI+UmnRxYE8pcY6OGvtnTjseRQdt4X?=
 =?us-ascii?Q?+rjVoTaPmVCNYkbaQYLwCjJRujl5qRdM2FPGKSCCXbNPQXu6CClmLp9lSDB7?=
 =?us-ascii?Q?95gd+pEfl14vc9Gl+irKlh/OFLPV80SzXGxFUYMyE1lY1MM79Yt9ZoLo3n1v?=
 =?us-ascii?Q?qyxKARJnkTa9VJ3uHT4JcLg14slKX6hKCyeWZKG8U7g3QCUcG8Oq1oP4engp?=
 =?us-ascii?Q?icYZ3lsjvue4toy9G16OMNiKcn8N/Uc/bCl844LDFAfd+JRuwRO0Lye0HeU8?=
 =?us-ascii?Q?sos37xfr0q2UwtkdCesh1OQvFKzjL7SOQopKqh+HMl2rMvcEdGOvK/6iqnuM?=
 =?us-ascii?Q?lZuHWTSMKbIR4umoWnVBbC86cPsx84t5u8ULKEQKl+T0fT0dXhgxzf027AfW?=
 =?us-ascii?Q?XAqcJaxaXE8QGHJNrw6LiCYrBh4iCKY+dFTyVVN0G5dKgTff7XY2eHlnj8NQ?=
 =?us-ascii?Q?FEbQvrZxeBwnqSGcOf4Xy1EbSn/eG/MhSitNVooBJeVDBb+azt+24gmjrYJp?=
 =?us-ascii?Q?b+OGqT4n5jhVElL44/aL+tOcH8+amqUe2RbfF+wpc1g4xl/ewSwgSjLZ9ur/?=
 =?us-ascii?Q?L/u4eOrFUGQGCX7/hnoapahEE81N1dYDmZJ+jB5rz912802l6IFLacjMko2j?=
 =?us-ascii?Q?2ci52f8A4E7bR0cN3kFsR+4IZaRHRaVu2Gl+xWe6KKiZ5dnFF58sEocODPvx?=
 =?us-ascii?Q?xeMnlTnrrH57XFOhcGDQOcx3VmxxAcFCtfpGckRF8Tye20QGXaNSwRMCGMWT?=
 =?us-ascii?Q?88V9DGUaCk30lz9kaG6cXd48JFPB3ew+zYtKW0zCqc3C3/KcYayWzb/xD6JC?=
 =?us-ascii?Q?a7HE2s+aX0ics4MMVnIc7qRIElWd/0UAj+tE6HecmBR/URdH0vLEyVACbycv?=
 =?us-ascii?Q?IcYRr0aByYvAME6nZICOU/k941KknDSYWDwH6jnAipk4ZEmCVdTMI+aXFdkx?=
 =?us-ascii?Q?sz/XEdHaEnUiOkrbTTwS6IpkqXIvu64LrM3bP08IXJKTphXvgq5HwkRR9Z1z?=
 =?us-ascii?Q?bNqUAmKIN6Qn9hTtfuchzroTkwpDM8FB8v56i4MUzQRTh2aIZ9rPZalB543C?=
 =?us-ascii?Q?/Whkz5IPYW5kopVgOblppGFsvgxtX8SPWNQeXBOo/Rpq3KwY9LvtcwIYxHyU?=
 =?us-ascii?Q?a+NHLltf8WihRv747aFXWo8BWohOlcsNT29ayMaU5XNb422/5XPawnfNOTBr?=
 =?us-ascii?Q?jMIxTZekQobOXlHP6APzjXtRBiTiVY/J1qQ3UBY3aqdKSijnqP1jLsXQwi3K?=
 =?us-ascii?Q?nAgeco47g7CGuqQxaUV0O/GhdikTHfjFGaPUgs9vSxfUV8lSGIEHsjQikxED?=
 =?us-ascii?Q?vga56eHAwsYR6CLBa/9f/MKtwiPb54tr502E9oPgdBhtgQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: b91afac9-98bd-40b5-567a-08d8e755c1d1
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 01:57:59.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jocoNB14oK+6hl2MKrpJzkbwgCzGTuicvB1y518HtXxSBTwNM+niSp6VZmw5OzfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--vvFdbfCUPjbjK3jh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

Signed-off-by: Hongren Zheng (Zenithal) <i@zenithal.me>
---
 Documentation/usb/usbip_protocol.rst | 284 +++++++++++++++------------
 1 file changed, 156 insertions(+), 128 deletions(-)

diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip=
_protocol.rst
index 988c832166cd..4c5bcec4a2e4 100644
--- a/Documentation/usb/usbip_protocol.rst
+++ b/Documentation/usb/usbip_protocol.rst
@@ -5,8 +5,14 @@ USB/IP protocol
 PRELIMINARY DRAFT, MAY CONTAIN MISTAKES!
 28 Jun 2011
=20
+Update: Fix major fields in protocol
+14 Mar 2021
+
+Architecture
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
 The USB/IP protocol follows a server/client architecture. The server expor=
ts the
-USB devices and the clients imports them. The device driver for the export=
ed
+USB devices and the client imports them. The device driver for the exported
 USB device runs on the client machine.
=20
 The client may ask for the list of the exported USB devices. To get the li=
st the
@@ -37,6 +43,9 @@ to transfer the URB traffic between the client and the se=
rver. The client may
 send two types of packets: the USBIP_CMD_SUBMIT to submit an URB, and
 USBIP_CMD_UNLINK to unlink a previously submitted URB. The answers of the
 server may be USBIP_RET_SUBMIT and USBIP_RET_UNLINK respectively.
+Note that after successful USBIP_RET_UNLINK, the unlinked URB request woul=
d not
+have a corresponding USBIP_RET_UNLINK (this is explained in
+drivers/usb/usbip/stub_rx.c).
=20
 ::
=20
@@ -85,16 +94,42 @@ server may be USBIP_RET_SUBMIT and USBIP_RET_UNLINK res=
pectively.
           |                        .                        |
           |                        :                        |
           |                                                 |
+          |            USBIP_CMD_SUBMIT(seqnum =3D p)         |
+          | ----------------------------------------------> |
+          |                                                 |
           |               USBIP_CMD_UNLINK                  |
+          |         (seqnum =3D p+1, unlink_seqnum =3D p)       |
           | ----------------------------------------------> |
           |                                                 |
           |               USBIP_RET_UNLINK                  |
+          |        (seqnum =3D p+1, status =3D -ECONNRESET)     |
+          | <---------------------------------------------- |
+          |                                                 |
+          |         Note: No USBIP_RET_SUBMIT(seqnum =3D p)   |
+          | <--X---X---X---X---X---X---X---X---X---X---X--- |
+          |                        .                        |
+          |                        :                        |
+          |                                                 |
+          |            USBIP_CMD_SUBMIT(seqnum =3D q)         |
+          | ----------------------------------------------> |
+          |                                                 |
+          |            USBIP_RET_SUBMIT(seqnum =3D q)         |
+          | <---------------------------------------------- |
+          |                                                 |
+          |               USBIP_CMD_UNLINK                  |
+          |         (seqnum =3D q+1, unlink_seqnum =3D q)       |
+          | ----------------------------------------------> |
+          |                                                 |
+          |               USBIP_RET_UNLINK                  |
+          |           (seqnum =3D q+1, status =3D 0)            |
           | <---------------------------------------------- |
           |                                                 |
=20
 The fields are in network (big endian) byte order meaning that the most si=
gnificant
 byte (MSB) is stored at the lowest address.
=20
+Message Format
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 OP_REQ_DEVLIST:
 	Retrieve the list of exported USB devices.
@@ -102,7 +137,7 @@ OP_REQ_DEVLIST:
 +-----------+--------+------------+---------------------------------------=
------------+
 | Offset    | Length | Value      | Description                           =
            |
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version num=
ber: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version num=
ber: v1.1.1 |
 +-----------+--------+------------+---------------------------------------=
------------+
 | 2         | 2      | 0x8005     | Command code: Retrieve the list of exp=
orted USB   |
 |           |        |            | devices.                              =
            |
@@ -116,7 +151,7 @@ OP_REP_DEVLIST:
 +-----------+--------+------------+---------------------------------------=
------------+
 | Offset    | Length | Value      | Description                           =
            |
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version num=
ber: v1.0.0.|
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version num=
ber: v1.1.1 |
 +-----------+--------+------------+---------------------------------------=
------------+
 | 2         | 2      | 0x0005     | Reply code: The list of exported USB d=
evices.     |
 +-----------+--------+------------+---------------------------------------=
------------+
@@ -187,7 +222,7 @@ OP_REQ_IMPORT:
 +-----------+--------+------------+---------------------------------------=
------------+
 | Offset    | Length | Value      | Description                           =
            |
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version num=
ber: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version num=
ber: v1.1.1 |
 +-----------+--------+------------+---------------------------------------=
------------+
 | 2         | 2      | 0x8003     | Command code: import a remote USB devi=
ce.         |
 +-----------+--------+------------+---------------------------------------=
------------+
@@ -206,7 +241,7 @@ OP_REP_IMPORT:
 +-----------+--------+------------+---------------------------------------=
------------+
 | Offset    | Length | Value      | Description                           =
            |
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version num=
ber: v1.0.0 |
+| 0         | 2      | 0x0111     | Binary-coded decimal USBIP version num=
ber: v1.1.1 |
 +-----------+--------+------------+---------------------------------------=
------------+
 | 2         | 2      | 0x0003     | Reply code: Reply to import.          =
            |
 +-----------+--------+------------+---------------------------------------=
------------+
@@ -254,65 +289,75 @@ OP_REP_IMPORT:
 | 0x13E     | 1      |            | bNumInterfaces                        =
            |
 +-----------+--------+------------+---------------------------------------=
------------+
=20
-USBIP_CMD_SUBMIT:
-	Submit an URB
+The following four commands have a common basic header called
+'usbip_header_basic', and their headers, called 'usbip_header' (before URB
+payload), have the same length, therefore paddings are needed.
=20
-+-----------+--------+------------+---------------------------------------=
------------+
-| Offset    | Length | Value      | Description                           =
            |
-+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-| 0         | 4      | 0x00000001 | command: Submit an URB                =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 4         | 4      |            | seqnum: the sequence number of the URB=
 to submit  |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 8         | 4      |            | devid                                 =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0xC       | 4      |            | direction:                            =
            |
-|           |        |            |                                       =
            |
-|           |        |            |    - 0: USBIP_DIR_OUT                 =
            |
-|           |        |            |    - 1: USBIP_DIR_IN                  =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x10      | 4      |            | ep: endpoint number, possible values a=
re: 0...15  |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x14      | 4      |            | transfer_flags: possible values depend=
 on the     |
-|           |        |            | URB transfer type, see below          =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x18      | 4      |            | transfer_buffer_length                =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x1C      | 4      |            | start_frame: specify the selected fram=
e to        |
-|           |        |            | transmit an ISO frame, ignored if URB_=
ISO_ASAP    |
-|           |        |            | is specified at transfer_flags        =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x20      | 4      |            | number_of_packets: number of ISO packe=
ts          |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x24      | 4      |            | interval: maximum time for the request=
 on the     |
-|           |        |            | server-side host controller           =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x28      | 8      |            | setup: data bytes for USB setup, fille=
d with      |
-|           |        |            | zeros if not used                     =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x30      |        |            | URB data. For ISO transfers the paddin=
g between   |
-|           |        |            | each ISO packets is not transmitted.  =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
+usbip_header_basic:
=20
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
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
=20
- +-------------------------+------------+---------+-----------+----------+=
-------------+
- | Allowed transfer_flags  | value      | control | interrupt | bulk     |=
 isochronous |
- +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+
- | URB_SHORT_NOT_OK        | 0x00000001 | only in | only in   | only in  |=
 no          |
- +-------------------------+------------+---------+-----------+----------+=
-------------+
- | URB_ISO_ASAP            | 0x00000002 | no      | no        | no       |=
 yes         |
- +-------------------------+------------+---------+-----------+----------+=
-------------+
- | URB_NO_TRANSFER_DMA_MAP | 0x00000004 | yes     | yes       | yes      |=
 yes         |
- +-------------------------+------------+---------+-----------+----------+=
-------------+
- | URB_ZERO_PACKET         | 0x00000040 | no      | no        | only out |=
 no          |
- +-------------------------+------------+---------+-----------+----------+=
-------------+
- | URB_NO_INTERRUPT        | 0x00000080 | yes     | yes       | yes      |=
 yes         |
- +-------------------------+------------+---------+-----------+----------+=
-------------+
- | URB_FREE_BUFFER         | 0x00000100 | yes     | yes       | yes      |=
 yes         |
- +-------------------------+------------+---------+-----------+----------+=
-------------+
- | URB_DIR_MASK            | 0x00000200 | yes     | yes       | yes      |=
 yes         |
- +-------------------------+------------+---------+-----------+----------+=
-------------+
+USBIP_CMD_SUBMIT:
+	Submit an URB
=20
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
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
=20
 USBIP_RET_SUBMIT:
 	Reply for submitting an URB
@@ -320,92 +365,75 @@ USBIP_RET_SUBMIT:
 +-----------+--------+------------+---------------------------------------=
------------+
 | Offset    | Length | Value      | Description                           =
            |
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-| 0         | 4      | 0x00000003 | command                               =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 4         | 4      |            | seqnum: URB sequence number           =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 8         | 4      |            | devid                                 =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0xC       | 4      |            | direction:                            =
            |
-|           |        |            |                                       =
            |
-|           |        |            |    - 0: USBIP_DIR_OUT                 =
            |
-|           |        |            |    - 1: USBIP_DIR_IN                  =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x10      | 4      |            | ep: endpoint number                   =
            |
+| 0         | 20     |            | usbip_header_basic, 'command' shall be=
 0x00000003 |
 +-----------+--------+------------+---------------------------------------=
------------+
 | 0x14      | 4      |            | status: zero for successful URB transa=
ction,      |
 |           |        |            | otherwise some kind of error happened.=
            |
 +-----------+--------+------------+---------------------------------------=
------------+
 | 0x18      | 4      | n          | actual_length: number of URB data byte=
s           |
+|           |        |            | use URB actual_length                 =
            |
 +-----------+--------+------------+---------------------------------------=
------------+
-| 0x1C      | 4      |            | start_frame: for an ISO frame the actu=
ally        |
-|           |        |            | selected frame for transmit.          =
            |
+| 0x1C      | 4      |            | start_frame: use URB start_frame;     =
            |
+|           |        |            | initial frame for ISO transfer        =
            |
+|           |        |            | shall be set to 0 if not ISO transfer =
            |
 +-----------+--------+------------+---------------------------------------=
------------+
-| 0x20      | 4      |            | number_of_packets                     =
            |
+| 0x20      | 4      |            | number_of_packets: number of ISO packe=
ts          |
+|           |        |            | shall be set to 0xffffffff if not ISO =
transfer    |
 +-----------+--------+------------+---------------------------------------=
------------+
 | 0x24      | 4      |            | error_count                           =
            |
 +-----------+--------+------------+---------------------------------------=
------------+
-| 0x28      | 8      |            | setup: data bytes for USB setup, fille=
d with      |
-|           |        |            | zeros if not used                     =
            |
+| 0x28      | 8      |            | padding, shall be set to 0            =
            |
 +-----------+--------+------------+---------------------------------------=
------------+
-| 0x30      | n      |            | URB data bytes. For ISO transfers the =
padding     |
+| 0x30      | n      |            | tranfer_buffer.                       =
            |
+|           |        |            | If direction is USBIP_DIR_OUT then n e=
quals       |
+|           |        |            | transfer_buffer_length; otherwise n eq=
uals 0      |
+|           |        |            | For ISO transfers the padding between =
each ISO    |
 |           |        |            | between each ISO packets is not transm=
itted.      |
 +-----------+--------+------------+---------------------------------------=
------------+
+| 0x30+n    | m      |            | iso_packet_descriptor                 =
            |
++-----------+--------+------------+---------------------------------------=
------------+
=20
 USBIP_CMD_UNLINK:
 	Unlink an URB
=20
-+-----------+--------+------------+---------------------------------------=
------------+
-| Offset    | Length | Value      | Description                           =
            |
-+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-| 0         | 4      | 0x00000002 | command: URB unlink command           =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 4         | 4      |            | seqnum: URB sequence number to unlink:=
            |
-|           |        |            |                                       =
            |
-|           |        |            | FIXME:                                =
            |
-|           |        |            |    is this so?                        =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 8         | 4      |            | devid                                 =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0xC       | 4      |            | direction:                            =
            |
-|           |        |            |                                       =
            |
-|           |        |            |    - 0: USBIP_DIR_OUT                 =
            |
-|           |        |            |    - 1: USBIP_DIR_IN                  =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x10      | 4      |            | ep: endpoint number: zero             =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x14      | 4      |            | seqnum: the URB sequence number given =
previously  |
-|           |        |            | at USBIP_CMD_SUBMIT.seqnum field      =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x30      | n      |            | URB data bytes. For ISO transfers the =
padding     |
-|           |        |            | between each ISO packets is not transm=
itted.      |
-+-----------+--------+------------+---------------------------------------=
------------+
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+| 0         | 20     | usbip_header_basic, 'command' shall be 0x00000002 |
++-----------+--------+---------------------------------------------------+
+| 0x14      | 4      | unlink_seqnum, of the SUBMIT request to unlink    |
++-----------+--------+---------------------------------------------------+
+| 0x18      | 24     | padding, shall be set to 0                        |
++-----------+--------+---------------------------------------------------+
=20
 USBIP_RET_UNLINK:
 	Reply for URB unlink
=20
-+-----------+--------+------------+---------------------------------------=
------------+
-| Offset    | Length | Value      | Description                           =
            |
-+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
-| 0         | 4      | 0x00000004 | command: reply for the URB unlink comm=
and         |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 4         | 4      |            | seqnum: the unlinked URB sequence numb=
er          |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 8         | 4      |            | devid                                 =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0xC       | 4      |            | direction:                            =
            |
-|           |        |            |                                       =
            |
-|           |        |            |    - 0: USBIP_DIR_OUT                 =
            |
-|           |        |            |    - 1: USBIP_DIR_IN                  =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x10      | 4      |            | ep: endpoint number                   =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x14      | 4      |            | status: This is the value contained in=
 the        |
-|           |        |            | urb->status in the URB completition ha=
ndler.      |
-|           |        |            |                                       =
            |
-|           |        |            | FIXME:                                =
            |
-|           |        |            |      a better explanation needed.     =
            |
-+-----------+--------+------------+---------------------------------------=
------------+
-| 0x30      | n      |            | URB data bytes. For ISO transfers the =
padding     |
-|           |        |            | between each ISO packets is not transm=
itted.      |
-+-----------+--------+------------+---------------------------------------=
------------+
++-----------+--------+---------------------------------------------------+
+| Offset    | Length | Description                                       |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
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
+=3D=3D=3D=3D=3D=3D=3D
+
+  The following data is captured from wire with Human Interface Devices (H=
ID)
+  payload
+
+::
+
+  CmdIntrIN:  00000001 00000d05 0001000f 00000001 00000001 00000200 000000=
40 ffffffff 00000000 00000004 00000000 00000000
+  CmdIntrOUT: 00000001 00000d06 0001000f 00000000 00000001 00000000 000000=
40 ffffffff 00000000 00000004 00000000 00000000
+              ffffffff860008a784ce5ae2123763000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000
+  RetIntrOut: 00000003 00000d06 00000000 00000000 00000000 00000000 000000=
40 ffffffff 00000000 00000000 00000000 00000000
+  RetIntrIn:  00000003 00000d05 00000000 00000000 00000000 00000000 000000=
40 ffffffff 00000000 00000000 00000000 00000000
+              ffffffff860011a784ce5ae2123763612891b10201000004000000000000=
00000000000000000000000000000000000000000000000000000000000000000000
--=20
2.30.1


--=20
GPG Fingerprint: 1127F188280AE3123619332987E17EEF9B18B6C9

--vvFdbfCUPjbjK3jh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQSdEFvOhgGwtbRRtKERicZZ89BMHAUCYE6/HAAKCRARicZZ89BM
HIyOAPsEnjCN7fgRpDbyo/a/2MIxJbYLPzybxSoPjN/ltN6IGwD7B3W5NW0RksyF
LvEpp2/71E53AXfQzESTtJQ5RHvlCgo=
=wVN5
-----END PGP SIGNATURE-----

--vvFdbfCUPjbjK3jh--
