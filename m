Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280613A0837
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFIAVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:21:47 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:44604 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFIAVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:21:46 -0400
Received: by mail-pf1-f176.google.com with SMTP id u18so17001025pfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BL8LYfLiW97gYs50mMRPWFDzO43ZPs/0nLhvyiI1l9k=;
        b=TwN6pJqmDjnw1jUF78frKPE3sQLHszqGjFRAVBbsP15o7eht+rzG9v0aT4xjB7Oi4y
         4KHRy6xnA6ntzPCsKiXtaqInCJv35Uyvk1ntGoSG3vg6Cc595QGvVlcaFvyFV5/tMfnv
         4laIKokxgf6or5+ToPBfFxXd8B3bxeVCslRrte5JKXpVEJ6w5vGi2o0atO52gEC74K4w
         Ay4VVIqMRCU+owvvl21mgw5JLyAFwyBKGKvEfV0KAMDi1ps/z1jCvHMZGd+AxmmRc7sl
         j6rbVn6PQgNDpk0YEyqBG42n5dOsYMvc+Sm59ws7BqIKaEUb2AZF5wpkpvszBOpvpa8D
         r6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BL8LYfLiW97gYs50mMRPWFDzO43ZPs/0nLhvyiI1l9k=;
        b=tkiPGO4BlMqQCywSpqUlbcoiMqL8gvGmDLfaNtglzCNSPzt2jEq6hsL3Gk4Asx6Dbg
         Fr6rZA+iS4mhf+n8hwebgWnY+TZd/fvnu/9x5Ei9RtN6krHwhLyi/RNaZjd7i654fR1v
         hMkpIbgzKk09xy7QS6GwJ14fpunsJiAvDqHwGrcQfpWRCIAjXqD2RTfbOrwqPTpvEn8o
         FaiF/GgzRr+BZg4yRxKuXoOd8ce0o6fYW/Ju3SJifDlK3K532vI9SZMy+IWqgtmjULH+
         Q+iS4tuXHPm25yzDkewu6lSlrmorQVeifK6+cvJtDR0jUo0CxiEqPN9R7VJLxzLnr5Mt
         4gMg==
X-Gm-Message-State: AOAM5336c0VP95zPALTQbS98OXj5dND4KcmoM+7XHaabcg5AdjU2x8jg
        Zx6nkxnLZfCMu1n7qd7Ooj2rhw==
X-Google-Smtp-Source: ABdhPJwmp1Lk7bsoywWHJKG1fB6e9hWnUEMNIoCQ52jVaFnQVitNhNkU5zua3Ug1Kgzuz7vqyQvFPA==
X-Received: by 2002:a65:520a:: with SMTP id o10mr920386pgp.172.1623197918663;
        Tue, 08 Jun 2021 17:18:38 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j5sm10143402pgl.70.2021.06.08.17.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:18:38 -0700 (PDT)
Date:   Tue, 08 Jun 2021 17:18:38 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Jun 2021 17:18:24 PDT (-0700)
Subject:     Re: [PATCH V2 1/2] riscv: Cleanup unused functions
In-Reply-To: <1622350408-44875-2-git-send-email-guoren@kernel.org>
CC:     guoren@kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sunxi@lists.linux.dev, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-c8795d34-beda-4ef5-85fc-932ac36a726e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 21:53:27 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> These functions haven't been used, so just remove them. The patch
> has been tested with riscv.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/page.h | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 6a7761c..a1b888f 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -37,16 +37,6 @@
>
>  #ifndef __ASSEMBLY__
>
> -#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
> -
> -/* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
> -#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
> -
> -/* align addr on a size boundary - adjust address up if needed */
> -#define _ALIGN(addr, size)	_ALIGN_UP(addr, size)
> -
>  #define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
>  #define copy_page(to, from)			memcpy((to), (from), PAGE_SIZE)

Thanks, this is on for-next.  I'm assuming you want the other one to go 
through the microblaze tree, and it looks like it's already been picked 
up.
