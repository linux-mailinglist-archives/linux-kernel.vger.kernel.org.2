Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2703D8D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhG1MPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhG1MPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:15:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7D5C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:15:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so4157328wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYbbIZoMD/b/Fq8e37HailMl4O7MY4m6Mt2gCBpEuDQ=;
        b=fqTrQ4uuHUeFCXJuKjWrrRZAjUSahCTgoWavfLLB4lOMC3ZYN+qMijBsymlR1rNoOv
         TZENLRhzK4CaipcXK90ge4PAAy3XlMGEgLugd/1FTgGlOw6NaMgGePd5Qq1wb60j8pOC
         V6T6u5XHmCmvkGD7Yu1lE/8Du+eMRUZUJNr84DGYfrJM5gBPbCL0lf5PgJJ3gU29r2Hn
         MApOPtQ30W4H8J/wz8oBgYYzwxVUYeroWafjX0hvAUzv7cxlXyTNPNpQ0SCBMhhX059q
         ahNwTVnKTF2LsmLZh5a2sEQOjMwzLrRA1gNMstiSvYy/TIEcVzg7CYhY0Rks1j+Zj41+
         stiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYbbIZoMD/b/Fq8e37HailMl4O7MY4m6Mt2gCBpEuDQ=;
        b=sUeksCHccp12DfFqveAdTHJxxI8Rgf5braJpQ24wBCi4Tp0OozPRN9j3qkUIld0CAE
         WMWKtPdiGQ+8gLyvd3X+W8UcUQeRz86r6YMPdUl+XTh278ClBkAW5jEUkkjgWGyoBQGw
         ncdcKOo/iC+KN0YbUV0ZoQC44T/F2+j73jpDpzLHOAdfgqBt6QaJ7aWEIrFs2vsUWN6K
         snAXnX7tzYuSnJi+PwXTkuMR9yuarVvWA9Hf/+hGQ46MkvXIm4NG0opK66waU8hT3NOh
         WgBbz0Do1h9Pjx4LGXyOiqd+DDQfYkjjRxwfe2TiroxYc+cFiyw/l5iEh4+pMdebPR9X
         ACnQ==
X-Gm-Message-State: AOAM53117wLAhykMEDFJ13eQSb6gVtrlHCJ/xZQgLz8w/ePlVik62WCe
        2b9PrNU8dQU0aQnNgxoDTnW27g==
X-Google-Smtp-Source: ABdhPJzgNbqRIxzd4hehDTC+KCWYXXRYwck4YjYrAzMJP5c35Whvluz0sZ3AKraerAUjQbY5ud0c6g==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr23388587wmk.5.1627474498601;
        Wed, 28 Jul 2021 05:14:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:ff6f:6a8e:935d:3f53])
        by smtp.gmail.com with ESMTPSA id w5sm1534611wro.45.2021.07.28.05.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:14:58 -0700 (PDT)
Date:   Wed, 28 Jul 2021 13:14:54 +0100
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH v2 12/16] KVM: arm64: Mark host bss and rodata section as
 shared
Message-ID: <YQFKPoUUjJyceVjR@google.com>
References: <20210726092905.2198501-1-qperret@google.com>
 <20210726092905.2198501-13-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726092905.2198501-13-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 Jul 2021 at 10:29:01 (+0100), Quentin Perret wrote:
> +static int finalize_mappings(void)
> +{
> +	enum kvm_pgtable_prot prot;
> +	int ret;
> +
> +	/*
> +	 * The host's .bss and .rodata sections are now conceptually owned by
> +	 * the hypervisor, so mark them as 'borrowed' in the host stage-2. We
> +	 * can safely use host_stage2_idmap_locked() at this point since the
> +	 * host stage-2 has not been enabled yet.
> +	 */
> +	prot = pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_BORROWED);
> +	ret = host_stage2_idmap_locked(__hyp_pa(__start_rodata),
> +				       __hyp_pa(__end_rodata), prot);
> +	if (ret)
> +		return ret;
> +
> +	return host_stage2_idmap_locked(__hyp_pa(__hyp_bss_end),
> +					__hyp_pa(__bss_stop), prot);
> +}
> +
>  void __noreturn __pkvm_init_finalise(void)
>  {
>  	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
> @@ -167,6 +199,10 @@ void __noreturn __pkvm_init_finalise(void)
>  	if (ret)
>  		goto out;
>  
> +	ret = finalize_mappings();
> +	if (ret)
> +		goto out;

While working on v3 of this series it occurred to me that we can
actually do vastly better than this. Specifically, the annotation of
shared pages currently happens in two places (recreate_hyp_mappings()
and finalize_mappings()) with nothing to guarantee they are in sync. At
the same time, the annotation of pages owned by the hypervisor is left
to the host itself using the __pkvm_mark_hyp hypercall. But clearly, by
the point we arrive to finalize_mappings() above, all the information I
need is already stored in the hyp pgtable. That is, it should be fairly
easy to walk the hyp stage-1, and for each valid mapping create a
matching annotation in the host stage-2 to mark the page shared or owned
by the hypervisor.

I'll have a go at implementing this in v3, which would guarantee
consistency across page-tables once the hypervisor is initialized, and
also allow to get rid of __pkvm_mark_hyp entirely. But if anybody thinks
this is a bad idea in the meantime, please shout!

Thanks,
Quentin
