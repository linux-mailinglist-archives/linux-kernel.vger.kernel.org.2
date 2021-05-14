Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80C3812BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhENVSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhENVSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:18:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1112161440
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621027026;
        bh=FkYS3b8klwUZgqRAsV1fLaIsKhorPnMeQcU6zqUcCXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oy/zU7SWu5VgDc+N+6nyOsYNzrzjbLZe9ibr2jg8hg3Wd6sK8Vuk4EKYzcHza3OIz
         XdiFm2zhIvJRjTcEoYyWNfnUOBlWowKvBT5C6+uFtI7HahONAYWZwsECXACqvrd19t
         VOR5Psl9+l8cqHaeMEavlgZ/Pvn15Qjcm0/77oHX//sx4+NpRUuk44eONr/HtwNJjE
         AooKxVs7tppkVWLudZaOAftMAmfMT5uYjqMXFLGxxU8itHPbf++/MN4i6tewi0VC3b
         kjqxhgM027l3utE+5K3eRXEfFcD9vBDj9rOnkwcfoz8Gmz5dRT+KKAwzbM8YUNnQ5/
         zqCnvSjNXoi7g==
Received: by mail-wm1-f54.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso2968093wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 14:17:05 -0700 (PDT)
X-Gm-Message-State: AOAM533jxIDotgjT9mwgBLCFpL9gAqXJgpG/42n9ga0/MUkZ51yBsW5a
        xBu9cytN0I6XX61uU62SImD8xLZSIhAnGM4Ub7w=
X-Google-Smtp-Source: ABdhPJwhAdIA3l53QKf9VIa2VSFX2oqBop3iSlv3/fGgXzbmeCwPpdYAw6WvhRWD6lW5h4GQkc15lxBDfKjdn6vnhyc=
X-Received: by 2002:a7b:c846:: with SMTP id c6mr11049940wml.75.1621027024776;
 Fri, 14 May 2021 14:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140015.2944744-1-arnd@kernel.org> <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1> <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
 <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 14 May 2021 23:16:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
Message-ID: <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Fri, May 14, 2021 at 01:11:05PM -0700, Nathan Chancellor wrote:

> > You can see my response to Marco here:
> >
> > https://lore.kernel.org/r/ad7fa126-f371-5a24-1d80-27fe8f655b05@kernel.org/
> >
> > Maybe some improved wording might look like
> >
> > clang with CONFIG_LTO_CLANG points out that an initcall function should
> > return an 'int' due to the changes made to the initcall macros in commit
> > 3578ad11f3fb ("init: lto: fix PREL32 relocations"):
>
> OK, so the naive reading was correct, thank you!
>
> > ...
> >
> > Arnd, do you have any objections?
>
> In the meantime, here is what I have.  Please let me know of any needed
> updates.
>

Looks good to me, thanks for the improvements!

          Arnd
