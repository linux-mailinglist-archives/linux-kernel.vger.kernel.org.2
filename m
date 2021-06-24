Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299C43B2EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhFXMUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:20:14 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:1344
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231247AbhFXMUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRWO04XoFsS2pd8UEPxJ4+J6TLhlXZs9phcETtx+cGgREy5HVIf15vNI/CHo/MfumLS2qQ4wTDKdP9cLJWTdRavR4Ek2LYnZzF94BCVgklrLEtPhwjxSBQfo9qda7AJADn3Rq9EtNWMufusGb90d4J8hCMZJ45h/cK5fdng8UPcaZxhfeBZQ99JFd+zahtQiiEHmnd/r2YiGVqMvQmMXZhy4vsO5u8cgpz6q0ErXGMpW9IdOc0rUoDlAcmkdPKffPG7lOq9B3724D+pwf/CVrtKseirYwvRFho23piwUA2deN8a1Y8gq3+BI4DiCEZC50pChE02j+35cHMX4JDffdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUxnbZnjlx5+Up8acUATpYz5cHAbBdRpSaf1Ew1Gj/4=;
 b=CquP6r01yVv8sAJBcfDiw3KMv196+eOHwHH8tDtwLlStwQ9qnZ4+NXL3EbF0PvBn+fLwQ9/3S3mIkKsUTVAb5/Uz209rcz4vgIAFrgqMY+JEh5tCd2yjcjujeK53H/KBCkitin8zJxgymHpr1I0PMd+Ca5Nkv6ria4zRgdGS8nixa1l34+Ub6wUoaStZhGZcC/c7H8ffLmHwcwz42NBkxzD2W/YqVlLFoQjnXnk7f+f1WMq5Bwf6miy3zSGj1lRQoYrYYLf1LzkjU7fSid5MEIXsAAccoWdfRXFX9h3McS7U/+g3+J7/1Obivts6A4NisF9uAJnp2ghX6GpLFVNGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUxnbZnjlx5+Up8acUATpYz5cHAbBdRpSaf1Ew1Gj/4=;
 b=LX50xH7nP0FswNdz2zS2fG9WPmEk/qMTq9wNnOSyflKm4ap5wDbiD9lOuUNmDGOx0MlRV+Nh5DhcE7jnJYTnNXatQuM7hoUOXno4bPS3ZtKcClCWQ1CpApgCbTiXVwjvfmsVl29VBOCIPldcvPSHnhyfgxEkdGCLf82qj0nwNa8=
Received: from DM5PR08CA0059.namprd08.prod.outlook.com (2603:10b6:4:60::48) by
 SN6PR02MB4752.namprd02.prod.outlook.com (2603:10b6:805:8f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Thu, 24 Jun 2021 12:17:46 +0000
Received: from DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::8a) by DM5PR08CA0059.outlook.office365.com
 (2603:10b6:4:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 12:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT010.mail.protection.outlook.com (10.13.5.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 12:17:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 05:17:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 24 Jun 2021 05:17:31 -0700
Envelope-to: mturquette@baylibre.com,
 sboyd@kernel.org,
 lee.jones@linaro.org,
 kristo@kernel.org,
 quanyang.wang@windriver.com,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.91] (port=51016 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1lwOIV-0003F7-Id; Thu, 24 Jun 2021 05:17:31 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v5 4/4] clk: zynqmp: Handle divider specific read only flag
Date:   Thu, 24 Jun 2021 05:16:33 -0700
Message-ID: <20210624121633.22179-5-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210624121633.22179-1-rajan.vaja@xilinx.com>
References: <20210624121633.22179-1-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 886c15f7-e621-4864-3dd9-08d9370a132a
X-MS-TrafficTypeDiagnostic: SN6PR02MB4752:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4752DAA461FA95AEA0483AB0B7079@SN6PR02MB4752.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBGJe18OrC11T+sHHVYBHR27xpdaRFI+BMXo3SAQEhran46/d+owZ7iaPf5VwNVVfaUIted0Otop06ngWL6ug5vKb1D5Yesz2rQxymaO4Ex9V28DDmLB69dwiu9SikYWlcsLorPhCKLvb5ZEUBpcrchT2Qh1BKOlo+I7xBUbVOhkpo4ymADwCVeP5NwbUV/BqW/MSCJTkb+rDM+3JNHEWWy4IyhVGMy85Knrkx0nzhoZqE+qu//BHdwiSFIAucLVSfxBv6fY+qE9juBNW3aYDbpE8MB1VlOO3KcPMR9+qq09wr1qFavwWmvjSQy5pMPJTQ89Y+GmfMQfX3Sg9edKT/To3FcBWOZSCiQDmeBz/0imMGzgibRP+lrXyI1NnkXUJoeQAtjwEs85nRgZvoe4Ctzl8GmcymVZNZyf8QaavUe/3x53I6mYcji/h+T/WORm70yk1sBeJRxOhccKHZVeb9pU4zScFcdDh2XnPGnGLAW4eSKdCZU3r3OqgOrETwvrUnS5AJnFC5NnTHUiqTnginY1MmOrJMbJ1Caem6QFdUzuYwiikn3GboM8pkjkEnSig0bYSxGaPPDhRByARpx421xnE1DzGYIfSsaZDIXP6qWboR1QPiKsXklyw1j0eYTblnv91Q+1KGpvMaLbdZuKVhKITq3WqLgwgf+9vxj/bBa8jpwVeAAe6vs3E/P9UJo4
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39840400004)(376002)(46966006)(36840700001)(82310400003)(83380400001)(2906002)(7636003)(356005)(2616005)(36860700001)(47076005)(426003)(70586007)(44832011)(70206006)(336012)(26005)(107886003)(1076003)(7696005)(110136005)(316002)(8936002)(8676002)(9786002)(36906005)(5660300002)(54906003)(4326008)(36756003)(186003)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:17:45.9482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 886c15f7-e621-4864-3dd9-08d9370a132a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for divider specific read only CCF flag
(CLK_DIVIDER_READ_ONLY).

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index c07423e03bc8..cb49281f9cf9 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -256,6 +256,11 @@ static const struct clk_ops zynqmp_clk_divider_ops = {
 	.set_rate = zynqmp_clk_divider_set_rate,
 };
 
+static const struct clk_ops zynqmp_clk_divider_ro_ops = {
+	.recalc_rate = zynqmp_clk_divider_recalc_rate,
+	.round_rate = zynqmp_clk_divider_round_rate,
+};
+
 /**
  * zynqmp_clk_get_max_divisor() - Get maximum supported divisor from firmware.
  * @clk_id:		Id of clock
@@ -334,7 +339,10 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.ops = &zynqmp_clk_divider_ops;
+	if (nodes->type_flag & CLK_DIVIDER_READ_ONLY)
+		init.ops = &zynqmp_clk_divider_ro_ops;
+	else
+		init.ops = &zynqmp_clk_divider_ops;
 
 	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
 
-- 
2.32.0.93.g670b81a

