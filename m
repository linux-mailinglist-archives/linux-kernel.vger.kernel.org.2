Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153643E9B47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhHKXhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhHKXhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:37:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5C5C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:37:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d17so4807621plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QuIfA2qSoLvffItEog0Txhua4v5iPaRzueSF+kKPuoo=;
        b=Nro9k9HupQ0Cn+4oIjxpP/aOsJSJiQlbcDnud9jglYKtOK1I0eEvP8zsE4YsrYE+oC
         dM5Y1lSLMwn9dUNR/4gAMeGhFLNJJZytNjNPtQG7PpAd+19TSBqqaOHk6kFCNa8PMfN1
         qbqcUC4EFE6n1Sjxiow8HPGx7L1efNBXBdS+CypfzSEHGUGac6SOX03pwZXxt4L+ENsB
         cxyO7kqlKPER+4C0Tdwncp7J0I6mgCo6s3JJXyQWckpc3SFO29QaGaeOxzRWD8xL8JZv
         0jQw1CufdMFLq7Rr7men3ROWSNuJpj6uXERI28mC64ddXyFjfQr/et1vYzNcGXdNHT7h
         kU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QuIfA2qSoLvffItEog0Txhua4v5iPaRzueSF+kKPuoo=;
        b=rZt4EUX9kEAJcIqilRyIBv76ozmD6fPk0douL5jG257TR2co/DoycLg+JrUs7y+/+C
         q3ibR2o2FLCAZ3qZ3xL8tMWccd3cTMQLf+cZlZ2mv/Yzf5VFgclQ2cDfSR9feXxnUB7g
         6PNncjfsqyYoLlq1iv8U84Tpufcyb3dAAb6S1c+S0bah2ZIhTtOWPb7yEmWnymVfOB1U
         mC2PLcBwdHfe3qJdOL00P0Jg7OT2pZES2neyu0bJT2vsIuv0PY/DVSMpVSNvzLwQnBmn
         14V33f/YavhyGHF690ULkoDPDFbFIC5cI+rf6W5j0hTcCr3i6K/O+yPCrFolwDSvzfLm
         54Tg==
X-Gm-Message-State: AOAM531VrrXCQdkHCb9bkRx3MOEUzsX+W9ApeYnPQiD2pakmK/KGc0me
        pTs/1SLoAuv4IdALARythc4=
X-Google-Smtp-Source: ABdhPJyQGvRB9kkKj7AWTBgQe9I4K3r9yhn9qQqCihdTFxOmCUbYJm5EuA21UJ9jpeeEICMMJ3sfug==
X-Received: by 2002:a17:902:7889:b029:12b:cf54:4bf1 with SMTP id q9-20020a1709027889b029012bcf544bf1mr1194219pll.85.1628725043745;
        Wed, 11 Aug 2021 16:37:23 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id n33sm723129pfv.96.2021.08.11.16.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 16:37:23 -0700 (PDT)
Date:   Thu, 12 Aug 2021 07:37:19 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kexec: do not add '-mno-relax' flag if compiler
 doesn't support it
Message-ID: <20210811233719.2thdgy7hqudf7yf4@mail.google.com>
References: <20210722021715.127066-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722021715.127066-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, ping status for this fix. There's a build error with gcc7-.

On Thu, Jul 22, 2021 at 10:17:15AM +0800, Changbin Du wrote:
> The RISC-V special option '-mno-relax' which to disable linker relaxations
> is supported by GCC8+. For GCC7 and lower versions do not support this
> option.
> 
> Fixes: fba8a8674f ("RISC-V: Add kexec support")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  arch/riscv/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index d3081e4d9600..3397ddac1a30 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -11,7 +11,7 @@ endif
>  CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
>  
>  ifdef CONFIG_KEXEC
> -AFLAGS_kexec_relocate.o := -mcmodel=medany -mno-relax
> +AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
>  endif
>  
>  extra-y += head.o
> -- 
> 2.26.2
> 
> 

-- 
Cheers,
Changbin Du
