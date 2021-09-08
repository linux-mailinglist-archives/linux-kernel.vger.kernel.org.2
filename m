Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B066D40362F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348299AbhIHIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbhIHIgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:36:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A63C061796
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 01:35:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q26so1998175wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+gTvqPkBS/9NQBkBlzTyY1pPZIuXVfqF0gdAjXvmEQ=;
        b=wDveK5lAB6l1NMxSINMMJExaTElhC1Hadv0ygYAfqTxaaYMv3IySUTUjp8bzuOPdRa
         bMndFJRdmVlulEHWcXp/LnteEs6vsNeOY8CT4htoyWxrJ74sTlvSEcRcZYgqmPILmOgc
         A4YtqmDEVblPPqigSHeeg7ICEqSpsHoL+p3C+kiue48QmlrgGL7sE0GJBJTwLjbOXfPl
         zJv9eJtsccvxTHkrB0VgN6p+n3N0t44AZxg77NZHqqyxv0+iSx2wngp0tllluH8IfgqJ
         G3WtqLaUK9i4s9Jzl6JIqkwOmtk7byhNg775DAh2t0Kjhwx/p35yVj+EesJNoCQpB2Rw
         NnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+gTvqPkBS/9NQBkBlzTyY1pPZIuXVfqF0gdAjXvmEQ=;
        b=0cj9erxVya2JOmpEOrx2lKO3ljNW3mmSm/xELkpK28aksQUKtRy0w3mnopFaKwCGbX
         RrlwZ0zVu++bLd0paKbqjfbJblIQO9hkKCioAJO64ZCeIj/w4xO84SqnTFZ/QTdULYj5
         tjy7B00nWkQUCHVNOOgL+DbNzlJEoJhmWeT+3nogbtAdSWkJ4f7y9YkZObzHAA47bocf
         UVyU33xAEb6K3+VrZ7bn5oIaDvKSiEElr34wA4WBO7361h6y58uXncjfgp8XvZ2z2QFy
         B5U8679SXWrb4Sq8nkUm6upqx96v6mLyZah0H82j4JNlcwq9+0zpFJcNgKZV/I2pTV7C
         BUFA==
X-Gm-Message-State: AOAM532/183dlMtbOGkE5ywZdXJZJRPzmTUPTjm9ikUJcEehB+nhpWxX
        2bVPHX1rXZyDeSo8dcNxCeMYL2OIx5LATutMT1hDvQ==
X-Google-Smtp-Source: ABdhPJxnmqEbAAXw4ZZscbrlTqRG8a/a1xTdLDZhNeb4FqiNF0dwRr/GBN9JwQCWTsqYDoM7El3dNiZ090+mHhCE49A=
X-Received: by 2002:adf:d1a8:: with SMTP id w8mr2667202wrc.306.1631090129589;
 Wed, 08 Sep 2021 01:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210907200254.467375-1-vgupta@kernel.org>
In-Reply-To: <20210907200254.467375-1-vgupta@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 8 Sep 2021 14:05:18 +0530
Message-ID: <CAAhSdy018QJ2hdqL2BSZXV81-CVbTf_g6chJSHM4UH2EhLUpCA@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: don't advertise 1 num_asid for 0 asid bits
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 1:33 AM Vineet Gupta <vgupta@kernel.org> wrote:
>
> Even if mmu doesn't support ASID, current code calculates @num_asids=1
> which is misleading, so avoid setting any asid related variables in such
> a case.
>
> Also while here, print the number of asid bits discovered even for the
> disabled case.
>
> Verified this on Hifive Unmatched.
>
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> ---
>  arch/riscv/mm/context.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index ee3459cb6750..c8c6f8831a3b 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -233,8 +233,10 @@ static int __init asids_init(void)
>         local_flush_tlb_all();
>
>         /* Pre-compute ASID details */
> -       num_asids = 1 << asid_bits;
> -       asid_mask = num_asids - 1;
> +       if (asid_bits) {
> +               num_asids = 1 << asid_bits;
> +               asid_mask = num_asids - 1;
> +       }
>
>         /*
>          * Use ASID allocator only if number of HW ASIDs are
> @@ -255,7 +257,7 @@ static int __init asids_init(void)
>                 pr_info("ASID allocator using %lu bits (%lu entries)\n",
>                         asid_bits, num_asids);
>         } else {
> -               pr_info("ASID allocator disabled\n");
> +               pr_info("ASID allocator disabled: %lu bits\n", asid_bits);

May be use:

pr_info("ASID allocator disabled (%lu bits)\n", asid_bits);

for consistency with the ASID enabled case.

Otherwise, it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

>         }
>
>         return 0;
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
