Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B004033E76B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCQDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhCQDEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:04:38 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE8AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 20:04:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 205so6950607pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 20:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ArISpaVR5NftLHA/UO2Rb3+d6mO7ozCvgCFkvz0VkaU=;
        b=gB8IhhzuEXE0MWZPR8gGgSnLLxT40ijvLPcJjobBxTOh7v+wqAn/EtahpgVWj8EAMl
         6cHsC/CpO9ttpUNdFm9uD7SudafgtprFotv94lVisWfSWYWv29hWuFCfRWkCLnp/UQGI
         GH7Awg0PrkcshDKjiJUutXKgvjDFHHHfMOyho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ArISpaVR5NftLHA/UO2Rb3+d6mO7ozCvgCFkvz0VkaU=;
        b=syOq8BbeklenbKx1fys1K8/sO3wW6QHFL/gaOE8dcUuBqHVojs4KjPnyCHuyzrv5bd
         6TrOLZlBokQrqNG9kKUfD/PypoEGYAPCyzQ8DKZoALNW2SCsE6+0ucXEpAoTx5OxG6Yz
         ZnRQGZDZjQ1Dfj85W+Hv/O9YQSFIhvhF7OQe9P+JSYJvuj0nxrbPghGHFJkNyxX3nBeD
         7ZuYOSts9n58R4kVsVPB9c0sUuL/xO+M9fpwNl7N4qe6c6CZf/kZiK8cDoFyVrP2vL4d
         O5SchU/uZqkbvdGH9r2asGn1zH+i71MRfWqRwgR9J4XUiRg0evy+/aj/BSolNV7EaUtv
         ocUg==
X-Gm-Message-State: AOAM530rEg/BSQ4hEKeKs6aX3nEBuBfWJbQcxzIJopU0cNEQ8pC3Fk0L
        0C/pVaj8FxDCBXKGvnsEbKrNIg==
X-Google-Smtp-Source: ABdhPJwY1VwCaeicuUaF81DtyNHoytPnwg1ChKYNRaLZMBOfmfRGpwZrDQOfSYMT+wziMZUympMZGg==
X-Received: by 2002:a65:4508:: with SMTP id n8mr745832pgq.294.1615950277599;
        Tue, 16 Mar 2021 20:04:37 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-b14c-f6f0-24fb-9b97.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b14c:f6f0:24fb:9b97])
        by smtp.gmail.com with ESMTPSA id z27sm16670536pff.111.2021.03.16.20.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 20:04:37 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     He Ying <heying24@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        rppt@kernel.org, ardb@kernel.org, clg@kaod.org,
        christophe.leroy@csgroup.eu
Cc:     johnny.chenyi@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: arch/powerpc/kernel/setup_64.c - cleanup warnings
In-Reply-To: <20210316041148.29694-1-heying24@huawei.com>
References: <20210316041148.29694-1-heying24@huawei.com>
Date:   Wed, 17 Mar 2021 14:04:33 +1100
Message-ID: <87wnu6bhvi.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi He Ying,

Thank you for this patch.

I'm not sure what the precise rules for Fixes are, but I wonder if this
should have:

Fixes: 9a32a7e78bd0 ("powerpc/64s: flush L1D after user accesses")
Fixes: f79643787e0a ("powerpc/64s: flush L1D on kernel entry")

Those are the commits that added the entry_flush and uaccess_flush
symbols. Perhaps one for rfi_flush too but I'm not sure what commit
introduced that.

Kind regards,
Daniel

> warning: symbol 'rfi_flush' was not declared.
> warning: symbol 'entry_flush' was not declared.
> warning: symbol 'uaccess_flush' was not declared.
> We found warnings above in arch/powerpc/kernel/setup_64.c by using
> sparse tool.
>
> Define 'entry_flush' and 'uaccess_flush' as static because they are not
> referenced outside the file. Include asm/security_features.h in which
> 'rfi_flush' is declared.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  arch/powerpc/kernel/setup_64.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 560ed8b975e7..f92d72a7e7ce 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -68,6 +68,7 @@
>  #include <asm/early_ioremap.h>
>  #include <asm/pgalloc.h>
>  #include <asm/asm-prototypes.h>
> +#include <asm/security_features.h>
>  
>  #include "setup.h"
>  
> @@ -949,8 +950,8 @@ static bool no_rfi_flush;
>  static bool no_entry_flush;
>  static bool no_uaccess_flush;
>  bool rfi_flush;
> -bool entry_flush;
> -bool uaccess_flush;
> +static bool entry_flush;
> +static bool uaccess_flush;
>  DEFINE_STATIC_KEY_FALSE(uaccess_flush_key);
>  EXPORT_SYMBOL(uaccess_flush_key);
>  
> -- 
> 2.17.1
