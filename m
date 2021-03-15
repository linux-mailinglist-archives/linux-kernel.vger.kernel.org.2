Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E404133BF6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCOPGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhCOPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:05:34 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:05:32 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so5283256otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZQnZyrqFY28jgPfI3hD0i2MzFBu70J581ahh1orOdQ=;
        b=DXvFhFSNldlg/sHML4WNqrrUZ8LKgUCpPS9WBc6E/U2NWuBcrI0im0Gk3ZgJTo9FFS
         EyjWMNrn7ReCbLGft0UB7ffBYnoi9j6ZbUuFOT8hzIfYrUML66tFyf036ggfGfiI3Vz2
         1i9cIJHRxxDtio3ilHRIlNOFCP7miYFOA/Rh8YKODEBEjkNuK8m9zf5mZPUO5UAu5RFB
         yAAAYtJ3nX5LCkpIiXV6ZKEsiyyE0MnO76wWLJ3Ntdj8FdFnhyEy38dXQudw7LhwyEGn
         u+IQxz1lA5M2VjqCyqgHwm2marD4Mk9IMVnwnRWHjqKkOUSV77Y3btQ+nZtMVRodLWLq
         xO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZQnZyrqFY28jgPfI3hD0i2MzFBu70J581ahh1orOdQ=;
        b=YnRMulDXhlK7e0GhQwCMMbvMOSjvthmn2xmdBiUC7QamfVqf3B5Kay5kztHVeP6x0T
         1YDTef1dciox4aRV3fZzrXHwJMWe40/P/DSOSarQviHqP6YLuO/9JDAKdo7jHx0+GgK/
         7AHOJiO6vg2ugLtfhXQ4NJCEkJ3YPpq9C3ivpEKWQZ59xQy0gAoJARal+j/RD+jldNmP
         0YcJXmFxfgNWAhmpLGiAJg3fC7VH/3umfAwYUeUIw0jLhigwEU37wCvXaBboxRtXc0E6
         9XR7K4/BKJrDg50XoT/3Lxgv9MyeG6pX/VG6YvlwNfQfqrh6vZ0RwhFU6R9MBA6aie2g
         tWEQ==
X-Gm-Message-State: AOAM531Vg9i7Q3c/QilvDPOEHYtkKaDcbE9YZIXw88eQMCrefidgs81O
        gY7zl6Ka71tpw1XfC1mV19QhYWAcyeKHhenoZUw=
X-Google-Smtp-Source: ABdhPJzrAEFT2o/9swfVF2swMUJVSSF3V+yAn05NjTJHsCllNpTc0GxkZW4A+DZd5St5/YDiV2jKRtTrkndE3Sm9L0A=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr14343647ota.311.1615820731926;
 Mon, 15 Mar 2021 08:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <PSXP216MB0438E23D0F4C2DFF2D9B8686806D9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438E23D0F4C2DFF2D9B8686806D9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Mar 2021 11:05:21 -0400
Message-ID: <CADnq5_Mqc3H07BtJbaGpt8XGnpXgaZvxDsS_e0cnZ++kWdQR-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] amdgpu: use MMIO to init atombios if device is
 Thunderbolt / USB4 attached
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 4:04 AM Nicholas Johnson
<nicholas.johnson-opensource@outlook.com.au> wrote:
>
> When using some Thunderbolt hosts using BIOS-assisted PCI enumeration
> with IO BAR assigned, we get an atombios timeout, such as:
>
> [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
> [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B456 (len 304, WS 4, PS 0) @ 0xB51B
> [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B104 (len 183, WS 0, PS 8) @ 0xB17E
> amdgpu 0000:08:00.0: amdgpu: gpu post error!
> amdgpu 0000:08:00.0: amdgpu: Fatal error during GPU init
> amdgpu: probe of 0000:08:00.0 failed with error -22
>
> A workaround is to use MMIO to access ATOMBIOS when device is
> Thunderbolt / USB4 attached.

Missing your signed-off-by.  Also, we can just remove the legacy IO
callbacks altogether.  They are leftover from radeon and not required
at all on amdgpu.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 86add0f4e..5d16ec10d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1999,11 +1999,15 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>         atom_card_info->reg_read = cail_reg_read;
>         atom_card_info->reg_write = cail_reg_write;
>         /* needed for iio ops */
> -       if (adev->rio_mem) {
> +       if (adev->rio_mem && !pci_is_thunderbolt_attached(adev->pdev)) {
>                 atom_card_info->ioreg_read = cail_ioreg_read;
>                 atom_card_info->ioreg_write = cail_ioreg_write;
>         } else {
> -               DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
> +               if (pci_is_thunderbolt_attached(adev->pdev))
> +                       DRM_DEBUG("Device is attached via Thunderbolt / USB4. Using MMIO to access ATOM BIOS\n");
> +               else
> +                       DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
> +
>                 atom_card_info->ioreg_read = cail_reg_read;
>                 atom_card_info->ioreg_write = cail_reg_write;
>         }
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
