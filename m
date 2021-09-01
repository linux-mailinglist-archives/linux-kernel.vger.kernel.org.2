Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C17C3FE3FA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhIAUaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:30:07 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22]:10715 "EHLO
        mail-4322.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhIAUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:30:06 -0400
Date:   Wed, 01 Sep 2021 20:29:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630528147;
        bh=WVOsQI5nD1PtXvSuDOtR2xqDg1KdImjbJxPWDJVWN2I=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hKwqPPNrZm8VnLoyFPUke5rYmRryiW7+1RiC5lX8+vK60EpgTqXD06rCHuuC6ylq/
         /mTnDOVFyUIk2zx4zjhYbRHt0hiQLgBUuRhCG7PTzbUnKktH1jhLM8ZkHVjqwZpM4l
         O5Byvp2TDqM5SDfFN1LttfSz2YIg1Uk/Pq6cEK7ZQ9ObB9XuGs5cQCbCancVXD0Tvb
         xyKYTWoZXD0oLJixV9wPYtqEDfE0BNkaw0MWZV+ESYgHhCqtkhcvqZQrlc37PYx93b
         jF8h9Tgnv0oDjYolSF0MI8PSdNIaV/yYCx0giAAwe+mBEqtBmuNHkGHXr0uO2GKVH3
         pz6KRpBDrTWtQ==
To:     Krish Jain <krishjain02939@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <20210901202855.fnoidizshw2uwo3q@h510>
In-Reply-To: <CAPGkw+zhb=zC8fKyK8uUiNxNqCUR9Trg6N7fBjaAcBc9rmkmUg@mail.gmail.com>
References: <20210829144531.c2syu4vv4s22dlg7@h510> <13366651.n50aozgL3V@localhost.localdomain> <20210831230014.cp46vho2hnndacjp@h510> <CAPGkw+zpYsovnXL_4GfjsQ60fqre+xyiwvwKuDj_fHPTKEfzeQ@mail.gmail.com> <YS+cexhuqldPaACs@kroah.com> <CAPGkw+z+uepM0hiNh48xjjD7=2rpgr+RSLzMcHbw2iE=8y+xqQ@mail.gmail.com> <YS+vfVTV0fls6KuN@kroah.com> <20210901173357.2dfvw5xgpzjndesc@h510> <CAPGkw+zhb=zC8fKyK8uUiNxNqCUR9Trg6N7fBjaAcBc9rmkmUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this day, September  1, 2021, thus sayeth Krish Jain:
>
> Yes, lots of reading to do :) . I had a look at the book and it seems
> better than the documentation too, I don't know, maybe the writing
> style? Love it, Greg. Lastly just out of curiosity, Bryan,  if this
> can only be built as a built-in object then how come "As for your
> patch, I built the driver using:
>
>   $ make CCFLAGS=3D-Werror W=3D1 M=3Ddrivers/staging/android"
>
> got you the errors that I desired? Aren't you building as a module here?
>

That's a good question Krish!

The command I sent you does not build built-in modules or create the
output I sent you!

As Greg said, ASHMEM cannot be built as a loadable module!

It is odd, when retracing my steps just now, I must have known at some
point that ASHMEM was a built-in module as menuconfig will not let you
select the <M> or loadable module option. The only thing I can think I
did was build the module without using the M=3D option, copied the error
message, then retyped the wrong 'make' command I had used to produce it.

What is *very* embarrassing is I had multiple opportunities to catch my
mistake. Somewhere between building your patch and writing the email I
truly lost the critical piece "this is a built-in module".

Even the CCFLAGS command Greg talked about is not a great command to be
using! I should not have sent you CCFLAGS or the less worse KCFLAGS that
I should not be using. Both really have no need here in drivers/staging/
and only add to the confusion.

I will say, for your next patch that I am eagerly waiting for, the W=3D1
option is a good way to catch subtle errors that Greg may ask you to fix
and resend. I got one thing right :/

I don't know, I truly lost my marbles on this one.

I apologize again for my goof, it must have been very frustrating.
~Bryan


