Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A739034484B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhCVOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhCVOzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:55:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A022CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:55:09 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so16208429ota.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qBjLygVAvz9+XKIT1YGfokASw756A87roBJgGUybMM=;
        b=K8O25M4uTGxZtlZLrQZNlL/571NxJ72JgK1LEAuBTksMszrHRz2PRcAspRJcz3FyAK
         OvjpalC1siQhgK9TczF8STTyOS2MG20Ni2rXwDHqo0/pufx8cy7infpEc7lXAkxlJLJL
         qQkGS3NpsLYPaOaHTg0HRqGj+27VW8JqFRisQ8M8D1tdjKB/zz9KCxaLIaeqOqv7tXYr
         xvg75GIFeyItShoMNCkR3EjUdOlZHw/z7FPrumGQ37rsgGtfOJuphcqWTA119lCZnDEy
         AuEbtUuKvdPbUed+Jnu2lJIzbS7EFJoPxszFiUzWZ3N0Q/MUVsBkQP434S7aWGKPk0fi
         mSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qBjLygVAvz9+XKIT1YGfokASw756A87roBJgGUybMM=;
        b=oVnsnwTaxClomhzm3/8JY3XhKr1FQg7g/83llkaFmFtzALlEObuKDiX3A0uFnra5fY
         sKJ1riFqT2hWiiUyiNhPMOCBL+VOfkSanp9L28EG0Sgen6b/6+dVwT7IYikQijvDcvd1
         NCkfsqGxBQP5iKD6Att/e5F+IbGEgxHUz1ooGQx4IdM/74KrHglxO42iBvnYFd71wKdW
         X5pA6o9BpNkngi6NcnBUJf3Dhy7IlEUpAZPqHWrMGFVKey6WYFzZHgLlsuq2kTjc2kTa
         O3HGXx/8KgOLlc3ZT4hRNIFFpSZsExHa9y4cO9YqSUrEUzizfmrul630jQFtuBlrbKM2
         JLzw==
X-Gm-Message-State: AOAM532lX8PeZmwN0Iktu/XyoYKOfEn085AeuXsV+wkqBWExkDqoKYOY
        wijLCjq+qfxfMPqzeQUc+o/fHjnLh3xpSrbZTKn1BBB2
X-Google-Smtp-Source: ABdhPJwN/gDeUFxciOwounpLBH2xj+Is9zb5fflIlc0ouOQlzGqPpNNyIU+u+gz187m7LwtwdO9ZUsrjRWfnZUvuNPc=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr281612ots.23.1616424909027; Mon,
 22 Mar 2021 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210319164418.1.I5d51cc12776ee8993a1a54089b548952f75ada41@changeid>
 <CADnq5_OguuMsqT7MVC=ieNZm9mqyVUsGpQDHr59BWtBJJUvFoA@mail.gmail.com>
 <54fc883a-c149-3f43-fb79-3cbff13e7b6a@amd.com> <CAP8nV8rL6eYSDyQ1jyv267ER8_E+rMBQkza2ZYZvwvdE+=sd3Q@mail.gmail.com>
 <CADnq5_O5AOK7B-3AM-qpPXcWD1LgdpnfLMd8NBds0Jfd_tZCBQ@mail.gmail.com> <CAKz_xw0vKSojPqh7QsJPY5eQBLcnteFmL1AJimJTXJmzmQd9kA@mail.gmail.com>
In-Reply-To: <CAKz_xw0vKSojPqh7QsJPY5eQBLcnteFmL1AJimJTXJmzmQd9kA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Mar 2021 10:54:57 -0400
Message-ID: <CADnq5_OarNHRwWe2FZyXA-5fxVpOEW2JxJUUD=n9LAXG7TgQGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Set AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to 0
To:     Evan Benn <evanbenn@chromium.org>
Cc:     Evan Benn <evanbenn@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Eryk Brol <eryk.brol@amd.com>, David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Anand <amistry@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 8:12 PM Evan Benn <evanbenn@chromium.org> wrote:
>
> On Sat, Mar 20, 2021 at 8:36 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Fri, Mar 19, 2021 at 5:31 PM Evan Benn <evanbenn@gmail.com> wrote:
> > >
> > > On Sat, 20 Mar 2021 at 02:10, Harry Wentland <harry.wentland@amd.com> wrote:
> > > > On 2021-03-19 10:22 a.m., Alex Deucher wrote:
> > > > > On Fri, Mar 19, 2021 at 3:23 AM Evan Benn <evanbenn@chromium.org> wrote:
> > > > >>
> > > > >> AMDGPU_DM_DEFAULT_MIN_BACKLIGHT was set to the value of 12
> > > > >> to ensure no display backlight will flicker at low user brightness
> > > > >> settings. However this value is quite bright, so for devices that do not
> > > > >> implement the ACPI ATIF
> > > > >> ATIF_FUNCTION_QUERY_BRIGHTNESS_TRANSFER_CHARACTERISTICS
> > > > >> functionality the user cannot set the brightness to a low level even if
> > > > >> the display would support such a low PWM.
> > > > >>
> > > > >> This ATIF feature is not implemented on for example AMD grunt chromebooks.
> > > > >>
> > > > >> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> > > > >>
> > > > >> ---
> > > > >> I could not find a justification for the reason for the value. It has
> > > > >> caused some noticable regression for users: https://bugzilla.kernel.org/show_bug.cgi?id=203439>>>
> > > > >> Maybe this can be either user controlled or userspace configured, but
> > > > >> preventing users from turning their backlight dim seems wrong.
> > > > >
> > > > > My understanding is that some panels flicker if you set the min to a
> > > > > value too low.  This was a safe minimum if the platform didn't specify
> > > > > it's own safe minimum.  I think we'd just be trading one bug for
> > > > > another (flickering vs not dim enough).  Maybe a whitelist or
> > > > > blacklist would be a better solution?
> > > > >
> > > >
> > > > Yeah, this is a NACK from me as-is for the reasons Alex described.
> > >
> > > Thanks Harry + Alex,
> > >
> > > I agree this solution is not the best.
> > >
> > > >
> > > > I agree a whitelist approach might be best.
> > >
> > > Do you have any idea what an allowlist could be keyed on?
> > > Is the flickering you observed here a function of the panel or the gpu
> > > or some other component?
> > > Maybe we could move the minimum level into the logic for that hardware.
> > >
> >
> > Maybe the panel string from the EDID?  Either that or something from
> > dmi data?  Harry would probably have a better idea.
>
> One problem with keying from panel EDID is that for example the grunt chromebook
> platform has more than 100 different panels already shipped. Add to that that
> repair centers or people repairing their own device will use 'compatible'
> panels. I'm sure the AMD windows laptops have even more variety!
>

Do all of those "compatible" panels work with the min backlight level
of 0?  If so, maybe something platform specific like a DMI string
would make more sense.

Alex


> >
> > Alex
> >
> > > >
> > > > Is this fix perhaps for OLED panels? If so we could use a different
> > > > min-value for OLED panels that don't do PWM, but use 12 for everything else.
> > >
> > > All the chromebooks I have worked with LCD + LED backlight have been
> > > fine with a backlight set to 0.
> > > We do have OLED panels too, but I'm not aware of what they do.
> > >
> > > > Harry
> > > >
> > > > > Alex
> > > > >
> > > > >
> > > > >>
> > > > >> Also reviewed here: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2748377>>>
> > > > >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> > > > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >>
> > > > >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > >> index 573cf17262da..0129bd69b94e 100644
> > > > >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > >> @@ -3151,7 +3151,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
> > > > >>          return 0;
> > > > >>   }
> > > > >>
> > > > >> -#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
> > > > >> +#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 0
> > > > >>   #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
> > > > >>   #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
> > > > >>
> > > > >> --
> > > > >> 2.31.0.291.g576ba9dcdaf-goog
> > > > >>
> > > > >> _______________________________________________
> > > > >> dri-devel mailing list
> > > > >> dri-devel@lists.freedesktop.org
> > > > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel>> _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel>>
> > > >
