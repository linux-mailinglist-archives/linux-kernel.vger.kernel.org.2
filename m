Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A15413018
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhIUIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhIUIUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:20:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91DCF61019
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632212356;
        bh=le6j7xmd/yCscuro1jGjBBfgcgdTXgx2DPvrOBijSBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lyaqTa6i6fLlxmYX45JMuYN88GgGnd7LEi9y41tzJk5WcJc4oUcG2UOSfpeoyNiBA
         xt1A1EF9rYs+MwZrmS0ULEotpUAU7rSapFfYWWvX3KaNgmVdCUvI+lTR+F6rplthEE
         g6IbqJCqeUcSscy0j/Fvp5vrT85Fg1GF7ldEp3I9skdXCHCdEZeURwCVG5AeMnJvrh
         +Rh5LOnOMaxKb/gk/xDPUJX1jvEds6rPOXLJuWdFk+6agSdZ1Dam1Q8Xv8/eXKlNiW
         hNuzg2OP85unETAtGfwqQriLo25gQ5w8vIVVSOtxr9++ziB6ACvOt2g0koRGuCM/r9
         ITuZlz2HT9KwQ==
Received: by mail-wr1-f53.google.com with SMTP id w17so28535872wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:19:16 -0700 (PDT)
X-Gm-Message-State: AOAM5303baKHOyeDXMjXPvcvRoN8mv/HZJ0kam5P9zbzur8NraV6gbqM
        +tAasXxCYBcqofPLjL36pgSDKm2jtdReYSE/VBE=
X-Google-Smtp-Source: ABdhPJxv1O0dtgWOE2xOt8BbTGoWVDHppPI/Nb+VWZUvA1xKsdwJNnipM49JsMgHQZCGodY7jmDKQbA9FA3ts6/+6YQ=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr567322wru.336.1632212355202;
 Tue, 21 Sep 2021 01:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210920121208.54732-1-arnd@kernel.org> <CAHk-=wi=CZ_fsUwDQCBbgPB4MTFx1ywgyERjFb7DNUk9Pix_Nw@mail.gmail.com>
In-Reply-To: <CAHk-=wi=CZ_fsUwDQCBbgPB4MTFx1ywgyERjFb7DNUk9Pix_Nw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 21 Sep 2021 10:18:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a03VTsdALMORVSWvAY9J8dS=wQjvhf=M0hXGqLLxDYHsQ@mail.gmail.com>
Message-ID: <CAK8P3a03VTsdALMORVSWvAY9J8dS=wQjvhf=M0hXGqLLxDYHsQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC v2] qnx: avoid -Wstringop-overread warning, again
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Anders Larsen <al@alarsen.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 7:26 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Sep 20, 2021 at 5:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > +               /*
> > +                * work around gcc-11.x using the first field it observes
> > +                * to determing the actual length
> > +                * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
> > +                */
> > +               char __empty[0];
> > +               char de_name[];
>
> Ugh. That looks _really_ hacky.
>
> It sounds like we can avoid the gcc bug if we just always use
> "de->de_name[]". Then we don't need to depend on magical behavior
> about one particular gcc version and a strange empty array in front of
> it.
>
> IOW, something like the attached simpler thing that just does that
> "always use de_name[]" and has a comment about why we don't do the
> natural thing

Yes, your patch is much nicer than my attempt. I checked it overnight
and it addresses all the randconfig issues I found.

> Also, just what version of gcc is the broken one? You say "gcc-11",
> but I certainly don't see it with _my_ version of gcc-11, so can we
> (just for that comment) document more precisely what version you have
> (or possibly what config you use to trigger it).

I'm using the gcc-11.1.0 that I uploaded to
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/

The gcc bug is still open and currently targets gcc-11.3. To make it
worse, this is definitely configuration dependent, and I do not see it
in an allmodconfig build, but only certain randconfig builds. I originally
had a simpler patch myself and also found that this did not fully
address all kernel configs.
gcc-10.x and early do not show the problem, I think the warning
was only introduced in 11.1.

https://pastebin.com/raw/fXmNiute is a .config for x86 that showed the
problem for me on 5.15-rc2 but not with your new patch.

       Arnd
