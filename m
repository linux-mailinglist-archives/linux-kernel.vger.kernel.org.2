Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAAF404282
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348932AbhIIBBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:01:42 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:24800
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233710AbhIIBBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:01:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLZiSXRuDrt7XZiZaGkiRnd0YXACYKIkzAPihrvVgagzXblC0O8f776SUKQlADh/M7d3Aal8sJW4+WRAqUK5Xd8Vzg2LYVsfsz+s55EHPpVXQ8OwbjrmBSlPtXyV8B9q0M9hGigSHGqbtwvJlvYHq1UK8B1aicyNW/FABOdpoQwxiGsxmIf3mwQbhCvUUwThfpsV8GYa8dO0u95SRz2/Rz4acdz4tbcYd2cGjKRHzRW7I3C/pwVaHdYsMspME5WaWGEpMLVWqzkTMKtUxnZKum/OQJHHuJyzW+OF+TNAFkTYW8i7flL5o7DrVjr5PL8YvLuYj16pP3XLJ1YWy3t+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TBWlUue0C2yf7StU+5y0DR+zAQBsCLOMdAZXi85ksVI=;
 b=gNWkErdRTxfvlWkeHE0+q2BAgW4uH8XwAD74SuzojhoRPC4XORolI5viK3RWERqXw/itN2spQ2+kgjMDAboucjkzT4Rh58jv1OYRrRwm550NOR1fPAY3LMiO6C2dAfZ2RrpjoTi/hQBfyl+Mb2e8KB46aW7r61V8k8S+ohdK8XuOHJ4iraZx59xomrGe7IM8Srl3GIIyIfw2sszwVGZnyMaYq78OWgyjJ1jpiEkyNVdul5JE1uCONCUmEx/48ej67KJilWFDKCgbT1RevbL+XsKVHotzk/FIWXaY4Cb2XcliPWx7tjEf1qwnGYDlTIHvubmuuhTsf8ZaC81CmyMAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBWlUue0C2yf7StU+5y0DR+zAQBsCLOMdAZXi85ksVI=;
 b=Cw+1NlEKuIvpS8s1tnYY79NezEoK3dSSV0GJyf2AFgXy1SM996Fb3psKHkrCEz/GlmHQlREKGRMtL7GX5MiA/cjPMuwVOhNlBPUJQ3jj0V2r/XcZ5NpOEl3c8n3rFJsCh2DguJdV4gSEmzSVYFMDLsqpAR9KRgCqBMe0Jqf8rRc=
Received: from CO2PR04CA0112.namprd04.prod.outlook.com (2603:10b6:104:7::14)
 by DM5PR12MB1721.namprd12.prod.outlook.com (2603:10b6:3:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 01:00:29 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::d8) by CO2PR04CA0112.outlook.office365.com
 (2603:10b6:104:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 01:00:28 +0000
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
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 01:00:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 20:00:27 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Wed, 8 Sep 2021 20:00:26 -0500
From:   Harry Wentland <harry.wentland@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <ndesaulniers@google.com>, <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <arnd@kernel.org>,
        <sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>,
        <nathan@kernel.org>, <linux@roeck-us.net>, <llvm@lists.linux.dev>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 1/4] drm/amd/display: Pass display_pipe_params_st as const in DML
Date:   Wed, 8 Sep 2021 21:00:20 -0400
Message-ID: <20210909010023.29110-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909010023.29110-1-harry.wentland@amd.com>
References: <20210909010023.29110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ccdef04-9028-4f55-4ef2-08d9732d372c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1721E7CB212C506A4C52420E8CD59@DM5PR12MB1721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVTpL3+D3w/9BpLli5c/U89Q2UP+zbx7ihjQwBUrNJ8C0KYTuoxviJxIGzX7wOHBzmV5uL6NpeLe8bhWom9ouzeRuzAqr4OjhbHwUtN2ILZoOZlTQVEjDJfMemcbXU/Wp+0lYxiDk/mmSCEneF17OM+jiJg1Fl3Z93jIPrIWHZEb6qFTFsdjIc9qPWeeUY96hjWDFmCV6DbNYCYmYYF/mSEvEwba1ZdF41Z58awg05Wbk0QnaGKulaf/jdx/9qAnH2bXT3NnSmZy84xz2eZW44kS8ZxjJz7LdkpOspmi5/q07x93EwHujw3BV3iYVjHpRyGrGp+ijUC4dBHNboGRAAJJNDe0WnYx9D8lEHyBAyMh6PjIgMAVwKo52QY+BfcsxhTQV8+zx1elOfJciba7RvinIy/lp7mqMFHGNIj46771TaDP2Fh2V3Y2u8anTUAIEptJ4OtU5wH6V8DMuM9nWcZ8bjv5zMb4jYHY8a7I0OJXX1lNDEmGHcSKmb2j4SrlUz5Hrq0yI1XrllAySBTfXmEGYCgphjOgooXu0jUivDTid5GgTOJowDco4pyw5iNLzlY+0S+oy7zwEUBq0aQ4lxzMijLK6qVdxfM9idBkGTgiyyX44RlWO4bkkZQV2cYL2D8dYD5ei3uPLfmXm7LDkn8xoFRwF73sReX+VfgRLDxI0A5SYTlZKa16sTN5nvi00Wa2RMDmxmJIYe+cH1i0ceFGkfsG13aQBanLCqzQXjI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(4326008)(47076005)(356005)(36756003)(30864003)(44832011)(81166007)(82310400003)(26005)(2616005)(8676002)(5660300002)(6916009)(8936002)(36860700001)(316002)(6666004)(54906003)(186003)(2906002)(66574015)(82740400003)(83380400001)(86362001)(7696005)(336012)(70586007)(478600001)(426003)(70206006)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 01:00:28.4300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccdef04-9028-4f55-4ef2-08d9732d372c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
This neither needs to be on the stack nor passed by value
to each function call. In fact, when building with clang
it seems to break the Linux's default 1024 byte stack
frame limit.

[How]
We can simply pass this as a const pointer.

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
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  6 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.h     |  4 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  6 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h   |  4 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     | 62 ++++++++--------
 .../dc/dml/dcn21/display_rq_dlg_calc_21.h     |  4 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     | 72 +++++++++----------
 .../dc/dml/dcn30/display_rq_dlg_calc_30.h     |  4 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 68 +++++++++---------
 .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |  4 +-
 .../drm/amd/display/dc/dml/display_mode_lib.h |  4 +-
 12 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e3e01b17c164..4389b36f0760 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3152,7 +3152,7 @@ void dcn20_calculate_dlg_params(
 
 		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg(&context->bw_ctx.dml,
 				&context->res_ctx.pipe_ctx[i].rq_regs,
-				pipes[pipe_idx].pipe);
+				&pipes[pipe_idx].pipe);
 		pipe_idx++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 2091dd8c252d..8c168f348a27 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -768,12 +768,12 @@ static void dml20_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 
 void dml20_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param)
+		const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = {0};
 
 	memset(rq_regs, 0, sizeof(*rq_regs));
-	dml20_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param.src);
+	dml20_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param->src);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
 	print__rq_regs_st(mode_lib, *rq_regs);
@@ -1549,7 +1549,7 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 void dml20_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
index d0b90947f540..8b23867e97c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
@@ -43,7 +43,7 @@ struct display_mode_lib;
 void dml20_rq_dlg_get_rq_reg(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 
 // Function: dml_rq_dlg_get_dlg_reg
@@ -61,7 +61,7 @@ void dml20_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 1a0c14e465fa..26ececfd40cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -768,12 +768,12 @@ static void dml20v2_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 
 void dml20v2_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param)
+		const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = {0};
 
 	memset(rq_regs, 0, sizeof(*rq_regs));
-	dml20v2_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param.src);
+	dml20v2_rq_dlg_get_rq_params(mode_lib, &rq_param, pipe_param->src);
 	extract_rq_regs(mode_lib, rq_regs, rq_param);
 
 	print__rq_regs_st(mode_lib, *rq_regs);
@@ -1550,7 +1550,7 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 void dml20v2_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
index 27cf8bed9376..2b4e46ea1c3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
@@ -43,7 +43,7 @@ struct display_mode_lib;
 void dml20v2_rq_dlg_get_rq_reg(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 
 // Function: dml_rq_dlg_get_dlg_reg
@@ -61,7 +61,7 @@ void dml20v2_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 287e31052b30..736978c4d40a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -694,7 +694,7 @@ static void get_surf_rq_param(
 		display_data_rq_sizing_params_st *rq_sizing_param,
 		display_data_rq_dlg_params_st *rq_dlg_param,
 		display_data_rq_misc_params_st *rq_misc_param,
-		const display_pipe_params_st pipe_param,
+		const display_pipe_params_st *pipe_param,
 		bool is_chroma)
 {
 	bool mode_422 = false;
@@ -706,30 +706,30 @@ static void get_surf_rq_param(
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma) {
-		vp_width = pipe_param.src.viewport_width_c / ppe;
-		vp_height = pipe_param.src.viewport_height_c;
-		data_pitch = pipe_param.src.data_pitch_c;
-		meta_pitch = pipe_param.src.meta_pitch_c;
+		vp_width = pipe_param->src.viewport_width_c / ppe;
+		vp_height = pipe_param->src.viewport_height_c;
+		data_pitch = pipe_param->src.data_pitch_c;
+		meta_pitch = pipe_param->src.meta_pitch_c;
 	} else {
-		vp_width = pipe_param.src.viewport_width / ppe;
-		vp_height = pipe_param.src.viewport_height;
-		data_pitch = pipe_param.src.data_pitch;
-		meta_pitch = pipe_param.src.meta_pitch;
+		vp_width = pipe_param->src.viewport_width / ppe;
+		vp_height = pipe_param->src.viewport_height;
+		data_pitch = pipe_param->src.data_pitch;
+		meta_pitch = pipe_param->src.meta_pitch;
 	}
 
-	if (pipe_param.dest.odm_combine) {
+	if (pipe_param->dest.odm_combine) {
 		unsigned int access_dir;
 		unsigned int full_src_vp_width;
 		unsigned int hactive_half;
 		unsigned int src_hactive_half;
-		access_dir = (pipe_param.src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
-		hactive_half  = pipe_param.dest.hactive / 2;
+		access_dir = (pipe_param->src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
+		hactive_half  = pipe_param->dest.hactive / 2;
 		if (is_chroma) {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio_c * pipe_param.dest.full_recout_width;
-			src_hactive_half  = pipe_param.scale_ratio_depth.hscl_ratio_c * hactive_half;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio_c * pipe_param->dest.full_recout_width;
+			src_hactive_half  = pipe_param->scale_ratio_depth.hscl_ratio_c * hactive_half;
 		} else {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio * pipe_param.dest.full_recout_width;
-			src_hactive_half  = pipe_param.scale_ratio_depth.hscl_ratio * hactive_half;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio * pipe_param->dest.full_recout_width;
+			src_hactive_half  = pipe_param->scale_ratio_depth.hscl_ratio * hactive_half;
 		}
 
 		if (access_dir == 0) {
@@ -754,7 +754,7 @@ static void get_surf_rq_param(
 	rq_sizing_param->meta_chunk_bytes = 2048;
 	rq_sizing_param->min_meta_chunk_bytes = 256;
 
-	if (pipe_param.src.hostvm)
+	if (pipe_param->src.hostvm)
 		rq_sizing_param->mpte_group_bytes = 512;
 	else
 		rq_sizing_param->mpte_group_bytes = 2048;
@@ -768,23 +768,23 @@ static void get_surf_rq_param(
 			vp_height,
 			data_pitch,
 			meta_pitch,
-			pipe_param.src.source_format,
-			pipe_param.src.sw_mode,
-			pipe_param.src.macro_tile_size,
-			pipe_param.src.source_scan,
-			pipe_param.src.hostvm,
+			pipe_param->src.source_format,
+			pipe_param->src.sw_mode,
+			pipe_param->src.macro_tile_size,
+			pipe_param->src.source_scan,
+			pipe_param->src.hostvm,
 			is_chroma);
 }
 
 static void dml_rq_dlg_get_rq_params(
 		struct display_mode_lib *mode_lib,
 		display_rq_params_st *rq_param,
-		const display_pipe_params_st pipe_param)
+		const display_pipe_params_st *pipe_param)
 {
 	// get param for luma surface
-	rq_param->yuv420 = pipe_param.src.source_format == dm_420_8
-			|| pipe_param.src.source_format == dm_420_10;
-	rq_param->yuv420_10bpc = pipe_param.src.source_format == dm_420_10;
+	rq_param->yuv420 = pipe_param->src.source_format == dm_420_8
+			|| pipe_param->src.source_format == dm_420_10;
+	rq_param->yuv420_10bpc = pipe_param->src.source_format == dm_420_10;
 
 	get_surf_rq_param(
 			mode_lib,
@@ -794,7 +794,7 @@ static void dml_rq_dlg_get_rq_params(
 			pipe_param,
 			0);
 
-	if (is_dual_plane((enum source_format_class) (pipe_param.src.source_format))) {
+	if (is_dual_plane((enum source_format_class) (pipe_param->src.source_format))) {
 		// get param for chroma surface
 		get_surf_rq_param(
 				mode_lib,
@@ -806,14 +806,14 @@ static void dml_rq_dlg_get_rq_params(
 	}
 
 	// calculate how to split the det buffer space between luma and chroma
-	handle_det_buf_split(mode_lib, rq_param, pipe_param.src);
+	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
 	print__rq_params_st(mode_lib, *rq_param);
 }
 
 void dml21_rq_dlg_get_rq_reg(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param)
+		const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = {0};
 
@@ -1658,7 +1658,7 @@ void dml21_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
@@ -1696,7 +1696,7 @@ void dml21_rq_dlg_get_dlg_reg(
 	// system parameter calculation done
 
 	dml_print("DML_DLG: Calculation for pipe[%d] start\n\n", pipe_idx);
-	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, e2e_pipe_param[pipe_idx].pipe);
+	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, &e2e_pipe_param[pipe_idx].pipe);
 	dml_rq_dlg_get_dlg_params(
 			mode_lib,
 			e2e_pipe_param,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
index e8f7785e3fc6..af6ad0ca9cf8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
@@ -44,7 +44,7 @@ struct display_mode_lib;
 void dml21_rq_dlg_get_rq_reg(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 // Function: dml_rq_dlg_get_dlg_reg
 //   Calculate and return DLG and TTU register struct given the system setting
@@ -61,7 +61,7 @@ void dml21_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 0d934fae1c3a..2120e0941a09 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -747,7 +747,7 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 	display_data_rq_sizing_params_st *rq_sizing_param,
 	display_data_rq_dlg_params_st *rq_dlg_param,
 	display_data_rq_misc_params_st *rq_misc_param,
-	const display_pipe_params_st pipe_param,
+	const display_pipe_params_st *pipe_param,
 	bool is_chroma,
 	bool is_alpha)
 {
@@ -761,32 +761,32 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma | is_alpha) {
-		vp_width = pipe_param.src.viewport_width_c / ppe;
-		vp_height = pipe_param.src.viewport_height_c;
-		data_pitch = pipe_param.src.data_pitch_c;
-		meta_pitch = pipe_param.src.meta_pitch_c;
-		surface_height = pipe_param.src.surface_height_y / 2.0;
+		vp_width = pipe_param->src.viewport_width_c / ppe;
+		vp_height = pipe_param->src.viewport_height_c;
+		data_pitch = pipe_param->src.data_pitch_c;
+		meta_pitch = pipe_param->src.meta_pitch_c;
+		surface_height = pipe_param->src.surface_height_y / 2.0;
 	} else {
-		vp_width = pipe_param.src.viewport_width / ppe;
-		vp_height = pipe_param.src.viewport_height;
-		data_pitch = pipe_param.src.data_pitch;
-		meta_pitch = pipe_param.src.meta_pitch;
-		surface_height = pipe_param.src.surface_height_y;
+		vp_width = pipe_param->src.viewport_width / ppe;
+		vp_height = pipe_param->src.viewport_height;
+		data_pitch = pipe_param->src.data_pitch;
+		meta_pitch = pipe_param->src.meta_pitch;
+		surface_height = pipe_param->src.surface_height_y;
 	}
 
-	if (pipe_param.dest.odm_combine) {
+	if (pipe_param->dest.odm_combine) {
 		unsigned int access_dir = 0;
 		unsigned int full_src_vp_width = 0;
 		unsigned int hactive_odm = 0;
 		unsigned int src_hactive_odm = 0;
-		access_dir = (pipe_param.src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
-		hactive_odm  = pipe_param.dest.hactive / ((unsigned int)pipe_param.dest.odm_combine*2);
+		access_dir = (pipe_param->src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
+		hactive_odm  = pipe_param->dest.hactive / ((unsigned int) pipe_param->dest.odm_combine*2);
 		if (is_chroma) {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio_c * pipe_param.dest.full_recout_width;
-			src_hactive_odm  = pipe_param.scale_ratio_depth.hscl_ratio_c * hactive_odm;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio_c * pipe_param->dest.full_recout_width;
+			src_hactive_odm  = pipe_param->scale_ratio_depth.hscl_ratio_c * hactive_odm;
 		} else {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio * pipe_param.dest.full_recout_width;
-			src_hactive_odm  = pipe_param.scale_ratio_depth.hscl_ratio * hactive_odm;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio * pipe_param->dest.full_recout_width;
+			src_hactive_odm  = pipe_param->scale_ratio_depth.hscl_ratio * hactive_odm;
 		}
 
 		if (access_dir == 0) {
@@ -815,7 +815,7 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 	rq_sizing_param->meta_chunk_bytes = 2048;
 	rq_sizing_param->min_meta_chunk_bytes = 256;
 
-	if (pipe_param.src.hostvm)
+	if (pipe_param->src.hostvm)
 		rq_sizing_param->mpte_group_bytes = 512;
 	else
 		rq_sizing_param->mpte_group_bytes = 2048;
@@ -828,28 +828,28 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 		vp_height,
 		data_pitch,
 		meta_pitch,
-		pipe_param.src.source_format,
-		pipe_param.src.sw_mode,
-		pipe_param.src.macro_tile_size,
-		pipe_param.src.source_scan,
-		pipe_param.src.hostvm,
+		pipe_param->src.source_format,
+		pipe_param->src.sw_mode,
+		pipe_param->src.macro_tile_size,
+		pipe_param->src.source_scan,
+		pipe_param->src.hostvm,
 		is_chroma,
 		surface_height);
 }
 
 static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 	display_rq_params_st *rq_param,
-	const display_pipe_params_st pipe_param)
+	const display_pipe_params_st *pipe_param)
 {
 	// get param for luma surface
-	rq_param->yuv420 = pipe_param.src.source_format == dm_420_8
-	|| pipe_param.src.source_format == dm_420_10
-	|| pipe_param.src.source_format == dm_rgbe_alpha
-	|| pipe_param.src.source_format == dm_420_12;
+	rq_param->yuv420 = pipe_param->src.source_format == dm_420_8
+	|| pipe_param->src.source_format == dm_420_10
+	|| pipe_param->src.source_format == dm_rgbe_alpha
+	|| pipe_param->src.source_format == dm_420_12;
 
-	rq_param->yuv420_10bpc = pipe_param.src.source_format == dm_420_10;
+	rq_param->yuv420_10bpc = pipe_param->src.source_format == dm_420_10;
 
-	rq_param->rgbe_alpha = (pipe_param.src.source_format == dm_rgbe_alpha)?1:0;
+	rq_param->rgbe_alpha = (pipe_param->src.source_format == dm_rgbe_alpha)?1:0;
 
 	get_surf_rq_param(mode_lib,
 		&(rq_param->sizing.rq_l),
@@ -859,7 +859,7 @@ static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 		0,
 		0);
 
-	if (is_dual_plane((enum source_format_class)(pipe_param.src.source_format))) {
+	if (is_dual_plane((enum source_format_class)(pipe_param->src.source_format))) {
 		// get param for chroma surface
 		get_surf_rq_param(mode_lib,
 			&(rq_param->sizing.rq_c),
@@ -871,13 +871,13 @@ static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib,
 	}
 
 	// calculate how to split the det buffer space between luma and chroma
-	handle_det_buf_split(mode_lib, rq_param, pipe_param.src);
+	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
 	print__rq_params_st(mode_lib, *rq_param);
 }
 
 void dml30_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 	display_rq_regs_st *rq_regs,
-	const display_pipe_params_st pipe_param)
+	const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = { 0 };
 
@@ -1831,7 +1831,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	display_dlg_regs_st *dlg_regs,
 	display_ttu_regs_st *ttu_regs,
-	display_e2e_pipe_params_st *e2e_pipe_param,
+	const display_e2e_pipe_params_st *e2e_pipe_param,
 	const unsigned int num_pipes,
 	const unsigned int pipe_idx,
 	const bool cstate_en,
@@ -1866,7 +1866,7 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	// system parameter calculation done
 
 	dml_print("DML_DLG: Calculation for pipe[%d] start\n\n", pipe_idx);
-	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, e2e_pipe_param[pipe_idx].pipe);
+	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, &e2e_pipe_param[pipe_idx].pipe);
 	dml_rq_dlg_get_dlg_params(mode_lib,
 		e2e_pipe_param,
 		num_pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
index c04965cceff3..625e41f8d575 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
@@ -41,7 +41,7 @@ struct display_mode_lib;
 //            See also: <display_rq_regs_st>
 void dml30_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 // Function: dml_rq_dlg_get_dlg_reg
 //   Calculate and return DLG and TTU register struct given the system setting
@@ -57,7 +57,7 @@ void dml30_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib             *mode_lib,
 		display_dlg_regs_st          *dlg_regs,
 		display_ttu_regs_st          *ttu_regs,
-		display_e2e_pipe_params_st   *e2e_pipe_param,
+		const display_e2e_pipe_params_st   *e2e_pipe_param,
 		const unsigned int            num_pipes,
 		const unsigned int            pipe_idx,
 		const bool                    cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index c23905bc733a..57bd4e3f8a82 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -738,7 +738,7 @@ static void get_surf_rq_param(
 		display_data_rq_sizing_params_st *rq_sizing_param,
 		display_data_rq_dlg_params_st *rq_dlg_param,
 		display_data_rq_misc_params_st *rq_misc_param,
-		const display_pipe_params_st pipe_param,
+		const display_pipe_params_st *pipe_param,
 		bool is_chroma,
 		bool is_alpha)
 {
@@ -752,33 +752,33 @@ static void get_surf_rq_param(
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma | is_alpha) {
-		vp_width = pipe_param.src.viewport_width_c / ppe;
-		vp_height = pipe_param.src.viewport_height_c;
-		data_pitch = pipe_param.src.data_pitch_c;
-		meta_pitch = pipe_param.src.meta_pitch_c;
-		surface_height = pipe_param.src.surface_height_y / 2.0;
+		vp_width = pipe_param->src.viewport_width_c / ppe;
+		vp_height = pipe_param->src.viewport_height_c;
+		data_pitch = pipe_param->src.data_pitch_c;
+		meta_pitch = pipe_param->src.meta_pitch_c;
+		surface_height = pipe_param->src.surface_height_y / 2.0;
 	} else {
-		vp_width = pipe_param.src.viewport_width / ppe;
-		vp_height = pipe_param.src.viewport_height;
-		data_pitch = pipe_param.src.data_pitch;
-		meta_pitch = pipe_param.src.meta_pitch;
-		surface_height = pipe_param.src.surface_height_y;
+		vp_width = pipe_param->src.viewport_width / ppe;
+		vp_height = pipe_param->src.viewport_height;
+		data_pitch = pipe_param->src.data_pitch;
+		meta_pitch = pipe_param->src.meta_pitch;
+		surface_height = pipe_param->src.surface_height_y;
 	}
 
-	if (pipe_param.dest.odm_combine) {
+	if (pipe_param->dest.odm_combine) {
 		unsigned int access_dir;
 		unsigned int full_src_vp_width;
 		unsigned int hactive_odm;
 		unsigned int src_hactive_odm;
 
-		access_dir = (pipe_param.src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
-		hactive_odm = pipe_param.dest.hactive / ((unsigned int) pipe_param.dest.odm_combine * 2);
+		access_dir = (pipe_param->src.source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
+		hactive_odm = pipe_param->dest.hactive / ((unsigned int) pipe_param->dest.odm_combine * 2);
 		if (is_chroma) {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio_c * pipe_param.dest.full_recout_width;
-			src_hactive_odm = pipe_param.scale_ratio_depth.hscl_ratio_c * hactive_odm;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio_c * pipe_param->dest.full_recout_width;
+			src_hactive_odm = pipe_param->scale_ratio_depth.hscl_ratio_c * hactive_odm;
 		} else {
-			full_src_vp_width = pipe_param.scale_ratio_depth.hscl_ratio * pipe_param.dest.full_recout_width;
-			src_hactive_odm = pipe_param.scale_ratio_depth.hscl_ratio * hactive_odm;
+			full_src_vp_width = pipe_param->scale_ratio_depth.hscl_ratio * pipe_param->dest.full_recout_width;
+			src_hactive_odm = pipe_param->scale_ratio_depth.hscl_ratio * hactive_odm;
 		}
 
 		if (access_dir == 0) {
@@ -808,7 +808,7 @@ static void get_surf_rq_param(
 	rq_sizing_param->meta_chunk_bytes = 2048;
 	rq_sizing_param->min_meta_chunk_bytes = 256;
 
-	if (pipe_param.src.hostvm)
+	if (pipe_param->src.hostvm)
 		rq_sizing_param->mpte_group_bytes = 512;
 	else
 		rq_sizing_param->mpte_group_bytes = 2048;
@@ -822,38 +822,38 @@ static void get_surf_rq_param(
 			vp_height,
 			data_pitch,
 			meta_pitch,
-			pipe_param.src.source_format,
-			pipe_param.src.sw_mode,
-			pipe_param.src.macro_tile_size,
-			pipe_param.src.source_scan,
-			pipe_param.src.hostvm,
+			pipe_param->src.source_format,
+			pipe_param->src.sw_mode,
+			pipe_param->src.macro_tile_size,
+			pipe_param->src.source_scan,
+			pipe_param->src.hostvm,
 			is_chroma,
 			surface_height);
 }
 
-static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib, display_rq_params_st *rq_param, const display_pipe_params_st pipe_param)
+static void dml_rq_dlg_get_rq_params(struct display_mode_lib *mode_lib, display_rq_params_st *rq_param, const display_pipe_params_st *pipe_param)
 {
 	// get param for luma surface
-	rq_param->yuv420 = pipe_param.src.source_format == dm_420_8 || pipe_param.src.source_format == dm_420_10 || pipe_param.src.source_format == dm_rgbe_alpha
-			|| pipe_param.src.source_format == dm_420_12;
+	rq_param->yuv420 = pipe_param->src.source_format == dm_420_8 || pipe_param->src.source_format == dm_420_10 || pipe_param->src.source_format == dm_rgbe_alpha
+			|| pipe_param->src.source_format == dm_420_12;
 
-	rq_param->yuv420_10bpc = pipe_param.src.source_format == dm_420_10;
+	rq_param->yuv420_10bpc = pipe_param->src.source_format == dm_420_10;
 
-	rq_param->rgbe_alpha = (pipe_param.src.source_format == dm_rgbe_alpha) ? 1 : 0;
+	rq_param->rgbe_alpha = (pipe_param->src.source_format == dm_rgbe_alpha) ? 1 : 0;
 
 	get_surf_rq_param(mode_lib, &(rq_param->sizing.rq_l), &(rq_param->dlg.rq_l), &(rq_param->misc.rq_l), pipe_param, 0, 0);
 
-	if (is_dual_plane((enum source_format_class) (pipe_param.src.source_format))) {
+	if (is_dual_plane((enum source_format_class) (pipe_param->src.source_format))) {
 		// get param for chroma surface
 		get_surf_rq_param(mode_lib, &(rq_param->sizing.rq_c), &(rq_param->dlg.rq_c), &(rq_param->misc.rq_c), pipe_param, 1, rq_param->rgbe_alpha);
 	}
 
 	// calculate how to split the det buffer space between luma and chroma
-	handle_det_buf_split(mode_lib, rq_param, pipe_param.src);
+	handle_det_buf_split(mode_lib, rq_param, pipe_param->src);
 	print__rq_params_st(mode_lib, *rq_param);
 }
 
-void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib, display_rq_regs_st *rq_regs, const display_pipe_params_st pipe_param)
+void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib, display_rq_regs_st *rq_regs, const display_pipe_params_st *pipe_param)
 {
 	display_rq_params_st rq_param = {0};
 
@@ -1677,7 +1677,7 @@ void dml31_rq_dlg_get_dlg_reg(
 		struct display_mode_lib *mode_lib,
 		display_dlg_regs_st *dlg_regs,
 		display_ttu_regs_st *ttu_regs,
-		display_e2e_pipe_params_st *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int num_pipes,
 		const unsigned int pipe_idx,
 		const bool cstate_en,
@@ -1704,7 +1704,7 @@ void dml31_rq_dlg_get_dlg_reg(
 	// system parameter calculation done
 
 	dml_print("DML_DLG: Calculation for pipe[%d] start\n\n", pipe_idx);
-	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, e2e_pipe_param[pipe_idx].pipe);
+	dml_rq_dlg_get_rq_params(mode_lib, &rq_param, &e2e_pipe_param[pipe_idx].pipe);
 	dml_rq_dlg_get_dlg_params(
 			mode_lib,
 			e2e_pipe_param,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
index adf8518f761f..8ee991351699 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.h
@@ -41,7 +41,7 @@ struct display_mode_lib;
 //            See also: <display_rq_regs_st>
 void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 
 // Function: dml_rq_dlg_get_dlg_reg
 //   Calculate and return DLG and TTU register struct given the system setting
@@ -57,7 +57,7 @@ void dml31_rq_dlg_get_rq_reg(struct display_mode_lib *mode_lib,
 void dml31_rq_dlg_get_dlg_reg(struct display_mode_lib             *mode_lib,
 		display_dlg_regs_st          *dlg_regs,
 		display_ttu_regs_st          *ttu_regs,
-		display_e2e_pipe_params_st   *e2e_pipe_param,
+		const display_e2e_pipe_params_st *e2e_pipe_param,
 		const unsigned int            num_pipes,
 		const unsigned int            pipe_idx,
 		const bool                    cstate_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
index d42a0aeca6be..72b1957022aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
@@ -49,7 +49,7 @@ struct dml_funcs {
 			struct display_mode_lib *mode_lib,
 			display_dlg_regs_st *dlg_regs,
 			display_ttu_regs_st *ttu_regs,
-			display_e2e_pipe_params_st *e2e_pipe_param,
+			const display_e2e_pipe_params_st *e2e_pipe_param,
 			const unsigned int num_pipes,
 			const unsigned int pipe_idx,
 			const bool cstate_en,
@@ -60,7 +60,7 @@ struct dml_funcs {
 	void (*rq_dlg_get_rq_reg)(
 		struct display_mode_lib *mode_lib,
 		display_rq_regs_st *rq_regs,
-		const display_pipe_params_st pipe_param);
+		const display_pipe_params_st *pipe_param);
 	void (*recalculate)(struct display_mode_lib *mode_lib);
 	void (*validate)(struct display_mode_lib *mode_lib);
 };
-- 
2.33.0

