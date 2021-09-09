Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6745D404287
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349254AbhIIBB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:01:56 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:18017
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348941AbhIIBBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:01:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leNmdEJbaFa3o0WJWSszVUghHTeZAfHPFiX9dTEdPAhlnRufjrOmITAARXOmJxAOwe1eP9QQKLiIVnFDElNdK4as0liQ0S63NUbL3/nMW1VykjOrQPGouPJ8lJ64PgFx7d9mD5/67os2vRYixA2MddFZbRb0qtzBNYpvWGKAoHkK5C0l+Oe2hntNlY+4Zfn8vZh2a2MC0OOKJ18fYzducKD6TrroJaPtajRsHFnssezey8zeJinEaRZ9zPAcs7SKBKgk5yU2OZm3+1QSz5LnNIcHsqlJDu7+utgDEVzT8NJA9HzII2ggqOFbe37tdeBANW1AdrCAvTb54lStuKRaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gxvBvuuAcCrB+fqQ6hTvv3yY7goYiuGPy8kdAV359pQ=;
 b=FQcm4z43iwv6fSS+KwMYPHH58lGae0y26dV9tWUW2zW5N5+ewnmxWfHm2saIHtb/FJGelVLKIOuV/ertexNB1t1FZyrYRo8sx2K6PE6xq0dZisp7HhWxDl+4RtFAo5kyjYrGZufgpgHFHNPPMB7YqWuScCHajK7OcIyTVN8MUXhIXoUvMW0G7GwrHBotECmxh2lEt6tUGce2MBgJ9sYeJwbD5aQUF3dL2pKdr1yi98NaxKCgYlP6941ErtQKWq1InBMkb28QBJN9Pulb4rT/GhrWkS1LJx+/JuDpj3KD5I7VPu3+k3kYWa7lwDnW/vwAPahk+vGNtDb16LIFkPoQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxvBvuuAcCrB+fqQ6hTvv3yY7goYiuGPy8kdAV359pQ=;
 b=kcFgI6g3vgUyzwdVW3FwTvLuqB1DE6uqosTDQxpQK5u9SRXv2k0SXp3cuPJ44JhWT7QVO1EbdcwQDi1pw7zT1hfLccbIiaBUKrNVAcXcuOpdz6fsjK4G5cRaAZTorIWVGLk/8iC4lK/iKL6pTTxSUkJPm2iWBpRUtb2mAioQasQ=
Received: from CO2PR04CA0110.namprd04.prod.outlook.com (2603:10b6:104:7::12)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 01:00:31 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::61) by CO2PR04CA0110.outlook.office365.com
 (2603:10b6:104:7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 01:00:31 +0000
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
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 01:00:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 20:00:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 20:00:30 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Wed, 8 Sep 2021 20:00:29 -0500
From:   Harry Wentland <harry.wentland@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <ndesaulniers@google.com>, <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <arnd@kernel.org>,
        <sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>,
        <nathan@kernel.org>, <linux@roeck-us.net>, <llvm@lists.linux.dev>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 4/4] drm/amd/display: Allocate structs needed by dcn_bw_calc_rq_dlg_ttu in pipe_ctx
Date:   Wed, 8 Sep 2021 21:00:23 -0400
Message-ID: <20210909010023.29110-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909010023.29110-1-harry.wentland@amd.com>
References: <20210909010023.29110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d587862-d546-4349-d625-08d9732d3903
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-Microsoft-Antispam-PRVS: <BY5PR12MB46444F6EEAC4C826E34C44818CD59@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcK4DBN7Vw94L25OwANoh7pl+K0roekSc60txSqRqyl8oQGk9SYbwGcld3mOE/NyiQd1QJVpczA4tSpW+8Wzl7w8m1Vr4RXTrrUOm9WULnPNxP7Lv0u1d3kO2lZLCd8KfkVlW1fCoYrB9zxUjqt8Rx+6EgFISmUYeC0o/n9wgEADlwmsPfryuFS/pbL1IuDB3DiqbSYuXrW03zyaKRpiSTD+H/Vm4igr79IVTYrj7HwMA89xRpQj7XrjiBqqxqPRBiNX361Q6i897wYbCDG2wQLh1iYXSL+BBnKQPMQH9w7nKI3v8KOHYlU01wSQYUVL5zkLSMN+qgN4Jb3EtRU1TBXRZVmuVgzhYCN1XXxM4zSWEkqdgqBlPQoa0HxrTUaEk9im66t9XkoxS4EATNw+2IX6nQzAyIWlyYgvC2xXmpNtonR6wfrLHkzdb7Afs2Tj2ZVVshJT/9TUnhMNLyBN5m7aRKSPHotCPt2rRwjY0UZ1TAKDGTK8EI4+ObkZ50J0ijUzZaxk7gkFeBt+BG92Tc/C+WkuWLrIwzPcUkF0I79RzGppLko2fRmn2RpncxNjHZx30Ml5JvL88FNaRlWZpKhiCW0q8nCoFIl+Xgb9GFfv9fnGTtxWS+fwSRbKStk2F17lsJJF016JBdC2fao1JgirtuV7uhRG8+MvM/wVAMX16OCIVHHy8eHzNFOUGZikq2ejuL5t58fL2JDqr1HTYB8/MKENrwePfElq0gO8JGs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(336012)(82740400003)(36756003)(6916009)(2616005)(82310400003)(70586007)(86362001)(70206006)(7696005)(6666004)(426003)(478600001)(8676002)(8936002)(26005)(83380400001)(54906003)(36860700001)(44832011)(81166007)(4326008)(47076005)(1076003)(186003)(2906002)(356005)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 01:00:31.5212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d587862-d546-4349-d625-08d9732d3903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why & How]
dcn_bw_calc_rq_dlg_ttu uses a stack frame great than 1024. To solve this
we could allocate the rq_param, dlg_sys_param, and input structs
dynamically. Since this function is inside a kernel_fpu_begin()/end()
call we want to avoid memory allocation. Instead it's much
safer to pre-allocate these on the pipe_ctx.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Fixes: 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
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
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  | 61 ++++++++++---------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 +
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 8e3a9294be3a..6b248cd2a461 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -459,9 +459,9 @@ static void dcn_bw_calc_rq_dlg_ttu(
 	struct _vcs_dpi_display_dlg_regs_st *dlg_regs = &pipe->dlg_regs;
 	struct _vcs_dpi_display_ttu_regs_st *ttu_regs = &pipe->ttu_regs;
 	struct _vcs_dpi_display_rq_regs_st *rq_regs = &pipe->rq_regs;
-	struct _vcs_dpi_display_rq_params_st rq_param = {0};
-	struct _vcs_dpi_display_dlg_sys_params_st dlg_sys_param = {0};
-	struct _vcs_dpi_display_e2e_pipe_params_st input = { { { 0 } } };
+	struct _vcs_dpi_display_rq_params_st *rq_param = &pipe->dml_rq_param;
+	struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param = &pipe->dml_dlg_sys_param;
+	struct _vcs_dpi_display_e2e_pipe_params_st *input = &pipe->dml_input;
 	float total_active_bw = 0;
 	float total_prefetch_bw = 0;
 	int total_flip_bytes = 0;
@@ -470,47 +470,50 @@ static void dcn_bw_calc_rq_dlg_ttu(
 	memset(dlg_regs, 0, sizeof(*dlg_regs));
 	memset(ttu_regs, 0, sizeof(*ttu_regs));
 	memset(rq_regs, 0, sizeof(*rq_regs));
+	memset(rq_param, 0, sizeof(*rq_param));
+	memset(dlg_sys_param, 0, sizeof(*dlg_sys_param));
+	memset(input, 0, sizeof(*input));
 
 	for (i = 0; i < number_of_planes; i++) {
 		total_active_bw += v->read_bandwidth[i];
 		total_prefetch_bw += v->prefetch_bandwidth[i];
 		total_flip_bytes += v->total_immediate_flip_bytes[i];
 	}
-	dlg_sys_param.total_flip_bw = v->return_bw - dcn_bw_max2(total_active_bw, total_prefetch_bw);
-	if (dlg_sys_param.total_flip_bw < 0.0)
-		dlg_sys_param.total_flip_bw = 0;
-
-	dlg_sys_param.t_mclk_wm_us = v->dram_clock_change_watermark;
-	dlg_sys_param.t_sr_wm_us = v->stutter_enter_plus_exit_watermark;
-	dlg_sys_param.t_urg_wm_us = v->urgent_watermark;
-	dlg_sys_param.t_extra_us = v->urgent_extra_latency;
-	dlg_sys_param.deepsleep_dcfclk_mhz = v->dcf_clk_deep_sleep;
-	dlg_sys_param.total_flip_bytes = total_flip_bytes;
-
-	pipe_ctx_to_e2e_pipe_params(pipe, &input.pipe);
-	input.clks_cfg.dcfclk_mhz = v->dcfclk;
-	input.clks_cfg.dispclk_mhz = v->dispclk;
-	input.clks_cfg.dppclk_mhz = v->dppclk;
-	input.clks_cfg.refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000.0;
-	input.clks_cfg.socclk_mhz = v->socclk;
-	input.clks_cfg.voltage = v->voltage_level;
+	dlg_sys_param->total_flip_bw = v->return_bw - dcn_bw_max2(total_active_bw, total_prefetch_bw);
+	if (dlg_sys_param->total_flip_bw < 0.0)
+		dlg_sys_param->total_flip_bw = 0;
+
+	dlg_sys_param->t_mclk_wm_us = v->dram_clock_change_watermark;
+	dlg_sys_param->t_sr_wm_us = v->stutter_enter_plus_exit_watermark;
+	dlg_sys_param->t_urg_wm_us = v->urgent_watermark;
+	dlg_sys_param->t_extra_us = v->urgent_extra_latency;
+	dlg_sys_param->deepsleep_dcfclk_mhz = v->dcf_clk_deep_sleep;
+	dlg_sys_param->total_flip_bytes = total_flip_bytes;
+
+	pipe_ctx_to_e2e_pipe_params(pipe, &input->pipe);
+	input->clks_cfg.dcfclk_mhz = v->dcfclk;
+	input->clks_cfg.dispclk_mhz = v->dispclk;
+	input->clks_cfg.dppclk_mhz = v->dppclk;
+	input->clks_cfg.refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000.0;
+	input->clks_cfg.socclk_mhz = v->socclk;
+	input->clks_cfg.voltage = v->voltage_level;
 //	dc->dml.logger = pool->base.logger;
-	input.dout.output_format = (v->output_format[in_idx] == dcn_bw_420) ? dm_420 : dm_444;
-	input.dout.output_type  = (v->output[in_idx] == dcn_bw_hdmi) ? dm_hdmi : dm_dp;
+	input->dout.output_format = (v->output_format[in_idx] == dcn_bw_420) ? dm_420 : dm_444;
+	input->dout.output_type  = (v->output[in_idx] == dcn_bw_hdmi) ? dm_hdmi : dm_dp;
 	//input[in_idx].dout.output_standard;
 
 	/*todo: soc->sr_enter_plus_exit_time??*/
-	dlg_sys_param.t_srx_delay_us = dc->dcn_ip->dcfclk_cstate_latency / v->dcf_clk_deep_sleep;
+	dlg_sys_param->t_srx_delay_us = dc->dcn_ip->dcfclk_cstate_latency / v->dcf_clk_deep_sleep;
 
-	dml1_rq_dlg_get_rq_params(dml, &rq_param, &input.pipe.src);
-	dml1_extract_rq_regs(dml, rq_regs, &rq_param);
+	dml1_rq_dlg_get_rq_params(dml, rq_param, &input->pipe.src);
+	dml1_extract_rq_regs(dml, rq_regs, rq_param);
 	dml1_rq_dlg_get_dlg_params(
 			dml,
 			dlg_regs,
 			ttu_regs,
-			&rq_param.dlg,
-			&dlg_sys_param,
-			&input,
+			&rq_param->dlg,
+			dlg_sys_param,
+			input,
 			true,
 			true,
 			v->pte_enable == dcn_bw_yes,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 45a6216dfa2a..4dca14b598dd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -366,6 +366,9 @@ struct pipe_ctx {
 	struct _vcs_dpi_display_ttu_regs_st ttu_regs;
 	struct _vcs_dpi_display_rq_regs_st rq_regs;
 	struct _vcs_dpi_display_pipe_dest_params_st pipe_dlg_param;
+	struct _vcs_dpi_display_rq_params_st dml_rq_param;
+	struct _vcs_dpi_display_dlg_sys_params_st dml_dlg_sys_param;
+	struct _vcs_dpi_display_e2e_pipe_params_st dml_input;
 	int det_buffer_size_kb;
 	bool unbounded_req;
 #endif
-- 
2.33.0

