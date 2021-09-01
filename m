Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F33FE05C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbhIAQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245504AbhIAQwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84A0660525;
        Wed,  1 Sep 2021 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630515072;
        bh=A9wkNg9aBJrglsUZ5b/buH7xJaIQnLA+gD3vgVvDd7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPeXShP9yKHzHlMdGL7qlLOd2lcOPNGRl8kL0qYwIlxJPbLzdlLogxSB0S1nBPiOc
         Pm7JdoOZozq1ou1DXfeRSbjYD9TWSXqmORrEypMmDIJhPT07uUNT9aINUF9qNv51ar
         +IKAIzlaYNjJIU9AZQJC+5QNVoX4ufAex0OeNuGw=
Date:   Wed, 1 Sep 2021 18:51:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krish Jain <krishjain02939@gmail.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <YS+vfVTV0fls6KuN@kroah.com>
References: <20210829144531.c2syu4vv4s22dlg7@h510>
 <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com>
 <20210831133533.6aayzjghdakrhy56@h510>
 <13366651.n50aozgL3V@localhost.localdomain>
 <20210831230014.cp46vho2hnndacjp@h510>
 <CAPGkw+zpYsovnXL_4GfjsQ60fqre+xyiwvwKuDj_fHPTKEfzeQ@mail.gmail.com>
 <YS+cexhuqldPaACs@kroah.com>
 <CAPGkw+z+uepM0hiNh48xjjD7=2rpgr+RSLzMcHbw2iE=8y+xqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPGkw+z+uepM0hiNh48xjjD7=2rpgr+RSLzMcHbw2iE=8y+xqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 05:34:36PM +0200, Krish Jain wrote:
> Oh ok, thanks Greg. I only attempted to use "make CCFLAGS=-Werror W=1
> M=drivers/staging/android/" as that's the command Bryan used earlier
> and it worked.
> 
> "As for your patch, I built the driver using:
> 
>   $ make CCFLAGS=-Werror W=1 M=drivers/staging/android"
> 
> 
> Can you tell me why this is the case?

Again, it depends on your kernel configuration file as to what will, or
will not, be built.

If you have some things set as modules, they can be built as a module,
but the ashmem code can not be built as a module, so you would never
build it if you did the above line.

Here, look at this sequence, starting with a tree that does nothing if I
do a simple 'make' in it, as the whole kernel is already built, and
ashmem is enabled in the kernel configuration

$ grep ASHMEM .config
CONFIG_ASHMEM=y
$ make
$

So, let's change the time stamp on the ashmem.c file and see what gets
built if you use the M= option:

$ touch drivers/staging/android/ashmem.c
$ make M=drivers/staging/android
  MODPOST drivers/staging/android/Module.symvers
$

Nothing gets built as ashmem is NOT a module, and M= only builds any
modules in the directory you specified.

But, if you tell make to just build the whole subdirectory, no matter
what the setting is, it will be built:

$ make drivers/staging/android/
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND objtool
  CC      drivers/staging/android/ashmem.o
  AR      drivers/staging/android/built-in.a
$

So that's the difference, "M=" builds modules in that directory, but if
you tell it to build the subdir, everything in there that needs to be
built, will be built.

Be careful about your kernel configuration, that is the key for what
will, and will not, be built.

Perhaps you should look at the book, "Linux Kernel in a Nutshell" that
is free online.  It talks all about building and configuring a kernel.
Parts of it are out of date, but the general ideas are good.

hope this helps,

greg k-h
