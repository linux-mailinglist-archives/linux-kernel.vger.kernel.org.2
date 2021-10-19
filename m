Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87DD433AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhJSPnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhJSPnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:43:20 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86739C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:41:07 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id u32so4528960ybd.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAz/rf9btWo86AlYRe/ss+IrFPzH4iWnZ+k8+VWp8Q4=;
        b=by51BMJTIeokyM48OQnVX9GSnteOHSgZC4WU5Mgi/G84VEUD0nYOdBQvrPR8o7xC/1
         6veu8zh69CoAJ7if85N8Wd58wgPPbqLfu++KaBvFhZWhFWPJSmEHKafIq2bQRDfKRVkv
         yU2j/67aVTJBnlLMGfFFk9OGsVGgb5IniJkjIAs7MA/Hv1UTFSjBP1jPPKywUQD8Lgmx
         WDOxp6Dug5ka7nrz81imJn/5EUogGdVJp2EJlTQZnrZkjDnGQTNny2CkDl7T5RsYgtCm
         oLkN8Cy1UyUg0e0zFtXV2pOrK9M7VYWFYjg9QbBFkqUXNEuELxhZMjIKebiy9FzUbtKX
         rTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAz/rf9btWo86AlYRe/ss+IrFPzH4iWnZ+k8+VWp8Q4=;
        b=NE8mFu2wShAIwn4cW+orYkd/OhYBKKcajMqxnY4wJssC79piynQGub5x1ifgAquS07
         9Ai9fSHlPmeIqH2rw/9X/iExb8ZX+r6B7XGcRZlt/Q9uZ1n3LSPXpgEmln5nnqK26N56
         IKXM/mkj7jCL7NQKBr7e/cD7+vL8br/Z7ctwGvduWQ+Q+1FieqOMYU9RU/MVGq5NiB/a
         r00/7ObjwqEYSyRh2EpJhVkJRAw44r7qsYaeR7ePxXYObJhM9smNHqXO+iy8HyTbqRxc
         qoNJRmXZjMebbavDDpX0vRMWiS3yT50JAk1YEMRa2Nb0Mbcb5Pqm216+Hp8cU8DSSFnr
         1VOQ==
X-Gm-Message-State: AOAM5331YzowiRSb4hoxivSDNYQSxPge14aI+0vz2tUnZF+MR6nUgcxp
        1I3Z8Mz6t3RAfe2jaJkZyQLGHCENXXqCaDBoJg4qqw==
X-Google-Smtp-Source: ABdhPJyexNDXVxn+DY7LHT3RLwL0rZ454DA3JtCYhuV5jYNPWDlMkYiouMhNYhgvAQ/HLVxcjegylnZajx5Wl0WShIY=
X-Received: by 2002:a25:5b8b:: with SMTP id p133mr36913300ybb.273.1634658066589;
 Tue, 19 Oct 2021 08:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com> <20211019095947.89257-1-alobakin@pm.me>
In-Reply-To: <20211019095947.89257-1-alobakin@pm.me>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 19 Oct 2021 08:40:55 -0700
Message-ID: <CABCJKufjGL9Zq6CDjDOdimu46ZM7Wj0rFNUD-AQrL=Hb81FZfQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:06 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Sami Tolvanen <samitolvanen@google.com>
> Date: Wed, 13 Oct 2021 11:16:43 -0700
>
> > This series adds support for Clang's Control-Flow Integrity (CFI)
> > checking to x86_64. With CFI, the compiler injects a runtime
> > check before each indirect function call to ensure the target is
> > a valid function with the correct static type. This restricts
> > possible call targets and makes it more difficult for an attacker
> > to exploit bugs that allow the modification of stored function
> > pointers. For more details, see:
> >
> >   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> >
> > Note that v5 is based on tip/master. The first two patches contain
> > objtool support for CFI, the remaining patches change function
> > declarations to use opaque types, fix type mismatch issues that
> > confuse the compiler, and disable CFI where it can't be used.
> >
> > You can also pull this series from
> >
> >   https://github.com/samitolvanen/linux.git x86-cfi-v5
>
> Hi,
>
> I found [0] while was testing Peter's retpoline series, wanted to
> ask / double check if that is because I'm using ClangCFI for x86
> on unsupported Clang 12. It is fixed in 13 I suppose?
>
> [0] https://lore.kernel.org/all/20211019094038.80569-1-alobakin@pm.me

No, it works exactly the same in later compiler versions. I also
replied to that thread, but this looks like another instance where
using an opaque type instead of a function declaration fixes the
issue, and probably makes sense as the thunks are not directly
callable from C code.

Sami
