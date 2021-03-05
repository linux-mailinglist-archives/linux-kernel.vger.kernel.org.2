Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17F432F497
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 21:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhCEUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 15:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCEUWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:22:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A91C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 12:22:38 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a24so1964231plm.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 12:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MgB9sUnmB+HDbU7JAxGibZcjoX4E3ntVPdJMz4KOYFw=;
        b=dLCXmMukcPtwoQkxr3n8IjcWmQ6q7PKDS4dt108Ep+Hg6xtKufWiaRfiYb+CxHR/HC
         qWKMfkrxZAMSD6QL8O9MUCKoSmwG/ZECasfaVxsuaSX2kBnGlXgijqIIG4MipL0UlkuP
         PEl4XvNYWvLojiZggWkziHss50vlyhTXkcdGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MgB9sUnmB+HDbU7JAxGibZcjoX4E3ntVPdJMz4KOYFw=;
        b=iiKFUkJ18cVyw44gyFwIjaEYeCwl1gOgmmqIsdedgcXBNbMqGNHPLq7MjJdmk3ylIw
         4n3Eq/hpvgLx2hfNycCN/wxlAC+zrhb+OzFQXE9rKEbLtm3i+D9XakfTCmIkznRhwzP0
         xxDP+npS3S0KzlvQIBsJdn3K34/RpOjDLZV7eBz5mgED9PN3WQ7r4V7gbxzDL7skk0iA
         KU/cH2zDJ/i5DkLt9FfxTjCRAyJCr/Z//h+k6ku140JFcHq66uU+dKNCqkGzBYVZYtIp
         jYlnutamhYqwDouQhpSsFvBhud/g3N1zaOx06L5uwt4CcQS5p7EaVyMiYQa7HKRAuBVM
         fLHw==
X-Gm-Message-State: AOAM531etpO7rh5tyRsLKOjaipN9a7VteOcrY4yklLfmptwpFpmIhZ4A
        8FJ5xzwRLlAomrU8+0ZpqNKYhQ==
X-Google-Smtp-Source: ABdhPJz904H54bOFu7Tm3S02OXvw0Agtoa0McJF8goVZOFxdTDl2+pz3qI79jeBp+mKHGDstYs9PXQ==
X-Received: by 2002:a17:902:ee06:b029:e4:ba18:3726 with SMTP id z6-20020a170902ee06b02900e4ba183726mr10198402plb.17.1614975758196;
        Fri, 05 Mar 2021 12:22:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 63sm3854163pfg.187.2021.03.05.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 12:22:37 -0800 (PST)
Date:   Fri, 5 Mar 2021 12:22:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Don't use cbz/adr with external symbols
Message-ID: <202103051222.1E08D7D31@keescook>
References: <20210305202124.3768527-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305202124.3768527-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 12:21:24PM -0800, Sami Tolvanen wrote:
> allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
> linker errors:
> 
>   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
>   relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
>   [-1048576, 1048575]; references hyp_panic
>   >>> defined in vmlinux.o
> 
>   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21E0):
>   relocation R_AARCH64_ADR_PREL_LO21 out of range: 2031200 is not in
>   [-1048576, 1048575]; references hyp_panic
>   >>> defined in vmlinux.o
> 
> This is because with LTO, the compiler ends up placing hyp_panic()
> more than 1MB away from __guest_enter(). Use an unconditional branch
> and adr_l instead to fix the issue.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1317
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
