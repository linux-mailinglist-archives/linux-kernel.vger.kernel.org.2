Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0747B3DA990
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhG2RAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG2RAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:00:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67C5C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:00:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z4so7764037wrv.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rFgImdL4oRnQoKBA5pI3AwMwu/TF6E4dvPNBUaLQNFQ=;
        b=Ym5Ufkl/exEhxT3LXpkyNJPvberJTQmdCqua9HnSvE4M1l834pSV3ErwW2z0EyYWzN
         25tlJDAdf4Z8milEdWy0tk01sdQ6hArqX5HIewWnMc4zSAriwLR/66Pb62qomNeOfoZ9
         uHH4jP7oMOLk7iBAtSooAcqjMGyBacUbzwf2prksRZN34Etp9YS6CxBG1OmhWxdt5iwv
         Cz0hTGe2SZ6LQAjhb/19b6Onsoqj3n+calSmMc1PqDOdl6S5v2E+DIvW1JqZultHFGaZ
         e0HJto+/7kXHwepNw+rHHp76Vd4deu1YTEZU2A+fO6L5MjxxixVrUs1tBlqHMKsC19AF
         Ywgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFgImdL4oRnQoKBA5pI3AwMwu/TF6E4dvPNBUaLQNFQ=;
        b=qytdJkCgporMPKELFDojbGRHGh0erbYRvXmK2SU6rjTQOdhqztm8dXDqyBDVl4IC2X
         XUNdCNVLj8wBl99EMI/km9kJv5aZTPwc2IO8vB7WN34IfGwcF6ChI/4nw7dsaTokN7Kp
         amIK0QB7tTEGqDTnyfNx5ERYG6MktjpfZgy5JsqzrgMKprch+ulp+TeAdNoOLj3gFdDI
         Od0+AxC8GGki0eh8wOT3t0DJC5v/bNDYgXNt/oUVfigLvXbrZ/l9IMw1NAdmuzXke1LU
         IZpMVxWANKv4+w5W0gcLyIvIUOkRqzWGe+xPD+w1gavYjbsgEwBd2WIYGcNtWSuGPsgv
         Wmzg==
X-Gm-Message-State: AOAM531EiLg996htbKWcDoX5GujABkoQ2nM/s2O2sPZYUAExA3rZRQ18
        rH3+iK7HYDVa9PBdFKsV04j+lQ==
X-Google-Smtp-Source: ABdhPJyFz2hml+WnVbZ7VNzv3kjo6OC8XSEJ53KL7oluYjYUSeypg9pkHqCQ9bSEkCwBjaOkz9WNEQ==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr4243003wrw.197.1627578027075;
        Thu, 29 Jul 2021 10:00:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
        by smtp.gmail.com with ESMTPSA id q22sm3841194wmc.16.2021.07.29.10.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:00:26 -0700 (PDT)
Date:   Thu, 29 Jul 2021 18:00:23 +0100
From:   Quentin Perret <qperret@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: Minor optimization of range_is_memory
Message-ID: <YQLep2cwhyzWu2cL@google.com>
References: <20210728153232.1018911-1-dbrazdil@google.com>
 <20210728153232.1018911-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728153232.1018911-3-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 Jul 2021 at 15:32:32 (+0000), David Brazdil wrote:
> Currently range_is_memory finds the corresponding struct memblock_region
> for both the lower and upper bounds of the given address range with two
> rounds of binary search, and then checks that the two memblocks are the
> same. Simplify this by only doing binary search on the lower bound and
> then checking that the upper bound is in the same memblock.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index a6ce991b1467..37d73af69634 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -189,13 +189,18 @@ static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
>  	return false;
>  }
>  
> +static bool is_in_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
> +{

Nit: addr@ could be u64 for consistency -- struct kvm_mem_range holds
IPAs in general.

> +	return range->start <= addr && addr < range->end;
> +}
> +
>  static bool range_is_memory(u64 start, u64 end)
>  {
> -	struct kvm_mem_range r1, r2;
> +	struct kvm_mem_range r;
>  
> -	if (!find_mem_range(start, &r1) || !find_mem_range(end - 1, &r2))
> +	if (!find_mem_range(start, &r))
>  		return false;
> -	if (r1.start != r2.start)
> +	if (!is_in_mem_range(end - 1, &r))
>  		return false;
>  
>  	return true;

Nit: maybe drop the second if and simplify to:

	return is_in_mem_range(end - 1, &r);

With that:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
