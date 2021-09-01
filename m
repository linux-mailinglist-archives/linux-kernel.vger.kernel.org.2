Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF93FE615
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbhIAX1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhIAX1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:27:54 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CEC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:26:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b10so145365ioq.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rOUt9lzL9h2nq8MizjgBr+LfkDuELuuwWbBlNJOQ814=;
        b=jR/4VwVeeFqV1reopTHZE859VRG+CTWfBgJ8xN+yYGIx367PJ9Bws70Zg1EV1ucG2W
         Y2lFJoMSCpZf0ZOBx+NjhIwk4yEFfXdTmKpLSNameuBcxm0f3b2xsZjDWWLkXQzioQzB
         rdiu2pi+dfj/LlK0SlnX6FXxRO6MlVrubO0LNbHQ1f2H+r49vZAn5pbFbLXLrAIpkyvv
         0mbcwbkA1+xfcqzsopbM8IzOFTKlUOVzRZtTJtxfRnE1RlJMRGD/lXwDFs9D701+M4E3
         2garEAvPOF6McbV+BoD72/uphVFvhiZwvjqcrhncYz9MizgjNlM4Tikc2xVWnh6P+yPf
         Hg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rOUt9lzL9h2nq8MizjgBr+LfkDuELuuwWbBlNJOQ814=;
        b=EbO+J1JireCNki9T565wy4pxWhXvJmsuRVTE0jn2k7sWj3GctIyLogf4ZyFb3GFH3J
         uCuNslsGECajs99D73lBG+bs8APnB9wZ5ABF/tEh7/XwpYEJzdI3BMdiRFJfE8qjr3R4
         wme+JGsM+zdm+ej8y06MZUMJaQYdVgCwTfr+zoFZ4zzzcTvrgec+zcI0dd4wRPGOAfLT
         iiMHIEfSRQAs+/x9e/Eo1thNBTDX5hHVyS9dC6uOyVepfTHAavyyUiO9IpETGl64exbj
         5Vam/epWoyTv5+bck4UbDkYTVKXkzOYlnCc5qH21wH+f1Y5+mY2u/RXATSRTSwrVOJHn
         hyHQ==
X-Gm-Message-State: AOAM532jHyLd2ho8gD0hCOA5quQ+S3KoYrIP3KmNZ63g0SrwUf41BZSp
        v8qAImYsf2rduUEGz0auzxXneQ==
X-Google-Smtp-Source: ABdhPJzCa6eAMWUaKvrSDwb4bW983RzCXex8DdL6ys7hZpXkcFNe3o+vWqlq6lWO9U5Kc26/5lS5Gw==
X-Received: by 2002:a5d:9b99:: with SMTP id r25mr279115iom.104.1630538816261;
        Wed, 01 Sep 2021 16:26:56 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id q12sm14251ioh.20.2021.09.01.16.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:26:55 -0700 (PDT)
Date:   Wed, 1 Sep 2021 23:26:52 +0000
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
Subject: Re: [PATCH v3 06/12] KVM: arm64: selftests: Add support to disable
 and enable local IRQs
Message-ID: <YTAMPIBDSl1rJHUR@google.com>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-7-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211412.4171835-7-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:14:06PM +0000, Raghavendra Rao Ananta wrote:
> Add functions local_irq_enable() and local_irq_disable() to
> enable and disable the IRQs from the guest, respectively.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Reviewed-by: Oliver Upton <oupton@google.com>

> ---
>  .../testing/selftests/kvm/include/aarch64/processor.h  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index 78df059dc974..c35bb7b8e870 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -241,4 +241,14 @@ static __always_inline u32 __raw_readl(const volatile void *addr)
>  #define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c));})
>  #define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })
>  
> +static inline void local_irq_enable(void)
> +{
> +	asm volatile("msr daifclr, #3" : : : "memory");
> +}
> +
> +static inline void local_irq_disable(void)
> +{
> +	asm volatile("msr daifset, #3" : : : "memory");
> +}
> +
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 
