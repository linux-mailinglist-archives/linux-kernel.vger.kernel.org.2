Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B158407207
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhIJTdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJTdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:33:02 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:31:50 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id k124so1030077vke.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RWMKyeRq3zB+VVkCByOR8MWd1gjzuVpvdfMSHO5pgQ=;
        b=cRko4OJ2+tUVMePUngyAH6pxJ8jqBmo/FpQqNj80nRV+klUSZzuzGEmBQIbZc0PdEz
         sOVM8TVKA1GR4GQfPOjbFzC99R2usw5T3Kw1YUf77GtZURtltSZIKZOhp2OSwmvquTNS
         jL4d0tu+4MKT08mm0VKLdk3bZMQxLe9PSnqR50f05DTIOs6qImQPY6KutE1ZFttQFX7V
         hUuB5ghGDmmzkn9uik5WFKA0ZspDhpGL3ar2kYuaJ4rHU8VRfYl8FyX2J8p/UzN9RYgM
         gkM7WE9EnVhbtbCwI7wBqdz+FU+LT2vFzarkUFAGZ8EwJE0fycvd7p6bAisFgueV4/9z
         SOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RWMKyeRq3zB+VVkCByOR8MWd1gjzuVpvdfMSHO5pgQ=;
        b=KVvrUEMxNCX+HxEmLB7qxxd2QiteaMbesYKDU/h/Lu2VxU4qUFrwUTGBpoQGfrCvvX
         Qf3dFowiXFrMLpCcxBYoWEiliFN6aTFw8p2xlUVDcFfOdLtZR/0uvhno7e3Lk6Z22vvK
         fwP0Ce+R2T7Dy/J8odBJFtLBHzAWXDCSzEc1fbt8yz4/cqqFRiIcNaNYjOkscTBHgCDo
         S9GnWKczJpSttwRP1ukVvANB/jWJc+cJrbOnmh+11BLNdjcc7fNP2XbvT20PyTOaUhsU
         8qYy2iF91jcDpirYkNuXvMWppWSYrectkTb4cwHylN3TCf3OzNlXoox4p00JAXVBs5Ga
         UDRw==
X-Gm-Message-State: AOAM533FosFEO2suBMXRSJuvvf38LIuW5E9PCvUC0nJCjJnJwWZm1dlB
        FJyVlzXgoGQRlXIS+A9FgI/jbTn9XjV5cCalkvU=
X-Google-Smtp-Source: ABdhPJwOzaiSriwfPRjre/GCZxp7LdRt7tQXeGkySZWnt2N68EM/Su4w7gfXpeP2ha8Xxi5mfnFjRM6df+VsCkstmSU=
X-Received: by 2002:a1f:6407:: with SMTP id y7mr6893423vkb.15.1631302308373;
 Fri, 10 Sep 2021 12:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210909161755.61743-1-ahalaney@redhat.com> <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
 <CAJfuBxzX9nEvxC1s-4uRCzLwN0=3gbFT__9vO_coEM5CrpnJng@mail.gmail.com> <20210910182445.vao7uhqveaen25tk@halaneylaptop>
In-Reply-To: <20210910182445.vao7uhqveaen25tk@halaneylaptop>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Sep 2021 13:31:22 -0600
Message-ID: <CAJfuBxzWwXCmw+YsonMCOaHq=21C-rVPL8BhZpDU0NPQW0B_8w@mail.gmail.com>
Subject: Re: [PATCH] dyndbg: make dyndbg a known cli param
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 12:24 PM Andrew Halaney <ahalaney@redhat.com> wrote:
>
> On Fri, Sep 10, 2021 at 11:14:45AM -0600, jim.cromie@gmail.com wrote:
> > On Thu, Sep 9, 2021 at 3:34 PM Jason Baron <jbaron@akamai.com> wrote:
> >
> > >
> > >
> > > On 9/9/21 12:17 PM, Andrew Halaney wrote:
> > > > Right now dyndbg shows up as an unknown parameter if used on boot:
> > > >
> > > >     Unknown command line parameters: dyndbg=module params +p ; module
> > > sys +p
> > > >
> > > > That's because it is unknown, it doesn't sit in the __param
> > > > section, so the processing done to warn users supplying an unknown
> > > > parameter doesn't think it is legitimate.
> > > >
> >
> >
> > your usage is incorrect for what youre trying to do in that example
> > what you need is:
> >
> >   params.dyndbg=+p  sys.dyndbg=+p
> >
> > dyndbg is properly unknown as a kernel param, it isnt one.
> > ( it was called a "fake" module param when added.)
> > $module.dyndbg is good, since its after the $module. (and the dot)
> > it also then inherits the "scan bootargs for relevant ones on module load"
> > behavior
> >
> >
>
> That example is (slightly altered) from
> Documentation/admin-guide/dynamic-debug-howto.rst,

oh dear, I see the lines youre referring to.
I am surprised.
fyi, those lines are:
    // enable pr_debugs in 2 builtins, #cmt is stripped
    dyndbg="module params +p #cmt ; module sys +p"

is your patchset removing those lines ?
if so, ack that part.

> I can change the example used to be a little less confusing (using the
> module keyword is confusing, I could use something like
> func or file instead of what the docs use as an example).

yes please, I saw bad usage, thought faulty premise.

> Is that what you're after, a better example usage of dyndbg= being
> whined about in dmesg for the commit message, or am I misunderstanding?

I guess Im inured to it.  Heres my regular version with a similar addition.

Unknown command line parameters:
virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
virtme_initmount0=/root virtme_initmount1=/root/sbin
virtme_stty_con=rows 27 cols 109 iutf8
virtme_chdir=home/jimc/projects/lx dyndbg=+p

most of them do something, just not for the kernel.

I dont think this is worth explicitly silencing.
rather rip out the misleading doc.


> I agree that dyndbg right now (both dyndbg= and $module.dyndbg=) are
> "fake" params, but I'd like to remove that message for dyndbg= as it is
> misleading. The code for module loading luckily already handles it all
> properly and doesn't warn on proper usage:
>
>     static int unknown_module_param_cb(char *param, char *val, const char *modname,
>                        void *arg)
>     {
>         struct module *mod = arg;
>         int ret;
>
>         if (strcmp(param, "async_probe") == 0) {
>             mod->async_probe_requested = true;
>             return 0;
>         }
>
>         /* Check for magic 'dyndbg' arg */
>         ret = ddebug_dyndbg_module_param_cb(param, val, modname);
>         if (ret != 0)
>             pr_warn("%s: unknown parameter '%s' ignored\n", modname, param);
>         return 0;
>     }
>
>
> >
> >
> >
> > >
> > > > Install a dummy handler to register it. This was chosen instead of the
> > > > approach the (deprecated) ddebug_query param takes, which is to
> > > > have a real handler that copies the string taking up a KiB memory.
> > > >
> > > > Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> > > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > > ---
> > > >
> > > > This is the last valid param I know of that was getting flagged on boot
> > > > if used correctly. Please let me know if the alternative approach of
> > > > actually copying the string is preferred and I'll spin that up instead.
> > > >
> > >
> > > Hi Andrew,
> > >
> > > So I think you are referring to the string copying that ddebug_query= does.
> > > I don't think that works for 'dyndbg=' b/c its actually looking through
> > > the entire command line for stuff like <module_name>.dyndbg="blah".
> > >
> > > So I think what you prposed below makes sense, we could perhaps add a note
> > > as to why it's a noop. As I mentioned it needs to look through the entire
> > > string.
> > >
> > >
> > > > Sort of an aside, but what's the policy for removing deprecated cli
> > > > params? ddebug_query has been deprecated for a very long time now, but I
> > > > am not sure if removing params like that is considered almost as bad as
> > > > breaking userspace considering some systems might update their kernels
> > > > but not the bootloader supplying the param.
> > >
> > > I think it's probably ok to remove at this point, especially now that
> > > we are going to flag it as unknown, right? So I feel like that change
> > > can logically go with this series if you want as a separate patch.
> > >
> > > Thanks,
> > >
> > > -Jason
> > >
> > >
> > > >
> > > >  lib/dynamic_debug.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > > > index cb5abb42c16a..84c16309cc63 100644
> > > > --- a/lib/dynamic_debug.c
> > > > +++ b/lib/dynamic_debug.c
> > > > @@ -761,6 +761,18 @@ static __init int ddebug_setup_query(char *str)
> > > >
> > > >  __setup("ddebug_query=", ddebug_setup_query);
> > > >
> > > > +/*
> > > > + * Install a noop handler to make dyndbg look like a normal kernel cli
> > > param.
> > > > + * This avoids warnings about dyndbg being an unknown cli param when
> > > supplied
> > > > + * by a user.
> > > > + */
> > > > +static __init int dyndbg_setup(char *str)
> > > > +{
> > > > +     return 1;
> > > > +}
> > > > +
> > > > +__setup("dyndbg=", dyndbg_setup);
> > > > +
> > > >  /*
> > > >   * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers
> > > the
> > > >   * command text from userspace, parses and executes it.
> > > >
> > >
>
