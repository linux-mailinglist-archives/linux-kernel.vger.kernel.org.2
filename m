Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD74070DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhIJS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 14:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhIJS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631298291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mL8ilcZymUIqeyt0xteUM3RAzyl0K33rhA8s46l4fOs=;
        b=FPzffdRPU/EqjhjkJUPjKMGdDucgBe+EQD7hCD2ULLVESu0UNT2nY23clP7An+Ot4iJDeJ
        72Np+Zw3Jg6Y1FARSaSBbJNOfEGORPjJqaCk86xmCirLpbJ8Zpf6kdhR3dhuAAOiJsuY7A
        mB3ePnBLw1ZzjzNl/9UYANThplWPgE0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-MMTSz2STNz6Xw64PhLzdbA-1; Fri, 10 Sep 2021 14:24:50 -0400
X-MC-Unique: MMTSz2STNz6Xw64PhLzdbA-1
Received: by mail-io1-f70.google.com with SMTP id g2-20020a6b7602000000b005be59530196so5292820iom.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mL8ilcZymUIqeyt0xteUM3RAzyl0K33rhA8s46l4fOs=;
        b=Y1mYqSO2Rb+iax5xOUpZN+BDhEABlCB3wo6aCr6TYDHGLXfEy5Ss+fnnD6Q86Y6NQN
         Y40jeF2liqYwWj3y27QMCOB1eqX8eh8pn0SbeC1VAN0zyjlVkCviCiCGb+Bx4NQqqsLD
         QVrau9bsdWBgC/y4n8I/oT3huvdFWNE9/7CnySLCFgP3nFCsDM/j9HYTXdkCeUTnZiaj
         adBozi0ledeJkA0xtRmhr4m5EV11JJHEpUCtQWXCbTpHJwkQtJUbm0ZJvHz121g2rEtW
         BxhR4dnb60mvvl3NViuaheMpmSdEOcstNGgYoXHpQjdHhvhM6tsOX7JxHP0L5Ze3e326
         SfIQ==
X-Gm-Message-State: AOAM530qlmhAvsOZ03tSxVujcKCoAEY4SUXeSyzbLMQiOedLaKNRlic8
        CLx3IOeQsL1jlrBJD+AmH6BB4lCdlswdqVXc91jovgfGRVcw2VzNcoaDrERI2hWUdTMvKJbDOW5
        /zav86W9m4kFOp9vvYdRgvOuT
X-Received: by 2002:a92:ad12:: with SMTP id w18mr7294002ilh.181.1631298289463;
        Fri, 10 Sep 2021 11:24:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4qORmamK53eLr4yxOnHqj7BwarQtOMuNX9FH47m/ncJ1Wd66yn6PV48kdy/Q2ioWxR2TXtw==
X-Received: by 2002:a92:ad12:: with SMTP id w18mr7293984ilh.181.1631298289174;
        Fri, 10 Sep 2021 11:24:49 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id f5sm3001956ils.3.2021.09.10.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:24:48 -0700 (PDT)
Date:   Fri, 10 Sep 2021 13:24:45 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dyndbg: make dyndbg a known cli param
Message-ID: <20210910182445.vao7uhqveaen25tk@halaneylaptop>
References: <20210909161755.61743-1-ahalaney@redhat.com>
 <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
 <CAJfuBxzX9nEvxC1s-4uRCzLwN0=3gbFT__9vO_coEM5CrpnJng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxzX9nEvxC1s-4uRCzLwN0=3gbFT__9vO_coEM5CrpnJng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 11:14:45AM -0600, jim.cromie@gmail.com wrote:
> On Thu, Sep 9, 2021 at 3:34 PM Jason Baron <jbaron@akamai.com> wrote:
> 
> >
> >
> > On 9/9/21 12:17 PM, Andrew Halaney wrote:
> > > Right now dyndbg shows up as an unknown parameter if used on boot:
> > >
> > >     Unknown command line parameters: dyndbg=module params +p ; module
> > sys +p
> > >
> > > That's because it is unknown, it doesn't sit in the __param
> > > section, so the processing done to warn users supplying an unknown
> > > parameter doesn't think it is legitimate.
> > >
> 
> 
> your usage is incorrect for what youre trying to do in that example
> what you need is:
> 
>   params.dyndbg=+p  sys.dyndbg=+p
> 
> dyndbg is properly unknown as a kernel param, it isnt one.
> ( it was called a "fake" module param when added.)
> $module.dyndbg is good, since its after the $module. (and the dot)
> it also then inherits the "scan bootargs for relevant ones on module load"
> behavior
> 
> 

That example is (slightly altered) from
Documentation/admin-guide/dynamic-debug-howto.rst,
I can change the example used to be a little less confusing (using the
module keyword is confusing, I could use something like
func or file instead of what the docs use as an example).

Is that what you're after, a better example usage of dyndbg= being
whined about in dmesg for the commit message, or am I misunderstanding?

I agree that dyndbg right now (both dyndbg= and $module.dyndbg=) are
"fake" params, but I'd like to remove that message for dyndbg= as it is
misleading. The code for module loading luckily already handles it all
properly and doesn't warn on proper usage:

    static int unknown_module_param_cb(char *param, char *val, const char *modname,
                       void *arg)
    {
        struct module *mod = arg;
        int ret;

        if (strcmp(param, "async_probe") == 0) {
            mod->async_probe_requested = true;
            return 0;
        }

        /* Check for magic 'dyndbg' arg */
        ret = ddebug_dyndbg_module_param_cb(param, val, modname);
        if (ret != 0)
            pr_warn("%s: unknown parameter '%s' ignored\n", modname, param);
        return 0;
    }


> 
> 
> 
> >
> > > Install a dummy handler to register it. This was chosen instead of the
> > > approach the (deprecated) ddebug_query param takes, which is to
> > > have a real handler that copies the string taking up a KiB memory.
> > >
> > > Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > ---
> > >
> > > This is the last valid param I know of that was getting flagged on boot
> > > if used correctly. Please let me know if the alternative approach of
> > > actually copying the string is preferred and I'll spin that up instead.
> > >
> >
> > Hi Andrew,
> >
> > So I think you are referring to the string copying that ddebug_query= does.
> > I don't think that works for 'dyndbg=' b/c its actually looking through
> > the entire command line for stuff like <module_name>.dyndbg="blah".
> >
> > So I think what you prposed below makes sense, we could perhaps add a note
> > as to why it's a noop. As I mentioned it needs to look through the entire
> > string.
> >
> >
> > > Sort of an aside, but what's the policy for removing deprecated cli
> > > params? ddebug_query has been deprecated for a very long time now, but I
> > > am not sure if removing params like that is considered almost as bad as
> > > breaking userspace considering some systems might update their kernels
> > > but not the bootloader supplying the param.
> >
> > I think it's probably ok to remove at this point, especially now that
> > we are going to flag it as unknown, right? So I feel like that change
> > can logically go with this series if you want as a separate patch.
> >
> > Thanks,
> >
> > -Jason
> >
> >
> > >
> > >  lib/dynamic_debug.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > > index cb5abb42c16a..84c16309cc63 100644
> > > --- a/lib/dynamic_debug.c
> > > +++ b/lib/dynamic_debug.c
> > > @@ -761,6 +761,18 @@ static __init int ddebug_setup_query(char *str)
> > >
> > >  __setup("ddebug_query=", ddebug_setup_query);
> > >
> > > +/*
> > > + * Install a noop handler to make dyndbg look like a normal kernel cli
> > param.
> > > + * This avoids warnings about dyndbg being an unknown cli param when
> > supplied
> > > + * by a user.
> > > + */
> > > +static __init int dyndbg_setup(char *str)
> > > +{
> > > +     return 1;
> > > +}
> > > +
> > > +__setup("dyndbg=", dyndbg_setup);
> > > +
> > >  /*
> > >   * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers
> > the
> > >   * command text from userspace, parses and executes it.
> > >
> >

