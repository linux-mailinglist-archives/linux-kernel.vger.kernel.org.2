Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15223AD853
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhFSHBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 03:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhFSHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 03:01:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 23:58:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y15so3631147pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6G6cPxZO1wJYjwHrbxpVxaAvSGtra3d9/Cgmg5fS0ec=;
        b=rep5NbXILX/YeNH/6/4N5GvoS6zuRL6S+f7QP3zXVfCM6WkliZPvpn6mDMO/HdoFKu
         HKDL/gkmsxbvt21AyvwZpk3mjXcXS080KPOaZN/YzIgynENTAv9oh/UdEZ5loQahoFes
         Q7qklmZ3HO9TJtgV69JSN7KNB8D854Ut5e3eZhmYMEaKCoyb2yHXGQJNA4qN0lcxMQzz
         OnxOhexKSl4MYu7PJd2DYYbvHKHUMJrL+mxlXEeBIGmxRjM7vB+5825NtMVWLUeMZVZr
         WF9u62/+BW1JVown5eWKs438vmEqkxJq+W/zgP6WZ2zt2q/zsWhw/cDhavhGpIEz92ld
         ABDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6G6cPxZO1wJYjwHrbxpVxaAvSGtra3d9/Cgmg5fS0ec=;
        b=HosU6pcdBr7Ah75J6jRa6HW70tw1jr160YxAux8RAgB3d6t4Fbya/IAZX39y5PZl/+
         nQ1qs91ADP3EaUSTCUdxGXS7neRabGGYrAk4EGtAu+CfQjRG87+cl7+whOFM4oKrVk2g
         V3F1lQ2ZGz9Q7zeM5PYeOqzyyrrJTxYI8iVXGk78pA3zqusQ7AHBoDhlguAaLDnj/bs1
         ynsBvyBSU2M7s3DArw7jmQTXWXNr1OOo4+fZ4DgBZij+Zv2nqUAzaNV6naZbZyiFm+yu
         wZglhiupkcJ7At14XaHGlNyoOnzBxoQbfo53FJFb+t4xXRz8i4b4BRzkgHWYcN3nrpmg
         iq0g==
X-Gm-Message-State: AOAM533jrzpnSs6Ntv7CvlWBnXAOVQv6hN5RXHonbbVGzPJYGuaWYVTY
        FriUg/SzaVVly+iQtdYCLYBOJQ==
X-Google-Smtp-Source: ABdhPJxh05kv+csFchihKpXjzobdKL1W5RfUylFFyQzDL6MWPQf+jiReEUZZNBriA/rLZY9uS1wJJA==
X-Received: by 2002:a63:1011:: with SMTP id f17mr13865826pgl.274.1624085924245;
        Fri, 18 Jun 2021 23:58:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z185sm10665908pgb.4.2021.06.18.23.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 23:58:43 -0700 (PDT)
Date:   Fri, 18 Jun 2021 23:58:43 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Jun 2021 23:45:54 PDT (-0700)
Subject:     Re: [PATCH] riscv: kasan: Fix MODULES_VADDR evaluation due to local variables' name
In-Reply-To: <20210618220136.21f32b98@xhacker>
CC:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, alex@ghiti.fr, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-b491e8d5-d7dc-4f5e-8b96-84d47360d85d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 07:01:36 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> commit 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear
> mapping") makes use of MODULES_VADDR to populate kernel, BPF, modules
> mapping. Currently, MODULES_VADDR is defined as below for RV64:
>
> | #define MODULES_VADDR   (PFN_ALIGN((unsigned long)&_end) - SZ_2G)
>
> But kasan_init() has two local variables which are also named as _start,
> _end, so MODULES_VADDR is evaluated with the local variable _end
> rather than the global "_end" as we expected. Fix this issue by
> renaming the two local variables.
>
> Fixes: 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear mapping")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/mm/kasan_init.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 55c113345460..d7189c8714a9 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -169,7 +169,7 @@ static void __init kasan_shallow_populate(void *start, void *end)
>
>  void __init kasan_init(void)
>  {
> -	phys_addr_t _start, _end;
> +	phys_addr_t p_start, p_end;
>  	u64 i;
>
>  	/*
> @@ -189,9 +189,9 @@ void __init kasan_init(void)
>  			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>
>  	/* Populate the linear mapping */
> -	for_each_mem_range(i, &_start, &_end) {
> -		void *start = (void *)__va(_start);
> -		void *end = (void *)__va(_end);
> +	for_each_mem_range(i, &p_start, &p_end) {
> +		void *start = (void *)__va(p_start);
> +		void *end = (void *)__va(p_end);
>
>  		if (start >= end)
>  			break;

Thanks for this.  I'd prefer a cleaner fix for tihs (maybe more '_'s in 
_end?), but I don't think we can do that without touching a bunch of 
code.  Given that this is necessary to make the fix work for me, I'm 
just going to take it as-is.

This is on fixes.
