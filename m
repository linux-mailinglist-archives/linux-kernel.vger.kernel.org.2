Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA832AE69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360944AbhCBXIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384502AbhCBWk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:40:57 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80488C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:40:17 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id m11so25249119lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2p9MbOkqBnD2DL+deut9cepxGqhyX+A0rBZZTNWQu7U=;
        b=THbki3q5Bp4Hza6tKAGvr356nc2IQUi/FzXVVUF+9DqkhIoafHNb5cKmfDO7uBy7W0
         T6rLz3aQby44Qzw99tkZjBc8eKolwZy+91Aqmy754REY7u6io7wHfZi7Mvgnys6WguSY
         mNl2EJDeK8n36QX80Iuk1Q3HqA1yFchHbYyldfbuL0bL0KxL7znB+wA2vowYqvPRqMJK
         kV29Lz7TblJCIsjHI0D2emwHps3kXBQ0d3kSMGDWFptmR41zoL2d08JJ5rfmuEVzQqza
         JVY2PoBETy9v5mzRy1aChGXHpS+4mST8cqbmSduSjD2PcYf0ZYnXygDQ4/mbVcR9kc9C
         jTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2p9MbOkqBnD2DL+deut9cepxGqhyX+A0rBZZTNWQu7U=;
        b=XDlPSufV6iaKLgOpMoHugeWF0sIII0MzGZRHDtGmd3s/b6S6VtBwOK9Fy4jEflsf8y
         FKYp0koPFi5mNkZAXf7AmQ26C/2cT0B6lz5BewvEnt9mn1QzdXi/yK6Z3DYa9iw5AvyL
         i5QyBJe+kGwsr3ISvXYMQezzcbADrGGcCpDK3nJVYfylS3cFEW4Jl4ORL/W05kcKNzl/
         iMonne2zvtLmC5BrahCbXi2dgnO5Kevj1Xv+uJFf0Cp9+Ie3zl478js62+903eJgke7e
         tgjleQRZwtyRDQFOAmEyh7uZbB6jNVhVkThLFeK4f91wwZWXydzfZ68pfBqUr9jxFfgC
         Sp4A==
X-Gm-Message-State: AOAM5303NwqhxzKSeUjWsVj1+ykxA1SwhDJ1a+m3QtGFh/Ee0fvXMnYi
        rU+KcxvHkumbmvgKxtg6VwJMqmJ2583QjNlJg5MyRw==
X-Google-Smtp-Source: ABdhPJxyOjgfPzpPjSZIqvbg3mSVljJGyWV4WAh3zbHWxpadv5uLqI6KgnWGdm1tVE9Izc5wcrm9xNyqoBlaV2SZ3s0=
X-Received: by 2002:a2e:b008:: with SMTP id y8mr4393794ljk.233.1614724815853;
 Tue, 02 Mar 2021 14:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20210302210646.3044738-1-nathan@kernel.org> <20210302210646.3044738-2-nathan@kernel.org>
 <20210302220252.ulvlsfyp4ordwrky@google.com> <CAKwvOdmR_p-zbrTUmbObmCVKBcuNLpg_V3NqLeYsEK4xNHfYOA@mail.gmail.com>
In-Reply-To: <CAKwvOdmR_p-zbrTUmbObmCVKBcuNLpg_V3NqLeYsEK4xNHfYOA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Mar 2021 14:40:04 -0800
Message-ID: <CAKwvOd=MXsvTBXvyqDXo8Fr1+-UdqnDGY8JzrD-wSxdQbvHJ5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: Only specify '--prefix=' when building with
 clang + GNU as
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 2:09 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Mar 2, 2021 at 2:02 PM Fangrui Song <maskray@google.com> wrote:
> >
> > On 2021-03-02, Nathan Chancellor wrote:
> > >When building with LLVM_IAS=1, there is no point to specifying
> > >'--prefix=' because that flag is only used to find the cross assembler,
> > >which is clang itself when building with LLVM_IAS=1. All of the other
> > >tools are invoked directly from PATH or a full path specified via the
> > >command line, which does not depend on the value of '--prefix='.
> > >
> > >Sharing commands to reproduce issues becomes a little bit easier without
> > >a '--prefix=' value because that '--prefix=' value is specific to a
> > >user's machine due to it being an absolute path.
> > >
> > >Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Reviewed-by: Fangrui Song <maskray@google.com>
> >
> > clang can spawn GNU as (if -f?no-integrated-as is specified) and GNU
> > objcopy (-f?no-integrated-as and -gsplit-dwarf and -g[123]).
>
> But -g get's set via CONFIG_DEBUG_INFO and -gsplit-dwarf by
> DEBUG_INFO_SPLIT.  So if we say:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang LLVM_IAS=1
>
> So cross compile, use clang, use the integrated assembler (ie. with
> this change, don't set --prefix), with either of the two above
> configs, which objcopy get's exec'd?

Ok, I spoke to Fangrui more offline, and probably misread his
response. From our chat:
```
Fangrui:
objcopy is only used for GNU as assembled object files
With integrated assembler, the object file streamer creates .o and
.dwo simultaneously
With GNU as, two objcopy commands are needed to extract .debug*.dwo to
.dwo files &&& another command to remove .debug*.dwo sections
```

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I ran this series through a mix of LLVM=1 vs CC=clang, LLVM_IAS=1 vs
unset, CROSS_COMPILE vs not, without issue.

>
> >
> > With LLVM_IAS=1, these cases are ruled out.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
