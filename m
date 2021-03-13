Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC861339E10
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhCMMjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCMMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:38:59 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A8C061574;
        Sat, 13 Mar 2021 04:38:59 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u20so28609832iot.9;
        Sat, 13 Mar 2021 04:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cgJ+VtAGOS3jTRYXST2zAk0X7X8186uEYL3R4mCpWkQ=;
        b=XeFGAlmUSuI28aEPPtCPicYmGAqKS2T6ZF8AfvV1syPnlrWdcPggRwvM1ugcf65/nu
         5BThcRA0Ucp2WMcVuik0B/0/zM7OR/CXfhhkXzvs4B0XjZMMrc2wOCmPYc48q1xPXx4m
         thwwnzUEZKEMFS6Rb+c0AayQ6bJ7sY9OBdVSczl95JrR8f/WiR+exU55hFj3ckpwyqLa
         ic2/grPvWUgxOC/EsfUWTMJDXHHGVNbuGrbw83gUnDpH8bPahyYna5RBx/pbXfuoZWUm
         +aQP2zdvuyM4JN+gtRRZ4l4jl+hgGIPx6hleVg2a6/69WR5n9PlrvnSX9vzAtjQU5PKq
         jnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cgJ+VtAGOS3jTRYXST2zAk0X7X8186uEYL3R4mCpWkQ=;
        b=MgDH8FuuZhuQ1QMORTclPORMQL/mb9205JwiSKsE6xOU0Eo8KYmZ2HwpUImUY9A5bJ
         olxY+TFNxwyddlt7hmKaAiuLrecC5tzHDnrEQqASx2VlDD28zDuX1RkZlzN03dFZ6bs6
         304j/t63jLJVbSu8hs7h/o0SIriw78UcoyptOW/PZ6/ejH3zTX0qRPehFH8U+qU8YGjU
         AkkH31eNe68am7Lu/s98Jo9sMyUuY+SN9ae4QF7jljK/eP+x13O8BDZBQbdp99t/lwYY
         Uc2P4ih3ZwIORbCcs/SEz2+I7cEMoXU3oRGobH3A0f9i6RxvaeNFp7hLbedBZ7XyXn29
         /StQ==
X-Gm-Message-State: AOAM532fZq0vFgpU4OtiVii69msWGif4xnBDEBimtYm+FkPRHTHQwDDv
        RUrIh6+c8NboEpH8MLm7F/mOYDyPQitriOVQxIzAwsBBlhbH/Q==
X-Google-Smtp-Source: ABdhPJxSTEzYAS4rSAqKWk/E40C6kKUyj+asBcqstMIBbL6LHHDg2+hTUMXXCY3S56XEAMULRHlmpHpapU6mArDvXyU=
X-Received: by 2002:a02:b890:: with SMTP id p16mr3091242jam.138.1615639138613;
 Sat, 13 Mar 2021 04:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic> <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic>
In-Reply-To: <20210313121541.GC16144@zn.tnic>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 13 Mar 2021 13:38:22 +0100
Message-ID: <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 1:15 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Mar 13, 2021 at 01:10:29PM +0100, Sedat Dilek wrote:
> > Here we go:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=864b435514b286c0be2a38a02f487aa28d990ef8
>
> That's why I told earlier you to use tip/master - that patch is already
> in it and all you would've needed to do is to apply the two nop patches.
>

Thanks for all your testings and suggestions.

For me it was easier to apply these 3 patches on top of my custom
patchset to see what impact Peter's patchset.

AFAICS you did a 5 times x86-64 defconfig with dropped pagecache and `make -j9`?
I run my "normal" workflow(s) (and build-script) for easier comparison
on my side.

Big thank-you for testing with LLVM/Clang v11.x - twice as slow as with GCC :-(.
A selfmade ThinLTO+PGO optimized LLVM tooolchain v11.x/v12-rcX/v13-git
is here as fast as Debian's GCC-v10.2.1 to build a Linux-kernel -
approx. 03:30 [hh:mm] - full adapted Debian v5.10.y kernel-config.
Does your distribution offer LLVM/Clang v12.0.0-rc3 (released this
week) binaries?

- Sedat -
