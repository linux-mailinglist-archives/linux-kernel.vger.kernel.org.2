Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339C43457CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCWG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCWG1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:27:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3301DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:27:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n138so24959478lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tf3+ufm9CCQWVkrT07EmAz18ZuZ1xI3SfrYzdfNmVEs=;
        b=hKD863u5GWp09THn+Fjpe3f27PjIOM2kUWsUcHLpFeMMvK4PACsFwnZaxfIvS9+WtO
         8o8wE6nUgBWRjJIPYEuCHruJ0o9MrIciN17RvW0ipbGVgXeHP0JBIwuwtTjeBv2l3UTH
         ktzFiHIxm7igxMrAHr1G/P34mrU6h5kruu9efCUaS6I9dBgzOdsueuUlIgYeN7sFC0BK
         yFi1XNnhBsralnp0YyUG3YYxzINrbYTc3G+Nyk05o6EYffTmsxIgBkUK6uwfBiMTp3Ag
         WWtCwieB5CZEXXuJzB/cmsTVu5yCzROZTGh7gjImTDt14BnejgL8CioD5EZq3jPrgvmz
         2//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tf3+ufm9CCQWVkrT07EmAz18ZuZ1xI3SfrYzdfNmVEs=;
        b=EMkz1VkzjBf5sL4K5w6TR2Ek/2GxC4h7+xr0pHdhTe/MEFDBAFOP2M1X0daf/YXUpu
         I4eWXHjQKoknxIGYYlflKsWJHOSOboeTqts4Z/RdmMsR3J++tdK+Lr7VJmcvSug2R2lf
         xz9STc8jZFawklnoT3BCnqziyThAaPhBYYjuFtGfRe1nrFYuctlw1KtuYFJQhGSgz6b8
         M9ON0/OSdQsu/R1TL/IwwnmVh6apGdvdlQa9Ex5brEl3tM0+LUwYvg0YFSE7VVmcujlB
         5NRvwfi4DL7D2F2RwtH1DarSQE/A/HOoCwABDQELKDCLhQjgEnllE2bbQo/jUP2WNJMl
         a79g==
X-Gm-Message-State: AOAM5334YEkGSkL2CzhsHcXU4taYlQoXaPPbUgJJtxOf7HnAuF4206Uc
        2hVLXwE9JOuG8b1CoN/g/SUL/0T+9llijdCoIDn/FQ==
X-Google-Smtp-Source: ABdhPJxTk+dXu/p8uzS5HVx5K721riyriY7sjL+rW5yxBSauGuOeMLtQR07/nLtidTe2MFJjtOzXDWK67GiEvNdZo9Q=
X-Received: by 2002:ac2:46db:: with SMTP id p27mr1720809lfo.396.1616480829596;
 Mon, 22 Mar 2021 23:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210226095306.1236539-1-sumit.garg@linaro.org>
 <20210226105934.gmppt6kubfadv4uf@maple.lan> <CAFA6WYPXCKSYBH8Tapf_yg-jS7G0sH0Dmi27s6hutUMtSE39-Q@mail.gmail.com>
 <20210226173727.dqa5uytqwbll6omo@maple.lan> <CAFA6WYO0AHJmsGVQr0LPd8p4TS-3S=S_3OnzFS=q2R5p5FiXSA@mail.gmail.com>
 <20210319173525.m5uagzthzzmtuldy@maple.lan>
In-Reply-To: <20210319173525.m5uagzthzzmtuldy@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Mar 2021 11:56:58 +0530
Message-ID: <CAFA6WYPEPQJ+bYvk7LbBmkYEuv91FgrzPjcQWG5r9vFTucUBVg@mail.gmail.com>
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

On Fri, 19 Mar 2021 at 23:05, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Mar 01, 2021 at 11:33:00AM +0530, Sumit Garg wrote:
> > On Fri, 26 Feb 2021 at 23:07, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, Feb 26, 2021 at 06:12:13PM +0530, Sumit Garg wrote:
> > > > On Fri, 26 Feb 2021 at 16:29, Daniel Thompson
> > > > <daniel.thompson@linaro.org> wrote:
> > > > >
> > > > > On Fri, Feb 26, 2021 at 03:23:06PM +0530, Sumit Garg wrote:
> > > > > > Currently the only user for debug heap is kdbnearsym() which can be
> > > > > > modified to rather ask the caller to supply a buffer for symbol name.
> > > > > > So do that and modify kdbnearsym() callers to pass a symbol name buffer
> > > > > > allocated statically and hence remove custom debug heap allocator.
> > > > >
> > > > > Why make the callers do this?
> > > > >
> > > > > The LRU buffers were managed inside kdbnearsym() why does switching to
> > > > > an approach with a single buffer require us to push that buffer out to
> > > > > the callers?
> > > > >
> > > >
> > > > Earlier the LRU buffers managed namebuf uniqueness per caller (upto
> > > > 100 callers)
> > >
> > > The uniqueness is per symbol, not per caller.
> > >
> >
> > Agree.
> >
> > > > but if we switch to single entry in kdbnearsym() then all
> > > > callers need to share common buffer which will lead to incorrect
> > > > results from following simple sequence:
> > > >
> > > > kdbnearsym(word, &symtab1);
> > > > kdbnearsym(word, &symtab2);
> > > > kdb_symbol_print(word, &symtab1, 0);
> > > > kdb_symbol_print(word, &symtab2, 0);
> > > >
> > > > But if we change to a unique static namebuf per caller then the
> > > > following sequence will work:
> > > >
> > > > kdbnearsym(word, &symtab1, namebuf1);
> > > > kdbnearsym(word, &symtab2, namebuf2);
> > > > kdb_symbol_print(word, &symtab1, 0);
> > > > kdb_symbol_print(word, &symtab2, 0);
> > >
> > > This is true but do any of the callers of kdbnearsym ever do this?
> >
> > No, but any of prospective callers may need this.
> >
> > > The
> > > main reaason that heap stuck out as redundant was that I've only ever
> > > seen the output of kdbnearsym() consumed almost immediately by a print.
> > >
> >
> > Yeah but I think the alternative proposed in this patch isn't as
> > burdensome as the heap and tries to somewhat match existing
> > functionality.
> >
> > > I wrote an early version of a patch like this that just shrunk the LRU
> > > cache down to 2 and avoided any heap usage... but I threw it away
> > > when I realized we never carry cached values outside the function
> > > that obtained them.
> > >
> >
> > Okay, so if you still think that having a single static buffer inside
> > kdbnearsym() is an appropriate approach for time being then I will
> > switch to use that instead.
>
> Sorry to drop this thread for so long.
>
> On reflection I still have a few concerns about the current code.
> To be clear this is not really about wasting 128 bytes of RAM (your
> patch saves 256K after all).
>
> It's more that the current static buffers "look weird". They are static
> so any competent OS programmer reads them and thinks "but what about
> concurrency/reentrancy"). With the static buffers scattered through the
> code they don't have a single place to find the answer.
>
> I originally proposed handling this by the static buffer horror in
> kdbnearsym() and describing how it all works in the header comment!
> As much as anything this was to centralize the commentary in the
> contract for calling kdbnearsym(). Hence nobody should write the
> theoretic bug you describe because they read the contract!
>
> You are welcome to counter propose but you must ensure that there are
> equivalent comments so our "competent OS programmer" from the paragraph
> above can figure out how the static buffer works without having to run
> git blame` and digging out the patch history.
>

Okay, I understand your point here. Let me go ahead with a single
static buffer in kdbnearsym() with a proper header comment.

-Sumit

>
> Daniel.
>
>
>
> >
> > -Sumit
> >
> > >
> > > > > > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
> > > >
> > > > >
> > > > > > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > > > > > index 9d69169582c6..6efe9ec53906 100644
> > > > > > --- a/kernel/debug/kdb/kdb_main.c
> > > > > > +++ b/kernel/debug/kdb/kdb_main.c
> > > > > > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
> > > > >
> > > > > The documentation comment for this function has not been updated to
> > > > > describe the new contract on callers of this function (e.g. if they
> > > > > consume the symbol name they must do so before calling kdbgetaddrarg()
> > > > > (and maybe kdbnearsym() again).
> > > > >
> > > >
> > > > I am not sure if I follow you here. If we have a unique static buffer
> > > > per caller then why do we need this new contract?
> > >
> > > I traced the code wrong. I thought it shared symtab->sym_name with its
> > > own caller... but it doesn't it shares synname with its caller and
> > > that's totally different...
> > >
> > >
> > > Daniel.
> > >
> > > >
> > > > >
> > > > > >       char symbol = '\0';
> > > > > >       char *cp;
> > > > > >       kdb_symtab_t symtab;
> > > > > > +     static char namebuf[KSYM_NAME_LEN];
> > > > > >
> > > > > >       /*
> > > > > >        * If the enable flags prohibit both arbitrary memory access
> > > > > > diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> > > > > > index b59aad1f0b55..9b907a84f2db 100644
> > > > > > --- a/kernel/debug/kdb/kdb_support.c
> > > > > > +++ b/kernel/debug/kdb/kdb_support.c
> > > > > > @@ -57,8 +57,6 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(kdbgetsymval);
> > > > > >
> > > > > > -static char *kdb_name_table[100];    /* arbitrary size */
> > > > > > -
> > > > > >  /*
> > > > > >   * kdbnearsym -      Return the name of the symbol with the nearest address
> > > > > >   *   less than 'addr'.
> > > > >
> > > > > Again the documentation comment has not been updated and, in this case,
> > > > > is now misleading.
> > > >
> > > > Okay, I will fix it.
> > > >
> > > > >
> > > > > If we move the static buffer here then the remarks section on this
> > > > > function is a really good place to describe what the callers must do to
> > > > > manage the static buffer safely as well as a convenient place to mention
> > > > > that we tolerate the reuse of the static buffer if kdb is re-entered
> > > > > becase a) kdb is broken if that happens and b) we are crash resilient
> > > > > if if does.
> > > > >
> > > > >
> > > > > > @@ -79,13 +77,11 @@ static char *kdb_name_table[100]; /* arbitrary size */
> > > > > >   *   hold active strings, no kdb caller of kdbnearsym makes more
> > > > > >   *   than ~20 later calls before using a saved value.
> > > > > >   */
> > > > > > -int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > > > > > +int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab, char *namebuf)
> > > > >
> > > > > As above, I don't understand why we need to add namebuf here. I think
> > > > > the prototype can remain the same.
> > > > >
> > > > > Think of it simple that we have reduce the cache from having 100 entries
> > > > > to having just 1 ;-) .
> > > >
> > > > Please see my response above.
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > >
> > > > > Daniel.
