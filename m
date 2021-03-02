Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE132A98B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580992AbhCBScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349578AbhCBPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:46:27 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB48C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:40:47 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id h10so9492742otm.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kN+qht5aNloSn99U+wCYtoBLxcHXOR5Y2r7OnXmIE50=;
        b=UYQMjzSo6roQCqqiamnsTLtYfz7qBGxFhi0xS/ciEJyVNhLlobBKXuvOT4LWxeTCpK
         yYY9eyoahFgKXXAcZ835UJgP7tjaA9uSpMFTVLvHTxk5FOMGsBnOTFw92EmLSJ9wZ59L
         HBX6djL0MFlHsdg7rDvRW2LICzTp7Z+MWqppYvqG8LFVHwogi/f6wljgTQc2e0QTSV3g
         MhErOFN/J7GHMGhep7gQvckJrbya/z07YNqkgFm3AROGU+th+Pmm//MGC+v8Ef1lVbrn
         4VNY4pfoG100KA/ey7TmERMyirhF+liB032KHQ363JdRQSDaORQ3dcU6u7wEZ5O1229r
         UV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kN+qht5aNloSn99U+wCYtoBLxcHXOR5Y2r7OnXmIE50=;
        b=ZP9JlPUmxz8/lYgisJGynJV3cuj3eYCYidoNxkQDF6/v1I5ytohaRrwTct+ai7qyCM
         wheJ2b8/CBfNY/OV0ii3rMp0XmX/TelkuBCaVfWo3lZYlBkugJKqhmL40Elwm5OHHZ8Z
         VL0Aajexu4AD+alroXC0lU7ymKIhGjKYeIl13MytSuF/ZG3U5RLy0cQv3c5P949Z0uU3
         oTaeuuP8BfMgClOG+cXpPtPC9FuFNWJMKt2N8Wj5Vj8r0hKNuBR/Pfs6uMrWxJ5mpnud
         TBouOdw8KqdEnVHTFAtMgoCpmPKcywsa13HoapclxaTtaHy3TSKXhQHKqHy0S4rH5OYc
         lLtQ==
X-Gm-Message-State: AOAM532Yo7WruPT+fJGLDU/UUQYjL6U6LNaNPvv8vWQHe8HYamNA6g9U
        9g7dh5CkHq2cI0Ogp3TBQuNYhor59pHDpujrj68mKg==
X-Google-Smtp-Source: ABdhPJxqr1iBApjiU7k3NzTpl5VaqrH6TuLMVGD+X6co4pETOtOnkN5IcRyvTZ8s5wYdxGG4V5/gny/gBPNilH9RqGw=
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr10981842otq.17.1614696046348;
 Tue, 02 Mar 2021 06:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20210214161348.369023-1-timur@kernel.org> <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley> <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
 <20210302090811.620ae7d0@gandalf.local.home> <YD5LKqtSz5r1Xp7B@elver.google.com>
 <20210302143516.GY2723601@casper.infradead.org>
In-Reply-To: <20210302143516.GY2723601@casper.infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Mar 2021 15:40:34 +0100
Message-ID: <CANpmjNNMFtJvkVBhjpp=YqFb3ck8Q4Ak8nGtB21XMd9ds_APFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Timur Tabi <timur@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 at 15:35, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Mar 02, 2021 at 03:26:50PM +0100, Marco Elver wrote:
> > +static const char no_hash_pointers_warning[9][55] __initconst = {
> > +     "******************************************************",
> > +     "   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
> > +     "                                                      ",
> > +     " This system shows unhashed kernel memory addresses   ",
> > +     " via the console, logs, and other interfaces. This    ",
> > +     " might reduce the security of your system.            ",
> > +     " If you see this message and you are not debugging    ",
> > +     " the kernel, report this immediately to your system   ",
> > +     " administrator!                                       ",
> > +};
> > +
> >  static int __init no_hash_pointers_enable(char *str)
> >  {
> > +     const int lines[] = { 0, 1, 2, 3, 4, 5, 2, 6, 7, 8, 2, 1, 0 };
> > +     int i;
> > +
> >       no_hash_pointers = true;
> >
> > -     pr_warn("**********************************************************\n");
> > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > -     pr_warn("**                                                      **\n");
> > -     pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > -     pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > -     pr_warn("** might reduce the security of your system.            **\n");
> > -     pr_warn("**                                                      **\n");
> > -     pr_warn("** If you see this message and you are not debugging    **\n");
> > -     pr_warn("** the kernel, report this immediately to your system   **\n");
> > -     pr_warn("** administrator!                                       **\n");
> > -     pr_warn("**                                                      **\n");
> > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > -     pr_warn("**********************************************************\n");
> > +     for (i = 0; i < ARRAY_SIZE(lines); i++)
> > +             pr_warn("**%s**\n", no_hash_pointers_warning[lines[i]]);
>
> +       for (i = 0; i < 3; i++)
> +               pr_warn("**%s**\n", no_hash_pointers_warning[lines[2 - i]]);

Yeah, I had that before, but then wanted to deal with the blank line
in the middle of the thing. So I just went with the lines array above,
which seemed cleanest for dealing with the middle blank line and
footer. Or maybe there's something even nicer I missed? :-)

Thanks,
-- Marco
