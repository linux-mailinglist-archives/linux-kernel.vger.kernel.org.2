Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E8423D5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhJFL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbhJFL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:59:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D25C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 04:57:39 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p80so2453047iod.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qP8qUdurFon+vS8eyUqKuAmxlr00Ucs7J31uCZEKlng=;
        b=RHqUFEetTG/eYk7o+keixgzTsx76qze7UUJ06SBYaebyHUQ2d5IplJMpy/dauoI6iB
         dXDfk49UADHMti+mCSw3jTWGQjE/NgyfiGmOE5qL/lL/MPBMO0UjMMvD7P5hwfEGmnTp
         fswdFmXWOJINyEbFlJ8T5NobRk2GBLe1NKBcVcC+ueLeV1X1P5jxzNRiQvzBt/26KEZs
         fgXpPBMzaFop8NrepFeSG5d5inz6n9u76TL2FuJjgOh0lxhzA98scObInb5Bpu/19LBT
         pEsirjNTqtAilTcjDnmEoaZ0eH2ebJd6P7nA1tXnCkBRiyLQcvZYF13hpRZrB5GMogAt
         Fk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qP8qUdurFon+vS8eyUqKuAmxlr00Ucs7J31uCZEKlng=;
        b=wW/f79lO8Xw7cdnHhjvgKXYRx2npdKosPbs7XI1QOw1NeKamh9BTt1QjdgRCJQMH8A
         RjdWNzeqDMneL9/SXL9RdFK6IW5rONL+EbJcWF6hGCsQnatJwKt5CpsrViszewYT8YFx
         eDc2yuZASIRmRCW+AI0e10BbuFQe3gSCZZiglbYd+6IIlF60f7zgxBU9WvH7WYgsVIUM
         pOC/3d5GhKHcDoiUCpiVk2fgNjW8T/PcCqRYLethYaqsBYkxGnPAJdkclouMfYOXETJC
         FNXE0hsSH0+RcFE/BXYuZs9s6olg5KERqedtp2wAWk49uzDLIYNNlD2eoZarrtLlXp26
         Vg1w==
X-Gm-Message-State: AOAM531z7Cc5/pa+8Gzj7ZjQwR5Kh1SJn4Byvq8gSZXFzobjI8a37x/Z
        7E+C7yxeovili6cLWkT8TOSTs2+rmLtKgUlIZ14g0uxrarA=
X-Google-Smtp-Source: ABdhPJzrUCrbL4qoMWWF4ycdUPgt1QQgBnX/C1pCX8aC6wNFiNRQWvoYqGnSTsMpnJdJpFN7PKPT/9sQv64HdBNoy10=
X-Received: by 2002:a5e:9b18:: with SMTP id j24mr6049480iok.202.1633521459169;
 Wed, 06 Oct 2021 04:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210922205525.570068-1-nathan@kernel.org> <CA+fCnZdfMYvQ1o8n41dDzgJUArsUyhnb9Y_azgCVuzj6_KBifA@mail.gmail.com>
 <YV0NPnUbElw7cTRH@archlinux-ax161>
In-Reply-To: <YV0NPnUbElw7cTRH@archlinux-ax161>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 6 Oct 2021 13:57:28 +0200
Message-ID: <CA+fCnZc5=fqM=eEZ3RLqBFaxR72bjxndDdnM_rOkiSBi3+2L6A@mail.gmail.com>
Subject: Re: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 4:43 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> > This part of code always looked weird to me.
> >
> > Shouldn't we be able to pull all these options out of the else section?
> >
> > Then, the code structure would make sense: first, try applying
> > KASAN_SHADOW_OFFSET; if failed, use CFLAGS_KASAN_MINIMAL; and then try
> > applying all these options one by one.
>
> Prior to commit 1a69e7ce8391 ("kasan/Makefile: support LLVM style asan
> parameters"), all the flags were run under one cc-option, meaning that
> if $(KASAN_SHADOW_OFFSET) was not set, the whole call would fail.
> However, after that commit, it is possible to do this but I was not sure
> if that was intentional so I went for the minimal fix.

Ack. Filed https://bugzilla.kernel.org/show_bug.cgi?id=214629 for the rest.

Thanks!
