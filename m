Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B25D395009
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhE3H4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 03:56:05 -0400
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:24932
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE3H4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 03:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFOcw7VdYMAvT4X2cVVFY10qUBZC314+MMld9ckEX/NSt2W/TG3UfJ5S/I8UwMa1s+TTfdUJ4J2k4RepSeWJl5tSnfSLgqz2hvAnq8GUmuddL/7UhysRT34RvTNPcgK6BRRBRzRJL178n26bo+ALY4xXN8Q+s/dxO2jRzjw7UZT5xjxX6bvJ+EcsV/KxqIp55LOadtEvs7KbKHjijV5kQBgOzlRRO3XS+4PA69EhbrVV/gfSuBPtsA40GKDto1QVuC+jobapP1UoKfPLG5N2N9Y+xbHECp4a1/FG8cDb4jcV0Zs+UGXsDQvAUEruf+I3qUtcMo34PRYYoSeUFVdGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAdn7+HzF39l3daLQxYyG2QFsdqTNjxBcYZ9oNo1/E0=;
 b=TfAcpJGV7n36yqUlO3sHXcz5yMZBzY6jrPxBU/oSaAnjsDWy7hyaeW/hPZYOMyV/KfEBkf24+3G0/+B7ipLuIMJreY2KJL80q4/eQgyuzkcT6+OjnPtOhuFiVhSlQpO52Aq2DClh4bwpvdCzElRvcVHagDUnlRG0p+fR5aHvvNHXhwW8u7rB1e70juvBTRnMk3mmqRBltxis1A4M4LcZFWq+AYLMC9YpcR0/1BwmfW2RGRSC8HQy+pw5BW6bfUU/QBLRvrMamM2L4uqFlTsHJr1pf1rwYUD2LeO3kUi0RkvtizjvSjNV4c9l8JMVdLMhOkRFgZKYvbQIW3T9uajnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAdn7+HzF39l3daLQxYyG2QFsdqTNjxBcYZ9oNo1/E0=;
 b=tHrxvZTGlFxTyQrudFJ0yrDZmkOowuF+KG5G7rNWJ8MYdbDgv8kqMtuMwFW8G2HW+0jeWhlNV1D1XFKlAvgRXF92OiZAMcDuxkOHSWSNoQcM4H9CXRqSKJ4yKw8Xho++DNN+RnEMyQF7upIwbfcNVzu2ivmdlDFLg+cjXl6Qq2CxBmq+ovRgTvBDFtZWkiSUq+D+u1zWBoHcelW1gC1taPXxMuwMlU5hMV2kOSFvkZ420PRwvoJqeR+wOyz0SpNjlt/V9RCYJSUEvGDiR8rzXRKX3PYTgGyyNe8Ikz9+mxJ897aDE9kLrnJLIWXah0T+nqsbPh4XwjwKucyeCeBWcg==
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by CY4PR1201MB0085.namprd12.prod.outlook.com (2603:10b6:910:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Sun, 30 May
 2021 07:54:25 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::11) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 07:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:54:24 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 May
 2021 00:54:23 -0700
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 May 2021 00:54:22 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <elic@nvidia.com>
Subject: [PATCH 0/2] vdpa/mlx5: Add support for virtio_vdpa
Date:   Sun, 30 May 2021 10:54:13 +0300
Message-ID: <20210530075415.4644-1-elic@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4cf5529-07af-4a47-a07d-08d92340247f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0085:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00855E9BA268E21BD08B8582AB209@CY4PR1201MB0085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FSE6emR789XK/xRY78KXun1ckBejGyqhm2kvZn6c9AQblD335Wkii6c6mYGiMTUWsYwQeLT3bEuYReltovMAsnEsxD9FXA+5y8St2XkfbYsDAL24KI1ugnOII2yiSEiylJfxAjB/X4pZCqz5SUhVWn3/Z5cvhMylpdYdDPcslSzV9Sw2zTGVQnVenPDJlR7QJpeUb/vER1k+uJbXwPURiu9R4cYyc+/jS/11+R155w+FAGZwJCfU9mpX8+kIlraBE3VWSUAGM969un39P06hJSMQc1sE1kLhHCn5hEERTSQaMEXdo+6n09OQxuHLZY4gSaAkAsHj7jTobxAYKHrN4KKSqx37Tun4yXhMTSyX4xCEtm8EBQmJ7fTn2KyXdnV8Ue4JCe5uepKn3aJAL4TLjaOfN2HLC5WIFSVqMwxIBrj3/ljt0lF4Ga8epkOW2S8SwZL6r6Tw3HvzG5f0yxzTSqZwONWle1oUkIDNOAe2cCv27LMu+OSCX7GQI2JtIHoaI0SI4DNPZB6lkaaS1FrI2eCbZld5/VPKKff4X1FETafedDQlerA3CBxxri2vy1FHbIBO/uO5s0d1rVzpr3G+VdviW4TkvhOJpSU0Y4X42kYpayT5kr+5k3c0o2QfDTdODlz7oUNDNGmSJ35vU3H6iORZ4sNsd6d5W4AZk6OFBw=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(336012)(82310400003)(8676002)(6666004)(8936002)(47076005)(86362001)(5660300002)(186003)(26005)(83380400001)(316002)(478600001)(7696005)(110136005)(4744005)(70586007)(70206006)(107886003)(82740400003)(36860700001)(4326008)(2906002)(1076003)(7636003)(2616005)(426003)(36756003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:54:24.5122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cf5529-07af-4a47-a07d-08d92340247f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

The following two patches add support for mlx5_vdpa to be driven by
virtio_vdpa. This requires the ability to create virtqueue resources
with uid equals zero.

The first patch makes use of uid 0 if supported.
The second one handles the memory registration.

Eli Cohen (2):
  vdpa/mlx5: Support creating resources with uid == 0
  vdpa/mlx5: Add support for running with virtio_vdpa

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 81 ++++++++++++++++++++++++------
 drivers/vdpa/mlx5/core/resources.c |  6 +++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 13 ++++-
 include/linux/mlx5/mlx5_ifc.h      |  4 +-
 5 files changed, 89 insertions(+), 16 deletions(-)

-- 
2.31.1

