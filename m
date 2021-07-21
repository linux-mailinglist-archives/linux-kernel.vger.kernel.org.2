Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AAD3D15CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhGURUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhGURUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:20:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A644BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:01:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 8so4429048lfp.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPa37eNvC3uDqntcxwWWKIYs96FW2IfN+zBOwLvLWyk=;
        b=c+qRkAs1DwxE9hRy95PZsZTyPTKGRmiVDdYPr/bRhqbhIDs7uWTM2Wsf1S7FMeFGe1
         FNgM0RY06bExtz9ZsFKG5uZQ1/OxFtWR3RXfJPOwfj+9JRRXgAw7yBN4moMgoQd9D6PA
         XBUgrH2V+hAGFnQQ1Pvz1igLS1r2cK9mRXng4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPa37eNvC3uDqntcxwWWKIYs96FW2IfN+zBOwLvLWyk=;
        b=WlAvXktGeph+rwrtByba0In4y5/9hDor4kaPdZeYmP/L9kvnEO8OlH+YilmwirE+uU
         iMB64lgfLA+6HFbejiQDclwIgi6gZnNT60GgPa/Jvjr1Pv9gKtoAbfStcRNSToBMBxTE
         dWKdUZnD3rrnsMuMaKZij0Rn7MKcGwX86/RaQhxTxf97JThn63dcGpG/zjweht0M5B0n
         Z8t93vq0pmHd56m5mozk16GfI2A9RCZN3i/DIcJJF6ZTFm4rL43XsAoDM3O5cYORWVHK
         fl6Yvcz/S1oNilRxXuisqhsMjQZyQ8IezzEmYCp/y2tfoLwULDZxLCtaTu8R6sZHNkds
         meRQ==
X-Gm-Message-State: AOAM53094057GmRTz+DnR/8fdPpsAEb/jCpVKOufIPK3S0nh/SjBJvSX
        nXGEckln03PH39udrogTOJbqUk7ErAxpZPzh
X-Google-Smtp-Source: ABdhPJz3h5qNRRU0jqN+/1nSbLOrLOQXBL9muYBnSGyzfis/Z96kLC7wv20fPzQA69+SAHb5DFB3FA==
X-Received: by 2002:ac2:414e:: with SMTP id c14mr26575175lfi.632.1626890476806;
        Wed, 21 Jul 2021 11:01:16 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d8sm1797015lfq.138.2021.07.21.11.01.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 11:01:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id g8so4422583lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:01:16 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr26027265lfl.41.1626890475459;
 Wed, 21 Jul 2021 11:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com>
In-Reply-To: <20210721135926.602840-1-nborisov@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 11:00:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
Message-ID: <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 6:59 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> This is glibc's memcmp version. The upside is that for architectures
> which don't have an optimized version the kernel can provide some
> solace in the form of a generic, word-sized optimized memcmp. I tested
> this with a heavy IOCTL_FIDEDUPERANGE(2) workload and here are the
> results I got:

Hmm. I suspect the usual kernel use of memcmp() is _very_ skewed to
very small memcmp calls, and I don't think I've ever seen that
(horribly bad) byte-wise default memcmp in most profiles.

I suspect that FIDEDUPERANGE thing is most likely a very special case.

So I don't think you're wrong to look at this, but I think you've gone
from our old "spend no effort at all" to "look at one special case".

And I think the glibc implementation is horrible and doesn't know
about machines where unaligned loads are cheap - which is all
reasonable ones.

That MERGE() macro is disgusting, and memcmp_not_common_alignment()
should not exist on any sane architecture. It's literally doing extra
work to make for slower accesses, when the hardware does it better
natively.

So honestly, I'd much rather see a much saner and simpler
implementation that works well on the architectures that matter, and
that don't want that "align things by hand".

Aligning one of the sources by hand is fine and makes sense - so that
_if_ the two strings end up being mutually aligned, all subsequent
accesses are aligned.

 But then trying to do shift-and-masking for the possibly remaining
unaligned source is crazy and garbage. Don't do it.

And you never saw that, because your special FIDEDUPERANGE testcase
will never have anything but mutually aligned cases.

Which just shows that going from "don't care at all' to "care about
one special case" is not the way to go.

So I'd much rather see a simple default function that works well for
the sane architectures, than go with the default code from glibc - and
bad for the common modern architectures.

Then architectures could choose that one with some

        select GENERIC_MEMCMP

the same way we have

        select GENERIC_STRNCPY_FROM_USER

for the (sane, for normal architectures) common optimized case for a
special string instruction that matters a lot for the kernel.

                     Linus
