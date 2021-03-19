Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946DD342369
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCSRgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCSRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:35:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:35:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j3so11693178edp.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kB3wMaglIcLKf7F3UpV4MdrlJMCKGqUAoltQ+BMHDS4=;
        b=fVDh6jF9M+OoMm38E3hF9oj+VaTCDTkwIuMTVvtW62vsnZBU64+pnsGfdeR6RAFc3G
         Gp4WCY0sv8RpKuzn6kNo0J+b8LBjQmMTJREDnChdN4txdIG9Gr4WMVJjRJOdYUm87R+P
         o7xHPoICgwzXwuq4rGkn9jTPrEVGxU3fLzuS8zrK8BKGpnJV3oCpcMLG+PHoghQcHZdR
         beS7xJ93uR4bvJBL9yFgEZ9YqSFXl138E98qHkr29stk0repAEuIPxZyhGq7IDJ9WOfZ
         VBtXozpdy2DSJD4fJVVsWLldsCCkH840iTNLg0bGvowosgBpMyiG3WcYL7Uyhj4HvnQd
         Cj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kB3wMaglIcLKf7F3UpV4MdrlJMCKGqUAoltQ+BMHDS4=;
        b=g8IlWMrj/1nH7JWK1VN/YBsKlZ/Tpf3vTqBNmEE1luHB6ZLKjg9a4PXXUYftAGRw/c
         9vtljNXHcOMNqB+uZM5Np9wzpZsAenvbMF3kWUcWg21qOboHN06TnBOn7S1Eo8792D+4
         iMsrj678O0COsdzDaBcCk780pKL6tq8T3BcHvWCDDMZac/SMcEWqKbxFFS+XBFeeRlYP
         P9silv+YYoUbNmpjTTQ8FliSCb1FHQm/1jQUWGYccnLTOgmAt/BL7LJrPvGaYKFO6Kqn
         E6MD0OgV6oyW1tgRWs8sc79W1/06ei6uqJYRSB9Pr3MWM2KrxnSGKOs7p3OHusdvD09X
         yGpg==
X-Gm-Message-State: AOAM531Wp2NACpBOBwwFHOLYTamARHNDR39rhug/uS6M+hI0rUS7o1w9
        9zc0I2JWx/HdhoD/6d43PGJLdYBDPReACJd+
X-Google-Smtp-Source: ABdhPJxTf/q2emE1qW05NY4RWOpvIh8CxujaPSro6L/Lm+yzo3uXQEBZ/HVDObejbA8Txnc+gGkqzA==
X-Received: by 2002:aa7:d792:: with SMTP id s18mr10817100edq.176.1616175327819;
        Fri, 19 Mar 2021 10:35:27 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id oy8sm4018291ejb.58.2021.03.19.10.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:35:27 -0700 (PDT)
Date:   Fri, 19 Mar 2021 17:35:25 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kdb: Get rid of custom debug heap allocator
Message-ID: <20210319173525.m5uagzthzzmtuldy@maple.lan>
References: <20210226095306.1236539-1-sumit.garg@linaro.org>
 <20210226105934.gmppt6kubfadv4uf@maple.lan>
 <CAFA6WYPXCKSYBH8Tapf_yg-jS7G0sH0Dmi27s6hutUMtSE39-Q@mail.gmail.com>
 <20210226173727.dqa5uytqwbll6omo@maple.lan>
 <CAFA6WYO0AHJmsGVQr0LPd8p4TS-3S=S_3OnzFS=q2R5p5FiXSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYO0AHJmsGVQr0LPd8p4TS-3S=S_3OnzFS=q2R5p5FiXSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:33:00AM +0530, Sumit Garg wrote:
> On Fri, 26 Feb 2021 at 23:07, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Feb 26, 2021 at 06:12:13PM +0530, Sumit Garg wrote:
> > > On Fri, 26 Feb 2021 at 16:29, Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > On Fri, Feb 26, 2021 at 03:23:06PM +0530, Sumit Garg wrote:
> > > > > Currently the only user for debug heap is kdbnearsym() which can be
> > > > > modified to rather ask the caller to supply a buffer for symbol name.
> > > > > So do that and modify kdbnearsym() callers to pass a symbol name buffer
> > > > > allocated statically and hence remove custom debug heap allocator.
> > > >
> > > > Why make the callers do this?
> > > >
> > > > The LRU buffers were managed inside kdbnearsym() why does switching to
> > > > an approach with a single buffer require us to push that buffer out to
> > > > the callers?
> > > >
> > >
> > > Earlier the LRU buffers managed namebuf uniqueness per caller (upto
> > > 100 callers)
> >
> > The uniqueness is per symbol, not per caller.
> >
> 
> Agree.
> 
> > > but if we switch to single entry in kdbnearsym() then all
> > > callers need to share common buffer which will lead to incorrect
> > > results from following simple sequence:
> > >
> > > kdbnearsym(word, &symtab1);
> > > kdbnearsym(word, &symtab2);
> > > kdb_symbol_print(word, &symtab1, 0);
> > > kdb_symbol_print(word, &symtab2, 0);
> > >
> > > But if we change to a unique static namebuf per caller then the
> > > following sequence will work:
> > >
> > > kdbnearsym(word, &symtab1, namebuf1);
> > > kdbnearsym(word, &symtab2, namebuf2);
> > > kdb_symbol_print(word, &symtab1, 0);
> > > kdb_symbol_print(word, &symtab2, 0);
> >
> > This is true but do any of the callers of kdbnearsym ever do this?
> 
> No, but any of prospective callers may need this.
> 
> > The
> > main reaason that heap stuck out as redundant was that I've only ever
> > seen the output of kdbnearsym() consumed almost immediately by a print.
> >
> 
> Yeah but I think the alternative proposed in this patch isn't as
> burdensome as the heap and tries to somewhat match existing
> functionality.
> 
> > I wrote an early version of a patch like this that just shrunk the LRU
> > cache down to 2 and avoided any heap usage... but I threw it away
> > when I realized we never carry cached values outside the function
> > that obtained them.
> >
> 
> Okay, so if you still think that having a single static buffer inside
> kdbnearsym() is an appropriate approach for time being then I will
> switch to use that instead.

Sorry to drop this thread for so long.

On reflection I still have a few concerns about the current code.
To be clear this is not really about wasting 128 bytes of RAM (your
patch saves 256K after all).

It's more that the current static buffers "look weird". They are static
so any competent OS programmer reads them and thinks "but what about
concurrency/reentrancy"). With the static buffers scattered through the
code they don't have a single place to find the answer.

I originally proposed handling this by the static buffer horror in
kdbnearsym() and describing how it all works in the header comment!
As much as anything this was to centralize the commentary in the
contract for calling kdbnearsym(). Hence nobody should write the
theoretic bug you describe because they read the contract!

You are welcome to counter propose but you must ensure that there are
equivalent comments so our "competent OS programmer" from the paragraph
above can figure out how the static buffer works without having to run 
git blame` and digging out the patch history.


Daniel.



> 
> -Sumit
> 
> >
> > > > > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
> > >
> > > >
> > > > > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > > > > index 9d69169582c6..6efe9ec53906 100644
> > > > > --- a/kernel/debug/kdb/kdb_main.c
> > > > > +++ b/kernel/debug/kdb/kdb_main.c
> > > > > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
> > > >
> > > > The documentation comment for this function has not been updated to
> > > > describe the new contract on callers of this function (e.g. if they
> > > > consume the symbol name they must do so before calling kdbgetaddrarg()
> > > > (and maybe kdbnearsym() again).
> > > >
> > >
> > > I am not sure if I follow you here. If we have a unique static buffer
> > > per caller then why do we need this new contract?
> >
> > I traced the code wrong. I thought it shared symtab->sym_name with its
> > own caller... but it doesn't it shares synname with its caller and
> > that's totally different...
> >
> >
> > Daniel.
> >
> > >
> > > >
> > > > >       char symbol = '\0';
> > > > >       char *cp;
> > > > >       kdb_symtab_t symtab;
> > > > > +     static char namebuf[KSYM_NAME_LEN];
> > > > >
> > > > >       /*
> > > > >        * If the enable flags prohibit both arbitrary memory access
> > > > > diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> > > > > index b59aad1f0b55..9b907a84f2db 100644
> > > > > --- a/kernel/debug/kdb/kdb_support.c
> > > > > +++ b/kernel/debug/kdb/kdb_support.c
> > > > > @@ -57,8 +57,6 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
> > > > >  }
> > > > >  EXPORT_SYMBOL(kdbgetsymval);
> > > > >
> > > > > -static char *kdb_name_table[100];    /* arbitrary size */
> > > > > -
> > > > >  /*
> > > > >   * kdbnearsym -      Return the name of the symbol with the nearest address
> > > > >   *   less than 'addr'.
> > > >
> > > > Again the documentation comment has not been updated and, in this case,
> > > > is now misleading.
> > >
> > > Okay, I will fix it.
> > >
> > > >
> > > > If we move the static buffer here then the remarks section on this
> > > > function is a really good place to describe what the callers must do to
> > > > manage the static buffer safely as well as a convenient place to mention
> > > > that we tolerate the reuse of the static buffer if kdb is re-entered
> > > > becase a) kdb is broken if that happens and b) we are crash resilient
> > > > if if does.
> > > >
> > > >
> > > > > @@ -79,13 +77,11 @@ static char *kdb_name_table[100]; /* arbitrary size */
> > > > >   *   hold active strings, no kdb caller of kdbnearsym makes more
> > > > >   *   than ~20 later calls before using a saved value.
> > > > >   */
> > > > > -int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > > > > +int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab, char *namebuf)
> > > >
> > > > As above, I don't understand why we need to add namebuf here. I think
> > > > the prototype can remain the same.
> > > >
> > > > Think of it simple that we have reduce the cache from having 100 entries
> > > > to having just 1 ;-) .
> > >
> > > Please see my response above.
> > >
> > > -Sumit
> > >
> > > >
> > > >
> > > > Daniel.
