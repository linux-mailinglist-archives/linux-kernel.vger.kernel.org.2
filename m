Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD10394008
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhE1Jez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:34:55 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:36613
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234618AbhE1Jev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:34:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1Dlf2tiEQxvr2x6Qeo1e7i/Hqa+ymH9OJMw9yecAOugXTgf9ULgP8/FH5djij4x+WjIG9u+o5xWfib6M6X83vywysvYfzn88qTp0phdA9TZlUiJRqIB/0A1/afqS78z0w7eVnL4xrGWvv3uRDayodFBbMAvAQmDVO40kwXWL8llg/MP4cAp4g7RN+sDzvoZJ+O2l3LBXtLz+EyqhAMYooFlXYtt+yg/c16gbCVvTg9DlD7ey5nYbgniCPr+LydFXh2R3i/MayrtAYwoXqNeHYssmHNCMZrHrAJz3ScwynGhnH/2uZZ9hHPyb6DQ5RC/FbLXlzj4aKJrMApH5WFXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFlM12RkdLJRXdzY0NhA7Eu1KiWTVo10rGq//7tXRQs=;
 b=k07hy8nf+7OKfcNNTX0y6f40HaBvrk0jjwJXk/Kz91R7PDMoxedTegZ+DENTJAMiJB6yjlkBtha2Iv2d3aZ+ZqpberYm5Tb6HbxOMDv0bv46nkTI14XpoVwD8c0TOCGs5+v/hyiz7vk1pJWu50gzLMftd7Q43ROtdFRDBiqpG2Ug6W5vgMcFZjMIkS6h7aC/DvPhmnWk+34Y5Ckpk8BtXVRjJO2oYF8NxB+6unGjL7dHMKPBG/Eh0cJoDMfYKrVKbV4G/+liVDWCUqNNZclnAmrvrTya03NVGNAB4v3zFlCdEcIoqSr7he/mf1zAfIXx4R2ikxS3RRM8CvEUuV9B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFlM12RkdLJRXdzY0NhA7Eu1KiWTVo10rGq//7tXRQs=;
 b=fVJRXFqu0jaT8yAhwr7bSLMEqszclyBavuUjNEJLVB4hh75IRcvZ7+gUN5QJoExiQEMNhNPZl5/BV0d0RuVpxQ16SIC1AMvu2C7ufLpa031gLHjlTHqSVBUdyZKg5OwLB8QxcUm/BpXuIrBb+fbXq8dZ3HfrOpjkK2/Ti+dpaRU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7302.eurprd04.prod.outlook.com (2603:10a6:10:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 09:33:12 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 09:33:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] mailbox: imx: add i.MX8ULP MU support
Date:   Fri, 28 May 2021 18:05:59 +0800
Message-Id: <20210528100603.21759-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 09:33:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43b33137-83af-4aa3-1df4-08d921bb9cb1
X-MS-TrafficTypeDiagnostic: DBAPR04MB7302:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7302A8D2B79D8098CD2B6827C9229@DBAPR04MB7302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzEKhc7uMBmgGfP4B/tNYfWEtk/hwMCxY9MvMkv//0r1ooRgKRVqFxLabgxuJ2Lz5sVIK4XXuZr1YNI8No/jtlhQOFzZNiMJsi9kTaT6c2nG5y5MEhpd2HvnBF0OGBcWjwa/l2QTi6UInSpdTw33tGajwwKdNxNGViZ4j20WZSlW3Ae6b8gDj0taRjK/2nlIDgvfsiQ4+XpLaMCirFUl87EZ2Trsgdv7viGmzqC1a7oOtpgiQEyxP9JYpkyHewvo+1y8aVpHE/Q20d7gANt+/ax4h2E0fpjJL5jqS27Ys/HtPEODuF+ouOcJTHdpep8N0CZV5sebt8gOgMELWY6ZvWRTp2MWq4KwvFd0z19yLrIbhVCv5QkyaicnfqmeIBCGxqMYh1k+w3RMsf5pSKUt+BSEZ+TC0foZw2c+AaKJyfmfyk4TbtFpf2YZsAZINJyXxV3DUtqNN3tuZXRbYVnwAZnQjBcX8Unt6VhVdb0KflLwn3qAB9jm4+ACQxKmIw9eW5boPwDn+xyWE/PpJJpPM6I341LyRsFDXlFYCjS9mNmYso7jPQRjQrVSv/WIpXtLRnK/7IRfPn5nxfU31r9hhbLycsKG4M1C3Zb7yZ8nlXPa6Z8srHSKayTTR4WH52C4X25XJdd7MBuPyTYIcknZQEBScK4aHUd0i05/o2D7MGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(2616005)(26005)(38350700002)(186003)(86362001)(8936002)(6666004)(8676002)(316002)(4326008)(2906002)(83380400001)(66476007)(66556008)(15650500001)(4744005)(6486002)(6506007)(52116002)(38100700002)(7416002)(956004)(5660300002)(66946007)(16526019)(478600001)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4vkECobvkEvKk0qyuIdlvG9ZPNhRLK+tvenPBaP79F4Ifq9KK/oXDkfV956L?=
 =?us-ascii?Q?WhaxJnJxipQraYsSnD++EbXkdSKu6OtvN/EjsBzGVXC0U4SCwleV9Zn4fdG+?=
 =?us-ascii?Q?IlGs0WQLta3MWSX8zfeZS+t/coRMH+phS3ljn2hw4HRFH1LgUEQSnO0f9A/j?=
 =?us-ascii?Q?hCs/VLh5XrfevwTNVaCFOWklZU0cyGPjtis4FejvUQnE8LxUtqZemqSqfTXk?=
 =?us-ascii?Q?oj8Q02WluB1c1jxQXJKYrxSAgp1L2NQ5qv0t6djCN/TCmaURVsPFcEjWdRZ7?=
 =?us-ascii?Q?L3TJm3fR3fUypgM6rvJKvfFnnZORt1yDVRaQMJqiSwion4bpuUiiF4n4v0R4?=
 =?us-ascii?Q?bzX9A1efl1x6LnVwy+t7p4CyMHfGV5ye6PAFqFzi+s4PbejH71WJ/Q0eTSNv?=
 =?us-ascii?Q?SF4M4t5B6EGNXXTX8QVicFDUZPWEVMR//L8g+fFdnbrpVPOZDtIMXURCepd2?=
 =?us-ascii?Q?ozwfEYH7o2pm1igX0TTdJS/GWFXPJPOuzmTgcch+fgIIDGQhzuWt1c+CX7L9?=
 =?us-ascii?Q?5a4eUOItMZkeLVK+km8d94yjoaD8USThT4Zy48hKop0EGZG7M4O4hQ9xeDZ0?=
 =?us-ascii?Q?17gm6XjlCMAlLpXzKhb5zD9HVtu083GatHQFMz+kD557A5giOTwBtyHqzrjO?=
 =?us-ascii?Q?FXR2hhg0putorbuFa9go61weJymd+7gfr0hap7NRe1xnTcR9ksl9ZGQ5GAyd?=
 =?us-ascii?Q?J92Vk9OBUYtl8y46bkCX8AfeJitzhfa/3V6hWeRG9627mamKt55zHUxiuU3t?=
 =?us-ascii?Q?0tu0hPSIWDcWBhJGo3a6zKM23Sx5vQAddQ9tKriea2yfXvk4yEpteaUp0Bgz?=
 =?us-ascii?Q?NAVJtzab3t+P4XyjHvjWBDqpk/X18B9SgvBwNBaJan0/y8vOn5BehX7GLLR+?=
 =?us-ascii?Q?1TJYtrMBMa3sVRi0UoQGoIC83lmQFqntLiljD8sATbAcZEza9+RSXuzK5b8G?=
 =?us-ascii?Q?MdKl0hkyjsigZ2g2JwjRtap+x8BJxG9lDTUuDKtvkfHjRp4DjbihNKPagpIZ?=
 =?us-ascii?Q?VVelwlC3SpzW1S63Uqv0Gv5Ge70wWyGlvuFvGIJ2vkQb+9gZAOsFRrBYpKnx?=
 =?us-ascii?Q?/bgSSQ6YYAlsjhs54f4OYLGmLKZQK7rsdaVOp/6++UZxs6C9Si49W8D/e10n?=
 =?us-ascii?Q?QSCheYGlrM+hs7EWIC9Det6vmYeSSf6ka2SPjTX0F9LO/2/jW6bKUMnOicSf?=
 =?us-ascii?Q?gLN49DOTN62C14a6FozZTDJQcSnpXCl0kb+ODsYpn0cInFpZGNrbduLv7qcI?=
 =?us-ascii?Q?qgUvpOQsqTKp2W7paGeQcLE9g5d1J6C5i1cU17QKAQMK6mZxiG/Yv/m6sGyK?=
 =?us-ascii?Q?Sqrq5wlhR/hsUf0QK8zRXa/PyXjh9Ufx3PDFMJUozOYdPQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b33137-83af-4aa3-1df4-08d921bb9cb1
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 09:33:12.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivceVwuwUNPS8BS7UA/7VsOOXhwsKYiWpvU1TKjGXpLT04stEvzrsM24YX0xDFCgPP/raaScoO1mwAUEC13IiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7302
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Add A-b from Rob in patch 1
 Fix RXDB for i.MX8ULP in patch 4

i.MX8ULP generic MU is a different IP compared with previous i.MX chips.
It has different register layout and bit position, but the register name
and bit definitions are almost same with previous i.MX MU.

So we extend the current imx-mailbox driver to support i.MX8ULP.

Peng Fan (4):
  dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
  mailbox: imx: replace the xTR/xRR array with single register
  mailbox: imx: add xSR/xCR register array
  mailbox: imx-mailbox: support i.MX8ULP MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
 drivers/mailbox/imx-mailbox.c                 | 196 +++++++++++-------
 2 files changed, 123 insertions(+), 74 deletions(-)

-- 
2.30.0

