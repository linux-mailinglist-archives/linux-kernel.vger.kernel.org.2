Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B030E31AC45
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 15:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBMOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 09:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBMOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 09:30:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4863CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 06:29:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id df22so3247234edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 06:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rTxtMdVJlP9rsr73q6o4Ig86cmaWLwUYLEI8zvZ8vqo=;
        b=AG82L/a1iC2O1thCjf1hd/Tjl+qX7Xz4vWwDGo+UpxtcHK3kEdpcYMm1muQS5/RmLt
         fkhgMx1YzsQfXZRHnP9xVqMlFUWA9MiDAmrw9omQ/tarr+i2bcHAzbl3YAJv8NWKUnuL
         T0PkK8+nxXw/3vDiizOfrxzxZYqjFrQhghB2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTxtMdVJlP9rsr73q6o4Ig86cmaWLwUYLEI8zvZ8vqo=;
        b=KrPv8bEUCpvJE7zpuwnDJWiuG3/u9N4ET1dKUY/3P8pc7SR5J3ZFmy/3kEoQLUGxZJ
         m2gRSudmDh0rsQx6VnSFGXEvIOI1d2xLuhJMv7YDjpIsS0NkL4uHKo2KyY/2EMNMftW0
         dCBFV8kK47Aae9iukRdkBYdRvEIyX5sqEkrhzZRsMbBdOfUamqEdCrJGm+9fp7OQocsS
         J5fyE7MPrgONv6FmaT2rSem4E3Sqlr6LkXTB5oUGkBgrapdc1C9WIkH77Vq2C+o4JKEO
         jZZ4X/VWw4TcbSRKOXKU6aDtWZ7qCsMVBAXiH9C8C3rj3JV801npunYkA4apVHFeHrhf
         jkwA==
X-Gm-Message-State: AOAM53266qTsZeGlOoXlPlMC/57fEYbt2WbrIhru10wseSaNQmLBgvTR
        wK9kxl+FqYFyCwvWu9GVBvFljw==
X-Google-Smtp-Source: ABdhPJzDiqgczcrO1AvXQYyABmmxlw1Ft3CDx6mn/G4u7MnoNWg8fxKriIPFONCPTUTR4blVaQUC7A==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr7860985edd.49.1613226592950;
        Sat, 13 Feb 2021 06:29:52 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id qx8sm7650289ejb.48.2021.02.13.06.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 06:29:52 -0800 (PST)
Date:   Sat, 13 Feb 2021 14:29:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4] printk: Userspace format enumeration support
Message-ID: <YCfiYKvuW4DxgICH@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <202102130158.8qvFdZvE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202102130158.8qvFdZvE-lkp@intel.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot writes:
>Hi Chris,
>
>Thank you for the patch! Yet something to improve:

I'm pretty sure !CONFIG_PRINTK && CONFIG_IA64_DEBUG_CMPXCHG has been broken 
like this long before this change.

With !CONFIG_PRINTK, printk() is static in the header, but ia64's cmpxchg.h 
with CONFIG_IA64_DEBUG_CMPXCHG doesn't take this into account before trying to 
use it as extern.

CONFIG_IA64_DEBUG_CMPXCHG should be dependent on CONFIG_PRINTK. I'll send a 
separate patch for that, no reason to put it in this series. Not sure why LKP 
only caught it now though.

Here's how it is even on the parent commit LKP applied this patch to:

     % git checkout bff4c8b4b0b9bcc31917d3b0f1a01a7573a1f473^
     Previous HEAD position was bff4c8b4b0b9 printk: Userspace format enumeration support
     HEAD is now at 1fa67f8391ac module: mark TRIM_UNUSED_KSYMS as BROKEN on powerpc
     % COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 /tmp/make.cross ARCH=ia64 -s
     Compiler will be installed in /home/cdown/0day
     make W=1 CROSS_COMPILE=/home/cdown/0day/gcc-9.3.0-nolibc/ia64-linux/bin/ia64-linux- --jobs=32 ARCH=ia64 -s
     In file included from ./include/linux/kernel.h:16,
                      from ./include/asm-generic/bug.h:20,
                      from ./arch/ia64/include/asm/bug.h:17,
                      from ./include/linux/bug.h:5,
                      from ./include/linux/page-flags.h:10,
                      from kernel/bounds.c:10:
     ./include/linux/printk.h:219:5: error: static declaration of 'printk' follows non-static declaration
       219 | int printk(const char *s, ...)
           |     ^~~~~~
     In file included from ./arch/ia64/include/uapi/asm/intrinsics.h:22,
                      from ./arch/ia64/include/asm/intrinsics.h:11,
                      from ./arch/ia64/include/asm/bitops.h:19,
                      from ./include/linux/bitops.h:32,
                      from ./include/linux/kernel.h:11,
                      from ./include/asm-generic/bug.h:20,
                      from ./arch/ia64/include/asm/bug.h:17,
                      from ./include/linux/bug.h:5,
                      from ./include/linux/page-flags.h:10,
                      from kernel/bounds.c:10:
     ./arch/ia64/include/uapi/asm/cmpxchg.h:142:14: note: previous declaration of 'printk' was here
       142 |   extern int printk(const char *fmt, ...);  \
           |              ^~~~~~
     ./arch/ia64/include/asm/bitops.h:309:3: note: in expansion of macro 'CMPXCHG_BUGCHECK'
       309 |   CMPXCHG_BUGCHECK(m);
           |   ^~~~~~~~~~~~~~~~
     make[1]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
     make[1]: *** Waiting for unfinished jobs....
     make: *** [Makefile:1206: prepare0] Error 2
