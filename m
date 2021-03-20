Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C498342BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCTLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhCTLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FCCC0604C0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3GqMuSjUBLohMKkTlJJ8Dy7HgjEx43jFmPqO7gdiLAvhjHaL1pxLuZ1mHmKrqWCLeOPXcdtqnIWdZJJGH9hsGhpZh/1cb7buzx0nfdW2CHIknsD0XTkSP1mqyxab2bICYZtesLULU2C3P6K8jOhoosEmdMCR0XKuEsq9OFw8wfaLsDuEh4ys/RdFqLHS8mjK+bMsM4yCmzgLzmowNm0jWeQnmUqu/4CePWSGc6RuOmXPWYaYJL7bQ+/zhR3scW4gz/v9QL6SjWCdXMPYh/RakaX28KfHTTSanfxjgJPyrioqMCAMeVWvt52nQEGJQWSP/L5Sui3UBUE7LKGUlyjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBylOg6xqQqFAhwR+UoTHhQKEJ9pnalFlAhm8GlHJLk=;
 b=N2QkPU3CUe/POJA4TwvMPEhjKPlqCwW8X0gq3oEtDSBjr+kgvIJKSb9RHwLC/EU7xejzY4AlujypGwqQD58T5y0nbM2sV4Tlf5jJa2BSzSoBIxI4gGOHi+/AVWP5Z+KxFp0rtsvKCgafCauYpgg3JbS+l3tmAAQf+A3TCnnIXDyX9wfNNd2Q11O14x4/2eTvpkpUl+i8yj27EyH8RcP9+gGqq04Usg4VauG2uvfJBqGbW7PGkjl5DZGklT1kpsxjo+NNeXg/1qPdF5gGiXVmESMJdGgKAyT5EZezP0C110Cki31hMbpJ0ZwlmxXlzrzyWLk15pevnvuyPyID+a7uhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBylOg6xqQqFAhwR+UoTHhQKEJ9pnalFlAhm8GlHJLk=;
 b=GVTK4P3ISYAC/vgXEGxETGttACWZCuk7dVJ34fUCd6JUgTcH/YhZRhCUqvodUtVqYl9K2+Y2NSuFdNEFzr2vqkeZFzIONBqfHoZHxNF1w5dNSgtbe4qniLHrLNptE9ZrKkc7nDPu5DthnmRj/VNaJlK5/omWeaGZmeTAAdtl9rk=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2149.namprd11.prod.outlook.com (2603:10b6:910:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 08:38:44 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3955.024; Sat, 20 Mar 2021
 08:38:44 +0000
From:   quanyang.wang@windriver.com
To:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] drm: xlnx: zynqmp: release reset to DP controller before accessing DP registers
Date:   Sat, 20 Mar 2021 16:37:39 +0800
Message-Id: <20210320083739.724246-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::32) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK0PR01CA0068.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sat, 20 Mar 2021 08:38:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 132dafa7-8110-4cae-7d07-08d8eb7b924b
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2149D4D6D5C0FFE78530CD19F0679@CY4PR1101MB2149.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJtPAj3kyeDWn3Ad7xAiTNu4RMBdKnenwdyly2Bpzudc1fUb0pl863778nQeDztALQ7PI8BGM+aFRc3MPZyimUnADHLAMp/dstFMLgU/bA8uO7Qis0kPQhz2NYKixgj50mhSHGrESJAywmNzYDfOD31Vm/JB1ADflOrBD+QeOOW3JE0QI6qsJxhv+pQ7vaAOWw6uhS82aGsPDy/BM3UGI6DhiCoCQOyFw5+MwMHGE4IimT33BKkyzElq8SRyEoOTLxhBL6Ra6pbTVR1SSI0KQknpD6vYLr5xTw7jIBNJi9gCCq6M+UWLoqRTWE6cip84Pw1cPxl/BDJAJpQZW4rdtTslVTvHqdXmxhRFvke7BLXPW4Lq8PlkreRt9oDzH1HYYa7HN2whODmvNUDHUl0hRmRvQaY3m2OSyNeVuH9wAAlUmTl5ddhWnpj1PJpt/Q/ywOngJ8z5eRTJLjPj3P75t6nYohjiQ5rkRmgLd2r7exKg1wo2wrtYsYyn81pDLyXWXfaWHBAh3pIcwzlzQ/W7/07vy1Iu0vFO5LwT2fAxzCEF+sqOOlB/EhxMWXIOhzWkhyG7WhXDxvuDHnN/0e4tfS1TljLp9zx5MfYKIjPCZ1eZygZFUqNjs6+QIJ46DAZufMFkoaPM1E9bz8pwLyyp9DL4GOFR4ynYY0R+Qg5haYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(376002)(136003)(346002)(38100700001)(8936002)(66946007)(66556008)(186003)(6636002)(66476007)(110136005)(36756003)(4326008)(316002)(16526019)(6506007)(26005)(956004)(83380400001)(2616005)(52116002)(6512007)(478600001)(2906002)(107886003)(6486002)(5660300002)(8676002)(86362001)(1076003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/HfsqKPWfdIgsHqRs5EDAVuhbooa0O1/GgdUZkZH3ycifwG3EUTjezUcRmas?=
 =?us-ascii?Q?7xpWty1c7JKXUiV0PLpQPA0zV6EpxidUdeAmMy92K6Y2FG+3xHtyy4llNItU?=
 =?us-ascii?Q?dGneMaFEL18tb1qTQaG1oVYo/fxsL+GZmREJhfZvId93rQsswCtFKNV5Rl3C?=
 =?us-ascii?Q?hArSHfQqFw+M45O999rm5/OjY1VxyTMoQyqCSGFznp/A9qGvu8ksyiuW773C?=
 =?us-ascii?Q?GX57oIQOfFMrE0mmAHiy4C8UAJj10EVpZMxfrZrm5d0prcP+xjJuAyp5vLkc?=
 =?us-ascii?Q?f/txJ+9wrE65CN1YZWHJhBEXQs+Zh1VNGF2eZq3xiq/oZQfe+8eySlgPOeqm?=
 =?us-ascii?Q?q0HcdNbxRwoR86926FVOTwdmLTulTVrZ20+d9oK7lPL5X1WHPIUDRT7st0U8?=
 =?us-ascii?Q?/3nvrzlhL/r7WBsIMnlOvVEDwK3mzLX6FkFxnNwiTD6vMVFccYbHZ4yK7yRA?=
 =?us-ascii?Q?39DSB58YLA6cCuAlLu5bnYrnTVR0UhXbyezVDUU+hKK81ftU53+J9V+SDr3j?=
 =?us-ascii?Q?1F9Kt7g78aqrF63jzsrzc/RAygZVuKFKM8NM8vxbi43s/euPHro+FdDSu5l9?=
 =?us-ascii?Q?iplwn62knpmn2MO/7WRinWhRhVHCM1JxdMeyj74RxAwZePnzeWXmzIxw7elS?=
 =?us-ascii?Q?P/80DWp2YH+EU8x/KLRBii/4T2f4eZtCX2fQfR2ZGMqxFQ/ZDG9LWAxeMijt?=
 =?us-ascii?Q?oaFcQTDRxmmQsQ7wHXpTfR9CmK61Aa0sRUmJjAYxpmFLeA8CLbCKuNLwVnjf?=
 =?us-ascii?Q?7xzM+gnuiYTqKHUZoQ2wpZcNV2ZMAGPVVzHz4x+UzmUyUNgVGUwyv20dqN45?=
 =?us-ascii?Q?YDSoY1gmwbzGtY5niExWjp/eTBjmtwsEQm5vXanv8fDf310cPi6tMzzppbrL?=
 =?us-ascii?Q?oKHOXVzfgrz9ABP6IgmR7Xp+fJYBcd/rJJmzILFXHRptTBabvgMWNDGXIO1P?=
 =?us-ascii?Q?3DEX4nNZaWir53oPgtKRy37nNLiHUc+19WWe9Cx7GxEtuI7OPYAznlNg9MMi?=
 =?us-ascii?Q?t5buM8oLRww/GRgcj3e07nUfq5IAQSWl5uidvV8SKnh+mSf//CMuLH8Z9bcT?=
 =?us-ascii?Q?2Hefo1i3sPyaf8U7dx8yfr7y5RSQleGSNhSBENF5f6CVbmrYhSVAOM44k/0N?=
 =?us-ascii?Q?OG/miqgdjAs8amimB+b4Xer/GT3VMDDiMzg+sNI3hKLSLnHp9gqSdTqPuMkK?=
 =?us-ascii?Q?d9mwyV5SWqAcIbVnx1n/DwnQvWQcuTwyix6gajQG8MSQ5MMZoAGkJeXKFRTW?=
 =?us-ascii?Q?60eJt0uMDeBoIT8HmMLuq0ib1qITHeGdSAkhwvaLimmXxbu4cwjioJFE0zxT?=
 =?us-ascii?Q?29DmhQaZE16VAWonf62yZdpc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132dafa7-8110-4cae-7d07-08d8eb7b924b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 08:38:44.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYtQelePuUW8OO8PlP7fbakHKE6EEeedXC17GiJNOuK8XEwWFX2wbAteoAnVtv38wwW7IB57Og260FiYwBFaSC/1+RKnmRcs5JL60qA2pto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

When insmod zynqmp-dpsub.ko after rmmod it, system will hang with the
error log as below:

root@xilinx-zynqmp:~# insmod zynqmp-dpsub.ko
[   88.391289] [drm] Initialized zynqmp-dpsub 1.0.0 20130509 for fd4a0000.display on minor 0
[   88.529906] Console: switching to colour frame buffer device 128x48
[   88.549402] zynqmp-dpsub fd4a0000.display: [drm] fb0: zynqmp-dpsubdrm frame buffer device
[   88.571624] zynqmp-dpsub fd4a0000.display: ZynqMP DisplayPort Subsystem driver probed
root@xilinx-zynqmp:~# rmmod zynqmp_dpsub
[   94.023404] Console: switching to colour dummy device 80x25
root@xilinx-zynqmp:~# insmod zynqmp-dpsub.ko
	<hang here>

This is because that in zynqmp_dp_probe it tries to access some DP
registers while the DP controller is still in the reset state. When
running "rmmod zynqmp_dpsub", zynqmp_dp_reset(dp, true) in
zynqmp_dp_phy_exit is called to force the DP controller into the reset
state. Then insmod will call zynqmp_dp_probe to write to the DP registers,
but at this moment the DP controller isn't brought out of the reset state
since the function zynqmp_dp_reset(dp, false) is called later and this
will result the system hang.

Releasing the reset to DP controller before any read/write operation to it
will fix this issue.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 99158ee67d02..bb45b3663d6b 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -402,10 +402,6 @@ static int zynqmp_dp_phy_init(struct zynqmp_dp *dp)
 		}
 	}
 
-	ret = zynqmp_dp_reset(dp, false);
-	if (ret < 0)
-		return ret;
-
 	zynqmp_dp_clr(dp, ZYNQMP_DP_PHY_RESET, ZYNQMP_DP_PHY_RESET_ALL_RESET);
 
 	/*
@@ -1682,6 +1678,10 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub, struct drm_device *drm)
 		return PTR_ERR(dp->reset);
 	}
 
+	ret = zynqmp_dp_reset(dp, false);
+	if (ret < 0)
+		return ret;
+
 	ret = zynqmp_dp_phy_probe(dp);
 	if (ret)
 		return ret;
-- 
2.25.1

