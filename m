Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC42345B46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhCWJr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCWJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:47:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D97C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:47:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z2so20066452wrl.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oEiL3agt/74r7enmoTbEE0QlFnF8CJn1Y4avzKhgTiU=;
        b=YUFx/qgDiqyZgnG8fBQV5CEOQ9+BCRiJTNLw0U/Sjtwv7xDzYaCvOnt/DijlqjJDeq
         4gQ1ijgTeZbWSdb+trVyRWjQKbmgFIyw4kGzPHLfck/FJdRXsv6bJpcjqeUqY7ghYvwq
         pRcEi12K2xC6zj3zsdQHR7GQAz649sWNk0M5X3vcihlgBrPbW/ysFTU3zhgqPGfOiyln
         Ce/J3a+l+5yKFk7jm7otSR8CvCnQGsnVqlJVGNBKTlVXojSRlpjhpm+gC9AtYVeX6D4+
         uJijgatuuL+mfS0/3DkfrCgbc1Hn0xyCXdplBpsN8aHekogkBv5nmPi8VJ893Vsd2gbg
         iDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oEiL3agt/74r7enmoTbEE0QlFnF8CJn1Y4avzKhgTiU=;
        b=fqFWU0ySJF0Ohz0CR2wnGG3SqLIfWlucKyDHPov6J2QWdi7IRbS07mKWOEfSX/PbzO
         rInbnmfr8nO2973uHsh357muNYVND/E8oSyOy/bUjruSbXAgnNLVCkmE5GTweSTtoPvP
         P2YPa7nREzKpv6aUYmnY0OjYo2qnUR9g+S+0QpjoMdzLPQ/Kj4iRl68zqD0enAbxsDPA
         UK3C2aoyUW1EDkNclWMPFTVDQh3gM4pm3GinO5QCE2UHgK92N/iIn9SBFB/scI2rj8+P
         yzng54C8psiOh8KKVxOXoBDyJ5RO4r6FpUcnc9dJO3IgEg59YGGXhAphB76unST7yoYt
         LTnw==
X-Gm-Message-State: AOAM532HvWDywPDN4kY26621T4XWL6rkGtSoPnimZCvj/xd97ay1kD59
        6N9pnX2eVzfBcup5MCx1ecJFWA==
X-Google-Smtp-Source: ABdhPJwZod2yQE1XjdtryqkkNyVhfuXXaVYhV4/ZQg1dkULLQ1uIrVQJ3DN+46T9qwKAV2wA8h4DIw==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr3039063wro.199.1616492831791;
        Tue, 23 Mar 2021 02:47:11 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id k4sm29442912wrd.9.2021.03.23.02.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:47:11 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:47:08 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        tabba@google.com, ardb@kernel.org, mark.rutland@arm.com,
        dbrazdil@google.com
Subject: Re: [PATCH 2/3] KVM: arm64: Generate final CTR_EL0 value when
 running in Protected mode
Message-ID: <YFm5HIC/2Toowhnx@google.com>
References: <20210322164828.800662-1-maz@kernel.org>
 <20210322164828.800662-3-maz@kernel.org>
 <YFjWmHerKk7+9d7N@google.com>
 <87k0pzghlx.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0pzghlx.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Monday 22 Mar 2021 at 18:37:14 (+0000), Marc Zyngier wrote:
> Can't say I'm keen on the yucky bit, but here's an alternative (ha!)
> for you:
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 1a4cee7eb3c9..7582c3bd2f05 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -278,6 +278,9 @@ alternative_else
>  	ldr_l	\reg, arm64_ftr_reg_ctrel0 + ARM64_FTR_SYSVAL
>  alternative_endif
>  #else
> +alternative_if_not ARM64_KVM_PROTECTED_MODE
> +	ASM_BUG()
> +alternative_else_nop_endif
>  alternative_cb kvm_compute_final_ctr_el0
>  	movz	\reg, #0
>  	movk	\reg, #0, lsl #16
> 
> Yes, it is one more instruction, but it is cleaner and allows us to
> from the first patch of the series.
> 
> What do you think?

Yes, I think having the ASM_BUG() in this macro is bit nicer and I doubt
the additional nop will make any difference, so this is looking good to
me!

Thanks,
Quentin
