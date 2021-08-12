Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEFA3EA8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhHLRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHLRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:00:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241A7C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:00:28 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n7so11617323ljq.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMdbm1Duu6T2o7Pmii6aGZ5IPzKeI0bawgd87K5hISA=;
        b=XKB75bis9tKuNhHX3eDTMKeSxlvftJ15dFdW/PqjC89Ur4xgXcznCXav012keKDr9q
         uVwQApi3YeYfIStj4+gOxYXeF8i11qPieLQ1yiCkx373DM+kh0ueZlzSltpcrquT6StP
         3ucAz74g4LfHvAL2yjncpx8WOYjTgEkJKVJzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMdbm1Duu6T2o7Pmii6aGZ5IPzKeI0bawgd87K5hISA=;
        b=hC2ll0+96yheJ2RiOfkMW4bb1nMMDs6rkCBKMQlS4B6+/WUN6LnvGQi4ihsT8VOxNB
         D1Lkq2GNa8tc2S/0SZ5f/mxtOHjCCGwJkgClK5LbvLUvScrjUpa/CGL2xwHe+TY9+d8t
         H0RqEKwotja99FlWq8zSdi+3jmjwTW5gl4Sg0j6j13lyyAB6GaUdVOBRRYnK0P2PLNq+
         gUQrHoRPKCpnQagjR7h8KEW6U5DXUW8UMfbzuBc/9nWwvvY2+UhQ1Paqv6S1xZ6I9Ion
         sLwH7G/19gm8/EIOltssDds2KZy53oTXbMGNG7GvIAne3hpgOxpwUirJvjRDulxSeZcy
         /xGw==
X-Gm-Message-State: AOAM533heGUHWfO0CjUympdNFjSIMD4qxu7WeDBWlMCeZjSmSvQ4YB70
        OOVoa3m3Bmql2CHxJi6CcxvTyzO7EKhy+CeiHBQ=
X-Google-Smtp-Source: ABdhPJw543hiUiQ+7K/4X+jUQnOeFAKfkFwm9aYw3UwwIxdXdoKKr9DYR0IUr7eTUITcwwUUhmov9A==
X-Received: by 2002:a2e:9998:: with SMTP id w24mr3674480lji.86.1628787625777;
        Thu, 12 Aug 2021 10:00:25 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j1sm368839lji.124.2021.08.12.10.00.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:00:25 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id n17so14604453lft.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:00:25 -0700 (PDT)
X-Received: by 2002:a05:6512:1290:: with SMTP id u16mr3010715lfs.487.1628787137615;
 Thu, 12 Aug 2021 09:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <20210812084348.6521-4-david@redhat.com>
In-Reply-To: <20210812084348.6521-4-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 06:51:59 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjWgFbEaE9T0smQu8WKkhrcNZZrghBUQ9441OdMsDg1-w@mail.gmail.com>
Message-ID: <CAHk-=wjWgFbEaE9T0smQu8WKkhrcNZZrghBUQ9441OdMsDg1-w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] kernel/fork: always deny write access to current
 MM exe_file
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
        Michel Lespinasse <walken@google.com>,
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
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:45 PM David Hildenbrand <david@redhat.com> wrote:
>
>         /* No ordering required: file already has been exposed. */
> -       RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
> +       exe_file = get_mm_exe_file(oldmm);
> +       RCU_INIT_POINTER(mm->exe_file, exe_file);
> +       if (exe_file)
> +               deny_write_access(exe_file);

Can we make a helper function for this, since it's done in two different places?

> -       if (new_exe_file)
> +       if (new_exe_file) {
>                 get_file(new_exe_file);
> +               /*
> +                * exec code is required to deny_write_access() successfully,
> +                * so this cannot fail
> +                */
> +               deny_write_access(new_exe_file);
> +       }
>         rcu_assign_pointer(mm->exe_file, new_exe_file);

And the above looks positively wrong. The comment is also nonsensical,
in that it basically says "we thought this cannot fail, so we'll just
rely on it".

If it truly cannot fail, then the comment should give the reason, not
the "we depend on this not failing".

And honestly, I don't see why it couldn't fail. And if it *does* fail,
we cannot then RCU-assign the exe_file pointer with this, because
you'll get a counter imbalance when you do the allow_write_access()
later.

Anyway, do_open_execat() does do deny_write_access() with proper error
checking. I think that is the existing reference that you depend on -
so that it doesn't fail. So the comment could possibly say that the
only caller has done this, but can we not just use the reference
deny_write_access() directly, and not do a new one here?

IOW, maybe there's an extraneous 'allow_write_access()' somewhere that
should be dropped when we do the whole binprm dance in execve()?

             Linus
