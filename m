Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79214373222
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhEDV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232971AbhEDV61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620165451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAmBiJFvPA+As7Gl+azsy2uCjLljzEnBHmbNc9z7r40=;
        b=Tv5Fd9/FDRgk6nGem9U7GOjwo5uqj+uyCR7nho6cnJ2FlM1P2QqhhJedpTOVpNZBpVhua4
        Slf0I9Wi5eNW8yqy9UG+e4BNyfvy9NkN/QRJjijtOdKTqy9rJaG/g9oX5Zl4WHLkJsLFeW
        d6NLClUwFGDqWCnFVUI37D3EvhEJW+s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-7faagQNWNGq09WptCGuSuA-1; Tue, 04 May 2021 17:57:30 -0400
X-MC-Unique: 7faagQNWNGq09WptCGuSuA-1
Received: by mail-ej1-f72.google.com with SMTP id p25-20020a1709061419b0290378364a6464so3675359ejc.15
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wAmBiJFvPA+As7Gl+azsy2uCjLljzEnBHmbNc9z7r40=;
        b=EPMq3+WEbe/4aJRyInrBK7S45W2V+aJvghoog143PPrQd9SiDVkCN3AE2EC0P3OdSw
         uN3EfHVfjjEK5JpqAL87HKStdKACZgE0CHMfVV+TKJJYP+8v1m+kl99r9YdFjZxCG7sB
         ekOIyh8pY9zvbYzRGfDqtudDAyKIRnCBHnZa8zGhmN2UJ79ra5468wiD6bOmYIZP8RB4
         VwfSz0Qq4r9tpF++TdFH399+7Dz2ZUC7dlWhaCrPtKYXbv0I1kwTRe7FwuHNPG59TnA8
         yTObRwy2QSN3jMijbLN2UVi2qFyStM1K88OjJrxWtSl2vSa98O8HR3V5uVITH1isJfiW
         tOFw==
X-Gm-Message-State: AOAM533hNTmXmgU2MJKBWLncFvKFH3jygQ0LQzY/sFcEB1PLDz4e5Gg6
        0f/5KASuMbyxlXYimbktWBAgHyQnfMXnhg7Rrl1XQc4UKCHdooZCOHF9s44fl/8kotln4ywJqjK
        X/kPN34w1NIHHHa22zhIgriG9
X-Received: by 2002:aa7:d996:: with SMTP id u22mr28550217eds.342.1620165449234;
        Tue, 04 May 2021 14:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvbNuFIfXZyEjH+O41yqnrvofU1K0RElRQQjLDG628sLCwRQW4kMqQwRj1+fwZgsjtwikdiA==
X-Received: by 2002:aa7:d996:: with SMTP id u22mr28550195eds.342.1620165449012;
        Tue, 04 May 2021 14:57:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id e5sm2051519ejq.85.2021.05.04.14.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 14:57:28 -0700 (PDT)
Subject: Re: [PATCH 03/15] KVM: SVM: Inject #UD on RDTSCP when it should be
 disabled in the guest
To:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
References: <20210504171734.1434054-1-seanjc@google.com>
 <20210504171734.1434054-4-seanjc@google.com>
 <CALMp9eSvXRJm-KxCGKOkgPO=4wJPBi5wDFLbCCX91UtvGJ1qBg@mail.gmail.com>
 <YJHCadSIQ/cK/RAw@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b50b090-2d6d-e13d-9532-e7195ebffe14@redhat.com>
Date:   Tue, 4 May 2021 23:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJHCadSIQ/cK/RAw@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 23:53, Sean Christopherson wrote:
>> Does the right thing happen here if the vCPU is in guest mode when
>> userspace decides to toggle the CPUID.80000001H:EDX.RDTSCP bit on or
>> off?
> I hate our terminology.  By "guest mode", do you mean running the vCPU, or do
> you specifically mean running in L2?
> 

Guest mode should mean L2.

(I wonder if we should have a capability that says "KVM_SET_CPUID2 can 
only be called prior to KVM_RUN").

Paolo

