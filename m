Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD2435EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJUKKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhJUKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:10:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE78C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:07:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d13so129001wrf.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1oNJbu4pHa0grSs6d/Ns7GwUCGiFMszmkl6//VgeII=;
        b=CngsNRHpP3xh6N7S6PHF34+fDeYjB5qMaxxKiYNqOUXnACoEzVHxqk0VkPKPnKHdvg
         hd4xZGhEWkmGTe3+vQq37jqfz+2B9jgU1f/k29IhjSEbTzNY7VEqfRaS4czCiwcWWGQH
         hXOGa460Fr6GCQuBFg4AjhGLfykL+N3ebKY/x9cgLPB6Ped+HppYo7wg08pEjqSiwrGp
         rn445z1qcoCtgA/5Sga/yWZjrpnftJ6gvgdJ62aFqCndEfK2v4R7Lp14sVp98mjJLlrY
         FFldqfowPeNnj06Bs88tiUuL2Aub10yszfkjfJtC0IAk+/dtVc1HWqv5Nos5Cep8XPMq
         FepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1oNJbu4pHa0grSs6d/Ns7GwUCGiFMszmkl6//VgeII=;
        b=WX9krUYJ72AMLnOtr+0X2pEfGea3XskSPNJwsPYoMS/OvAUvKApgCCWObUXF0xdGAG
         7OvQcMZTp6bZARxsmjsS25KGTDJrpbVlwYdzdoRcJCFXfCuEcl8IOAVeaQ6gLjdDi9Vs
         8Y3N0R9prj8KQQRvknGoZ2gnuQ+w0oPxYMBuurPUQ7wPnUNBd2AzsLWwGHsiZFYNi4L3
         5CT2CC10xWO+C1fWI/nLTIsCgzL/pCDbw1eVmOuKjLQoZyri/C/HA1PMBYxPtBX4U/Dc
         PiRW+2EsF7CCK7GPSiiIb81qiSIQn+ITvYhDgKAcjrJR6ecs8nfPkmE+AmFTdj22gJAv
         Gv5Q==
X-Gm-Message-State: AOAM532bovSe7AY+uXmgJykjEy6LhFtUd5aTGDSwm9syS0bwrSElokDW
        EJeFfiflorGZJm+bZYy6pbW8mg==
X-Google-Smtp-Source: ABdhPJx0Ugn18uahMeYKsgvnxSDyUIvip8FsoCCPzC5FJhL12HE7Bbu4dUtEydRB1ms/fxFX8qmiVQ==
X-Received: by 2002:adf:a10f:: with SMTP id o15mr6411916wro.286.1634810872098;
        Thu, 21 Oct 2021 03:07:52 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id n12sm5422554wri.22.2021.10.21.03.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:07:51 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:07:47 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        Andrew Walbran <qwandor@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 07/15] KVM: arm64: Introduce kvm_share_hyp()
Message-ID: <YXE7842op3n8+JXv@google.com>
References: <20211019121304.2732332-1-qperret@google.com>
 <20211019121304.2732332-8-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019121304.2732332-8-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 0019b2309f70..0cc4b295e525 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -299,6 +299,17 @@ static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
>  	return 0;
>  }
>  
> +int kvm_share_hyp(void *from, void *to)
> +{
> +	if (is_kernel_in_hyp_mode())
> +		return 0;
> +
> +	if (kvm_host_owns_hyp_mappings())
> +		return create_hyp_mappings(from, to, PAGE_HYP);
> +
> +	return pkvm_share_hyp(kvm_kaddr_to_phys(from), kvm_kaddr_to_phys(to));

We should be careful about vmalloc memory here. kvm_kaddr_to_phys will
happily return the physical address but the range is not guaranteed to
be physically contiguous. It doesn't look like this series ever shares
vmalloc memory, but we should make it harder for users of this function
to shoot themselves in the foot.

One option would be to turn this into a loop and call pkvm_share_hyp on
each physical page. But since the hypervisor has no means of making
those pages virtually contigous anyway, probably not the right approach.

We could make it possible to share vmalloc buffer that fit into a page
and reject others. There we still need to be careful about the upper
bound because the way it's written now, 'to' can be treated as
exclusive and 'kvm_kaddr_to_phys(to)' would not always return the page
after 'kvm_kaddr_to_phys(from)'.

-David
