Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC73DA977
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhG2Qw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhG2Qw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:52:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A53C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:52:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d8so7747387wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+D+WQ6dthjR+r0AdBLApfx1B5e7Pkkf4I29v7UyCASI=;
        b=juIc7gELG7oN7gWL10hEXKAxzCKfQ3+sXIXbR8NVbv6H6/8iyg7e5nZinla68omfBb
         pJpFFeqW+7tNmBT3QkjlBbDReKO8n2PbzQz3d77E7PZ0q/OrwNaBD97Aa9ZAvTjI2boz
         wt1J1hBbyiLjD0zz4d+HP27f045C5hKwbqgPpJCj8+eSu5Orkr4Vl1ZAf+4WDVyBXmcJ
         OZJEBITH+AOxbJko2FNW5gO3AMZQ/0O5QbdhFoa4zbUZnMlvy63Cf/GBBX+Gh5o/4Fbc
         r3MUSxUe13D+9pOCExT/UwXJemJzILzsz9i7KJQdbLvRY6qX2Cj9v4tai1maVHI/jTRe
         B0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+D+WQ6dthjR+r0AdBLApfx1B5e7Pkkf4I29v7UyCASI=;
        b=No20V8PjsKFCD1npg4+B9xbhWedDYvG5EwSVsUAMm/6idaX1YABM6k2p1oKSWI0LWA
         LOs96SBR+k7fpZuOsXvYccHI2les5Y+DWvgqvCniMQptyIs3l/1uKYp99ACRn21LcYIU
         sAJjelE/44sUaJKblGZ8gXm35swMQGXS9h+14ExZXDlY2DXghTv2kfudL4GAul2+tD6w
         G1v1zsLTJ58Dl0UrzRRLHjGlNZ3isSP9fSDTSt00Bd/ss47uf6hEJM8j4oQkOsdS9unz
         V47F7v2FwqTzGNiSNGrvl1Q/3vctMTH5H6mlYUvCsVLYMUX6XjNpWAbEaRYj26+TUVlf
         sZMw==
X-Gm-Message-State: AOAM532P5z1CGbwxMeZ/a6m7DuO9vW1H8WPHRq3Vl297PAQhr5ENcndp
        SK1IKPacg3cT+BEv98KYIbzOGw==
X-Google-Smtp-Source: ABdhPJyuOEXmaCM+TGYzMuW7Y5FKOpp4wnpTdqH3IdxX/TQTz9aynuGEL16s1B6g9wYjmkjo8JDYfA==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr5939815wrv.77.1627577572042;
        Thu, 29 Jul 2021 09:52:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
        by smtp.gmail.com with ESMTPSA id j1sm9301709wmo.4.2021.07.29.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:52:51 -0700 (PDT)
Date:   Thu, 29 Jul 2021 17:52:49 +0100
From:   Quentin Perret <qperret@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: Fix off-by-one in range_is_memory
Message-ID: <YQLc4YlDfMRbnRJh@google.com>
References: <20210728153232.1018911-1-dbrazdil@google.com>
 <20210728153232.1018911-2-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728153232.1018911-2-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 Jul 2021 at 15:32:31 (+0000), David Brazdil wrote:
> Hyp checks whether an address range only covers RAM by checking the
> start/endpoints against a list of memblock_region structs. However,
> the endpoint here is exclusive but internally is treated as inclusive.
> Fix the off-by-one error that caused valid address ranges to be
> rejected.
> 
> Cc: Quentin Perret <qperret@google.com>
> Fixes: 90134ac9cabb6 ("KVM: arm64: Protect the .hyp sections from the host")
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index d938ce95d3bd..a6ce991b1467 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -193,7 +193,7 @@ static bool range_is_memory(u64 start, u64 end)
>  {
>  	struct kvm_mem_range r1, r2;
>  
> -	if (!find_mem_range(start, &r1) || !find_mem_range(end, &r2))
> +	if (!find_mem_range(start, &r1) || !find_mem_range(end - 1, &r2))
>  		return false;
>  	if (r1.start != r2.start)
>  		return false;

Looks good to me:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
