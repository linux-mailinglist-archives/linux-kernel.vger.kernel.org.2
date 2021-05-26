Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35251390E10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 03:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhEZBzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 21:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhEZBzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 21:55:31 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 18:54:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r7so23736370ybs.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 18:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvrXRyjoBBrQMHRw50pC/sl/5hocosZ/le3L6XN/5G0=;
        b=TDHeF7nt4MrYu00bq6FkzfvRaseUNm+Vb+wr4VLpSJ69fzI4MJh21m+2/XVfIhsTdv
         rm7b19FwT5QTjcIMsK4wNOHSsKUCmLrX5Ws3FdAdN2eibOuXieqC+2/urZpyUJHoHife
         E+JuQt217OaOoRJrJ7uuMhZ3zyaaZG2W5JTbQy9Keb98uOGI1IuOIGJojuuAOTEYoCjI
         625GRpHftkNtrIo9mWHQgkeF+9u4pKrOpIQpr0waO66f5N71by+WnVQZyl487BllHX8P
         4/ga6N99LdU63OIR4Lvkp/pjvaEQzcklCcUVDyqBQ1AEeEOr8OvRduI87Dgk5Ky+ZP2c
         t+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvrXRyjoBBrQMHRw50pC/sl/5hocosZ/le3L6XN/5G0=;
        b=U9jOTdFXGPForVWj7u+4BRMclZ/5cZKM0sSOHX4J/u025I0osVsuMOQ7qQcqTLIopr
         BpZc5B/8b7+HvvELeeXrvjLOK2fY9HEcMm6kM61f4SpLkgff8wXBBNAmXFs36u2yc2i9
         jAgbF2ClPvwLBfrSPNxy3EbokOT6xJnejPohQqXFhit2uVZ9oKRqM32B7cZSyoHCQcSg
         ds6jk2AVVv5DY/94XO0Ty9jWFYUqX0S2T6lX1OtEBfGfR6hLyg4oWvGUPA/LrMOpQGF0
         8FZgkKO4ZAI+2vw1hB3mE6qSEkM8vqto84X/vnOBodU/hAlb5ggPM75EEDLf2dXSKFSt
         8wzA==
X-Gm-Message-State: AOAM533OTwyhXiSNMOvGbU61rL9IRt7oz0TSxNTFVtApZlHH2s3zaAjh
        wCdAfAiTJyd2MLnNArlIeo2GaIbPqOyNWveiPBY=
X-Google-Smtp-Source: ABdhPJwcpDhbJjwreR5M4pyxCXYqs5RFMUyYAJ9SVB1xHD0yZSkhtc38rL2zNjFdhYG55Zec5dPCooZzfS82b5sNUjY=
X-Received: by 2002:a25:a448:: with SMTP id f66mr44585807ybi.135.1621994039003;
 Tue, 25 May 2021 18:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210525175819.699786-1-elver@google.com> <CANiq72krX9PU14wFsQyW_CJEjTS-TT8wyhBVZZbC132Gz5XO-Q@mail.gmail.com>
 <CANpmjNPGUAv-d3yEusyF11ip0zEdht7eMGi4pSoQsRYns-MvJA@mail.gmail.com>
In-Reply-To: <CANpmjNPGUAv-d3yEusyF11ip0zEdht7eMGi4pSoQsRYns-MvJA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 May 2021 03:53:48 +0200
Message-ID: <CANiq72kCkej_ONwSWjRHWLVrr+g0BZygAUAQVx+FQf7DEdg3cQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: add __no_sanitize_coverage to fix noinstr for all architectures
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 9:13 PM Marco Elver <elver@google.com> wrote:
>
> Long story short: this is not fixable without more Clang changes. The
> only way to do it without a version check would be to introduce
> no_sanitize_coverage attr to Clang, which we probably shouldn't do,
> and I didn't want to fight it. ;-)

I am not sure I followed why you would not want to support querying
for the attributes (if they are intended to be used separately).

But regardless of that, why not the feature flag at least then, to be
consistent with the others?

Going back to version checks seems bad -- they should be reserved for
e.g. known broken versions and things like that. New compiler features
should come with new feature flags...

In fact, for Clang, I do not see any version checks in code at the
moment, so this would be the first :(

Cheers,
Miguel
