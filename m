Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7096B3424B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSSb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:31:33 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:31:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso9435319otq.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pTtEztAlZlvdcvUPIJRMBRJNUX2fnT4BTRPLkCRFrF0=;
        b=LOztUkjI6cqKImroYp9bQSvDB1j8J+tLj6YfIPd3qV+9YqsIJS52+lZaIUy9vl82Js
         Sz+TsObvYHsMvvX/NRVb7+mTh1BL24KLH9jn7wkyNRKYxSv21Cz+feuuxN+rrbkRDYq4
         xh3NUk/CrTXldsQoQWl3LHmu9oNEmkoRguJOryyE5lYEMpdZ9IviKsYWXeksjebPG8X0
         gU2VVvKHDOMBAJwyJUQ+DR4uoq1nxdCIS2HS8dn5yfeENEVjHJteT8lWTp1Wcpa3FXAH
         iQwXbHNoxQ9BVuGTL0LVulIFlPr4cyuzZliIXypQTSO4YzkatOobvgKwZNAoI73lWeVX
         yVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pTtEztAlZlvdcvUPIJRMBRJNUX2fnT4BTRPLkCRFrF0=;
        b=J8MaDFtWiUS9pYXzJBhCmeRKRC3humXksqIJNuSVH9PaTHXBiOXbrtkQVYvmizAjDx
         iSDGpNvOkEEvz2uXJ+85zOWo6irBA2GuajEaYKnkYn0axltkf6cYalKm7AR6m1ipFcLf
         3h72VCzkFjVaIkY8llngCs/I/JvZvFbaiwxcVhmgMv0ctnv7J7pUDHTjN/jcKaCdDe3Q
         AqxGEyBjh4oLIPdTnlcyjPiEo5o3AcjLm55vQGB14iIFXqd90fz5ZlFkWLm8UBs7raRc
         ntdgwpDfdXv9xqMGAmh/CHFv/txMPmjuMpC1pyfna7RTYs1VofdQuPD9c6oGPrUkfaiT
         cdVQ==
X-Gm-Message-State: AOAM530XiXducDSFu/OQyqmIFV7QneWwVMQA+vwI0DUijPhknlzrZhek
        Dl18UcEZOeliToFmjYl6CZA0bk9RyJeYi6bWMUk=
X-Google-Smtp-Source: ABdhPJyv194Gm+/npl0MnBJVaTkDD5H+6oETqSm2t2vv6lboTdLS0lRr8NY61j/L55ntJoAahziF9hSt3Jf9MGC+C74=
X-Received: by 2002:a9d:750e:: with SMTP id r14mr2142229otk.311.1616178692466;
 Fri, 19 Mar 2021 11:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org>
 <20210319082428.3294591-7-lee.jones@linaro.org> <CADnq5_O7wFLzp7THHN15Diyw52XUN7w+HMks227LWcUvmXShcw@mail.gmail.com>
 <2ec1225f-4bf1-41b7-0d00-2b11eab90c94@amd.com>
In-Reply-To: <2ec1225f-4bf1-41b7-0d00-2b11eab90c94@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Mar 2021 14:31:21 -0400
Message-ID: <CADnq5_OrwEo0uoFhXyRRtf9cxN6z++fFVrniW8421Rbu8ZjfjQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] drm/amd/display/dc/calcs/dce_calcs: Move some large
 variables from the stack to the heap
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 2:26 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
> On 2021-03-19 2:13 p.m., Alex Deucher wrote:
> > + Harry, Nick
> >
> > On Fri, Mar 19, 2021 at 4:24 AM Lee Jones <lee.jones@linaro.org> wrote:
> >>
> >> Fixes the following W=3D1 kernel build warning(s):
> >>
> >>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In funct=
ion =E2=80=98calculate_bandwidth=E2=80=99:
> >>   drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1: w=
arning: the frame size of 1216 bytes is larger than 1024 bytes [-Wframe-lar=
ger-than=3D]
> >>
> >> Cc: Harry Wentland <harry.wentland@amd.com>
> >> Cc: Leo Li <sunpeng.li@amd.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> >> Cc: David Airlie <airlied@linux.ie>
> >> Cc: Daniel Vetter <daniel@ffwll.ch>
> >> Cc: Colin Ian King <colin.king@canonical.com>
> >> Cc: amd-gfx@lists.freedesktop.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> ---
> >>   .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 32 ++++++++++++++++-=
--
> >>   1 file changed, 28 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/driver=
s/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> >> index e633f8a51edb6..9d8f2505a61c2 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> >> @@ -98,16 +98,16 @@ static void calculate_bandwidth(
> >>          int32_t num_cursor_lines;
> >>
> >>          int32_t i, j, k;
> >> -       struct bw_fixed yclk[3];
> >> -       struct bw_fixed sclk[8];
> >> +       struct bw_fixed *yclk;
> >> +       struct bw_fixed *sclk;
> >>          bool d0_underlay_enable;
> >>          bool d1_underlay_enable;
> >>          bool fbc_enabled;
> >>          bool lpt_enabled;
> >>          enum bw_defines sclk_message;
> >>          enum bw_defines yclk_message;
> >> -       enum bw_defines tiling_mode[maximum_number_of_surfaces];
> >> -       enum bw_defines surface_type[maximum_number_of_surfaces];
> >> +       enum bw_defines *tiling_mode;
> >> +       enum bw_defines *surface_type;
> >>          enum bw_defines voltage;
> >>          enum bw_defines pipe_check;
> >>          enum bw_defines hsr_check;
> >> @@ -122,6 +122,22 @@ static void calculate_bandwidth(
> >>          int32_t number_of_displays_enabled_with_margin =3D 0;
> >>          int32_t number_of_aligned_displays_with_no_margin =3D 0;
> >>
> >> +       yclk =3D kcalloc(3, sizeof(*yclk), GFP_KERNEL);
> >> +       if (!yclk)
> >> +               return;
> >> +
> >> +       sclk =3D kcalloc(8, sizeof(*sclk), GFP_KERNEL);
> >> +       if (!sclk)
> >> +               goto free_yclk;
> >> +
> >> +       tiling_mode =3D kcalloc(maximum_number_of_surfaces, sizeof(*ti=
ling_mode), GFP_KERNEL);
> >> +       if (!tiling_mode)
> >> +               goto free_sclk;
> >> +
> >> +       surface_type =3D kcalloc(maximum_number_of_surfaces, sizeof(*s=
urface_type), GFP_KERNEL);
> >> +       if (!surface_type)
> >> +               goto free_tiling_mode;
> >> +
> >
> >
> > Harry or Nick can correct me if I'm wrong, but for this patch and the
> > next one, I think this can be called from an atomic context.
> >
>
>  From what I can see this doesn't seem the case. If I'm missing
> something someone please correct me.
>
> This and the next (06/19) patch are both
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Thanks.  I've applied them.

Alex


>
> Harry
>
> > Alex
> >
> >>          yclk[low] =3D vbios->low_yclk;
> >>          yclk[mid] =3D vbios->mid_yclk;
> >>          yclk[high] =3D vbios->high_yclk;
> >> @@ -2013,6 +2029,14 @@ static void calculate_bandwidth(
> >>                          }
> >>                  }
> >>          }
> >> +
> >> +       kfree(surface_type);
> >> +free_tiling_mode:
> >> +       kfree(tiling_mode);
> >> +free_yclk:
> >> +       kfree(yclk);
> >> +free_sclk:
> >> +       kfree(sclk);
> >>   }
> >>
> >>   /*******************************************************************=
************
> >> --
> >> 2.27.0
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel>
