Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34E94074C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 05:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhIKDGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 23:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKDF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:05:59 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C875C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 20:04:47 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id f6so3350207vsr.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yWERo7tF3URDl9LTnTwuRGrWrBbQExxfKt3SGp43Aw=;
        b=Qw+CBOyrqy5kfPxH8IpxDt+XEdrWeXjdzLE6Px6/vECO2u+PEWemCRbZaUZ2ge3uSA
         crsCaS4NFis/zhSCDJWzC2MvEfIScwCcWEUNCzYn43WuF5YrF+2OBKBZkp0obkJh4BJB
         9jxr/NA8BMl4jqXqnAmkPROPpWTzuDN4Hv/PI2PCdcTLr6IfwkL7mECus0sbX09voNzO
         RXfKteXjLUX5aZnm0XPOhKGLtY+ypdkh8Be4GHoww9AIXtB1l3C2NPRQBSu21PkLpAhr
         DT1CDJEW+IFWnmJ7LVepO9HND9btpdrfYufKB5TJh3BRtwDVhi78CygW0+ONcP3oMc7n
         b1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yWERo7tF3URDl9LTnTwuRGrWrBbQExxfKt3SGp43Aw=;
        b=psUqpq5oHriOoX5g1HCvjdf8SAOXCIUFTaldGDBiPbXLw0tIrRtIoBfBtOAh+aZFEH
         vKMG1/tF+rjswYGqTuola1vxdBsHzLeGFwpSSfPGaY4n2qCsgyApcnsXOyT2MEXNPhww
         M36uzJWailZGX1y203Rty1PvOdkxjBUt9OIDqB0aGtK1PL3EWBQ6zSkLaNYc8pxy3qNj
         0ykxVy2lMY7Svu+GfEYJoui5nha9uuwrquD4bo0aNl3l5mGH3yiAv0fiEiyJXslt3Z+C
         6cTgbcgcCIi7AmhU2eaow4O4HMWRNtF63JVMxMKci74IjoHj3xGEpBZ+BrWgBNnI9Gif
         KMEQ==
X-Gm-Message-State: AOAM5339XtxoWiWE9pNa0Dfh3GAh5kUBvStQMDes1Eys0U9sH2+BLyYp
        BXm6WStTdAzpY+/va1O1CkfeEC6LRfD/gPud6DLdzBJ4xrI=
X-Google-Smtp-Source: ABdhPJxRo370PEM1hXL6mXedr46eqxWgc6tq+n/3f0leI6K8rQ9CuEXqtaxqSxgkJ6dfu3lXDSUXCGBpG8xF16afp5U=
X-Received: by 2002:a05:6102:482:: with SMTP id n2mr215371vsa.53.1631329486493;
 Fri, 10 Sep 2021 20:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210909161755.61743-1-ahalaney@redhat.com> <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
 <CAJfuBxzX9nEvxC1s-4uRCzLwN0=3gbFT__9vO_coEM5CrpnJng@mail.gmail.com>
 <20210910182445.vao7uhqveaen25tk@halaneylaptop> <CAJfuBxzWwXCmw+YsonMCOaHq=21C-rVPL8BhZpDU0NPQW0B_8w@mail.gmail.com>
 <20210910201635.4d3fhhrwvcusdwk2@halaneylaptop>
In-Reply-To: <20210910201635.4d3fhhrwvcusdwk2@halaneylaptop>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Sep 2021 21:04:20 -0600
Message-ID: <CAJfuBxy5LqFZViZ+Hn3Y4-=QXOJwReHhscDNey9v5ZJkHDRF2A@mail.gmail.com>
Subject: Re: [PATCH] dyndbg: make dyndbg a known cli param
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So converting dyndbg= to act like ddebug_query= won't work because
> $module.dyndbg="+p" should work if $module is builtin or a module
> (settles my open discussion with Jason).
>

they can both work, because the dot.

\w+.\w+ is separate, which is why it works for loadable modules.

and Ive just re-verified that these both ( bare/global and after $mod. ) work

dyndbg=+pmfl
turns on all builtins

[  128.341650] 8250:serial8250_interrupt:140: serial8250_interrupt(4): end
[  128.344996] 8250:serial8250_interrupt:140: serial8250_interrupt(4): end
^C
bash-5.1# echo -p > /proc/dynamic_debug/control
dyndbg: read 3 bytes from userspace <
-p
>
dyndbg: query 0: <-p> mod:<*>
dyndbg: split into words: <-p>
dyndbg: op=<->
dyndbg: flags=0x1
dyndbg: *flagsp=0x0 *maskp=0xfffffffe
dyndbg: parsed: func=<> file=<> module=<> format=<> lineno=0-0
dyndbg: applied: func=<> file=<> module=<> format=<> lineno=0-0
dyndbg: processed 1 queries, with 3055 matches, 0 errs
bash-5.1# cat /proc/cmdline
virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
virtme_initmount0=/root virtme_initmount1=/root/sbin
earlyprintk=serial,ttyS0,115200 console=ttyS0 psmouse.proto=exps
"virtme_stty_con=rows 27 cols 109 iutf8" TERM=xterm-256color
virtme_chdir=home/jimc/projects/lx rootfstype=9p
rootflags=version=9p2000.L,trans=virtio,access=any,msize=200M
raid=noautodetect ro nokaslr dynamic_debug.verbose=3
module.dyndbg=+pmf dyndbg=+pmfl init=/bin/sh -- -c "mount -t tmpfs run
/run;mkdir -p /run/virtme/guesttools;/bin/mount -n -t 9p -o
ro,version=9p2000.L,trans=virtio,access=any,msize=104857600
virtme.guesttools /run/virtme/guesttools;exec
/run/virtme/guesttools/virtme-init"
bash-5.1# ^C
bash-5.1# modprobe i915
dyndbg:  384 debug prints in module drm
dyndbg:  211 debug prints in module drm_kms_helper
dyndbg:    2 debug prints in module ttm
dyndbg:    8 debug prints in module video
dyndbg: 1821 debug prints in module i915

**********************************************************
**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**                                                      **
** trace_printk() being used. Allocating extra memory.  **
**                                                      **
** This means that this is a DEBUG kernel and it is     **
** unsafe for production use.                           **
**                                                      **
** If you see this message and you are not debugging    **
** the kernel, report this immediately to your vendor!  **
**                                                      **
**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**********************************************************
bash-5.1# wc /proc/dynamic_debug/control
5482 47545 613066 /proc/dynamic_debug/control
bash-5.1# grep =p /proc/dynamic_debug/control | wc
      3      21     244
bash-5.1# QEMU: Terminated



bash-5.1# wc /proc/dynamic_debug/control
3056 24089 307832 /proc/dynamic_debug/control
bash-5.1# grep =pfml /proc/dynamic_debug/control | wc
      0       0       0
bash-5.1# cat /proc/cmdline
virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
virtme_initmount0=/root virtme_initmount1=/root/sbin
earlyprintk=serial,ttyS0,115200 console=ttyS0 psmouse.proto=exps
"virtme_stty_con=rows 27 cols 109 iutf8" TERM=xterm-256color
virtme_chdir=home/jimc/projects/lx rootfstype=9p
rootflags=version=9p2000.L,trans=virtio,access=any,msize=200M
raid=noautodetect ro nokaslr dynamic_debug.verbose=3
module.dyndbg=+pmf *.dyndbg=+pmfl init=/bin/sh -- -c "mount -t tmpfs
run /run;mkdir -p /run/virtme/guesttools;/bin/mount -n -t 9p -o
ro,version=9p2000.L,trans=virtio,access=any,msize=104857600
virtme.guesttools /run/virtme/guesttools;exec
/run/virtme/guesttools/virtme-init"
bash-5.1# grep =p /proc/dynamic_debug/control | wc
   3039   23944  305800
bash-5.1# grep =pmfl /proc/dynamic_debug/control |wc
   3039   23944  305800
bash-5.1# echo -p > /proc/dynamic_debug/control
dyndbg: read 3 bytes from userspace <
-p
>
dyndbg: query 0: <-p> mod:<*>
dyndbg: split into words: <-p>
dyndbg: op=<->
dyndbg: flags=0x1
dyndbg: *flagsp=0x0 *maskp=0xfffffffe
dyndbg: parsed: func=<> file=<> module=<> format=<> lineno=0-0
dyndbg: applied: func=<> file=<> module=<> format=<> lineno=0-0
dyndbg: processed 1 queries, with 3055 matches, 0 errs
bash-5.1# grep =pmfl /proc/dynamic_debug/control |wc
      0       0       0



> I'm going to hold my ground and try and silence the warning, because I
> think the kernel parameters interface is well defined enough (kernel
> params go before the -- i.e. "these are kernel params -- these are for init"
>


Policy zone: DMA32
Kernel command line:
virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
virtme_initmount0=/root virtme_initmount1=/root/sbin
earlyprintk=serial,ttyS0,115200 console=ttyS0 psmouse.proto=exps
"virtme_stty_con=rows 27 cols 109 iutf8" TERM=xterm-256color
virtme_chdir=home/jimc/projects/lx rootfstype=9p
rootflags=version=9p2000.L,trans=virtio,access=any,msize=200M
raid=noautodetect ro nokaslr dynamic_debug.verbose=3
module.dyndbg=+pmf init=/bin/sh -- -c "mount -t tmpfs run /run;mkdir
-p /run/virtme/guesttools;/bin/mount -n -t 9p -o
ro,version=9p2000.L,trans=virtio,access=any,msize=104857600
virtme.guesttools /run/virtme/guesttools;exec
/run/virtme/guesttools/virtme-init"
Unknown command line parameters:
virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
virtme_initmount0=/root virtme_initmount1=/root/sbin
virtme_stty_con=rows 27 cols 109 iutf8
virtme_chdir=home/jimc/projects/lx
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)


in the above, I see unknown complaints about items after the --

But I agree the warning is misleading.




> With that in mind I'll make a v2 series out of this doing:
>   1. Clean up the doc to show intended usage on cli, something like
>      (params.dyndbg="+p" sys.dyndbg="+p" dyndbg="file init/main.c +p #cmt ; func pc87360_init_device +p")

how about 1 builtin, 1 loadable, and use a wildcard somewhere,
to hint that theres more than 2 ways to make a "group"

>   2. Remove ddebug_query per Jason's approval

sorry for not keeping up - is the problem the static storage ?
is there a way to fix that for all setup= stuff ?
if you could make ddebug_query into an alias for dyndbg it might fix
the narrow case.


>   3. Silence the param with this patch here, with a commit message
>      updated explaining why dyndbg= needs to be able to process the whole
>      cli, per Jason
>
> Please lemme know if there are any strong objections in the meantime and
> thanks for the feedback!
>
> >
> > > I agree that dyndbg right now (both dyndbg= and $module.dyndbg=) are
> > > "fake" params, but I'd like to remove that message for dyndbg= as it is
> > > misleading. The code for module loading luckily already handles it all
> > > properly and doesn't warn on proper usage:

s/luckily/serendipitously/ - the way fake just worked was an aha for me.

just dont kill the fake-ness while quieting the warning

thanks
JIm
