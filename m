Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9533A996
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhCOCXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhCOCXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:23:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E8DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=1ahWSU1keKnyalV1HZQUNZ0Cd+VYVx3givR8mdK3q7U=; b=SiSoSrt3GSUQYDKi0er1x9KDO/
        Wwi1LuYneaq7haCjtlrV7uBXxHwvGr+Yt2c63NOIlcOvCs73Ngy55pBl8RkspCz3gRv0uutCTUCct
        dRnPgT+rCMd6EA1t7zKHQ0yxf9MSxZr4v+TjWfqZsnhxyEECMs2GArVw/0p1+buEAZXx87CXJVvY3
        QB1Od+61xwsg+SghzH1c6j2Z8/m5UJnlDmo3VQ6y8Xjc68986pZ/xmGm2nWF+8ndmj/8lFMD2SziL
        jWssbgZpnZkhsecWTxY83K0ZxQ9HxfwC0eNXdTaE3i6oF2ovN0609zKg1AsGMYWNfEG2XeBApiP3X
        E+XTizrg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLcsw-001FMm-Oq; Mon, 15 Mar 2021 02:23:25 +0000
Subject: Re: [PATCH] gpu: drm: amd: pm: Mundane typo fix in the file
 amdgpu_pm.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        nirmoy.das@amd.com, kevin1.wang@amd.com, Hawking.Zhang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210315015748.1380807-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6f78caff-a30a-de51-a1fd-87f4a54123fe@infradead.org>
Date:   Sun, 14 Mar 2021 19:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315015748.1380807-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/21 6:57 PM, Bhaskar Chowdhury wrote:
> 
> s/maxmum/maximum/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 7b6ef05a1d35..7af74d236600 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3143,7 +3143,7 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>   *
>   * - fan1_min: an minimum value Unit: revolution/min (RPM)

                  a minimum
>   *
> - * - fan1_max: an maxmum value Unit: revolution/max (RPM)
> + * - fan1_max: an maximum value Unit: revolution/max (RPM)

                  a maximum
>   *
>   * - fan1_input: fan speed in RPM
>   *
> --

and please follow the Subject: style:

$ git log --online drivers/gpu/drm/amd/pm

48123d068fcb drm/amd/pm: correct the watermark settings for Polaris
50ceb1fe7acd drm/amd/pm: bug fix for pcie dpm
6efda1671312 drm/amd/pm: correct Arcturus mmTHM_BACO_CNTL register address
992ace410c32 drm/amdgpu/swsmu/vangogh: Only use RLCPowerNotify msg for disable
e3746696e78f drm/amdgpu/pm: make unsupported power profile messages debug
7b3d19a76d68 drm/amd/pm/swsmu: Avoid using structure_size uninitialized in smu_cmn_init_soft_gpu_metrics
d7ef887f2f8e drm/amd/pm: make the error log more clear for fine grain tuning function
6ef28889b413 drm/amd/pm: enable LCLK DS
ae07970a0621 drm/amd/pm: add support for hwmon control of slow and fast PPT limit on vangogh
52d720b1a800 drm/amd/pm: modify the power limit level parameter from bool to enum type
b36c1024dc32 drm/amd/pm: update the smu v11.5 smc header for vangogh
de4b7cd8cb87 drm/amd/pm/swsmu: unify the init soft gpu metrics function
680602d6c2d6 drm/amd/pm: enable DCS
137aac26a2ed drm/amdgpu/smu12: fix power reporting on renoir
62826b86085d drm/amd/pm: enable ACDC feature
c915ef890d5d drm/amdgpu: Prevent shift wrapping in amdgpu_read_mask()
bb377febb10f drm/amd/pm: Disable GFXOFF when GFX DPM or PG disabled
e487cb54db1b drm/amd/pm: remove some useless code for vangogh
c9021a6e58c8 drm/amd/pm: fill in the data member of v2 gpu metrics table for vangogh
4954a76add70 drm/amdgpu/swsmu: use percent rather than rpm for manual fan control (v2)

-- 
~Randy

