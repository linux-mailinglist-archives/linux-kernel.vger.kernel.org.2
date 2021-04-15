Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D514360227
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhDOGHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229793AbhDOGHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618466831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zQpfJqpx9ouYTivVYHq0zZnLNXpxnHkEi/8kwyW1R0=;
        b=a0v1mNj/cgE58K7k80u+PLWYSEpOGbbSEr2S8zSxzQ77fG9rSL6nH3ZSvomZTSaq/gzHis
        rkNCE+4q2E90VDqb2TFKjZgwNIeLzaLTaQqhK9LA2HeKhOhTi3QhzrBvqn1/vUfeAG44zn
        WSn61MF6IiBcAQHx1B2fFcnUelcJR3E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-JQoklg8MOzuDJUNEbGyAsQ-1; Thu, 15 Apr 2021 02:07:09 -0400
X-MC-Unique: JQoklg8MOzuDJUNEbGyAsQ-1
Received: by mail-ej1-f70.google.com with SMTP id j25-20020a1709060519b029037cb8ca241aso537138eja.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 23:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+zQpfJqpx9ouYTivVYHq0zZnLNXpxnHkEi/8kwyW1R0=;
        b=CYKgopsRNM5g2G7Z+7TGQoDlr9U9pDGD0y7OyFZQNnL6B5AbbVv9MDfiexGMSUVWHl
         pameKHpf9NQzZPeSU7bVjqhmJyrVNQ5j379G2aCHbeqwfHWCXeyN+n55ttoibL81G48s
         yPqYUbpxDpbhKDWJZ0JetMziIbUeciRTYSBxutC+wqbyXrqGxHrEBdrJA1EMb/IVLKyp
         rmEZuGHMWXbmRlHDB8mO3b8mBxWfjFJthUc6B5LvLulNn/fNBKUi189uZyXBpSQ8F0F2
         J4VU0mbdTqYqDQx6Pi1W2Xynfdfydg1D71z1l7XC+eX1I7YPpAiLFlhKBlRK5I8HO+4y
         c6iQ==
X-Gm-Message-State: AOAM533cz6VCoCSM+dmhZfU1e5kqHTYwH9CdTfbHYiG3IbFKrxSe5XdK
        mBUQGi3J7a/andKRuvEEaMPQT2sK7iP6w89VwdG0H09XfSWH4bBagEZttaOzg5++slEd9mqWuTn
        ye4cxdlsOMQeImuq3Ru2jI+Ow
X-Received: by 2002:a17:906:5052:: with SMTP id e18mr1711345ejk.112.1618466828689;
        Wed, 14 Apr 2021 23:07:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRvvfi/7R2Qj/6IiukMYJNx/KuJdr6BgooLpTLPmk3qQeui/HM+RKSnJeBX/QpfGrRkoxWTw==
X-Received: by 2002:a17:906:5052:: with SMTP id e18mr1711322ejk.112.1618466828430;
        Wed, 14 Apr 2021 23:07:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id f11sm1113767ejc.62.2021.04.14.23.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 23:07:07 -0700 (PDT)
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Filippo Sironi <sironi@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "v4.7+" <stable@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20201127112114.3219360-1-pbonzini@redhat.com>
 <20201127112114.3219360-3-pbonzini@redhat.com>
 <CAJhGHyCdqgtvK98_KieG-8MUfg1Jghd+H99q+FkgL0ZuqnvuAw@mail.gmail.com>
 <YHS/BxMiO6I1VOEY@google.com>
 <CAJhGHyAcnwkCfTcnxXcgAHnF=wPbH2EDp7H+e74ce+oNOWJ=_Q@mail.gmail.com>
 <80b013dc-0078-76f4-1299-3cff261ef7d8@redhat.com>
 <CAJhGHyChfXdcAMzzD7P3aC8tnhFW5GvOt88vOY=D3pyb7hgNAA@mail.gmail.com>
 <6d9dafb1-b8ff-82ef-93dc-da869fe7ba0f@redhat.com>
 <CAJhGHyA=v_va2QTvo7Ve8JyZO4j5LjiCdB9CLnvRXGwGwa3e+A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] KVM: x86: Fix split-irqchip vs interrupt injection
 window request
Message-ID: <5b422691-ffc5-d73a-1bda-f1ee61116756@redhat.com>
Date:   Thu, 15 Apr 2021 08:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyA=v_va2QTvo7Ve8JyZO4j5LjiCdB9CLnvRXGwGwa3e+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/21 02:59, Lai Jiangshan wrote:
> The next call to inject_pending_event() will reach here AT FIRST with
> vcpu->arch.exception.injected==false and vcpu->arch.exception.pending==false
> 
>>           ... if (!vcpu->arch.exception.pending) {
>>                   if (vcpu->arch.nmi_injected) {
>>                           static_call(kvm_x86_set_nmi)(vcpu);
>>                           can_inject = false;
>>                   } else if (vcpu->arch.interrupt.injected) {
>>                           static_call(kvm_x86_set_irq)(vcpu);
>>                           can_inject = false;
>
> And comes here and vcpu->arch.interrupt.injected is true for there is
> an interrupt queued by KVM_INTERRUPT for pure user irqchip. It then does
> the injection of the interrupt without checking the EFLAGS.IF.

Ok, understood now.  Yeah, that could be a problem for userspace irqchip 
so we should switch it to use pending_external_vector instead.  Are you 
going to write the patch or should I?

Thanks!

Paolo

> My question is that what stops the next call to inject_pending_event()
> to reach here when KVM_INTERRUPT is called with exepction pending.

