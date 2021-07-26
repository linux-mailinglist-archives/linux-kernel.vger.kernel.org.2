Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652FC3D5CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhGZOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhGZOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:37:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A8C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:17:58 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w17so15334488ybl.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnAIHyCEItEuPsqof61uC1vm7KM3TYKYc6ro2iKHDXg=;
        b=hI/BOSEapNM5LUyi/PDldZ1uVecFcBW87K3977vgsHD0tPnU7AV5S/PhgciHRXibRj
         /7p6M01gOmceJbzwGolte7Z1IR1fCygYvPDHGzlHTzIqWbzAjEbpzuzN0WckCQYfwxr3
         fOMAlkEPbR1SITKntXjaEwSgyF2ipV0l8fHYiiQqar6nnL8LZXyKz82kXu/+YGF0/afY
         KTvFDi/wFUmnBJj5bmfdJBgHlQ8NLWFwwpqf6xa3YAcgUGbBqTia2lAD+jUEu7owMof6
         FVk2Rrmt0GAZRuipK1J896VhjQSFO8IVLdOs+ACb1wtQ/rR/219pG+ycpu+BrML56aLq
         ATcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnAIHyCEItEuPsqof61uC1vm7KM3TYKYc6ro2iKHDXg=;
        b=SiMwnWiOis4Qa39r2FCbuWf4Q8AMw9EC7mXBAwiIEWqtIK4VLFFJtCt9dEyoevDQaT
         HHVCOekNJQcde9v4BqsNklUCIZUMASRU11/OhdErgzS0/qQ5eOB8ZyKokN0pdoVdRXst
         SSDdvEuMAIOoc8rXEfI22UCWULVHgzlaGleGGYZnfN/DfPLldFeEH7wp94fGWrNfX4K3
         6azlcNbWAxmfgu2mn3YJvvmDsguLdvkzx/z+s0ItJKxOZE3Jc/KiNaHecyWw6jSH3LhA
         +QZ5iVU8iLoXdBlAbKaq6RzDnoNLM+Ughql7ewfNAPnYykYUENlXCnTDzp5in5ENJ7aR
         RMqw==
X-Gm-Message-State: AOAM532TmDKc4aG+LKynpgo0u8S+JCgiN+aInXsp/wvwUvU0h6FNC0HT
        p7ct1pCAzWTxe+vThUeZm+4lib/f04H5UGg6eU0GfA==
X-Google-Smtp-Source: ABdhPJytqHJfIipVuYjGqyN/w0QeLgWzQYKTNIi2X/jMMqdzHFMNf0Ziz1uKTx+NDFlgYmEuEFJJebtgdihu3tYcZm0=
X-Received: by 2002:a05:6902:703:: with SMTP id k3mr3168736ybt.47.1627312676488;
 Mon, 26 Jul 2021 08:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210720221541.16164-1-padmanabha.srinivasaiah@harman.com>
In-Reply-To: <20210720221541.16164-1-padmanabha.srinivasaiah@harman.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 26 Jul 2021 08:17:45 -0700
Message-ID: <CABCJKuecCch5v32GJ8Bt9wEJOWtp2aYanRT7qdrD6BHx5qDRNw@mail.gmail.com>
Subject: Re: [PATCH] tracing/syscalls: Clang cfi enable syscall events
To:     treasure4paddy@gmail.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 20, 2021 at 3:16 PM <treasure4paddy@gmail.com> wrote:
>
> From: Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>
>
> With clang cfi syscall symbols are appended with <syscall>.cfi_jt,
> hence syscall tracer can not find corresponding syscall name.
> And results in no syscall ftrace events with CFI.
>
> To fix this issue, this introduces custom cleanup_syscall_symbol_name()
> to strip postfix ".cfi_jt" before comparing syscall and symbol name.
>
> Signed-off-by: Padmanabha Srinivasaiah <padmanabha.srinivasaiah@harman.com>
> ---
>  kernel/trace/trace_syscalls.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 8bfcd3b09422..dbc253fea34d 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -79,6 +79,27 @@ trace_get_syscall_nr(struct task_struct *task, struct pt_regs *regs)
>  }
>  #endif /* ARCH_TRACE_IGNORE_COMPAT_SYSCALLS */
>
> +#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> +/*
> + * For a syscall symbol, clang generated non-canonical local jump tables
> + * will have entry as <syscall>.cfi_jt and address of this entry
> + * will be used to replace references to the syscall symbol.
> + * so we will strip the postfix from appended symbol name.
> + */
> +static inline bool cleanup_syscall_symbol_name(char *s)
> +{
> +       char *res;
> +
> +       res = strrchr(s, '.');
> +       if (res)
> +               *res = '\0';
> +
> +       return res != NULL;
> +}
> +#else
> +static inline bool cleanup_syscall_symbol_name(char *s) { return false; }
> +#endif
> +
>  static __init struct syscall_metadata *
>  find_syscall_meta(unsigned long syscall)
>  {
> @@ -90,6 +111,7 @@ find_syscall_meta(unsigned long syscall)
>         start = __start_syscalls_metadata;
>         stop = __stop_syscalls_metadata;
>         kallsyms_lookup(syscall, NULL, NULL, NULL, str);
> +       cleanup_syscall_symbol_name(str);

Shouldn't this happen in the kallsyms code instead? We already have
code there to clean up function names, and it seems like we should
just strip the postfix there before returning the name.

Sami
