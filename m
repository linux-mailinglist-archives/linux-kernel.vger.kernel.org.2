Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18832342638
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCSTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSTbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:31:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D5BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:31:41 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n8so5937007oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kw4RJHeomF/coZU+kZgPBn3/me96DQ9uAU6/T2CZfqA=;
        b=CPVznYpSa5ZclOyAwizrndMBxwkISoeL9kdNAxhrMMW23Q5r41WZI8VmpNkqSyjEW9
         /X86bLXU6dh6xqitsolWKseAFPpEvw1t46XfUHaO+NuN98n0cYAG6OWyNb79lJmwaWh4
         D8OAdnaYQv46jyIJI92CYcvLj/3V7+zcUrfQ6NtwyXsZd1JAu+sYDQ+ftTXpkKxlLr6d
         gt/Y5ntmaVHpe3CSMbCmKtxU0RUl/+sh1LjZI1Rfz16NaL71EFhcoeGh5ZZwpuDNarPJ
         pNZeT39TA/CATe7rApwgjoQP1yQmAsnqjTsx5U0cC1ffEoYphQhpFySJHE3b9e+0ZDDH
         eIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kw4RJHeomF/coZU+kZgPBn3/me96DQ9uAU6/T2CZfqA=;
        b=tnLupkgPYtY7mwZuUQL4xKBXF71Q6dNdm2mjhcC7tJAlZFwHO2Qr17NsrknIt7BVT5
         sp0Cr7jk5qEEnJB+bViZEkt637EB0owwdTQuLWFts7dIlA4QSfL/U5dQiQNkMCpG3vlY
         JvSq8vvRmIQe5TFPkp8UV0nWMID0n9Jv9MyS/kR4kgLowTMLO/cmKTjPmrVifR8ySLAf
         96NcLrUQtAkh/XhQGzqKTTXIGIDTka4cFLYLCWEVh1jrDphwTE+tGudgcc6IAS94DIne
         rdp2vk5UgoMk+TbmBZWjvmeoa+XYCr/jt6sXWYObqdse9jESV8p+wrbPsCaEywPESPT0
         dCuA==
X-Gm-Message-State: AOAM531yOiDbWUbuTFcOkzfNqItYEeh7YpEBWSm/gSnbcJdMxRhIv8no
        k94eRd5luI8b3fe45786CXFW2EGK9LoHaDd9hC8=
X-Google-Smtp-Source: ABdhPJxZL5qATrG/zALbPxohf/D9Vc8WgssH3t/fubUH19eY7TpxSR1JSlKBE0w65kJiD1EsuHWh9uwFPcV21w7IF68=
X-Received: by 2002:aca:4748:: with SMTP id u69mr1979504oia.5.1616182300436;
 Fri, 19 Mar 2021 12:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org>
 <20210319082428.3294591-7-lee.jones@linaro.org> <CADnq5_O7wFLzp7THHN15Diyw52XUN7w+HMks227LWcUvmXShcw@mail.gmail.com>
 <2ec1225f-4bf1-41b7-0d00-2b11eab90c94@amd.com> <a74c5599-e519-2b02-f16b-31e352872a31@amd.com>
In-Reply-To: <a74c5599-e519-2b02-f16b-31e352872a31@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Mar 2021 15:31:29 -0400
Message-ID: <CADnq5_PanwrUoaZbU0vnovkcbQwdw+UUsTZ0-tyKgLWpcTn7=g@mail.gmail.com>
Subject: Re: [PATCH 06/19] drm/amd/display/dc/calcs/dce_calcs: Move some large
 variables from the stack to the heap
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Lee Jones <lee.jones@linaro.org>, Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Harry Wentland <hwentlan@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 2:47 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 19.03.21 um 19:26 schrieb Harry Wentland:
> > On 2021-03-19 2:13 p.m., Alex Deucher wrote:
> >> + Harry, Nick
> >>
> >> On Fri, Mar 19, 2021 at 4:24 AM Lee Jones <lee.jones@linaro.org> wrote=
:
> >>>
> >>> Fixes the following W=3D1 kernel build warning(s):
> >>>
> >>>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In
> >>> function =E2=80=98calculate_bandwidth=E2=80=99:
> >>> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1:
> >>> warning: the frame size of 1216 bytes is larger than 1024 bytes
> >>> [-Wframe-larger-than=3D]
> >>>
> >>> Cc: Harry Wentland <harry.wentland@amd.com>
> >>> Cc: Leo Li <sunpeng.li@amd.com>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> >>> Cc: David Airlie <airlied@linux.ie>
> >>> Cc: Daniel Vetter <daniel@ffwll.ch>
> >>> Cc: Colin Ian King <colin.king@canonical.com>
> >>> Cc: amd-gfx@lists.freedesktop.org
> >>> Cc: dri-devel@lists.freedesktop.org
> >>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>> ---
> >>>   .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 32
> >>> ++++++++++++++++---
> >>>   1 file changed, 28 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> >>> b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> >>> index e633f8a51edb6..9d8f2505a61c2 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> >>> @@ -98,16 +98,16 @@ static void calculate_bandwidth(
> >>>          int32_t num_cursor_lines;
> >>>
> >>>          int32_t i, j, k;
> >>> -       struct bw_fixed yclk[3];
> >>> -       struct bw_fixed sclk[8];
> >>> +       struct bw_fixed *yclk;
> >>> +       struct bw_fixed *sclk;
> >>>          bool d0_underlay_enable;
> >>>          bool d1_underlay_enable;
> >>>          bool fbc_enabled;
> >>>          bool lpt_enabled;
> >>>          enum bw_defines sclk_message;
> >>>          enum bw_defines yclk_message;
> >>> -       enum bw_defines tiling_mode[maximum_number_of_surfaces];
> >>> -       enum bw_defines surface_type[maximum_number_of_surfaces];
> >>> +       enum bw_defines *tiling_mode;
> >>> +       enum bw_defines *surface_type;
> >>>          enum bw_defines voltage;
> >>>          enum bw_defines pipe_check;
> >>>          enum bw_defines hsr_check;
> >>> @@ -122,6 +122,22 @@ static void calculate_bandwidth(
> >>>          int32_t number_of_displays_enabled_with_margin =3D 0;
> >>>          int32_t number_of_aligned_displays_with_no_margin =3D 0;
> >>>
> >>> +       yclk =3D kcalloc(3, sizeof(*yclk), GFP_KERNEL);
> >>> +       if (!yclk)
> >>> +               return;
> >>> +
> >>> +       sclk =3D kcalloc(8, sizeof(*sclk), GFP_KERNEL);
> >>> +       if (!sclk)
> >>> +               goto free_yclk;
> >>> +
> >>> +       tiling_mode =3D kcalloc(maximum_number_of_surfaces,
> >>> sizeof(*tiling_mode), GFP_KERNEL);
> >>> +       if (!tiling_mode)
> >>> +               goto free_sclk;
> >>> +
> >>> +       surface_type =3D kcalloc(maximum_number_of_surfaces,
> >>> sizeof(*surface_type), GFP_KERNEL);
> >>> +       if (!surface_type)
> >>> +               goto free_tiling_mode;
> >>> +
> >>
> >>
> >> Harry or Nick can correct me if I'm wrong, but for this patch and the
> >> next one, I think this can be called from an atomic context.
> >>
> >
> > From what I can see this doesn't seem the case. If I'm missing
> > something someone please correct me.
>
> Have you taken into account that using FP functions require atomic
> context as well?
>
> We had quite a bunch of problems with that and had to replace some
> GFP_KERNEL with GFP_ATOMIC in the DC code because of this.
>
> Could of course be that this code here isn't affected by that, but
> better save than sorry.

DCE hardware uses fixed point math so that should be ok.  It's just
the newer DCN hardware that requires FP.

Alex


>
> Christian.
>
> >
> > This and the next (06/19) patch are both
> > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >
> > Harry
> >
> >> Alex
> >>
> >>>          yclk[low] =3D vbios->low_yclk;
> >>>          yclk[mid] =3D vbios->mid_yclk;
> >>>          yclk[high] =3D vbios->high_yclk;
> >>> @@ -2013,6 +2029,14 @@ static void calculate_bandwidth(
> >>>                          }
> >>>                  }
> >>>          }
> >>> +
> >>> +       kfree(surface_type);
> >>> +free_tiling_mode:
> >>> +       kfree(tiling_mode);
> >>> +free_yclk:
> >>> +       kfree(yclk);
> >>> +free_sclk:
> >>> +       kfree(sclk);
> >>>   }
> >>>
> >>> /********************************************************************=
***********
> >>> --
> >>> 2.27.0
> >>>
> >>> _______________________________________________
> >>> dri-devel mailing list
> >>> dri-devel@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/dri-devel>
>
