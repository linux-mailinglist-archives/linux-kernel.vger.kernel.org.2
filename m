Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6050A401104
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhIERSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhIERSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 13:18:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C44C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 10:17:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t19so8610583lfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpxSclMyPpq3hjTkndeLX+vXWq2jAp6AUp9RJSFInpc=;
        b=gK/q/jXjhkCQnjJcvu9HTWv3Xy/cZUkhrGXV+w6Yieir7RJN0wnXBCgrW7qEaTLfMe
         oYo31t90pvfHuligx33j3D0RxXp6Y2ZbKY0rpcBN0DvbvSQ1EHWrcrgoKint1hxYzqDA
         HGx76j07IWwevhOJYViS08kEj6stJNiezUr3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpxSclMyPpq3hjTkndeLX+vXWq2jAp6AUp9RJSFInpc=;
        b=Fz1qCQDKE8GalcfAkBfEt/tfoU7/9TZbnNSwxZ4WtHo4o+B2QZPI7c56DiapBzFB92
         cpC1o299u5xtkIkE7wiBvu1ZSVJ+V+twGT+JMR/Z6dDYOlhEfcuqCuYi8Enpsrf1kLTT
         eYfYZxr4H2tMhIE4fZnTUPox6UQYzXGbMdNeJ/fSKmDSrn1oMKrrJEICqcyp2kmgGrw2
         hHbanpCdg2puFfhOPMzZlmKBlB56N6L5emxYA58eCgMadbd4JmYQnELvvXIBtw8OPmI0
         gPEvCixQbEhH0fb7XVmiFG3L57zg1Kq6s/526+C/Su+oauJadhIrsTYA3Q9vsZ67tTsm
         ds3Q==
X-Gm-Message-State: AOAM530S71uBqegGmQniufBoHG7jvo8sfRIk0AsgeN/YrFsD1U4u2E6x
        DP2XDGxkCZa91lIps4GdLZw0goQpzlGLEX5o
X-Google-Smtp-Source: ABdhPJy0hT8ph71FP4dKk3Bs4UKmQbfL1mTzMaIa2/diPaOHgFPV2f4aQ2aeLeMGOQp2tpGHcYJhBg==
X-Received: by 2002:ac2:4359:: with SMTP id o25mr6771186lfl.106.1630862265331;
        Sun, 05 Sep 2021 10:17:45 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v16sm710451ljc.138.2021.09.05.10.17.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 10:17:43 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id w4so7094483ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 10:17:42 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr7195539ljp.494.1630862262563;
 Sun, 05 Sep 2021 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210816194840.42769-1-david@redhat.com> <20210816194840.42769-2-david@redhat.com>
 <20210905153229.GA3019909@roeck-us.net>
In-Reply-To: <20210905153229.GA3019909@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Sep 2021 10:17:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO-dnNxz5H8yfnGsNxrDHu-TVQq-X-VwhoDyWu3Lgnyg@mail.gmail.com>
Message-ID: <CAHk-=whO-dnNxz5H8yfnGsNxrDHu-TVQq-X-VwhoDyWu3Lgnyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] binfmt: don't use MAP_DENYWRITE when loading
 shared libraries via uselib()
To:     Guenter Roeck <linux@roeck-us.net>
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

On Sun, Sep 5, 2021 at 8:32 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Guess someone didn't care compile testing their code. This is now in
> mainline.

To be fair, a.out is disabled pretty much on all relevant platforms these days.

Only alpha and m68k left, I think.

I applied the obvious patch from Geert.

            Linus
