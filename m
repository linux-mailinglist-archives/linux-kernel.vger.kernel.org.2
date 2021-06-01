Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22D3978B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhFARKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFARJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:09:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B80C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 10:08:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e2so20263684ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iyHaQ7eusXLRjtFERBUVZNb8xaPVSBCRT0/y8uyn4c=;
        b=Pvzi2RTs0xv8RthXQbDip89Ark+YPqTkuESnir8GjsIwSzhAbzowZu2Larpe0AnxKV
         HXxFFINhALJDRN0kadRjv2EEBoB5u9sQCtFhueOf3CA8PbCTHUcudTzn4dkLiuKrlOoO
         Msvb5ckElaH+KPKY/9H+8LleppOMQoD4G2aCLfO2bd9/ICidJDlHJGzNNHOk+PUtX94C
         NUGDJZ2fsa3Ah6Z0yxWOavAYlJlKZKQBOP6sU+2QVj/qFIVIjujg/3s3eDnxs43d5AwB
         lpiuPCo83EijwetzaArrZXHlWafFZhch+yADPktNJrrpE2zHwL8HxtiHfazyZt5l40f+
         jmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iyHaQ7eusXLRjtFERBUVZNb8xaPVSBCRT0/y8uyn4c=;
        b=A14MGJ8ywMEIJDPHckL9DAQMcY44dGefic/t1bOx/mFmrm0I7n9i+FhwV5dfaF7O9r
         RK7r4L76K9bkxSfDrZzKZ3yZr+hnsvIpt9+/gbaItRcWF9qImZq8V4n/JqiNlOKegkEi
         8E6JkjB8DGecsA/h9v9F2UjdIfkZZzxJMhy3EuLuFm+eL0mr3Yp1P51NcJIzXEgCiK6v
         T1XheLdzwpMlr8ictxEVkv6pPv473ynSQQbN7zOMg4+TAEYnWljf62KXptPsE0YQhWtc
         IC5A85E1NWYEunp2GpM/YyyaL1Kpxj6Dua/Cl6oluZBnf8RF/l+SWHNjyVSecpsNppac
         TEww==
X-Gm-Message-State: AOAM532kvvdREnmv6rkpNIqn/JNtgvBjp985qta0kBh4PPGyV0+Z2TOQ
        m8EegsWbJUsVJi30uTguPz8uuGLMYmblh5I61c5VlA==
X-Google-Smtp-Source: ABdhPJzl+Cl1UbXSRojpUksElwA1wE+1Ml5ttKnLUWhHUb0qH+JifNvIbHgqpsnxYsuVO3AECPVQnwJ/moldgfTgCmY=
X-Received: by 2002:a2e:b0f2:: with SMTP id h18mr11079691ljl.244.1622567295431;
 Tue, 01 Jun 2021 10:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210531205405.67993-1-nathan@kernel.org> <20210531210629.864888-1-nathan@kernel.org>
In-Reply-To: <20210531210629.864888-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Jun 2021 10:08:04 -0700
Message-ID: <CAKwvOdkwKc5opVXUAVxehDCGfgidhEr2LH4LQaS-HUSk7gQk1g@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add Clang CFI section
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 2:06 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Sami is the primary developer and Kees has been chauffeuring the patches
> to Linus so ensure they are always kept in the loop about proposed
> changes to these files. Add Nick and I as reviewers so we are CC'd as
> well.
>
> Fixes: cf68fffb66d6 ("add support for Clang CFI")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2:
>
> * Add "git " in front of the "T:" entry to match the rest of MAINTAINERS
>
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 008fcad7ac00..4ddf370572d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4436,6 +4436,18 @@ F:       include/linux/compiler-clang.h
>  F:     scripts/clang-tools/
>  K:     \b(?i:clang|llvm)\b
>
> +CLANG CONTROL FLOW INTEGRITY SUPPORT
> +M:     Sami Tolvanen <samitolvanen@google.com>
> +M:     Kees Cook <keescook@chromium.org>
> +R:     Nathan Chancellor <nathan@kernel.org>
> +R:     Nick Desaulniers <ndesaulniers@google.com>
> +L:     clang-built-linux@googlegroups.com
> +S:     Supported
> +B:     https://github.com/ClangBuiltLinux/linux/issues
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
> +F:     include/linux/cfi.h
> +F:     kernel/cfi.c
> +
>  CLEANCACHE API
>  M:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>  L:     linux-kernel@vger.kernel.org
>
> base-commit: 24845dcb170e16b3100bd49743687648c71387ae
> --
> 2.32.0.rc0

-- 
Thanks,
~Nick Desaulniers
