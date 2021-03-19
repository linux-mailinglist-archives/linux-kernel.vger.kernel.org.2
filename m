Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF843427E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCSVg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhCSVgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:36:07 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1DEC061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:36:06 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l79so6271827oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gd8/LS9G/arRtGpvSNTnyt+X8KIH+uan5nzLifBdm54=;
        b=llXCL9/c8u+lPuPiYaXG3P6ezw9Xx6uGG7S+O4ZtL8gIcFQGCrOOCDj5RUpO/xuCpu
         iGrcysjj1ps8KVwpcku9vLv6dQTkLk4Lq9JxPxpuoTgrZRQW4X5dWeWipeEeP/DKVbEX
         H/VBrceoqc59JQnVhZvsJDFy0mYkdM7NMnP15TUNCvG6n1/jXBH0+nHxmmfbAzRjMUWc
         5gEVpKEd1TvNT+ZCcXHntTIbMAgLinN2LslONFFh2aPaoR8f1fecoUJfZbiA3XU5HZpI
         n6/dx4JQoTEHug8AvQwiFCuhJBKLl/EHS2TlDa/Tghr0p1RC7OXMv6tPCPwC6m0DBgKg
         NIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd8/LS9G/arRtGpvSNTnyt+X8KIH+uan5nzLifBdm54=;
        b=IODZGfl359QA7dTIaYE8c+v1tQ5NWOmupyu0561q3LZ1w57LCLGYJh90EJa8zwcQWg
         jIJbhPY536a6fzYrvLys04arArkwfpN1x4SgUO4Vpj89S/LQgZ5zcDtwGJFIvB5rbHzu
         AbwFUtwshQQi/OmkwcQdF/fyhurp5xJqsG6OxM15PpGxheJ7zUBodyKombaU0jZk4Dej
         QQHOLrFMBX9AbyPfbL9i2aK457ER4XDmYQtiDtY+gLqHFwGBmgqznyeFUSSFZ2fOwEVm
         I/cBcExcxGeJTDog2S8R2tOXBfyCUaDbYDlehqxvLIIvSef6wTaYmcxP4kdvhx3Vh9Cx
         lRwA==
X-Gm-Message-State: AOAM532D36WT1EELOaHO0qjWO7LaS9pW3Xqg+DksgdAnZMe28ioJxtzY
        19aYw8iQd2DSbYQEm8DDFPO8eRsaPus893l2R2l+6eNm
X-Google-Smtp-Source: ABdhPJw1aufG+kZg8BweLNMDZwZcwQT/Rj4rIr1Z2VE+Qg+T+1hZHQroIxBcW2e/AAzj4sICZPIxY7Z57VTL1hL6er4=
X-Received: by 2002:aca:af10:: with SMTP id y16mr2440946oie.120.1616189766078;
 Fri, 19 Mar 2021 14:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210319164418.1.I5d51cc12776ee8993a1a54089b548952f75ada41@changeid>
 <CADnq5_OguuMsqT7MVC=ieNZm9mqyVUsGpQDHr59BWtBJJUvFoA@mail.gmail.com>
 <54fc883a-c149-3f43-fb79-3cbff13e7b6a@amd.com> <CAP8nV8rL6eYSDyQ1jyv267ER8_E+rMBQkza2ZYZvwvdE+=sd3Q@mail.gmail.com>
In-Reply-To: <CAP8nV8rL6eYSDyQ1jyv267ER8_E+rMBQkza2ZYZvwvdE+=sd3Q@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Mar 2021 17:35:55 -0400
Message-ID: <CADnq5_O5AOK7B-3AM-qpPXcWD1LgdpnfLMd8NBds0Jfd_tZCBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Set AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to 0
To:     Evan Benn <evanbenn@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Evan Benn <evanbenn@chromium.org>,
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

On Fri, Mar 19, 2021 at 5:31 PM Evan Benn <evanbenn@gmail.com> wrote:
>
> On Sat, 20 Mar 2021 at 02:10, Harry Wentland <harry.wentland@amd.com> wrote:
> > On 2021-03-19 10:22 a.m., Alex Deucher wrote:
> > > On Fri, Mar 19, 2021 at 3:23 AM Evan Benn <evanbenn@chromium.org> wrote:
> > >>
> > >> AMDGPU_DM_DEFAULT_MIN_BACKLIGHT was set to the value of 12
> > >> to ensure no display backlight will flicker at low user brightness
> > >> settings. However this value is quite bright, so for devices that do not
> > >> implement the ACPI ATIF
> > >> ATIF_FUNCTION_QUERY_BRIGHTNESS_TRANSFER_CHARACTERISTICS
> > >> functionality the user cannot set the brightness to a low level even if
> > >> the display would support such a low PWM.
> > >>
> > >> This ATIF feature is not implemented on for example AMD grunt chromebooks.
> > >>
> > >> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> > >>
> > >> ---
> > >> I could not find a justification for the reason for the value. It has
> > >> caused some noticable regression for users: https://bugzilla.kernel.org/show_bug.cgi?id=203439>>>
> > >> Maybe this can be either user controlled or userspace configured, but
> > >> preventing users from turning their backlight dim seems wrong.
> > >
> > > My understanding is that some panels flicker if you set the min to a
> > > value too low.  This was a safe minimum if the platform didn't specify
> > > it's own safe minimum.  I think we'd just be trading one bug for
> > > another (flickering vs not dim enough).  Maybe a whitelist or
> > > blacklist would be a better solution?
> > >
> >
> > Yeah, this is a NACK from me as-is for the reasons Alex described.
>
> Thanks Harry + Alex,
>
> I agree this solution is not the best.
>
> >
> > I agree a whitelist approach might be best.
>
> Do you have any idea what an allowlist could be keyed on?
> Is the flickering you observed here a function of the panel or the gpu
> or some other component?
> Maybe we could move the minimum level into the logic for that hardware.
>

Maybe the panel string from the EDID?  Either that or something from
dmi data?  Harry would probably have a better idea.

Alex

> >
> > Is this fix perhaps for OLED panels? If so we could use a different
> > min-value for OLED panels that don't do PWM, but use 12 for everything else.
>
> All the chromebooks I have worked with LCD + LED backlight have been
> fine with a backlight set to 0.
> We do have OLED panels too, but I'm not aware of what they do.
>
> > Harry
> >
> > > Alex
> > >
> > >
> > >>
> > >> Also reviewed here: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2748377>>>
> > >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >> index 573cf17262da..0129bd69b94e 100644
> > >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >> @@ -3151,7 +3151,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
> > >>          return 0;
> > >>   }
> > >>
> > >> -#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
> > >> +#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 0
> > >>   #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
> > >>   #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
> > >>
> > >> --
> > >> 2.31.0.291.g576ba9dcdaf-goog
> > >>
> > >> _______________________________________________
> > >> dri-devel mailing list
> > >> dri-devel@lists.freedesktop.org
> > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel>> _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel>>
> >
