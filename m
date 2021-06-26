Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718F13B4C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFZDQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFZDQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:16:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37413C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:13:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a15so11940729lfr.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TkyzL4Oc3lzO4SmvL1uZ5kh/tlw7Tnkl30zzFvAnsHU=;
        b=BRUo2gzr89us7y2+/oL9vvZc/Vz15VUEx4jF4hxEgfybERK9O9kUd9bOmZ3yq2So56
         v4HTTw3Tw5KzH2TlpiOiOw7KHGHHjzfeH9f+26fFMAY0GnX2je4A5hHC7AO+O1sWxHX8
         NmQaIBG8tAChmaAf2FqaNm1DjPcuTJ/8ps0Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkyzL4Oc3lzO4SmvL1uZ5kh/tlw7Tnkl30zzFvAnsHU=;
        b=ji6zQivcpe+oXx53qC2RIYccV+TrHY8zec85rhSOJHCVFAMh7K6jqE1VX5pYL9Djm8
         /3KmvBZZaAHvFfMUFlR0xSTJMg9K/GnARM4G9Ta4VZmJ1mB0ohTjtIaX3BAEIgf78T4/
         WSf4/WvOqp8VObajv42uR6+64CZozosdRztdcwvvcLQ+EAVjzB5l27vp55OwnGdpURq7
         dcEbWhznoLxqSIdq4JTFFzZAKFpPC5XFAw91hpofodIugoa4X5BlAviCJZ+bBYxZPfGL
         hjmX1iXwGV49Vy8ZYAA6h91r/bLAlYtxMa2917KUaczavHD/62vLanzk4Sn4bSGIcMli
         zA/w==
X-Gm-Message-State: AOAM533zirW5aNP+PHePj/nvDp2a3sPUNBi1O/eOxYQ6Z0MmQ0F9ad/p
        ugUER8xT+8XT6cRmiR9Tw+lX6Ex0USr5vyLE
X-Google-Smtp-Source: ABdhPJxNos9Ip5BXMtEtwT6E+n6gki/vBDa3cjGABWtVJUO13blraqP8pEyF+0MsnTzHoMY3iiCB1w==
X-Received: by 2002:ac2:5e38:: with SMTP id o24mr10654085lfg.652.1624677217329;
        Fri, 25 Jun 2021 20:13:37 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t16sm665263lfq.275.2021.06.25.20.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 20:13:36 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id d2so15285267ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:13:36 -0700 (PDT)
X-Received: by 2002:a2e:850e:: with SMTP id j14mr9011286lji.251.1624677216398;
 Fri, 25 Jun 2021 20:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <YNYz+hVeqsQmiEqN@localhost.localdomain> <YNZG6N0W/7gjG7Gm@localhost.localdomain>
 <20210625163040.a15af04872959da9af161fca@linux-foundation.org>
 <CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com> <YNaS5AZDDpL3gJfe@zeniv-ca.linux.org.uk>
In-Reply-To: <YNaS5AZDDpL3gJfe@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Jun 2021 20:13:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgitzn6sqXZ0YjFW-pYadEXU808QPJZ5OXvM5oB47K_Lw@mail.gmail.com>
Message-ID: <CAHk-=wgitzn6sqXZ0YjFW-pYadEXU808QPJZ5OXvM5oB47K_Lw@mail.gmail.com>
Subject: Re: [PATCH v2] ELF: add and use SUPPRESS_WARN_UNUSED_RESULT
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 7:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Wasn't there some emulator (dosemu? wine?) that relied upon that?
> Said that, I could be easily wrong - half-asleep right now...

Different issue.

dosemu used to use vm86 mode to do hardware acceleration of 16-bit
emulation. And the way vm86 mode works, it all has to be mapped
beginning at address 0.

So yes, dosemu used to do a mmap at address 0 too, but it didn't use
this ELF mmap MMAP_PAGE_ZERO personality thing to do it, it just did
its own (it also wants a lot more than one page).

Nobody uses vm86 mode any more, because hardware acceleration of
16-bit code just isn't relevant any more. Any 16-bit code you have
doesn't need special hw modes to run sufficiently fast.

Plus x86-64 doesn't support vm86 mode at all (well, technically you
can do it in a VM that runs a 32-bit OS if you really really want to,
but see above as to why you don't really need it).

There are other things that have mmap'ed things at zero. I think all
PA-RISC HP-UX binaries used to do the same thing iBCS2 did, and the
compiler would actually hoist loads to before the NULL pointer test,
so it was pretty much "architectural". Afaik, that's the same reason
why iBCS2 did that zero mapping too, but PA-RISC just required it a
lot more.

It's a horrible thing to do, and only makes debugging harder (because
you won't actually get a SIGSEGV on a NULL pointer load, you'll just
silently get a zero value and your buggy program will continue
running).

                 Linus
