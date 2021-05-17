Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B0E383C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhEQSZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhEQSZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:25:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A52D761004;
        Mon, 17 May 2021 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621275869;
        bh=kiHxisrSfOdJvAPC2fdmIu0u+DiRMK0/wMlGBkTQNFI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WdgR/t2MIoV8u1SSxO6NMkjraoE1xtXj2d1ef4nt7x1O6oUiehaU5m0N38GJlbwlT
         Zzf+bM6LpRedOL1/ek1szUSwpwuB1Ot577QzdnDscjtLqS95RLlUQaXtfTG7UBE+GV
         CcEx7KGL4sfFWWbcptGOveDujSi2f5kriYhLG3PgLQeSzfGN94nSGvcjzQSjmzuTVb
         dF8nHoH4AnNbg2BPgFwzTKfpVZhRzBTlnCX+pkLWHZ4jsZ78u0qrnmxsCMd/eNNwVL
         s6yCaQ8YzYd4EJl2DdwZ5JQtjiI7RhBapykDKgjrLaeO7cyUXMAFhi/U44B1tCWud8
         exYBLVyXEyOyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5DF9B5C00C6; Mon, 17 May 2021 11:24:29 -0700 (PDT)
Date:   Mon, 17 May 2021 11:24:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
Message-ID: <20210517182429.GK4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210514140015.2944744-1-arnd@kernel.org>
 <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
 <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1>
 <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
 <YJ8BS9fs5qrtQIzg@elver.google.com>
 <CANiq72ms+RzVGE7WQ9YC+uWyhQVB9P64abxhOJ20cmcc84_w4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72ms+RzVGE7WQ9YC+uWyhQVB9P64abxhOJ20cmcc84_w4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 04:19:45PM +0200, Miguel Ojeda wrote:
> On Sat, May 15, 2021 at 1:01 AM 'Marco Elver' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > FWIW, this prompted me to see if I can convince the compiler to complain
> > in all configs. The below is what I came up with and will send once the
> > fix here has landed. Need to check a few other config+arch combinations
> > (allyesconfig with gcc on x86_64 is good).
> 
> +1 Works for LLVM=1 too (x86_64, small config).
> 
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

I will applyon the next rebase, thank you!

							Thanx, Paul
