Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1C3B1BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFWODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230312AbhFWODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624456893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GI7BUvQGaSJTYs1XHkSa35D9gwv1cTj0EBhXSBIFL1M=;
        b=S1o6A23ECx4vq9DQGGQIOlNVBm08Y2mS+YNEnnH6LeJfkiyRmGqO0ZPtrAYuXOc840GDYd
        DklbtNMjI/+AR+s8tFAVspMAFUx6x6hcEVanSxTTenvxYDjLcCXmkg+sVfhXepsQ8+uBA8
        cJ6etpy6WYVJNpLiC5JW4tpDiTKfrOc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-xZkN8XtAO_yDNv0FmAPdvQ-1; Wed, 23 Jun 2021 10:01:31 -0400
X-MC-Unique: xZkN8XtAO_yDNv0FmAPdvQ-1
Received: by mail-ej1-f69.google.com with SMTP id o12-20020a17090611ccb02904876d1b5532so1019497eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 07:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GI7BUvQGaSJTYs1XHkSa35D9gwv1cTj0EBhXSBIFL1M=;
        b=ByUFnflru4soufCvAB9xCi1BcsXqMB1lAPqF3iKyEqfa+SiDWLclVYdrb2y3KZ0Js+
         bAy4pGJj0nSGs7iaAEANBzkQVzsWAKLcym7m2Fe04Ojv95i65dgOhx1CIFyPYi4Cp8Co
         3wMJKcHWt2/9z7AAgoiSYM1OhYeWveAki3QcCiXRHG16sJyBtBDp+ovsCd6CXQzX6uvJ
         QoKWW0i1SULjXcv+/VMS0LJEFGzyWTJP7Y3lXcxtlmoWKUFF4LLHEw1Yyu+S6fD1i4Um
         a338CrITttOpwL/Cnl0FOJ9Y0JVFRWj8m5i7Gn/sMnNZJpQLH4SNkoEtf6P5AeT5RutT
         1Fmw==
X-Gm-Message-State: AOAM533ykCDR13alUJDAKH6eZ9DgsoieJLvNw5t9mHH6zAnnr8FRH9KH
        4jSSF5X4BZnwCDC6gq7KlPF0+NBtb6K02EDe7QT7+PSPgowj9IvMPY1D11g/f9azJ6vnhXTriHr
        9io0XIL2zs4bkXMIdN2cYCGsd
X-Received: by 2002:a17:906:36d5:: with SMTP id b21mr181071ejc.258.1624456890705;
        Wed, 23 Jun 2021 07:01:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVVzhqdfVDJJTFG6BriT0PEnR8sAnb90HHFIoMhWugO9e/5JQG8bPfqCAHNolqC3qdIS/oPg==
X-Received: by 2002:a17:906:36d5:: with SMTP id b21mr181048ejc.258.1624456890517;
        Wed, 23 Jun 2021 07:01:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u12sm7382464eje.40.2021.06.23.07.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 07:01:29 -0700 (PDT)
Subject: Re: [PATCH 03/54] KVM: x86: Properly reset MMU context at vCPU
 RESET/INIT
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-4-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c3f9251-cab4-70ee-6e38-85fe8e6579f7@redhat.com>
Date:   Wed, 23 Jun 2021 16:01:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:56, Sean Christopherson wrote:
> +	/*
> +	 * Reset the MMU context if paging was enabled prior to INIT (which is
> +	 * implied if CR0.PG=1 as CR0 will be '0' prior to RESET).  Unlike the
> +	 * standard CR0/CR4/EFER modification paths, only CR0.PG needs to be
> +	 * checked because it is unconditionally cleared on INIT and all other
> +	 * paging related bits are ignored if paging is disabled, i.e. CR0.WP,
> +	 * CR4, and EFER changes are all irrelevant if CR0.PG was '0'.
> +	 */
> +	if (old_cr0 & X86_CR0_PG)
> +		kvm_mmu_reset_context(vcpu);

Hmm, I'll answer myself, is it because of the plan to add a vCPU reset 
ioctl?

Paolo

