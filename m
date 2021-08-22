Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81103F40C6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhHVSFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHVSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 14:05:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EEDC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 11:04:19 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s12so1902267ljg.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdFxYhd+eeTvCDoJF+ykQd/hvB6y5cUN0QY2l3gJKV8=;
        b=au92NbSisRvXy93M+NrgnvN1ZFxFpdCvErKBfMKVIqPkcLDsmlc4H8IlkBaoDTokon
         +3bncuuUd0fsd3z1HifoTs0zMQn06fmz518jwP3j+xMbPOi2iWMFEHBiOt1QHwW5pDC9
         gQ87hYhnRnXoLWW0aQEtDFTGVTYDaIQIFcmIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdFxYhd+eeTvCDoJF+ykQd/hvB6y5cUN0QY2l3gJKV8=;
        b=IeevaPoE7WjiXuBuC7/WxS7fb1Q9HsIScY2U1Lr57vB4jQPXPejsAlVBxJqgkBA1uC
         MAwtRVrqk1EosYG/+YwdNDn4huzVN/XQNS0biud+GBjlUxynFl5MLCn8If8i46Zqrgqn
         t1jWR9Cuunxq8Pxy7BRckhbpaoghfdbGrraIN3Uw8KhpszXpJOFEsL0gd/t8QfNazaDQ
         sESBhnOT91YHSlTOKWpa0qQ1bJfovhHlgGnH6aYqnFXWcKr3z0UNdC7Tq5ilMWmPjkSo
         H8255ssPholzH4fAn7kvlExt3Pxn/TBLPAdDWhDplD1aLOtlDSQGbR/Lcr8a1wpWM4yE
         sLXg==
X-Gm-Message-State: AOAM5305gfUg1P1O2RoCHzaKL/cAe2qhlIbuAydSSFThqj7CfoPiTI49
        v6zbFlR3J1pzaCDxxOANmTjRFFNwnce+4biZ0j4=
X-Google-Smtp-Source: ABdhPJzGVvI+JL4Gl/vvHQuIio/tiLFpeE8z4w3kJiYvYWNtyUumsCYwlprLK8rQhtCk3ZdmIijc4w==
X-Received: by 2002:a05:651c:490:: with SMTP id s16mr24274134ljc.214.1629655457699;
        Sun, 22 Aug 2021 11:04:17 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b16sm826261lfv.26.2021.08.22.11.04.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 11:04:17 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x27so32868921lfu.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 11:04:17 -0700 (PDT)
X-Received: by 2002:a2e:81c2:: with SMTP id s2mr23439411ljg.48.1629655124814;
 Sun, 22 Aug 2021 10:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210816194840.42769-1-david@redhat.com> <20210816194840.42769-3-david@redhat.com>
 <CAHk-=wgsLtJ7=+NGGSEbTw9XBh7qyf4Py9-jBdajGnPTxU1hZg@mail.gmail.com>
 <d90a7dfd-11c8-c4e1-1c59-91aad5a7f08e@redhat.com> <87o89srxnn.fsf@disp2133>
In-Reply-To: <87o89srxnn.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Aug 2021 10:58:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6XnsUf+WioJ3qRS09QhWqf50-DwCmUCjja5PHqjvsxw@mail.gmail.com>
Message-ID: <CAHk-=wi6XnsUf+WioJ3qRS09QhWqf50-DwCmUCjja5PHqjvsxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kernel/fork: factor out replacing the current MM exe_file
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Aug 20, 2021 at 7:36 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I think this check is there to keep from changing /proc/self/exe
> arbitrarily.

Well, you pretty much can already. You just have to jump through a few hoops.

> Maybe it is all completely silly and we should not care about the code
> that thinks /proc/self/exe is a reliable measure of anything, but short
> of that I think we should either keep the code or put in some careful
> thought as to which restrictions make sense when changing
> /proc/self/exe.

I think the important ones are already there: checking that it is (a)
an executable and (b) that we have execute permission to it.

I also think the code is actually racy - while we are checking "did
the old mm_exe file have any mappings", there's nothing that keeps
another thread from changing the exe file to another one that _does_
have mappings, and then we'll happily replace it with yet another file
because we checked the old one, not the new one it was replaced by in
the meantime.

Of course, that "race" doesn't really matter - exactly because this
isn't about security, it's just a random "let's test that immaterial
thing, and we don't actually care about corner cases".

So I'm not saying that race needs to be fixed - I'm just pointing it
out as an example of how nonsensical the test really is. It's not
fundamental to anything, it's just a random "let's test this odd
condition".

That said, I don't care _that_ much. I'm happy with David's series, I
just think that once we don't do this at a mmap level any more, the
"go look for mappings" code makes little sense.

So we can leave it, and remove it later if people agree.

                  Linus
