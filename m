Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188933653E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhDTIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:20:57 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:50848
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhDTIUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl632t1dMbvhD6rIsvwBwzYf7bMtnfWUf5ExG7m/xxDVl7Dxe6t2dbdEXV0qJud8V8FMANAThrCuzMy83rEyc1vlJGLKWBk1PXwYBc4wUd0muKNDdxDK+wP5RFZrOPfK34azlUCF0AZvXoxlKKeow9YHhPYFIG4Ry+2RaBMUeC7L5T2h6027NU61pzYDGLQxLa04X1tCIt7eV0QnrXFFXqQxzqPVQpgl0OQVrNOl4dkgf0JlKpXSMlX/WNd75uw+9koWGQVHnMP70j4xyzetve/85iCVm5iKt05fmluoioPoDlHvBpd81cHmyRFUES+JJDm2VR+/n5Mb6yk13zqiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Jppvj2S3GbKTMPTaG94EVZ9G0H4CqvfTJ8A1c18xQ=;
 b=UGbaiVvU08+F0RJHNWOb4HxaF9Q1nEnFjt0oB+m41ZZdjcWqbJw6G9odfWInrXixHtVDgI3J/F6xnVRG2qNuHAOf2gsKtAxD02PhkECQr9VGdS6ISPAVDVYCiuf94kuqDPjNoG3V1JvZhtraGuCByZhTK2c/J4phreiM7y5AGvaHmz0LBZOlopfJISprMGOQ8ufUv06AG+PRa7UrSh2gZsory2CUIALYkxJmI9BS3o4oOiVyFTg5pPSZk6LswlcGbLvx7wzEAjUnjHzsebYMUUqY+OuJACQMkgm/T76RmSql96OJDAI3MaTBKSqfiUr1Ay5lgRgd8ix50U4GiuT41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Jppvj2S3GbKTMPTaG94EVZ9G0H4CqvfTJ8A1c18xQ=;
 b=QKF4SRIsZzqFgYczosiLY58QWzNbSvFxla4XbLrqRL+ccrabow8wBwE6jzDgnk1yN7IFyMH1JNa6IWyvYH+iSPTzYt/l+GZEuA2WB8JIGC3rRJPgtpH4aSkm8Q3Mb7Aye/w0BHEbJYGmVv0IHNYIAzoM/bZuNhZMYimKj3eMmUE=
Received: from CY4PR18CA0069.namprd18.prod.outlook.com (2603:10b6:903:13f::31)
 by BL0PR02MB4369.namprd02.prod.outlook.com (2603:10b6:208:4f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Tue, 20 Apr
 2021 08:20:21 +0000
Received: from CY1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::a7) by CY4PR18CA0069.outlook.office365.com
 (2603:10b6:903:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 08:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT026.mail.protection.outlook.com (10.152.75.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 08:20:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 01:20:20 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 20 Apr 2021 01:20:20 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=45276 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lYlcI-0007C5-ME; Tue, 20 Apr 2021 01:20:19 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <nava.manne@xilinx.com>, <rajan.vaja@xilinx.com>,
        <jolly.shah@xilinx.com>, <tejas.patel@xilinx.com>,
        <amit.sunil.dhamne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>,
        <git@xilinx.com>
Subject: [PATCH 0/5]misc: Add afi config drivers support.
Date:   Tue, 20 Apr 2021 13:41:48 +0530
Message-ID: <20210420081153.17020-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f123e882-76b8-4ca8-7ef7-08d903d523a6
X-MS-TrafficTypeDiagnostic: BL0PR02MB4369:
X-Microsoft-Antispam-PRVS: <BL0PR02MB43690A412F492B8EAA6BC435C2489@BL0PR02MB4369.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tb6014mi8ItvqGkF3SLKe0JOamZmaQ6pG6ZRwVeyJ4Na4ub7vPFXhMRyvExQtY1KIK2DYOkjRWAXDfXmaJewwOrBwJWGZcYynGBre9k0f3UpHEIn+ejswSi333230gVjMmbutA0/Fwi1+7ns66TvURjPDejEkiYbjAPBJs6ieahePAVevspH/P0eKV6KAR61Qz4DAp39YwW7EY+LTMAyb3937sV1Ee5PyIO6bav8U2bSF2dHdWrrpo9nbKY0TFgAJ2Ufba4cUAAwMapBj8bMAPeKlUL8GW5pmZ8fks1XLhBNMoVDbGD5bwUc3SNouSgs0dnMTffY4gxMVc8eeX2RIqmwnR5Wb/pKAqLzuVvXdpU+zq8utMDg8L2bu3NhjM8Ei9zQgXBYsXtfKGcp20xXgj824ndh1k8DNmhHeZzM/NZdBz/BWoeUJG9lNM8lfU5zCwlRuqJC3pCP+O/dDSOY38oTIqDaf+bitvm+iqHW/gBniKwh5prOWr9OpLVr8uY0vq2vrH7XWXC1t+dPugnzjuUE3B/T3hIILACBQ0TyRp9Th1OA/loGig2fK7gpbF0Z33sIU26NfvYlRiAQmeTVlWll29VzywtjfRUkZUxVwDpiDPQd+oaTr4JuAcL7OwmX8guqb7+L/s7pdX84sF27VLL5UXooXQJfUaeSJdXzPdXw0Fq5ECl8tu2Hivl/kdEzxxzuXeaHgJRz2fK9kli2kFj2RwwncyMRYyVTXrbNtiVXDH/vB5YNjoKzKGVf9xML
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(6636002)(478600001)(2616005)(82740400003)(336012)(110136005)(26005)(8676002)(83380400001)(356005)(36906005)(8936002)(9786002)(426003)(921005)(186003)(7696005)(70586007)(36860700001)(36756003)(1076003)(82310400003)(47076005)(70206006)(6666004)(2906002)(7636003)(316002)(5660300002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:20:21.0027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f123e882-76b8-4ca8-7ef7-08d903d523a6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4369
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx SoC platforms (Zynq and ZynqMP) connect the PS to the
programmable logic (PL) through the AXI port.This AXI port helps
to establish the data path between the PS and PL. In-order to
establish to proper communication data path between PS and PL
the AXI port data path should be configured with the proper
Bus-width values

This patch series Adds afi config drivers support to handle the
PS-PL AXI port bus-width configurations.

Nava kishore Manne (5):
  misc: doc: Add binding doc for the afi config driver
  misc: zynq: Add afi config driver
  firmware: xilinx: Add afi ioctl support
  misc: doc: Add binding doc for the zynqmp afi config driver
  misc: zynqmp: Add afi config driver

 .../bindings/misc/xlnx,zynq-afi-fpga.yaml     |  47 ++++++
 .../bindings/misc/xlnx,zynqmp-afi-fpga.yaml   | 136 ++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c              |  13 ++
 drivers/misc/Kconfig                          |  22 +++
 drivers/misc/Makefile                         |   2 +
 drivers/misc/zynq-afi.c                       |  81 +++++++++++
 drivers/misc/zynqmp-afi.c                     |  83 +++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   7 +
 8 files changed, 391 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,zynq-afi-fpga.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
 create mode 100644 drivers/misc/zynq-afi.c
 create mode 100644 drivers/misc/zynqmp-afi.c

-- 
2.18.0

