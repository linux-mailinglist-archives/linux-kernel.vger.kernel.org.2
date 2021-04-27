Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7836C51B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhD0Lcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:32:39 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:6183
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhD0Lci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:32:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwtYwdiXNClbzn0B2Im1dKatnfuQT6x/iJY1Suj0JN/np6WmRHiFtI/CMC+yRIzKlYX+AwEmIq2o+qOVLXUH9vwZ4Ln1raqMx6zYBd7g9U45LP9r3cqWWM2miO3wMWW1TwsmWl/ZDqn+dOPA2K6iPN70tyIxRAx2ZcbuyqKw7AG2WdixxYZh/OKKx0jVY3QiVx/D3uMArLtZUrPQvjuXGX9mQzld/+SpiAIWJvybzJLW1U18sj2kI0zxobKUG4jpeBTPCNCGfFd9qgUxKpQY4qIeKFCFzqwWAT/H4nxihf35ZXu0If239LTY98smhhMNr+fPOWkbREfidA++VyxTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrQC78/CI1ZBgR72EXNNPwMtmo8f+9EiIoM+yE4yt6M=;
 b=KK4Dtoy7hgxwWRwPvQqCYCKB2+PjyUGXKPBG7kH+QOl3hK82fM3RYlNsh49+Wejx2GiRV7sEWGFzwHFw8zNoAsscsMP0ceou3PhmA2tRCCw3qjmPCAsHvChMBQ2aCdz/8VZCve9vLU8edLNUxMWVnRhilFpXgOit673+ZxC2IJmS6Vvq3A8qIQ0N2KjJLjX8VHaylO/mbEzfBU0SGFTY9WjD1iboXqTWWIqykQVdL/8DERj+9Ashz8t4gKIE2UhyDAx5zVU7AHy8qyAhS9HstXHEYo8rPJwq/zZ4Tkljg2yyWzxo/AwfJB/rXaOhjjMxi/Zw5zG4vCFc0daWq3Ov8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrQC78/CI1ZBgR72EXNNPwMtmo8f+9EiIoM+yE4yt6M=;
 b=AdLp5nFwFJYwU3OMjJuiK+xnwck+8yd4ZFsq1NSCxdm7/giaI3Q7+z29Gzu4FQBCLwJxbk1wxPYT4KPJZfnZVrhcxhvdlA2xdrJiyyuYL2PZNntxiKiElXVFcCHiT+aHCk6WopFQfKANGqWyVsYDqGj5MPVO+Gl2QldwMsKFdoA=
Received: from CY4PR13CA0004.namprd13.prod.outlook.com (2603:10b6:903:32::14)
 by BN7PR02MB4115.namprd02.prod.outlook.com (2603:10b6:406:f1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 27 Apr
 2021 11:31:53 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::41) by CY4PR13CA0004.outlook.office365.com
 (2603:10b6:903:32::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend
 Transport; Tue, 27 Apr 2021 11:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 11:31:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 04:31:50 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 04:31:50 -0700
Envelope-to: git@xilinx.com,
 maz@kernel.org,
 tglx@linutronix.de,
 valentin.schneider@arm.com,
 dianders@chromium.org,
 hdegoede@redhat.com,
 mkshah@codeaurora.org,
 thunder.leizhen@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 frowand.list@gmail.com,
 devicetree@vger.kernel.org
Received: from [10.140.6.2] (port=33778 helo=xhdanirudh40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anirudha.sarangi@xilinx.com>)
        id 1lbLwS-000328-Th; Tue, 27 Apr 2021 04:31:49 -0700
From:   Anirudha Sarangi <anirudha.sarangi@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <git@xilinx.com>,
        Anirudha Sarangi <anirudha.sarangi@xilinx.com>
Subject: [PATCH 0/3] Updates in irqchip framework to remove irqchip
Date:   Tue, 27 Apr 2021 17:01:33 +0530
Message-ID: <20210427113136.12469-1-anirudha.sarangi@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d1c5827-da3d-40ed-9355-08d909700e65
X-MS-TrafficTypeDiagnostic: BN7PR02MB4115:
X-Microsoft-Antispam-PRVS: <BN7PR02MB41159B2B4F152A99977A6719DA419@BN7PR02MB4115.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLOLDHKuAFyS0CIzwi6ePrNUuPHCHs6L8Hm36SiTgCPL9ZRDOgPhcM/oxkIj2NAEZmty+8GR97jsVQGBpemWJnSYN7+rX7j1WGiLHhtjL2v5c7lj0qG/FD8YM408d0t5AuZtlcGU0sFC9KUwmspFEKGfZhCS4i1uoXj/6awYmr3jIfIfntuI2dcKe5qQQGRA7gVEV5DBtfWBlfvYxvZ56JVccznLQ+eU9tdoejQVOz72ym8tsw7MgwEhtnDGr7Oup/REI0urhBMpHhsCKpmTw940wktiR1WQnUloCMso/fee5f4dZDrTRwXHETHSzbL9zhFhEAD8uo3nkhHvGDnaiU7zbMJQCilP4iX/WMDGc9Mbc1KX/NWQLmC8hKbOZwzWfMbg8GntrpIKYAs73ouQcNYovwzidzQTtsKEMFSJcCd7n5AqeyETYaauTPRmxMh//iaf81bv1kP2nKOUtdkdODyU7WB2C4YArszKzv0bVxmBmJ44B99XiYjkDjI9fQGF/GlJ6sRBMFKGDDQiR1r6hbmlRu09ckORisCDAuUlM2brBddJ7plXNDMNsAdum25oVxBZR0PAOgwt2uSVZLnwJkF6qXInU3FHov/NWSRzHOPsxIdZGV+SS6IB4jLxsGldQz7E11KPqyK+dFAgbvhznDcyZojmdQvzu+yekk66VWsTg3RvpXOmjh9Byea5TgwX
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39840400004)(46966006)(36840700001)(107886003)(7416002)(36860700001)(26005)(5660300002)(186003)(7696005)(1076003)(316002)(54906003)(8676002)(82310400003)(44832011)(70586007)(70206006)(2616005)(36906005)(83380400001)(6666004)(8936002)(9786002)(36756003)(4744005)(4326008)(426003)(47076005)(356005)(6916009)(478600001)(2906002)(336012)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 11:31:53.1531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1c5827-da3d-40ed-9355-08d909700e65
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Available irqchip framework does not fully support use cases where an
irqchip driver has to be loaded and unloaded as a module. 
Existing Xilinx INTC driver does not have a remove path which means the
INTC IP cannot be removed from a removable partition.

Anirudha Sarangi (3):
  irqchip: xilinx: Avoid __init macro usage for xilinx_intc_of_init
  irqchip: Add support to remove irqchip driver modules.
  irqchip: xilinx: Add support to remove the Xilinx INTC driver module.

 drivers/irqchip/irq-xilinx-intc.c | 53 ++++++++++++++++++++++++++++---
 drivers/irqchip/irqchip.c         | 38 ++++++++++++++++++++--
 include/linux/irq.h               | 15 ++++++++-
 include/linux/of_irq.h            |  1 +
 kernel/irq/handle.c               |  2 +-
 5 files changed, 100 insertions(+), 9 deletions(-)

-- 
2.17.1

