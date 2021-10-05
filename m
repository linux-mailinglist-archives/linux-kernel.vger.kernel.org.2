Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F033A421B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhJEAhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJEAhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:37:33 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A05DC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:35:43 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id 64so13674065uab.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0l5p0oE25SqlRLFMCCo2EWRTCPhDAqiXcOcdg7xVq1M=;
        b=ejuDgM8fmefZMUg3Jx2LeaRwi6b9kq8lSJKUxN8jCsFqiTUmXH3Svzmal9VU5eVFum
         Zg7tuD/lrSRPLUFFQTVcqjkO5q8zL4TA4a2zz8IgPZCArY7VUWYbxEF49COMMoP0nkTM
         teh8alqCaTTktQL69QAezC/jeF+DfIxnp0SEWUVbogUrB13IIBCmXbS3bRgLN9OxfRu4
         pNXAozDqp0gt/aO3BFvj6AvvkkuzwTOJWYXaP6J5fl0eptabu8o2uk+pW30JXyBK6bcM
         2gshRIWzj2LaRUMVRSXSh0LSxG8uHN8xqYY6iwU9jeAvs7Ogt9aIf/rEKhY83mDwm/HR
         0fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0l5p0oE25SqlRLFMCCo2EWRTCPhDAqiXcOcdg7xVq1M=;
        b=S5Kk3EXVNHnlq0npnMGoKMb7htOvLKWd0/eDy1x5MyS2FtgrUgvoYTNOjURKClDp1M
         jfOBhvLoiq8RWKbMgna6NI8GK7r/K+71RTpfmFTCR+fcnwe2driS8u0anyCS1fT21oNW
         /3c3A8v5cRdiQ5jcUyfJU13ScQHVbA/RH6dIczNIhBo85s27CBuBd+5Yto+FBn6lW+Ex
         zwmhYvlx1fsPaBPPxS5DoQe2RkPmsOu6CF42zlzgWWDIIV0QfMslqoG1+C1NvHfpno/G
         q6Zj/WFU3h5vtmUXMNFWXZk04D39sX2L9JKvtt3nqnvBYlSC/odL/Dw6lQ4AQZFjOJii
         72Cg==
X-Gm-Message-State: AOAM533e/ktWvOZ5rdkWMFhOjMVQ+pB1K+5/b9D4/7ZqDr3n7b6YVWxG
        HjKgacIhHRSY1t04fyazJHOBlQ==
X-Google-Smtp-Source: ABdhPJwwCbODZAmdlHTct0WG9V3q+5xFprMFyk6J4nicYFya2JLGnSGHMjclaFE/ckmqCOs8CKTF1w==
X-Received: by 2002:ab0:4a9d:: with SMTP id s29mr10047253uae.104.1633394142354;
        Mon, 04 Oct 2021 17:35:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o3sm7542542vsc.26.2021.10.04.17.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:35:40 -0700 (PDT)
Date:   Mon, 04 Oct 2021 17:35:40 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Oct 2021 17:35:36 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Include clone3() on rv32
In-Reply-To: <20211004111758.rl2zq6l575hmcv22@wittgenstein>
CC:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, christian@brauner.io,
        linux-kernel@vger.kernel.org, kernel-team@android.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     christian.brauner@ubuntu.com
Message-ID: <mhng-73210076-6df9-44e7-8c1a-09ced50fe4c0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Oct 2021 04:17:58 PDT (-0700), christian.brauner@ubuntu.com wrote:
> On Sun, Oct 03, 2021 at 05:30:24PM +0200, Arnd Bergmann wrote:
>> On Sun, Oct 3, 2021 at 2:58 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >
>> > From: Palmer Dabbelt <palmerdabbelt@google.com>
>> >
>> > As far as I can tell this should be enabled on rv32 as well, I'm not
>> > sure why it's rv64-only.  checksyscalls is complaining about our lack of
>> > clone3() on rv32.
>> >
>> > Fixes: 56ac5e213933 ("riscv: enable sys_clone3 syscall for rv64")
>> > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> We should probably reverse the polarity of this symbol and force
>> architectures that don't implement it properly to say they don't
>> have it, but for now, it definitely makes sense to treat this the same
>> way on 32-bit and 64-bit risc-v.
>
> I think we had that discussion back when I added it and I think I even
> proposed that or you did but then we settled on __ARCH_WANT_SYS_CLONE3.
> Most likely because it fell in line with the other
> __ARCH_WANT_SYS_{CLONE,FORK}.
>
> I think at this point its alpha, ia64, nios, sparc, and sh that don't
> implement it. For some it looks trivial at first glance at least (Fwiw,
> nios implements sys_clone() but doesn't select __ARCH_WANT_SYS_CLONE3):
>
> diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
> index 0b4bb1d41b28..6c4f45abd3ab 100644
> --- a/arch/nios2/include/uapi/asm/unistd.h
> +++ b/arch/nios2/include/uapi/asm/unistd.h
> @@ -18,6 +18,7 @@
>
>   #define sys_mmap2 sys_mmap_pgoff
>
> +#define __ARCH_WANT_SYS_CLONE3
>  #define __ARCH_WANT_RENAMEAT
>  #define __ARCH_WANT_STAT64
>  #define __ARCH_WANT_SET_GET_RLIMIT
> diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
> index 0794cd7803df..c1804bda8259 100644
> --- a/arch/nios2/kernel/entry.S
> +++ b/arch/nios2/kernel/entry.S
> @@ -396,6 +396,15 @@ ENTRY(sys_clone)
>         RESTORE_SWITCH_STACK
>         ret
>
> +/*
> + * int clone3(struct clone_args __user *, uargs, size_t, size)
> + */
> +ENTRY(sys_clone3)
> +       SAVE_SWITCH_STACK
> +       call    sys_clone3
> +       RESTORE_SWITCH_STACK
> +       ret
> +
>  ENTRY(sys_rt_sigreturn)
>         SAVE_SWITCH_STACK
>         mov     r4, sp

Thanks.

I've put this on fixes, but if you're trying to do that refactoring I've 
merged it in as a single patch on top of 5.15-rc1.  That's on 
palmer/riscv-clone3, in case it helps someone avoid a conflict when 
doing that refactoring.  I'd usually offer to do the refactoring, but 
I'm super buried right now with all the RISC-V stuff ;)

I want to call this fix because it's breaking my builds, these 
checksyscall warnings have recently turned into errors.
