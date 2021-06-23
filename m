Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FC3B217E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFWUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhFWUEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624478536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wITQxEls1SBROh7qIbfqzCrqr45KUONEom3x8qAlLc=;
        b=M160kHm1wC29/9YXpgZqQU4ZYgQH3XfGrmc7VSTNpOSZlgzzXOwPRlrYYoK1F7uOT0Ex6E
        yc8548C6UT2V/sVOJs5caK2S1QaHyPCp1ShSEw5/1TtRTp7+dcVR7dFkpMPcNtZGJcKhn1
        E5ODJGCdH4lEtbrFNVCAnrO9plBrjVI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-YhRIeFatMg-ywzOmuQGHkA-1; Wed, 23 Jun 2021 16:02:14 -0400
X-MC-Unique: YhRIeFatMg-ywzOmuQGHkA-1
Received: by mail-ed1-f70.google.com with SMTP id z5-20020a05640235c5b0290393974bcf7eso1948540edc.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+wITQxEls1SBROh7qIbfqzCrqr45KUONEom3x8qAlLc=;
        b=kWvh+vQxS5wwql4hEmjLrlKliex8FlmPYfm5PsRmqI9iJKhTT+2/cTv/Y1fypAhOl4
         /g0uKFAWg71tV/09v7mTOw6CEf3zf64S1o1Zt0NQo3vezTqid6ebiysQcfRCXV7ysL1v
         gG5AfYF/rsz4lz2zPJo4uuTkHyYe5shOGtV8yb7q3fXp8iCwJjWBpKjqjTVjoraCAM7N
         yKIpmMKPcfLK/93jtPOmcGVLxUHwcel9hyBQlHeeGI9J75rpFZmaqUToIAOuPhI906iM
         A9DickI5cR6Y5GMZ/8q92Nhv8GUvBA39ifEva5O5R67oqH/5oba3asL4FiobGweYDyZM
         44XA==
X-Gm-Message-State: AOAM531ZRdHpuUkErrb9dUJMRN08kwhzgdq8Di6XuBzcJDR0mEXL4jBF
        p9XvDQLiNFltNYt97mJWUtgAmEF02vs+oqjQ7j7clEkaFVuZ7zT5peNKUGq2w8aayzQ4wXtjSeo
        Yp72HDdGIZSyNALxnIl6CjRpz
X-Received: by 2002:a17:906:4f14:: with SMTP id t20mr1710314eju.398.1624478532803;
        Wed, 23 Jun 2021 13:02:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC61FR9h9pqcksmyOBKdVJfV0+wOITLQi948V0/yXZhz/1HFgRKfZp3KQo29MTBit3KtOR6w==
X-Received: by 2002:a17:906:4f14:: with SMTP id t20mr1710293eju.398.1624478532624;
        Wed, 23 Jun 2021 13:02:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id yh11sm296692ejb.16.2021.06.23.13.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 13:02:12 -0700 (PDT)
Subject: Re: [PATCH 25/54] KVM: x86/mmu: Add helpers to query mmu_role bits
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-26-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1babfd1c-bee1-12e5-a9d9-9507891efdfd@redhat.com>
Date:   Wed, 23 Jun 2021 22:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-26-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:57, Sean Christopherson wrote:
> +static inline bool is_##reg##_##name(struct kvm_mmu *mmu)	\

What do you think about calling these is_mmu_##name?  The point of 
having these helpers is that the register doesn't count, and they return 
the effective value (e.g. false in most EPT cases).

Paolo

> +{								\
> +	return !!(mmu->mmu_role. base_or_ext . reg##_##name);	\
> +}
> +BUILD_MMU_ROLE_ACCESSOR(ext,  cr0, pg);
> +BUILD_MMU_ROLE_ACCESSOR(base, cr0, wp);
> +BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pse);
> +BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pae);
> +BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smep);
> +BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smap);
> +BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pke);
> +BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
> +BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);
> +
>   struct kvm_mmu_role_regs vcpu_to_role_regs(struct kvm_vcpu *vcpu)

