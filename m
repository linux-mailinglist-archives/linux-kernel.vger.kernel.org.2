Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A19540F23B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhIQGWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhIQGV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:21:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F25B06103C;
        Fri, 17 Sep 2021 06:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631859636;
        bh=SUfmlBFiiigTcztXFPQlPQmAAGaznw7fdM5Uf1sxBRI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IgrEbzLPeKZxGTW6apiYzlY5kwC7cFkYgVkzMgv6eJ1z/w9eRyHm7YR+LML8zI71N
         DyXxuPRkX+U8ocM9rA3Q31anXmODGUqYI1R4FAC8k5mfhB8r/SiNabuXhIt/v3RiD6
         YUvopDZs/6KkdQfZEfxa4od9gVDHRhjNrDfjv2scb0F6xQqRqNA+f8e81m5OPQRwrE
         +Z96VmBXJiuK424Pq1aA0nxefd+8IsT/sgZxus9/grM+LqZK1pNWlYlnCOTAxa4bYO
         fpwJjVn6i4gvK7Jt6q0zV6Jq06H8y9ujUDeN8Legp3c3Aio8Y1ihmmNP1nJf3/jqGj
         2qmP8n3AxIAbg==
Received: by mail-lf1-f53.google.com with SMTP id t10so22807865lfd.8;
        Thu, 16 Sep 2021 23:20:35 -0700 (PDT)
X-Gm-Message-State: AOAM530vKzmD5q713QWe4fhPjGV9j4l6YJMQUxJN22wXtNbxKDoZ3oZ8
        cWf6h26D+4o5zk7+ULf4A0FaPJfQbp6pbSQ0mRs=
X-Google-Smtp-Source: ABdhPJz//P1LNmStqogkfYSD37psrQnuLqjbASNi7Y6sSnhKxqRef1aXjg02gQp/3X7AXEpn4KL/QFuILqg0qtxf/kg=
X-Received: by 2002:a2e:750b:: with SMTP id q11mr8099654ljc.172.1631859634334;
 Thu, 16 Sep 2021 23:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210917043838.3514789-1-linux@roeck-us.net> <20210917043838.3514789-2-linux@roeck-us.net>
In-Reply-To: <20210917043838.3514789-2-linux@roeck-us.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 17 Sep 2021 14:20:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQXD0Kz483FK+NT=OS8y0O4XqhZTRDNXJZP=o0T5htJGg@mail.gmail.com>
Message-ID: <CAJF2gTQXD0Kz483FK+NT=OS8y0O4XqhZTRDNXJZP=o0T5htJGg@mail.gmail.com>
Subject: Re: [PATCH 1/3] csky: Select ARCH_WANT_FRAME_POINTERS only if
 compiler supports it
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked, thx. It'll in next-tree.

On Fri, Sep 17, 2021 at 12:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Compiling csky:allmodconfig with an upstream C compiler results
> in the following error.
>
> csky-linux-gcc: error:
>         unrecognized command-line option '-mbacktrace';
>         did you mean '-fbacktrace'?
>
> Select ARCH_WANT_FRAME_POINTERS only if gcc supports it to
> avoid the error.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/csky/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 9d4d898df76b..58ca3ef02bab 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -8,7 +8,7 @@ config CSKY
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_QUEUED_RWLOCKS
> -       select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
> +       select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>         select COMMON_CLK
>         select CLKSRC_MMIO
> --
> 2.33.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
