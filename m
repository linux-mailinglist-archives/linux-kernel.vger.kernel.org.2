Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751F740725E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhIJUSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233397AbhIJURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631305001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSpHJM1SZnkBSkR/Kgh/lAzpb1RsvELLm2gfxAvT8c8=;
        b=FD5P1fyoSiiSATLZ1WZsIxDRI3SskF1Kz7auYddEnUN3UP7DgL48aWsOXUEs0GRBh2FMGm
        /on7bJ7MVo37l0acJJQhBt07BMbIjBLrXKvcG8671Ft686hBw8cUfyej50ECEDn381hsR3
        izbNGi4MzkdchvjCw/k2OvQrAvmfLeM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-t4-sgk8gOTKXLKWSc2oflg-1; Fri, 10 Sep 2021 16:16:40 -0400
X-MC-Unique: t4-sgk8gOTKXLKWSc2oflg-1
Received: by mail-il1-f200.google.com with SMTP id m15-20020a056e021c2f00b0022c598b86c3so6764541ilh.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BSpHJM1SZnkBSkR/Kgh/lAzpb1RsvELLm2gfxAvT8c8=;
        b=IJWGYdJsPKVDEEdZHJIiiX9OnrfBwQRizdMddk4QBdBikvv80KbCk/rRsFR6CJWzxz
         Q9FOQqM40A7rkcTUtfq29CshVr4075bGZ+eeCzEkYbFmi/ZFxLHrLkSXsVeImDe37Aya
         UArLZvKl6qTcArzk+FyWVTyiUVUC9DD4Z8J8MT2kbzFcQvy1QP9aq5JRFVVjSuT3X4aR
         00m5FapvNA76t4inOca3FpbruxUqOh9wrPHJhYB+jiLrO9iiUiQRrkdxdpOcWshiYj/P
         5UU+cS/LZk08Ru8ZLaQeQvY5VmxTHljlF71mK6g+hOJrJme6VtupR9KhHgIiuKUW2x+8
         RRYA==
X-Gm-Message-State: AOAM532Uhq3ulmpqs6ishzxK/PNnikYSdpwL68qHUoh/4NWy92flaAZ5
        K7yWN7VDeto/2tZoY+H1D6RDVlQJyUECbzlP9mQAljPEs/9YCKqa1J/7gsioLw5gAK1FY5rhk+6
        4rMXYqvy8PAS12mXNpEtGDkT2
X-Received: by 2002:a92:6907:: with SMTP id e7mr7586460ilc.301.1631304999605;
        Fri, 10 Sep 2021 13:16:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1s3aiIVgMKgujAfSWAAc7n2l2wsOaUR3fXFlmmSP79YE+lV3YN+CbQgM084/SQUNiFUGwDg==
X-Received: by 2002:a92:6907:: with SMTP id e7mr7586445ilc.301.1631304999319;
        Fri, 10 Sep 2021 13:16:39 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id o15sm745714ilj.69.2021.09.10.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:16:38 -0700 (PDT)
Date:   Fri, 10 Sep 2021 15:16:35 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dyndbg: make dyndbg a known cli param
Message-ID: <20210910201635.4d3fhhrwvcusdwk2@halaneylaptop>
References: <20210909161755.61743-1-ahalaney@redhat.com>
 <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
 <CAJfuBxzX9nEvxC1s-4uRCzLwN0=3gbFT__9vO_coEM5CrpnJng@mail.gmail.com>
 <20210910182445.vao7uhqveaen25tk@halaneylaptop>
 <CAJfuBxzWwXCmw+YsonMCOaHq=21C-rVPL8BhZpDU0NPQW0B_8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxzWwXCmw+YsonMCOaHq=21C-rVPL8BhZpDU0NPQW0B_8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 01:31:22PM -0600, jim.cromie@gmail.com wrote:
> On Fri, Sep 10, 2021 at 12:24 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Fri, Sep 10, 2021 at 11:14:45AM -0600, jim.cromie@gmail.com wrote:
> > > On Thu, Sep 9, 2021 at 3:34 PM Jason Baron <jbaron@akamai.com> wrote:
> > >
> > > >
> > > >
> > > > On 9/9/21 12:17 PM, Andrew Halaney wrote:
> > > > > Right now dyndbg shows up as an unknown parameter if used on boot:
> > > > >
> > > > >     Unknown command line parameters: dyndbg=module params +p ; module
> > > > sys +p
> > > > >
> > > > > That's because it is unknown, it doesn't sit in the __param
> > > > > section, so the processing done to warn users supplying an unknown
> > > > > parameter doesn't think it is legitimate.
> > > > >
> > >
> > >
> > > your usage is incorrect for what youre trying to do in that example
> > > what you need is:
> > >
> > >   params.dyndbg=+p  sys.dyndbg=+p
> > >
> > > dyndbg is properly unknown as a kernel param, it isnt one.
> > > ( it was called a "fake" module param when added.)
> > > $module.dyndbg is good, since its after the $module. (and the dot)
> > > it also then inherits the "scan bootargs for relevant ones on module load"
> > > behavior
> > >
> > >
> >
> > That example is (slightly altered) from
> > Documentation/admin-guide/dynamic-debug-howto.rst,
> 
> oh dear, I see the lines youre referring to.
> I am surprised.
> fyi, those lines are:
>     // enable pr_debugs in 2 builtins, #cmt is stripped
>     dyndbg="module params +p #cmt ; module sys +p"
> 
> is your patchset removing those lines ?
> if so, ack that part.
> 
> > I can change the example used to be a little less confusing (using the
> > module keyword is confusing, I could use something like
> > func or file instead of what the docs use as an example).
> 
> yes please, I saw bad usage, thought faulty premise.
> 
> > Is that what you're after, a better example usage of dyndbg= being
> > whined about in dmesg for the commit message, or am I misunderstanding?
> 
> I guess Im inured to it.  Heres my regular version with a similar addition.
> 
> Unknown command line parameters:
> virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
> virtme_initmount0=/root virtme_initmount1=/root/sbin
> virtme_stty_con=rows 27 cols 109 iutf8
> virtme_chdir=home/jimc/projects/lx dyndbg=+p
> 
> most of them do something, just not for the kernel.
> 
> I dont think this is worth explicitly silencing.
> rather rip out the misleading doc.
> 

Ohhhhh, ok now I think I'm following what you and Jason are saying.

dyndbg= parameter does need to process the whole cli, for cases like
when $module.dyndbg= is supplied but $module is a builtin. And you are
saying that this syntax (although it works)
'dyndbg="module params +p #cmt ; module sys +p"' is not the intended
usage.

So converting dyndbg= to act like ddebug_query= won't work because
$module.dyndbg="+p" should work if $module is builtin or a module
(settles my open discussion with Jason).

I'm going to hold my ground and try and silence the warning, because I
think the kernel parameters interface is well defined enough (kernel
params go before the -- i.e. "these are kernel params -- these are for init"

With that in mind I'll make a v2 series out of this doing:
  1. Clean up the doc to show intended usage on cli, something like
     (params.dyndbg="+p" sys.dyndbg="+p" dyndbg="file init/main.c +p #cmt ; func pc87360_init_device +p")
  2. Remove ddebug_query per Jason's approval
  3. Silence the param with this patch here, with a commit message
     updated explaining why dyndbg= needs to be able to process the whole
     cli, per Jason

Please lemme know if there are any strong objections in the meantime and
thanks for the feedback!

> 
> > I agree that dyndbg right now (both dyndbg= and $module.dyndbg=) are
> > "fake" params, but I'd like to remove that message for dyndbg= as it is
> > misleading. The code for module loading luckily already handles it all
> > properly and doesn't warn on proper usage:
> >
> >     static int unknown_module_param_cb(char *param, char *val, const char *modname,
> >                        void *arg)
> >     {
> >         struct module *mod = arg;
> >         int ret;
> >
> >         if (strcmp(param, "async_probe") == 0) {
> >             mod->async_probe_requested = true;
> >             return 0;
> >         }
> >
> >         /* Check for magic 'dyndbg' arg */
> >         ret = ddebug_dyndbg_module_param_cb(param, val, modname);
> >         if (ret != 0)
> >             pr_warn("%s: unknown parameter '%s' ignored\n", modname, param);
> >         return 0;
> >     }
> >
> >
> > >
> > >
> > >
> > > >
> > > > > Install a dummy handler to register it. This was chosen instead of the
> > > > > approach the (deprecated) ddebug_query param takes, which is to
> > > > > have a real handler that copies the string taking up a KiB memory.
> > > > >
> > > > > Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> > > > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > > > ---
> > > > >
> > > > > This is the last valid param I know of that was getting flagged on boot
> > > > > if used correctly. Please let me know if the alternative approach of
> > > > > actually copying the string is preferred and I'll spin that up instead.
> > > > >
> > > >
> > > > Hi Andrew,
> > > >
> > > > So I think you are referring to the string copying that ddebug_query= does.
> > > > I don't think that works for 'dyndbg=' b/c its actually looking through
> > > > the entire command line for stuff like <module_name>.dyndbg="blah".
> > > >
> > > > So I think what you prposed below makes sense, we could perhaps add a note
> > > > as to why it's a noop. As I mentioned it needs to look through the entire
> > > > string.
> > > >
> > > >
> > > > > Sort of an aside, but what's the policy for removing deprecated cli
> > > > > params? ddebug_query has been deprecated for a very long time now, but I
> > > > > am not sure if removing params like that is considered almost as bad as
> > > > > breaking userspace considering some systems might update their kernels
> > > > > but not the bootloader supplying the param.
> > > >
> > > > I think it's probably ok to remove at this point, especially now that
> > > > we are going to flag it as unknown, right? So I feel like that change
> > > > can logically go with this series if you want as a separate patch.
> > > >
> > > > Thanks,
> > > >
> > > > -Jason
> > > >
> > > >
> > > > >
> > > > >  lib/dynamic_debug.c | 12 ++++++++++++
> > > > >  1 file changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > > > > index cb5abb42c16a..84c16309cc63 100644
> > > > > --- a/lib/dynamic_debug.c
> > > > > +++ b/lib/dynamic_debug.c
> > > > > @@ -761,6 +761,18 @@ static __init int ddebug_setup_query(char *str)
> > > > >
> > > > >  __setup("ddebug_query=", ddebug_setup_query);
> > > > >
> > > > > +/*
> > > > > + * Install a noop handler to make dyndbg look like a normal kernel cli
> > > > param.
> > > > > + * This avoids warnings about dyndbg being an unknown cli param when
> > > > supplied
> > > > > + * by a user.
> > > > > + */
> > > > > +static __init int dyndbg_setup(char *str)
> > > > > +{
> > > > > +     return 1;
> > > > > +}
> > > > > +
> > > > > +__setup("dyndbg=", dyndbg_setup);
> > > > > +
> > > > >  /*
> > > > >   * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers
> > > > the
> > > > >   * command text from userspace, parses and executes it.
> > > > >
> > > >
> >
> 

