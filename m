Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275AD426D91
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbhJHPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:37:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36932 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhJHPhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:37:50 -0400
Received: from zn.tnic (p200300ec2f0d5600b5f996c39c66b7a4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5600:b5f9:96c3:9c66:b7a4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B6AC1EC04B9;
        Fri,  8 Oct 2021 17:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633707354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FyemXY0AOdlICp0KI0nDs+rgSiJMVPqaGO8BhnjPb6o=;
        b=lcxW2fredBQl+/XQ+czUhGjIofkM75FwTMqqiuee+37/OGvOZVPL7Ce1zOgCObeBOJAiuQ
        00d7Q3B9SSZ2oztutdJIdACD/g9AWECYzvHNgf9gwmZSzmLiAWEeiplAgkghPYWqmizG9b
        KVp5GROArNCvaFvnofDpMp6r2cFFTok=
Date:   Fri, 8 Oct 2021 17:35:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Quan, Evan" <Evan.Quan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>
Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Message-ID: <YWBlVzZK35ecQHNZ@zn.tnic>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 11:12:35AM -0400, Alex Deucher wrote:
> Can you try swapping the order of
> amdgpu_device_ip_set_powergating_state() and
> amdgpu_device_ip_set_clockgating_state() in the patch?

Nope, the diff below didn't change things.

Should I comment them out one by one and see whether the clockgating or
the powergating causes it?

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index bc571833632e..99e3d697cc24 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -561,10 +561,10 @@ static int uvd_v6_0_hw_fini(void *handle)
 	} else {
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
 	}
 
 	if (RREG32(mmUVD_STATUS) != 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 9de66893ccd6..a36612357d0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -507,10 +507,10 @@ static int vce_v3_0_hw_fini(void *handle)
 		amdgpu_dpm_enable_vce(adev, false);
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
 	}
 
 	r = vce_v3_0_wait_for_idle(handle);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
