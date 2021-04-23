Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A80368AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 04:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhDWByF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhDWByF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:54:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B8FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:53:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h11so2015200pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hWpkxbRFPrHzvBdyCxq0yM9F4eVkT1GLFQSzePBdBvU=;
        b=ui0YQ67r0GMCX0m9lG1nzigxAQyxN6UQjTQ38IAJMKfa3dvpbR9pKjP3RR7EV73O0Z
         e3A/51zX3+Qr4PGyqcUlm+zDOL6MNVoGcw8/3CHeek2cGdc2jBC1Q8pbyE58bMkzakis
         +1yR8DKBYTUf8GPeYAbNsW14EiKjMWOZE84VsnBXigwUzIGTtpYRWtoUgNSir9tuyXSD
         2djFeLgdvkxX08pFvWgY5AnfurYjLEAeyeMLXngalTqHEz5W0yEZQAN4u2IIJvqXLiyk
         kUhHqrt5OQRDHXXMOW7VEi4KPph11LcHxjf/1P+dVnVfRhh3bcXPLH17fHzButt0nxwY
         8vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hWpkxbRFPrHzvBdyCxq0yM9F4eVkT1GLFQSzePBdBvU=;
        b=HTsWhzXQ9MNzblvYrfIXW6h7/g46OHR9TGUao0C0tgYUFseIje8drZBk//SoOlOTFK
         VtmOZPw+4eaje++gC/jRB1UZftxccK4U8q8wcloeC70owaesvv6N1w+/Xqk+GaAEF3t1
         U+F/VocdmgeOn02lCREvUB7AKviYSUevvA75fr71lgAdb8rui/0HEjjP7ZzXXdq9nlGI
         H7mUHNyfrdU6/fdvq62pgXzyGdRjUtclH3cFz/MhPNUMFGfHkWh0kvzS1FJ5Ucj8IjB4
         daElM8dsn2CT0q4/aXPwWYe+KMbI+QSB2Yc0F0UBmY8O0m/XPfG94mRcvtbz79GgUeDk
         tdUw==
X-Gm-Message-State: AOAM5307gCD6gautLEfubyGg+HusulxsTigvTCRsuphI3oGTaiW1NtUt
        ClnzCu+CWQ97Bv3YUQW4tcLctg==
X-Google-Smtp-Source: ABdhPJwhOCtZhiWeV5BXgLADTWwMhpuimis0nWYpyu/hpAfFNe2Pgn6BjVC9l+syYXOFfmH5snsLXw==
X-Received: by 2002:a63:ec4e:: with SMTP id r14mr1567362pgj.153.1619142808475;
        Thu, 22 Apr 2021 18:53:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u18sm3113176pfm.4.2021.04.22.18.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:53:28 -0700 (PDT)
Date:   Thu, 22 Apr 2021 18:53:28 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 18:53:26 PDT (-0700)
Subject:     Re: [PATCH] riscv/mm: Use BUG_ON instead of if condition followed by BUG.
In-Reply-To: <1617112588-7750-1-git-send-email-zhouchuangao@vivo.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, rppt@kernel.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        zong.li@sifive.com, mick@ics.forth.gr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhouchuangao@vivo.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zhouchuangao@vivo.com
Message-ID: <mhng-1c7adead-9a56-41dc-a734-61e0088b0cc3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 06:56:26 PDT (-0700), zhouchuangao@vivo.com wrote:
> BUG_ON() uses unlikely in if(), which can be optimized at compile time.
>
> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
> ---
>  arch/riscv/mm/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 067583a..a7fa5e2 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -213,8 +213,8 @@ static phys_addr_t alloc_pte_late(uintptr_t va)
>  	unsigned long vaddr;
>
>  	vaddr = __get_free_page(GFP_KERNEL);
> -	if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
> -		BUG();
> +	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)));
> +
>  	return __pa(vaddr);
>  }

Thanks, this is on for-next.
