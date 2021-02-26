Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D945326660
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBZRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBZRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:38:11 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC881C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:37:30 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n4so7071517wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=veZgy17Qv7a6dOErF+0HWjSOpg9SVAzw3NpOggfjmDQ=;
        b=qxK9tJ80SkTns5/mqJrFGM+Y8je0U6Fppv1OGwiYyeWQauXU4nt77C561Hjj+RJMEe
         G7AuPNzsWq1UbSiCLY1pLITemweSTK03hLwO9L7aoBirYeN+k5EZrW/uoiUImFJSoZhg
         zTgKSXjU3QQbWgDYTeHbn+1nyWaXu6wD04KEz0Sl/xdGHiiju3kyaWQVkB7UwXw4lf3h
         wHJUeu9Vrg1fTN/Lml3JdBqDbIKmBhan57wi54z9rhHVu5kmx3nCRnZWn0VvG5hbiXIk
         a5sY7LObqQCliXUhAakL01bHVtlU+EZ+VLbUxBGzM5L62kAI36yCHtm3k0vjaPXa9b/S
         PV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=veZgy17Qv7a6dOErF+0HWjSOpg9SVAzw3NpOggfjmDQ=;
        b=Mbmw91YJO7k0O9n2dbSGNP6wxnobO3YXlxrRtHsmwzDvCHE/1KPHMFdtfp98/BeWCX
         B7jyc8P8/z6Nve0UPSDNp+7jMkQobVelV0g9Meh0lk+gAEbROSYlZr3Da08IuQo7jRxE
         lCG7fhS02rEwHY57KEQk0JsAo87vocegCQVCp1kdtI2sGEXYa0fKQslLv9wcwui8ueG7
         f8b9+/S5id2J9g5u4UhUTEHS4lZYRAatBhpYkg4Yv1KaD4Eh3/nPQcG463PtHFttF///
         +2CZs0WXPO7ShchxLk62NZXuA0IGzlvBGDav7lK3V74QdtmSqmJuPwClJH60XT6dKFbv
         t+XQ==
X-Gm-Message-State: AOAM530Go7cb5ndebd4AxwILHc0x4F0+aKDOcNgQDd3vlN6m0YEXE7lC
        B6/TqLSB00Ou9MY1Rp0ppjAXPw==
X-Google-Smtp-Source: ABdhPJzrqayqs3QwF66mzSrY3iQ3M0cQTtC+IsYvltl94Zm8cmNJRbwF7yNDnGO3/B3OqzwnITZh2Q==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr3954732wmo.97.1614361049311;
        Fri, 26 Feb 2021 09:37:29 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q140sm14556328wme.0.2021.02.26.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:37:28 -0800 (PST)
Date:   Fri, 26 Feb 2021 17:37:27 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kdb: Get rid of custom debug heap allocator
Message-ID: <20210226173727.dqa5uytqwbll6omo@maple.lan>
References: <20210226095306.1236539-1-sumit.garg@linaro.org>
 <20210226105934.gmppt6kubfadv4uf@maple.lan>
 <CAFA6WYPXCKSYBH8Tapf_yg-jS7G0sH0Dmi27s6hutUMtSE39-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPXCKSYBH8Tapf_yg-jS7G0sH0Dmi27s6hutUMtSE39-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 06:12:13PM +0530, Sumit Garg wrote:
> On Fri, 26 Feb 2021 at 16:29, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Feb 26, 2021 at 03:23:06PM +0530, Sumit Garg wrote:
> > > Currently the only user for debug heap is kdbnearsym() which can be
> > > modified to rather ask the caller to supply a buffer for symbol name.
> > > So do that and modify kdbnearsym() callers to pass a symbol name buffer
> > > allocated statically and hence remove custom debug heap allocator.
> >
> > Why make the callers do this?
> >
> > The LRU buffers were managed inside kdbnearsym() why does switching to
> > an approach with a single buffer require us to push that buffer out to
> > the callers?
> >
> 
> Earlier the LRU buffers managed namebuf uniqueness per caller (upto
> 100 callers)

The uniqueness is per symbol, not per caller.

> but if we switch to single entry in kdbnearsym() then all
> callers need to share common buffer which will lead to incorrect
> results from following simple sequence:
> 
> kdbnearsym(word, &symtab1);
> kdbnearsym(word, &symtab2);
> kdb_symbol_print(word, &symtab1, 0);
> kdb_symbol_print(word, &symtab2, 0);
> 
> But if we change to a unique static namebuf per caller then the
> following sequence will work:
> 
> kdbnearsym(word, &symtab1, namebuf1);
> kdbnearsym(word, &symtab2, namebuf2);
> kdb_symbol_print(word, &symtab1, 0);
> kdb_symbol_print(word, &symtab2, 0);

This is true but do any of the callers of kdbnearsym ever do this? The
main reaason that heap stuck out as redundant was that I've only ever
seen the output of kdbnearsym() consumed almost immediately by a print.

I wrote an early version of a patch like this that just shrunk the LRU
cache down to 2 and avoided any heap usage... but I threw it away
when I realized we never carry cached values outside the function
that obtained them.


> > > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
> 
> >
> > > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > > index 9d69169582c6..6efe9ec53906 100644
> > > --- a/kernel/debug/kdb/kdb_main.c
> > > +++ b/kernel/debug/kdb/kdb_main.c
> > > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
> >
> > The documentation comment for this function has not been updated to
> > describe the new contract on callers of this function (e.g. if they
> > consume the symbol name they must do so before calling kdbgetaddrarg()
> > (and maybe kdbnearsym() again).
> >
> 
> I am not sure if I follow you here. If we have a unique static buffer
> per caller then why do we need this new contract?

I traced the code wrong. I thought it shared symtab->sym_name with its
own caller... but it doesn't it shares synname with its caller and
that's totally different...


Daniel.

> 
> >
> > >       char symbol = '\0';
> > >       char *cp;
> > >       kdb_symtab_t symtab;
> > > +     static char namebuf[KSYM_NAME_LEN];
> > >
> > >       /*
> > >        * If the enable flags prohibit both arbitrary memory access
> > > diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> > > index b59aad1f0b55..9b907a84f2db 100644
> > > --- a/kernel/debug/kdb/kdb_support.c
> > > +++ b/kernel/debug/kdb/kdb_support.c
> > > @@ -57,8 +57,6 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
> > >  }
> > >  EXPORT_SYMBOL(kdbgetsymval);
> > >
> > > -static char *kdb_name_table[100];    /* arbitrary size */
> > > -
> > >  /*
> > >   * kdbnearsym -      Return the name of the symbol with the nearest address
> > >   *   less than 'addr'.
> >
> > Again the documentation comment has not been updated and, in this case,
> > is now misleading.
> 
> Okay, I will fix it.
> 
> >
> > If we move the static buffer here then the remarks section on this
> > function is a really good place to describe what the callers must do to
> > manage the static buffer safely as well as a convenient place to mention
> > that we tolerate the reuse of the static buffer if kdb is re-entered
> > becase a) kdb is broken if that happens and b) we are crash resilient
> > if if does.
> >
> >
> > > @@ -79,13 +77,11 @@ static char *kdb_name_table[100]; /* arbitrary size */
> > >   *   hold active strings, no kdb caller of kdbnearsym makes more
> > >   *   than ~20 later calls before using a saved value.
> > >   */
> > > -int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > > +int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab, char *namebuf)
> >
> > As above, I don't understand why we need to add namebuf here. I think
> > the prototype can remain the same.
> >
> > Think of it simple that we have reduce the cache from having 100 entries
> > to having just 1 ;-) .
> 
> Please see my response above.
> 
> -Sumit
> 
> >
> >
> > Daniel.
