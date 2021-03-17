Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2433E89D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhCQE5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCQE4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:56:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:56:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so2556985pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=kNYiVBd1cBCop/nrtBQYXoofnHMlkqLGb5kuKDRfR4g=;
        b=rkmJjRKSwf7e15UE78TMTFXqP3y7u7jqpwes0ZtS4DmiApHjc62VD1ZLB6eoXSQRhH
         rOmJsEfJB807H+Vpvd8LEyvTkqPwNH9hLvv+NoPaWvsAdMbPksBlR5kx+21obllqi9vj
         7m8FusXNXESFNQwPDLtz5pX4JLZdChnlhmbIxKxV/4EjqYIlzx6r/2miWVNoDJ2v2vQS
         9B9ncsjzUP3I63X0fJ1mXwm83lpnQv90yCng7V9LdL2FDA4qmXFcokbOyfPPjTWtego0
         RTQIM7RkyT37GLguI6QJg6w/ndsvPK++vy5h/BqmcYOIgCN4pVX5Xz/P9DSQI93Hn13m
         tSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=kNYiVBd1cBCop/nrtBQYXoofnHMlkqLGb5kuKDRfR4g=;
        b=Cyn32Q9M1hufWzWykAlTES2iGJGwAqKgxLKtI/9CclnBxozVJgB8G1+CohiM0J03dv
         f3aeWTAVV0sRn6T0iyny27/TSdNIjWQrhqvAD/L3P6BrOENxFQIt2n2ak7c1w2w3cC2a
         +Y+ZimKLDymFWYmGiG+bTW1LBH0qqRqfUd/SOovnqSgOa6AgLAnHDiFzjRsROffCjICW
         S11SO2qkZBTa90S8uUJhUXz7nGBbfMkbzBtt7Oea5vHZFg9lUBjZgzXMMOEwmWQCnKKk
         UvpUC49/iStMo6wtEm7wIlJJTRUCzZvf1z4e+nRIP/7MecGxiZK8N70pBv6TW9i1IqH+
         /VUg==
X-Gm-Message-State: AOAM533tl/LG1SAmeA4lRY/zgfU7iI6FsE18xwNvSCXzG46fu+3MveoN
        9Fcx2i+XDnEnw7I1yFQsNLWGnsFrdw+fuw==
X-Google-Smtp-Source: ABdhPJyjXaM0gupVP9yZBysQyI/n0XlvnGgv9z+RdE3OBzlRIvtK6srLkWHzbGDQFe8EjRvgLIeGcw==
X-Received: by 2002:a17:90a:5d10:: with SMTP id s16mr2589245pji.126.1615957013965;
        Tue, 16 Mar 2021 21:56:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k63sm19238522pfd.48.2021.03.16.21.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 21:56:53 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:56:53 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 21:56:38 PDT (-0700)
Subject:     Re: [PATCH v3 1/2] riscv: Ensure page table writes are flushed when initializing KASAN vmalloc
In-Reply-To: <20210313084505.16132-2-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        nylon7@andestech.com, nickhu@andestech.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-8c8d3e1d-7d6a-4e28-8c18-901af08a29d3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2021 00:45:04 PST (-0800), alex@ghiti.fr wrote:
> Make sure that writes to kernel page table during KASAN vmalloc
> initialization are made visible by adding a sfence.vma.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/mm/kasan_init.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 1b968855d389..57bf4ae09361 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -187,6 +187,8 @@ void __init kasan_shallow_populate(void *start, void *end)
>  		}
>  		vaddr += PAGE_SIZE;
>  	}
> +
> +	local_flush_tlb_all();
>  }
>
>  void __init kasan_init(void)

Thanks, this is on fixes.
