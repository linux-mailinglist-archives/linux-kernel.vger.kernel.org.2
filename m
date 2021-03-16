Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDF33DC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhCPSDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhCPSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:01:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126A3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:01:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a1so21671580ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBDcxnmnlcdmGNIzAX9LfTHLUlQAJdWJ9myTmotHrI4=;
        b=f9LBS+K0WNsomlx8fjcuF9nm4FhTtT/JNtnRxNvXnRUnt+CHQD47qxSrxFKf1sKuuh
         SrvV6anjfLUaUg4sBpUAqyk/ShuO7R8vZnHODa58AR5pZIhLZhKt4+Mm3gJ7r/EX8eSK
         9RByvVNrw7wDysImHeeqInO9GGJ+9HX9giQnTgpHh75NcQAESI0Gst6iIILMC9TFtYrJ
         vyq5/vf4QNRhzNtSvp8e2Kt3W4TpqfWqXj0Y1xKLd5CfHuaXE0n9odi70O0itAFO+3P1
         5oWb/0fuV0bpGVKA7RtwNlOktmYNkvYr0Q/1apNZ4+HdV9dW0mQ/XDFvR4rrYOOpXsBB
         75cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBDcxnmnlcdmGNIzAX9LfTHLUlQAJdWJ9myTmotHrI4=;
        b=CqanShUYOmo9UpJKebLIwJ+i9PQ9XRGbO9kB0MiJ4IySEUbWuPXNtsVVKHVXZLsHYE
         /kfQjtw8TzIveHY1pPyRb7U7NVUMWB16lE94ARm+jSbC/Ma+uboJgy9jw6c4se+BLQm/
         zzLk9iKVsRD1Jis/95lKCCkFl3yeOlcXoJjZgrfkI3wrglJ1x5VWDy7ahcIooBQWtfIy
         ++CQYGTRI9se49M5Spv0g8JrZmAXDTAhZV7HLdhBokRK5uE9jIleyRx8rb9KxxlOX4uZ
         extTryblQPkIN8b2ZTpfkCBBBRRZuo55Zlwt1l9IGDVBZ41KxbNkL5181eTpGeEWARC/
         A48A==
X-Gm-Message-State: AOAM5335rnrUJB7W2HvQOe9PKL2qpRtej11cZ80e1SakEw03URTBtK/6
        OL6LKVAHivYl8psAUdOWe2pev8tYv0uXzYu0OynLQw==
X-Google-Smtp-Source: ABdhPJw82JldT5/m8o79tV/4+uSZJd9u12QWonMBRW9Vb4pH41u1t2LMv2moA8UqvsPAS9U2tGFCDwAJ/nvlLbVoGqA=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr3505791ljj.116.1615917695303;
 Tue, 16 Mar 2021 11:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210316171347.14084-1-rppt@kernel.org>
In-Reply-To: <20210316171347.14084-1-rppt@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Mar 2021 11:01:24 -0700
Message-ID: <CAKwvOdn1DBXPfYRFSPwgnaXG-h73cmp2L4uYFBAPP4+yOKoqow@mail.gmail.com>
Subject: Re: [PATCH] memblock: fix section mismatch warning again
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:13 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Commit 34dc2efb39a2 ("memblock: fix section mismatch warning") marked
> memblock_bottom_up() and memblock_set_bottom_up() as __init, but they could
> be referenced from non-init functions like memblock_find_in_range_node() on
> architectures that enable CONFIG_ARCH_KEEP_MEMBLOCK.
>
> For such builds kernel test robot reports:
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> >> WARNING: modpost: vmlinux.o(.text+0x74fea4): Section mismatch in reference from the function memblock_find_in_range_node() to the function .init.text:memblock_bottom_up()
> The function memblock_find_in_range_node() references
> the function __init memblock_bottom_up().
> This is often because memblock_find_in_range_node lacks a __init
> annotation or the annotation of memblock_bottom_up is wrong.
>
> Replace __init annotations with __init_memblock annotations so that the
> appropriate section will be selected depending on
> CONFIG_ARCH_KEEP_MEMBLOCK.
>
> Link: https://lore.kernel.org/lkml/202103160133.UzhgY0wt-lkp@intel.com
> Fixes: 34dc2efb39a2 ("memblock: fix section mismatch warning")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thank you Mike.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> @Andrew, please let me know if you'd prefer this merged via memblock tree.
>
>  include/linux/memblock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d13e3cd938b4..5984fff3f175 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -460,7 +460,7 @@ static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
>  /*
>   * Set the allocation direction to bottom-up or top-down.
>   */
> -static inline __init void memblock_set_bottom_up(bool enable)
> +static inline __init_memblock void memblock_set_bottom_up(bool enable)
>  {
>         memblock.bottom_up = enable;
>  }
> @@ -470,7 +470,7 @@ static inline __init void memblock_set_bottom_up(bool enable)
>   * if this is true, that said, memblock will allocate memory
>   * in bottom-up direction.
>   */
> -static inline __init bool memblock_bottom_up(void)
> +static inline __init_memblock bool memblock_bottom_up(void)
>  {
>         return memblock.bottom_up;
>  }
> --
> 2.28.0
>


-- 
Thanks,
~Nick Desaulniers
