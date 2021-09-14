Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552EE40B997
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhINVGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:06:36 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:15713
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233856AbhINVGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:06:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrNkvBJCdw0He6K/wAgkIVlaBRrOx09tPTbxI48u8SNaBIZ/O/B6tQi0mcnQhNf7Fd6FJgo2XmEKU+u1gCUmrVSxdnlXeYTSlXlJwSKWjxkC+yeQdNw7B96eK9QpBnuvuMXX3Sqhitm2kp4dnbrOyVYK4gMIFG8p45CyFQMu8FxH4vXJjl2n8tfqdUuT+HEbuQEuOeL9s780eJWJhJwrFs04sAaiHLfOE4NhTch2tIGTh2ijZI1QapDC7fHeo4icM/f0D5TTKiLckyhleBUouPzWljvvoZK8ELqvz/SmFZCyapP8u6tvMObI7P8wcBSDD8LGubbFp5iUXuiqt1lIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rpmbGee9oQ1wKoWYjZVyE6ai4Us21mxZP6EPdymzUHI=;
 b=B+N/0mX1WiEi/N1ny67Bd+i9Q1UZqcKgQ8fNKKc+2nEmTb9X8MHefzW6MaW0m8f9Hu7J7laVQg/8IQ5HUUBDpE5cG5ovHF4GbFG77FPnONe9dRXvv7nLYZyxnxtriBFM8sT8fpvklerFJ4yAMfcpvPUK6AnH9Z1o3MRLbchbOi6cwdYj1yKDX0BRkaMQrCCGbaRe44U7s5FmPwc1AFCb4pDw9CGoM0f8T4ZcmjoPT+67sAS3q/CnbbKTcXTFwqTdlQakPkdP5f+MZ3K3DiA/xqt8hWqyBhQvSYigFe8VxSd/LXOVtIGu2FondSgq2ifNHKCAFWqoWn/NuPx/55UAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpmbGee9oQ1wKoWYjZVyE6ai4Us21mxZP6EPdymzUHI=;
 b=fXENfJu534dQRv3ACy3Awjbz1ZJ7VhTLy7AvfUnormq3di/CND24leSjSdLW+wA1tDxBz9YZ0fFO5G9ROmsZco49zdcAAgQMQ0hUh45I8L/xs/p5EMe+xM2rz+5Am4u3RPFb1dp7j/V5gGYpHFSYkEu2XWQDniaK3RYZx0N+XU4=
Received: from CO1PR15CA0060.namprd15.prod.outlook.com (2603:10b6:101:1f::28)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 21:05:14 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::24) by CO1PR15CA0060.outlook.office365.com
 (2603:10b6:101:1f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 14 Sep 2021 21:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:05:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 16:05:12 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 14 Sep 2021 16:05:11 -0500
From:   Harry Wentland <harry.wentland@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <ndesaulniers@google.com>, <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <arnd@kernel.org>,
        <sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>,
        <nathan@kernel.org>, <linux@roeck-us.net>, <llvm@lists.linux.dev>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Reduce stack size for dml21_ModeSupportAndSystemConfigurationFull
Date:   Tue, 14 Sep 2021 17:05:08 -0400
Message-ID: <20210914210508.10627-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 542e9dfa-aa4d-40b1-6f8e-08d977c358a3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5328:
X-Microsoft-Antispam-PRVS: <DM4PR12MB532829DBF81757CAADE056238CDA9@DM4PR12MB5328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYUD+qq+g/crLT96JbBk1dkTt+pC7JpymV0QCyG5wnHRL/QfLwgCZTOAaGDCVpc6Ou9buTq8OpcKQGA7g0yuicdKVa+g2FE7DJUXY3l1GmmRRoR38VJPnckJ3B4gfyegwyNv7uCilexnCHzlfccmbuMSLvHhOxzQD+pman5Hz85wt3hZGroj69NlQ2A3mEnoZ/66FCqY7O+7MSO7BrcNB72WTVgwqGDMyEiMN969LMvKdkYMTgbDp2ysEZ+/2AQUao8yT8nv2YcyypxUwFyzJq1fd1mmXp5nQXfe7+MkAI9gRdnf07YTvJ6tvYtoaZe6hFyVb3C1pDySEAuAA37nREpT4J7dcs7jhYXYVsm/NO0IPgHdf/N8u+VLQxw0AJPFaYtcAhJwaqcWCN21J/hofGYlx0oWpRPh+OrRtjh4T3C2YZe5zpfjMNLR8VJFh7EsNjkxbD/vT8LyDfprzbs5GIopMysOvjzdZBR4I8BXCmaJIvTGJNo7nfbm0bMjCulOc4cqEHh+wNYRIQbSuPBdttQH+BY9tBrrFGlKKlP8vsVMseFL56tBJ3f1U59/qn0logLO9y65AvfhDZd0RA4I0KBkpyI5hMkI2TEHwoF7MdyofmYM8G0OcMKZU99B7bF8GJ91d3C92Wu4+9Pp/Y6jwG6cSdd3jNjzrzBy/gYhJ2Xe3lDg56jEWz7+Gtv6sztAX4e52Yfa/DTPqyMpz/nvzCTUhdPtMJ9k8HnuNzWfde6SnEg73FKl38nJaiM5xnRMeyRxMwOn/HPjlWqAfHiRaS8ltSxv/pa7xfDaasj3C2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(30864003)(8936002)(86362001)(2906002)(4326008)(186003)(316002)(356005)(478600001)(44832011)(70586007)(19627235002)(1076003)(36756003)(5660300002)(36860700001)(54906003)(336012)(66574015)(6666004)(26005)(82310400003)(81166007)(83380400001)(426003)(82740400003)(6916009)(70206006)(47076005)(2616005)(8676002)(7696005)(213903007)(36900700001)(44824005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:05:13.7450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 542e9dfa-aa4d-40b1-6f8e-08d977c358a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why & How]
With Werror enabled in the kernel we were failing the clang build since
dml21_ModeSupportAndSystemConfigurationFull's stack frame is 1064 when
building with clang, and exceeding the default 1024 stack frame limit.

The culprit seems to be the Pipe struct, so pull the relevant block
out into its own sub-function.

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
 .../dc/dml/dcn21/display_mode_vba_21.c        | 236 +++++++++---------
 1 file changed, 123 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 4136eb8256cb..8a7485e21d53 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -3394,6 +3394,127 @@ static unsigned int TruncToValidBPP(
 	}
 }
 
+
+static noinline void CalculatePrefetchSchedulePerPlane(
+		struct display_mode_lib *mode_lib,
+		int i,
+		unsigned j,
+		unsigned k)
+{
+	struct vba_vars_st *locals = &mode_lib->vba;
+	Pipe myPipe;
+	HostVM myHostVM;
+
+	if (mode_lib->vba.XFCEnabled[k] == true) {
+		mode_lib->vba.XFCRemoteSurfaceFlipDelay =
+				CalculateRemoteSurfaceFlipDelay(
+						mode_lib,
+						mode_lib->vba.VRatio[k],
+						locals->SwathWidthYThisState[k],
+						dml_ceil(locals->BytePerPixelInDETY[k], 1.0),
+						mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k],
+						mode_lib->vba.XFCTSlvVupdateOffset,
+						mode_lib->vba.XFCTSlvVupdateWidth,
+						mode_lib->vba.XFCTSlvVreadyOffset,
+						mode_lib->vba.XFCXBUFLatencyTolerance,
+						mode_lib->vba.XFCFillBWOverhead,
+						mode_lib->vba.XFCSlvChunkSize,
+						mode_lib->vba.XFCBusTransportTime,
+						mode_lib->vba.TimeCalc,
+						mode_lib->vba.TWait,
+						&mode_lib->vba.SrcActiveDrainRate,
+						&mode_lib->vba.TInitXFill,
+						&mode_lib->vba.TslvChk);
+	} else {
+		mode_lib->vba.XFCRemoteSurfaceFlipDelay = 0.0;
+	}
+
+	myPipe.DPPCLK = locals->RequiredDPPCLK[i][j][k];
+	myPipe.DISPCLK = locals->RequiredDISPCLK[i][j];
+	myPipe.PixelClock = mode_lib->vba.PixelClock[k];
+	myPipe.DCFCLKDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[0][0];
+	myPipe.DPPPerPlane = locals->NoOfDPP[i][j][k];
+	myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
+	myPipe.SourceScan = mode_lib->vba.SourceScan[k];
+	myPipe.BlockWidth256BytesY = locals->Read256BlockWidthY[k];
+	myPipe.BlockHeight256BytesY = locals->Read256BlockHeightY[k];
+	myPipe.BlockWidth256BytesC = locals->Read256BlockWidthC[k];
+	myPipe.BlockHeight256BytesC = locals->Read256BlockHeightC[k];
+	myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
+	myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
+	myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
+	myPipe.HTotal = mode_lib->vba.HTotal[k];
+
+
+	myHostVM.Enable = mode_lib->vba.HostVMEnable;
+	myHostVM.MaxPageTableLevels = mode_lib->vba.HostVMMaxPageTableLevels;
+	myHostVM.CachedPageTableLevels = mode_lib->vba.HostVMCachedPageTableLevels;
+
+
+	mode_lib->vba.IsErrorResult[i][j][k] = CalculatePrefetchSchedule(
+			mode_lib,
+			mode_lib->vba.PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
+			mode_lib->vba.PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
+			&myPipe,
+			locals->DSCDelayPerState[i][k],
+			mode_lib->vba.DPPCLKDelaySubtotal,
+			mode_lib->vba.DPPCLKDelaySCL,
+			mode_lib->vba.DPPCLKDelaySCLLBOnly,
+			mode_lib->vba.DPPCLKDelayCNVCFormater,
+			mode_lib->vba.DPPCLKDelayCNVCCursor,
+			mode_lib->vba.DISPCLKDelaySubtotal,
+			locals->SwathWidthYThisState[k] / mode_lib->vba.HRatio[k],
+			mode_lib->vba.OutputFormat[k],
+			mode_lib->vba.MaxInterDCNTileRepeaters,
+			dml_min(mode_lib->vba.MaxVStartup, locals->MaximumVStartup[0][0][k]),
+			locals->MaximumVStartup[0][0][k],
+			mode_lib->vba.GPUVMMaxPageTableLevels,
+			mode_lib->vba.GPUVMEnable,
+			&myHostVM,
+			mode_lib->vba.DynamicMetadataEnable[k],
+			mode_lib->vba.DynamicMetadataLinesBeforeActiveRequired[k],
+			mode_lib->vba.DynamicMetadataTransmittedBytes[k],
+			mode_lib->vba.DCCEnable[k],
+			mode_lib->vba.UrgentLatency,
+			mode_lib->vba.ExtraLatency,
+			mode_lib->vba.TimeCalc,
+			locals->PDEAndMetaPTEBytesPerFrame[0][0][k],
+			locals->MetaRowBytes[0][0][k],
+			locals->DPTEBytesPerRow[0][0][k],
+			locals->PrefetchLinesY[0][0][k],
+			locals->SwathWidthYThisState[k],
+			locals->BytePerPixelInDETY[k],
+			locals->PrefillY[k],
+			locals->MaxNumSwY[k],
+			locals->PrefetchLinesC[0][0][k],
+			locals->BytePerPixelInDETC[k],
+			locals->PrefillC[k],
+			locals->MaxNumSwC[k],
+			locals->SwathHeightYThisState[k],
+			locals->SwathHeightCThisState[k],
+			mode_lib->vba.TWait,
+			mode_lib->vba.XFCEnabled[k],
+			mode_lib->vba.XFCRemoteSurfaceFlipDelay,
+			mode_lib->vba.ProgressiveToInterlaceUnitInOPP,
+			&locals->dst_x_after_scaler,
+			&locals->dst_y_after_scaler,
+			&locals->LineTimesForPrefetch[k],
+			&locals->PrefetchBW[k],
+			&locals->LinesForMetaPTE[k],
+			&locals->LinesForMetaAndDPTERow[k],
+			&locals->VRatioPreY[i][j][k],
+			&locals->VRatioPreC[i][j][k],
+			&locals->RequiredPrefetchPixelDataBWLuma[i][j][k],
+			&locals->RequiredPrefetchPixelDataBWChroma[i][j][k],
+			&locals->VStartupRequiredWhenNotEnoughTimeForDynamicMetadata,
+			&locals->Tno_bw[k],
+			&locals->prefetch_vmrow_bw[k],
+			locals->swath_width_luma_ub,
+			locals->swath_width_chroma_ub,
+			&mode_lib->vba.VUpdateOffsetPix[k],
+			&mode_lib->vba.VUpdateWidthPix[k],
+			&mode_lib->vba.VReadyOffsetPix[k]);
+}
 void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	struct vba_vars_st *locals = &mode_lib->vba;
@@ -4676,120 +4797,9 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						mode_lib->vba.DRAMClockChangeLatency,
 						mode_lib->vba.UrgentLatency,
 						mode_lib->vba.SREnterPlusExitTime);
-				for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-					Pipe myPipe;
-					HostVM myHostVM;
-
-					if (mode_lib->vba.XFCEnabled[k] == true) {
-						mode_lib->vba.XFCRemoteSurfaceFlipDelay =
-								CalculateRemoteSurfaceFlipDelay(
-										mode_lib,
-										mode_lib->vba.VRatio[k],
-										locals->SwathWidthYThisState[k],
-										dml_ceil(locals->BytePerPixelInDETY[k], 1.0),
-										mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k],
-										mode_lib->vba.XFCTSlvVupdateOffset,
-										mode_lib->vba.XFCTSlvVupdateWidth,
-										mode_lib->vba.XFCTSlvVreadyOffset,
-										mode_lib->vba.XFCXBUFLatencyTolerance,
-										mode_lib->vba.XFCFillBWOverhead,
-										mode_lib->vba.XFCSlvChunkSize,
-										mode_lib->vba.XFCBusTransportTime,
-										mode_lib->vba.TimeCalc,
-										mode_lib->vba.TWait,
-										&mode_lib->vba.SrcActiveDrainRate,
-										&mode_lib->vba.TInitXFill,
-										&mode_lib->vba.TslvChk);
-					} else {
-						mode_lib->vba.XFCRemoteSurfaceFlipDelay = 0.0;
-					}
+				for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++)
+					CalculatePrefetchSchedulePerPlane(mode_lib, i, j, k);
 
-					myPipe.DPPCLK = locals->RequiredDPPCLK[i][j][k];
-					myPipe.DISPCLK = locals->RequiredDISPCLK[i][j];
-					myPipe.PixelClock = mode_lib->vba.PixelClock[k];
-					myPipe.DCFCLKDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[0][0];
-					myPipe.DPPPerPlane = locals->NoOfDPP[i][j][k];
-					myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
-					myPipe.SourceScan = mode_lib->vba.SourceScan[k];
-					myPipe.BlockWidth256BytesY = locals->Read256BlockWidthY[k];
-					myPipe.BlockHeight256BytesY = locals->Read256BlockHeightY[k];
-					myPipe.BlockWidth256BytesC = locals->Read256BlockWidthC[k];
-					myPipe.BlockHeight256BytesC = locals->Read256BlockHeightC[k];
-					myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
-					myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
-					myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
-					myPipe.HTotal = mode_lib->vba.HTotal[k];
-
-
-					myHostVM.Enable = mode_lib->vba.HostVMEnable;
-					myHostVM.MaxPageTableLevels = mode_lib->vba.HostVMMaxPageTableLevels;
-					myHostVM.CachedPageTableLevels = mode_lib->vba.HostVMCachedPageTableLevels;
-
-
-					mode_lib->vba.IsErrorResult[i][j][k] = CalculatePrefetchSchedule(
-							mode_lib,
-							mode_lib->vba.PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
-							mode_lib->vba.PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
-							&myPipe,
-							locals->DSCDelayPerState[i][k],
-							mode_lib->vba.DPPCLKDelaySubtotal,
-							mode_lib->vba.DPPCLKDelaySCL,
-							mode_lib->vba.DPPCLKDelaySCLLBOnly,
-							mode_lib->vba.DPPCLKDelayCNVCFormater,
-							mode_lib->vba.DPPCLKDelayCNVCCursor,
-							mode_lib->vba.DISPCLKDelaySubtotal,
-							locals->SwathWidthYThisState[k] / mode_lib->vba.HRatio[k],
-							mode_lib->vba.OutputFormat[k],
-							mode_lib->vba.MaxInterDCNTileRepeaters,
-							dml_min(mode_lib->vba.MaxVStartup, locals->MaximumVStartup[0][0][k]),
-							locals->MaximumVStartup[0][0][k],
-							mode_lib->vba.GPUVMMaxPageTableLevels,
-							mode_lib->vba.GPUVMEnable,
-							&myHostVM,
-							mode_lib->vba.DynamicMetadataEnable[k],
-							mode_lib->vba.DynamicMetadataLinesBeforeActiveRequired[k],
-							mode_lib->vba.DynamicMetadataTransmittedBytes[k],
-							mode_lib->vba.DCCEnable[k],
-							mode_lib->vba.UrgentLatency,
-							mode_lib->vba.ExtraLatency,
-							mode_lib->vba.TimeCalc,
-							locals->PDEAndMetaPTEBytesPerFrame[0][0][k],
-							locals->MetaRowBytes[0][0][k],
-							locals->DPTEBytesPerRow[0][0][k],
-							locals->PrefetchLinesY[0][0][k],
-							locals->SwathWidthYThisState[k],
-							locals->BytePerPixelInDETY[k],
-							locals->PrefillY[k],
-							locals->MaxNumSwY[k],
-							locals->PrefetchLinesC[0][0][k],
-							locals->BytePerPixelInDETC[k],
-							locals->PrefillC[k],
-							locals->MaxNumSwC[k],
-							locals->SwathHeightYThisState[k],
-							locals->SwathHeightCThisState[k],
-							mode_lib->vba.TWait,
-							mode_lib->vba.XFCEnabled[k],
-							mode_lib->vba.XFCRemoteSurfaceFlipDelay,
-							mode_lib->vba.ProgressiveToInterlaceUnitInOPP,
-							&locals->dst_x_after_scaler,
-							&locals->dst_y_after_scaler,
-							&locals->LineTimesForPrefetch[k],
-							&locals->PrefetchBW[k],
-							&locals->LinesForMetaPTE[k],
-							&locals->LinesForMetaAndDPTERow[k],
-							&locals->VRatioPreY[i][j][k],
-							&locals->VRatioPreC[i][j][k],
-							&locals->RequiredPrefetchPixelDataBWLuma[i][j][k],
-							&locals->RequiredPrefetchPixelDataBWChroma[i][j][k],
-							&locals->VStartupRequiredWhenNotEnoughTimeForDynamicMetadata,
-							&locals->Tno_bw[k],
-							&locals->prefetch_vmrow_bw[k],
-							locals->swath_width_luma_ub,
-							locals->swath_width_chroma_ub,
-							&mode_lib->vba.VUpdateOffsetPix[k],
-							&mode_lib->vba.VUpdateWidthPix[k],
-							&mode_lib->vba.VReadyOffsetPix[k]);
-				}
 				mode_lib->vba.MaximumReadBandwidthWithoutPrefetch = 0.0;
 				mode_lib->vba.MaximumReadBandwidthWithPrefetch = 0.0;
 				for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-- 
2.33.0

