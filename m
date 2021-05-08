Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4833773B3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhEHSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhEHSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 14:52:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0311C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 11:51:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o16so15771405ljp.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xjuz5nHo61d9Wa4XmkNxBJhrgcOJsGcLtL7RrIrVjys=;
        b=HhycAKccvwZg03wbw4Xro+QgymNA8sh992uA7x85dJAQ5PvJckrSDoeQfzpru8L/NH
         a+XxuFunPAt04tL8VZGAhW/zAXq/OscqdcLDXanw0TZ1iXza13lMdpBcvozdlRRVBcDL
         gARVDCZBwnKqISkpdCz+VzbLqWbId+MofVlkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xjuz5nHo61d9Wa4XmkNxBJhrgcOJsGcLtL7RrIrVjys=;
        b=j8g9vxd5lwPjgpMdtr8sVkOzZVLgvdO5iK7xbH5MW+v2bZQlILrI4s7X6KSbHziLjw
         RlMnIgbzpQ0SVWucY+KKehvmoz2fuAvMmI1EWpkTfoQ02IXTXnovKBc/6v1lOLxxa6Du
         ZMbwvt9UaVKdPBNTF06LBnXitt0AGuNj8xdrkSRbQZ62qETeol/KW5rC33RpjfEWEtjT
         TlnBWp6j+nJowFe0LzrSLR1KDGQMy6Wsr7lB1nOQ+sPgZdOYpswYm/l8WtuDaZkW2Z0T
         V2mLutHL82larrjX8B3atL0S+zzgmhMi8GUKcxivtxPRXT8i4ScG6jb1kNejo9edlXKu
         sUvg==
X-Gm-Message-State: AOAM531cMW+/LfwM+vZ+N/fMfC629DdEOG+OtZOucP8uxcS7wDN0ttv+
        JCfaqCFtMoulbMmtX6bTfBiAkXtT0PIKHxrUoFA=
X-Google-Smtp-Source: ABdhPJwph58pcTj3tLg26/oB0Ud8DTGFbP1kVObonL2j8AXMyLc1giUDSgslQJt/TRLAfoHHRll8sw==
X-Received: by 2002:a05:651c:2004:: with SMTP id s4mr10119508ljo.443.1620499888932;
        Sat, 08 May 2021 11:51:28 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e17sm544004ljp.71.2021.05.08.11.51.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 11:51:28 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id e11so2188513ljn.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 11:51:27 -0700 (PDT)
X-Received: by 2002:a05:651c:333:: with SMTP id b19mr12571082ljp.61.1620499887537;
 Sat, 08 May 2021 11:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyKdGHyiRLDooKrMf=02GtNn8U4YfF4dJtXdabnVAGdXQ@mail.gmail.com>
 <CAHk-=whOOVBBuQceJ9D9uZrv-QOUWGMQ4aZe2K+2X24o7xA8cg@mail.gmail.com> <87bl9y50ok.fsf@intel.com>
In-Reply-To: <87bl9y50ok.fsf@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 11:51:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJsh4FOcMQ+eDx=f4joa-CCH1pmYtrsw0H7L0HV_GhJg@mail.gmail.com>
Message-ID: <CAHk-=whJsh4FOcMQ+eDx=f4joa-CCH1pmYtrsw0H7L0HV_GhJg@mail.gmail.com>
Subject: Re: New warnings with gcc-11
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have heard nothing about this, and it remains the only warning from
my allmodconfig build (I have another one for drm compiled with clang,
but there I at least heard back that a fix exists).

Since I am going to release rc1 tomorrow, and I don't want to release
it with an ugly compiler warning, I took it upon myself to just fix
the code:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dfec4d42724a1bf3dcba52307e55375fdb967b852

HOWEVER.

That commit fixes the warning, and is at worst harmless. At best it
fixes an access to random stack memory. But it does smell like
somebody who actually knows how these arrays work should look at that
code.

IOW, maybe the code should actually have read 16 bytes from the Event
Status Indicator? Maybe offset 10 was wrong? Maybe
drm_dp_channel_eq_ok() should never have taken six bytes to begin
with?

It's a mystery, and I haven't heard anything otherwise, so there it is.

              Linus

On Wed, Apr 28, 2021 at 12:27 AM Jani Nikula <jani.nikula@intel.com> wrote:
>
> On Tue, 27 Apr 2021, Linus Torvalds <torvalds@linux-foundation.org> wrote=
:
> > I've updated to Fedora 34 on one of my machines, and it causes a lot
> > of i915 warnings like
> >
> >   drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_la=
tency=E2=80=99:
> >   drivers/gpu/drm/i915/intel_pm.c:3059:9: note: referencing argument 3
> > of type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigne=
d int *=E2=80=99}
> >   drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
> > =E2=80=98intel_print_wm_latency=E2=80=99
> >
> > and the reason is that gcc now seems to look at the argument array
> > size more, and notices that
>
> Arnd Bergmann reported some of these a while back. I think we have some
> of them fixed in our -next already, but not all. Thanks for the
> reminder.
