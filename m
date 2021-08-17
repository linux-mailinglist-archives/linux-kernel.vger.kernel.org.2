Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF603EED07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhHQNHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:07:11 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:52320
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237236AbhHQNHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noXMmRTLyG9Jad7zBvs8cLQB9dGdi80rz5LC9XfAjr48wT6/XHiiOIpPxBBFD6J4zteTCWLwpMCryf920sg/FlRXE2eIoPHm98rGREPGSgTtLi1dmSPBPfd6fx5l0c9BHOFKicgvnvpK3r4qM6bXdHnTpTb2W8AWfNuMDRz4fpPM/9l1+aFEDZvJ8JznyHaXSLBMyv6aw+PDOw8KWQD1NUouX2WTjOIV8r3UZblA7lbrNtEFcm72TxppcAt3/RvoPUllz92eecLwjCzrwD6Jw1wBZO6JXOtwUL3W+YFscGpzbBygZpkBWnMHSCuXx4HG0fceWLrriLw+1gzEw4vzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo0DgHTO60tD5cVDxc4eYmYXY7Hy1rLpphHzlx7eV7A=;
 b=biGxP3qCHyvTKv7+ry+w0TRFUzD41guOyBMXT25LQj4BvbVSSIeBLTEHVC2Kpnhx9rlyClwdrxRxKTFfTwmKnGXGfKNJG1Gl3ZhALXupUZY1sn2a+mp+O6BxTBBaw+9SZ3mDhKynrDe6Kg7gyIjdpHPEEtoSTLR2n/NVWvqlqiEDRfL90pHjiEr2vBKIhnRAH82D3fdVYVfcHF69cBnfNiiFo3akEJlx3mbChkocYduzUvSiDu6J+YpYn3tFkcHQqp3qZFVVQKcU55CqSZIwxX0n0+nZUTIh0zjlVsB95b8OIdgGWQNRImivZAHmuyHNClYWwuqZLHaXtLdI/Qz/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo0DgHTO60tD5cVDxc4eYmYXY7Hy1rLpphHzlx7eV7A=;
 b=nRw6i8zUhI5TURvtHiJYNvhBK0FYq12Vt0pTYOWJHAL3w7oahqFnZ+0zEQt3/f3fGWMu5AnU3vZM9GGrvPv8WZTP+7r5uk5LWUChF5TGRypLmlIh5eBe6xLrT7N+r0Sbvh8QEvT2HcQ9pOzTcvUVdTv6HIOGxVUDi9BSFBKGb20=
Received: from BN6PR14CA0017.namprd14.prod.outlook.com (2603:10b6:404:79::27)
 by CO1PR02MB8347.namprd02.prod.outlook.com (2603:10b6:303:162::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Tue, 17 Aug
 2021 13:06:28 +0000
Received: from BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::e6) by BN6PR14CA0017.outlook.office365.com
 (2603:10b6:404:79::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Tue, 17 Aug 2021 13:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT022.mail.protection.outlook.com (10.13.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 13:06:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 06:06:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 17 Aug 2021 06:06:27 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=34742 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1mFynT-0002Yt-4K; Tue, 17 Aug 2021 06:06:27 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 0/3] Add support for runtime features
Date:   Tue, 17 Aug 2021 06:05:50 -0700
Message-ID: <20210817130553.20219-1-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d4e8d2-d07c-4f48-4e21-08d9617fd305
X-MS-TrafficTypeDiagnostic: CO1PR02MB8347:
X-Microsoft-Antispam-PRVS: <CO1PR02MB8347574EB3571B8212EE2CD8A4FE9@CO1PR02MB8347.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dK+seJSfsiXXk8XwLL3nOu5VPwJX8TaNFO0stbe3YW2Wuqrineu3i0gQOmlo3aMo/GQ4S24Tvia+YFEn2GuqFRaXb2E6QuhG9cVGWGjQVqVkYSXpCr/eu7rXNWhLgAe671pZ4SduJrx6GnCJRDx0irCnOegux0IgWH3CfInspaeQSlBPdSrmRPutwtARpYl3zX87hE5KMyInJcOt3OHcpgvCcSEA7JhcUzSdxNzjUb+gzWP/uP0vugkKBGEYS3cbkHOo8E7TahiAdBfg52Oi+gBFyiyLnqRYn4w0ww1PPAX8ppAmcd55I6CW5o+Ceb9uwnBxbFK2EODANuSajm3lgIG/27E2spVsRvxe3HiSHzsQmrDlkmmYNSWyYQ0vMaW801esJugHTayNAmlbWwAEjVYzj5G07KpzrHUo71wnT15YiPv57wFDHMGLCYqimPeXh8nNr4/SGeEovQ5krpQNbro46miq9mUaCQ1P0PNOPuT69GoiRgcwYd1AtUKu2oTyHbTMrw5BUq77EpCTqaD9WURk7f/7EhIiLle5LR1D82T2lpkM+A2yL8JL/VzayRtDt71AnlYf/dhig+lox2WoJmfXQMA8LZBqc0kZpVJ7GnH9ChRs2y3oW8Txldsm1W/kb9Q7iIlmgXc5pTweqE2OXdaBG04bGgew+O+vQ3X3sPHMqmBfIBwWH2582SvwMzxyPAMAUThfJ0ibmNIec7+LXrvbw0EflK9c3CJLm63tfDE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(5660300002)(478600001)(70206006)(70586007)(82740400003)(7636003)(356005)(2906002)(7696005)(26005)(186003)(36860700001)(6666004)(36756003)(4326008)(8676002)(82310400003)(1076003)(83380400001)(36906005)(2616005)(110136005)(54906003)(426003)(44832011)(107886003)(316002)(8936002)(9786002)(47076005)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 13:06:27.7387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d4e8d2-d07c-4f48-4e21-08d9617fd305
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8347
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for runtime feature configuration by using the IOCTL
 calls. The user can enable or disable as well as can configure the
 runtime features. The support is added for the over temperature and
 external watchdog. The user can configure the over temperature limit
 and external watchdog timer interval at runtime by using PM_IOCTL
 calls.

Also, added support for sysfs interface for runtime feature
configuration for the over temperature and external watchdog features.

Ronak Jain (3):
  firmware: xilinx: Add support for runtime features
  firmware: zynqmp: Add sysfs entry for runtime features
  firmware: xilinx: Add sysfs support for feature config

 .../ABI/stable/sysfs-driver-firmware-zynqmp   | 84 ++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c              | 98 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 25 +++++
 3 files changed, 207 insertions(+)

--
2.32.0.93.g670b81a

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
