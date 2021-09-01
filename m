Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81D3FE67F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbhIAXtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242632AbhIAXtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:49:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39055C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:48:17 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b10so194228ioq.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7QLaqmuMdndaoDUoQKfj9TVz0nnnEHxweKe5hvBPXD0=;
        b=vLoV3R33YLTSXudj2GKqaz2xUKTo/hFMiYfsqG/Fz3dT8teBjlT7VODVk8heJfB0JT
         fUNhKoXkyn3UsIiwKTRMDEWo7nEJ4NVJX7SWhXurBTzziGFf2ls9a6cn6gBuqs85JPhL
         Rp6yb0/UPwD/9pIrcSxGX8Qao0EVoBbvygNditKUMfFrRMOS/rlbZX4YK+8UgVFlPyC7
         ItJyQLXmGmJlVEtJZvW6h8rYhkecCGKg9JxHNAqiRr4ylYCbedpzjIyn1ijclBeZ8/g2
         TSIs0i6xJo5sWN0UDJfjSFrTC/sFJ9wOkdQftASbkiEMOoRPLXLrGgaw4on2KvuSb7nI
         PX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7QLaqmuMdndaoDUoQKfj9TVz0nnnEHxweKe5hvBPXD0=;
        b=h8MlWPNZVckRkW0+4AkxbQd8SEb2TnNcodqu5vMkbVM1c0Ex86p/RdhYTQY7m4fezm
         PzRZ7eebPE1rwLVMC+5rkmW4q36hMekPZ77U6UkawLM18QvKf+8Dkc7NTH+iDcIiaPaO
         rkLqmyQDYYJo+zuiKooioxCDVuAff+qyw0WPD1Tgsk5xvkOZUYM9vILlI6jrbD3MQ6QY
         AcWtc0ie1rHZVCYm8wb/is7fL/b5Mi/osYXGSFoq12+KVjhczyqOHOgenXfNv2E9osOv
         do9F8mzGPzpDlADIER7/G3uKlbL8CfCzdl261Dp4Ik903lUzN/sdAJvL+bjDJQBH78vw
         5LSw==
X-Gm-Message-State: AOAM533NRwr0IwS0ZdGgMT16hQZBTV8fBFhSQ7TuiZAQW5/gtJ5fBPdV
        t1nZ8yv9EWEjAC28SgwCNegv5A==
X-Google-Smtp-Source: ABdhPJz6cpuNWJjH26XrDJUo+kRNx4ojf/ksC3gj1/vmgDdieL8PaiWXNPxQsuZSqgO4P3XxcpmNHA==
X-Received: by 2002:a02:cc53:: with SMTP id i19mr379146jaq.124.1630540096213;
        Wed, 01 Sep 2021 16:48:16 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id k21sm38569ioh.38.2021.09.01.16.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:48:15 -0700 (PDT)
Date:   Wed, 1 Sep 2021 23:48:12 +0000
From:   Oliver Upton <oupton@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 07/12] KVM: arm64: selftests: Add support to get the
 vcpuid from MPIDR_EL1
Message-ID: <YTARPBhMHXjgcPlg@google.com>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-8-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211412.4171835-8-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:14:07PM +0000, Raghavendra Rao Ananta wrote:
> At times, such as when in the interrupt handler, the guest wants to
> get the vCPU-id that it's running on. As a result, introduce
> get_vcpuid() that parses the MPIDR_EL1 and returns the vcpuid to the
> requested caller.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/include/aarch64/processor.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index c35bb7b8e870..8b372cd427da 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -251,4 +251,23 @@ static inline void local_irq_disable(void)
>  	asm volatile("msr daifset, #3" : : : "memory");
>  }
>  
> +#define MPIDR_LEVEL_BITS 8
> +#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
> +#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
> +#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
> +	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
> +
> +static inline uint32_t get_vcpuid(void)
> +{
> +	uint32_t vcpuid = 0;
> +	uint64_t mpidr = read_sysreg(mpidr_el1);
> +
> +	/* KVM limits only 16 vCPUs at level 0 */
> +	vcpuid = mpidr & 0x0f;
> +	vcpuid |= MPIDR_AFFINITY_LEVEL(mpidr, 1) << 4;
> +	vcpuid |= MPIDR_AFFINITY_LEVEL(mpidr, 2) << 12;
> +
> +	return vcpuid;
> +}

Are we guaranteed that KVM will always compose vCPU IDs the same way? I
do not believe this is guaranteed ABI.

For the base case, you could pass the vCPU ID as an arg to the guest
function.

I do agree that finding the vCPU ID is a bit more challenging in an
interrupt context. Maybe use a ucall to ask userspace? But of course,
every test implements its own run loop, so its yet another case that
tests need to handle.

Or, you could allocate an array at runtime of length KVM_CAP_MAX_VCPUS
(use the KVM_CHECK_EXTENSION ioctl to get the value). Once all vCPUs are
instantiated, iterate over them from userspace to populate the {MPIDR,
VCPU_ID} map. You'd need to guarantee that callers initialize the vGIC
*after* adding vCPUs to the guest.

--
Thanks,
Oliver

>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 
