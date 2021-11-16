Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D094532E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhKPNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:36:03 -0500
Received: from lithium.sammserver.com ([168.119.122.30]:49106 "EHLO
        lithium.sammserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhKPNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:35:58 -0500
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id AEBD13115D1B;
        Tue, 16 Nov 2021 14:33:00 +0100 (CET)
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 3BF2E2534D;
        Tue, 16 Nov 2021 14:32:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1637069580; bh=rsBoRUnLkAEXPVbzZQ/EmyVepqJ2ugaPXO0wds7juOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmqtAhN0PjzmJnp5Ads5EPwiG0Da0AWI9vRxkfs/9FYiwOjJ0cfLMr7sjnOxNX29y
         0IFa/YtCuoowxkDtJc4CpvUosq3gThzCg4FFqlK1L0E1CWhczN4i16DSWn1VK62GgW
         uU9qp+WVFue/mJ4spMXpIRLzZKRBmqFX5vAPPWVQ=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 268DD1421378; Tue, 16 Nov 2021 14:32:59 +0100 (CET)
Date:   Tue, 16 Nov 2021 14:32:59 +0100
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Roman Li <Roman.Li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: Backlight control broken on UM325 (OLED) on 5.15 (bisected)
Message-ID: <20211116133259.svayrqaiivaubkjp@fastboi.localdomain>
References: <20211114105657.b57pjojiv72iopg5@fastboi.localdomain>
 <CADnq5_NF++xE6Jj32Wy2ZGALo4pOGt3yTCoj5HU37tKO3Ce=Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NF++xE6Jj32Wy2ZGALo4pOGt3yTCoj5HU37tKO3Ce=Fg@mail.gmail.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED,URIBL_ZEN_BLOCKED_OPENDNS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sammserver.tu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

thank you for your response.

On 15.11.2021 10:43, Alex Deucher wrote:
> [...]
>
> That patch adds support for systems with multiple backlights.  Do you
> have multiple backlight devices now?  If so, does the other one work?

No, there is still only one backlight device -- amdgpu_bl0.
> 
> Can you also try this patch?
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4811b0faafd9..67163c9d49e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -854,8 +854,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>                 if (amdgpu_device_has_dc_support(adev)) {
>  #if defined(CONFIG_DRM_AMD_DC)
>                         struct amdgpu_display_manager *dm = &adev->dm;
> -                       if (dm->backlight_dev[0])
> -                               atif->bd = dm->backlight_dev[0];
> +                       if (dm->backlight_dev[1])
> +                               atif->bd = dm->backlight_dev[1];
>  #endif
>                 } else {
>                         struct drm_encoder *tmp;
> 

There is no difference in behaviour after applying the patch.

Samuel

> 
> Alex
> 
> >
> > Regards,
> > Samuel Čavoj
> >
> > [0]: https://www.reddit.com/r/AMDLaptops/comments/qst0fm/after_updating_to_linux_515_my_brightness/
