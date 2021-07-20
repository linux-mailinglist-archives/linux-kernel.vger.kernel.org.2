Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74453CF770
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhGTJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhGTJ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:28:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D428C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:09:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c15so1776672wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0j3bPtwVUVm/jZDBUJXolF4U+AmslpUbr8sCL6VPfoA=;
        b=HAyimdTxgae0VX9e5mbMhkKbnj16MrHWbI0i37pITjBmQQJ4VRXmvUpgvzO9ymMIKg
         mjrgM+dSiSax+84SIS0Okxr3ALUy2Ehb+jDqtr2dpRRcd9ugaeJaePM84jSgNnWfo7b6
         owAA6Yabf9pZ2CECadWlx2Vf/UcEBe3Ru/Hg8eXnI3Od9skjqLcVzLQYwMKdHLP1FjTf
         UXYVjUdCfgJtyqHqmkXXSPNvKzWc7/4OhrDx4gVDizRY6QqTXT5ADTSEwm8EW6X4NsiK
         KfeXgor2I58mOMbFMQYxJ6eRaDl5r+ueK7+ScH5nlJkkcOYGasQrSdjuHKcsvRFOpkbH
         csUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0j3bPtwVUVm/jZDBUJXolF4U+AmslpUbr8sCL6VPfoA=;
        b=ePjfdY2BQSe6rhYBSY/kM/yNFCUQw7Kod9HuyxgJbRdsbyu/3TnLVP0sMbYPRVhlAt
         WpsudErSvYVYNPSUNSQQMe93g/MaIHXf4bBxuiCRbbsqN9GFiWGv6nYJiLmA0FNkqXCm
         nY6EY7qJqzWGuv1d7ZKXn/XGGO4XPjKIx+KZ1MxzUqDUnLUZwR2HFjnKOeQYBNncoJ12
         xZyR15+N2N0rTwFI+sQC2aypIYBZrsDXssfaPOfd/6mXWJjCjoqpTrvA5oRzgEAUbcWr
         wpLV9xPae7NvrAZWiCiu9t/3KXtJES6/4rxTGf6uA8yc84sbS3g1PioaMF2pOiVO0FT0
         vL4Q==
X-Gm-Message-State: AOAM530A0VckQsIOccrnmPLZq8KcuoPklYAbACR9ja66KnbmET26MY4t
        V1Zp10ES0Mz7vd2Dw4jnmX0MUQ==
X-Google-Smtp-Source: ABdhPJw9FCFTdkiAN4LxfJoUs++5xlLWx8lVhaIJEWeX7hAEofC+sahFp6Ki2Mrs5oqdp3xuqh93zw==
X-Received: by 2002:adf:a2c3:: with SMTP id t3mr33970462wra.223.1626775765602;
        Tue, 20 Jul 2021 03:09:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id m15sm19470088wmc.20.2021.07.20.03.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:09:25 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:09:21 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        dbrazdil@google.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH 03/16] KVM: arm64: Turn kvm_pgtable_stage2_set_owner into
 kvm_pgtable_stage2_annotate
Message-ID: <YPag0YQHB0nph5ji@google.com>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210715163159.1480168-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715163159.1480168-4-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Jul 2021 at 17:31:46 (+0100), Marc Zyngier wrote:
> @@ -815,7 +807,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
>  		.arg		= &map_data,
>  	};
>  
> -	if (owner_id > KVM_MAX_OWNER_ID)
> +	if (!annotation || (annotation & PTE_VALID))
>  		return -EINVAL;

Why do you consider annotation==0 invalid? The assumption so far has
been that the owner_id for the host is 0, so annotating a range with 0s
should be a valid operation -- this will be required when e.g.
transferring ownership of a page back to the host.

>  
>  	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
> -- 
> 2.30.2
> 
