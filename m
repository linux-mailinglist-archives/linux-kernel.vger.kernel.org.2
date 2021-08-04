Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC13DFA36
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 06:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhHDERz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 00:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhHDERw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 00:17:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D8C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 21:17:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so1782602pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 21:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vKtpxFfXXonzxQpVSnSTmoh4P23uDt+JR975j7vzGY4=;
        b=or4MtC5Pa4CHAc3sHN8vhHOBNZECV0NeNG52atUIvJ97vUKZ7iKFlI7i7xyi2oWoCl
         OLZ9Z1MyXwztCijqG5Jjc4zOlgeEeMtkXCqA9JED/mzH0JY3F1oR3EYJCmxag21gKGek
         24xvgcmy2Ke9tggxbTUUqWLns8bFbF1za4wLPM/FwEVUSa2g6U+Thg/IU3R5kdAPou+n
         0CGaRnD5rejAOKudXbqqgJBtsCgWJh/QLXTR3yg9XELegw3OADOY/BRn40MXwJVugREE
         7Gv5yx3UkMy4+0NU9dEpuDDUgoJXg81Igw7QbMICjaMxN6VMLWCGS0VsYK2lTjNZDuaR
         o05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vKtpxFfXXonzxQpVSnSTmoh4P23uDt+JR975j7vzGY4=;
        b=f2us1UO+r5kTGavdHXTHGAGVoEuy48MK2cYSb5ym9emY8pHReilRUxZ2F6p7uWo9qS
         8bC38e4Douq4gCsy+RmavWYNDiz0p2zaNcHiNDGeMB6pcxjecl8fBhXSOvuoges7Q2zM
         q9TwX/meiNwucSxQ8Bn8/rObwe+VVVL3+b+HehvCmDeR7vRcPfSY/uHIq2prHQoLOR1f
         w04SkfUhGPY1IVcn4OZnc+v/JK4vEudL5nLl0ao9ZexaXJEDLI8bktX25F3OQfqzhyn7
         RKCYrmBm5WYe8WWlNbepZmpuOt/AmdFhlDBTzsfj0hzZeIPx+03edo/OK7ft/QnfpYLL
         B+jg==
X-Gm-Message-State: AOAM531R+W7ZHyPgGVoVj5rP3zVh35H/8g7+eW+ymGqYD0U1BpEd/zkv
        S0s7iAwT7kZo8IL5MH+GP5Pigg==
X-Google-Smtp-Source: ABdhPJxT/EuDDdw2vtXk3B6b9kWmMENSSLMKvYVu3SKC68N0WAiRQo8hVGeu4ERHg/s9uOaxjUO/bA==
X-Received: by 2002:a05:6a00:188e:b029:3c3:1142:15f2 with SMTP id x14-20020a056a00188eb02903c3114215f2mr8894882pfh.36.1628050660207;
        Tue, 03 Aug 2021 21:17:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k25sm751605pfa.213.2021.08.03.21.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:17:39 -0700 (PDT)
Date:   Tue, 03 Aug 2021 21:17:39 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Aug 2021 21:13:20 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: Implement thread_struct whitelist for hardened usercopy
In-Reply-To: <20210702045422.3527469-1-tongtiangen@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        tongtiangen@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tongtiangen@huawei.com
Message-ID: <mhng-f83de915-bef2-4624-9e0f-40fa9fd9560b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jul 2021 21:54:21 PDT (-0700), tongtiangen@huawei.com wrote:
> This whitelists the FPU register state portion of the thread_struct for
> copying to userspace, instead of the default entire struct.
>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/riscv/Kconfig                 | 1 +
>  arch/riscv/include/asm/processor.h | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 821081bdb8b8..5c26c0726944 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -70,6 +70,7 @@ config RISCV
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ASM_MODVERSIONS
>  	select HAVE_CONTEXT_TRACKING
>  	select HAVE_DEBUG_KMEMLEAK
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 021ed64ee608..46b492c78cbb 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -37,6 +37,14 @@ struct thread_struct {
>  	unsigned long bad_cause;
>  };
>
> +/* Whitelist the fstate from the task_struct for hardened usercopy */
> +static inline void arch_thread_struct_whitelist(unsigned long *offset,
> +						unsigned long *size)
> +{
> +	*offset = offsetof(struct thread_struct, fstate);
> +	*size = sizeof_field(struct thread_struct, fstate);
> +}
> +
>  #define INIT_THREAD {					\
>  	.sp = sizeof(init_stack) + (long)&init_stack,	\
>  }

Thanks, this is on for-next.
