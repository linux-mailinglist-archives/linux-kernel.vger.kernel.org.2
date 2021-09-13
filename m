Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF9409DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbhIMUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236133AbhIMUL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631563809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZPU1b1kYKuZGMn4d8bx7sgkMCUetNBpjpgoduGLg3l8=;
        b=MAizkl8D0xVmrCHy48OqdKIwVnyGI9SynAkjkhA8Xf3hPhbnYcyAKWTsF4329hzkDkhDRk
        RyjSUYt01dIB4MwUoKgec+8po0f/NOTAOF4uH706LRwrgw73qM76rwoWUMIhjyDbV0AwcJ
        XTqhVH3OomSVxsnWBVPBcKNLmXTg6uU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-g6KSw8wsPg6VCzt8rcNb3A-1; Mon, 13 Sep 2021 16:10:08 -0400
X-MC-Unique: g6KSw8wsPg6VCzt8rcNb3A-1
Received: by mail-il1-f197.google.com with SMTP id x7-20020a920607000000b002302afca41bso10190625ilg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZPU1b1kYKuZGMn4d8bx7sgkMCUetNBpjpgoduGLg3l8=;
        b=8AGJ0URQLzdyUkWFy0m/UgALuI0souW329Gx+Gnjf0skI3HSIIiSwMFT6FqIbEvJEL
         scYwwyBPlNM/bbOcwEE12xboTLWFL9BnBJzSK/xO+DXVOUnWcy1UT/JzDBLrLZ5x2n4M
         +XEzvlU91q+HO3hy243cnyDjdh0e0AaraZrxoEdCfUb/xYCtblvKq0yhOGrIcQpuvUBF
         amUG/BwV7Y7oZU7zjrzaP1Wku9cwxjddpZLO51/mUmH385kjK2JlctSytRkb/ZXKHZL0
         YAjLn/L5UUJ0EqHk2ZtoLykR5UlnUuV9ZkKEwytvo+GEzpNgK/xg4JBZR7oNN4eXSXW3
         M5gQ==
X-Gm-Message-State: AOAM530aJHj2/SmflVUpmj9ODQgj45uwnzv4TsCgvl/DHo/9t9vwqEE8
        oL5OPKTRjGf+GwXNIRkx8zD3P3CHtugq4zDvVfCfabMabS8FROVM3SX3qRI0cs/rpL/scrh1Ttj
        LTvmqj0I6knr2JBY3VTbaB+fe
X-Received: by 2002:a02:ab87:: with SMTP id t7mr11307278jan.127.1631563807359;
        Mon, 13 Sep 2021 13:10:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLAtOWDxo/h4WCwfHU8igp4V7sQKjxBvz9HvppLWw8ApR3CbjEH5OxgrgxlGD9uLJubcRIKA==
X-Received: by 2002:a02:ab87:: with SMTP id t7mr11307261jan.127.1631563807013;
        Mon, 13 Sep 2021 13:10:07 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id r16sm5428653ile.66.2021.09.13.13.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:10:06 -0700 (PDT)
Date:   Mon, 13 Sep 2021 15:10:03 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dyndbg: make dyndbg a known cli param
Message-ID: <20210913201003.onurkgvhvh4tre6l@halaneylaptop>
References: <20210909161755.61743-1-ahalaney@redhat.com>
 <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
 <CAJfuBxzX9nEvxC1s-4uRCzLwN0=3gbFT__9vO_coEM5CrpnJng@mail.gmail.com>
 <20210910182445.vao7uhqveaen25tk@halaneylaptop>
 <CAJfuBxzWwXCmw+YsonMCOaHq=21C-rVPL8BhZpDU0NPQW0B_8w@mail.gmail.com>
 <20210910201635.4d3fhhrwvcusdwk2@halaneylaptop>
 <CAJfuBxy5LqFZViZ+Hn3Y4-=QXOJwReHhscDNey9v5ZJkHDRF2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxy5LqFZViZ+Hn3Y4-=QXOJwReHhscDNey9v5ZJkHDRF2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 09:04:20PM -0600, jim.cromie@gmail.com wrote:
> >
> > So converting dyndbg= to act like ddebug_query= won't work because
> > $module.dyndbg="+p" should work if $module is builtin or a module
> > (settles my open discussion with Jason).
> >
> 
> they can both work, because the dot.
> 
> \w+.\w+ is separate, which is why it works for loadable modules.
> 
> and Ive just re-verified that these both ( bare/global and after $mod. ) work
> 
> dyndbg=+pmfl
> turns on all builtins

Yeah, you are totally right, my head clearly was not working well Friday
afternoon. Although I think converting dyndbg= to behave more like
ddebug_query wrt copying the string is pointless, since you've
shown quite well here that we need to process the whole command line
when we start up dynamic debug to catch any $module.dyndbg= usage that is
actually builtin currently. So you've settled that for me, I think the
noop approach here is best, but will update commit message to reflect
reality.

> 
> [  128.341650] 8250:serial8250_interrupt:140: serial8250_interrupt(4): end
> [  128.344996] 8250:serial8250_interrupt:140: serial8250_interrupt(4): end
> ^C
> bash-5.1# echo -p > /proc/dynamic_debug/control
> dyndbg: read 3 bytes from userspace <
> -p
> >
> dyndbg: query 0: <-p> mod:<*>
> dyndbg: split into words: <-p>
> dyndbg: op=<->
> dyndbg: flags=0x1
> dyndbg: *flagsp=0x0 *maskp=0xfffffffe
> dyndbg: parsed: func=<> file=<> module=<> format=<> lineno=0-0
> dyndbg: applied: func=<> file=<> module=<> format=<> lineno=0-0
> dyndbg: processed 1 queries, with 3055 matches, 0 errs
> bash-5.1# cat /proc/cmdline
> virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
> virtme_initmount0=/root virtme_initmount1=/root/sbin
> earlyprintk=serial,ttyS0,115200 console=ttyS0 psmouse.proto=exps
> "virtme_stty_con=rows 27 cols 109 iutf8" TERM=xterm-256color
> virtme_chdir=home/jimc/projects/lx rootfstype=9p
> rootflags=version=9p2000.L,trans=virtio,access=any,msize=200M
> raid=noautodetect ro nokaslr dynamic_debug.verbose=3
> module.dyndbg=+pmf dyndbg=+pmfl init=/bin/sh -- -c "mount -t tmpfs run
> /run;mkdir -p /run/virtme/guesttools;/bin/mount -n -t 9p -o
> ro,version=9p2000.L,trans=virtio,access=any,msize=104857600
> virtme.guesttools /run/virtme/guesttools;exec
> /run/virtme/guesttools/virtme-init"
> bash-5.1# ^C
> bash-5.1# modprobe i915
> dyndbg:  384 debug prints in module drm
> dyndbg:  211 debug prints in module drm_kms_helper
> dyndbg:    2 debug prints in module ttm
> dyndbg:    8 debug prints in module video
> dyndbg: 1821 debug prints in module i915
> 
> **********************************************************
> **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> **                                                      **
> ** trace_printk() being used. Allocating extra memory.  **
> **                                                      **
> ** This means that this is a DEBUG kernel and it is     **
> ** unsafe for production use.                           **
> **                                                      **
> ** If you see this message and you are not debugging    **
> ** the kernel, report this immediately to your vendor!  **
> **                                                      **
> **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> **********************************************************
> bash-5.1# wc /proc/dynamic_debug/control
> 5482 47545 613066 /proc/dynamic_debug/control
> bash-5.1# grep =p /proc/dynamic_debug/control | wc
>       3      21     244
> bash-5.1# QEMU: Terminated
> 
> 
> 
> bash-5.1# wc /proc/dynamic_debug/control
> 3056 24089 307832 /proc/dynamic_debug/control
> bash-5.1# grep =pfml /proc/dynamic_debug/control | wc
>       0       0       0
> bash-5.1# cat /proc/cmdline
> virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
> virtme_initmount0=/root virtme_initmount1=/root/sbin
> earlyprintk=serial,ttyS0,115200 console=ttyS0 psmouse.proto=exps
> "virtme_stty_con=rows 27 cols 109 iutf8" TERM=xterm-256color
> virtme_chdir=home/jimc/projects/lx rootfstype=9p
> rootflags=version=9p2000.L,trans=virtio,access=any,msize=200M
> raid=noautodetect ro nokaslr dynamic_debug.verbose=3
> module.dyndbg=+pmf *.dyndbg=+pmfl init=/bin/sh -- -c "mount -t tmpfs
> run /run;mkdir -p /run/virtme/guesttools;/bin/mount -n -t 9p -o
> ro,version=9p2000.L,trans=virtio,access=any,msize=104857600
> virtme.guesttools /run/virtme/guesttools;exec
> /run/virtme/guesttools/virtme-init"
> bash-5.1# grep =p /proc/dynamic_debug/control | wc
>    3039   23944  305800
> bash-5.1# grep =pmfl /proc/dynamic_debug/control |wc
>    3039   23944  305800
> bash-5.1# echo -p > /proc/dynamic_debug/control
> dyndbg: read 3 bytes from userspace <
> -p
> >
> dyndbg: query 0: <-p> mod:<*>
> dyndbg: split into words: <-p>
> dyndbg: op=<->
> dyndbg: flags=0x1
> dyndbg: *flagsp=0x0 *maskp=0xfffffffe
> dyndbg: parsed: func=<> file=<> module=<> format=<> lineno=0-0
> dyndbg: applied: func=<> file=<> module=<> format=<> lineno=0-0
> dyndbg: processed 1 queries, with 3055 matches, 0 errs
> bash-5.1# grep =pmfl /proc/dynamic_debug/control |wc
>       0       0       0
> 
> 
> 
> > I'm going to hold my ground and try and silence the warning, because I
> > think the kernel parameters interface is well defined enough (kernel
> > params go before the -- i.e. "these are kernel params -- these are for init"
> >
> 
> 
> Policy zone: DMA32
> Kernel command line:
> virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
> virtme_initmount0=/root virtme_initmount1=/root/sbin
> earlyprintk=serial,ttyS0,115200 console=ttyS0 psmouse.proto=exps
> "virtme_stty_con=rows 27 cols 109 iutf8" TERM=xterm-256color
> virtme_chdir=home/jimc/projects/lx rootfstype=9p
> rootflags=version=9p2000.L,trans=virtio,access=any,msize=200M
> raid=noautodetect ro nokaslr dynamic_debug.verbose=3
> module.dyndbg=+pmf init=/bin/sh -- -c "mount -t tmpfs run /run;mkdir
> -p /run/virtme/guesttools;/bin/mount -n -t 9p -o
> ro,version=9p2000.L,trans=virtio,access=any,msize=104857600
> virtme.guesttools /run/virtme/guesttools;exec
> /run/virtme/guesttools/virtme-init"
> Unknown command line parameters:
> virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
> virtme_initmount0=/root virtme_initmount1=/root/sbin
> virtme_stty_con=rows 27 cols 109 iutf8
> virtme_chdir=home/jimc/projects/lx
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> 
> 
> in the above, I see unknown complaints about items after the --

I'm the doofus who added the warning message output, so I definitely
don't want to ignore you claiming there are complaints after the --
because there shouldn't be... but I've re-read that block 3 times now and
don't see anything after the -- that's in the unknown list. Can you
please highlight it for me? I'd like to figure out why it is showing up
if that's happening.

> 
> But I agree the warning is misleading.
> 
> 
> 
> 
> > With that in mind I'll make a v2 series out of this doing:
> >   1. Clean up the doc to show intended usage on cli, something like
> >      (params.dyndbg="+p" sys.dyndbg="+p" dyndbg="file init/main.c +p #cmt ; func pc87360_init_device +p")
> 
> how about 1 builtin, 1 loadable, and use a wildcard somewhere,
> to hint that theres more than 2 ways to make a "group"
> 

Sure, I'll illustrate using:
    builtin (with explicit comment about how this works for when params
        module is builtin or loadable): params.dyndbg="+p"
    module: kvm.dyndbg="+p"
    wildcard/dyndbg: dyndbg="file init/* +p #cmt ; func pc87360_init_device +p"

Please let me know of any objections (or wait till v2) on that list..
not sure I hit the nail on the head so throwing that up for "pre-review"
I suppose.

> >   2. Remove ddebug_query per Jason's approval
> 
> sorry for not keeping up - is the problem the static storage ?
> is there a way to fix that for all setup= stuff ?
> if you could make ddebug_query into an alias for dyndbg it might fix
> the narrow case.
> 

No real problem, I just looked at this code for the first time to tackle
the dyndbg= warning and looked into ddebug_query a bit. After looking I
realized it has been deprecated for quite a while and thought it would
be good to remove it if there's no objections just to clean up house.

It does eat some static storage for the string. I'm not sure if there's
a great way to solve such a problem systematically, but yes ddebug_query
could be made into an alias for dyndbg and function fine still for this
case. If there's some objection to removing it entirely I'll do that just
to save a little more space.

> 
> >   3. Silence the param with this patch here, with a commit message
> >      updated explaining why dyndbg= needs to be able to process the whole
> >      cli, per Jason
> >
> > Please lemme know if there are any strong objections in the meantime and
> > thanks for the feedback!
> >
> > >
> > > > I agree that dyndbg right now (both dyndbg= and $module.dyndbg=) are
> > > > "fake" params, but I'd like to remove that message for dyndbg= as it is
> > > > misleading. The code for module loading luckily already handles it all
> > > > properly and doesn't warn on proper usage:
> 
> s/luckily/serendipitously/ - the way fake just worked was an aha for me.
> 
> just dont kill the fake-ness while quieting the warning
> 
> thanks
> JIm
> 

