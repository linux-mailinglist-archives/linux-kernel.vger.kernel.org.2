Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC4449CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 20:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbhKHTzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 14:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbhKHTzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 14:55:10 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB6C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 11:52:25 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id j9so16147922pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 11:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNcWIVn+Wy27pUdYO1jQPgIdx2E92vh2pwmX05EnzNE=;
        b=jY2kujZ12wsKAFtiPmLXkOMgcjk0V+lZpDyp1TNMvbtWI+VynPsGxgcY6crCiITz1G
         HJIS2bMxc0GhiAKiPKuj8xwxZAK1pu8RVZXu4x7ETHRkxs97m4sAztO8NLMCSZwaE0q/
         199RO27X0LwDu89rtiCtzNrQpAxDaViRY4F5PiYkCa2sbdmHGcId9eQLRYTuHIXYCQ5k
         guL4KI2LYQXcrJfIgGAL4oEEmQgPy4FJ0m8Tmpsi0ki+qwVkPuAE92s4Gb6cbpcLPMx/
         dJpU4q2CwStfL9ZMOhnsdZ9rA6zQxj7VF0OeBpk07zfh3V02hb0ea21ne0PDl5Ojoc0U
         bNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNcWIVn+Wy27pUdYO1jQPgIdx2E92vh2pwmX05EnzNE=;
        b=Q8iu1KTLmYUQi0wwsWWM0Lkerbh9j7FaRYvf+0pCBOlKX1+EPz7/SxHfZZrqmKMlxx
         1jx0C7npfvMMUoLc0m9K3mIcBWU+HT1GaHPiYbhKAtuggGljkCRMFYWJgQ00jrISLpM6
         RL/iWoppw4gXcd+qBU5RbofQSiwb65SkJv0SzS9Ina2UxJJOaHpFVulNKZA4YqauPMxF
         0VLWH5MemD6+xNPIb4ty5i+qGg3NwXgZsXrFnbpvk7uLqoFy3M3qGH2I4dSLnr6OISRQ
         oa046tCmNuzIsQpwcnTD51GYkmbh/b5mf+rg6qmqiDjni7MQK+puntMBuxVuuj8Cr3GU
         rBtA==
X-Gm-Message-State: AOAM533L0AN4tzywOTRFvoie+IGeijW21nYqxQC5W2d+yPbo1PE0QhQF
        vwmvAIecD3ax1Zh+wXkH4wnVXw==
X-Google-Smtp-Source: ABdhPJy5wIrKHJe+eT8XAlzCxuq5th9yVuBQWA/n3sAvMYSiOpa0/XY8nBsSFRmM9d501h2QBP3eYQ==
X-Received: by 2002:a63:7d0f:: with SMTP id y15mr1473407pgc.446.1636401145324;
        Mon, 08 Nov 2021 11:52:25 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t38sm4342031pfg.218.2021.11.08.11.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:52:24 -0800 (PST)
Date:   Mon, 8 Nov 2021 19:52:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] KVM: MMU: Add support for PKS emulation
Message-ID: <YYl/9fi/fYJ92O5k@google.com>
References: <20210811101126.8973-1-chenyi.qiang@intel.com>
 <20210811101126.8973-6-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811101126.8973-6-chenyi.qiang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021, Chenyi Qiang wrote:
> @@ -202,14 +202,17 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>  	WARN_ON(pfec & (PFERR_PK_MASK | PFERR_RSVD_MASK));
>  	if (unlikely(mmu->pkr_mask)) {
>  		u32 pkr_bits, offset;
> +		u64 pkr;

Heh, MSR_IA32_PKRS strikes again.  This should be a u32.

>  
>  		/*
> -		* PKRU defines 32 bits, there are 16 domains and 2
> -		* attribute bits per domain in pkru.  pte_pkey is the
> -		* index of the protection domain, so pte_pkey * 2 is
> -		* is the index of the first bit for the domain.
> +		* PKRU and PKRS both define 32 bits. There are 16 domains
> +		* and 2 attribute bits per domain in them. pte_key is the
> +		* index of the protection domain, so pte_pkey * 2 is the
> +		* index of the first bit for the domain. The choice of
> +		* PKRU and PKRS is determined by the accessed pages.

Please replace "accessed pages" with something along the lines of

  The use of PKRU versus PKRS is selected by the address type, as determined by
  the U/S bit in the paging-structure entries.

I.e. try to avoid "access" in favor of "address" to follow the SDM's wording.
