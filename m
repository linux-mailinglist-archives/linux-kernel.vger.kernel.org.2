Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B886408731
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbhIMIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:41:23 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:52544
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238054AbhIMIlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:41:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8cujWzj2CcAzpBhJ1Zjmgi8OBU094behY7v2kA0FLJUx9eXyvyfCMK73vrAagpiyBEaDWc3oefvSXHG6v6dZL3RVxgkWdMox1VOWYkGrobNcudTiFMhVGK/f1qOzHJwQzx8fexHBWwD8Up4Gwqpy3O62c7aVBiyKJBQ2gV34eWFvghLDH7Kq2TSRTFwLGtkNlNGG28AMGhFYWInyWkY4/W7Bz3FgIpM6O0D+D+zvsK9SG1tJoc64YcXsZC6UXA7HuHIAdZNSKCke9aTa5a4MNuUA9l9WHBNyBvgLL9LnuTUcbkQNQMHrtVT3r5kbruqPCFVmsF50HjFA94DRws1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nTZtp7WwbiUvGkqC/cOLjlqAptItMIX5YtyK/DSial8=;
 b=lr3Od8Xb1cbzpsA1jCkwX5fyRKZ6YhI1gv0x6sGPVRbBV4eWEUiipq+/ayqus4yF7YSZC1vzLBMqTn+n5HIY6n9dgkUTwNDRJ8LnqN0c57cn8LV+VJKQObgvD79zlBSJQpoRKra9DhmXaQmOAjnpRADJvMlCZCF5ecpR7oRIaC8X3XSOMf0sTRLtJBcuqMkKxvrzUehR1gcEAcGr7gLr6UjSJfyFUsBNF8sHwNbW3coxmEWF2akbdNNX4bYzfDeDAjk7MZsYQ+UY0s56Swm7rrYod6b22InBymqWeltBqt8bL6olDSjjqGMOFzQ/OCzy2wtlUKl5c/ktzCpGdmwEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTZtp7WwbiUvGkqC/cOLjlqAptItMIX5YtyK/DSial8=;
 b=OO5aiFvl9JkshhwSk1oUXgWrsI2MnUL07C4gY7NxYc5FiYYk2LjOr7snmmMG90KwGATfMAyM6EYr4uQCDill/+Ohxwd4WXxLTOEfb5keNRb7gKOQAZf0m1dKEUTeqF/3XwqXTIHuK/CCLtJOrtyjCyjovvD0K29X4fMy5DUIF68=
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by BYAPR02MB5784.namprd02.prod.outlook.com (2603:10b6:a03:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 08:40:05 +0000
Received: from BN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::c2) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 08:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT004.mail.protection.outlook.com (10.13.2.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:40:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Sep 2021 01:40:04 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Sep 2021 01:40:04 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=36668 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1mPhVU-000Cg1-4k; Mon, 13 Sep 2021 01:40:04 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v2 0/3] Add support for runtime features
Date:   Mon, 13 Sep 2021 01:39:52 -0700
Message-ID: <20210913083955.27146-1-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498261bd-964f-47cb-9871-08d9769215ea
X-MS-TrafficTypeDiagnostic: BYAPR02MB5784:
X-Microsoft-Antispam-PRVS: <BYAPR02MB578450AD4627759175EC36C8A4D99@BYAPR02MB5784.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kr/q+Xwsw5VCxuFSmBQltipQiespnor9ETSqUoUjz3x0i46gQoB3F4i6LL0wd4Jzm7OLNvzvvvo4smBJw59grKgA0BREmThdjtk/BDBCXp8kSvVQyQyK4tpr2hMObeUYgrqQEM9IgTawMvrnOmkUGS/8Bj7oBQRgUQKXurk9tbuntLx/xLWh67AfH7oJNe2sREHmJZqsWG1/WX5m//kK4ibOCMg6jd/33K83UvmeAUFazmsSqlCJxkvdD6q58vJJuu+byuIQY3fzujYLmCnk5O0gLBN2ieyztUL7ruxvTiwk8EGXEnsu7n63Z637ZBLcau1kp611hlIyOYdiJlTwgGArdSfTWWVsfW44M0nVRXu68zVsYiqnNQ4uyhPU6JTxAt8vEUwQAQgzR+dXCi3ZfPbUKyU5J4gMmQqOFEMg/8E7AsKUkRJ7Dpj60kiPz8+5BLp6sv/0OEfrvBwCPKCQtr+uSc+vyNkz4BwccTucY/H9sMNqR39g/rB0ui8BnF+aOQpYLRXquaZXhs/O0lw/UXBxYW7c29ztUKI8HsjRdeBLXz0DxSLhx6SDIZcuwbovOQylmqW8ao8xrefoTelq749gmtUlX/CsG5irqEyLXXJO6UbtW1djX7idclCgKge5hMXqmsg/53x5IR2nnYy4ZpFWD8zAyeSy4u45jq9sEx3I9H9WinQHG4DllRErBHA6BP4IU/4YjBpPRtoM5dCW/WD1abNCtA0YzVpQfrLgpHM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(36756003)(4744005)(36906005)(316002)(426003)(7636003)(36860700001)(5660300002)(7696005)(83380400001)(508600001)(6666004)(54906003)(110136005)(8936002)(8676002)(70206006)(44832011)(26005)(1076003)(47076005)(336012)(70586007)(186003)(4326008)(2906002)(9786002)(82310400003)(2616005)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:40:05.3155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498261bd-964f-47cb-9871-08d9769215ea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime feature configuration by using the IOCTL
 calls. The user can enable or disable as well as can configure the
 runtime features. The support is added for the over temperature and
 external watchdog. The user can configure the over temperature limit
 and external watchdog timer interval at runtime by using PM_IOCTL
 calls.
 
Also, added support for sysfs interface for runtime feature
configuration for the over temperature and external watchdog features.

Changes in v2:
- Remove default footer from email
- Update commit message
- Resolved merged conflict

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

