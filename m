Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7030D1A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhBCCfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhBCCfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:35:37 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:34:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o7so16272642pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ne1JKbl2xYwrXX2qMgmxDsV3cfU3kyRYQzt/TMMEZaU=;
        b=WjMLaeZqHgQQrmNTQUTxDOOfOs3/Vr7b8wvBXLkwARbC/rw6HL+RXVh63Zbakdkh/2
         /Hj4LFOajBggkMOg4uN/yAZcFN3AlgbRfFHmvadYKCuvvMrurAqIg8khrmsZ5Y7tvkuR
         wOGDyUI0FXqRkGnBmK/xjKpwyUd/QiEqE6atpRGBFVpAckU/S/W4DWnfV1ZqM020OurQ
         PTSJq2STJxsUxNP+uVtgJpHLQ3eDikWBqC/2KPevKBv4LqoTh5wx13q5j2QpZToSJEI0
         HDawL1FCzz4RqXl8TvzABtEW+j0bNCHIrpijjEEqdfZNIPWhoLN/A6tvTkHxWOp+sETw
         kFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ne1JKbl2xYwrXX2qMgmxDsV3cfU3kyRYQzt/TMMEZaU=;
        b=LrIKUTdX9BOnE8V2oVJfD7N0qg51D0W3+ql+sFAupELCcIHIQrvJHBfOXs1OoNJV5u
         kN8OsmbQy+v59ktF1l9Hd37xiJHE2iMrnhy2XkraMGqWXsvAOgjtpCV2XP5CNWS4365Y
         QJub6o9lFpe2hSloQgw4olnc6AF50dSKETXhwsjTqCVSgdGwflDtRhZ+ljoIG+VPaMzy
         PXjMO9+DNlag+r+AHat0Na9lZVfg0OpNWzS4kOkHzbHhlY3cIk+XWbDCDVv7TWsydTUw
         1Jw1XwCIV9wuVZLYmefGUe/5T/qhABNI2s0QsU+ynQxzMxAtN56LhpHUdKiZ2vwnl2aL
         rX1g==
X-Gm-Message-State: AOAM533TBAZS8G68qs79ix8HreiDtSMScenr63WmNVcN4N4PKWwAEdbS
        sypJYru2axhv2rQqc2hP15weTmM8Y8rZdg==
X-Google-Smtp-Source: ABdhPJx2w8/CzL5MkRNREZh521egDSJFbkvPWPHdogBYBo2u/S/mTbENTFOlU3sLFpnYqWgv69hmRg==
X-Received: by 2002:aa7:8044:0:b029:1c7:eecb:aafa with SMTP id y4-20020aa780440000b02901c7eecbaafamr979685pfm.33.1612319696937;
        Tue, 02 Feb 2021 18:34:56 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p16sm295829pfq.28.2021.02.02.18.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:34:56 -0800 (PST)
Date:   Tue, 02 Feb 2021 18:34:56 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 18:32:47 PST (-0800)
Subject:     Re: [PATCH 2/3] riscv: Align on L1_CACHE_BYTES when STRICT_KERNEL_RWX
In-Reply-To: <20210129190038.1001626-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, svancau@gmail.com,
        Atish Patra <Atish.Patra@wdc.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, ardb@kernel.org,
        kirill.shutemov@linux.intel.com, linux-riscv@lists.infradead.org,
        ndesaulniers@gooogle.com, Paul Walmsley <paul.walmsley@sifive.com>,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-4fdfe85d-490e-4968-b927-afc7b34801e0@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 11:00:37 PST (-0800), Atish Patra wrote:
> From: Sebastien Van Cauwenberghe <svancau@gmail.com>
>
> Allows the sections to be aligned on smaller boundaries and
> therefore results in a smaller kernel image size.
>
> Signed-off-by: Sebastien Van Cauwenberghe <svancau@gmail.com>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/set_memory.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 211eb8244a45..8b80c80c7f1a 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -32,14 +32,14 @@ bool kernel_page_present(struct page *page);
>
>  #endif /* __ASSEMBLY__ */
>
> -#ifdef CONFIG_ARCH_HAS_STRICT_KERNEL_RWX
> +#ifdef CONFIG_STRICT_KERNEL_RWX
>  #ifdef CONFIG_64BIT
>  #define SECTION_ALIGN (1 << 21)
>  #else
>  #define SECTION_ALIGN (1 << 22)
>  #endif
> -#else /* !CONFIG_ARCH_HAS_STRICT_KERNEL_RWX */
> +#else /* !CONFIG_STRICT_KERNEL_RWX */
>  #define SECTION_ALIGN L1_CACHE_BYTES
> -#endif /* CONFIG_ARCH_HAS_STRICT_KERNEL_RWX */
> +#endif /* CONFIG_STRICT_KERNEL_RWX */
>
>  #endif /* _ASM_RISCV_SET_MEMORY_H */

Thanks, this is on fixes.
