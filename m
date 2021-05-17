Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1C382D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhEQNOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhEQNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:14:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:13:17 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so5486098otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1niWPbp6OXctfAAznJewfN6Eqjsqw0nM8ckzYrVktvk=;
        b=d7CG4UV4uV/QvT/PB3LlqCepedtDGPXwmcB5sYhOAr5UFDYI6t2UWqoAu6SQ50Dl+1
         ybQlPRgq6zOcYfRTI8AcmZaVF9UmkTtuSsOILLQKg3mDgdY/GtdJWOLYJba019tbu+U3
         5bHr8t+Jhpl7HsLNJUbqd4PynYK9iGwTXGaoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1niWPbp6OXctfAAznJewfN6Eqjsqw0nM8ckzYrVktvk=;
        b=mETdXB/GdbQ15+dWxmnZ7GtBC9PWawnjf/0R9pvhxtbrRZnxxiB+dFlxe2MOpLmFE3
         7vWGJYYiGOCvTaZKV+z2jbqIFV+lx64ADBMVfd4qO+UYNIGZdQ+UzsikxIvdRETetsLi
         3jiKIU5o+ho4fQLCFwjjfy8fMzz4LeHifOZnSh+ccmsijQ23MHPCuPdPNHZObYdRlzjU
         GQKDeMvKRj2Vf4N7i3ztuV0gBDCpbT7J0m/bRrcXoB2agcsBZ56uyKHQoN2BcbwvQRgL
         kN+1Uj5rdAnRz36vig5vtfB/QzgcQXMDkZJ8XjHqyNqNMsOKJsTxY+5vFs7rRWOkwZA3
         S64w==
X-Gm-Message-State: AOAM532BLfkNWnVPEFOVHjs5qd/2SA27etgvjbw+UkIa9HIEKqAwTzit
        SjRdZ/jQ6KRFyyX8++9o39338u2cTNXhyTQJ9kHYAQ==
X-Google-Smtp-Source: ABdhPJyDuQIvXw+luxml8GEexK3jECtW+UAWqe0kXDIKCICTTAfz7N7CV/zjN9R469BgZWNcW6e4zYMo96HA10ZPQKg=
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr31941099otq.303.1621257196488;
 Mon, 17 May 2021 06:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
 <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk> <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
 <CAHk-=wjkVAjfWrmmJnJe1_MriK9gezWCew_MU=MbQNzHbGopsQ@mail.gmail.com>
 <97f1d292-c3a8-f4d6-0651-b4f5571ecb72@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2105151815040.3032@angie.orcam.me.uk> <alpine.DEB.2.21.2105151828380.3032@angie.orcam.me.uk>
 <CAHk-=wgz-iC97f0cnawKZc_S4-0ZEOdOx43J7pVX6b=AqYUhfg@mail.gmail.com>
In-Reply-To: <CAHk-=wgz-iC97f0cnawKZc_S4-0ZEOdOx43J7pVX6b=AqYUhfg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 17 May 2021 15:13:05 +0200
Message-ID: <CAKMK7uGO3_EtQem=zuTa2w8jO4zwwT27Ly6uJEYF4wVLYXGZ_Q@mail.gmail.com>
Subject: Re: [PATCH v2] tty: vt: always invoke vc->vc_sw->con_resize callback
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sat, May 15, 2021 at 6:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, May 15, 2021 at 9:33 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> >
> >  NB I suggest that you request your change to be backported, i.e. post v3
> > with:
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org # v2.6.12+
>
> I've applied it to my tree, but let's wait to see that it doesn't
> cause any issues before notifying the stable people.

Ah I missed all the fun with the long w/e. fwiw I think this looks
very reasonable, see my other reply why I think this shouldn't cause
issues. Especially when fbcon_resize only touches hw when in KD_TEXT
mode.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
