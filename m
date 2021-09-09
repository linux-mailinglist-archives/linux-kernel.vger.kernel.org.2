Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E91404283
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348999AbhIIBBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:01:45 -0400
Received: from mail-sn1anam02on2058.outbound.protection.outlook.com ([40.107.96.58]:6146
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233710AbhIIBBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:01:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fab19IQRfcFfU1cBosyiOlpqqvGL3o5MEZ+fxzJahXRDh9rGeCeaFGNZJiP4v2ucXfRfJYuv4TnZ70noxf/FOgZP/qaPNY3ootZyGaet1CfZqMCG2ZrDMPGoZK88GdoOzsDrj4Tlnza3ydaTzyCwTNXtH2FLvVFCknNYwRkB28RG6FM9UmQlAoX7S0X4akxU1tB4EXMQ5pjUZDdBbpRPfukatZx5EKqx/VGQohi3FxQHOEHh1KasRaWzJQhSXmJ1EYlARDXGLT9Tgxk6Wkfb+JSFNyC4vzBpd9A5bwwFsaF7+F+z4WPFVRuJ7s7spVEd/Oj5RUw5bEfS9APLc6avQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WZPzpg35zTcm6TavCEBpJfRdKGaAadVLbW5K730IK7s=;
 b=FOqO7cB8a5YwF6XkY12xWvy9YQwN6/rS7w9Ae6CsOSFYwb76sEI++CbUhXpS1fJ7LtLQ4j8Svb7U96Gb38tF2o6nWUmPvbTQPwNl0ELuCUhj+XrnWCZbzQL+E09Bzib4KbHCCmGbBGjA53Z12D5P7LswPSMzN+N251FaoH13+MoXU94MbY9OYdQgXn4L7pVt5sMUEHGBXtvi+Ur/cYyrIIiXl6XKHR3wN/JfF+ZHOSOiTMLqG/tHqRD1ENd5vrnoG4qNroOEhXoF+SktzbhAzQBo81OS8UEL0r6X+6uNXX9XXGVKc0Ben5i52xMrrY05AgCqcaKIb0nPiXFenka10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZPzpg35zTcm6TavCEBpJfRdKGaAadVLbW5K730IK7s=;
 b=Nu3DUE0WVgYKFtcLWkXDvhJPTMJUUrnWdkRsQg1pxthyZfT9ommTRE1ebQXHCo8B1XOmB9QxImdkFVtawJHhQz/qTdFeGRxX+1X4Fzhjzui1ZFXxfFEBC2jAkmFlACJXzq9E16NgA9Ko4+EwAB1ti2yKz/JUKYbRUfEpn4wyYMw=
Received: from CO2PR04CA0122.namprd04.prod.outlook.com (2603:10b6:104:7::24)
 by MWHPR1201MB2495.namprd12.prod.outlook.com (2603:10b6:300:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 9 Sep
 2021 01:00:29 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::89) by CO2PR04CA0122.outlook.office365.com
 (2603:10b6:104:7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 01:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 01:00:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 20:00:28 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Wed, 8 Sep 2021 20:00:27 -0500
From:   Harry Wentland <harry.wentland@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <ndesaulniers@google.com>, <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <arnd@kernel.org>,
        <sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>,
        <nathan@kernel.org>, <linux@roeck-us.net>, <llvm@lists.linux.dev>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 2/4] drm/amd/display: Pass all structs in display_rq_dlg_helpers by pointer
Date:   Wed, 8 Sep 2021 21:00:21 -0400
Message-ID: <20210909010023.29110-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909010023.29110-1-harry.wentland@amd.com>
References: <20210909010023.29110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b430c6c7-ed48-4c13-0cf4-08d9732d37ef
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2495:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB24951867C00EBB892753C54A8CD59@MWHPR1201MB2495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sgR2QRQiqsuF5qNm8IINyF8ZBw4gsX0mhav5L6FvGoiv9ix/tFU3pih/4lGP7yriGxMy+OMPnc3toaquz9ErdRx1w7qZSB8kOFDcjoqGVbnQFIRYiVPM/0jFRKHOTPeZK7ij20MRqnNN0z71J0JAI6qgjJDQvPQUEis8F4gqtRxToujOzn7nSqAUHF6kGelpi1HH9Z9mSKTBsYU4FfiRyGthe/9cBXMic81yylId8KczGEcHhlIPgxsy9xhkoU7Rex9SXthXXoiz92Rtf7ls2mdr6s+jT2k2JEa+ZdrDsDeVw3I6x64yJsPOXltA5AvkSCFmuu2sj4o57NLAGakcCCs42kIIHwg256Bcv5w+vSE9Q90rowXA10VXT74OhxZJNJzVU+/IxZ1h+BqVK3IZZIZSufMksBGAkvmV7JsT68/e2hpQS/wwzaYh6uV9fiIIAcEagGTfj1j9m8itL17U2F9ptuy5PWptfu6IsqNqsB46HHu6TL/dVb1J/5tBsXOGpz4ru+7Q7A/3hVnXom5/p3psL+2N5DP5tDqsKamqmGUVCSzc7Ahl7whP1zN40BdCYJLvmWmkhzhhcvkdbIbUoaktMLiw7KI+jLuNW3ZZO6K4YvehIdhtzoPWFpqlUN2BrFXXCbFwWG2l1F4ICm03uM7G1Vdm5qVt6ykvH4YCkGzCFgiqPoFS/iRB0ZsRMoyYuwFaviW0cmxgE1ZlqBSWa2Y2jgezSTL9PpPgUCYokI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4326008)(54906003)(81166007)(356005)(70206006)(47076005)(70586007)(36756003)(6916009)(82310400003)(66574015)(6666004)(2906002)(44832011)(1076003)(30864003)(8936002)(316002)(508600001)(7696005)(8676002)(5660300002)(186003)(36860700001)(26005)(83380400001)(336012)(426003)(2616005)(86362001)(36900700001)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 01:00:29.7082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b430c6c7-ed48-4c13-0cf4-08d9732d37ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2495
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing structs adds a lot of overhead. We don't ever want to pass
anything bigger than primitives by value.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: llvm@lists.linux.dev
---
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  32 +--
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  32 +--
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  32 +--
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  32 +--
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  32 +--
 .../display/dc/dml/display_rq_dlg_helpers.c   | 256 +++++++++---------
 .../display/dc/dml/display_rq_dlg_helpers.h   |  20 +-
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |  28 +-
 8 files changed, 232 insertions(+), 232 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 8c168f348a27..6a4f479c5aab 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -164,26 +164,26 @@ static unsigned int get_blk_size_bytes(const enum source_macro_tile_size tile_si
 
 static void extract_rq_sizing_regs(struct display_mode_lib *mode_lib,
 		display_data_rq_regs_st *rq_regs,
-		const display_data_rq_sizing_params_st rq_sizing)
+		const display_data_rq_sizing_params_st *rq_sizing)
 {
 	dml_print("DML_DLG: %s: rq_sizing param\n", __func__);
 	print__data_rq_sizing_params_st(mode_lib, rq_sizing);
 
-	rq_regs->chunk_size = dml_log2(rq_sizing.chunk_bytes) - 10;
+	rq_regs->chunk_size = dml_log2(rq_sizing->chunk_bytes) - 10;
 
-	if (rq_sizing.min_chunk_bytes == 0)
+	if (rq_sizing->min_chunk_bytes == 0)
 		rq_regs->min_chunk_size = 0;
 	else
-		rq_regs->min_chunk_size = dml_log2(rq_sizing.min_chunk_bytes) - 8 + 1;
+		rq_regs->min_chunk_size = dml_log2(rq_sizing->min_chunk_bytes) - 8 + 1;
 
-	rq_regs->meta_chunk_size = dml_log2(rq_sizing.meta_chunk_bytes) - 10;
-	if (rq_sizing.min_meta_chunk_bytes == 0)
+	rq_regs->meta_chunk_size = dml_log2(rq_sizing->meta_chunk_bytes) - 10;
+	if (rq_sizing->min_meta_chunk_bytes == 0)
 		rq_regs->min_meta_chunk_size = 0;
 	else
-		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing.min_meta_chunk_bytes) - 6 + 1;
+		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing->min_meta_chunk_bytes) - 6 + 1;
 
-	rq_regs->dpte_group_size = dml_log2(rq_sizing.dpte_group_bytes) - 6;
-	rq_regs->mpte_group_size = dml_log2(rq_sizing.mpte_group_bytes) - 6;
+	rq_regs->dpte_group_size = dml_log2(rq_sizing->dpte_group_bytes) - 6;
+	rq_regs->mpte_group_size = dml_log2(rq_sizing->mpte_group_bytes) - 6;
 }
 
 static void extract_rq_regs(struct display_mode_lib *mode_lib,
@@ -193,13 +193,13 @@ static void extract_rq_regs(struct display_mode_lib *mode_lib,
 	unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
 	unsigned int detile_buf_plane1_addr = 0;
 
-	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.rq_l);
+	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), &rq_param.sizing.rq_l);
 
 	rq_regs->rq_regs_l.pte_row_height_linear = dml_floor(dml_log2(rq_param.dlg.rq_l.dpte_row_height),
 			1) - 3;
 
 	if (rq_param.yuv420) {
-		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.rq_c);
+		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), &rq_param.sizing.rq_c);
 		rq_regs->rq_regs_c.pte_row_height_linear = dml_floor(dml_log2(rq_param.dlg.rq_c.dpte_row_height),
 				1) - 3;
 	}
@@ -763,7 +763,7 @@ static void dml20_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 
 	// calculate how to split the det buffer space between luma and chroma
 	handle_det_buf_split(mode_lib, rq_param, pipe_src_param);
-	print__rq_params_st(mode_lib, *rq_param);
+	print__rq_params_st(mode_lib, rq_param);
 }
 
 void dml20_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
@@ -776,7 +776,7 @@ void dml20_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 	dml20_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param->src);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
-	print__rq_regs_st(mode_lib, *rq_regs);
+	print__rq_regs_st(mode_lib, rq_regs);
 }
 
 // Note: currently taken in as is.
@@ -1542,8 +1542,8 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	disp_ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
 	ASSERT(disp_ttu_regs->min_ttu_vblank < dml_pow(2, 24));
 
-	print__ttu_regs_st(mode_lib, *disp_ttu_regs);
-	print__dlg_regs_st(mode_lib, *disp_dlg_regs);
+	print__ttu_regs_st(mode_lib, disp_ttu_regs);
+	print__dlg_regs_st(mode_lib, disp_dlg_regs);
 }
 
 void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
@@ -1579,7 +1579,7 @@ void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
 			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
 
-	print__dlg_sys_params_st(mode_lib, dlg_sys_param);
+	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
 	// system parameter calculation done
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 26ececfd40cd..b5f33f05c8e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -164,26 +164,26 @@ static unsigned int get_blk_size_bytes(const enum source_macro_tile_size tile_si
 
 static void extract_rq_sizing_regs(struct display_mode_lib *mode_lib,
 		display_data_rq_regs_st *rq_regs,
-		const display_data_rq_sizing_params_st rq_sizing)
+		const display_data_rq_sizing_params_st *rq_sizing)
 {
 	dml_print("DML_DLG: %s: rq_sizing param\n", __func__);
 	print__data_rq_sizing_params_st(mode_lib, rq_sizing);
 
-	rq_regs->chunk_size = dml_log2(rq_sizing.chunk_bytes) - 10;
+	rq_regs->chunk_size = dml_log2(rq_sizing->chunk_bytes) - 10;
 
-	if (rq_sizing.min_chunk_bytes == 0)
+	if (rq_sizing->min_chunk_bytes == 0)
 		rq_regs->min_chunk_size = 0;
 	else
-		rq_regs->min_chunk_size = dml_log2(rq_sizing.min_chunk_bytes) - 8 + 1;
+		rq_regs->min_chunk_size = dml_log2(rq_sizing->min_chunk_bytes) - 8 + 1;
 
-	rq_regs->meta_chunk_size = dml_log2(rq_sizing.meta_chunk_bytes) - 10;
-	if (rq_sizing.min_meta_chunk_bytes == 0)
+	rq_regs->meta_chunk_size = dml_log2(rq_sizing->meta_chunk_bytes) - 10;
+	if (rq_sizing->min_meta_chunk_bytes == 0)
 		rq_regs->min_meta_chunk_size = 0;
 	else
-		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing.min_meta_chunk_bytes) - 6 + 1;
+		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing->min_meta_chunk_bytes) - 6 + 1;
 
-	rq_regs->dpte_group_size = dml_log2(rq_sizing.dpte_group_bytes) - 6;
-	rq_regs->mpte_group_size = dml_log2(rq_sizing.mpte_group_bytes) - 6;
+	rq_regs->dpte_group_size = dml_log2(rq_sizing->dpte_group_bytes) - 6;
+	rq_regs->mpte_group_size = dml_log2(rq_sizing->mpte_group_bytes) - 6;
 }
 
 static void extract_rq_regs(struct display_mode_lib *mode_lib,
@@ -193,13 +193,13 @@ static void extract_rq_regs(struct display_mode_lib *mode_lib,
 	unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
 	unsigned int detile_buf_plane1_addr = 0;
 
-	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.rq_l);
+	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), &rq_param.sizing.rq_l);
 
 	rq_regs->rq_regs_l.pte_row_height_linear = dml_floor(dml_log2(rq_param.dlg.rq_l.dpte_row_height),
 			1) - 3;
 
 	if (rq_param.yuv420) {
-		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.rq_c);
+		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), &rq_param.sizing.rq_c);
 		rq_regs->rq_regs_c.pte_row_height_linear = dml_floor(dml_log2(rq_param.dlg.rq_c.dpte_row_height),
 				1) - 3;
 	}
@@ -763,7 +763,7 @@ static void dml20v2_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 
 	// calculate how to split the det buffer space between luma and chroma
 	handle_det_buf_split(mode_lib, rq_param, pipe_src_param);
-	print__rq_params_st(mode_lib, *rq_param);
+	print__rq_params_st(mode_lib, rq_param);
 }
 
 void dml20v2_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
@@ -776,7 +776,7 @@ void dml20v2_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 	dml20v2_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param->src);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
-	print__rq_regs_st(mode_lib, *rq_regs);
+	print__rq_regs_st(mode_lib, rq_regs);
 }
 
 // Note: currently taken in as is.
@@ -1543,8 +1543,8 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	disp_ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
 	ASSERT(disp_ttu_regs->min_ttu_vblank < dml_pow(2, 24));
 
-	print__ttu_regs_st(mode_lib, *disp_ttu_regs);
-	print__dlg_regs_st(mode_lib, *disp_dlg_regs);
+	print__ttu_regs_st(mode_lib, disp_ttu_regs);
+	print__dlg_regs_st(mode_lib, disp_dlg_regs);
 }
 
 void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
@@ -1580,7 +1580,7 @@ void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
 			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
 
-	print__dlg_sys_params_st(mode_lib, dlg_sys_param);
+	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
 	// system parameter calculation done
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 736978c4d40a..661fbb622824 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -141,26 +141,26 @@ static unsigned int get_blk_size_bytes(const enum source_macro_tile_size tile_si
 static void extract_rq_sizing_regs(
 		struct display_mode_lib *mode_lib,
 		display_data_rq_regs_st *rq_regs,
-		const display_data_rq_sizing_params_st rq_sizing)
+		const display_data_rq_sizing_params_st *rq_sizing)
 {
 	dml_print("DML_DLG: %s: rq_sizing param\n", __func__);
 	print__data_rq_sizing_params_st(mode_lib, rq_sizing);
 
-	rq_regs->chunk_size = dml_log2(rq_sizing.chunk_bytes) - 10;
+	rq_regs->chunk_size = dml_log2(rq_sizing->chunk_bytes) - 10;
 
-	if (rq_sizing.min_chunk_bytes == 0)
+	if (rq_sizing->min_chunk_bytes == 0)
 		rq_regs->min_chunk_size = 0;
 	else
-		rq_regs->min_chunk_size = dml_log2(rq_sizing.min_chunk_bytes) - 8 + 1;
+		rq_regs->min_chunk_size = dml_log2(rq_sizing->min_chunk_bytes) - 8 + 1;
 
-	rq_regs->meta_chunk_size = dml_log2(rq_sizing.meta_chunk_bytes) - 10;
-	if (rq_sizing.min_meta_chunk_bytes == 0)
+	rq_regs->meta_chunk_size = dml_log2(rq_sizing->meta_chunk_bytes) - 10;
+	if (rq_sizing->min_meta_chunk_bytes == 0)
 		rq_regs->min_meta_chunk_size = 0;
 	else
-		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing.min_meta_chunk_bytes) - 6 + 1;
+		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing->min_meta_chunk_bytes) - 6 + 1;
 
-	rq_regs->dpte_group_size = dml_log2(rq_sizing.dpte_group_bytes) - 6;
-	rq_regs->mpte_group_size = dml_log2(rq_sizing.mpte_group_bytes) - 6;
+	rq_regs->dpte_group_size = dml_log2(rq_sizing->dpte_group_bytes) - 6;
+	rq_regs->mpte_group_size = dml_log2(rq_sizing->mpte_group_bytes) - 6;
 }
 
 static void extract_rq_regs(
@@ -171,14 +171,14 @@ static void extract_rq_regs(
 	unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
 	unsigned int detile_buf_plane1_addr = 0;
 
-	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.rq_l);
+	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), &rq_param.sizing.rq_l);
 
 	rq_regs->rq_regs_l.pte_row_height_linear = dml_floor(
 			dml_log2(rq_param.dlg.rq_l.dpte_row_height),
 			1) - 3;
 
 	if (rq_param.yuv420) {
-		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.rq_c);
+		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), &rq_param.sizing.rq_c);
 		rq_regs->rq_regs_c.pte_row_height_linear = dml_floor(
 				dml_log2(rq_param.dlg.rq_c.dpte_row_height),
 				1) - 3;
@@ -807,7 +807,7 @@ static void dml_rq_dlg_get_rq_params(
 
 	// calculate how to split the det buffer space between luma and chroma
 	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
-	print__rq_params_st(mode_lib, *rq_param);
+	print__rq_params_st(mode_lib, rq_param);
 }
 
 void dml21_rq_dlg_get_rq_reg(
@@ -821,7 +821,7 @@ void dml21_rq_dlg_get_rq_reg(
 	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
-	print__rq_regs_st(mode_lib, *rq_regs);
+	print__rq_regs_st(mode_lib, rq_regs);
 }
 
 // Note: currently taken in as is.
@@ -1650,8 +1650,8 @@ static void dml_rq_dlg_get_dlg_params(
 	disp_ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
 	ASSERT(disp_ttu_regs->min_ttu_vblank < dml_pow(2, 24));
 
-	print__ttu_regs_st(mode_lib, *disp_ttu_regs);
-	print__dlg_regs_st(mode_lib, *disp_dlg_regs);
+	print__ttu_regs_st(mode_lib, disp_ttu_regs);
+	print__dlg_regs_st(mode_lib, disp_dlg_regs);
 }
 
 void dml21_rq_dlg_get_dlg_reg(
@@ -1691,7 +1691,7 @@ void dml21_rq_dlg_get_dlg_reg(
 	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
 			/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
 
-	print__dlg_sys_params_st(mode_lib, dlg_sys_param);
+	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
 	// system parameter calculation done
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 2120e0941a09..1535b01a8c5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -89,26 +89,26 @@ static unsigned int get_blk_size_bytes(const enum source_macro_tile_size tile_si
 
 static void extract_rq_sizing_regs(struct display_mode_lib *mode_lib,
 	display_data_rq_regs_st *rq_regs,
-	const display_data_rq_sizing_params_st rq_sizing)
+	const display_data_rq_sizing_params_st *rq_sizing)
 {
 	dml_print("DML_DLG: %s: rq_sizing param\n", __func__);
 	print__data_rq_sizing_params_st(mode_lib, rq_sizing);
 
-	rq_regs->chunk_size = dml_log2(rq_sizing.chunk_bytes) - 10;
+	rq_regs->chunk_size = dml_log2(rq_sizing->chunk_bytes) - 10;
 
-	if (rq_sizing.min_chunk_bytes == 0)
+	if (rq_sizing->min_chunk_bytes == 0)
 		rq_regs->min_chunk_size = 0;
 	else
-		rq_regs->min_chunk_size = dml_log2(rq_sizing.min_chunk_bytes) - 8 + 1;
+		rq_regs->min_chunk_size = dml_log2(rq_sizing->min_chunk_bytes) - 8 + 1;
 
-	rq_regs->meta_chunk_size = dml_log2(rq_sizing.meta_chunk_bytes) - 10;
-	if (rq_sizing.min_meta_chunk_bytes == 0)
+	rq_regs->meta_chunk_size = dml_log2(rq_sizing->meta_chunk_bytes) - 10;
+	if (rq_sizing->min_meta_chunk_bytes == 0)
 		rq_regs->min_meta_chunk_size = 0;
 	else
-		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing.min_meta_chunk_bytes) - 6 + 1;
+		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing->min_meta_chunk_bytes) - 6 + 1;
 
-	rq_regs->dpte_group_size = dml_log2(rq_sizing.dpte_group_bytes) - 6;
-	rq_regs->mpte_group_size = dml_log2(rq_sizing.mpte_group_bytes) - 6;
+	rq_regs->dpte_group_size = dml_log2(rq_sizing->dpte_group_bytes) - 6;
+	rq_regs->mpte_group_size = dml_log2(rq_sizing->mpte_group_bytes) - 6;
 }
 
 static void extract_rq_regs(struct display_mode_lib *mode_lib,
@@ -118,13 +118,13 @@ static void extract_rq_regs(struct display_mode_lib *mode_lib,
 	unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
 	unsigned int detile_buf_plane1_addr = 0;
 
-	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.rq_l);
+	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), &rq_param.sizing.rq_l);
 
 	rq_regs->rq_regs_l.pte_row_height_linear = dml_floor(dml_log2(rq_param.dlg.rq_l.dpte_row_height),
 		1) - 3;
 
 	if (rq_param.yuv420) {
-		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.rq_c);
+		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), &rq_param.sizing.rq_c);
 		rq_regs->rq_regs_c.pte_row_height_linear = dml_floor(dml_log2(rq_param.dlg.rq_c.dpte_row_height),
 			1) - 3;
 	}
@@ -872,7 +872,7 @@ static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 
 	// calculate how to split the det buffer space between luma and chroma
 	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
-	print__rq_params_st(mode_lib, *rq_param);
+	print__rq_params_st(mode_lib, rq_param);
 }
 
 void dml30_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
@@ -885,7 +885,7 @@ void dml30_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
-	print__rq_regs_st(mode_lib, *rq_regs);
+	print__rq_regs_st(mode_lib, rq_regs);
 }
 
 static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
@@ -1824,8 +1824,8 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	disp_ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
 	ASSERT(disp_ttu_regs->min_ttu_vblank < dml_pow(2, 24));
 
-	print__ttu_regs_st(mode_lib, *disp_ttu_regs);
-	print__dlg_regs_st(mode_lib, *disp_dlg_regs);
+	print__ttu_regs_st(mode_lib, disp_ttu_regs);
+	print__dlg_regs_st(mode_lib, disp_dlg_regs);
 }
 
 void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
@@ -1861,7 +1861,7 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	dlg_sys_param.t_srx_delay_us = mode_lib->ip.dcfclk_cstate_latency
 		/ dlg_sys_param.deepsleep_dcfclk_mhz; // TODO: Deprecated
 
-	print__dlg_sys_params_st(mode_lib, dlg_sys_param);
+	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
 	// system parameter calculation done
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 57bd4e3f8a82..442abae4bc8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -175,25 +175,25 @@ static unsigned int get_blk_size_bytes(const enum source_macro_tile_size tile_si
 		return (4 * 1024);
 }
 
-static void extract_rq_sizing_regs(struct display_mode_lib *mode_lib, display_data_rq_regs_st *rq_regs, const display_data_rq_sizing_params_st rq_sizing)
+static void extract_rq_sizing_regs(struct display_mode_lib *mode_lib, display_data_rq_regs_st *rq_regs, const display_data_rq_sizing_params_st *rq_sizing)
 {
 	print__data_rq_sizing_params_st(mode_lib, rq_sizing);
 
-	rq_regs->chunk_size = dml_log2(rq_sizing.chunk_bytes) - 10;
+	rq_regs->chunk_size = dml_log2(rq_sizing->chunk_bytes) - 10;
 
-	if (rq_sizing.min_chunk_bytes == 0)
+	if (rq_sizing->min_chunk_bytes == 0)
 		rq_regs->min_chunk_size = 0;
 	else
-		rq_regs->min_chunk_size = dml_log2(rq_sizing.min_chunk_bytes) - 8 + 1;
+		rq_regs->min_chunk_size = dml_log2(rq_sizing->min_chunk_bytes) - 8 + 1;
 
-	rq_regs->meta_chunk_size = dml_log2(rq_sizing.meta_chunk_bytes) - 10;
-	if (rq_sizing.min_meta_chunk_bytes == 0)
+	rq_regs->meta_chunk_size = dml_log2(rq_sizing->meta_chunk_bytes) - 10;
+	if (rq_sizing->min_meta_chunk_bytes == 0)
 		rq_regs->min_meta_chunk_size = 0;
 	else
-		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing.min_meta_chunk_bytes) - 6 + 1;
+		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing->min_meta_chunk_bytes) - 6 + 1;
 
-	rq_regs->dpte_group_size = dml_log2(rq_sizing.dpte_group_bytes) - 6;
-	rq_regs->mpte_group_size = dml_log2(rq_sizing.mpte_group_bytes) - 6;
+	rq_regs->dpte_group_size = dml_log2(rq_sizing->dpte_group_bytes) - 6;
+	rq_regs->mpte_group_size = dml_log2(rq_sizing->mpte_group_bytes) - 6;
 }
 
 static void extract_rq_regs(struct display_mode_lib *mode_lib, display_rq_regs_st *rq_regs, const display_rq_params_st rq_param)
@@ -201,12 +201,12 @@ static void extract_rq_regs(struct display_mode_lib *mode_lib, display_rq_regs_s
 	unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
 	unsigned int detile_buf_plane1_addr = 0;
 
-	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.rq_l);
+	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), &rq_param.sizing.rq_l);
 
 	rq_regs->rq_regs_l.pte_row_height_linear = dml_floor(dml_log2(rq_param.dlg.rq_l.dpte_row_height), 1) - 3;
 
 	if (rq_param.yuv420) {
-		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.rq_c);
+		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), &rq_param.sizing.rq_c);
 		rq_regs->rq_regs_c.pte_row_height_linear = dml_floor(dml_log2(rq_param.dlg.rq_c.dpte_row_height), 1) - 3;
 	}
 
@@ -850,7 +850,7 @@ static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib, display_
 
 	// calculate how to split the det buffer space between luma and chroma
 	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
-	print__rq_params_st(mode_lib, *rq_param);
+	print__rq_params_st(mode_lib, rq_param);
 }
 
 void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib, display_rq_regs_st *rq_regs, const display_pipe_params_st *pipe_param)
@@ -861,7 +861,7 @@ void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib, display_rq_regs_
 	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
-	print__rq_regs_st(mode_lib, *rq_regs);
+	print__rq_regs_st(mode_lib, rq_regs);
 }
 
 static void calculate_ttu_cursor(
@@ -1669,8 +1669,8 @@ static void dml_rq_dlg_get_dlg_params(
 	disp_ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
 	ASSERT(disp_ttu_regs->min_ttu_vblank < dml_pow(2, 24));
 
-	print__ttu_regs_st(mode_lib, *disp_ttu_regs);
-	print__dlg_regs_st(mode_lib, *disp_dlg_regs);
+	print__ttu_regs_st(mode_lib, disp_ttu_regs);
+	print__dlg_regs_st(mode_lib, disp_dlg_regs);
 }
 
 void dml31_rq_dlg_get_dlg_reg(
@@ -1699,7 +1699,7 @@ void dml31_rq_dlg_get_dlg_reg(
 	dlg_sys_param.total_flip_bw = get_total_immediate_flip_bw(mode_lib, e2e_pipe_param, num_pipes);
 	dlg_sys_param.total_flip_bytes = get_total_immediate_flip_bytes(mode_lib, e2e_pipe_param, num_pipes);
 
-	print__dlg_sys_params_st(mode_lib, dlg_sys_param);
+	print__dlg_sys_params_st(mode_lib, &dlg_sys_param);
 
 	// system parameter calculation done
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
index e2d82aacd3bc..71ea503cb32f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
@@ -26,371 +26,371 @@
 #include "display_rq_dlg_helpers.h"
 #include "dml_logger.h"
 
-void print__rq_params_st(struct display_mode_lib *mode_lib, display_rq_params_st rq_param)
+void print__rq_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_params_st *rq_param)
 {
 	dml_print("DML_RQ_DLG_CALC: ***************************\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_PARAM_ST\n");
 	dml_print("DML_RQ_DLG_CALC:  <LUMA>\n");
-	print__data_rq_sizing_params_st(mode_lib, rq_param.sizing.rq_l);
+	print__data_rq_sizing_params_st(mode_lib, &rq_param->sizing.rq_l);
 	dml_print("DML_RQ_DLG_CALC:  <CHROMA> ===\n");
-	print__data_rq_sizing_params_st(mode_lib, rq_param.sizing.rq_c);
+	print__data_rq_sizing_params_st(mode_lib, &rq_param->sizing.rq_c);
 
 	dml_print("DML_RQ_DLG_CALC: <LUMA>\n");
-	print__data_rq_dlg_params_st(mode_lib, rq_param.dlg.rq_l);
+	print__data_rq_dlg_params_st(mode_lib, &rq_param->dlg.rq_l);
 	dml_print("DML_RQ_DLG_CALC: <CHROMA>\n");
-	print__data_rq_dlg_params_st(mode_lib, rq_param.dlg.rq_c);
+	print__data_rq_dlg_params_st(mode_lib, &rq_param->dlg.rq_c);
 
 	dml_print("DML_RQ_DLG_CALC: <LUMA>\n");
-	print__data_rq_misc_params_st(mode_lib, rq_param.misc.rq_l);
+	print__data_rq_misc_params_st(mode_lib, &rq_param->misc.rq_l);
 	dml_print("DML_RQ_DLG_CALC: <CHROMA>\n");
-	print__data_rq_misc_params_st(mode_lib, rq_param.misc.rq_c);
+	print__data_rq_misc_params_st(mode_lib, &rq_param->misc.rq_c);
 	dml_print("DML_RQ_DLG_CALC: ***************************\n");
 }
 
-void print__data_rq_sizing_params_st(struct display_mode_lib *mode_lib, display_data_rq_sizing_params_st rq_sizing)
+void print__data_rq_sizing_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_sizing_params_st *rq_sizing)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DATA_RQ_SIZING_PARAM_ST\n");
-	dml_print("DML_RQ_DLG_CALC:    chunk_bytes           = %0d\n", rq_sizing.chunk_bytes);
-	dml_print("DML_RQ_DLG_CALC:    min_chunk_bytes       = %0d\n", rq_sizing.min_chunk_bytes);
-	dml_print("DML_RQ_DLG_CALC:    meta_chunk_bytes      = %0d\n", rq_sizing.meta_chunk_bytes);
+	dml_print("DML_RQ_DLG_CALC:    chunk_bytes           = %0d\n", rq_sizing->chunk_bytes);
+	dml_print("DML_RQ_DLG_CALC:    min_chunk_bytes       = %0d\n", rq_sizing->min_chunk_bytes);
+	dml_print("DML_RQ_DLG_CALC:    meta_chunk_bytes      = %0d\n", rq_sizing->meta_chunk_bytes);
 	dml_print(
 			"DML_RQ_DLG_CALC:    min_meta_chunk_bytes  = %0d\n",
-			rq_sizing.min_meta_chunk_bytes);
-	dml_print("DML_RQ_DLG_CALC:    mpte_group_bytes      = %0d\n", rq_sizing.mpte_group_bytes);
-	dml_print("DML_RQ_DLG_CALC:    dpte_group_bytes      = %0d\n", rq_sizing.dpte_group_bytes);
+			rq_sizing->min_meta_chunk_bytes);
+	dml_print("DML_RQ_DLG_CALC:    mpte_group_bytes      = %0d\n", rq_sizing->mpte_group_bytes);
+	dml_print("DML_RQ_DLG_CALC:    dpte_group_bytes      = %0d\n", rq_sizing->dpte_group_bytes);
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__data_rq_dlg_params_st(struct display_mode_lib *mode_lib, display_data_rq_dlg_params_st rq_dlg_param)
+void print__data_rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_dlg_params_st *rq_dlg_param)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DATA_RQ_DLG_PARAM_ST\n");
 	dml_print(
 			"DML_RQ_DLG_CALC:    swath_width_ub              = %0d\n",
-			rq_dlg_param.swath_width_ub);
+			rq_dlg_param->swath_width_ub);
 	dml_print(
 			"DML_RQ_DLG_CALC:    swath_height                = %0d\n",
-			rq_dlg_param.swath_height);
+			rq_dlg_param->swath_height);
 	dml_print(
 			"DML_RQ_DLG_CALC:    req_per_swath_ub            = %0d\n",
-			rq_dlg_param.req_per_swath_ub);
+			rq_dlg_param->req_per_swath_ub);
 	dml_print(
 			"DML_RQ_DLG_CALC:    meta_pte_bytes_per_frame_ub = %0d\n",
-			rq_dlg_param.meta_pte_bytes_per_frame_ub);
+			rq_dlg_param->meta_pte_bytes_per_frame_ub);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dpte_req_per_row_ub         = %0d\n",
-			rq_dlg_param.dpte_req_per_row_ub);
+			rq_dlg_param->dpte_req_per_row_ub);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dpte_groups_per_row_ub      = %0d\n",
-			rq_dlg_param.dpte_groups_per_row_ub);
+			rq_dlg_param->dpte_groups_per_row_ub);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dpte_row_height             = %0d\n",
-			rq_dlg_param.dpte_row_height);
+			rq_dlg_param->dpte_row_height);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dpte_bytes_per_row_ub       = %0d\n",
-			rq_dlg_param.dpte_bytes_per_row_ub);
+			rq_dlg_param->dpte_bytes_per_row_ub);
 	dml_print(
 			"DML_RQ_DLG_CALC:    meta_chunks_per_row_ub      = %0d\n",
-			rq_dlg_param.meta_chunks_per_row_ub);
+			rq_dlg_param->meta_chunks_per_row_ub);
 	dml_print(
 			"DML_RQ_DLG_CALC:    meta_req_per_row_ub         = %0d\n",
-			rq_dlg_param.meta_req_per_row_ub);
+			rq_dlg_param->meta_req_per_row_ub);
 	dml_print(
 			"DML_RQ_DLG_CALC:    meta_row_height             = %0d\n",
-			rq_dlg_param.meta_row_height);
+			rq_dlg_param->meta_row_height);
 	dml_print(
 			"DML_RQ_DLG_CALC:    meta_bytes_per_row_ub       = %0d\n",
-			rq_dlg_param.meta_bytes_per_row_ub);
+			rq_dlg_param->meta_bytes_per_row_ub);
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, display_data_rq_misc_params_st rq_misc_param)
+void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_misc_params_st *rq_misc_param)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DATA_RQ_MISC_PARAM_ST\n");
 	dml_print(
 			"DML_RQ_DLG_CALC:     full_swath_bytes   = %0d\n",
-			rq_misc_param.full_swath_bytes);
+			rq_misc_param->full_swath_bytes);
 	dml_print(
 			"DML_RQ_DLG_CALC:     stored_swath_bytes = %0d\n",
-			rq_misc_param.stored_swath_bytes);
-	dml_print("DML_RQ_DLG_CALC:     blk256_width       = %0d\n", rq_misc_param.blk256_width);
-	dml_print("DML_RQ_DLG_CALC:     blk256_height      = %0d\n", rq_misc_param.blk256_height);
-	dml_print("DML_RQ_DLG_CALC:     req_width          = %0d\n", rq_misc_param.req_width);
-	dml_print("DML_RQ_DLG_CALC:     req_height         = %0d\n", rq_misc_param.req_height);
+			rq_misc_param->stored_swath_bytes);
+	dml_print("DML_RQ_DLG_CALC:     blk256_width       = %0d\n", rq_misc_param->blk256_width);
+	dml_print("DML_RQ_DLG_CALC:     blk256_height      = %0d\n", rq_misc_param->blk256_height);
+	dml_print("DML_RQ_DLG_CALC:     req_width          = %0d\n", rq_misc_param->req_width);
+	dml_print("DML_RQ_DLG_CALC:     req_height         = %0d\n", rq_misc_param->req_height);
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, display_rq_dlg_params_st rq_dlg_param)
+void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_dlg_params_st *rq_dlg_param)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_DLG_PARAM_ST\n");
 	dml_print("DML_RQ_DLG_CALC:  <LUMA>\n");
-	print__data_rq_dlg_params_st(mode_lib, rq_dlg_param.rq_l);
+	print__data_rq_dlg_params_st(mode_lib, &rq_dlg_param->rq_l);
 	dml_print("DML_RQ_DLG_CALC:  <CHROMA>\n");
-	print__data_rq_dlg_params_st(mode_lib, rq_dlg_param.rq_c);
+	print__data_rq_dlg_params_st(mode_lib, &rq_dlg_param->rq_c);
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, display_dlg_sys_params_st dlg_sys_param)
+void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_DLG_PARAM_ST\n");
-	dml_print("DML_RQ_DLG_CALC:    t_mclk_wm_us         = %3.2f\n", dlg_sys_param.t_mclk_wm_us);
-	dml_print("DML_RQ_DLG_CALC:    t_urg_wm_us          = %3.2f\n", dlg_sys_param.t_urg_wm_us);
-	dml_print("DML_RQ_DLG_CALC:    t_sr_wm_us           = %3.2f\n", dlg_sys_param.t_sr_wm_us);
-	dml_print("DML_RQ_DLG_CALC:    t_extra_us           = %3.2f\n", dlg_sys_param.t_extra_us);
+	dml_print("DML_RQ_DLG_CALC:    t_mclk_wm_us         = %3.2f\n", dlg_sys_param->t_mclk_wm_us);
+	dml_print("DML_RQ_DLG_CALC:    t_urg_wm_us          = %3.2f\n", dlg_sys_param->t_urg_wm_us);
+	dml_print("DML_RQ_DLG_CALC:    t_sr_wm_us           = %3.2f\n", dlg_sys_param->t_sr_wm_us);
+	dml_print("DML_RQ_DLG_CALC:    t_extra_us           = %3.2f\n", dlg_sys_param->t_extra_us);
 	dml_print(
 			"DML_RQ_DLG_CALC:    t_srx_delay_us       = %3.2f\n",
-			dlg_sys_param.t_srx_delay_us);
+			dlg_sys_param->t_srx_delay_us);
 	dml_print(
 			"DML_RQ_DLG_CALC:    deepsleep_dcfclk_mhz = %3.2f\n",
-			dlg_sys_param.deepsleep_dcfclk_mhz);
+			dlg_sys_param->deepsleep_dcfclk_mhz);
 	dml_print(
 			"DML_RQ_DLG_CALC:    total_flip_bw        = %3.2f\n",
-			dlg_sys_param.total_flip_bw);
+			dlg_sys_param->total_flip_bw);
 	dml_print(
 			"DML_RQ_DLG_CALC:    total_flip_bytes     = %i\n",
-			dlg_sys_param.total_flip_bytes);
+			dlg_sys_param->total_flip_bytes);
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__data_rq_regs_st(struct display_mode_lib *mode_lib, display_data_rq_regs_st rq_regs)
+void print__data_rq_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_regs_st *rq_regs)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DATA_RQ_REGS_ST\n");
-	dml_print("DML_RQ_DLG_CALC:    chunk_size              = 0x%0x\n", rq_regs.chunk_size);
-	dml_print("DML_RQ_DLG_CALC:    min_chunk_size          = 0x%0x\n", rq_regs.min_chunk_size);
-	dml_print("DML_RQ_DLG_CALC:    meta_chunk_size         = 0x%0x\n", rq_regs.meta_chunk_size);
+	dml_print("DML_RQ_DLG_CALC:    chunk_size              = 0x%0x\n", rq_regs->chunk_size);
+	dml_print("DML_RQ_DLG_CALC:    min_chunk_size          = 0x%0x\n", rq_regs->min_chunk_size);
+	dml_print("DML_RQ_DLG_CALC:    meta_chunk_size         = 0x%0x\n", rq_regs->meta_chunk_size);
 	dml_print(
 			"DML_RQ_DLG_CALC:    min_meta_chunk_size     = 0x%0x\n",
-			rq_regs.min_meta_chunk_size);
-	dml_print("DML_RQ_DLG_CALC:    dpte_group_size         = 0x%0x\n", rq_regs.dpte_group_size);
-	dml_print("DML_RQ_DLG_CALC:    mpte_group_size         = 0x%0x\n", rq_regs.mpte_group_size);
-	dml_print("DML_RQ_DLG_CALC:    swath_height            = 0x%0x\n", rq_regs.swath_height);
+			rq_regs->min_meta_chunk_size);
+	dml_print("DML_RQ_DLG_CALC:    dpte_group_size         = 0x%0x\n", rq_regs->dpte_group_size);
+	dml_print("DML_RQ_DLG_CALC:    mpte_group_size         = 0x%0x\n", rq_regs->mpte_group_size);
+	dml_print("DML_RQ_DLG_CALC:    swath_height            = 0x%0x\n", rq_regs->swath_height);
 	dml_print(
 			"DML_RQ_DLG_CALC:    pte_row_height_linear   = 0x%0x\n",
-			rq_regs.pte_row_height_linear);
+			rq_regs->pte_row_height_linear);
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__rq_regs_st(struct display_mode_lib *mode_lib, display_rq_regs_st rq_regs)
+void print__rq_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_regs_st *rq_regs)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_REGS_ST\n");
 	dml_print("DML_RQ_DLG_CALC:  <LUMA>\n");
-	print__data_rq_regs_st(mode_lib, rq_regs.rq_regs_l);
+	print__data_rq_regs_st(mode_lib, &rq_regs->rq_regs_l);
 	dml_print("DML_RQ_DLG_CALC:  <CHROMA>\n");
-	print__data_rq_regs_st(mode_lib, rq_regs.rq_regs_c);
-	dml_print("DML_RQ_DLG_CALC:    drq_expansion_mode  = 0x%0x\n", rq_regs.drq_expansion_mode);
-	dml_print("DML_RQ_DLG_CALC:    prq_expansion_mode  = 0x%0x\n", rq_regs.prq_expansion_mode);
-	dml_print("DML_RQ_DLG_CALC:    mrq_expansion_mode  = 0x%0x\n", rq_regs.mrq_expansion_mode);
-	dml_print("DML_RQ_DLG_CALC:    crq_expansion_mode  = 0x%0x\n", rq_regs.crq_expansion_mode);
-	dml_print("DML_RQ_DLG_CALC:    plane1_base_address = 0x%0x\n", rq_regs.plane1_base_address);
+	print__data_rq_regs_st(mode_lib, &rq_regs->rq_regs_c);
+	dml_print("DML_RQ_DLG_CALC:    drq_expansion_mode  = 0x%0x\n", rq_regs->drq_expansion_mode);
+	dml_print("DML_RQ_DLG_CALC:    prq_expansion_mode  = 0x%0x\n", rq_regs->prq_expansion_mode);
+	dml_print("DML_RQ_DLG_CALC:    mrq_expansion_mode  = 0x%0x\n", rq_regs->mrq_expansion_mode);
+	dml_print("DML_RQ_DLG_CALC:    crq_expansion_mode  = 0x%0x\n", rq_regs->crq_expansion_mode);
+	dml_print("DML_RQ_DLG_CALC:    plane1_base_address = 0x%0x\n", rq_regs->plane1_base_address);
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__dlg_regs_st(struct display_mode_lib *mode_lib, display_dlg_regs_st dlg_regs)
+void print__dlg_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_regs_st *dlg_regs)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_DLG_REGS_ST\n");
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_h_blank_end              = 0x%0x\n",
-			dlg_regs.refcyc_h_blank_end);
+			dlg_regs->refcyc_h_blank_end);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dlg_vblank_end                  = 0x%0x\n",
-			dlg_regs.dlg_vblank_end);
+			dlg_regs->dlg_vblank_end);
 	dml_print(
 			"DML_RQ_DLG_CALC:    min_dst_y_next_start            = 0x%0x\n",
-			dlg_regs.min_dst_y_next_start);
+			dlg_regs->min_dst_y_next_start);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_htotal               = 0x%0x\n",
-			dlg_regs.refcyc_per_htotal);
+			dlg_regs->refcyc_per_htotal);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_x_after_scaler           = 0x%0x\n",
-			dlg_regs.refcyc_x_after_scaler);
+			dlg_regs->refcyc_x_after_scaler);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_after_scaler              = 0x%0x\n",
-			dlg_regs.dst_y_after_scaler);
+			dlg_regs->dst_y_after_scaler);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_prefetch                  = 0x%0x\n",
-			dlg_regs.dst_y_prefetch);
+			dlg_regs->dst_y_prefetch);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_per_vm_vblank             = 0x%0x\n",
-			dlg_regs.dst_y_per_vm_vblank);
+			dlg_regs->dst_y_per_vm_vblank);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_per_row_vblank            = 0x%0x\n",
-			dlg_regs.dst_y_per_row_vblank);
+			dlg_regs->dst_y_per_row_vblank);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_per_vm_flip               = 0x%0x\n",
-			dlg_regs.dst_y_per_vm_flip);
+			dlg_regs->dst_y_per_vm_flip);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_per_row_flip              = 0x%0x\n",
-			dlg_regs.dst_y_per_row_flip);
+			dlg_regs->dst_y_per_row_flip);
 	dml_print(
 			"DML_RQ_DLG_CALC:    ref_freq_to_pix_freq            = 0x%0x\n",
-			dlg_regs.ref_freq_to_pix_freq);
+			dlg_regs->ref_freq_to_pix_freq);
 	dml_print(
 			"DML_RQ_DLG_CALC:    vratio_prefetch                 = 0x%0x\n",
-			dlg_regs.vratio_prefetch);
+			dlg_regs->vratio_prefetch);
 	dml_print(
 			"DML_RQ_DLG_CALC:    vratio_prefetch_c               = 0x%0x\n",
-			dlg_regs.vratio_prefetch_c);
+			dlg_regs->vratio_prefetch_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_pte_group_vblank_l   = 0x%0x\n",
-			dlg_regs.refcyc_per_pte_group_vblank_l);
+			dlg_regs->refcyc_per_pte_group_vblank_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_pte_group_vblank_c   = 0x%0x\n",
-			dlg_regs.refcyc_per_pte_group_vblank_c);
+			dlg_regs->refcyc_per_pte_group_vblank_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_meta_chunk_vblank_l  = 0x%0x\n",
-			dlg_regs.refcyc_per_meta_chunk_vblank_l);
+			dlg_regs->refcyc_per_meta_chunk_vblank_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_meta_chunk_vblank_c  = 0x%0x\n",
-			dlg_regs.refcyc_per_meta_chunk_vblank_c);
+			dlg_regs->refcyc_per_meta_chunk_vblank_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_pte_group_flip_l     = 0x%0x\n",
-			dlg_regs.refcyc_per_pte_group_flip_l);
+			dlg_regs->refcyc_per_pte_group_flip_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_pte_group_flip_c     = 0x%0x\n",
-			dlg_regs.refcyc_per_pte_group_flip_c);
+			dlg_regs->refcyc_per_pte_group_flip_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_meta_chunk_flip_l    = 0x%0x\n",
-			dlg_regs.refcyc_per_meta_chunk_flip_l);
+			dlg_regs->refcyc_per_meta_chunk_flip_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_meta_chunk_flip_c    = 0x%0x\n",
-			dlg_regs.refcyc_per_meta_chunk_flip_c);
+			dlg_regs->refcyc_per_meta_chunk_flip_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_per_pte_row_nom_l         = 0x%0x\n",
-			dlg_regs.dst_y_per_pte_row_nom_l);
+			dlg_regs->dst_y_per_pte_row_nom_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_per_pte_row_nom_c         = 0x%0x\n",
-			dlg_regs.dst_y_per_pte_row_nom_c);
+			dlg_regs->dst_y_per_pte_row_nom_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_pte_group_nom_l      = 0x%0x\n",
-			dlg_regs.refcyc_per_pte_group_nom_l);
+			dlg_regs->refcyc_per_pte_group_nom_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_pte_group_nom_c      = 0x%0x\n",
-			dlg_regs.refcyc_per_pte_group_nom_c);
+			dlg_regs->refcyc_per_pte_group_nom_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_per_meta_row_nom_l        = 0x%0x\n",
-			dlg_regs.dst_y_per_meta_row_nom_l);
+			dlg_regs->dst_y_per_meta_row_nom_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_per_meta_row_nom_c        = 0x%0x\n",
-			dlg_regs.dst_y_per_meta_row_nom_c);
+			dlg_regs->dst_y_per_meta_row_nom_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_meta_chunk_nom_l     = 0x%0x\n",
-			dlg_regs.refcyc_per_meta_chunk_nom_l);
+			dlg_regs->refcyc_per_meta_chunk_nom_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_meta_chunk_nom_c     = 0x%0x\n",
-			dlg_regs.refcyc_per_meta_chunk_nom_c);
+			dlg_regs->refcyc_per_meta_chunk_nom_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_line_delivery_pre_l  = 0x%0x\n",
-			dlg_regs.refcyc_per_line_delivery_pre_l);
+			dlg_regs->refcyc_per_line_delivery_pre_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_line_delivery_pre_c  = 0x%0x\n",
-			dlg_regs.refcyc_per_line_delivery_pre_c);
+			dlg_regs->refcyc_per_line_delivery_pre_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_line_delivery_l      = 0x%0x\n",
-			dlg_regs.refcyc_per_line_delivery_l);
+			dlg_regs->refcyc_per_line_delivery_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_line_delivery_c      = 0x%0x\n",
-			dlg_regs.refcyc_per_line_delivery_c);
+			dlg_regs->refcyc_per_line_delivery_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    chunk_hdl_adjust_cur0           = 0x%0x\n",
-			dlg_regs.chunk_hdl_adjust_cur0);
+			dlg_regs->chunk_hdl_adjust_cur0);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_offset_cur1               = 0x%0x\n",
-			dlg_regs.dst_y_offset_cur1);
+			dlg_regs->dst_y_offset_cur1);
 	dml_print(
 			"DML_RQ_DLG_CALC:    chunk_hdl_adjust_cur1           = 0x%0x\n",
-			dlg_regs.chunk_hdl_adjust_cur1);
+			dlg_regs->chunk_hdl_adjust_cur1);
 	dml_print(
 			"DML_RQ_DLG_CALC:    vready_after_vcount0            = 0x%0x\n",
-			dlg_regs.vready_after_vcount0);
+			dlg_regs->vready_after_vcount0);
 	dml_print(
 			"DML_RQ_DLG_CALC:    dst_y_delta_drq_limit           = 0x%0x\n",
-			dlg_regs.dst_y_delta_drq_limit);
+			dlg_regs->dst_y_delta_drq_limit);
 	dml_print(
 			"DML_RQ_DLG_CALC:    xfc_reg_transfer_delay          = 0x%0x\n",
-			dlg_regs.xfc_reg_transfer_delay);
+			dlg_regs->xfc_reg_transfer_delay);
 	dml_print(
 			"DML_RQ_DLG_CALC:    xfc_reg_precharge_delay         = 0x%0x\n",
-			dlg_regs.xfc_reg_precharge_delay);
+			dlg_regs->xfc_reg_precharge_delay);
 	dml_print(
 			"DML_RQ_DLG_CALC:    xfc_reg_remote_surface_flip_latency = 0x%0x\n",
-			dlg_regs.xfc_reg_remote_surface_flip_latency);
+			dlg_regs->xfc_reg_remote_surface_flip_latency);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_vm_dmdata            = 0x%0x\n",
-			dlg_regs.refcyc_per_vm_dmdata);
+			dlg_regs->refcyc_per_vm_dmdata);
 
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__ttu_regs_st(struct display_mode_lib *mode_lib, display_ttu_regs_st ttu_regs)
+void print__ttu_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_ttu_regs_st *ttu_regs)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 	dml_print("DML_RQ_DLG_CALC: DISPLAY_TTU_REGS_ST\n");
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_level_low_wm                  = 0x%0x\n",
-			ttu_regs.qos_level_low_wm);
+			ttu_regs->qos_level_low_wm);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_level_high_wm                 = 0x%0x\n",
-			ttu_regs.qos_level_high_wm);
+			ttu_regs->qos_level_high_wm);
 	dml_print(
 			"DML_RQ_DLG_CALC:    min_ttu_vblank                    = 0x%0x\n",
-			ttu_regs.min_ttu_vblank);
+			ttu_regs->min_ttu_vblank);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_level_flip                    = 0x%0x\n",
-			ttu_regs.qos_level_flip);
+			ttu_regs->qos_level_flip);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_req_delivery_pre_l     = 0x%0x\n",
-			ttu_regs.refcyc_per_req_delivery_pre_l);
+			ttu_regs->refcyc_per_req_delivery_pre_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_req_delivery_l         = 0x%0x\n",
-			ttu_regs.refcyc_per_req_delivery_l);
+			ttu_regs->refcyc_per_req_delivery_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_req_delivery_pre_c     = 0x%0x\n",
-			ttu_regs.refcyc_per_req_delivery_pre_c);
+			ttu_regs->refcyc_per_req_delivery_pre_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_req_delivery_c         = 0x%0x\n",
-			ttu_regs.refcyc_per_req_delivery_c);
+			ttu_regs->refcyc_per_req_delivery_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_req_delivery_cur0      = 0x%0x\n",
-			ttu_regs.refcyc_per_req_delivery_cur0);
+			ttu_regs->refcyc_per_req_delivery_cur0);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_req_delivery_pre_cur0  = 0x%0x\n",
-			ttu_regs.refcyc_per_req_delivery_pre_cur0);
+			ttu_regs->refcyc_per_req_delivery_pre_cur0);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_req_delivery_cur1      = 0x%0x\n",
-			ttu_regs.refcyc_per_req_delivery_cur1);
+			ttu_regs->refcyc_per_req_delivery_cur1);
 	dml_print(
 			"DML_RQ_DLG_CALC:    refcyc_per_req_delivery_pre_cur1  = 0x%0x\n",
-			ttu_regs.refcyc_per_req_delivery_pre_cur1);
+			ttu_regs->refcyc_per_req_delivery_pre_cur1);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_level_fixed_l                 = 0x%0x\n",
-			ttu_regs.qos_level_fixed_l);
+			ttu_regs->qos_level_fixed_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_ramp_disable_l                = 0x%0x\n",
-			ttu_regs.qos_ramp_disable_l);
+			ttu_regs->qos_ramp_disable_l);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_level_fixed_c                 = 0x%0x\n",
-			ttu_regs.qos_level_fixed_c);
+			ttu_regs->qos_level_fixed_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_ramp_disable_c                = 0x%0x\n",
-			ttu_regs.qos_ramp_disable_c);
+			ttu_regs->qos_ramp_disable_c);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_level_fixed_cur0              = 0x%0x\n",
-			ttu_regs.qos_level_fixed_cur0);
+			ttu_regs->qos_level_fixed_cur0);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_ramp_disable_cur0             = 0x%0x\n",
-			ttu_regs.qos_ramp_disable_cur0);
+			ttu_regs->qos_ramp_disable_cur0);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_level_fixed_cur1              = 0x%0x\n",
-			ttu_regs.qos_level_fixed_cur1);
+			ttu_regs->qos_level_fixed_cur1);
 	dml_print(
 			"DML_RQ_DLG_CALC:    qos_ramp_disable_cur1             = 0x%0x\n",
-			ttu_regs.qos_ramp_disable_cur1);
+			ttu_regs->qos_ramp_disable_cur1);
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
index 2555ef0358c2..ebcd717744e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
@@ -31,16 +31,16 @@
 /* Function: Printer functions
  *  Print various struct
  */
-void print__rq_params_st(struct display_mode_lib *mode_lib, display_rq_params_st rq_param);
-void print__data_rq_sizing_params_st(struct display_mode_lib *mode_lib, display_data_rq_sizing_params_st rq_sizing);
-void print__data_rq_dlg_params_st(struct display_mode_lib *mode_lib, display_data_rq_dlg_params_st rq_dlg_param);
-void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, display_data_rq_misc_params_st rq_misc_param);
-void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, display_rq_dlg_params_st rq_dlg_param);
-void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, display_dlg_sys_params_st dlg_sys_param);
+void print__rq_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_params_st *rq_param);
+void print__data_rq_sizing_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_sizing_params_st *rq_sizing);
+void print__data_rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_dlg_params_st *rq_dlg_param);
+void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_misc_params_st *rq_misc_param);
+void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_dlg_params_st *rq_dlg_param);
+void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param);
 
-void print__data_rq_regs_st(struct display_mode_lib *mode_lib, display_data_rq_regs_st data_rq_regs);
-void print__rq_regs_st(struct display_mode_lib *mode_lib, display_rq_regs_st rq_regs);
-void print__dlg_regs_st(struct display_mode_lib *mode_lib, display_dlg_regs_st dlg_regs);
-void print__ttu_regs_st(struct display_mode_lib *mode_lib, display_ttu_regs_st ttu_regs);
+void print__data_rq_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_regs_st *rq_regs);
+void print__rq_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_regs_st *rq_regs);
+void print__dlg_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_regs_st *dlg_regs);
+void print__ttu_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_ttu_regs_st *ttu_regs);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index 8f2b1684c231..9bde3f961409 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -206,26 +206,26 @@ static unsigned int get_blk_size_bytes(const enum source_macro_tile_size tile_si
 static void extract_rq_sizing_regs(
 		struct display_mode_lib *mode_lib,
 		struct _vcs_dpi_display_data_rq_regs_st *rq_regs,
-		const struct _vcs_dpi_display_data_rq_sizing_params_st rq_sizing)
+		const struct _vcs_dpi_display_data_rq_sizing_params_st *rq_sizing)
 {
 	DTRACE("DLG: %s: rq_sizing param", __func__);
 	print__data_rq_sizing_params_st(mode_lib, rq_sizing);
 
-	rq_regs->chunk_size = dml_log2(rq_sizing.chunk_bytes) - 10;
+	rq_regs->chunk_size = dml_log2(rq_sizing->chunk_bytes) - 10;
 
-	if (rq_sizing.min_chunk_bytes == 0)
+	if (rq_sizing->min_chunk_bytes == 0)
 		rq_regs->min_chunk_size = 0;
 	else
-		rq_regs->min_chunk_size = dml_log2(rq_sizing.min_chunk_bytes) - 8 + 1;
+		rq_regs->min_chunk_size = dml_log2(rq_sizing->min_chunk_bytes) - 8 + 1;
 
-	rq_regs->meta_chunk_size = dml_log2(rq_sizing.meta_chunk_bytes) - 10;
-	if (rq_sizing.min_meta_chunk_bytes == 0)
+	rq_regs->meta_chunk_size = dml_log2(rq_sizing->meta_chunk_bytes) - 10;
+	if (rq_sizing->min_meta_chunk_bytes == 0)
 		rq_regs->min_meta_chunk_size = 0;
 	else
-		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing.min_meta_chunk_bytes) - 6 + 1;
+		rq_regs->min_meta_chunk_size = dml_log2(rq_sizing->min_meta_chunk_bytes) - 6 + 1;
 
-	rq_regs->dpte_group_size = dml_log2(rq_sizing.dpte_group_bytes) - 6;
-	rq_regs->mpte_group_size = dml_log2(rq_sizing.mpte_group_bytes) - 6;
+	rq_regs->dpte_group_size = dml_log2(rq_sizing->dpte_group_bytes) - 6;
+	rq_regs->mpte_group_size = dml_log2(rq_sizing->mpte_group_bytes) - 6;
 }
 
 void dml1_extract_rq_regs(
@@ -236,9 +236,9 @@ void dml1_extract_rq_regs(
 	unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
 	unsigned int detile_buf_plane1_addr = 0;
 
-	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.rq_l);
+	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), &rq_param.sizing.rq_l);
 	if (rq_param.yuv420)
-		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.rq_c);
+		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), &rq_param.sizing.rq_c);
 
 	rq_regs->rq_regs_l.swath_height = dml_log2(rq_param.dlg.rq_l.swath_height);
 	rq_regs->rq_regs_c.swath_height = dml_log2(rq_param.dlg.rq_c.swath_height);
@@ -988,7 +988,7 @@ void dml1_rq_dlg_get_rq_params(
 
 	/* calculate how to split the det buffer space between luma and chroma */
 	handle_det_buf_split(mode_lib, rq_param, pipe_src_param);
-	print__rq_params_st(mode_lib, *rq_param);
+	print__rq_params_st(mode_lib, rq_param);
 }
 
 /* Note: currently taken in as is.
@@ -1927,6 +1927,6 @@ void dml1_rq_dlg_get_dlg_params(
 	disp_ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
 	ASSERT(disp_ttu_regs->min_ttu_vblank < dml_pow(2, 24));
 
-	print__ttu_regs_st(mode_lib, *disp_ttu_regs);
-	print__dlg_regs_st(mode_lib, *disp_dlg_regs);
+	print__ttu_regs_st(mode_lib, disp_ttu_regs);
+	print__dlg_regs_st(mode_lib, disp_dlg_regs);
 }
-- 
2.33.0

