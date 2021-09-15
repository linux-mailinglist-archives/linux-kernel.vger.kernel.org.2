Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C202D40BF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhIOF43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236294AbhIOF41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631685308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xA4ByGlEfEieWx2EOyrJAeS2vRhXErE4knQ2GkX8GRQ=;
        b=C3mYO9dS5MIk8ay23dzigrjpe/uBoQRmyejNgDBWf938KO0n+Fcri8cdiseovSTohuL4NO
        Dcs4FW88TTGw5BggUK62ok9IcYRSMnF9vcNwO4iWW4zZAOwat5jmTm4+Jeupq03Yt/WBdm
        krlPOT7syGOEON/jtwmoN6rA1DdZKUU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-g3rHP0o5P3Sq0k5SzLa9Tw-1; Wed, 15 Sep 2021 01:55:01 -0400
X-MC-Unique: g3rHP0o5P3Sq0k5SzLa9Tw-1
Received: by mail-ej1-f71.google.com with SMTP id p24-20020a17090635d800b005f264e9cb99so904108ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xA4ByGlEfEieWx2EOyrJAeS2vRhXErE4knQ2GkX8GRQ=;
        b=2SIIT92wUg8Ig5sWYiT8C/nBIp0OlIoovF3RAL4HwvxC2VdSJfNGFTlOe7O8lReYJB
         pMAzo4+oNG4fF62yiHzFuvAFdLHV4u8VHDDo6LCu80rIcnoUbB0NmNd9BrCAQuKuvsoe
         aqhmK7l/ijaFuABOqzGHrbZfTKiwPpy4lATM8q8VizAU/lFIe1XnbQGm9gmwBXgPwcuB
         rdHXqAtcIHImy/groam4/WzZXeOAiWeCQLi5x/npD62QuFZWVMdmlCdw7zvQee24CLXq
         679MdAS5neyjgHueBtp/2Xs47L6AeXXE5urCo1g/P3csg4PEFs9W/dZdpvv2GuzyLBE6
         mQ7A==
X-Gm-Message-State: AOAM530Sl1D8gbw2fTy3QpCrxj7BiGUIXoeLgt99Bquj30CjG3SGh9F8
        usbmV+uf2JW8nMW4onEj+Tpk28uilOSpA9e6PZCzeR+8zhgL/p2Tw+nkLWWMExUyPvby7vm4FvQ
        nX1jL7Kg2iYk1PwGt8bG4ZWMo
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr22935871ejb.408.1631685300682;
        Tue, 14 Sep 2021 22:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmQFNRGGALDgSXECb7+CrH4Fm9yKRXtMUcjRCgpoUKc0xeyaWdPjESYb6S0eyWptweOgXupA==
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr22935848ejb.408.1631685300500;
        Tue, 14 Sep 2021 22:55:00 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id ba29sm5086767edb.5.2021.09.14.22.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 22:55:00 -0700 (PDT)
Date:   Wed, 15 Sep 2021 07:54:58 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 09/15] KVM: arm64: selftests: Maintain consistency for
 vcpuid type
Message-ID: <20210915055458.tek6piqjyswxlvfv@gator.home>
References: <20210914223114.435273-1-rananta@google.com>
 <20210914223114.435273-10-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914223114.435273-10-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:31:08PM +0000, Raghavendra Rao Ananta wrote:
> The prototype of aarch64_vcpu_setup() accepts vcpuid as
> 'int', while the rest of the aarch64 (and struct vcpu)
> carries it as 'uint32_t'. Hence, change the prototype
> to make it consistent throughout the board.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  tools/testing/selftests/kvm/include/aarch64/processor.h | 2 +-
>  tools/testing/selftests/kvm/lib/aarch64/processor.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index 515d04a3c27d..27d8e1bb5b36 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -63,7 +63,7 @@ static inline void set_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id, uint
>  	vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, &reg);
>  }
>  
> -void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *init);
> +void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init *init);
>  void aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid,
>  			      struct kvm_vcpu_init *init, void *guest_code);
>  
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index db64ee206064..34f6bd47661f 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -212,7 +212,7 @@ void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
>  	}
>  }
>  
> -void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *init)
> +void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init *init)
>  {
>  	struct kvm_vcpu_init default_init = { .target = -1, };
>  	uint64_t sctlr_el1, tcr_el1;
> -- 
> 2.33.0.309.g3052b89438-goog
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

