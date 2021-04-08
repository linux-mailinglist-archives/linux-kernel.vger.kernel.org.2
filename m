Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62629358BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhDHRyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:54:50 -0400
Received: from mail-bn8nam08on2066.outbound.protection.outlook.com ([40.107.100.66]:22593
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231676AbhDHRys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:54:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iryiYxn4OkoSnPggA1NGxEq5RmyVxna6FFYsPGPBhvRKz0rv3ScDL+bVAT/Cnf/2lMhJ8rkbPLf6k+SCI6ruGB+k7iF9kcGFHKFJs1eem9Ggn+z4L4pBQUUK07eiRzfGsPFbTrlrmGD3cejw/jnRYmvTYlN9lgwtccrqR772cVbj8ARU/vS5aiRHqTP2EGsUDqHe/Rcwu9j6sHErfBkPbG0kXsPMwEzkm2PmeJhbNHZDxc0GJTKbc4FaQGZy6+aIKheGV90W7td6zVRuywQjplBVTAqGdHnODi+TXrlaIwEFXZ7qclS59uuN1MytGC96+VAKsUd/U4Vj5nrChisE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPJp6GUubDeERgE19mcNEqhQxJdEc7ZqzdOQ3bvCYwo=;
 b=V3xDFsy41ppaKeIqMGunrBp/g73c2Unvv7A7gQm7TLS/sXQftsTWPFKismn46gw21NYIWVNbSAlkM/ZhIQeBbXjF4Nho//KFt5OjMdySmKPDl05yoMK1wf0OPOGKzH62Q8IWem0iv3Y1JdNCSPvo3coNxMeDNj/uWvnOABkBKttson4deTm9R19aqbTt4YQWhuoKGjGUB/g8Y+sszqeKbE4CbVKIqsh5+VfIL1lE7038OG4Aqg6JMZpLhBJAKCTMfSQGxIjh278autwwaXrq4sbeiGX0vM7g68pmJe3cRj92h3WgM9VhofXJ5la4siavpp3aZ7ovJ9+FQSbxQGCXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPJp6GUubDeERgE19mcNEqhQxJdEc7ZqzdOQ3bvCYwo=;
 b=VypG/MtEgmtqr0lsVjXEZ0ChwcRB3mhmKvu8juvedOUZDV02vhiKakhO+y7G+61Pa+RZVKwyT5rAFk7R51w+M2PeKy9aRX+8dOXBXz2r2Y69gP7PkhvHxAZH3ayGXOezBUQLoG5FW4QSi4dXu54Q2tHq75/0+6CW8MNKXOdJHL4=
Received: from BLAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:32b::12)
 by BN6PR02MB3284.namprd02.prod.outlook.com (2603:10b6:405:61::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 17:54:35 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32b:cafe::eb) by BLAPR03CA0007.outlook.office365.com
 (2603:10b6:208:32b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19 via Frontend
 Transport; Thu, 8 Apr 2021 17:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 17:54:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 10:54:21 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 8 Apr 2021 10:54:21 -0700
Envelope-to: git@xilinx.com,
 balbi@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=38708 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lUYrE-0002hA-IW; Thu, 08 Apr 2021 10:54:20 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id BD91112123D; Thu,  8 Apr 2021 23:24:19 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@xilinx.com>,
        <balbi@kernel.org>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 0/2] Fix for a bug and a kernel-doc warning in Xilinx DWC3
Date:   Thu, 8 Apr 2021 23:24:06 +0530
Message-ID: <1617904448-74611-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef437e48-2ebb-4c9a-a23b-08d8fab75f5a
X-MS-TrafficTypeDiagnostic: BN6PR02MB3284:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3284E0535FCC6DF4D9AD0704C1749@BN6PR02MB3284.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8v1VAVdFZ+RXsKdnUTZxtbfLA0CVKVHkI8RvI6wt6awoooMAXGZ8hHK4RHZnIfD0XAcDmC5kTFYOkYkHB9E2lVkCpiiOpyU96SAGeWCzhkMedVDR5tf7gNvBg3uStYteGpI9Xy5qGryLPhU+wy7pMSAedJIk25DHdGiqSQh/w7xwsBMQWwNH3a26FZsDwacH6xYn85BLN2OhN9hrxsYo/vbbPY21rl+ONidKjexWVtpwq8GgOs5YI+zxDsJB6FfeI2JgAjwRQNqmJLlJxKgUV3DFtYBlQceDkKM8l9NCKED2fPYva4VgmHm56nXfH6st09Hg4vcWsWGINroZcYkloTXIrbkBS123zBph5yY8HDn/5IuYFB8DsNWgz/DcjdFP4EDrs83nnuTApwretiUpyZ4EVErglAFbPMlETk6zjV7zsNpmv2m6/MbNIbKUAGHioiRlxDnIYm1laPM0hlmWpfrn2K9nLs73C134/ofDjtda92GtqXK7hYySYhLzzAo0JESLOgevCqmoZNjJGHImw4DQCYCa2rPL0b5Kxur8d0HBjZ3fcj0BkMKzMR+9Z1YHc2rsjorHMArCjzTmouN02A21nAWnQQx8raI0CFk/2HSnQi29CYQNQKpmZqwuq12jwHkENp/9um/DpeVjz2tTh/LirnkmXaOiZto4k7dCM+HekJ4AdOVBZgefbKVPzc/tyeDhqppmZSqtih3VtKuebI3i/EvE/mcOFEIUOOsxPthrJ5nTdPjlwWKEVqweYKxnYTrMlMiNKp/W9pfbip5fQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(6266002)(186003)(83380400001)(107886003)(36756003)(26005)(42186006)(110136005)(82740400003)(5660300002)(4326008)(2906002)(70206006)(316002)(54906003)(36906005)(7636003)(4744005)(70586007)(82310400003)(966005)(2616005)(6666004)(336012)(44832011)(8676002)(36860700001)(8936002)(426003)(47076005)(356005)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 17:54:35.7260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef437e48-2ebb-4c9a-a23b-08d8fab75f5a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3284
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series resolves a kernel-doc warning and a clk freeing bug
that was causing a crash.

This patch series is on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?id=84770f028fabab4cb66188d583ed12652f30576b

Manish Narani (2):
  usb: dwc3: Resolve kernel-doc warning for Xilinx DWC3 driver
  usb: dwc3: xilinx: Remove the extra freeing of clocks

 drivers/usb/dwc3/dwc3-xilinx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.1.1

