Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5DB3F21ED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhHSUws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhHSUwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:52:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8688C061764
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:52:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f2so13669975ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJyUMpRvCKY0Vh89D3w3gONjiQnSaoV/zmqyDYmDpUA=;
        b=Y+pU8j9vQaWTxEhQ0j0tkQUmizFhaaD+mBD4UKDchtCcNJDPjhu50XdOkmR7wRhVkU
         sO/ZAyNE37DjaIrX3Jupm5Lmzorw4l3UwqrPdvdUzj38oBpjeDPsJPwAdFT5IzBfsdoc
         aflzICp2BeWzdnFJvaqwcQw0cXI2edPGK5Q7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJyUMpRvCKY0Vh89D3w3gONjiQnSaoV/zmqyDYmDpUA=;
        b=nllSbZPwXTcDYTnMvGP/Arn9MkJFkN/24Yy/x09j1yd+7a6A0fKFeG+LQc4hX4LJLp
         pZ4iIQ+1+pkRmi5BVurcKKAaLJJwSraw1/fo3FRf1CTq+f/7JknT6xQydMU7pWZdC9H2
         VfXTmrxXHEJodLlpd6R95WsKZWgUzFIpTgmfLlGqYIGhgbhyg/C5kF0qXkK5PffUUgtb
         iPeHpv5e5tiBZqGkPhg3JAEhAJe68O+pfdrQy3LqUCkultHOFFlnG40Nz+7nBpFddcyp
         D1NxOHpLz+PhI9b0MXGgBP4JOjwxiNejURv8i4ha8BTn8MuRiqvF6mC67r+F88vqPqWn
         zv6A==
X-Gm-Message-State: AOAM533L/d2MTc1For0Iqgl8J5iJpjrV3niNaTqEs/lct+vBkIpCuXRO
        hRMin6aR8Z3C2zo21TBmHV+pMDLMwId9sYVz9Jo=
X-Google-Smtp-Source: ABdhPJxj1ROBnK/UeOUkdq57zMMCl+qD4k4UYyZhAseAi7Y9nMJam1E6xVbzIkgsEXbRsLsjeqgd/Q==
X-Received: by 2002:a2e:a54a:: with SMTP id e10mr12991452ljn.503.1629406327882;
        Thu, 19 Aug 2021 13:52:07 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o20sm413680lfu.148.2021.08.19.13.52.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 13:52:07 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id o10so15636480lfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:52:07 -0700 (PDT)
X-Received: by 2002:a19:4f1a:: with SMTP id d26mr11559422lfb.377.1629406326706;
 Thu, 19 Aug 2021 13:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210816194840.42769-1-david@redhat.com> <20210816194840.42769-3-david@redhat.com>
In-Reply-To: <20210816194840.42769-3-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 13:51:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsLtJ7=+NGGSEbTw9XBh7qyf4Py9-jBdajGnPTxU1hZg@mail.gmail.com>
Message-ID: <CAHk-=wgsLtJ7=+NGGSEbTw9XBh7qyf4Py9-jBdajGnPTxU1hZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kernel/fork: factor out replacing the current MM exe_file
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

So I like this series.

However, logically, I think this part in replace_mm_exe_file() no
longer makes sense:

On Mon, Aug 16, 2021 at 12:50 PM David Hildenbrand <david@redhat.com> wrote:
>
> +       /* Forbid mm->exe_file change if old file still mapped. */
> +       old_exe_file = get_mm_exe_file(mm);
> +       if (old_exe_file) {
> +               mmap_read_lock(mm);
> +               for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
> +                       if (!vma->vm_file)
> +                               continue;
> +                       if (path_equal(&vma->vm_file->f_path,
> +                                      &old_exe_file->f_path))
> +                               ret = -EBUSY;
> +               }
> +               mmap_read_unlock(mm);
> +               fput(old_exe_file);
> +               if (ret)
> +                       return ret;
> +       }

and should just be removed.

NOTE! I think it makes sense within the context of this patch (where
you just move code around), but that it should then be removed in the
next patch that does that "always deny write access to current MM
exe_file" thing.

I just quoted it in the context of this patch, since the next patch
doesn't actually show this code any more.

In the *old* model - where the ETXTBUSY was about the mmap() of the
file - the above tests make sense.

But in the new model, walking the mappings just doesn't seem to be a
sensible operation any more. The mappings simply aren't what ETXTBUSY
is about in the new world order, and so doing that mapping walk seems
nonsensical.

Hmm?

                 Linus
