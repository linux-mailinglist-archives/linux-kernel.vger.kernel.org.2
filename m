Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE0744C966
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhKJTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhKJTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:51:14 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ADFC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:48:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 200so3188729pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qWWY/WFn1LBOS2/O0/NN84UY90autzk0HN9I5jipZ5A=;
        b=TdtMLeoOs4YDDP9l/fDTv+mYOridUBpGzMra6tDgeLO2nGc3a/uuZBFtru6h2oRDo/
         WIuFnpZTxPppVFkgZOgc2RaLFngZq+Gx4/NwhKP3P4y7S7YANx6F0zcwYfEWz+X1su3h
         sY2T8/s/9S5yhC+BeiZvu1NadcxylBrH+SKDiQMd/41jQzs1cBGNwAeYhbrMvH84m5Vi
         SZBWhWSs9llt6YiVjJzj57KKlFEl1WVqKU6lxkNpi8snMQKfHi+iTWiFHO6iEEp/dVDK
         itA4dJe0iL4Ca7wB/4RjqQp733DyK0hDQP0pRFAfvUmRs7fXWa8/ls3eqwWqzV15CWMK
         ntxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWWY/WFn1LBOS2/O0/NN84UY90autzk0HN9I5jipZ5A=;
        b=3P/UCNiZyCL8v/6JQoVrxYKrmuJIiYuDFB+9X+TxhPDB2iDRLfBTWTXTlWtoDACQNd
         AOMhfTHrgC9f+bimdkNXEWT4q8KgjeTLkQFvJ4nCSKKyhuNjzQ1WT/ZBLtxtYcLpjkku
         OU8rZYxeKR/sFp/phkYE4b73RiyDhRyDBajDWIv7W3ioGcE4o2UFtqoW/8VJ3NOHGSFW
         OLVM0bEXo2MkaC/X9ybgKJqE9hNKNlCwGgqWisStLhFFHF9GVAhfUVLfM1yu615w+5gv
         HOkF65z9kojXqyEu/Sj6LjD69wFDh54C30bMEWNXG3kA+Frt4KAWSmzgHUsDCXa5e2L+
         JahA==
X-Gm-Message-State: AOAM530lDSAre9XBfiFWY/FCu4oDMm8M68uk2xAk+Z2WDcGDhDpqPH0j
        m9HzFLtdfv+kJ0xNIGezq6wXOw==
X-Google-Smtp-Source: ABdhPJzC5p22wmi8/04JU3OHJvwZiRpWURdZ0hDXX9GmLLjx79g6w1p1MV8F3X+/3ntVGIcAw0a+HQ==
X-Received: by 2002:a05:6a00:1a43:b0:49f:ef23:a358 with SMTP id h3-20020a056a001a4300b0049fef23a358mr1686299pfv.50.1636573705988;
        Wed, 10 Nov 2021 11:48:25 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u38sm504559pfg.0.2021.11.10.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:48:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 19:48:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, peterz@infradead.org,
        hpa@zytor.com, thomas.lendacky@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 2/2] KVM: SVM: Extend host physical APIC ID field to
 support more than 8-bit
Message-ID: <YYwiBbyUINIcGXp3@google.com>
References: <20211110101805.16343-1-suravee.suthikulpanit@amd.com>
 <20211110101805.16343-3-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110101805.16343-3-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021, Suravee Suthikulpanit wrote:
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 989685098b3e..0b066bb5149d 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1031,6 +1031,12 @@ static __init int svm_hardware_setup(void)
>  			nrips = false;
>  	}
>  
> +	if (avic) {
> +		r = avic_init_host_physical_apicid_mask();
> +		if (r)
> +			avic = false;
> +	}

Haven't yet dedicated any brain cells to the rest of the patch, but this can be
written as

	if (avic && avic_init_host_physical_apicid_mask())
		avic = false;

or 

	avic = avic && !avic_init_host_physical_apicid_mask();

But looking at the context below, combining everything would be preferable.  I
would say split out the enable_apicv part to make it more obvious that enable_apicv
is merely a reflection of avic.

	avic = avic && npt_enabled && boot_cpu_has(X86_FEATURE_AVIC) &&
	       !avic_init_host_physical_apicid_mask();
	enable_apicv = avic;

> +
>  	enable_apicv = avic = avic && npt_enabled && boot_cpu_has(X86_FEATURE_AVIC);
>  
>  	if (enable_apicv) {
