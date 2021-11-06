Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1D446F68
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhKFRpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 13:45:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:3118 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhKFRpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 13:45:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10160"; a="232311793"
X-IronPort-AV: E=Sophos;i="5.87,214,1631602800"; 
   d="gz'50?scan'50,208,50";a="232311793"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2021 10:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,214,1631602800"; 
   d="gz'50?scan'50,208,50";a="502383381"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2021 10:42:17 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mjPho-0009T9-Ak; Sat, 06 Nov 2021 17:42:16 +0000
Date:   Sun, 7 Nov 2021 01:41:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3957:6:
 warning: stack frame size (2520) exceeds limit (2048) in
 'dml31_ModeSupportAndSystemConfigurationFull'
Message-ID: <202111070121.4xIDXkc5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fe91c4725aeed35023ba4f7a1e1adfebb6878c23
commit: 8fe44c080a53ac0ccbe88053a2e40f9acca33091 drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN
date:   5 months ago
config: x86_64-randconfig-a003-20211004 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c0039de2953d15815448b4b3c3bafb45607781e0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fe44c080a53ac0ccbe88053a2e40f9acca33091
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8fe44c080a53ac0ccbe88053a2e40f9acca33091
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3957:6: warning: stack frame size (2520) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than]
   void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        ^
   1 warning generated.


vim +/dml31_ModeSupportAndSystemConfigurationFull +3957 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c

74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3956  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19 @3957  void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3958  {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3959  	struct vba_vars_st *v = &mode_lib->vba;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3960  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3961  	int i, j;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3962  	unsigned int k, m;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3963  	int ReorderingBytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3964  	int MinPrefetchMode = 0, MaxPrefetchMode = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3965  	bool NoChroma = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3966  	bool EnoughWritebackUnits = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3967  	bool P2IWith420 = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3968  	bool DSCOnlyIfNecessaryWithBPP = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3969  	bool DSC422NativeNotSupported = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3970  	double MaxTotalVActiveRDBandwidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3971  	bool ViewportExceedsSurface = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3972  	bool FMTBufferExceeded = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3973  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3974  	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3975  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3976  	CalculateMinAndMaxPrefetchMode(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3977  		mode_lib->vba.AllowDRAMSelfRefreshOrDRAMClockChangeInVblank,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3978  		&MinPrefetchMode, &MaxPrefetchMode);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3979  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3980  	/*Scale Ratio, taps Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3981  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3982  	v->ScaleRatioAndTapsSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3983  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3984  		if (v->ScalerEnabled[k] == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3985  				&& ((v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3986  						&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_mono_16
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3987  						&& v->SourcePixelFormat[k] != dm_mono_8 && v->SourcePixelFormat[k] != dm_rgbe
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3988  						&& v->SourcePixelFormat[k] != dm_rgbe_alpha) || v->HRatio[k] != 1.0 || v->htaps[k] != 1.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3989  						|| v->VRatio[k] != 1.0 || v->vtaps[k] != 1.0)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3990  			v->ScaleRatioAndTapsSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3991  		} else if (v->vtaps[k] < 1.0 || v->vtaps[k] > 8.0 || v->htaps[k] < 1.0 || v->htaps[k] > 8.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3992  				|| (v->htaps[k] > 1.0 && (v->htaps[k] % 2) == 1) || v->HRatio[k] > v->MaxHSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3993  				|| v->VRatio[k] > v->MaxVSCLRatio || v->HRatio[k] > v->htaps[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3994  				|| v->VRatio[k] > v->vtaps[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3995  				|| (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3996  						&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_mono_16
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3997  						&& v->SourcePixelFormat[k] != dm_mono_8 && v->SourcePixelFormat[k] != dm_rgbe
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3998  						&& (v->VTAPsChroma[k] < 1 || v->VTAPsChroma[k] > 8 || v->HTAPsChroma[k] < 1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3999  								|| v->HTAPsChroma[k] > 8 || (v->HTAPsChroma[k] > 1 && v->HTAPsChroma[k] % 2 == 1)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4000  								|| v->HRatioChroma[k] > v->MaxHSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4001  								|| v->VRatioChroma[k] > v->MaxVSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4002  								|| v->HRatioChroma[k] > v->HTAPsChroma[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4003  								|| v->VRatioChroma[k] > v->VTAPsChroma[k]))) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4004  			v->ScaleRatioAndTapsSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4005  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4006  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4007  	/*Source Format, Pixel Format and Scan Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4008  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4009  	v->SourceFormatPixelAndScanSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4010  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4011  		if ((v->SurfaceTiling[k] == dm_sw_linear && (!(v->SourceScan[k] != dm_vert) || v->DCCEnable[k] == true))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4012  				|| ((v->SurfaceTiling[k] == dm_sw_64kb_d || v->SurfaceTiling[k] == dm_sw_64kb_d_t
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4013  						|| v->SurfaceTiling[k] == dm_sw_64kb_d_x) && !(v->SourcePixelFormat[k] == dm_444_64))) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4014  			v->SourceFormatPixelAndScanSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4015  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4016  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4017  	/*Bandwidth Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4018  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4019  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4020  		CalculateBytePerPixelAnd256BBlockSizes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4021  				v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4022  				v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4023  				&v->BytePerPixelY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4024  				&v->BytePerPixelC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4025  				&v->BytePerPixelInDETY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4026  				&v->BytePerPixelInDETC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4027  				&v->Read256BlockHeightY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4028  				&v->Read256BlockHeightC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4029  				&v->Read256BlockWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4030  				&v->Read256BlockWidthC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4031  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4032  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4033  		if (v->SourceScan[k] != dm_vert) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4034  			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4035  			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4036  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4037  			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4038  			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4039  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4040  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4041  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4042  		v->ReadBandwidthLuma[k] = v->SwathWidthYSingleDPP[k] * dml_ceil(v->BytePerPixelInDETY[k], 1.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4043  				/ (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4044  		v->ReadBandwidthChroma[k] = v->SwathWidthYSingleDPP[k] / 2 * dml_ceil(v->BytePerPixelInDETC[k], 2.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4045  				/ (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k] / 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4046  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4047  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4048  		if (v->WritebackEnable[k] == true && v->WritebackPixelFormat[k] == dm_444_64) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4049  			v->WriteBandwidth[k] = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4050  					/ (v->WritebackSourceHeight[k] * v->HTotal[k] / v->PixelClock[k]) * 8.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4051  		} else if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4052  			v->WriteBandwidth[k] = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4053  					/ (v->WritebackSourceHeight[k] * v->HTotal[k] / v->PixelClock[k]) * 4.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4054  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4055  			v->WriteBandwidth[k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4056  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4057  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4058  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4059  	/*Writeback Latency support check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4060  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4061  	v->WritebackLatencySupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4062  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4063  		if (v->WritebackEnable[k] == true && (v->WriteBandwidth[k] > v->WritebackInterfaceBufferSize * 1024 / v->WritebackLatency)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4064  			v->WritebackLatencySupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4065  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4066  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4067  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4068  	/*Writeback Mode Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4069  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4070  	v->TotalNumberOfActiveWriteback = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4071  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4072  		if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4073  			v->TotalNumberOfActiveWriteback = v->TotalNumberOfActiveWriteback + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4074  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4075  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4076  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4077  	if (v->TotalNumberOfActiveWriteback > v->MaxNumWriteback) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4078  		EnoughWritebackUnits = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4079  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4080  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4081  	/*Writeback Scale Ratio and Taps Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4082  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4083  	v->WritebackScaleRatioAndTapsSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4084  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4085  		if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4086  			if (v->WritebackHRatio[k] > v->WritebackMaxHSCLRatio || v->WritebackVRatio[k] > v->WritebackMaxVSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4087  					|| v->WritebackHRatio[k] < v->WritebackMinHSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4088  					|| v->WritebackVRatio[k] < v->WritebackMinVSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4089  					|| v->WritebackHTaps[k] > v->WritebackMaxHSCLTaps
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4090  					|| v->WritebackVTaps[k] > v->WritebackMaxVSCLTaps
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4091  					|| v->WritebackHRatio[k] > v->WritebackHTaps[k] || v->WritebackVRatio[k] > v->WritebackVTaps[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4092  					|| (v->WritebackHTaps[k] > 2.0 && ((v->WritebackHTaps[k] % 2) == 1))) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4093  				v->WritebackScaleRatioAndTapsSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4094  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4095  			if (2.0 * v->WritebackDestinationWidth[k] * (v->WritebackVTaps[k] - 1) * 57 > v->WritebackLineBufferSize) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4096  				v->WritebackScaleRatioAndTapsSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4097  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4098  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4099  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4100  	/*Maximum DISPCLK/DPPCLK Support check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4101  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4102  	v->WritebackRequiredDISPCLK = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4103  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4104  		if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4105  			v->WritebackRequiredDISPCLK = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4106  					v->WritebackRequiredDISPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4107  					dml31_CalculateWriteBackDISPCLK(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4108  							v->WritebackPixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4109  							v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4110  							v->WritebackHRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4111  							v->WritebackVRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4112  							v->WritebackHTaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4113  							v->WritebackVTaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4114  							v->WritebackSourceWidth[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4115  							v->WritebackDestinationWidth[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4116  							v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4117  							v->WritebackLineBufferSize));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4118  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4119  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4120  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4121  		if (v->HRatio[k] > 1.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4122  			v->PSCL_FACTOR[k] = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4123  					v->MaxDCHUBToPSCLThroughput,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4124  					v->MaxPSCLToLBThroughput * v->HRatio[k] / dml_ceil(v->htaps[k] / 6.0, 1.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4125  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4126  			v->PSCL_FACTOR[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4127  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4128  		if (v->BytePerPixelC[k] == 0.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4129  			v->PSCL_FACTOR_CHROMA[k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4130  			v->MinDPPCLKUsingSingleDPP[k] = v->PixelClock[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4131  					* dml_max3(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4132  							v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4133  							v->HRatio[k] * v->VRatio[k] / v->PSCL_FACTOR[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4134  							1.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4135  			if ((v->htaps[k] > 6.0 || v->vtaps[k] > 6.0) && v->MinDPPCLKUsingSingleDPP[k] < 2.0 * v->PixelClock[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4136  				v->MinDPPCLKUsingSingleDPP[k] = 2.0 * v->PixelClock[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4137  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4138  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4139  			if (v->HRatioChroma[k] > 1.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4140  				v->PSCL_FACTOR_CHROMA[k] = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4141  						v->MaxDCHUBToPSCLThroughput,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4142  						v->MaxPSCLToLBThroughput * v->HRatioChroma[k] / dml_ceil(v->HTAPsChroma[k] / 6.0, 1.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4143  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4144  				v->PSCL_FACTOR_CHROMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4145  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4146  			v->MinDPPCLKUsingSingleDPP[k] = v->PixelClock[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4147  					* dml_max5(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4148  							v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4149  							v->HRatio[k] * v->VRatio[k] / v->PSCL_FACTOR[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4150  							v->VTAPsChroma[k] / 6.0 * dml_min(1.0, v->HRatioChroma[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4151  							v->HRatioChroma[k] * v->VRatioChroma[k] / v->PSCL_FACTOR_CHROMA[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4152  							1.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4153  			if ((v->htaps[k] > 6.0 || v->vtaps[k] > 6.0 || v->HTAPsChroma[k] > 6.0 || v->VTAPsChroma[k] > 6.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4154  					&& v->MinDPPCLKUsingSingleDPP[k] < 2.0 * v->PixelClock[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4155  				v->MinDPPCLKUsingSingleDPP[k] = 2.0 * v->PixelClock[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4156  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4157  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4158  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4159  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4160  		int MaximumSwathWidthSupportLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4161  		int MaximumSwathWidthSupportChroma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4162  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4163  		if (v->SurfaceTiling[k] == dm_sw_linear) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4164  			MaximumSwathWidthSupportLuma = 8192.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4165  		} else if (v->SourceScan[k] == dm_vert && v->BytePerPixelC[k] > 0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4166  			MaximumSwathWidthSupportLuma = 2880.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4167  		} else if (v->SourcePixelFormat[k] == dm_rgbe_alpha) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4168  			MaximumSwathWidthSupportLuma = 3840.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4169  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4170  			MaximumSwathWidthSupportLuma = 5760.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4171  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4172  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4173  		if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4174  			MaximumSwathWidthSupportChroma = MaximumSwathWidthSupportLuma / 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4175  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4176  			MaximumSwathWidthSupportChroma = MaximumSwathWidthSupportLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4177  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4178  		v->MaximumSwathWidthInLineBufferLuma = v->LineBufferSize * dml_max(v->HRatio[k], 1.0) / v->LBBitPerPixel[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4179  				/ (v->vtaps[k] + dml_max(dml_ceil(v->VRatio[k], 1.0) - 2, 0.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4180  		if (v->BytePerPixelC[k] == 0.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4181  			v->MaximumSwathWidthInLineBufferChroma = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4182  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4183  			v->MaximumSwathWidthInLineBufferChroma = v->LineBufferSize * dml_max(v->HRatioChroma[k], 1.0) / v->LBBitPerPixel[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4184  					/ (v->VTAPsChroma[k] + dml_max(dml_ceil(v->VRatioChroma[k], 1.0) - 2, 0.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4185  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4186  		v->MaximumSwathWidthLuma[k] = dml_min(MaximumSwathWidthSupportLuma, v->MaximumSwathWidthInLineBufferLuma);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4187  		v->MaximumSwathWidthChroma[k] = dml_min(MaximumSwathWidthSupportChroma, v->MaximumSwathWidthInLineBufferChroma);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4188  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4189  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4190  	CalculateSwathAndDETConfiguration(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4191  			true,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4192  			v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4193  			v->DETBufferSizeInKByte[0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4194  			v->MaximumSwathWidthLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4195  			v->MaximumSwathWidthChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4196  			v->SourceScan,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4197  			v->SourcePixelFormat,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4198  			v->SurfaceTiling,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4199  			v->ViewportWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4200  			v->ViewportHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4201  			v->SurfaceWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4202  			v->SurfaceWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4203  			v->SurfaceHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4204  			v->SurfaceHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4205  			v->Read256BlockHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4206  			v->Read256BlockHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4207  			v->Read256BlockWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4208  			v->Read256BlockWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4209  			v->odm_combine_dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4210  			v->BlendingAndTiming,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4211  			v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4212  			v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4213  			v->BytePerPixelInDETY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4214  			v->BytePerPixelInDETC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4215  			v->HActive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4216  			v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4217  			v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4218  			v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4219  			v->swath_width_luma_ub_this_state,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4220  			v->swath_width_chroma_ub_this_state,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4221  			v->SwathWidthYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4222  			v->SwathWidthCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4223  			v->SwathHeightYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4224  			v->SwathHeightCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4225  			v->DETBufferSizeYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4226  			v->DETBufferSizeCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4227  			v->SingleDPPViewportSizeSupportPerPlane,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4228  			&v->ViewportSizeSupport[0][0]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4229  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4230  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4231  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4232  			v->MaxDispclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(v->MaxDispclk[i], v->DISPCLKDPPCLKVCOSpeed);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4233  			v->MaxDppclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(v->MaxDppclk[i], v->DISPCLKDPPCLKVCOSpeed);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4234  			v->RequiredDISPCLK[i][j] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4235  			v->DISPCLK_DPPCLK_Support[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4236  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4237  				v->PlaneRequiredDISPCLKWithoutODMCombine = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4238  						* (1.0 + v->DISPCLKRampingMargin / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4239  				if ((v->PlaneRequiredDISPCLKWithoutODMCombine >= v->MaxDispclk[i]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4240  						&& v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4241  						&& v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4242  					v->PlaneRequiredDISPCLKWithoutODMCombine = v->PixelClock[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4243  							* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4244  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4245  				v->PlaneRequiredDISPCLKWithODMCombine2To1 = v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4246  						* (1 + v->DISPCLKRampingMargin / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4247  				if ((v->PlaneRequiredDISPCLKWithODMCombine2To1 >= v->MaxDispclk[i]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4248  						&& v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4249  						&& v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4250  					v->PlaneRequiredDISPCLKWithODMCombine2To1 = v->PixelClock[k] / 2
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4251  							* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4252  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4253  				v->PlaneRequiredDISPCLKWithODMCombine4To1 = v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4254  						* (1 + v->DISPCLKRampingMargin / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4255  				if ((v->PlaneRequiredDISPCLKWithODMCombine4To1 >= v->MaxDispclk[i]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4256  						&& v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4257  						&& v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4258  					v->PlaneRequiredDISPCLKWithODMCombine4To1 = v->PixelClock[k] / 4
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4259  							* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4260  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4261  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4262  				if (v->ODMCombinePolicy == dm_odm_combine_policy_none
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4263  						|| !(v->Output[k] == dm_dp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4264  						     v->Output[k] == dm_edp)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4265  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4266  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4267  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4268  					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4269  						FMTBufferExceeded = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4270  				} else if (v->ODMCombinePolicy == dm_odm_combine_policy_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4271  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4272  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4273  				} else if (v->ODMCombinePolicy == dm_odm_combine_policy_4to1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4274  						|| v->PlaneRequiredDISPCLKWithODMCombine2To1 > v->MaxDispclkRoundedDownToDFSGranularity) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4275  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4276  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4277  				} else if (v->PlaneRequiredDISPCLKWithoutODMCombine > v->MaxDispclkRoundedDownToDFSGranularity) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4278  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4279  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4280  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4281  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4282  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4283  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4284  				if (v->DSCEnabled[k] && v->HActive[k] > DCN31_MAX_DSC_IMAGE_WIDTH
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4285  						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4286  					if (v->HActive[k] / 2 > DCN31_MAX_DSC_IMAGE_WIDTH) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4287  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4288  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4289  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4290  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4291  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4292  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4293  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4294  				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN31_MAX_FMT_420_BUFFER_WIDTH
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4295  						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4296  					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4297  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4298  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4299  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4300  						if (v->HActive[k] / 4 > DCN31_MAX_FMT_420_BUFFER_WIDTH)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4301  							FMTBufferExceeded = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4302  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4303  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4304  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4305  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4306  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4307  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4308  					v->MPCCombine[i][j][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4309  					v->NoOfDPP[i][j][k] = 4;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4310  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 4;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4311  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4312  					v->MPCCombine[i][j][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4313  					v->NoOfDPP[i][j][k] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4314  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4315  				} else if ((v->WhenToDoMPCCombine == dm_mpc_never
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4316  						|| (v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4317  								<= v->MaxDppclkRoundedDownToDFSGranularity && v->SingleDPPViewportSizeSupportPerPlane[k] == true))) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4318  					v->MPCCombine[i][j][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4319  					v->NoOfDPP[i][j][k] = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4320  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4321  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4322  					v->MPCCombine[i][j][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4323  					v->NoOfDPP[i][j][k] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4324  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4325  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4326  				v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->PlaneRequiredDISPCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4327  				if ((v->MinDPPCLKUsingSingleDPP[k] / v->NoOfDPP[i][j][k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4328  						> v->MaxDppclkRoundedDownToDFSGranularity)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4329  						|| (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4330  					v->DISPCLK_DPPCLK_Support[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4331  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4332  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4333  			v->TotalNumberOfActiveDPP[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4334  			v->TotalNumberOfSingleDPPPlanes[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4335  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4336  				v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4337  				if (v->NoOfDPP[i][j][k] == 1)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4338  					v->TotalNumberOfSingleDPPPlanes[i][j] = v->TotalNumberOfSingleDPPPlanes[i][j] + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4339  				if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4340  						|| v->SourcePixelFormat[k] == dm_420_12 || v->SourcePixelFormat[k] == dm_rgbe_alpha)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4341  					NoChroma = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4342  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4343  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4344  			// UPTO
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4345  			if (j == 1 && v->WhenToDoMPCCombine != dm_mpc_never
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4346  					&& !UnboundedRequest(v->UseUnboundedRequesting, v->TotalNumberOfActiveDPP[i][j], NoChroma, v->Output[0])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4347  				while (!(v->TotalNumberOfActiveDPP[i][j] >= v->MaxNumDPP || v->TotalNumberOfSingleDPPPlanes[i][j] == 0)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4348  					double BWOfNonSplitPlaneOfMaximumBandwidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4349  					unsigned int NumberOfNonSplitPlaneOfMaximumBandwidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4350  					BWOfNonSplitPlaneOfMaximumBandwidth = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4351  					NumberOfNonSplitPlaneOfMaximumBandwidth = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4352  					for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4353  						if (v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k] > BWOfNonSplitPlaneOfMaximumBandwidth
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4354  								&& v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled && v->MPCCombine[i][j][k] == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4355  							BWOfNonSplitPlaneOfMaximumBandwidth = v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4356  							NumberOfNonSplitPlaneOfMaximumBandwidth = k;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4357  						}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4358  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4359  					v->MPCCombine[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4360  					v->NoOfDPP[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4361  					v->RequiredDPPCLK[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] =
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4362  							v->MinDPPCLKUsingSingleDPP[NumberOfNonSplitPlaneOfMaximumBandwidth]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4363  									* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100) / 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4364  					v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4365  					v->TotalNumberOfSingleDPPPlanes[i][j] = v->TotalNumberOfSingleDPPPlanes[i][j] - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4366  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4367  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4368  			if (v->TotalNumberOfActiveDPP[i][j] > v->MaxNumDPP) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4369  				v->RequiredDISPCLK[i][j] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4370  				v->DISPCLK_DPPCLK_Support[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4371  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4372  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4373  					if (v->SingleDPPViewportSizeSupportPerPlane[k] == false && v->WhenToDoMPCCombine != dm_mpc_never) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4374  						v->MPCCombine[i][j][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4375  						v->NoOfDPP[i][j][k] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4376  						v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4377  								* (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4378  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4379  						v->MPCCombine[i][j][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4380  						v->NoOfDPP[i][j][k] = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4381  						v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4382  								* (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4383  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4384  					if (!(v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4385  							&& v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4386  						v->PlaneRequiredDISPCLK = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4387  								* (1.0 + v->DISPCLKRampingMargin / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4388  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4389  						v->PlaneRequiredDISPCLK = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4390  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4391  					v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->PlaneRequiredDISPCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4392  					if ((v->MinDPPCLKUsingSingleDPP[k] / v->NoOfDPP[i][j][k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4393  							> v->MaxDppclkRoundedDownToDFSGranularity)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4394  							|| (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4395  						v->DISPCLK_DPPCLK_Support[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4396  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4397  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4398  				v->TotalNumberOfActiveDPP[i][j] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4399  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4400  					v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4401  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4402  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4403  			v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->WritebackRequiredDISPCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4404  			if (v->MaxDispclkRoundedDownToDFSGranularity < v->WritebackRequiredDISPCLK) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4405  				v->DISPCLK_DPPCLK_Support[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4406  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4407  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4408  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4409  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4410  	/*Total Available Pipes Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4411  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4412  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4413  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4414  			if (v->TotalNumberOfActiveDPP[i][j] <= v->MaxNumDPP) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4415  				v->TotalAvailablePipesSupport[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4416  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4417  				v->TotalAvailablePipesSupport[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4418  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4419  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4420  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4421  	/*Display IO and DSC Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4422  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4423  	v->NonsupportedDSCInputBPC = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4424  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4425  		if (!(v->DSCInputBitPerComponent[k] == 12.0 || v->DSCInputBitPerComponent[k] == 10.0 || v->DSCInputBitPerComponent[k] == 8.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4426  				|| v->DSCInputBitPerComponent[k] > v->MaximumDSCBitsPerComponent) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4427  			v->NonsupportedDSCInputBPC = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4428  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4429  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4430  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4431  	/*Number Of DSC Slices*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4432  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4433  		if (v->BlendingAndTiming[k] == k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4434  			if (v->PixelClockBackEnd[k] > 3200) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4435  				v->NumberOfDSCSlices[k] = dml_ceil(v->PixelClockBackEnd[k] / 400.0, 4.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4436  			} else if (v->PixelClockBackEnd[k] > 1360) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4437  				v->NumberOfDSCSlices[k] = 8;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4438  			} else if (v->PixelClockBackEnd[k] > 680) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4439  				v->NumberOfDSCSlices[k] = 4;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4440  			} else if (v->PixelClockBackEnd[k] > 340) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4441  				v->NumberOfDSCSlices[k] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4442  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4443  				v->NumberOfDSCSlices[k] = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4444  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4445  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4446  			v->NumberOfDSCSlices[k] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4447  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4448  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4449  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4450  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4451  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4452  			v->RequiresDSC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4453  			v->RequiresFEC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4454  			if (v->BlendingAndTiming[k] == k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4455  				if (v->Output[k] == dm_hdmi) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4456  					v->RequiresDSC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4457  					v->RequiresFEC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4458  					v->OutputBppPerState[i][k] = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4459  							dml_min(600.0, v->PHYCLKPerState[i]) * 10,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4460  							3,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4461  							v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4462  							v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4463  							v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4464  							v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4465  							false,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4466  							v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4467  							v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4468  							v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4469  							v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4470  							v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4471  							v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4472  							v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4473  				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4474  					if (v->DSCEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4475  						v->RequiresDSC[i][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4476  						v->LinkDSCEnable = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4477  						if (v->Output[k] == dm_dp) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4478  							v->RequiresFEC[i][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4479  						} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4480  							v->RequiresFEC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4481  						}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4482  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4483  						v->RequiresDSC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4484  						v->LinkDSCEnable = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4485  						v->RequiresFEC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4486  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4487  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4488  					v->Outbpp = BPP_INVALID;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4489  					if (v->PHYCLKPerState[i] >= 270.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4490  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4491  								(1.0 - v->Downspreading / 100.0) * 2700,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4492  								v->OutputLinkDPLanes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4493  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4494  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4495  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4496  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4497  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4498  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4499  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4500  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4501  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4502  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4503  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4504  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4505  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4506  						// TODO: Need some other way to handle this nonsense
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4507  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4508  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4509  					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4510  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4511  								(1.0 - v->Downspreading / 100.0) * 5400,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4512  								v->OutputLinkDPLanes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4513  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4514  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4515  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4516  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4517  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4518  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4519  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4520  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4521  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4522  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4523  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4524  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4525  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4526  						// TODO: Need some other way to handle this nonsense
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4527  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4528  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4529  					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4530  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4531  								(1.0 - v->Downspreading / 100.0) * 8100,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4532  								v->OutputLinkDPLanes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4533  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4534  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4535  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4536  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4537  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4538  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4539  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4540  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4541  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4542  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4543  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4544  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4545  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4546  						// TODO: Need some other way to handle this nonsense
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4547  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4548  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4549  					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4550  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4551  								(1.0 - v->Downspreading / 100.0) * 10000,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4552  								4,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4553  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4554  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4555  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4556  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4557  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4558  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4559  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4560  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4561  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4562  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4563  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4564  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4565  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4566  						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4567  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4568  					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4569  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4570  								12000,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4571  								4,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4572  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4573  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4574  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4575  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4576  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4577  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4578  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4579  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4580  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4581  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4582  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4583  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4584  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4585  						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4586  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4587  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4588  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4589  				v->OutputBppPerState[i][k] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4590  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4591  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4592  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4593  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4594  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4595  		v->LinkCapacitySupport[i] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4596  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4597  			if (v->BlendingAndTiming[k] == k
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4598  					&& (v->Output[k] == dm_dp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4599  					    v->Output[k] == dm_edp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4600  					    v->Output[k] == dm_hdmi) && v->OutputBppPerState[i][k] == 0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4601  				v->LinkCapacitySupport[i] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4602  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4603  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4604  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4605  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4606  	// UPTO 2172
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4607  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4608  		if (v->BlendingAndTiming[k] == k
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4609  				&& (v->Output[k] == dm_dp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4610  				    v->Output[k] == dm_edp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4611  				    v->Output[k] == dm_hdmi)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4612  			if (v->OutputFormat[k] == dm_420 && v->Interlace[k] == 1 && v->ProgressiveToInterlaceUnitInOPP == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4613  				P2IWith420 = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4614  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4615  			if (v->DSCEnable[k] == true && v->OutputFormat[k] == dm_n422
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4616  					&& !v->DSC422NativeSupport) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4617  				DSC422NativeNotSupported = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4618  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4619  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4620  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4621  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4622  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4623  		v->ODMCombine4To1SupportCheckOK[i] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4624  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4625  			if (v->BlendingAndTiming[k] == k && v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4626  					&& (v->ODMCombine4To1Supported == false || v->Output[k] == dm_dp || v->Output[k] == dm_edp
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4627  							|| v->Output[k] == dm_hdmi)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4628  				v->ODMCombine4To1SupportCheckOK[i] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4629  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4630  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4631  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4632  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4633  	/* Skip dscclk validation: as long as dispclk is supported, dscclk is also implicitly supported */
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4634  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4635  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4636  		v->NotEnoughDSCUnits[i] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4637  		v->TotalDSCUnitsRequired = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4638  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4639  			if (v->RequiresDSC[i][k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4640  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4641  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 4.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4642  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4643  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4644  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4645  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 1.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4646  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4647  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4648  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4649  		if (v->TotalDSCUnitsRequired > v->NumberOfDSC) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4650  			v->NotEnoughDSCUnits[i] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4651  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4652  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4653  	/*DSC Delay per state*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4654  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4655  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4656  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4657  			if (v->OutputBppPerState[i][k] == BPP_INVALID) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4658  				v->BPP = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4659  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4660  				v->BPP = v->OutputBppPerState[i][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4661  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4662  			if (v->RequiresDSC[i][k] == true && v->BPP != 0.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4663  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4664  					v->DSCDelayPerState[i][k] = dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4665  							v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4666  							v->BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4667  							dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4668  							v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4669  							v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4670  							v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4671  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4672  					v->DSCDelayPerState[i][k] = 2.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4673  							* (dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4674  									v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4675  									v->BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4676  									dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4677  									v->NumberOfDSCSlices[k] / 2,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4678  									v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4679  									v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4680  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4681  					v->DSCDelayPerState[i][k] = 4.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4682  							* (dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4683  									v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4684  									v->BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4685  									dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4686  									v->NumberOfDSCSlices[k] / 4,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4687  									v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4688  									v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4689  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4690  				v->DSCDelayPerState[i][k] = v->DSCDelayPerState[i][k] * v->PixelClock[k] / v->PixelClockBackEnd[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4691  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4692  				v->DSCDelayPerState[i][k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4693  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4694  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4695  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4696  			for (m = 0; m < v->NumberOfActivePlanes; m++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4697  				if (v->BlendingAndTiming[k] == m && v->RequiresDSC[i][m] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4698  					v->DSCDelayPerState[i][k] = v->DSCDelayPerState[i][m];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4699  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4700  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4701  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4702  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4703  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4704  	//Calculate Swath, DET Configuration, DCFCLKDeepSleep
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4705  	//
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4706  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4707  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4708  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4709  				v->RequiredDPPCLKThisState[k] = v->RequiredDPPCLK[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4710  				v->NoOfDPPThisState[k] = v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4711  				v->ODMCombineEnableThisState[k] = v->ODMCombineEnablePerState[i][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4712  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4713  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4714  			CalculateSwathAndDETConfiguration(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4715  					false,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4716  					v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4717  					v->DETBufferSizeInKByte[0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4718  					v->MaximumSwathWidthLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4719  					v->MaximumSwathWidthChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4720  					v->SourceScan,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4721  					v->SourcePixelFormat,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4722  					v->SurfaceTiling,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4723  					v->ViewportWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4724  					v->ViewportHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4725  					v->SurfaceWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4726  					v->SurfaceWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4727  					v->SurfaceHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4728  					v->SurfaceHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4729  					v->Read256BlockHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4730  					v->Read256BlockHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4731  					v->Read256BlockWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4732  					v->Read256BlockWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4733  					v->ODMCombineEnableThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4734  					v->BlendingAndTiming,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4735  					v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4736  					v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4737  					v->BytePerPixelInDETY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4738  					v->BytePerPixelInDETC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4739  					v->HActive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4740  					v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4741  					v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4742  					v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4743  					v->swath_width_luma_ub_this_state,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4744  					v->swath_width_chroma_ub_this_state,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4745  					v->SwathWidthYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4746  					v->SwathWidthCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4747  					v->SwathHeightYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4748  					v->SwathHeightCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4749  					v->DETBufferSizeYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4750  					v->DETBufferSizeCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4751  					v->dummystring,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4752  					&v->ViewportSizeSupport[i][j]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4753  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4754  			CalculateDCFCLKDeepSleep(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4755  					mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4756  					v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4757  					v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4758  					v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4759  					v->VRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4760  					v->VRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4761  					v->SwathWidthYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4762  					v->SwathWidthCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4763  					v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4764  					v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4765  					v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4766  					v->PixelClock,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4767  					v->PSCL_FACTOR,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4768  					v->PSCL_FACTOR_CHROMA,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4769  					v->RequiredDPPCLKThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4770  					v->ReadBandwidthLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4771  					v->ReadBandwidthChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4772  					v->ReturnBusWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4773  					&v->ProjectedDCFCLKDeepSleep[i][j]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4774  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4775  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4776  				v->swath_width_luma_ub_all_states[i][j][k] = v->swath_width_luma_ub_this_state[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4777  				v->swath_width_chroma_ub_all_states[i][j][k] = v->swath_width_chroma_ub_this_state[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4778  				v->SwathWidthYAllStates[i][j][k] = v->SwathWidthYThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4779  				v->SwathWidthCAllStates[i][j][k] = v->SwathWidthCThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4780  				v->SwathHeightYAllStates[i][j][k] = v->SwathHeightYThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4781  				v->SwathHeightCAllStates[i][j][k] = v->SwathHeightCThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4782  				v->DETBufferSizeYAllStates[i][j][k] = v->DETBufferSizeYThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4783  				v->DETBufferSizeCAllStates[i][j][k] = v->DETBufferSizeCThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4784  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4785  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4786  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4787  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4788  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4789  		v->cursor_bw[k] = v->NumberOfCursors[k] * v->CursorWidth[k][0] * v->CursorBPP[k][0] / 8.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4790  				/ (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4791  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4792  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4793  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4794  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4795  			bool NotUrgentLatencyHiding[DC__NUM_DPP__MAX];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4796  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4797  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4798  				v->swath_width_luma_ub_this_state[k] = v->swath_width_luma_ub_all_states[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4799  				v->swath_width_chroma_ub_this_state[k] = v->swath_width_chroma_ub_all_states[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4800  				v->SwathWidthYThisState[k] = v->SwathWidthYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4801  				v->SwathWidthCThisState[k] = v->SwathWidthCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4802  				v->SwathHeightYThisState[k] = v->SwathHeightYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4803  				v->SwathHeightCThisState[k] = v->SwathHeightCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4804  				v->DETBufferSizeYThisState[k] = v->DETBufferSizeYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4805  				v->DETBufferSizeCThisState[k] = v->DETBufferSizeCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4806  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4807  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4808  			v->TotalNumberOfDCCActiveDPP[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4809  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4810  				if (v->DCCEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4811  					v->TotalNumberOfDCCActiveDPP[i][j] = v->TotalNumberOfDCCActiveDPP[i][j] + v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4812  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4813  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4814  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4815  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4816  				if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4817  						|| v->SourcePixelFormat[k] == dm_420_12 || v->SourcePixelFormat[k] == dm_rgbe_alpha) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4818  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4819  					if ((v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4820  							&& v->SourceScan[k] != dm_vert) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4821  						v->PTEBufferSizeInRequestsForLuma = (v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4822  								/ 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4823  						v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsForLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4824  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4825  						v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4826  						v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsChroma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4827  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4828  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4829  					v->PDEAndMetaPTEBytesPerFrameC = CalculateVMAndRowBytes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4830  							mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4831  							v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4832  							v->Read256BlockHeightC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4833  							v->Read256BlockWidthC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4834  							v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4835  							v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4836  							v->BytePerPixelC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4837  							v->SourceScan[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4838  							v->SwathWidthCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4839  							v->ViewportHeightChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4840  							v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4841  							v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4842  							v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4843  							v->GPUVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4844  							v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4845  							v->PTEBufferSizeInRequestsForChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4846  							v->PitchC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4847  							0.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4848  							&v->MacroTileWidthC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4849  							&v->MetaRowBytesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4850  							&v->DPTEBytesPerRowC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4851  							&v->PTEBufferSizeNotExceededC[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4852  							&v->dummyinteger7,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4853  							&v->dpte_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4854  							&v->dummyinteger28,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4855  							&v->dummyinteger26,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4856  							&v->dummyinteger23,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4857  							&v->meta_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4858  							&v->dummyinteger8,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4859  							&v->dummyinteger9,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4860  							&v->dummyinteger19,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4861  							&v->dummyinteger20,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4862  							&v->dummyinteger17,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4863  							&v->dummyinteger10,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4864  							&v->dummyinteger11);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4865  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4866  					v->PrefetchLinesC[i][j][k] = CalculatePrefetchSourceLines(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4867  							mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4868  							v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4869  							v->VTAPsChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4870  							v->Interlace[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4871  							v->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4872  							v->SwathHeightCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4873  							v->ViewportYStartC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4874  							&v->PrefillC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4875  							&v->MaxNumSwC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4876  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4877  					v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4878  					v->PTEBufferSizeInRequestsForChroma = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4879  					v->PDEAndMetaPTEBytesPerFrameC = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4880  					v->MetaRowBytesC = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4881  					v->DPTEBytesPerRowC = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4882  					v->PrefetchLinesC[i][j][k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4883  					v->PTEBufferSizeNotExceededC[i][j][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4884  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4885  				v->PDEAndMetaPTEBytesPerFrameY = CalculateVMAndRowBytes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4886  						mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4887  						v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4888  						v->Read256BlockHeightY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4889  						v->Read256BlockWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4890  						v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4891  						v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4892  						v->BytePerPixelY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4893  						v->SourceScan[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4894  						v->SwathWidthYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4895  						v->ViewportHeight[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4896  						v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4897  						v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4898  						v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4899  						v->GPUVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4900  						v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4901  						v->PTEBufferSizeInRequestsForLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4902  						v->PitchY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4903  						v->DCCMetaPitchY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4904  						&v->MacroTileWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4905  						&v->MetaRowBytesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4906  						&v->DPTEBytesPerRowY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4907  						&v->PTEBufferSizeNotExceededY[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4908  						&v->dummyinteger7,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4909  						&v->dpte_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4910  						&v->dummyinteger29,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4911  						&v->dummyinteger27,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4912  						&v->dummyinteger24,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4913  						&v->meta_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4914  						&v->dummyinteger25,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4915  						&v->dpte_group_bytes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4916  						&v->dummyinteger21,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4917  						&v->dummyinteger22,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4918  						&v->dummyinteger18,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4919  						&v->dummyinteger5,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4920  						&v->dummyinteger6);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4921  				v->PrefetchLinesY[i][j][k] = CalculatePrefetchSourceLines(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4922  						mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4923  						v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4924  						v->vtaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4925  						v->Interlace[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4926  						v->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4927  						v->SwathHeightYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4928  						v->ViewportYStartY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4929  						&v->PrefillY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4930  						&v->MaxNumSwY[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4931  				v->PDEAndMetaPTEBytesPerFrame[i][j][k] = v->PDEAndMetaPTEBytesPerFrameY + v->PDEAndMetaPTEBytesPerFrameC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4932  				v->MetaRowBytes[i][j][k] = v->MetaRowBytesY + v->MetaRowBytesC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4933  				v->DPTEBytesPerRow[i][j][k] = v->DPTEBytesPerRowY + v->DPTEBytesPerRowC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4934  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4935  				CalculateRowBandwidth(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4936  						v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4937  						v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4938  						v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4939  						v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4940  						v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4941  						v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4942  						v->MetaRowBytesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4943  						v->MetaRowBytesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4944  						v->meta_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4945  						v->meta_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4946  						v->DPTEBytesPerRowY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4947  						v->DPTEBytesPerRowC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4948  						v->dpte_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4949  						v->dpte_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4950  						&v->meta_row_bandwidth[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4951  						&v->dpte_row_bandwidth[i][j][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4952  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4953  			v->UrgLatency[i] = CalculateUrgentLatency(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4954  					v->UrgentLatencyPixelDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4955  					v->UrgentLatencyPixelMixedWithVMData,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4956  					v->UrgentLatencyVMDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4957  					v->DoUrgentLatencyAdjustment,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4958  					v->UrgentLatencyAdjustmentFabricClockComponent,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4959  					v->UrgentLatencyAdjustmentFabricClockReference,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4960  					v->FabricClockPerState[i]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4961  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4962  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4963  				CalculateUrgentBurstFactor(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4964  						v->swath_width_luma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4965  						v->swath_width_chroma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4966  						v->SwathHeightYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4967  						v->SwathHeightCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4968  						v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4969  						v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4970  						v->CursorBufferSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4971  						v->CursorWidth[k][0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4972  						v->CursorBPP[k][0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4973  						v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4974  						v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4975  						v->BytePerPixelInDETY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4976  						v->BytePerPixelInDETC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4977  						v->DETBufferSizeYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4978  						v->DETBufferSizeCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4979  						&v->UrgentBurstFactorCursor[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4980  						&v->UrgentBurstFactorLuma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4981  						&v->UrgentBurstFactorChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4982  						&NotUrgentLatencyHiding[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4983  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4984  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4985  			v->NotEnoughUrgentLatencyHidingA[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4986  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4987  				if (NotUrgentLatencyHiding[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4988  					v->NotEnoughUrgentLatencyHidingA[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4989  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4990  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4991  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4992  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4993  				v->VActivePixelBandwidth[i][j][k] = v->ReadBandwidthLuma[k] * v->UrgentBurstFactorLuma[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4994  						+ v->ReadBandwidthChroma[k] * v->UrgentBurstFactorChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4995  				v->VActiveCursorBandwidth[i][j][k] = v->cursor_bw[k] * v->UrgentBurstFactorCursor[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4996  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4997  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4998  			v->TotalVActivePixelBandwidth[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4999  			v->TotalVActiveCursorBandwidth[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5000  			v->TotalMetaRowBandwidth[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5001  			v->TotalDPTERowBandwidth[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5002  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5003  				v->TotalVActivePixelBandwidth[i][j] = v->TotalVActivePixelBandwidth[i][j] + v->VActivePixelBandwidth[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5004  				v->TotalVActiveCursorBandwidth[i][j] = v->TotalVActiveCursorBandwidth[i][j] + v->VActiveCursorBandwidth[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5005  				v->TotalMetaRowBandwidth[i][j] = v->TotalMetaRowBandwidth[i][j] + v->NoOfDPP[i][j][k] * v->meta_row_bandwidth[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5006  				v->TotalDPTERowBandwidth[i][j] = v->TotalDPTERowBandwidth[i][j] + v->NoOfDPP[i][j][k] * v->dpte_row_bandwidth[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5007  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5008  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5009  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5010  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5011  	//Calculate Return BW
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5012  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5013  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5014  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5015  				if (v->BlendingAndTiming[k] == k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5016  					if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5017  						v->WritebackDelayTime[k] = v->WritebackLatency
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5018  								+ CalculateWriteBackDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5019  										v->WritebackPixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5020  										v->WritebackHRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5021  										v->WritebackVRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5022  										v->WritebackVTaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5023  										v->WritebackDestinationWidth[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5024  										v->WritebackDestinationHeight[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5025  										v->WritebackSourceHeight[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5026  										v->HTotal[k]) / v->RequiredDISPCLK[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5027  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5028  						v->WritebackDelayTime[k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5029  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5030  					for (m = 0; m < v->NumberOfActivePlanes; m++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5031  						if (v->BlendingAndTiming[m] == k && v->WritebackEnable[m] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5032  							v->WritebackDelayTime[k] = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5033  									v->WritebackDelayTime[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5034  									v->WritebackLatency
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5035  											+ CalculateWriteBackDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5036  													v->WritebackPixelFormat[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5037  													v->WritebackHRatio[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5038  													v->WritebackVRatio[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5039  													v->WritebackVTaps[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5040  													v->WritebackDestinationWidth[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5041  													v->WritebackDestinationHeight[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5042  													v->WritebackSourceHeight[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5043  													v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5044  						}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5045  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5046  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5047  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5048  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5049  				for (m = 0; m < v->NumberOfActivePlanes; m++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5050  					if (v->BlendingAndTiming[k] == m) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5051  						v->WritebackDelayTime[k] = v->WritebackDelayTime[m];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5052  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5053  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5054  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5055  			v->MaxMaxVStartup[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5056  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5057  				v->MaximumVStartup[i][j][k] =
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5058  						(v->Interlace[k] && !v->ProgressiveToInterlaceUnitInOPP) ?
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5059  								dml_floor((v->VTotal[k] - v->VActive[k]) / 2.0, 1.0) :
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5060  								v->VTotal[k] - v->VActive[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5061  										- dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5062  												1.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5063  												dml_ceil(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5064  														1.0 * v->WritebackDelayTime[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5065  																/ (v->HTotal[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5066  																		/ v->PixelClock[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5067  														1.0));
5d9e7fe8ef9b1c Nikola Cornij       2021-06-07  5068  				if (v->MaximumVStartup[i][j][k] > 1023)
5d9e7fe8ef9b1c Nikola Cornij       2021-06-07  5069  					v->MaximumVStartup[i][j][k] = 1023;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5070  				v->MaxMaxVStartup[i][j] = dml_max(v->MaxMaxVStartup[i][j], v->MaximumVStartup[i][j][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5071  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5072  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5073  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5074  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5075  	ReorderingBytes = v->NumberOfChannels
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5076  			* dml_max3(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5077  					v->UrgentOutOfOrderReturnPerChannelPixelDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5078  					v->UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5079  					v->UrgentOutOfOrderReturnPerChannelVMDataOnly);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5080  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5081  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5082  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5083  			v->DCFCLKState[i][j] = v->DCFCLKPerState[i];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5084  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5085  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5086  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5087  	if (v->UseMinimumRequiredDCFCLK == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5088  		UseMinimumDCFCLK(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5089  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5090  				v->MaxInterDCNTileRepeaters,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5091  				MaxPrefetchMode,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5092  				v->DRAMClockChangeLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5093  				v->SREnterPlusExitTime,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5094  				v->ReturnBusWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5095  				v->RoundTripPingLatencyCycles,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5096  				ReorderingBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5097  				v->PixelChunkSizeInKByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5098  				v->MetaChunkSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5099  				v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5100  				v->GPUVMMaxPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5101  				v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5102  				v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5103  				v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5104  				v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5105  				v->DynamicMetadataVMEnabled,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5106  				v->ImmediateFlipRequirement,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5107  				v->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5108  				v->MaxAveragePercentOfIdealFabricAndSDPPortBWDisplayCanUseInNormalSystemOperation,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5109  				v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5110  				v->VTotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5111  				v->VActive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5112  				v->DynamicMetadataTransmittedBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5113  				v->DynamicMetadataLinesBeforeActiveRequired,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5114  				v->Interlace,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5115  				v->RequiredDPPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5116  				v->RequiredDISPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5117  				v->UrgLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5118  				v->NoOfDPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5119  				v->ProjectedDCFCLKDeepSleep,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5120  				v->MaximumVStartup,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5121  				v->TotalVActivePixelBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5122  				v->TotalVActiveCursorBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5123  				v->TotalMetaRowBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5124  				v->TotalDPTERowBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5125  				v->TotalNumberOfActiveDPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5126  				v->TotalNumberOfDCCActiveDPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5127  				v->dpte_group_bytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5128  				v->PrefetchLinesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5129  				v->PrefetchLinesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5130  				v->swath_width_luma_ub_all_states,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5131  				v->swath_width_chroma_ub_all_states,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5132  				v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5133  				v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5134  				v->HTotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5135  				v->PixelClock,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5136  				v->PDEAndMetaPTEBytesPerFrame,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5137  				v->DPTEBytesPerRow,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5138  				v->MetaRowBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5139  				v->DynamicMetadataEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5140  				v->VActivePixelBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5141  				v->VActiveCursorBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5142  				v->ReadBandwidthLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5143  				v->ReadBandwidthChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5144  				v->DCFCLKPerState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5145  				v->DCFCLKState);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5146  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5147  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5148  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5149  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5150  			double IdealFabricAndSDPPortBandwidthPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5151  					v->ReturnBusWidth * v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5152  					v->FabricClockPerState[i] * v->FabricDatapathToDCNDataReturn);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5153  			double IdealDRAMBandwidthPerState = v->DRAMSpeedPerState[i] * v->NumberOfChannels * v->DRAMChannelWidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5154  			double PixelDataOnlyReturnBWPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5155  					IdealFabricAndSDPPortBandwidthPerState * v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5156  					IdealDRAMBandwidthPerState * v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyPixelDataOnly / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5157  			double PixelMixedWithVMDataReturnBWPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5158  					IdealFabricAndSDPPortBandwidthPerState * v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5159  					IdealDRAMBandwidthPerState * v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyPixelMixedWithVMData / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5160  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5161  			if (v->HostVMEnable != true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5162  				v->ReturnBWPerState[i][j] = PixelDataOnlyReturnBWPerState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5163  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5164  				v->ReturnBWPerState[i][j] = PixelMixedWithVMDataReturnBWPerState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5165  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5166  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5167  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5168  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5169  	//Re-ordering Buffer Support Check
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5170  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5171  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5172  			if ((v->ROBBufferSizeInKByte - v->PixelChunkSizeInKByte) * 1024 / v->ReturnBWPerState[i][j]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5173  					> (v->RoundTripPingLatencyCycles + __DML_ARB_TO_RET_DELAY__) / v->DCFCLKState[i][j] + ReorderingBytes / v->ReturnBWPerState[i][j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5174  				v->ROBSupport[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5175  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5176  				v->ROBSupport[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5177  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5178  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5179  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5180  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5181  	//Vertical Active BW support check
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5182  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5183  	MaxTotalVActiveRDBandwidth = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5184  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5185  		MaxTotalVActiveRDBandwidth = MaxTotalVActiveRDBandwidth + v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5186  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5187  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5188  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5189  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5190  			v->MaxTotalVerticalActiveAvailableBandwidth[i][j] = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5191  					dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5192  							v->ReturnBusWidth * v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5193  							v->FabricClockPerState[i] * v->FabricDatapathToDCNDataReturn)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5194  							* v->MaxAveragePercentOfIdealFabricAndSDPPortBWDisplayCanUseInNormalSystemOperation / 100,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5195  					v->DRAMSpeedPerState[i] * v->NumberOfChannels * v->DRAMChannelWidth
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5196  							* v->MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperation / 100);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5197  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5198  			if (MaxTotalVActiveRDBandwidth <= v->MaxTotalVerticalActiveAvailableBandwidth[i][j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5199  				v->TotalVerticalActiveBandwidthSupport[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5200  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5201  				v->TotalVerticalActiveBandwidthSupport[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5202  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5203  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5204  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5205  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5206  	v->UrgentLatency = CalculateUrgentLatency(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5207  			v->UrgentLatencyPixelDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5208  			v->UrgentLatencyPixelMixedWithVMData,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5209  			v->UrgentLatencyVMDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5210  			v->DoUrgentLatencyAdjustment,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5211  			v->UrgentLatencyAdjustmentFabricClockComponent,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5212  			v->UrgentLatencyAdjustmentFabricClockReference,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5213  			v->FabricClock);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5214  	//Prefetch Check
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5215  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5216  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5217  			double VMDataOnlyReturnBWPerState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5218  			double HostVMInefficiencyFactor = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5219  			int NextPrefetchModeState = MinPrefetchMode;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5220  			bool UnboundedRequestEnabledThisState = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5221  			int CompressedBufferSizeInkByteThisState = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5222  			double dummy;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5223  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5224  			v->TimeCalc = 24 / v->ProjectedDCFCLKDeepSleep[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5225  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5226  			v->BandwidthWithoutPrefetchSupported[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5227  			if (v->TotalVActivePixelBandwidth[i][j] + v->TotalVActiveCursorBandwidth[i][j] + v->TotalMetaRowBandwidth[i][j]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5228  					+ v->TotalDPTERowBandwidth[i][j] > v->ReturnBWPerState[i][j] || v->NotEnoughUrgentLatencyHidingA[i][j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5229  				v->BandwidthWithoutPrefetchSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5230  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5231  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5232  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5233  				v->NoOfDPPThisState[k] = v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5234  				v->swath_width_luma_ub_this_state[k] = v->swath_width_luma_ub_all_states[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5235  				v->swath_width_chroma_ub_this_state[k] = v->swath_width_chroma_ub_all_states[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5236  				v->SwathWidthYThisState[k] = v->SwathWidthYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5237  				v->SwathWidthCThisState[k] = v->SwathWidthCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5238  				v->SwathHeightYThisState[k] = v->SwathHeightYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5239  				v->SwathHeightCThisState[k] = v->SwathHeightCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5240  				v->DETBufferSizeYThisState[k] = v->DETBufferSizeYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5241  				v->DETBufferSizeCThisState[k] = v->DETBufferSizeCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5242  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5243  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5244  			VMDataOnlyReturnBWPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5245  					dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5246  							v->ReturnBusWidth * v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5247  							v->FabricClockPerState[i] * v->FabricDatapathToDCNDataReturn)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5248  							* v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5249  					v->DRAMSpeedPerState[i] * v->NumberOfChannels * v->DRAMChannelWidth
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5250  							* v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyVMDataOnly / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5251  			if (v->GPUVMEnable && v->HostVMEnable)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5252  				HostVMInefficiencyFactor = v->ReturnBWPerState[i][j] / VMDataOnlyReturnBWPerState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5253  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5254  			v->ExtraLatency = CalculateExtraLatency(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5255  					v->RoundTripPingLatencyCycles,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5256  					ReorderingBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5257  					v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5258  					v->TotalNumberOfActiveDPP[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5259  					v->PixelChunkSizeInKByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5260  					v->TotalNumberOfDCCActiveDPP[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5261  					v->MetaChunkSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5262  					v->ReturnBWPerState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5263  					v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5264  					v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5265  					v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5266  					v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5267  					v->dpte_group_bytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5268  					HostVMInefficiencyFactor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5269  					v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5270  					v->HostVMMaxNonCachedPageTableLevels);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5271  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5272  			v->NextMaxVStartup = v->MaxMaxVStartup[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5273  			do {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5274  				v->PrefetchModePerState[i][j] = NextPrefetchModeState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5275  				v->MaxVStartup = v->NextMaxVStartup;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5276  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5277  				v->TWait = CalculateTWait(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5278  						v->PrefetchModePerState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5279  						v->DRAMClockChangeLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5280  						v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5281  						v->SREnterPlusExitTime);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5282  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5283  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5284  					Pipe myPipe;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5285  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5286  					myPipe.DPPCLK = v->RequiredDPPCLK[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5287  					myPipe.DISPCLK = v->RequiredDISPCLK[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5288  					myPipe.PixelClock = v->PixelClock[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5289  					myPipe.DCFCLKDeepSleep = v->ProjectedDCFCLKDeepSleep[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5290  					myPipe.DPPPerPlane = v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5291  					myPipe.ScalerEnabled = v->ScalerEnabled[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5292  					myPipe.SourceScan = v->SourceScan[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5293  					myPipe.BlockWidth256BytesY = v->Read256BlockWidthY[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5294  					myPipe.BlockHeight256BytesY = v->Read256BlockHeightY[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5295  					myPipe.BlockWidth256BytesC = v->Read256BlockWidthC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5296  					myPipe.BlockHeight256BytesC = v->Read256BlockHeightC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5297  					myPipe.InterlaceEnable = v->Interlace[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5298  					myPipe.NumberOfCursors = v->NumberOfCursors[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5299  					myPipe.VBlank = v->VTotal[k] - v->VActive[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5300  					myPipe.HTotal = v->HTotal[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5301  					myPipe.DCCEnable = v->DCCEnable[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5302  					myPipe.ODMCombineIsEnabled = v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5303  							|| v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5304  					myPipe.SourcePixelFormat = v->SourcePixelFormat[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5305  					myPipe.BytePerPixelY = v->BytePerPixelY[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5306  					myPipe.BytePerPixelC = v->BytePerPixelC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5307  					myPipe.ProgressiveToInterlaceUnitInOPP = v->ProgressiveToInterlaceUnitInOPP;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5308  					v->NoTimeForPrefetch[i][j][k] = CalculatePrefetchSchedule(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5309  							mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5310  							HostVMInefficiencyFactor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5311  							&myPipe,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5312  							v->DSCDelayPerState[i][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5313  							v->DPPCLKDelaySubtotal + v->DPPCLKDelayCNVCFormater,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5314  							v->DPPCLKDelaySCL,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5315  							v->DPPCLKDelaySCLLBOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5316  							v->DPPCLKDelayCNVCCursor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5317  							v->DISPCLKDelaySubtotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5318  							v->SwathWidthYThisState[k] / v->HRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5319  							v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5320  							v->MaxInterDCNTileRepeaters,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5321  							dml_min(v->MaxVStartup, v->MaximumVStartup[i][j][k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5322  							v->MaximumVStartup[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5323  							v->GPUVMMaxPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5324  							v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5325  							v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5326  							v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5327  							v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5328  							v->DynamicMetadataEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5329  							v->DynamicMetadataVMEnabled,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5330  							v->DynamicMetadataLinesBeforeActiveRequired[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5331  							v->DynamicMetadataTransmittedBytes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5332  							v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5333  							v->ExtraLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5334  							v->TimeCalc,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5335  							v->PDEAndMetaPTEBytesPerFrame[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5336  							v->MetaRowBytes[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5337  							v->DPTEBytesPerRow[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5338  							v->PrefetchLinesY[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5339  							v->SwathWidthYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5340  							v->PrefillY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5341  							v->MaxNumSwY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5342  							v->PrefetchLinesC[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5343  							v->SwathWidthCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5344  							v->PrefillC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5345  							v->MaxNumSwC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5346  							v->swath_width_luma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5347  							v->swath_width_chroma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5348  							v->SwathHeightYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5349  							v->SwathHeightCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5350  							v->TWait,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5351  							&v->DSTXAfterScaler[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5352  							&v->DSTYAfterScaler[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5353  							&v->LineTimesForPrefetch[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5354  							&v->PrefetchBW[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5355  							&v->LinesForMetaPTE[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5356  							&v->LinesForMetaAndDPTERow[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5357  							&v->VRatioPreY[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5358  							&v->VRatioPreC[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5359  							&v->RequiredPrefetchPixelDataBWLuma[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5360  							&v->RequiredPrefetchPixelDataBWChroma[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5361  							&v->NoTimeForDynamicMetadata[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5362  							&v->Tno_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5363  							&v->prefetch_vmrow_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5364  							&v->dummy7[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5365  							&v->dummy8[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5366  							&v->dummy13[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5367  							&v->VUpdateOffsetPix[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5368  							&v->VUpdateWidthPix[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5369  							&v->VReadyOffsetPix[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5370  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5371  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5372  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5373  					CalculateUrgentBurstFactor(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5374  							v->swath_width_luma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5375  							v->swath_width_chroma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5376  							v->SwathHeightYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5377  							v->SwathHeightCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5378  							v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5379  							v->UrgentLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5380  							v->CursorBufferSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5381  							v->CursorWidth[k][0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5382  							v->CursorBPP[k][0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5383  							v->VRatioPreY[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5384  							v->VRatioPreC[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5385  							v->BytePerPixelInDETY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5386  							v->BytePerPixelInDETC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5387  							v->DETBufferSizeYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5388  							v->DETBufferSizeCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5389  							&v->UrgentBurstFactorCursorPre[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5390  							&v->UrgentBurstFactorLumaPre[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5391  							&v->UrgentBurstFactorChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5392  							&v->NotUrgentLatencyHidingPre[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5393  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5394  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5395  				v->MaximumReadBandwidthWithPrefetch = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5396  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5397  					v->cursor_bw_pre[k] = v->NumberOfCursors[k] * v->CursorWidth[k][0] * v->CursorBPP[k][0] / 8.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5398  							/ (v->HTotal[k] / v->PixelClock[k]) * v->VRatioPreY[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5399  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5400  					v->MaximumReadBandwidthWithPrefetch =
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5401  							v->MaximumReadBandwidthWithPrefetch
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5402  									+ dml_max4(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5403  											v->VActivePixelBandwidth[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5404  											v->VActiveCursorBandwidth[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5405  													+ v->NoOfDPP[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5406  															* (v->meta_row_bandwidth[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5407  																	+ v->dpte_row_bandwidth[i][j][k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5408  											v->NoOfDPP[i][j][k] * v->prefetch_vmrow_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5409  											v->NoOfDPP[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5410  													* (v->RequiredPrefetchPixelDataBWLuma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5411  															* v->UrgentBurstFactorLumaPre[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5412  															+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5413  																	* v->UrgentBurstFactorChromaPre[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5414  													+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5415  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5416  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5417  				v->NotEnoughUrgentLatencyHidingPre = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5418  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5419  					if (v->NotUrgentLatencyHidingPre[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5420  						v->NotEnoughUrgentLatencyHidingPre = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5421  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5422  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5423  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5424  				v->PrefetchSupported[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5425  				if (v->BandwidthWithoutPrefetchSupported[i][j] == false || v->MaximumReadBandwidthWithPrefetch > v->ReturnBWPerState[i][j]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5426  						|| v->NotEnoughUrgentLatencyHidingPre == 1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5427  					v->PrefetchSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5428  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5429  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5430  					if (v->LineTimesForPrefetch[k] < 2.0 || v->LinesForMetaPTE[k] >= 32.0 || v->LinesForMetaAndDPTERow[k] >= 16.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5431  							|| v->NoTimeForPrefetch[i][j][k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5432  						v->PrefetchSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5433  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5434  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5435  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5436  				v->DynamicMetadataSupported[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5437  				for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5438  					if (v->NoTimeForDynamicMetadata[i][j][k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5439  						v->DynamicMetadataSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5440  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5441  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5442  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5443  				v->VRatioInPrefetchSupported[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5444  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5445  					if (v->VRatioPreY[i][j][k] > 4.0 || v->VRatioPreC[i][j][k] > 4.0 || v->NoTimeForPrefetch[i][j][k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5446  						v->VRatioInPrefetchSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5447  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5448  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5449  				v->AnyLinesForVMOrRowTooLarge = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5450  				for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5451  					if (v->LinesForMetaAndDPTERow[k] >= 16 || v->LinesForMetaPTE[k] >= 32) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5452  						v->AnyLinesForVMOrRowTooLarge = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5453  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5454  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5455  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5456  				v->NextPrefetchMode = v->NextPrefetchMode + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5457  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5458  				if (v->PrefetchSupported[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5459  					v->BandwidthAvailableForImmediateFlip = v->ReturnBWPerState[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5460  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5461  						v->BandwidthAvailableForImmediateFlip = v->BandwidthAvailableForImmediateFlip
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5462  								- dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5463  										v->VActivePixelBandwidth[i][j][k] + v->VActiveCursorBandwidth[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5464  										v->NoOfDPP[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5465  												* (v->RequiredPrefetchPixelDataBWLuma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5466  														* v->UrgentBurstFactorLumaPre[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5467  														+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5468  																* v->UrgentBurstFactorChromaPre[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5469  												+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5470  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5471  					v->TotImmediateFlipBytes = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5472  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5473  						v->TotImmediateFlipBytes = v->TotImmediateFlipBytes
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5474  								+ v->NoOfDPP[i][j][k] * v->PDEAndMetaPTEBytesPerFrame[i][j][k] + v->MetaRowBytes[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5475  								+ v->DPTEBytesPerRow[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5476  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5477  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5478  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5479  						CalculateFlipSchedule(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5480  								mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5481  								HostVMInefficiencyFactor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5482  								v->ExtraLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5483  								v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5484  								v->GPUVMMaxPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5485  								v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5486  								v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5487  								v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5488  								v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5489  								v->PDEAndMetaPTEBytesPerFrame[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5490  								v->MetaRowBytes[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5491  								v->DPTEBytesPerRow[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5492  								v->BandwidthAvailableForImmediateFlip,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5493  								v->TotImmediateFlipBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5494  								v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5495  								v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5496  								v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5497  								v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5498  								v->Tno_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5499  								v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5500  								v->dpte_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5501  								v->meta_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5502  								v->dpte_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5503  								v->meta_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5504  								&v->DestinationLinesToRequestVMInImmediateFlip[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5505  								&v->DestinationLinesToRequestRowInImmediateFlip[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5506  								&v->final_flip_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5507  								&v->ImmediateFlipSupportedForPipe[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5508  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5509  					v->total_dcn_read_bw_with_flip = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5510  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5511  						v->total_dcn_read_bw_with_flip = v->total_dcn_read_bw_with_flip
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5512  								+ dml_max3(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5513  										v->NoOfDPP[i][j][k] * v->prefetch_vmrow_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5514  										v->NoOfDPP[i][j][k] * v->final_flip_bw[k] + v->VActivePixelBandwidth[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5515  												+ v->VActiveCursorBandwidth[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5516  										v->NoOfDPP[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5517  												* (v->final_flip_bw[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5518  														+ v->RequiredPrefetchPixelDataBWLuma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5519  																* v->UrgentBurstFactorLumaPre[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5520  														+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5521  																* v->UrgentBurstFactorChromaPre[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5522  												+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5523  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5524  					v->ImmediateFlipSupportedForState[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5525  					if (v->total_dcn_read_bw_with_flip > v->ReturnBWPerState[i][j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5526  						v->ImmediateFlipSupportedForState[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5527  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5528  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5529  						if (v->ImmediateFlipSupportedForPipe[k] == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5530  							v->ImmediateFlipSupportedForState[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5531  						}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5532  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5533  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5534  					v->ImmediateFlipSupportedForState[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5535  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5536  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5537  				if (v->MaxVStartup <= __DML_VBA_MIN_VSTARTUP__ || v->AnyLinesForVMOrRowTooLarge == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5538  					v->NextMaxVStartup = v->MaxMaxVStartup[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5539  					NextPrefetchModeState = NextPrefetchModeState + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5540  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5541  					v->NextMaxVStartup = v->NextMaxVStartup - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5542  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5543  				v->NextPrefetchMode = v->NextPrefetchMode + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5544  			} while (!((v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5545  					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement != dm_immediate_flip_required)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5546  							|| v->ImmediateFlipSupportedForState[i][j] == true))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5547  					|| (v->NextMaxVStartup == v->MaxMaxVStartup[i][j] && NextPrefetchModeState > MaxPrefetchMode)));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5548  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5549  			CalculateUnboundedRequestAndCompressedBufferSize(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5550  					v->DETBufferSizeInKByte[0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5551  					v->ConfigReturnBufferSizeInKByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5552  					v->UseUnboundedRequesting,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5553  					v->TotalNumberOfActiveDPP[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5554  					NoChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5555  					v->MaxNumDPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5556  					v->CompressedBufferSegmentSizeInkByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5557  					v->Output,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5558  					&UnboundedRequestEnabledThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5559  					&CompressedBufferSizeInkByteThisState);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5560  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5561  			CalculateWatermarksAndDRAMSpeedChangeSupport(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5562  					mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5563  					v->PrefetchModePerState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5564  					v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5565  					v->MaxLineBufferLines,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5566  					v->LineBufferSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5567  					v->WritebackInterfaceBufferSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5568  					v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5569  					v->ReturnBWPerState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5570  					v->SynchronizedVBlank,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5571  					v->dpte_group_bytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5572  					v->MetaChunkSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5573  					v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5574  					v->ExtraLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5575  					v->WritebackLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5576  					v->WritebackChunkSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5577  					v->SOCCLKPerState[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5578  					v->DRAMClockChangeLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5579  					v->SRExitTime,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5580  					v->SREnterPlusExitTime,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5581  					v->SRExitZ8Time,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5582  					v->SREnterPlusExitZ8Time,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5583  					v->ProjectedDCFCLKDeepSleep[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5584  					v->DETBufferSizeYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5585  					v->DETBufferSizeCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5586  					v->SwathHeightYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5587  					v->SwathHeightCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5588  					v->LBBitPerPixel,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5589  					v->SwathWidthYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5590  					v->SwathWidthCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5591  					v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5592  					v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5593  					v->vtaps,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5594  					v->VTAPsChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5595  					v->VRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5596  					v->VRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5597  					v->HTotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5598  					v->PixelClock,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5599  					v->BlendingAndTiming,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5600  					v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5601  					v->BytePerPixelInDETY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5602  					v->BytePerPixelInDETC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5603  					v->DSTXAfterScaler,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5604  					v->DSTYAfterScaler,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5605  					v->WritebackEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5606  					v->WritebackPixelFormat,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5607  					v->WritebackDestinationWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5608  					v->WritebackDestinationHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5609  					v->WritebackSourceHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5610  					UnboundedRequestEnabledThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5611  					CompressedBufferSizeInkByteThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5612  					&v->DRAMClockChangeSupport[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5613  					&v->UrgentWatermark,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5614  					&v->WritebackUrgentWatermark,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5615  					&v->DRAMClockChangeWatermark,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5616  					&v->WritebackDRAMClockChangeWatermark,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5617  					&dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5618  					&dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5619  					&dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5620  					&dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5621  					&v->MinActiveDRAMClockChangeLatencySupported);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5622  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5623  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5624  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5625  	/*PTE Buffer Size Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5626  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5627  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5628  			v->PTEBufferSizeNotExceeded[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5629  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5630  				if (v->PTEBufferSizeNotExceededY[i][j][k] == false || v->PTEBufferSizeNotExceededC[i][j][k] == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5631  					v->PTEBufferSizeNotExceeded[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5632  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5633  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5634  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5635  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5636  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5637  	/*Cursor Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5638  	v->CursorSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5639  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5640  		if (v->CursorWidth[k][0] > 0.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5641  			if (v->CursorBPP[k][0] == 64 && v->Cursor64BppSupport == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5642  				v->CursorSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5643  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5644  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5645  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5646  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5647  	/*Valid Pitch Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5648  	v->PitchSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5649  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5650  		v->AlignedYPitch[k] = dml_ceil(dml_max(v->PitchY[k], v->SurfaceWidthY[k]), v->MacroTileWidthY[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5651  		if (v->DCCEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5652  			v->AlignedDCCMetaPitchY[k] = dml_ceil(dml_max(v->DCCMetaPitchY[k], v->SurfaceWidthY[k]), 64.0 * v->Read256BlockWidthY[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5653  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5654  			v->AlignedDCCMetaPitchY[k] = v->DCCMetaPitchY[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5655  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5656  		if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5657  				&& v->SourcePixelFormat[k] != dm_mono_16 && v->SourcePixelFormat[k] != dm_rgbe
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5658  				&& v->SourcePixelFormat[k] != dm_mono_8) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5659  			v->AlignedCPitch[k] = dml_ceil(dml_max(v->PitchC[k], v->SurfaceWidthC[k]), v->MacroTileWidthC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5660  			if (v->DCCEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5661  				v->AlignedDCCMetaPitchC[k] = dml_ceil(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5662  						dml_max(v->DCCMetaPitchC[k], v->SurfaceWidthC[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5663  						64.0 * v->Read256BlockWidthC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5664  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5665  				v->AlignedDCCMetaPitchC[k] = v->DCCMetaPitchC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5666  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5667  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5668  			v->AlignedCPitch[k] = v->PitchC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5669  			v->AlignedDCCMetaPitchC[k] = v->DCCMetaPitchC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5670  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5671  		if (v->AlignedYPitch[k] > v->PitchY[k] || v->AlignedCPitch[k] > v->PitchC[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5672  				|| v->AlignedDCCMetaPitchY[k] > v->DCCMetaPitchY[k] || v->AlignedDCCMetaPitchC[k] > v->DCCMetaPitchC[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5673  			v->PitchSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5674  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5675  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5676  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5677  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5678  		if (v->ViewportWidth[k] > v->SurfaceWidthY[k] || v->ViewportHeight[k] > v->SurfaceHeightY[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5679  			ViewportExceedsSurface = true;
28a0a14423b855 Wan Jiabing         2021-06-09  5680  			if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5681  					&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_444_8
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5682  					&& v->SourcePixelFormat[k] != dm_rgbe) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5683  				if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5684  						|| v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5685  					ViewportExceedsSurface = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5686  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5687  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5688  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5689  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5690  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5691  	/*Mode Support, Voltage State and SOC Configuration*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5692  	for (i = v->soc.num_states - 1; i >= 0; i--) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5693  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5694  			if (v->ScaleRatioAndTapsSupport == true && v->SourceFormatPixelAndScanSupport == true && v->ViewportSizeSupport[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5695  					&& v->LinkCapacitySupport[i] == true && !P2IWith420 && !DSCOnlyIfNecessaryWithBPP
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5696  					&& !DSC422NativeNotSupported && v->ODMCombine4To1SupportCheckOK[i] == true && v->NotEnoughDSCUnits[i] == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5697  					&& v->DTBCLKRequiredMoreThanSupported[i] == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5698  					&& v->ROBSupport[i][j] == true && v->DISPCLK_DPPCLK_Support[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5699  					&& v->TotalAvailablePipesSupport[i][j] == true && EnoughWritebackUnits == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5700  					&& v->WritebackLatencySupport == true && v->WritebackScaleRatioAndTapsSupport == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5701  					&& v->CursorSupport == true && v->PitchSupport == true && ViewportExceedsSurface == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5702  					&& v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5703  					&& v->TotalVerticalActiveBandwidthSupport[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5704  					&& v->PTEBufferSizeNotExceeded[i][j] == true && v->NonsupportedDSCInputBPC == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5705  					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement != dm_immediate_flip_required)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5706  							|| v->ImmediateFlipSupportedForState[i][j] == true)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5707  					&& FMTBufferExceeded == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5708  				v->ModeSupport[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5709  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5710  				v->ModeSupport[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5711  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5712  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5713  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5714  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5715  	{
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5716  		unsigned int MaximumMPCCombine = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5717  		for (i = v->soc.num_states; i >= 0; i--) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5718  			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5719  				v->VoltageLevel = i;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5720  				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5721  				if (v->ModeSupport[i][0] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5722  					MaximumMPCCombine = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5723  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5724  					MaximumMPCCombine = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5725  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5726  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5727  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5728  		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5729  		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5730  			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5731  			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5732  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5733  		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5734  		v->DRAMSpeed = v->DRAMSpeedPerState[v->VoltageLevel];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5735  		v->FabricClock = v->FabricClockPerState[v->VoltageLevel];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5736  		v->SOCCLK = v->SOCCLKPerState[v->VoltageLevel];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5737  		v->ReturnBW = v->ReturnBWPerState[v->VoltageLevel][MaximumMPCCombine];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5738  		v->maxMpcComb = MaximumMPCCombine;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5739  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5740  }
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5741  

:::::: The code at line 3957 was first introduced by commit
:::::: 74458c081fcfb0423877e630de2746daefdb16e4 drm/amd/display: Add DCN3.1 DML calculation support

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
VLDs/z0CAA==

--LQksG6bCIzRHxTLp--
