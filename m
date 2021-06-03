Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B977399FE9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFCLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:38:43 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33318 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFCLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:38:43 -0400
Received: by mail-wr1-f48.google.com with SMTP id a20so5543657wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUWQYY6cwXoInPRfC/THU59jRaVeDOI2+m6C3p5kdkg=;
        b=2POa4/DxL3JRww/m2F5CWyfeZDJIbslwiPuE4VWvkdtk0v8fJgU1idUSWF09zSdpqi
         mfwRoAXiRBkv20g32UdgxUkb4qcetzXTquQ8NNgFNiJ3rAkXvcH6/zZQwTXMNrEzeqZT
         U4Kwg5Za/uNzxxBdM3YExgc3L+pw9b6Pdff0cZN6hoNxJCAq+nq/UrHgBBooW0OJUl6d
         N1qIh3w0wFmBIRnlQNtR+W5kiSUb/Af1wZxa1gaAeTg/SLrqidOB8vkIrxg8u8iAC9E6
         ikNQoeiEaIBi+iVyUg1vJqXQnX6vPxVRJI6WaNABewvgqrctE0clhGEdUtbSbIyk4sPE
         aXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUWQYY6cwXoInPRfC/THU59jRaVeDOI2+m6C3p5kdkg=;
        b=Fl39BfXuMFkxC1qq8N03KSfI2y/7H/JYdq7uQRHAwdFXZ9A29qa8wTz4dlALARdZrw
         7/a1efDPmL+IL7VIdn+9uyrSBcKa0QoLDGGoa4cOJIT9YemIZB5nop8u2kiNFfPaQfoX
         MtdM+P0m4p1tHZIjoz2sAzFI0tM/LGpyuGcSXihnmYLmWPLKS+l+Lackyk/z1BO7q3cT
         Yjtb1uFW3bcrqy9xJdMaJg0VtuTnmZXjiwr8JTzcQO/7K/DtqNW9NZw7xaH9N+fLicHc
         5yqtYZ4AR04xNeZX6ubHkC2HM2+lvPkR0gKWdoquxAiZlVWl+67tNyRthKhPFYPq+RgT
         Tqpg==
X-Gm-Message-State: AOAM531gEt8F9Fg9dez2w37pgV6gz1denigz8XKv7hRIkPeqYrUOQqP/
        7FhHwGj/1JljSk+GW1uBwO75DdGb3h7ivF2tQGindg==
X-Google-Smtp-Source: ABdhPJyIhL6hTINCWDRrrSltrfTkfJaKF204Cw9/Y/5S0gfYKtqafpFSdqhlMdgytjfSJIu53WXZwcV8KyjqDBS+V5E=
X-Received: by 2002:a5d:540b:: with SMTP id g11mr11167932wrv.390.1622720157797;
 Thu, 03 Jun 2021 04:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210603082749.1256129-1-alex@ghiti.fr> <20210603082749.1256129-3-alex@ghiti.fr>
In-Reply-To: <20210603082749.1256129-3-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 3 Jun 2021 17:05:46 +0530
Message-ID: <CAAhSdy0w4DsGMdWZ3k2Qti0mwQQmFXHbJw2RXbjH+hQ8fPKxfQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] riscv: Introduce set_kernel_memory helper
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 2:00 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This helper should be used for setting permissions to the kernel
> mapping as it takes pointers as arguments and then avoids explicit cast
> to unsigned long needed for the set_memory_* API.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/set_memory.h |  5 +++++
>  arch/riscv/mm/pageattr.c            | 10 ++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 086f757e8ba3..7a411fed9e0e 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -16,6 +16,7 @@ int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
>  int set_memory_rw_nx(unsigned long addr, int numpages);
> +int set_kernel_memory(char *start, char *end, int (*set_memory)(unsigned long, int));
>  void protect_kernel_text_data(void);
>  #else
>  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
> @@ -24,6 +25,10 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  static inline void protect_kernel_text_data(void) {}
>  static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
> +static inline int set_kernel_memory(char *start, char *end, int (*set_memory)(unsigned long, int))
> +{
> +       return 0;
> +}
>  #endif
>
>  #if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 5e49e4b4a4cc..c47ac6a432ac 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -156,6 +156,16 @@ int set_memory_nx(unsigned long addr, int numpages)
>         return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
>  }
>
> +int set_kernel_memory(char *startp, char *endp,
> +                     int (*set_memory)(unsigned long start, int num_pages))
> +{
> +       unsigned long start = (unsigned long)startp;
> +       unsigned long end = (unsigned long)endp;
> +       int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
> +
> +       return set_memory(start, num_pages);
> +}
> +
>  int set_direct_map_invalid_noflush(struct page *page)
>  {
>         int ret;
> --
> 2.30.2
>
