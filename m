Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BB033CDAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhCPF6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhCPF5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:57:30 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38347C06174A;
        Mon, 15 Mar 2021 22:57:30 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id p10so11639395ils.9;
        Mon, 15 Mar 2021 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PunuthsHHvFUpjG6XB7E+47qeOKXzni10NlDoUs74g8=;
        b=hZbWCzK07qG99NA9PnCCun/jjiCiSspOSaYC8JiB0WJ7nK82YS9VmI4csU7HAWKsQ0
         n4GnMam19zRfk+GdcWstfwo7fwVglIH3aRxCtOeYUCYohMMzImfBGI3HTyk1MG+KE5VK
         IS7OHhXX5TXZJvTPDeFntJK1Q/4QHkoDg4EyAiGb35gW4lv3Hvly7o5BJIT4DlvuTqpt
         mvV7YdMH+nUEHW9UKn2k7taxPHPO2PKQSpTDR63cC2lyfPrFx4Ji0vFbXtZFiogks3Df
         4xwwsr96vIsDEvUqovjcR1YmReEoqQNYmqawuQyGEETEZM9uT38LfBVja/63fYniz2+d
         qYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PunuthsHHvFUpjG6XB7E+47qeOKXzni10NlDoUs74g8=;
        b=mbmiPyi4kDbykobNt9STsNnQj0FELhUa4ZPK7FEtfHU05tdbf77RfLvEuHpoRPy6p5
         4ythG3iqPNqNjwVbbtN3cPrbgvocC7UbTheFn6oGf3nAsEM0soSCLU6E6vGq6sYUZkDZ
         S/fwDH7Kt8Xt3zSKHPGuwk9C8/aY9HPJL/7dvFf/w1fC9GxuCnvFSaL2G8oeMVJLemwR
         BbYJc91LNOcM23Gq9QuhJ+aLK4+AQdBN1PzTMnaRyFvVk+czGq6kfR3wsJKhcgq0rBiE
         svXG6YGESwXljtT51rHjyO9aJBLB20LbZXw4xg7hAKMYHU2BxPdMxv70flQarU8QOY+M
         xsTg==
X-Gm-Message-State: AOAM532xEVwxalgwX9OYEHvdWRX/rzSBKqVEsw2QeYrVzg3g2B7eA5FI
        KHSGUu1sbGJRcdu1+2cQ6BTG5848+Y4d983sPfA/KAp5Ib0=
X-Google-Smtp-Source: ABdhPJyD0aHr9d3HmX8WJ57qBEc0Nie1Huwvep6tIoPan8LXvOowUX1mNkH6JA+vff/FPJUsdyI3R5sRGzZfqEI4imA=
X-Received: by 2002:a92:444e:: with SMTP id a14mr2482945ilm.215.1615874249620;
 Mon, 15 Mar 2021 22:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic> <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic> <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
 <YE+i/VWITCCb37tD@hirez.programming.kicks-ass.net> <CA+icZUWQ1kH6muAQbNuVAPj4Cn=8ssDAJfYLKht8ezAgJKWApA@mail.gmail.com>
 <YE/cMeO+oC/5JEC6@hirez.programming.kicks-ass.net>
In-Reply-To: <YE/cMeO+oC/5JEC6@hirez.programming.kicks-ass.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 16 Mar 2021 06:56:53 +0100
Message-ID: <CA+icZUXko_Nxh-9_qgjMYyGsh8E1rj2cWmQh0OHjuZECMZxp6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 15, 2021 at 07:23:29PM +0100, Sedat Dilek wrote:
>
> > You mean something like that ^^?
> >
> > - Sedat -
> >
> > [1] https://git.zx2c4.com/laptop-kernel/commit/?id=116badbe0a18bc36ba90acb8b80cff41f9ab0686
>
> *shudder*, I was more thinking you'd simply add it to you CFLAGS when
> building. I don't see any point in having that in Kconfig.

Simply adding the CFLAGS to arch/x86/Makefile.

If I forgot to mention:

   Tested-by: Sedat Dilek <sedat.dilek@gmail.com>. # LLVM/Clang v12.0.0-rc3

- Sedat -
