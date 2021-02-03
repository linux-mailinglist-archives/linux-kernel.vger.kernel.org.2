Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF930D1A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhBCCfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhBCCfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:35:34 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F860C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:34:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g3so13625541plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BZA3fMh+uit+LJFdPKPeRPO6jEIc0xrLde3uJLKGkgw=;
        b=YVkmkvRJXzbKWT+V1C4Cthr7VO5yZh9wxNcwVK8FcvANDyus4VO8sWzb7qHaixMzU4
         63zFE5KDY0Wh3uSn4Zcfyy9jn8rNj0FD/F5kEAOrsACvKIML1nGFGr6nLBox02dGR/aX
         wY2wjlQEpgsYRev08rkAiO+N7xIyxhIU0g4vXX2jYSUNrldTNtr8/R0GHECXCsOYOKhX
         1W/x2zHxhEzKA4csWozLX1EOxzsxw5taAkGNhowJVN6NFxivhiTaBqnBNz7QLmU95YS+
         bCcTNmy+V+RucCeySWp6/uJA3cgNuPEIxJGK41YZskOg3TCbRIWR7hjTgUQgwHdPE9bd
         d/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BZA3fMh+uit+LJFdPKPeRPO6jEIc0xrLde3uJLKGkgw=;
        b=VERlbX5Wwg6pwSwNK1JePHiNITugW7F31yTFxESuE6/xUmQ7vDHpQm9+aZLXW+bhgY
         aqo9jQSsSAAYkXoynIid7+iZfzaBLkvcFVb7HKIVfo48s5AXMoXoy6BJ8JKc0bjtlirN
         WQ3XrFEajIsNdSByjjMjFXW5T3irWXneJP5pIYWq+VzKDFBrgJoRjr87cBvqTY7bNT0t
         ygPZZAVpgGwRRUTf0Dg6Qrixhl0ZPlgpqf9wSWD3Zux6Pbwjf8kZvq28MMlmfAvP6ZiF
         QKyez0+ulMSAS0aABQjyknWKswySGckuOI/AruVgi98puhzJTyAL16HQ5aDbNTR6YvjN
         F1pQ==
X-Gm-Message-State: AOAM532q9M6x1qQ0E2WnnkXUtXOezJVQ7GDXazaM+eFMFtDc4/lutv1u
        NMhD0qx3GdaTAHm5RxgWS4VPKIuWYKEiWg==
X-Google-Smtp-Source: ABdhPJxU0ey/rE368B4EU3jBz0v7JBzHrDZGgf1zgUFuoU7sYdCApSJwHxEy1ZxxaW9Cs1uHGXGYMQ==
X-Received: by 2002:a17:90a:fa2:: with SMTP id 31mr875078pjz.57.1612319693816;
        Tue, 02 Feb 2021 18:34:53 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 123sm294441pfd.91.2021.02.02.18.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:34:52 -0800 (PST)
Date:   Tue, 02 Feb 2021 18:34:52 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 18:31:35 PST (-0800)
Subject:     Re: [PATCH] riscv: virt_addr_valid must check the address belongs to linear mapping
In-Reply-To: <20210129173105.22020-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        dvyukov@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-709d96f9-92ec-4ea4-8db6-e983b6e34777@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 09:31:05 PST (-0800), alex@ghiti.fr wrote:
> virt_addr_valid macro checks that a virtual address is valid, ie that
> the address belongs to the linear mapping and that the corresponding
>  physical page exists.
>
> Add the missing check that ensures the virtual address belongs to the
> linear mapping, otherwise __virt_to_phys, when compiled with
> CONFIG_DEBUG_VIRTUAL enabled, raises a WARN that is interpreted as a
> kernel bug by syzbot.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/asm/page.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 2d50f76efe48..64a675c5c30a 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -135,7 +135,10 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
>
>  #endif /* __ASSEMBLY__ */
>
> -#define virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
> +#define virt_addr_valid(vaddr)	({						\
> +	unsigned long _addr = (unsigned long)vaddr;				\
> +	(unsigned long)(_addr) >= PAGE_OFFSET && pfn_valid(virt_to_pfn(_addr));	\
> +})
>
>  #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_NON_EXEC

Thanks, this is on fixes.
