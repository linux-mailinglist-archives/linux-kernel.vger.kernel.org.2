Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1921D3907D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhEYRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231805AbhEYRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621964072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nq350MACz4Fig01ElZSgRJ9srEfq331nm9FACh4vpWs=;
        b=Z2e5fzhBACYR7KvaEZ44dRXIkOaGcd/PP0qvhmoB/tei3C8IGrIsSA3f7u61d3SEBCsXqA
        qAkKccCSE9rkSqosGOSyn2oYUEgTUVWMYAW/JxAo4KUvmDhw0gVHYdIFfonAa6c3ea5B8g
        Bh8v8YHrqfsslMy3VnhzWsB39yJs1fE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-9jie9b14OqGzvnUVT3Hsqg-1; Tue, 25 May 2021 13:34:07 -0400
X-MC-Unique: 9jie9b14OqGzvnUVT3Hsqg-1
Received: by mail-ed1-f69.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so17752565edb.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nq350MACz4Fig01ElZSgRJ9srEfq331nm9FACh4vpWs=;
        b=qY5272Es807XMtCt2wM/95OC30pMTxf8T84FuGIC2v0Qu52ANcrZUpKzPxFZPzpEOQ
         VrUE/GqdB1rwXoHerohyF5IO0xYtgbMytQ59n4QxtGyTQ+t2Bv1/6yABALvguQfepcDW
         PQd/cW+0wV9PaSzPs17MUM98ZohyQix07GNoghr1EegW+WG/feIYEaVmUl0zKx7NZe94
         Hszf9+IFfIUuh91/PiyLkpu4w0axuWccnbbShLYki1FEnOZytMqg0+9h8POkrM4uoNi9
         4elWcukYe9GkCjkr4fIfjLTJWdrvLL7COfJ7ACdfnxeNqk7H8yKreqCibZ9iR5Tm4tTy
         p04g==
X-Gm-Message-State: AOAM532RZXeX4mmST5+eVrq1MQi8ZdwmJISJu9gKdW7ampoIA+fpYgX/
        ywqsw0lJU8tZnYOzQLDoe60tQEED1aspPINuRD4aOCYwwYTXkxCrOKIyW2EKM0T3A83fYmQ+RQ8
        pH5zkvG+1EADzAH5zk5UfX9rS
X-Received: by 2002:a17:907:d1a:: with SMTP id gn26mr27156821ejc.42.1621964046261;
        Tue, 25 May 2021 10:34:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwXFI7D3EngljRDF73EgBxapIMlB5miiRiuN8uy1zQYXoGOwQKYxA5P+PVQ1yF38Y5BJnzLg==
X-Received: by 2002:a17:907:d1a:: with SMTP id gn26mr27156797ejc.42.1621964046001;
        Tue, 25 May 2021 10:34:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s2sm11374671edu.89.2021.05.25.10.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 10:34:04 -0700 (PDT)
Subject: Re: [PATCH v3 09/12] KVM: VMX: Remove vmx->current_tsc_ratio and
 decache_tsc_multiplier()
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Stamatis, Ilias" <ilstam@amazon.com>,
        "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "zamsden@gmail.com" <zamsden@gmail.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>
References: <20210521102449.21505-1-ilstam@amazon.com>
 <20210521102449.21505-10-ilstam@amazon.com>
 <2b3bc8aff14a09c4ea4a1b648f750b5ffb1a15a0.camel@redhat.com>
 <YKv0KA+wJNCbfc/M@google.com>
 <8a13dedc5bc118072d1e79d8af13b5026de736b3.camel@amazon.com>
 <YK0emU2NjWZWBovh@google.com>
 <0220f903-2915-f072-b1da-0b58fc07f416@redhat.com>
 <YK0nGozm4PRPv6D7@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <204c0b60-5e39-eb61-da85-705c56604cde@redhat.com>
Date:   Tue, 25 May 2021 19:34:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YK0nGozm4PRPv6D7@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/21 18:34, Sean Christopherson wrote:
>> I actually like the idea of storing the expected value in kvm_vcpu and the
>> current value in loaded_vmcs.  We might use it for other things such as
>> reload_vmcs01_apic_access_page perhaps.
> I'm not necessarily opposed to aggressively shadowing the VMCS, but if we go
> that route then it should be a standalone series that implements a framework
> that can be easily extended to arbitrary fields.  Adding fields to loaded_vmcs
> one at a time will be tedious and error prone.  E.g. what makes TSC_MULTIPLIER
> more special than TSC_OFFSET, GUEST_IA32_PAT, GUEST_IA32_DEBUGCTL, GUEST_BNDCFGS,
> and other number of fields that are likely to persist for a given vmcs02?

That it can be changed via ioctls in a way that affects both vmcs01 and 
vmcs02.  So TSC_MULTIPLIER is in the same boat as TSC_OFFSET, which I 
agree we should shadow more aggressively, but the others are different.

Paolo

