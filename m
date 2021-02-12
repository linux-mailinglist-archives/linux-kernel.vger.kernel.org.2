Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672EA3197F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 02:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBLBZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 20:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBLBZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 20:25:01 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 17:24:21 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id t62so838801qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 17:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dCKEEGBad1vtrLBcctXNlKDK+ANduoVGoPVyzgMOphI=;
        b=E47mYWv3Stzwnppzl37fam8xT3lDdxoW6tL5MFqHF360n762WmUpej4AfbWcJUtMCb
         bGQkFUlBfIUVXXDJGKYXqdi9nlljGgWgZJVaXrMogJDFFCpKJOyyLJRR2/x941a70/TY
         e1kZZPUH3TVJkEPYAzgl92mODBHfuxwUXcr7/f0z0yJM6H6DKRFWXbL5XNwg2pf6abTa
         ajE5jV7Evaf4zm/Uz6CQhS5xrtTtOM7XUya0wNf1TnhIurdAbiCB+QzUtxZqboXH+zRP
         2Fjnw2sLZ7x7NcUw9eY6h21NYYaruBwh08/J28kahwOpn/RtgUGudsroddzSULfp3d8n
         I9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dCKEEGBad1vtrLBcctXNlKDK+ANduoVGoPVyzgMOphI=;
        b=DbkkhmSteI2sERh2IQL9h5mrRCkPROJFhHbPT2bdR1MRD5jIG5JXJ/+IF4a5qHDokj
         KCl21AS1nSLiU9yBbNYsoMFdinrd3nsnusAeZFyY+Q5UE8tEq7leooTzXUPDDfRaHJXa
         5G8gKslHYnt83Sx9jv8EbgqdeyhDeA4glEos6DJMEQvpG2DL6M745MPps6Owkm0+qmZB
         6zLQ8SCwTt6J1du69dN3S072x7jBDjgww3dXImFWhqCRpopVY0ZlPFBfZkNu2VCaWcfx
         AqI7JbTW6kK7eZNDzP4P/ePI02CfoSfi60gy3TVos/MpsDxoZZVWbvxCCQWbYp0MlAqI
         69EA==
X-Gm-Message-State: AOAM533DaXHWf1nOXGrGHgxiVfNw5EEJwikJiu1y/R/Rmqz3M1ZSF2pf
        kYPRESDLByQL1afxmVMxYG0=
X-Google-Smtp-Source: ABdhPJzkPUfqYqANtXULj3VdywFLTypho8xN7/Y/9nBRICs9kaa5NJHAxlQ3GlgcWDuqenYQ2Z9S5w==
X-Received: by 2002:a37:9e8e:: with SMTP id h136mr648349qke.50.1613093060197;
        Thu, 11 Feb 2021 17:24:20 -0800 (PST)
Received: from localhost ([2607:fb90:c68:5473:21b5:a5ca:7841:595c])
        by smtp.gmail.com with ESMTPSA id t8sm5016385qkt.125.2021.02.11.17.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 17:24:19 -0800 (PST)
Date:   Thu, 11 Feb 2021 17:24:17 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of
 bitmap
Message-ID: <20210212012417.GB167389@yury-ThinkPad>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <20210209225907.78405-7-paul.gortmaker@windriver.com>
 <CAAH8bW_fJi_PeHrXsPZzLtRP=-L99QJBXEvHkN9w6DBP-1FPWQ@mail.gmail.com>
 <20210210155825.GA28155@windriver.com>
 <YCQOmkfEH0lLJY8l@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQOmkfEH0lLJY8l@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 06:49:30PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 10, 2021 at 10:58:25AM -0500, Paul Gortmaker wrote:
> > [Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap] On 09/02/2021 (Tue 15:16) Yury Norov wrote:
> > 
> > > On Tue, Feb 9, 2021 at 3:01 PM Paul Gortmaker
> > > <paul.gortmaker@windriver.com> wrote:
> > 
> > [...]
> > 
> > > > -static const char *bitmap_getnum(const char *str, unsigned int *num)
> > > > +static const char *bitmap_getnum(const char *str, unsigned int *num,
> > > > +                                unsigned int lastbit)
> > > 
> > > The idea of struct bitmap_region is avoid passing the lastbit to the functions.
> > > But here you do pass. Can you please be consistent? Or if I misunderstand
> > > the idea of struct bitmap_region, can you please clarify it?
> > > 
> > > Also, I don't think that in this specific case it's worth it to create
> > > a hierarchy of
> > > structures. Just adding lastbits to struct region will be simpler and more
> > > transparent.
> > 
> > I'm getting mixed messages from different people as to what is wanted here.
> > 
> > Here is what the code looks like now; only relevant lines shown:
> > 
> >  -------------------------------
> > int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> > {
> > 
> >         struct region r;
> > 
> >         bitmap_parse_region(buf, &r);       <-----------
> >         bitmap_check_region(&r);
> >         bitmap_set_region(&r, maskp, nmaskbits);
> > }
> > 
> > static const char *bitmap_parse_region(const char *str, struct region *r)
> > {
> >         bitmap_getnum(str, &r->start);
> >         bitmap_getnum(str + 1, &r->end);
> >         bitmap_getnum(str + 1, &r->off);
> >         bitmap_getnum(str + 1, &r->group_len);
> > }
> > 
> > static const char *bitmap_getnum(const char *str, unsigned int *num)
> > {
> > 	/* PG: We need nmaskbits here for N processing. */
> > }
> >  -------------------------------
> > 
> > 
> > Note the final function - the one where you asked to locate the N
> > processing into -- does not take a region.  So even if we bundle nbits
> > into the region struct, it doesn't get the data to where we need it.
> > 
> > Choices:
> > 
> > 1) pass in nbits just like bitmap_set_region() does currently.
> > 
> > 2) add nbits to region and pass full region instead of start/end/off.
> > 
> > 2a) add nbits to region and pass full region and also start/end/off.
> > 
> > 3) use *num as a bi-directional data path and initialize with nbits.
> > 
> > 
> > Yury doesn't want us add any function args -- i.e. not to do #1.
> > 
> > Andy didn't like #2 because it "hides" that we are writing to r.
> > 
> > I ruled out sending 2a -- bitmap_getnum(str, r, &r->end)  because
> > it adds an arg, AND seems rather redundant to pass r and r->field.
> > 
> > The #3 is the smallest change - but seems like we are trying to be
> > too clever just to save a line of code or a couple bytes. (see below)
> > 
> > Yury - in your reply to patch 5, you indicate you wrote the region
> > code and want me to go back to putting nbits into region directly.
> > 
> > Can you guys please clarify who is maintainer and hence exactly how
> > you want this relatively minor detail handled?  I'll gladly do it
> > in whatever way the maintainer wants just to get this finally done.
> 
> Funny that there is no maintainer of the code.
> That said, I consider #1 or #3 is good enough. Rationale for
> - #1: it doesn't touch purity of getnum(), I think it's good enough not to know
>   region details
> - #3 (as you posted below): I like how it looks like (one nit below, though)
> 
> But let's put this way, I think Yury had done a lot in the area, let's listen
> more to him than to me.

I think that the simplest approach is the best. For me, the simplest
thing is to add a field to existing structure, like this:

        struct region {
                unsigned int start;
                unsigned int off; 
                unsigned int group_len;
                unsigned int end; 
                unsigned int nbits; 
        };

Of course we can do like:
 
        struct region {
                struct boundaries;
                struct periodic_part;
        };

        struct bitmap_region {
                struct region;
                unsigned int nbits; 
        };

But it would be nothing better than simple flat structure.

> > I'd rather not keep going in circles and guessing and annoying everyone
> > else on the Cc: list by filling their inbox any more than I already have.
> > 
> > That would help a lot in getting this finished.
> 
> Agree!
> 
> > Example #3 -- not sent..
> > 
> > +#define DECLARE_REGION(rname, initval) \
> > +struct region rname = {                \
> > +       .start = initval,               \
> > +       .off = initval,                 \
> > +       .group_len = initval,           \
> > +       .end = initval,                 \
> > +}
> > 
> > [...]
> > 
> > -       struct region r;
> > +       DECLARE_REGION(r, nmaskbits - 1);       /* "N-N:N/N" */
>
> I would initialize with nmaskbits to be sure the value is invalid, but it will
> add some code, below, so up to you, guys.

We don't need to initialize r because it's purely internal and helpers
don't expect that r is initialized, so it's waste of cycles.
 
> > +/*
> > + * Seeing 'N' tells us to leave the value of "num" unchanged (which will
> > + * be the max value for the width of the bitmap, set via DECLARE_REGION).
> > + */
> >  static const char *bitmap_getnum(const char *str, unsigned int *num)
> >  {
> >         unsigned long long n;
> >         unsigned int len;
> >  
> > +       if (str[0] == 'N')      /* nothing to do, just advance str */
> > +               return str + 1;

Is my understanding correct that this is an attempt to avoid adding
the nbits to struct region? It would probably work, but I'd prefer
to extend the structure. For me it's more readable and maintainable
approach.

Yury
