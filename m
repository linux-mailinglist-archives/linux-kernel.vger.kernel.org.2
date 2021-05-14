Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E673811E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhENUkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhENUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:40:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A23FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:39:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id di13so25216edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9fFCzzakKEZE6yIPzCdXzgESj8HznLN13JEu2IrUhs=;
        b=AZD5F3fmpvTeEhIt43za7+8EIrk2t9t9HMEYztpTlYaJJuCP+wvA3afhdJCb5YQVUE
         gku0fZAVygSRcHZvtbgGNSvieB4UtA0Btv4ADLqSbXfXPrX0uVMGUN+SV7Sw6GZaO0Cl
         LSH64wCZBlZv1NlK5Pmcnn3tyCs7yG5F18jNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9fFCzzakKEZE6yIPzCdXzgESj8HznLN13JEu2IrUhs=;
        b=bMCf7QqYlCtJ+BRZf43qJiQn3UqfXgCXQpVxrFRJ5QC+pYBF1fEk/9j8BL7pOFABhH
         IsZ6+dhxQZh20SBeWz/mZE3wcC+q2be6Y8KM6uA6930g5Y0nL2nFB0ejHSvxuGm7fS55
         6mkChdTd3HoGptPujdJeMS6UArIBo/cN8l/EuYdDOcJYgCvEeceDYeM2JX5UDrqZTMgu
         T3Ag06BZ+eUQtYFjVvByjENN/87JOzcpFM+AYoGrHxdH9ea/jbrBJsd3RbYO0ylyHP2z
         lJ+3XAZjrN8SjJqts4ZB2XCDHSsM7WfAt22MI1PQfYy4PNqSbl7Fzdu2Ld/9WfGwEq3L
         lcYQ==
X-Gm-Message-State: AOAM533UF2CJZ5rrj05axR/Nj959QbTgZ5uXaphbAzEDSxMDy75h1yGI
        DTQEWjUV3VgY4jusUTFh8vn7kphOUw2THpcgV5w=
X-Google-Smtp-Source: ABdhPJxwJhmsAue0vBcI7hIs5RWyCsSVnE3yjK/Z7G3svbyZ1Wy61rcGbtAoMGUzT8eIfoqTFndXFA==
X-Received: by 2002:a05:6402:5174:: with SMTP id d20mr4835384ede.248.1621024781141;
        Fri, 14 May 2021 13:39:41 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id n11sm4324611ejg.43.2021.05.14.13.39.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 13:39:41 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id a25so11932579edr.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:39:40 -0700 (PDT)
X-Received: by 2002:a05:6512:36c5:: with SMTP id e5mr655215lfs.41.1621024378774;
 Fri, 14 May 2021 13:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com> <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 13:32:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
Message-ID: <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
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

On Fri, May 14, 2021 at 1:25 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
>  Overall I think it does make sense to resize the text console at any
> time, even if the visible console (VT) chosen is in the graphics mode,

It might make sense, but only if we call the function to update the
low-level data.

Not calling it, and then starting to randomly use the (wrong)
geometry, and just limiting it so that it's all within the buffer -
THAT does not make sense.

So I think your patch is fundamentally wrong. It basically says "let's
use random stale incorrect data, but just make sure that the end
result is still within the allocated buffer".

My patch is at least conceptually sane.

An alternative would be to just remove the "vcmode != KD_GRAPHICS"
check entirely, and always call con_resize() to update the low-level
data, but honestly, that seems very likelty to break something very
fundamentally, since it's not how any of fbcon has ever been tested,

Another alternative would be to just delay the resize to when vcmode
is put back to text mode again. That sounds somewhat reasonable to me,
but it's a pretty big thing.

But no, your patch to just "knowingly use entirely wrong values, then
add a limit check because we know the values are possibly garbage and
not consistent with reality" is simply not acceptable.

              Linus
