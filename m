Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875E942CF9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 02:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhJNAqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 20:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229872AbhJNAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 20:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634172279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFv5OLM8EkJT7hF4OqXauqHE4zCaE1+d14pWIYx+RA0=;
        b=NhGvnlj7cHQWsKCkT66xm4vi1U9h7XRZRpebPc06DBwVlj8a5NROSPytkLFibV/juD3qHx
        4rUUQhn64xLRBwl28yfX5e757+GoaSkmhp9YOwtmsoAh59Cwh87p7RKqi98druDi1oChmt
        ZJQx2J08vBkUmuUJ9HZTEvpAMiphz2U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-vLqXvdDHOsiNSTcmEfLYZQ-1; Wed, 13 Oct 2021 20:44:38 -0400
X-MC-Unique: vLqXvdDHOsiNSTcmEfLYZQ-1
Received: by mail-qk1-f198.google.com with SMTP id b189-20020a3799c6000000b0045eb0c29072so3246564qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 17:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jFv5OLM8EkJT7hF4OqXauqHE4zCaE1+d14pWIYx+RA0=;
        b=qXNXb1eW7ycsn4w4rAImDcS7xsZLbpDkM016bk7JcMzTkMYVMxJblxGgLacRsByHO0
         TcuWpqCje7rFg8CJM00UwCjJ8+qrmockkeuBWvergQgCpiCCIHmqTIdnz6b3JlgiS+tx
         +Kz4w21VBY6wpeF2++9gzoFJk3YkEADsEa9i9P4QAgMjeVnLyaCZX0YF9ippQiU495jK
         /f3d5QycBbn48kGk+9HIJ+7caMft6LBBqOqiiiF1SygYoKDGxGRSBcRSVw+czJM3v1Cd
         GbB208SryhkGniwGb72hADms0JTBoGbV9fq1+rXPsZGT4IfOghwGTFy+IduL45+YxSgX
         LwKQ==
X-Gm-Message-State: AOAM533S300zyRLRdQkHS7GpDOuqPREPkF8sLF1siVfjlb0uJdFnTTpZ
        t88miejt/jT1avGJkzMO72I2xhnM6eHfqhqv7rbQthlhf8EDH+ZOSh0cEaT67gNgOiT7ZR7ICi2
        MG3PXmQrYt2yg4/2YhtSzpUZ0
X-Received: by 2002:a37:b742:: with SMTP id h63mr2191203qkf.204.1634172278088;
        Wed, 13 Oct 2021 17:44:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN7hRCKU/SKDN5he5DTJoX8aHISMFYBLbyiwc6It64vOfVpkP2EJr4BFnCIqPmfMZ5NSu/ig==
X-Received: by 2002:a37:b742:: with SMTP id h63mr2191187qkf.204.1634172277891;
        Wed, 13 Oct 2021 17:44:37 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id z19sm701005qts.96.2021.10.13.17.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:44:37 -0700 (PDT)
Date:   Wed, 13 Oct 2021 17:44:34 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 01/15] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <20211014004434.vjbpkd4ykn7upvsw@treble>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-2-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:44AM -0700, Sami Tolvanen wrote:
> The upcoming CONFIG_CFI_CLANG support uses -fsanitize=cfi, the
> non-canonical version of which hijacks function entry by changing
> function relocation references to point to an intermediary jump table.
> 
> For example:
> 
>   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x37e018 contains 6 entries:
>       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000000  0002944700000002 R_X86_64_PC32          00000000000023f0 do_suspend_lowlevel + 0
>   0000000000000008  0003c11900000001 R_X86_64_64            0000000000000008 xen_cpuid$e69bc59f4fade3b6f2b579b3934137df.cfi_jt + 0
>   0000000000000010  0003980900000001 R_X86_64_64            0000000000000060 machine_real_restart.cfi_jt + 0
>   0000000000000018  0003962b00000001 R_X86_64_64            0000000000000e18 kretprobe_trampoline.cfi_jt + 0
>   0000000000000020  000028f300000001 R_X86_64_64            0000000000000000 .rodata + 12
>   0000000000000028  000349f400000001 R_X86_64_64            0000000000000018 __crash_kexec.cfi_jt + 0
> 
>   0000000000000060 <machine_real_restart.cfi_jt>:
>     60: e9 00 00 00 00          jmpq   65 <machine_real_restart.cfi_jt+0x5>
>                         61: R_X86_64_PLT32      machine_real_restart-0x4
>     65: cc                      int3
>     66: cc                      int3
>     67: cc                      int3
> 
> This breaks objtool vmlinux validation in many ways, including static
> call site detection and the STACK_FRAME_NON_STANDARD() macro.
> 
> Fix it by converting those relocations' symbol references back to their
> original non-jump-table versions.  Note this doesn't change the actual
> relocations in the object itself, it just changes objtool's view of
> them. This change is based on Josh's initial patch:
> 
> https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

