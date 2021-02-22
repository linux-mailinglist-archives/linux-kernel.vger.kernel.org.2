Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804443220FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhBVUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBVUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:52:43 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116BCC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:52:03 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id k13so2877313otn.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsKNWOTpoXFBX3Vm20VX6e7+2+XeumtrdsmpqxkFoSE=;
        b=hx3ZtNKXCjBF9VddK8QgdVRc3sYrJ55BQupjDWwHI7khjSuKLDNLD0Kz9MR3dQ4v/J
         /NWxPC7wssr4gRI9wTUsE5nQFc+C9iYzom2snaBD0WOe5kHUeCGqd2uzpyUu1N4iZQYB
         m9fhfaAd+CTX1VqvmvTrmZTJUOuJy1WUACfQ8pyZmdzPr2+CUL5+dvHStza5z2tFVhtz
         etYdm5dNI1D70LSlkjgAYmdgW0OEOxYXiUh1jCYsNUUC1GIPjCGj67Nub8zr898KoIPL
         06yH3kUXJ1bU6yJcX125gno29ErYUlSiuOTkwKI6crx8I/LxT0Tdwzt9SCDAxTR9r7ak
         3NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsKNWOTpoXFBX3Vm20VX6e7+2+XeumtrdsmpqxkFoSE=;
        b=sdA1zWdcuZnz/AR64ZU3ew0+CVFssXBbSdlEM+jfd2ahteGINmGJ8DFu3K4MgiZH95
         yqEIJpzOuk+yu5b0GaZqYdYwlpcSf1f5VcK+oQq3j4mdFJ/0VNmXBL0KbTQyH6FVCyWd
         OYt/Q7nhJ1znqJeAbm7vhsH7RLq49IoC6SuTzHwthCcxe2NNVrqOcUlJY++vkw69J7GJ
         mCA+vOQRH6NM4MOHmJrsYr+1+edXuqSFwLDroDJPpQbsIMB1GKuIiV6pFwQsir8/yEsd
         /za2b0BpHuhM3nbwTGMtVmFd4OLeHGzTb0tOUMOOtUCfL8PZATV6ff25gRW+WUWei1jG
         PfRQ==
X-Gm-Message-State: AOAM532+ZpvVyoGSrw7yMtpH+CuP+Pfu1KWi0lqEpbSYzsm5zQwe5gPM
        FoxkZ2WTesSMdXTWg37yM0fAJQwPg28cFATc+QkHmdX0
X-Google-Smtp-Source: ABdhPJxgtf9qdkqoR/ipe+6CsbbzBAq5ddIs5TNufipZbmAeTYrchhfeEOY7Tl9/Fuz8GfJ/YxQrPGmnMN0S7JTlfQc=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr7475200oti.132.1614027122516;
 Mon, 22 Feb 2021 12:52:02 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txd-x1NKWK9BBqVTDNOR00zNqcXgs76YJrDfL94eMLYqQ@mail.gmail.com>
 <CAHk-=wgiPxXzRNnfaXk7ozSWSu7fFU--kTmVjkDaTB05wwUk_g@mail.gmail.com> <20210221234549.GA21254@24bbad8f3778>
In-Reply-To: <20210221234549.GA21254@24bbad8f3778>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Feb 2021 15:51:51 -0500
Message-ID: <CADnq5_OcxrYehTWWiEOO8OMqMSHk22=Z7ehcYhiOUVwFF=Yhyw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.12-rc1
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kevin Wang <kevin1.wang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 6:45 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sun, Feb 21, 2021 at 03:07:17PM -0800, Linus Torvalds wrote:
> > On Thu, Feb 18, 2021 at 10:06 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > Let me know if there are any issues,
> >
> > gcc was happy, and I obviously already pushed out my merge, but then
> > when I did my clang build afterwards, it reports:
> >
> >   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:764:2: warning:
> > variable 'structure_size' is used uninitialized whenever switch
> > default is taken [-Wsometimes-uninitialized]
> >           default:
> >           ^~~~~~~
> >   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:770:23: note:
> > uninitialized use occurs here
> >           memset(header, 0xFF, structure_size);
> >                                ^~~~~~~~~~~~~~
> >
> > and clang is very very right. That "default" case is completely
> > broken, and will generate a randomly sized memset. Not good.
> >
> > Presumably that default case never happens, but if so it shouldn't exist.
> >
> > Perhaps better yet, make the "default" case just do a "return" instead
> > of a break. Breaking out of the switch statement to code that cannot
> > possibly work is all kinds of mindless.
> >
> > Kevin/Alex? This was introduced by commit de4b7cd8cb87
> > ("drm/amd/pm/swsmu: unify the init soft gpu metrics function")
> >
> >               Linus
>
> I sent https://lore.kernel.org/r/20210218224849.5591-1-nathan@kernel.org/
> a few days ago and Kevin reviewed it, just seems like Alex needs to pick
> it up.

Yeah, sorry, I meant to include it, but it slipped through the cracks
last week.  Will include it in my -fixes PR this week.

Alex
