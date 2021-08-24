Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9FB3F6219
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbhHXP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhHXP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:58:15 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4A4C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:57:31 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso32494032ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X27sm7XRJloh7TYC16b8bidIz7tS9xlzanMCh+7pg/0=;
        b=XdbRGi4/xxxpl/ndGsjItcDBt9YYDql6ArJnAKPQWbGna4AOMWlO7a0Z3OOS5k0jRV
         yQW0gr/9eEah9ZHViP/HKoJa5Cz+/euHaWecXA26T04uzZtjdwVaRPRizCigqg+PD8Fd
         8RNWTStsEmwdk+0tWagb9H0zBgxdhlpLNmunCxmabLsrRSa2s44H+LoVt/jx7B8/4m4o
         eMNdKf3U07cwFWNdpvdK9OQCzvpwf7pXWBXO7FutF0tk/CRAfLjmTCznzy1KmxsUEwFj
         YkJz6wpGrKJh8m0D7xeB0ZboVEJrQWCQra2c8d31fIphrpPbvx6HUt0Zvck6nZHjUWTH
         S47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X27sm7XRJloh7TYC16b8bidIz7tS9xlzanMCh+7pg/0=;
        b=Fk9TDIK1V2G16Tkz70UiKCgkTwTkAX9DErxO16zReA+LAVFwJLZUefllQ+Ly+E5Nx9
         sc43pTouRSQt4KRvlBHl1hJUKRcXEB4ZputKo096akcZ9kBN0th66nzs6DRXQvgYKsXS
         eu0SksMN1DD1K/x+qudhxYIZ7nwail22fRP5fc7YOyNDP0WsweUwHytIZulo9YE+KGF0
         PzCbxn44rQGTBr54/va3OpmZYwIDwdBEITaqTcGNuP3Hc1+yadDUYJErws5j4KxVBeTC
         ji1ThTKRVI+DBWEqsOf3zsNncsCYkbiAJ61YhqCtptQEVqstLXWz/ozdJhRXBFPzHH5d
         i5cA==
X-Gm-Message-State: AOAM530p5mRVIehnO1ii+cypucfpTAJT2TQJ7qlpSul9NS7O9g3rv82T
        zqrKk2OH9mXrrsd/VWZvZJSJ80qOgj5CzYSVG+g=
X-Google-Smtp-Source: ABdhPJyPQRalck3DahrxIbbctemODf7n5JPHNPSc984wGNf7NLLsoBJ4dx6nhPQ9eWWKFduLlQouz30eBNZzqRFm0wY=
X-Received: by 2002:a05:6830:1c69:: with SMTP id s9mr4883042otg.132.1629820650421;
 Tue, 24 Aug 2021 08:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <YSP6Lv53QV0cOAsd@zn.tnic> <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic> <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic> <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
 <YSS/F9kcQcRKlNJ5@zn.tnic> <2d7e3536-fc3e-629a-4f0d-2ac5ccacccc5@amd.com>
In-Reply-To: <2d7e3536-fc3e-629a-4f0d-2ac5ccacccc5@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Aug 2021 11:57:19 -0400
Message-ID: <CADnq5_N0493Bv7i4H7dcMr7SJVqVExFTpSx_6PovHq5beVFJpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix build with missing pm_suspend_target_state
 module export
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Aug 24, 2021 at 11:16 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 8/24/2021 3:12 PM, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> >
> > Building a randconfig here triggered:
> >
> >    ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgp=
u/amdgpu.ko] undefined!
> >
> > because the module export of that symbol happens in
> > kernel/power/suspend.c which is enabled with CONFIG_SUSPEND.
> >
> > The ifdef guards in amdgpu_acpi_is_s0ix_supported(), however, test for
> > CONFIG_PM_SLEEP which is defined like this:
> >
> >    config PM_SLEEP
> >            def_bool y
> >            depends on SUSPEND || HIBERNATE_CALLBACKS
> >
> Missed this altogether!
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > and that randconfig has:
> >
> >    # CONFIG_SUSPEND is not set
> >    CONFIG_HIBERNATE_CALLBACKS=3Dy
> >
> > leading to the module export missing.
> >
> > Change the ifdeffery to depend directly on CONFIG_SUSPEND.
> >
> > Fixes: 5706cb3c910c ("drm/amdgpu: fix checking pmops when PM_SLEEP is n=
ot enabled")
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flkml.kernel.org%2Fr%2FYSP6Lv53QV0cOAsd%40zn.tnic&amp;data=3D04%7C01%7CLi=
jo.Lazar%40amd.com%7C71b6769cdd574a05b32b08d966e37525%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637653949420453962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi=
MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3Dai%2B95gtZz0r0pXYaUkG97tiuaiykEy8%2FB%2FtmHP3W4Zs%3D&amp;reserved=3D0
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> > index 4137e848f6a2..a9ce3b20d371 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1040,7 +1040,7 @@ void amdgpu_acpi_detect(void)
> >    */
> >   bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
> >   {
> > -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_PM_SLEEP)
> > +#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> >       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> >               if (adev->flags & AMD_IS_APU)
> >                       return pm_suspend_target_state =3D=3D PM_SUSPEND_=
TO_IDLE;
> >
