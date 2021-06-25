Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A553B3A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhFYBQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 21:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYBQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:16:00 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF63C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:13:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id b13so2184159ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0qxPupN9xX/MROlm0ElwGrjb5EkmD1HQYEar67dhfI=;
        b=hwkuEQ2r8MR2kHEr6g1h2AShp6uH/l/GCyQbl49/Gewht8ybadsKlpismJSo/PWUnB
         TaNHucid+KA7ArBKvpXzshBRDuNCDpoEan4pE4q9e/6FsBHRAdRjs/KULZUQI1xTEmmO
         6IoQ6crJ2WFxWajWoRZ/1X17b0Va0/s9oyeqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0qxPupN9xX/MROlm0ElwGrjb5EkmD1HQYEar67dhfI=;
        b=sKuy1QSjtcGBU2YYQbf7mIpx5io1Yyv5r23V9G0O6tkJcbqyGb/zx/QY8XaAVwXuHy
         TZYpM8qFvhf8rlmJSs/nhz0v9mu+4IDQBK69IQ3FH9wE13Lnx8oyDFXJa492D2N2fRXF
         w3jH1Xm4LLyN/zUt/iUmZd7ixPja1i19FR3v7n4SrEV+FSyTOwOivV6CKbA5AXAt6g72
         XYGk1S5QG6clKw4hnZXRBn32txGhi2cffQM7DCCFbDb3/0AvcsvWYYiIAY3CuX2/ObhY
         xocRwePQNXmCChWwR5bGSJJ2LONH/SYORJwaERz7KLljJKJJyQ5GvZR1MDUtJqvqAwt6
         sHMw==
X-Gm-Message-State: AOAM5304Di+vDW/pUbz4vHDoA31XQ5dNA0XdtWUd4WITfhEqA3aTs2xW
        bknzjRG9EXL0HHRxXJi5rh7acwikm5L4uQrqRm7l
X-Google-Smtp-Source: ABdhPJzoBF4yGGMmhwSDKtModRaqahZE7MGrEAmJq3wCwKyrjPsk2UTSEtdsH614PTd6ptQ4SfJ/oZ3iXkBzsnxKchs=
X-Received: by 2002:a25:3bcb:: with SMTP id i194mr8486526yba.442.1624583618557;
 Thu, 24 Jun 2021 18:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210624120041.2786419-1-alex@ghiti.fr> <20210624120041.2786419-2-alex@ghiti.fr>
In-Reply-To: <20210624120041.2786419-2-alex@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 24 Jun 2021 18:13:27 -0700
Message-ID: <CAOnJCUKs-75Vd_Wmp_X5Wdf-5UPfXD3GzFnuDb8FjtT2WcFybg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] riscv: Introduce set_kernel_memory helper
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 5:02 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This helper should be used for setting permissions to the kernel
> mapping as it takes pointers as arguments and then avoids explicit cast
> to unsigned long needed for the set_memory_* API.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/include/asm/set_memory.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 9d4d455726d4..96e317dcab13 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -17,6 +17,16 @@ int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
>  int set_memory_rw_nx(unsigned long addr, int numpages);
>  void protect_kernel_text_data(void);
> +static __always_inline int set_kernel_memory(char *startp, char *endp,
> +                                            int (*set_memory)(unsigned long start,
> +                                                              int num_pages))
> +{
> +       unsigned long start = (unsigned long)startp;
> +       unsigned long end = (unsigned long)endp;
> +       int num_pages = PAGE_ALIGN(end - start) >> PAGE_SHIFT;
> +
> +       return set_memory(start, num_pages);
> +}
>  #else
>  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> @@ -24,6 +34,12 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  static inline void protect_kernel_text_data(void) {}
>  static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
> +static inline int set_kernel_memory(char *startp, char *endp,
> +                                   int (*set_memory)(unsigned long start,
> +                                                     int num_pages))
> +{
> +       return 0;
> +}
>  #endif
>
>  #if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
