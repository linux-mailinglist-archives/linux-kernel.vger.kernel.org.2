Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B46140033F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349984AbhICQ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349968AbhICQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:27:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E34C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:26:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id d16so10396037ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGwJPrU2ymA9P5fTXacx3Qx7nyhlT5Ql+hJVxARh6kE=;
        b=K1rpsMJtFquFY0qt0aI/UI9kou+zwJyr90hh+Vza9DcECr82hORBsg2aFd3wZYBMyW
         mxSJGjFZE1t/C6jfyYk7elauPxHWpv1yEHosEvvwTsPovx6P/GaYLx1qmSOFYXAnwgSc
         ifABx5ircSoY9atjYL5bS6LS1nIcyTGaPGEEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGwJPrU2ymA9P5fTXacx3Qx7nyhlT5Ql+hJVxARh6kE=;
        b=B7qcWWD7ZbGe+hEH0N/gVVtGLbSQXWpGtHgm48auPVjEYl6CfKHRM2orqsiAUXAYRl
         xpAgiwQVnFGzGre/vwS0yk4xwyduFyKqc+t/aP3KNBv5mt7/nU96aHUix/R4lhMPqPnI
         wFB0EZkifq9V3Yx1LAutWIKOO2+Ip9QhY/cy/9z09rEYgVO0uRxDgVwaPMZCMMEs4pFz
         rMnd7aKjLIxdh9DYFBz0jV7b8yW78yNKmUZsF3RohZ8BhqrwYx/azCsWAPRYTlD+iBnz
         tXWkbDnjHNeMFSubNjD9JkSBw0luUTw0362WvEtUL29feCvCvjHstFr9UESeM2v6OXe4
         ERTg==
X-Gm-Message-State: AOAM531OA6XEfd4vjnUIt82TnjWeYnW3v5pnbaB+dUNNO/Zue77nOkmq
        ig0xaFxcLtWu7TogWZgzdgTuITFwdWWUr+V02iI=
X-Google-Smtp-Source: ABdhPJzVVFfZuYG6Y6sPrJyebnpqhytDaI0OyIyF9zKEeGOlUoRzBgq41/ugAb+SSUvFNvEAOhFwCA==
X-Received: by 2002:a2e:b8c7:: with SMTP id s7mr3618745ljp.105.1630686393655;
        Fri, 03 Sep 2021 09:26:33 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id h17sm620096ljg.131.2021.09.03.09.26.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 09:26:32 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id p15so10436477ljn.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:26:32 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr3678393ljg.68.1630686392088;
 Fri, 03 Sep 2021 09:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210816194840.42769-1-david@redhat.com> <7c57a16b-8184-36a3-fcdc-5e751184827b@redhat.com>
In-Reply-To: <7c57a16b-8184-36a3-fcdc-5e751184827b@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 09:26:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whghWSYo498cKaK9VLwBKKW0uMynwPT3zpnEG73MfKqUA@mail.gmail.com>
Message-ID: <CAHk-=whghWSYo498cKaK9VLwBKKW0uMynwPT3zpnEG73MfKqUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 2:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> So, how do we want to continue with this? Pick it up for v5.15? Have it
> in -next for a while and eventually pick it up for v5.16?

I'm ok with the series. If you have a git tree, do the normal pull
request, and we can do it for 5.15 and see if anybody notices.

As you say, any final removal of ETXTBSY should be a separate and
later patch on top.

            Linus
