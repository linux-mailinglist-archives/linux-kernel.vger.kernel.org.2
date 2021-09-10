Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63CC406D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhIJOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231963AbhIJOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631282432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bL/byGSpb3O+/6TI3MhORPkecYe2Wew1ixIcleGl5VM=;
        b=dqcT80t4nW2/PyLfUKC8OhtZzgFaqXDSDtkuAKgE9kIhsPfZudl6ydBH2mVFMnaNIkQB3m
        LvOBNHrub/ahuJF/BEytMlIhel4rzwpuWgyKnKyPqS+I3ZiCexmWxEp39TWWn3lh1dohR9
        YsSB0JKiFaSak5x0HJmp5XdklqYyEwE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-d7wMMqIyNPiNe9Bm--5YLQ-1; Fri, 10 Sep 2021 10:00:31 -0400
X-MC-Unique: d7wMMqIyNPiNe9Bm--5YLQ-1
Received: by mail-il1-f200.google.com with SMTP id h10-20020a056e020d4a00b00227fc2e6687so3133893ilj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bL/byGSpb3O+/6TI3MhORPkecYe2Wew1ixIcleGl5VM=;
        b=vVI2zjcoolgeBMv6x5zrDnHJnvKgg1GWJYcV3WK19gm++UXt+dA1MT7mpazxMnSETi
         eUbpRuTpaT9lmvIBUfIuS2hF5O3YMkMat3fco0YqfksMv0uRtyCFN3kwjnidLy2EWa2f
         q70aPsPp3Zo+ZbeUNSbJhSpXR5XvUDDGEkcs+vlp+PxUwqcfYJFjLIsIdti4rhp6QaHZ
         n/kIQD/lgAvpN89ZoSVCGRwrAgGgsItSrsAJMA8DLM4kJLIzKt5o+80fubt4nWH9UF08
         a5uuZDGCG126RpAkXp7hnWhzQibBYGboI73a2lWUPg8q+xs54JniJ/0bmaUXfiIojykA
         j5cw==
X-Gm-Message-State: AOAM530hKKjxLFssCFzhUF/7dJjBxtVMl+NaaKuf5BKJpwYC/peAGHlR
        jGpuTI8PgPhHDo2Ts69N3QwqzxFyuD+gemP6S9HOKsFVB9W5QcsJvMkIj0JXtko80oFcuED5Upm
        vS46DBNF3H1IeQt0fMdtAPyWh
X-Received: by 2002:a5e:9249:: with SMTP id z9mr7403653iop.14.1631282430086;
        Fri, 10 Sep 2021 07:00:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI8qNHc8fkfaZGxesLWLEVd8g/AyePjNbNf1D2B5rTs8PALPBnk6jL8eZ4VnnWLbwkfffm7Q==
X-Received: by 2002:a5e:9249:: with SMTP id z9mr7403636iop.14.1631282429853;
        Fri, 10 Sep 2021 07:00:29 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id p11sm2594768ilm.61.2021.09.10.07.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:00:29 -0700 (PDT)
Date:   Fri, 10 Sep 2021 09:00:26 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH] dyndbg: make dyndbg a known cli param
Message-ID: <20210910140026.tufn25xf5j4tzbtx@halaneylaptop>
References: <20210909161755.61743-1-ahalaney@redhat.com>
 <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 05:34:51PM -0400, Jason Baron wrote:
> 
> 
> On 9/9/21 12:17 PM, Andrew Halaney wrote:
> > Right now dyndbg shows up as an unknown parameter if used on boot:
> > 
> >     Unknown command line parameters: dyndbg=module params +p ; module sys +p
> > 
> > That's because it is unknown, it doesn't sit in the __param
> > section, so the processing done to warn users supplying an unknown
> > parameter doesn't think it is legitimate.
> > 
> > Install a dummy handler to register it. This was chosen instead of the
> > approach the (deprecated) ddebug_query param takes, which is to
> > have a real handler that copies the string taking up a KiB memory.
> > 
> > Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > 
> > This is the last valid param I know of that was getting flagged on boot
> > if used correctly. Please let me know if the alternative approach of
> > actually copying the string is preferred and I'll spin that up instead.
> > 
> 
> Hi Andrew,
> 
> So I think you are referring to the string copying that ddebug_query= does.
> I don't think that works for 'dyndbg=' b/c its actually looking through
> the entire command line for stuff like <module_name>.dyndbg="blah".
> 
> So I think what you prposed below makes sense, we could perhaps add a note
> as to why it's a noop. As I mentioned it needs to look through the entire
> string.
> 

I think that the ddebug_query= style works fine for dyndbg=, and that
things like <module_name>.dyndbg= go through a different path to
actually have the work done.

When dyndbg= is processed through dynamic_debug_init() all of the
<module_name>.dyndbg= style queries don't do anything ultimately.

When the module is actually loaded unknown_module_param_cb() checks for
the module's dyndbg query and calls ddebug_dyndbg_module_param_cb()
directly. It is at this point that I believe the query is really
applied.

For example, this is what I see in dmesg:

    [    0.045553] Kernel command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.14.0+ root=UUID=9a0e5b84-1190-465f-a587-f2f2a00a8e91 ro rhgb quiet "dyndbg=module params +p ; module sys +p" dynamic_debug.verbose=2 kvm.dyndbg=+pflmt

    # Initial dynamic_debug processing..
    [    0.114308] dyndbg:   6 debug prints in module main
    [    0.114308] dyndbg:   1 debug prints in module initramfs
    <snip (no kvm debug prints... since it is a module and not loaded)>

    # Processing normal dyndbg= for builtins, param has matches but sys
    # does not
    [    0.114308] dyndbg: dyndbg="module params +p ; module sys +p"
    [    0.114308] dyndbg: query 0: "module params +p "
    <snip>
    [    0.114308] dyndbg: applied: func="" file="" module="params" format="" lineno=0-0
    [    0.114308] dyndbg: query 1: "module sys +p"
    [    0.114308] dyndbg: no-match: func="" file="" module="sys" format="" lineno=0-0
    [    0.114308] dyndbg: processed 2 queries, with 4 matches, 0 errs

    # Trying to process kvm.dyndbg=, but no effect as module isn't loaded
    [    0.114308] doing dyndbg params: kvm.dyndbg='+pflmt'
    [    0.114308] dyndbg: kvm.dyndbg="+pflmt"
    <snip>
    [    0.114308] dyndbg: processed 1 queries, with 0 matches, 0 errs

    # kvm module is loaded, kernel/module.c calls ddebug_dyndbg_module_param_cb()
    # this time it does something
    [    3.651764] doing kvm, parsing ARGS: 'dyndbg=+pflmt '
    [    3.651767] doing kvm: dyndbg='+pflmt'
    [    3.651768] dyndbg: module: kvm dyndbg="+pflmt"
    [    3.651769] dyndbg: query 0: "+pflmt"
    <snip>
    [    3.652414] dyndbg: applied: func="" file="" module="kvm" format="" lineno=0-0
    [    3.652416] dyndbg: processed 1 queries, with 10 matches, 0 errs

With that being said, I think ddebug_query= style of copying the
dyndbg="string" is all that is really needed for processing builtins,
and the module loading method that's already in place shouldn't be
affected. Does that change you opinion of the approach (or am I totally
misunderstanding)? Processing the whole cli seems unnecessary, but I'm
also a (unjustified?) stickler for adding additional memory usage in the
patch.

> 
> > Sort of an aside, but what's the policy for removing deprecated cli
> > params? ddebug_query has been deprecated for a very long time now, but I
> > am not sure if removing params like that is considered almost as bad as
> > breaking userspace considering some systems might update their kernels
> > but not the bootloader supplying the param.
> 
> I think it's probably ok to remove at this point, especially now that
> we are going to flag it as unknown, right? So I feel like that change
> can logically go with this series if you want as a separate patch.

ddebug_query actually _is_ known (it registers with __setup() so there's
no warning like the one I listed in the commit description (although the
deprecated message in lib/dynamic_debug.c is present if you actually use
it). So I sort of feel like the removal would be separate to this
patchset. Let me know when your thoughts when you answer the prior
question and I'll react with a v2 accordingly!

> 
> Thanks,
> 
> -Jason
> 
> 
> > 
> >  lib/dynamic_debug.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index cb5abb42c16a..84c16309cc63 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -761,6 +761,18 @@ static __init int ddebug_setup_query(char *str)
> >  
> >  __setup("ddebug_query=", ddebug_setup_query);
> >  
> > +/*
> > + * Install a noop handler to make dyndbg look like a normal kernel cli param.
> > + * This avoids warnings about dyndbg being an unknown cli param when supplied
> > + * by a user.
> > + */
> > +static __init int dyndbg_setup(char *str)
> > +{
> > +	return 1;
> > +}
> > +
> > +__setup("dyndbg=", dyndbg_setup);
> > +
> >  /*
> >   * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers the
> >   * command text from userspace, parses and executes it.
> > 
> 

