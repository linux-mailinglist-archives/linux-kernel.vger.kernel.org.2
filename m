Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E23453EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhKQDbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:31:33 -0500
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:24942
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229997AbhKQDbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:31:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/9Fx9p2SfjCIUtEwpdraLcXGvr6stXtMXgkK669d7+T8vqmXaGfu1TwQj5eUwV5fDqImbwzL1c/1uaff15Bz8SOOzIZo1ZU7jQ/Rh8bcAQfFev6n1cLQe7yCq37zMc5q0Fsh4l3PdyjabP5ziNQMUqyOUhHDPj4oP9lkv6urIQbu4i5VehlzisO/qI5Oi4RL3MNZDERAxOVGPGrrQwrMzU0mtaLd6vEFWbI9ppiunk0weEokEfuVd/4a51VTUiCXblwdifLYxehEm2dizHfhbC0lgu4iRmCyX9cO+w988IFyDTRUhmYhXV0hAhbC9qOzLvfR4vN75MZZym9e98OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMgfsXQysMRmeWsn2qWiHYPKZXS6hRD6snA2YtwbChY=;
 b=Efmg9r2G54KUeU6Gd4Weqvu3wVpgsSiP5kIDYPQZiLsyNTygVt/AJLJFgbvOMSrmPDvI4uIEwLJxUYZSQNqIyAJIBujJscMTFsfdNQiQyjcZtcKQZb2O6iCTRroorG75aPx161dXIi3cTONdhzr0yQBt1x0VHq2lb60YiT3WIUDE5tRSB6VHvk1pZtYB5AvM56XFJHeoPB15iF6kSO1b9/5qtD58LWW98FOZR+xnnE4gwzSpRsnlxN6YZkqX529eiCjLXRZt/rRE+tFZ5F9k46M7bzohkPnxm9VISgviUPXnSVxlh6p3deRMlavjmULd+ZJK8z39kOz9vj+qqdhU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMgfsXQysMRmeWsn2qWiHYPKZXS6hRD6snA2YtwbChY=;
 b=mRyNcz5GtVw1mutPjBmIUYoHoHOBuWVh7d0KoRjJoyuI5NIszRJqTmPtf2tu2aczTiW8hYr0y0zV0tctMYsFBQDEXZrWkH9L9nJx+FHfSBDAC4xnieeQkAdZkvsOZliNkus4jgtJ7Oq1220fHbsErk1RFzWz4xmCWa8v9F4vdzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8518.eurprd04.prod.outlook.com (2603:10a6:10:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 03:28:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4669.016; Wed, 17 Nov 2021
 03:28:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] add i.MX8ULP scmi power domain
Date:   Wed, 17 Nov 2021 11:27:37 +0800
Message-Id: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 03:28:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc66329-f5ba-41ae-8c9f-08d9a97a53ed
X-MS-TrafficTypeDiagnostic: DU2PR04MB8518:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB85180BB93383AFE53080C791C99A9@DU2PR04MB8518.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZPwYohKj7p61Xz2lftGwX9AVVA48Wr3Bd/5uh79YET6Iqfi4hyWdFzrkjsJeO4HBz/iPszZL2xvhM0EQgbEzqJB32peY01vygaHovY482yXgMVu+b81r9UFbFjmrfq+wgDDnYa14Tz0PlWzZzALmmNDvXZPF+4wEB12+qWAa8nW28dS/RujrDGi2GU2Bz2aBqjhgMNIkOrKNDgDDGOVz4aZy6cYT+dxHScyMVmytvILkG3manrGeK/MFPawWoCeY689OOxIyR8ksO2eMQVB90/7JMCVbCUx/vNPBarM2KeFu9rSJ9Ce/88mQNXU0gehcprUergA3ArbuBmAsT1so3JIDywyevwLABonFmPxSPcHbcg3X/0v94hSrjQhh2zlMBpx5tb0s6zQ8Ise5SJLfsPzM7vHkxpuEUVWdWscxdvlL9lQYyU3+g6aeu6LvLDyNX7VfUb8ByzcSByLw91x03+RS3F3grRtWsgJ3Nq2dCCEi8LVgfLz38IkrnhyRTOJkIkmkUKNwmn5ILXgIabrr0mu9rbBzHpdF1pY7ROwkhH5xmXD6M9zlgahWOecXkOsJUPUiFy1DEMgnAv/htaWYhzXq9+lw6otQZYsnBTdnstNRNjZCy9Wof2uFl8DgJhV8oPObRLRKIzlR6AHdSBz/tQ2MAua30J4ErXwBC6sGJG5cgKrigwfnCMRg5Ckf8GsSao4/TUTVMlezLu0TrSEGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66556008)(66946007)(6486002)(26005)(66476007)(38350700002)(508600001)(956004)(4744005)(2906002)(316002)(38100700002)(6512007)(6666004)(8676002)(1076003)(186003)(4326008)(52116002)(8936002)(86362001)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qFUOwpIHYcmF3wNKD4rIUbBIu85IK2SEyYY8syfwPgDlyXiGLCjkKO2NH4sm?=
 =?us-ascii?Q?QwnAecROT49+TwaotlZp32jxw+7qCI3TBOd8+lElsJFDVeub/iIikLm25mPb?=
 =?us-ascii?Q?wNqgvZdwfBD1KUOBm2Ra7ujUZOw1q23xeI1X7iAW12fuBulfiOgcaur/0izr?=
 =?us-ascii?Q?OCjCirfzziDuI7QW+iWWv36VV1jofcb2JV0cI5tvd0E/698pstePH1/xZnH2?=
 =?us-ascii?Q?HQBc/FuRr5qu9KQWngM0N9xSzWxDX1Tu4OJxoelMSkhgS3GhlHq/dVOE6iTp?=
 =?us-ascii?Q?3e6O1/q7cH1qLwi1/537bTw/4tBuOJHxxkapRNv50T/LB8JSfVR4nzhuGPz/?=
 =?us-ascii?Q?QvH3Yv92CFqHNtMrwcIUTF5bDda4bOt1YvpgPgYWsVDoRSJ4VV5baFSj90mA?=
 =?us-ascii?Q?C22GUtkuB+iAd57oqx8ueLhMjQdL6JevSWpay0IIYE2ZO5ygSBb7d7ZGP3JQ?=
 =?us-ascii?Q?WSmS/B1FDdOtdDUcl26UngLDX1aUwZMl0DGEdqhon5N1lnkkCuzt4x33dazg?=
 =?us-ascii?Q?RNs8Eb1f+l7cLe1t5fRpMxSbJfNPX2ouUwXvR4hZ+NOhkYlCvDp2B2mi0Wx0?=
 =?us-ascii?Q?jFTo0mPm2+VCJ4jPuINk9VrGzN1ZWmoLJSnA/PmpAk7rp6dXuYQoYwMsWNmp?=
 =?us-ascii?Q?JFIsMhg99yEj7xXlgK63U2z3X5yu/sbO6x0BRCpwKkFJMmgyXjKBcKcEF83e?=
 =?us-ascii?Q?v25bIZGIbTdcK52mlwmAG5XuJZIBrnWV1AsfymCR7KitVPBrMyJZMXRVpgO1?=
 =?us-ascii?Q?qFMG3aEl2hPAPUm2rUk9v9iepPC+tr12gn/Sycat1iLQK3gXb+8e04solBYm?=
 =?us-ascii?Q?CcherRzFU/mkwk4yYX2x2Nm5r2W0RVDQzUN0W5tGErLLN1tC0OWSCeZGax9x?=
 =?us-ascii?Q?wVVAm5rooBNTMqMZcu0hEO9rZ4F2auHSfzBkL6DdmgGFJJpGZTmho1dIvtyd?=
 =?us-ascii?Q?URhyA3/exg5p4OeHGQ4drs9WVuvGDvMfWIFUR6+PBr20RY+RYVP1T2QXeMAS?=
 =?us-ascii?Q?zPtL2lv8PbdorIGcchSGBpgra9Z0O2RmHDOnIDGwqpDg2NaWcAeEYdI2GDOX?=
 =?us-ascii?Q?o2/v2hxaTXFBMdVkqHMYSswd11VUWrnsM+HBcnqhAIaXt6xa6AlSV44KCI9G?=
 =?us-ascii?Q?B2BRVRc1qkqNvLDEmzxLzSR9s0EIy17Znul/58vGQ0nuwBU94R3kIQU/WLFl?=
 =?us-ascii?Q?GG8qysLdviq3JvPkTS/O7MlsZLGg1NaX6HiSFFyO7YVB1K8HR5waU8LfITmu?=
 =?us-ascii?Q?jxQOgZmr/Q5OJIEWEZ6wZKoi53R6SAAVJ3//LmiySp3MG8XVQFKjbK7iVFud?=
 =?us-ascii?Q?2Gh/vZtiEwbVQkj63CrYXqoIAFuOQ5MailsdGITTgHyvqKH2tPDC9gdPMTbT?=
 =?us-ascii?Q?vOZvtul2PlLx4pxXWj4f4OKYIElfIqvv56pl7P4Erla91ov1+cYQQaGFLh38?=
 =?us-ascii?Q?z5XQRkUc9COf8JAcJlCy/tpsrOf9SBXi91ZFAYze40L/GaDhrhelFfhE7aFe?=
 =?us-ascii?Q?zEqEZZHSRloH1j8BPQnfT62za/IDhQm69NnKQof9d/TN+59u4+c/vmXnxo/2?=
 =?us-ascii?Q?jYkVjeLA7tYLwzWy0bXojGFgjqMUgJr33C8gMWKH3w4fe+u2TlE0tVrgFfCx?=
 =?us-ascii?Q?KPypMAfWRxFSIHO+mXo5iFo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc66329-f5ba-41ae-8c9f-08d9a97a53ed
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 03:28:31.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CnLiKZClMYAZzdhnqF+WPZhqazkovLExdPGGL0CNNKUb4GzhYUv0EzDQRdtmmDHvwOX6yafnwn47CAO8r/I5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8518
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to add device tree support for i.MX8ULP SCMI firmware,
and enable it for USDHC node

Peng Fan (3):
  dt-bindings: power: imx8ulp: add power domain header file
  arm64: dts: imx8ulp: add scmi firmware node
  arm64: dts: imx8ulp: add power domain entry for usdhc

 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 38 ++++++++++++++++++++++
 include/dt-bindings/power/imx8ulp-power.h  | 26 +++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8ulp-power.h

-- 
2.25.1

