Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE01C3819EC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhEOQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhEOQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:43:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472C9C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 09:42:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w4so2104963ljw.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKkVD1Qtnhdv59KfIngIIRAgpMVGtUMoAaJE9aWcwDg=;
        b=ZTy8QEEoSvjvmpGGdABqj29z7ZcuL0IRQ9UBKh89fhMz+j8cPVNUeZBKE8yaOCqkMJ
         kXzjCIiBF/NlemQsWsYyOaATN469b44wJYerSUSZFnkQiC4aQLy7om0FmX9cUarP4FxA
         D1eo9OLAbDq5eCqiokMYbyAbQahObMHCCCKQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKkVD1Qtnhdv59KfIngIIRAgpMVGtUMoAaJE9aWcwDg=;
        b=LtQh+3GIAWVwV1kLn8mP/Evg+rxDTBI9D1vCtUj1pNUH6AYPhp0+eo2qHuZoKzJpr0
         r/T4rfQgnrVfiNMRP+tcR+wSeXR8A6j6u5BCQyxz/y9hNsXeb2atVlZUt8mHPaMf3Jaq
         h4iPuv7qOxuZUMofLu+O2V43cKGTwRNB1nh+COGtwnG/0Fj44cCl1Yoc6HRMUIoq3L8z
         eKmedfdVoYmeTShoCAnTAMDv6gCtiBwYDN82KO+1zihK4bYaWXyNuWVTyTz1rsM4cING
         EeqEwwHOTS7e3zGRjsLOkWF03JBMF4Qf8MXjr5qf9rcLUyDTdkQ/VXtsz5yefD218frp
         hK+w==
X-Gm-Message-State: AOAM532PGmZiH6DU7plzcIepTW2+7JXHMo3CtLqjHqqA32SIfXWpt4A3
        uy6b157EPD+ji1cdyfwUaSImThKqF/lSKos0u7A=
X-Google-Smtp-Source: ABdhPJxLf9vNgqw6BDjSlHPdzQmjXvGzZOfi0tc09Fu/jdr/NghtcQDx1rhrrZL9wFNtJ9wJAIGxRA==
X-Received: by 2002:a2e:a7cb:: with SMTP id x11mr7425462ljp.143.1621096930400;
        Sat, 15 May 2021 09:42:10 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h19sm1419125lfc.56.2021.05.15.09.42.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 09:42:09 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id q7so1365838lfr.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 09:42:09 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr35147289lfs.377.1621096929091;
 Sat, 15 May 2021 09:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
 <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk> <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
 <CAHk-=wjkVAjfWrmmJnJe1_MriK9gezWCew_MU=MbQNzHbGopsQ@mail.gmail.com>
 <97f1d292-c3a8-f4d6-0651-b4f5571ecb72@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2105151815040.3032@angie.orcam.me.uk> <alpine.DEB.2.21.2105151828380.3032@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2105151828380.3032@angie.orcam.me.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 15 May 2021 09:41:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz-iC97f0cnawKZc_S4-0ZEOdOx43J7pVX6b=AqYUhfg@mail.gmail.com>
Message-ID: <CAHk-=wgz-iC97f0cnawKZc_S4-0ZEOdOx43J7pVX6b=AqYUhfg@mail.gmail.com>
Subject: Re: [PATCH v2] tty: vt: always invoke vc->vc_sw->con_resize callback
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Antonino A. Daplas" <adaplas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 9:33 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
>  NB I suggest that you request your change to be backported, i.e. post v3
> with:
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org # v2.6.12+

I've applied it to my tree, but let's wait to see that it doesn't
cause any issues before notifying the stable people.

               Linus
