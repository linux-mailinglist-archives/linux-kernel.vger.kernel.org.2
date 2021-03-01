Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11653327758
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCAGGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhCAGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:03:55 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F12C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 22:03:14 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id n16so6618333lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 22:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5+p89wmcRTNNV+DoPVNJPTQENWG1vX1KbzN9Cz/cN0=;
        b=rSeeF9p6bRGkezDtIr9TZf33lexnS0/9gyo2komWRPd60hDauQWTIgF617rODrWW2N
         iIygewHXGVFE4p1YjGr48eIdHMiqV3sJ18Wv/olQ6I1n79Rhkrc17v1eZg5qimnmvdsC
         99hXO0nLkNkZD7syjN6ijItChujWhFmBAm+AVaqN14sCgGy3AuSF6sycBEKS2XEh23V8
         0cIGvkrTLttFYWWoaE41RDFl9fSkgQvs3bHBdMdfVmRHPyQVE/7MuNL67i1UR8iDaFhh
         F7aTQbr+CbdtaOvcjFCgpxGYUQ2fNZ+RWAqym8QPeQrQtwakFHhc18+naI83MSrRyThr
         7Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5+p89wmcRTNNV+DoPVNJPTQENWG1vX1KbzN9Cz/cN0=;
        b=r3KiNxwKPuGpDvNlBap8JtsGuWMIFEreU5gUPHlIJMKM278VppJEINa7asb9t43tW8
         QksUAX17gWrITSvTQC/ZqGx1RaOTkKY9CyvN2pdU7Y9Z+iA1ZYQTAjnHSq2sZf3JPgYY
         3ZfE67Zl5QJQDcdstQMWahKTuvj+rgdZA4jfKeU0g+9UOMYUbtaWZMAUeSHzb/CjeUS1
         Dg/ZyqlQsXMgPRboDcO17omcKDJj3NX3TkTQw6XOQfXg1lqyAGDgYv4xg6buBxWCCkRD
         BBQAG1oOU9mlwZvc1u+p24k0XebrBKRMfnjtUtFVxaVXxlz3V46mWcbGZh9Po7w+2Z9s
         8F/w==
X-Gm-Message-State: AOAM533ijXXDoZiTtCA/y5dEsIxPKM5h7BWINWmhOD1m1oJDSfTchR5V
        zYBIs56UZKHNe8yqEDPI8ibjB5ghsmFqa02t2i/Aow==
X-Google-Smtp-Source: ABdhPJzceB3bTvWIkWkf1nJ1sz+48cpKT5slwIooq3ZAMqnB1a9PRUhVEqG6t3A4SL9HddKtn0498GWSAWYbL71ueS4=
X-Received: by 2002:a19:4192:: with SMTP id o140mr8547067lfa.302.1614578592161;
 Sun, 28 Feb 2021 22:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20210226095306.1236539-1-sumit.garg@linaro.org>
 <20210226105934.gmppt6kubfadv4uf@maple.lan> <CAFA6WYPXCKSYBH8Tapf_yg-jS7G0sH0Dmi27s6hutUMtSE39-Q@mail.gmail.com>
 <20210226173727.dqa5uytqwbll6omo@maple.lan>
In-Reply-To: <20210226173727.dqa5uytqwbll6omo@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Mar 2021 11:33:00 +0530
Message-ID: <CAFA6WYO0AHJmsGVQr0LPd8p4TS-3S=S_3OnzFS=q2R5p5FiXSA@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Get rid of custom debug heap allocator
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 at 23:07, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Feb 26, 2021 at 06:12:13PM +0530, Sumit Garg wrote:
> > On Fri, 26 Feb 2021 at 16:29, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, Feb 26, 2021 at 03:23:06PM +0530, Sumit Garg wrote:
> > > > Currently the only user for debug heap is kdbnearsym() which can be
> > > > modified to rather ask the caller to supply a buffer for symbol name.
> > > > So do that and modify kdbnearsym() callers to pass a symbol name buffer
> > > > allocated statically and hence remove custom debug heap allocator.
> > >
> > > Why make the callers do this?
> > >
> > > The LRU buffers were managed inside kdbnearsym() why does switching to
> > > an approach with a single buffer require us to push that buffer out to
> > > the callers?
> > >
> >
> > Earlier the LRU buffers managed namebuf uniqueness per caller (upto
> > 100 callers)
>
> The uniqueness is per symbol, not per caller.
>

Agree.

> > but if we switch to single entry in kdbnearsym() then all
> > callers need to share common buffer which will lead to incorrect
> > results from following simple sequence:
> >
> > kdbnearsym(word, &symtab1);
> > kdbnearsym(word, &symtab2);
> > kdb_symbol_print(word, &symtab1, 0);
> > kdb_symbol_print(word, &symtab2, 0);
> >
> > But if we change to a unique static namebuf per caller then the
> > following sequence will work:
> >
> > kdbnearsym(word, &symtab1, namebuf1);
> > kdbnearsym(word, &symtab2, namebuf2);
> > kdb_symbol_print(word, &symtab1, 0);
> > kdb_symbol_print(word, &symtab2, 0);
>
> This is true but do any of the callers of kdbnearsym ever do this?

No, but any of prospective callers may need this.

> The
> main reaason that heap stuck out as redundant was that I've only ever
> seen the output of kdbnearsym() consumed almost immediately by a print.
>

Yeah but I think the alternative proposed in this patch isn't as
burdensome as the heap and tries to somewhat match existing
functionality.

> I wrote an early version of a patch like this that just shrunk the LRU
> cache down to 2 and avoided any heap usage... but I threw it away
> when I realized we never carry cached values outside the function
> that obtained them.
>

Okay, so if you still think that having a single static buffer inside
kdbnearsym() is an appropriate approach for time being then I will
switch to use that instead.

-Sumit

>
> > > > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
> >
> > >
> > > > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > > > index 9d69169582c6..6efe9ec53906 100644
> > > > --- a/kernel/debug/kdb/kdb_main.c
> > > > +++ b/kernel/debug/kdb/kdb_main.c
> > > > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
> > >
> > > The documentation comment for this function has not been updated to
> > > describe the new contract on callers of this function (e.g. if they
> > > consume the symbol name they must do so before calling kdbgetaddrarg()
> > > (and maybe kdbnearsym() again).
> > >
> >
> > I am not sure if I follow you here. If we have a unique static buffer
> > per caller then why do we need this new contract?
>
> I traced the code wrong. I thought it shared symtab->sym_name with its
> own caller... but it doesn't it shares synname with its caller and
> that's totally different...
>
>
> Daniel.
>
> >
> > >
> > > >       char symbol = '\0';
> > > >       char *cp;
> > > >       kdb_symtab_t symtab;
> > > > +     static char namebuf[KSYM_NAME_LEN];
> > > >
> > > >       /*
> > > >        * If the enable flags prohibit both arbitrary memory access
> > > > diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> > > > index b59aad1f0b55..9b907a84f2db 100644
> > > > --- a/kernel/debug/kdb/kdb_support.c
> > > > +++ b/kernel/debug/kdb/kdb_support.c
> > > > @@ -57,8 +57,6 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
> > > >  }
> > > >  EXPORT_SYMBOL(kdbgetsymval);
> > > >
> > > > -static char *kdb_name_table[100];    /* arbitrary size */
> > > > -
> > > >  /*
> > > >   * kdbnearsym -      Return the name of the symbol with the nearest address
> > > >   *   less than 'addr'.
> > >
> > > Again the documentation comment has not been updated and, in this case,
> > > is now misleading.
> >
> > Okay, I will fix it.
> >
> > >
> > > If we move the static buffer here then the remarks section on this
> > > function is a really good place to describe what the callers must do to
> > > manage the static buffer safely as well as a convenient place to mention
> > > that we tolerate the reuse of the static buffer if kdb is re-entered
> > > becase a) kdb is broken if that happens and b) we are crash resilient
> > > if if does.
> > >
> > >
> > > > @@ -79,13 +77,11 @@ static char *kdb_name_table[100]; /* arbitrary size */
> > > >   *   hold active strings, no kdb caller of kdbnearsym makes more
> > > >   *   than ~20 later calls before using a saved value.
> > > >   */
> > > > -int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > > > +int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab, char *namebuf)
> > >
> > > As above, I don't understand why we need to add namebuf here. I think
> > > the prototype can remain the same.
> > >
> > > Think of it simple that we have reduce the cache from having 100 entries
> > > to having just 1 ;-) .
> >
> > Please see my response above.
> >
> > -Sumit
> >
> > >
> > >
> > > Daniel.
