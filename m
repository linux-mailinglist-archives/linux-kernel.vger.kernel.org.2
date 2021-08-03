Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BDA3DF0B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhHCOuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhHCOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:50:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC79C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:49:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso8991797otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZH2nIiiSnakY3FpS+wMVMs/uCUmksAAV/3YZm7bqsOY=;
        b=rZ4Q93WKcb8SdHFSMM/rNBR0ZsBlSoZE4udCGLC6cH7H8DBdCCAw/EJBUSXS58Dv7D
         k2tal+SHQdxQndFpVNoZkND/WGGp3xIbhQU+Ba5sZMtoXJcJ8w+G3RMWLFLPI4RRiY+t
         loWNOOElrWBd13mQHhk4Q0NjJTFzxtoITIZ7GW/EjdFs6J9xEiNuK32EkCZvpvtwbokt
         kVFReNqCSwTnUJwUJrMcik5OxG00bvzGMcJOSfOBcRz8Rznii6oMTCfg+Q6ZTfIDsjr1
         UpCXCc593V5KBu/sg7ekFg0zp+4osuW1p63D14vcWIm0T13uVCo72qU0eW5Wk0Tas6qg
         txSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZH2nIiiSnakY3FpS+wMVMs/uCUmksAAV/3YZm7bqsOY=;
        b=AoDDDP8KoHzA/PSYKv1j409HMHTDwMlseoDsZth9M3gvM6H2CrGMG6vQ+/C6hAE1u1
         mjXJQ2mqUNg5V170WqA0FW97NmEwfzOLC/JkyPzVYWruf++0N1pzcxne9tvo9moWaHgt
         zPmoYWgbWFOOv/4O07sS5foodhAYJFY1AKTA085yHZ4apr2vlMrzPp0dTqxInkA142UD
         pyiJBXi+r0MCFlPAwzi63AZVynb9LMKv5dl3VKiR/7/FMYajJ7cc6rhCUC+zxOAiH6FT
         8Xfnupp0XK5+kayNR8fjE6Y5xDBfIKg+9YkRbr0GOysEavHB+pe8rrHTXkgcSYzfloRr
         IWMw==
X-Gm-Message-State: AOAM532F10Y60Pag2I7k+3Qk8+hWF9coqoFDGexJ6nSgfaEYMQoXftZ/
        h4SWpICEGZzsAAE+Nslh1U2rb4p+LacKR1WjBCM=
X-Google-Smtp-Source: ABdhPJwn0Rpz9mVkqCTZg2eV64Hl7ywnveTNQNlZAFzS8iSiYVDBfBemH1xzSX8yv8Q//ZvG3gOoeEUUWn3a+khsHK0=
X-Received: by 2002:a9d:2072:: with SMTP id n105mr16305204ota.132.1628002190755;
 Tue, 03 Aug 2021 07:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210802074310.1526526-1-lizhenneng@kylinos.cn>
 <e6e77cfb-4e6b-c30e-ae7c-ac84b82c9a75@amd.com> <YQetXMaASz/F2EyS@phenom.ffwll.local>
 <CADnq5_PDtEn1y5HJBRHXw8o11LVwSRDKNtQgZtN5u0CW5ZspnQ@mail.gmail.com> <6a34fcc3-0aa3-85ff-21c4-86b9b5a48fd5@daenzer.net>
In-Reply-To: <6a34fcc3-0aa3-85ff-21c4-86b9b5a48fd5@daenzer.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 3 Aug 2021 10:49:39 -0400
Message-ID: <CADnq5_MJ=m2_VvzCQ7wJaFx2=OfFfLpoJtc_Ofb+a-v3eujtXg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Update pitch for page flip
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 4:34 AM Michel D=C3=A4nzer <michel@daenzer.net> wrot=
e:
>
> On 2021-08-02 4:51 p.m., Alex Deucher wrote:
> > On Mon, Aug 2, 2021 at 4:31 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>
> >> On Mon, Aug 02, 2021 at 10:12:47AM +0200, Christian K=C3=B6nig wrote:
> >>> Am 02.08.21 um 09:43 schrieb Zhenneng Li:
> >>>> When primary bo is updated, crtc's pitch may
> >>>> have not been updated, this will lead to show
> >>>> disorder content when user changes display mode,
> >>>> we update crtc's pitch in page flip to avoid
> >>>> this bug.
> >>>> This refers to amdgpu's pageflip.
> >>>
> >>> Alex is the expert to ask about that code, but I'm not sure if that i=
s
> >>> really correct for the old hardware.
> >>>
> >>> As far as I know the crtc's pitch should not change during a page fli=
p, but
> >>> only during a full mode set.
> >>>
> >>> So could you elaborate a bit more how you trigger this?
> >>
> >> legacy page_flip ioctl only verifies that the fb->format stays the sam=
e.
> >> It doesn't check anything else (afair never has), this is all up to
> >> drivers to verify.
> >>
> >> Personally I'd say add a check to reject this, since testing this and
> >> making sure it really works everywhere is probably a bit much on this =
old
> >> hw.
> >
> > If just the pitch changed, that probably wouldn't be much of a
> > problem, but if the pitch is changing, that probably implies other
> > stuff has changed as well and we'll just be chasing changes.  I agree
> > it would be best to just reject anything other than updating the
> > scanout address.
>
> FWIW, that means page flipping cannot be used in some cases which work fi=
ne by changing the pitch, which can result in tearing: https://gitlab.freed=
esktop.org/xorg/xserver/-/issues/839 (which says the i915 driver handles th=
is as well).
>

Ok.  In that case, @Zhenneng can you update all of the pitch in all of
the page_flip functions in radeon rather than just the evergreen one?

Thanks,

Alex


>
> --
> Earthling Michel D=C3=A4nzer               |               https://redhat=
.com
> Libre software enthusiast             |             Mesa and X developer
