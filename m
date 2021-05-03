Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3CA37161C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhECNnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234378AbhECNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620049366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jh0/hHrHbLzaHCSYuT1pc5Fh+CANKYVwkmu3cpQk8WE=;
        b=ZaU0qPUCoEZ589gG9GyGR90voP8o+toJN4k/YRij9j1bJtC5y482Mn+tWwC5SmvNmeQhIF
        2gHAPoGDwgT7b3hHXtSrDgnD9wp0eIJfYYxWSI0ipozbsEgiXosqq6Ku8AJeAP6kRmT0BW
        gGx21HtIw+9VZ+kcwWy0wXiDUph7WuQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-YIM8cc2TOga81B56ksCvxA-1; Mon, 03 May 2021 09:42:44 -0400
X-MC-Unique: YIM8cc2TOga81B56ksCvxA-1
Received: by mail-ed1-f71.google.com with SMTP id i2-20020a0564020542b02903875c5e7a00so4532606edx.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 06:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jh0/hHrHbLzaHCSYuT1pc5Fh+CANKYVwkmu3cpQk8WE=;
        b=lymTwGWSDrTq7xWxpf0yVQcnWACclHIiLzafWgu7UKAaYGX0BfSNB2PXKRpVpl/qgE
         2QV9pPkp+iIxE7Oid59rGLatkAhSUgHX3bfdaEzIXEYP8DbKIjxErVGRBDsliTnUtCmX
         lil8Nh9iWLQm4Synl6EY+C9ojvAX6x6SoJ+eDTzHkiB+cYT/RdwhBrklDUWugbLVOc61
         rItkwOQKuQ62NcAyCsgO0bFy/eNfcH494Y1jyRS4JoeamsM960FWul//sOXXxm2hNewO
         jz8d2B85ZqNKDLrVxy2jRpL97vWT8T20RZY8JeTxkfY0uRAU80wViPgo5pjGpDLoKooq
         r+Hw==
X-Gm-Message-State: AOAM532d75tAE0DeA6QgxtB9LaJjrI1aD4La1guSKAXjCC1WYPHCxA3A
        pVlmtW36ye8CctQc6mSbrPetW62KPc/tDg1PLjsee+wyoiMKPHEnQ4hJ1SaE+9qO5YrGT54jApZ
        ZhrQT4S3NtmFHlprogvs0gr0+
X-Received: by 2002:a50:ed0c:: with SMTP id j12mr20095435eds.12.1620049363350;
        Mon, 03 May 2021 06:42:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT1FEL4DEzuhWsaXKj6xN8HE6TDqjHPEBH/r40+4+mMkvdP67JaLFWtCoHZkMx52g29PwGSw==
X-Received: by 2002:a50:ed0c:: with SMTP id j12mr20095421eds.12.1620049363215;
        Mon, 03 May 2021 06:42:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q16sm12725801edv.61.2021.05.03.06.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 06:42:42 -0700 (PDT)
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210429211833.3361994-1-bgardon@google.com>
 <20210429211833.3361994-8-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/7] KVM: x86/mmu: Lazily allocate memslot rmaps
Message-ID: <ad4ccd85-a5c0-b80f-f268-14ed0f82a3ad@redhat.com>
Date:   Mon, 3 May 2021 15:42:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429211833.3361994-8-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/21 23:18, Ben Gardon wrote:
> +int alloc_memslots_rmaps(struct kvm *kvm, struct kvm_memslots *slots)

This can be static, can't it?

Paolo

> +{
> +	struct kvm_memory_slot *slot;
> +	int r = 0;
> +
> +	kvm_for_each_memslot(slot, slots) {
> +		r = alloc_memslot_rmap(kvm, slot, slot->npages);
> +		if (r)
> +			break;
> +	}
> +	return r;
> +}
> +

