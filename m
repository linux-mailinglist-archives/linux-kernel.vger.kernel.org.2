Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE27340D71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhCRSoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhCRSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:43:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C1AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:43:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m12so6171215lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nO1NtgEydXG2HLjdhqcJj5jPeQtrUPiYrY1ZDV7Qq/s=;
        b=iVhfN+7riOgr03gvFp6rabJN8XblDjHGtyOGptCHZxdhiECWH17xolvbVqxD61vi5I
         j7wFaX5OK16XDA5OTljEBtUkLE2p3wAIHOYdcH8ygbsif54rpWGXfnIWvKORxYc4UJ1w
         6dpCNm4hA+O3GYVYuNboKJbPCS8Oh2iWIqDuNjVnnqHZcMpWEB+u61udXs5p4zIplHiH
         CBdgrX3qELlJwkMMudYSduN4JtzCQ0guTsDLtI6hfWhmcv5TSoKkA2uF2dne+wk64bzA
         vhgHY9WcBAhuoxiLklXUyWlxBSx7Duidr12ctcSGZeFqB3A/j6mB7xOZA+MdIuSjYEd1
         X7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nO1NtgEydXG2HLjdhqcJj5jPeQtrUPiYrY1ZDV7Qq/s=;
        b=BqnekJhF9rEcfUZjnAYK3MsJxqIvDpjjgSEm475SH+onCnni9U1y0HdhSVZp3bTS7F
         4Ym+t2sujWVUn7v/+Ekux1z7v2mDI9QTCLjAdZkD3kvmfZsuLTfRvt2N/cFnsIPnVhQG
         sUYltSQr9O0OMpFyhHa0mfKthAwiWLq/DvkK/n1axJYjAKxFMlIkPLMVFXCkY1hauD9s
         ZX3Yv2dJu5A8DCklPg0Nx12qyNpLjL9YRvIzoIYtIS6gAvgrFnbs+8S67zPO1PE3GO68
         fmGA4SH+IJKQfbQOCiIXdHx2GksF7z7WQ+AUJy6ihoGBFJ1BMrNT/skxmFxxZDe6lLmq
         qrIw==
X-Gm-Message-State: AOAM531O8/MHRLDI0Dqrjk/OjOch659G5HmMffhuRp/w/iJtmdJTkJP/
        kq79CMdexRWdG6XZC0LLOwZNCKn+6tomDhoCtlaU9Q==
X-Google-Smtp-Source: ABdhPJwPMFefAwqyWlFWcoKbDZciOiKnXiRQmrMNGrG6rw2lNtQsSLGJF3SwnZ8fBikFCSYXYvEuLtpI1LrMEMs5+eI=
X-Received: by 2002:ac2:532c:: with SMTP id f12mr6587813lfh.73.1616093021734;
 Thu, 18 Mar 2021 11:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com> <20210318171111.706303-11-samitolvanen@google.com>
In-Reply-To: <20210318171111.706303-11-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 11:43:29 -0700
Message-ID: <CAKwvOdkn7MY+-9D0DQ-18OR=s1XmgPaP7VchCm6VV5kYuKSAkA@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] lkdtm: use __va_function
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> To ensure we take the actual address of a function in kernel text, use
> __va_function. Otherwise, with CONFIG_CFI_CLANG, the compiler replaces
> the address with a pointer to the CFI jump table, which is actually in
> the module when compiled with CONFIG_LKDTM=m.

Should patch 10 and 12 be reordered against one another? Otherwise it
looks like 12 defines __va_function while 10 uses it?


>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/lkdtm/usercopy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
> index 109e8d4302c1..d173d6175c87 100644
> --- a/drivers/misc/lkdtm/usercopy.c
> +++ b/drivers/misc/lkdtm/usercopy.c
> @@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
>
>         pr_info("attempting bad copy_to_user from kernel text: %px\n",
>                 vm_mmap);
> -       if (copy_to_user((void __user *)user_addr, vm_mmap,
> +       if (copy_to_user((void __user *)user_addr, __va_function(vm_mmap),
>                          unconst + PAGE_SIZE)) {
>                 pr_warn("copy_to_user failed, but lacked Oops\n");
>                 goto free_user;
> --
> 2.31.0.291.g576ba9dcdaf-goog
>


--
Thanks,
~Nick Desaulniers
