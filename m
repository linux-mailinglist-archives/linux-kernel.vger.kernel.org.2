Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF99348787
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 04:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCYDfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 23:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCYDeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 23:34:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A8FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 20:34:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x126so573831pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 20:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uiHuANgZnUbs15erWI7jFJ06CQL/PCIuoG5tp+3N4nE=;
        b=Avv86z6t3Wlrh6ex01MDKbR5Qe9MemwRgAj1PIprTZWNVr5vpe2TpYSZANV1n5OATL
         zZaJ5qQDZiEGkKvCSOgAzKB5ZRAWg5HSq1KkfAKxYbEZHJh8sIb/XK14yCwGXMBGtS20
         0U5XPJ/LWeAlNBbnHotvyKWXTpSt1e8cT+ux9w14OrihPnXYnQW/chh2WGfXisDqBNJv
         N0cozmY90iTzeixUAC/W76VPTg9kexWXW8wfUB3Lo0VVwQ1Iz7Hq6ZnFdIudcvtjxsau
         qhM7nGl4xM9XkTONd2PpCzC/OUDC0ssP7urAYzZ/amK+kCESzmhH7+6zuxySYcgxDqu0
         qmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uiHuANgZnUbs15erWI7jFJ06CQL/PCIuoG5tp+3N4nE=;
        b=JCfGtmxrrcCcKy15qnAOIiFmRAfnv8eJyrdsh+LhcEP+h6bmUJ65j1Up6MKK08s+0L
         GESjKYsigWq340FIbzWLQBMDA9M+4dfUu8RHenNJ9pAX68cw7pLXEjfB2MzeRVZP8owL
         qIhzxEJBCeqWhI17w64xnAyMxT2kYjNe8b758mUzrK4KmN1OLUMNAL+zPU7AoCNiMl48
         IX7GG+dnOqT71YkM50NpnEzGwL4MNCEtEJwoo5SHoNP9tMOQjrnuace4ZDevqx4DTQjQ
         M4nD4Yhks2E9YTdL10qXzFchseLezUmXVf+WA8SlM3P5xR9kISH5TFGDZGU22RwvUyeL
         5k0Q==
X-Gm-Message-State: AOAM533I+Nt6QdYs5zRjlglZZ28OHOjvntwSYzscYfJGhlDKs3/s2rSA
        yThxEv5qQUYKXufNAJ5A2Rwbj8ofrJGvNA==
X-Google-Smtp-Source: ABdhPJxImsKBAHNehdnBOjZGwfMv4q2M2pY7ju3E01s04z4pvRiTdZAPGc2tU3JodE7AeVEWfWa/mA==
X-Received: by 2002:a62:7f86:0:b029:20a:a195:bb36 with SMTP id a128-20020a627f860000b029020aa195bb36mr6160832pfd.4.1616643276590;
        Wed, 24 Mar 2021 20:34:36 -0700 (PDT)
Received: from rashmica (150.24.220.111.sta.wbroadband.net.au. [111.220.24.150])
        by smtp.googlemail.com with ESMTPSA id m3sm3528784pgk.47.2021.03.24.20.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 20:34:36 -0700 (PDT)
Message-ID: <fa0803a7ca3c88835e113e06e32bed68adbc45c2.camel@gmail.com>
Subject: Re: [PATCH] powerpc/asm-offsets: GPR14 is not needed either
From:   Rashmica Gupta <rashmica.g@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Mar 2021 14:34:31 +1100
In-Reply-To: <9881c68fbca004f9ea18fc9473f630e11ccd6417.1615806071.git.christophe.leroy@csgroup.eu>
References: <9881c68fbca004f9ea18fc9473f630e11ccd6417.1615806071.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-15 at 11:01 +0000, Christophe Leroy wrote:
> Commit aac6a91fea93 ("powerpc/asm: Remove unused symbols in
> asm-offsets.c") removed GPR15 to GPR31 but kept GPR14,
> probably because it pops up in a couple of comments when doing
> a grep.
> 
> However, it was never used either, so remove it as well.
> 

Looks good to me.

Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>

> Fixes: aac6a91fea93 ("powerpc/asm: Remove unused symbols in asm-
> offsets.c")
> Cc: Rashmica Gupta <rashmicy@gmail.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/asm-offsets.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/asm-offsets.c
> b/arch/powerpc/kernel/asm-offsets.c
> index f3a662201a9f..4d230c5c7099 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -323,9 +323,6 @@ int main(void)
>  	STACK_PT_REGS_OFFSET(GPR11, gpr[11]);
>  	STACK_PT_REGS_OFFSET(GPR12, gpr[12]);
>  	STACK_PT_REGS_OFFSET(GPR13, gpr[13]);
> -#ifndef CONFIG_PPC64
> -	STACK_PT_REGS_OFFSET(GPR14, gpr[14]);
> -#endif /* CONFIG_PPC64 */
>  	/*
>  	 * Note: these symbols include _ because they overlap with
> special
>  	 * register names

