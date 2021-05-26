Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF1391001
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhEZFbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhEZFbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:31:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2561EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 22:30:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 22so89947pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hDYUDmZv1mSfVqejIfcboudVE6wsUa6+OahMlWik0tM=;
        b=iUQIUIWOGD5Qe8r/yuDwG446zmgI4ofbjQb3TZK8fGD+P7nBdIZ+CEbD91AVH5GshD
         Axjp8sFacOA2yV5nFvHN6hYeaX3xuqU12q7im6RU/88STMFNom+dkBjYWHrU6RUyhGtq
         3hkmpXKRqGXTyHqdgyfHrJifFCZZKQOD+sa/TVDwHoS2+NrwxDFMXEjbohOeakKzDEoD
         VZzJq++8wDWHbHrNUH7ceUbsSeEnd2flkZ0En0MrWt1McCN4JYpJ85myvHfhvUei2WYG
         jQAEtBOb5HhmMlmAKU3mXa3esczWIDofG0A5ou4I3xyVPcj9Hbb0zx3Q1txaMIq+a5z1
         zm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hDYUDmZv1mSfVqejIfcboudVE6wsUa6+OahMlWik0tM=;
        b=d+UQcHexXTJVL1mJLNkiLojf3v+1ZCyrm5B2bL1D7sypko/LvZMMmGvbZwTi/B2BmW
         zfGdjbysfxjP5N95GlddDFBF4gNovpMYAmXN5+vxEsjSjxMJft04WI6Q9T7k4GKG0nMV
         pMPQQzjbZL51i+7NhQAyKr+1wL+T4WDhUHha/ZKmHhzu/yVC+vXYKGKWiAuXPb3MeR+1
         HO3D4srmIhUbPiT+bs0xasXUEL9M7sAd/EZxi3gyyCGDaWgd21P6E2cbLh6yCB+H/nre
         u3uzkOu2UO6NBsYS9zqNFZX74U7+l2JlMSLLDvX06f8fiWsr+yYDlbsirRH9rI6dyA83
         b9jA==
X-Gm-Message-State: AOAM5309+f5jMaclJ8LHqIAcSRRYM9iQLn0QJpnizqKAZcm65Ww6qWQz
        hzDpEUFgQ5E3z8nOn6b84K6+cA==
X-Google-Smtp-Source: ABdhPJwO3DBcDHG3edSM4G3dabflg3h4nZEYz71hsOD8jdKVz+xwCV+wsWYrYL3yuFrB7ids29WP8g==
X-Received: by 2002:a62:17cc:0:b029:2de:39c1:7eb7 with SMTP id 195-20020a6217cc0000b02902de39c17eb7mr33572853pfx.26.1622007013553;
        Tue, 25 May 2021 22:30:13 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n23sm12531178pgv.76.2021.05.25.22.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:30:12 -0700 (PDT)
Date:   Tue, 25 May 2021 22:30:12 -0700 (PDT)
X-Google-Original-Date: Tue, 25 May 2021 16:51:26 PDT (-0700)
Subject:     Re: [PATCH] riscv: Optimize switch_mm by passing "cpu" to flush_icache_deferred()
In-Reply-To: <20210512014231.466aff04@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-7775ab3c-847e-48f0-adaa-590285b8bbca@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 10:42:31 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Directly passing the cpu to flush_icache_deferred() rather than calling
> smp_processor_id() again.
>
> Here are some performance numbers:
>
> With a run of hackbench 30 times on a single core riscv64 Qemu instance
> with 1GB memory:
>
> without this patch: mean 36.934
> with this patch: mean 36.104 (improved by 2.24%)

I don't really put any stock in QEMU performance numbers for this sort 
of thing, but for something like this where we're just skipping an 
expensive call I don't really see a reason to even need performance 
numbers at all as we can just consider it an obvious optimization.

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/mm/context.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 68aa312fc352..6d445f2888ec 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -281,10 +281,9 @@ static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
>   * actually performs that local instruction cache flush, which implicitly only
>   * refers to the current hart.
>   */
> -static inline void flush_icache_deferred(struct mm_struct *mm)
> +static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
>  {
>  #ifdef CONFIG_SMP
> -	unsigned int cpu = smp_processor_id();
>  	cpumask_t *mask = &mm->context.icache_stale_mask;
>
>  	if (cpumask_test_cpu(cpu, mask)) {

This proceeds to perform only a local icache flush, which means it will 
break if any callers use a different CPU number.  That large comment at 
the top alludes to this behavior, but I went ahead and added a line to 
make that more explicit.

> @@ -320,5 +319,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>
>  	set_mm(next, cpu);
>
> -	flush_icache_deferred(next);
> +	flush_icache_deferred(next, cpu);
>  }

Thanks, this is on for-next.
