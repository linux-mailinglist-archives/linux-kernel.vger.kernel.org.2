Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0FD397A98
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhFATUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbhFATUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:20:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:18:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f12so20783066ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvgn/sxx7fGdQ0zzgT5kUctxtrwYDVPpVuGOvB0eRkA=;
        b=pqfGVO0rokdZUODQi3AfTBRhuEcIua1lvBvXpame6DPSE4q2YkVue74W6/3vNeKk2o
         uNhHpTK01zPwMuAsDr6x6qY1gUny7sCnZlAvs9Y4FN0Kfz/PIA0mWQAtP47f+llLIYI2
         R66XJneli7t4gptoOzeLjN0SMTFCwDxA5aMfQFBavmjOkzY/1c1QqtIZpTXtx9H0pCmy
         dqQE8MqfnXye6Setz6mXtDFdQ3ALtvBegeDzRX0R35oT73hcf1KVPgIJH7OFrkZ4QQRW
         iFBCR1hawZI/d1/aDsLRKxaOhAD0DbDO1DnReU4ncqhTPKv0PwJST4e3hQ5y+w2nThrc
         lf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvgn/sxx7fGdQ0zzgT5kUctxtrwYDVPpVuGOvB0eRkA=;
        b=Si9+ZV5Uzv719EddUj+Pyt9nrODekhnBOnoESYVgApWtb/4Y26C9QLRvLPoBhnuHdC
         U9ezzFhwKTGk8VXqIqacO91zr8m1yfcdPB4piaJtiawmVaMO1oHS2ZhHXX0yJ7xzYLuZ
         /ZjlMnwp9o37/hpoL+79DkBQ6fjopegIUFiRIWkkUf3BM8nPGnitJy9uNFDiK8NTmEM5
         QjKpre1N4/7U9dy1K5Vy4TLvsKYiLnndabpb/P5OKhN1b6u62TsZlS0bHAYQGdSlr5Ff
         5qyYTnsSYYveEnEytN+sxh2P+nXufQmVh6E5der1d7DNNRiKHSRkBYT68LIRcja2AWZN
         PjmQ==
X-Gm-Message-State: AOAM533MPDZgycJrMXNj1K76EXJb2IWRIUJp/mxGwCDwbuLF8XDRkxzf
        KeQpx05gtMsNI9IIfdaEFcaUOVYaI0qI2tKDf2gssg==
X-Google-Smtp-Source: ABdhPJyhQlLrytV5dgDlFpCtB6Ap0nEb9KGGhzv4syOgIhxsroyMbjsLF32tXLxIQxkd0/ApMUPRLgfBTpKAmpRFTew=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr8516566ljg.341.1622575126992;
 Tue, 01 Jun 2021 12:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-3-nathan@kernel.org>
In-Reply-To: <20210521011239.1332345-3-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Jun 2021 12:18:35 -0700
Message-ID: <CAKwvOd=T9HTUXETv2EJit0Qa8+p7NhTxcfZ3FYqy1xu--GNkgA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hexagon: Use common DISCARDS macro
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 6:13 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> ld.lld warns that the '.modinfo' section is not currently handled:
>
> ld.lld: warning: kernel/built-in.a(workqueue.o):(.modinfo) is being placed in '.modinfo'
> ld.lld: warning: kernel/built-in.a(printk/printk.o):(.modinfo) is being placed in '.modinfo'
> ld.lld: warning: kernel/built-in.a(irq/spurious.o):(.modinfo) is being placed in '.modinfo'
> ld.lld: warning: kernel/built-in.a(rcu/update.o):(.modinfo) is being placed in '.modinfo'
>
> The '.modinfo' section was added in commit 898490c010b5 ("moduleparam:
> Save information about built-in modules in separate file") to the
> DISCARDS macro but Hexagon has never used that macro. The unification of
> DISCARDS happened in commit 023bf6f1b8bf ("linker script: unify usage of
> discard definition") in 2009, prior to Hexagon being added in 2011.
>
> Switch Hexagon over to the DISCARDS macro so that anything that is
> expected to be discarded gets discarded.
>
> Fixes: e95bf452a9e2 ("Hexagon: Add configuration and makefiles for the Hexagon architecture.")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/hexagon/kernel/vmlinux.lds.S | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
> index 20f19539c5fc..57465bff1fe4 100644
> --- a/arch/hexagon/kernel/vmlinux.lds.S
> +++ b/arch/hexagon/kernel/vmlinux.lds.S
> @@ -61,14 +61,9 @@ SECTIONS
>
>         _end = .;
>
> -       /DISCARD/ : {
> -               EXIT_TEXT
> -               EXIT_DATA
> -               EXIT_CALL
> -       }
> -
>         STABS_DEBUG
>         DWARF_DEBUG
>         ELF_DETAILS
>
> +       DISCARDS
>  }
> --
> 2.32.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
