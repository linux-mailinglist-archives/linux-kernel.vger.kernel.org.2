Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3603EDD5A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhHPSyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhHPSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:54:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F593C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:54:05 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t128so28161653oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YoY9bHgtBFBdh+LL5q9r5ScpCfKdiLG+MRqaif3YEI8=;
        b=naoSBJkgtcuj5qgJOEZkSZimaplLVdgNyuZkSUQOT4oTguOAkX6UV9uhieY+czuvyC
         yKl+WA0CV9mqasUFr9PIYgiR087D0pB2DSlo7BJlIJOIeH8jZe90iieO/YLidSIvyGcF
         y120bsGWC2BVTQ4HihQP1T9IDivfmdAump1sI1BksIJxwB5U864hAmI+CYPqoUxVmf9b
         rtYUU/gjJHllsB4yhuL/fsFmr4fSG2UYhzvG3SxadqL7yAr1+lzHaT65vfY+b4nAv6pE
         riWxWjM/lMBOuoaoLzdmW2IFQuhDZ6aS10JodX0K8HOixim9MKDvwfe3gqNhyZrNomrY
         F2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YoY9bHgtBFBdh+LL5q9r5ScpCfKdiLG+MRqaif3YEI8=;
        b=OieHEt56K0g1me98t7TZ9wi9oWpUfWouU4f17O1IiCfjjP39X8Kw6N4kOWws1kls/K
         +3pdiulJiQslOuNQnWIQxVCLZi5zESRA3+2SCsdIdn67Z71mUrF73v//js2LAQ0HpGs3
         UOHlOq80O/1j+2WJq1iLNik29xwWWTflNgSB5FaTLihItD6B24VkcYvCVoGEERdiBN40
         gaz93ODKLwJgOOMtnoIG1KHhU91HyK+RiAJs00lnqIebWrzY/i3ma9kDvvfF4Qdh9phN
         CzKXE0UH0TfEBFUOQXBgBDytoL5q5/EouN/qDbr91tqhsLeLuPW+RnwAkFqeWf0ItpSP
         MihA==
X-Gm-Message-State: AOAM5310UYFOWSCB0VMF0Hukb6bvO+qbFUwho/3piZc3xw6x96c591mo
        M3BKAP0HrcOJjSgD9OW9RGwFGV1+vWgaePT20ho=
X-Google-Smtp-Source: ABdhPJyjsT23z+JKUtzE0jLgdLWJv7SfrxzzaZKXzkFJJLzPFGv15wqNC71FHrLBwBKGtq3duPeYyc8o86vTH0Psaxc=
X-Received: by 2002:a05:6808:1390:: with SMTP id c16mr128831oiw.123.1629140045025;
 Mon, 16 Aug 2021 11:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210815192959.90142-1-nathan@kernel.org> <d2e9b2a0-49b9-42fe-47fc-66a44bef3b01@amd.com>
In-Reply-To: <d2e9b2a0-49b9-42fe-47fc-66a44bef3b01@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Aug 2021 14:53:53 -0400
Message-ID: <CADnq5_N0o_6vCqE0tYq=yqtPWvOzZikLoVF1f4U9DJcb2bCgCA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Add break to switch statement in radeonfb_create_pinned_object()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Aug 16, 2021 at 3:23 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 15.08.21 um 21:29 schrieb Nathan Chancellor:
> > Clang + -Wimplicit-fallthrough warns:
> >
> > drivers/gpu/drm/radeon/radeon_fb.c:170:2: warning: unannotated
> > fall-through between switch labels [-Wimplicit-fallthrough]
> >          default:
> >          ^
> > drivers/gpu/drm/radeon/radeon_fb.c:170:2: note: insert 'break;' to avoi=
d
> > fall-through
> >          default:
> >          ^
> >          break;
> > 1 warning generated.
> >
> > Clang's version of this warning is a little bit more pedantic than
> > GCC's. Add the missing break to satisfy it to match what has been done
> > all over the kernel tree.
> >
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_fb.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeo=
n/radeon_fb.c
> > index 0b206b052972..c8b545181497 100644
> > --- a/drivers/gpu/drm/radeon/radeon_fb.c
> > +++ b/drivers/gpu/drm/radeon/radeon_fb.c
> > @@ -167,6 +167,7 @@ static int radeonfb_create_pinned_object(struct rad=
eon_fbdev *rfbdev,
> >               break;
> >       case 2:
> >               tiling_flags |=3D RADEON_TILING_SWAP_16BIT;
> > +             break;
> >       default:
> >               break;
> >       }
> >
> > base-commit: ba31f97d43be41ca99ab72a6131d7c226306865f
>
