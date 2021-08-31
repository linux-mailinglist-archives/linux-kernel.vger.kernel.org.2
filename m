Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78343FCC36
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhHaRUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:20:36 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:36767 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbhHaRUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:20:35 -0400
Received: by mail-vs1-f46.google.com with SMTP id f6so144423vsr.3;
        Tue, 31 Aug 2021 10:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMOX2To1IEOY2ZnzUeCxb0+BBk/jcmCPbhrdDzxJbcg=;
        b=sZ7uWxlzeUzmgbLH688QWiQjFRdZTH/FLRn9HPOMIFACKocPntakFs5ZRfmkQDek1q
         Gg1Aeenc897704wRSaSdZZAAeElRFdXeqrEa9GaSS1CvFovF+Sd/YKEAga1Pa0g/dfXS
         jzHb4CGyylMPfSjujzt6La0Ga5tgna8EIuhH/5Eev76u5ytQd5hZ+ZN/HOSvL50aa+18
         02EmNsBX6OKEiRXNAEnwqCZckoGS+Goo9RLwuiU8N787HViLjDiF0D6Dz6JBwej9s9to
         V2NIel8Byqug/Rn0btbdv2p6FlITC9EYxcyu0ZF+rZQpmb/HOMoT5D1qQ0gJZ5kesQfb
         ETnw==
X-Gm-Message-State: AOAM532aSr3K4iyzRS6qLxw3hR84jGWvQjEFIz+2LrPhu8ZIhfXhaQLj
        HeQkeF69fHGL5KQDNuVEOY4PrW3eZEmQ2as3Wuc=
X-Google-Smtp-Source: ABdhPJzwIcYtEYXT+4ELrSXZhc7SGBnDBykZ6QWPifjhJFCJ02Jh+wK9QnEW6KWY0HcJvsALfiP7/h+mMWcZEJ7eWpI=
X-Received: by 2002:a67:c789:: with SMTP id t9mr20435604vsk.60.1630430379297;
 Tue, 31 Aug 2021 10:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <339bfb21-8e80-c7d9-46dd-c416f87c50c0@infradead.org> <535e404d-03bf-8e7a-b296-132a2a98c599@i-love.sakura.ne.jp>
 <CAMuHMdWX7s63X_zR9329canbQkPGBVxZNG4O+_=jUut60aGR9g@mail.gmail.com> <5c6d2b95-31d7-0d59-5e62-2593d9a0e1fe@i-love.sakura.ne.jp>
In-Reply-To: <5c6d2b95-31d7-0d59-5e62-2593d9a0e1fe@i-love.sakura.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Aug 2021 19:19:27 +0200
Message-ID: <CAMuHMdWbSUGRGAVi-17C3hyDBZnGLAsmbAs+wXPHiCNWWLbMpA@mail.gmail.com>
Subject: Re: [PATCH] fbmem: don't allow too huge resolutions
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Handa-san,

On Tue, Aug 31, 2021 at 5:24 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/08/31 15:48, Geert Uytterhoeven wrote:
> > Furthermore, this restricts the virtual frame buffer size on 64-bit,
> > too, while graphics cards can have much more than 4 GiB of RAM.
>
> Excuse me, but do you mean that some hardware allows allocating more than
> UINT_MAX bytes of memory for kernel frame buffer drivers?

While smem_len is u32 (there have been complaints about such
limitations on 64-bit platforms as far as 10 years ago), I see no
reason why a graphics card with more than 4 GiB of RAM would not be
able to provide a very large virtual screen.

Of course e.g. vga16fb cannot, as it is limited to 64 KiB.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
