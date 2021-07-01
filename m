Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3AC3B8EDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhGAIgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235159AbhGAIgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C9426144B;
        Thu,  1 Jul 2021 08:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625128414;
        bh=esVTnd8ExDuxBM3XS/RqhLAB72n8t3bLQh1uiKPdLE8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RVXcb9Y4hUyG6hVcMc90ECxIdciJOzCd38Lw9Vs1lv/WfoH6hBCnSswNUJsCCjF+i
         8XiJi00gtlipOP9DXE7A/GlVz+RvCtR+u3kNXtT7CIwLVYwK0dVa9S1ywiYom96gzO
         ZNrmxskfD7C/NqWg/xv2Z/YTX99zWVDSIo7wgpj4Xw9Yls8RuaNxO+V5Kx47tOU49a
         VFyQ+1zpsO8SUuMMmI427TMJSyv2jj7+Lzlyak0Ki8fDQz5cLamq6+xAUBgOy49B5N
         ohuLBTwe/TJUHHnOju378Kz5PFz2HZuuflnNYzaFoS85NVF95LYVOXFoDbb/Q40tWk
         xJttm41WUyo5A==
Date:   Thu, 1 Jul 2021 10:33:31 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>
cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@ucw.cz>
Subject: Re: [PATCH v2] drm/amdgpu: Avoid printing of stack contents on
 firmware load error
In-Reply-To: <nycvar.YFH.7.76.2106241310000.18969@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2107011032520.18969@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2106241135440.18969@cbobk.fhfr.pm> <YNRnDTD1fdpZOXB8@suse.com> <nycvar.YFH.7.76.2106241310000.18969@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021, Jiri Kosina wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> In case when psp_init_asd_microcode() fails to load ASD microcode file, 
> psp_v12_0_init_microcode() tries to print the firmware filename that 
> failed to load before bailing out.
> 
> This is wrong because:
> 
> - the firmware filename it would want it print is an incorrect one as
>   psp_init_asd_microcode() and psp_v12_0_init_microcode() are loading
>   different filenames
> - it tries to print fw_name, but that's not yet been initialized by that
>   time, so it prints random stack contents, e.g.
> 
>     amdgpu 0000:04:00.0: Direct firmware load for amdgpu/renoir_asd.bin failed with error -2
>     amdgpu 0000:04:00.0: amdgpu: fail to initialize asd microcode
>     amdgpu 0000:04:00.0: amdgpu: psp v12.0: Failed to load firmware "\xfeTO\x8e\xff\xff"
> 
> Fix that by bailing out immediately, instead of priting the bogus error
> message.

Friendly ping on this one too; priting a few bytes of stack is not a 
*huge* info leak, but I believe it should be fixed nevertheless.

Thanks.

> 
> Reported-by: Vojtech Pavlik <vojtech@ucw.cz>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>


> ---
> 
> v1 -> v2: remove now-unused label
> 
>  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index c4828bd3264b..b0ee77ee80b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -67,7 +67,7 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
>  
>  	err = psp_init_asd_microcode(psp, chip_name);
>  	if (err)
> -		goto out;
> +		return err;
>  
>  	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
>  	err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
> @@ -80,7 +80,7 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
>  	} else {
>  		err = amdgpu_ucode_validate(adev->psp.ta_fw);
>  		if (err)
> -			goto out2;
> +			goto out;
>  
>  		ta_hdr = (const struct ta_firmware_header_v1_0 *)
>  				 adev->psp.ta_fw->data;
> @@ -105,10 +105,9 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
>  
>  	return 0;
>  
> -out2:
> +out:
>  	release_firmware(adev->psp.ta_fw);
>  	adev->psp.ta_fw = NULL;
> -out:
>  	if (err) {
>  		dev_err(adev->dev,
>  			"psp v12.0: Failed to load firmware \"%s\"\n",
> -- 
> 2.12.3
> 

-- 
Jiri Kosina
SUSE Labs

