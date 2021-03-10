Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D159333387
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhCJDD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhCJDDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:03:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377CEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:03:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q204so10964410pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1YN8IaUR1Mu+1HOs/O2B0D40c+eC0rZ/zq/HTR6lO6w=;
        b=XdXjc9K0RS3ILjzJPr9g/Dru5e9KYMtoCzt8QhzKOlbzs05Fq+wgfjZ0xGhbEYKfNy
         5mI449JhfKLltyVCCaStPz0Hbmkrzqyv/EyOQ1dg5rvBz+UbRso7BozDLiT5azXKq9TA
         CAUSy/PJuQuQGjVCIj24x6uJ28N9bl4c8JAbRjkb5PN529+7VzPC6F2UMzTgIedq+zj7
         8goawhoy1sMy2XyRGH7Vv8LSV5X9TtM156R/NPck5P9vowxfatS91OSfML4X6YvRTprZ
         QcwFrNiPNPaUC2htvLzbfrBWFL5U68rWWcvtwXIQAm6ucGp4RMo0rP8vRjueUQx3wPC/
         6rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1YN8IaUR1Mu+1HOs/O2B0D40c+eC0rZ/zq/HTR6lO6w=;
        b=LW0NEjfQNvP2iukCC3eSo1h9JycIMgaC/jTfUcfAr0DnGjaoSUuKWft3GZdsew/g2x
         E6mmPGWrn466dmd32f09byEZegBE8FcxcXzua3TU22rf89rbrh22cd7EImrts2GbLZk9
         F2NEE8j0ahp2ewOtqtKGLT4365ejR2k6tgoP21oii6PQS2zNKOEs/mpF1RxT3eru/FMN
         8OQf6ObvzDn7zEPy4yp/NFxrSGmJQFil+G2a4EcrDIFDQ+xK+MsQ+ICbPiZi1PbLJiQL
         jXRppAOt2tIr4iAYfuoYuJECvJHdyY64/LwwkW58HsEHnltt7E4YljhvTh8XfxkUhfOS
         47cg==
X-Gm-Message-State: AOAM532XucbDFQs+jRovtDQ8zGqlPN2CRy7yqSh8CPsLQsMdl9eVCwPK
        29zTZIGG2ght5BJkFWa0FCr6yA==
X-Google-Smtp-Source: ABdhPJxl0YqekU2reqvAkEnVPyaoCtK2/VBG955HtdRnP0IqBiMOajFw5iFby8+nAp6JpwOP+5bamw==
X-Received: by 2002:a63:6dca:: with SMTP id i193mr879023pgc.81.1615345420644;
        Tue, 09 Mar 2021 19:03:40 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s22sm4168279pjs.42.2021.03.09.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:03:39 -0800 (PST)
Date:   Tue, 09 Mar 2021 19:03:39 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 19:03:24 PST (-0800)
Subject:     Re: [PATCH] riscv: kasan: remove unneeded semicolon
In-Reply-To: <1614667008-22640-1-git-send-email-jiapeng.chong@linux.alibaba.com>
CC:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiapeng.chong@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jiapeng.chong@linux.alibaba.com
Message-ID: <mhng-c78e0139-c0f9-4a61-87ab-f9658bfe5a42@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021 22:36:48 PST (-0800), jiapeng.chong@linux.alibaba.com wrote:
> Fix the following coccicheck warnings:
>
> ./arch/riscv/mm/kasan_init.c:217:2-3: Unneeded semicolon.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/riscv/mm/kasan_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 3fc18f4..e202cdb 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -214,7 +214,7 @@ void __init kasan_init(void)
>  			break;
>
>  		kasan_populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
> -	};
> +	}
>
>  	for (i = 0; i < PTRS_PER_PTE; i++)
>  		set_pte(&kasan_early_shadow_pte[i],

Looks like this one has already been fixed, thanks though!
