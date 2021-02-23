Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25A4322453
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBWC7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBWC7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:59:01 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE6AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:58:21 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g20so8976571plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CjGqwkyVdOUjMU+Osg0oifDQj76K6GurWtUd7NJehmk=;
        b=fTW6i4gdM2obLimij+JFj3ntaPTwvLB9LjMmcTjo80nsNH8VXX4WNnFpTCGnne9AHV
         qjnlo+QofPbzQWHkrJXdwa1fzqxqrnB8LZzp5zFCURkf8Wy03P9xcW5EPPwbqvqSlN+g
         okL1wUv3JKsatvsOLK4rixUhUBV956To9jwh9CTm4YFu6IgRKsFw59uKT56dNvFMairN
         mA8thPoCr2WreDAWn361qDac7cJ5w4/Hwh0E5OPY/DfbcB2y+5pij9hM2PYIaKymREpn
         wqvCAuELFJkLdvhq9A2p7+9LnWwWRXgiB/L809GZOzJs2kgRakJNeelcMphuoej0tfIm
         7Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CjGqwkyVdOUjMU+Osg0oifDQj76K6GurWtUd7NJehmk=;
        b=LrjBnU8JV5iYeTyoNW2OF1K1DppCiCbkxH8vxCq8JAA1k0Mqq1VsRDrO3UODMKALx9
         nWWvzCghyPTOlRAfVWOsdGt6iC3ZKA3LpW4dP8Xl1o272lAu38Rf8+cYU93DQn6+6sJz
         eCcySCyHZ14XSlGuIsCxP8ZAvnxQORQTipBq9g9JQDFwzZLAIVXjRTa+/BdhesbkgMCJ
         bMGXpydLRZTKOOnWdclHo4DFwW/AhZlc7rkKXHtTLSs5uB9Z7LksGjIw1b3tJOTZSDT+
         xLZY3oHhuvppNzhTJrZzTO10UPcv7iExXhXqy5woyxNiuUl97Se3vsR1XGRlLf8xD8um
         VB/g==
X-Gm-Message-State: AOAM531CaVAYsKe8CaVU9q3338xpispLTbwQTOMYwhTCOVnQAYL6dFnZ
        +jXsRpnEEfVlMnLp0XLtMsMLUQ==
X-Google-Smtp-Source: ABdhPJxxijb0gsLekm5CEtAUePwNAVm4vwpXa59OIi8JYMbQ7S+nv1HiGkaz0VwCoKnCI/D7CufSZw==
X-Received: by 2002:a17:90a:8c84:: with SMTP id b4mr26336255pjo.21.1614049100590;
        Mon, 22 Feb 2021 18:58:20 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j26sm20162062pfa.35.2021.02.22.18.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:58:20 -0800 (PST)
Date:   Mon, 22 Feb 2021 18:58:20 -0800 (PST)
X-Google-Original-Date: Mon, 22 Feb 2021 18:36:27 PST (-0800)
Subject:     Re: [PATCH] riscv: Pass virtual addresses to kasan_mem_to_shadow
In-Reply-To: <20210222080734.31631-1-alex@ghiti.fr>
CC:     aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org, rppt@kernel.org,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-ed9c69f4-96ab-417c-90da-4c03a48d1268@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 00:07:34 PST (-0800), alex@ghiti.fr wrote:
> kasan_mem_to_shadow translates virtual addresses to kasan shadow
> addresses whereas for_each_mem_range returns physical addresses: it is
> then required to use __va on those addresses before passing them to
> kasan_mem_to_shadow.
>
> Fixes: b10d6bca8720 ("arch, drivers: replace for_each_membock() with for_each_mem_range()")
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/kasan_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 4b9149f963d3..6d3b88f2c566 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -148,8 +148,8 @@ void __init kasan_init(void)
>  			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>
>  	for_each_mem_range(i, &_start, &_end) {
> -		void *start = (void *)_start;
> -		void *end = (void *)_end;
> +		void *start = (void *)__va(_start);
> +		void *end = (void *)__va(_end);
>
>  		if (start >= end)
>  			break;

Thanks, but unless I'm missing something this is already in Linus' tree as
c25a053e1577 ("riscv: Fix KASAN memory mapping.").
