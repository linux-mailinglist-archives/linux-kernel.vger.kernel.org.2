Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3F3FC269
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhHaGCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbhHaGC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:02:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD394C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:01:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1156789pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PVdJWAW4gV+l3crQVW3zm26y90XFf8SFud15h5boB9k=;
        b=DUSY685Mt6bD+78O+cuR0kSOvujYkzK0h6LdWW4l6nGhPWG+gnKZ9IdAmhm07pfq9l
         KmyQYhBx9Hed9oiHmzlk3uPA+qnoR/HSQD8nZFZNPmnUwv8UlrzJh2wRXHc3q9EGsgiS
         ovJMSv0vXjoDkHX3E43PSwfjU5Z+UGRoGP/4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PVdJWAW4gV+l3crQVW3zm26y90XFf8SFud15h5boB9k=;
        b=FXqiZoywneaqGeTQovIqUVKg/dU4NkEs/GRoR/RXq8757o983FXJ9SI1SuG6zUATL4
         p7GWh6Pm3KhSSlfJ31wj6sFoKOZMNx+0l0blpvnhowgtpMGJtPq4zEbYShluMlULjkA2
         HzqbxOuLAhAOVGPPYoWNq41omAHVjTfVc86nc/9H39Zy7QN8MNrekJsH9zUnqxSdyrqQ
         Knv/nF2nW3owFIjuX/ZtPsTK1GDrZmIkP180Jc4X4gTpqKi5PQhjrmcoCAOiSdQWlr2k
         Mq5exvePNRcE/NYTKhQlbBhVZ5guDw4nUM2uEwMmPw+pM+Jjn5PrKT15suZTRuzpiOYg
         myvQ==
X-Gm-Message-State: AOAM532E52oKFwUjgu31V2zaqAR49cXHLG2XxYqG9D60uZymj4efw8RQ
        4rJZe2htKou6PlR8YnliQBD+iw==
X-Google-Smtp-Source: ABdhPJxaHoEhY6NhIKPUuvmwa4U6i7dWA5wABSMPHCCtui5n6whegr42jU1T5IiZawYrOWc5TX+b9g==
X-Received: by 2002:a17:90a:168f:: with SMTP id o15mr3495765pja.158.1630389693272;
        Mon, 30 Aug 2021 23:01:33 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:a664:ffe7:ee94:4600])
        by smtp.gmail.com with ESMTPSA id r15sm12914731pfh.45.2021.08.30.23.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 23:01:32 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     CGEL <cgel.zte@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Zeal Robot <zealci@zte.com.cn>,
        Jing Yangyang <jing.yangyang@zte.com.cn>
Subject: Re: [PATCH linux-next] power:pkeys: fix bugon.cocci warnings
In-Reply-To: <20210825064228.70487-1-deng.changcheng@zte.com.cn>
References: <20210825064228.70487-1-deng.changcheng@zte.com.cn>
Date:   Tue, 31 Aug 2021 16:01:29 +1000
Message-ID: <87lf4i6tl2.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jing,

Thanks for your patch.

The patch looks good, but looking at the output of `make coccicheck
M=arch/powerpc MODE=report`, it looks like there might be a few other
things that we might want to fix. Would it be worth trying to make the
arch/powerpc directory free from coccinelle warnings in one big patch
series, and then we could add coccicheck to our automatic patch testing?
(see
e.g. https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210825064228.70487-1-deng.changcheng@zte.com.cn/ )

For this patch, I think we should try to fix all of arch/powerpc at the
same time. The check points out the following other possible uses of
BUG_ON:

arch/powerpc/include/asm/book3s/64/pgtable-64k.h:68:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
arch/powerpc/platforms/cell/spufs/sched.c:908:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
arch/powerpc/platforms/powernv/idle.c:968:3-6: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
arch/powerpc/platforms/powernv/idle.c:456:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)

Kind regards,
Daniel


> Use BUG_ON instead of a if condition followed by BUG.
>
> ./arch/powerpc/include/asm/book3s/64/pkeys.h:21:2-5:WARNING
> Use BUG_ON instead of if condition followed by BUG.
> ./arch/powerpc/include/asm/book3s/64/pkeys.h:14:2-5:WARNING
> Use BUG_ON instead of if condition followed by BUG.
>
> Generated by: scripts/coccinelle/misc/bugon.cocci
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
> ---
>  arch/powerpc/include/asm/book3s/64/pkeys.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pkeys.h b/arch/powerpc/include/asm/book3s/64/pkeys.h
> index 5b17813..5f74f0c 100644
> --- a/arch/powerpc/include/asm/book3s/64/pkeys.h
> +++ b/arch/powerpc/include/asm/book3s/64/pkeys.h
> @@ -10,15 +10,13 @@ static inline u64 vmflag_to_pte_pkey_bits(u64 vm_flags)
>  	if (!mmu_has_feature(MMU_FTR_PKEY))
>  		return 0x0UL;
>  
> -	if (radix_enabled())
> -		BUG();
> +	BUG_ON(radix_enabled());
>  	return hash__vmflag_to_pte_pkey_bits(vm_flags);
>  }
>  
>  static inline u16 pte_to_pkey_bits(u64 pteflags)
>  {
> -	if (radix_enabled())
> -		BUG();
> +	BUG_ON(radix_enabled());
>  	return hash__pte_to_pkey_bits(pteflags);
>  }
>  
> -- 
> 1.8.3.1
