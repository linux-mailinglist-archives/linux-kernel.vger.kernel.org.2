Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5E3726E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEDIH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229815AbhEDIH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620115592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLKysQTV4YSvTWozBBPWCa8Guy98Cew7Li+JKEFqCjc=;
        b=QoOU0fsu+B2yc6Zy0DFoTE7Xi7td5oozijyiv1o07TjBzMGkkolbjiX4qtRP/O0QlcVNvc
        u09mscZgLNb/P0sPIorNe0aWeQc8Yaf2h+4VlQzUFdGvKauAprDkguPodF8VjC2OrctPHV
        k4P8e3wITuVxEr0F2yieqzlRD0rk/W0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-oGFz4xJhNgqD1W9TiZO59g-1; Tue, 04 May 2021 04:06:31 -0400
X-MC-Unique: oGFz4xJhNgqD1W9TiZO59g-1
Received: by mail-ej1-f70.google.com with SMTP id bi3-20020a170906a243b02903933c4d9132so2830936ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 01:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLKysQTV4YSvTWozBBPWCa8Guy98Cew7Li+JKEFqCjc=;
        b=CWMr0pOOETBJUCSG9p82acjaOg8GIeGvEbd1ZwF1amhwWDqNHxmYukA0RQ0ZeiVOEV
         s7UQ31MWOYQvbUOfNU5p1h/GnaUkYsQ5P/qdFbRuyE3hHYEP3XWZw7Ats75qJkdiAhVV
         H2+O3RoYEUdCU6K8qD5JORiY9a76KU4eCDeMiKGPpNJ03a7H2AWSxdTXnjArNXqcQvos
         qlNHE/mXOMS4taPDWv26QxwPULpfvlAmiuPri6q85eYn22+N/1cgbGrUg5JYR4iSga0n
         KfHrXo/M1d3Jzzq3aXPmt+rjXa0lyIvt8tbbwEZET353wM4nJq8Qpx8PfB+nyyebogm/
         EL3g==
X-Gm-Message-State: AOAM530rp9cRtYooQNvQXbyOOR+jvVazvrGM9FU1DfZ+zdRqerfIbmnr
        Kw0+XVvY7QK+lGYFGVStcnb+xu5wbchDKyY+rdPioK7fpF3ZAiOpO1xlNDQJi4TIK1hpOM423Vb
        gJHAgKk61juMjE+pjj3Mvzr7VUSCu66vb5hhRMIYFUZfsjzgmqaEVYbcF0XWiWi6OPy+XvCOG5C
        4z
X-Received: by 2002:a17:906:5285:: with SMTP id c5mr9840087ejm.282.1620115589440;
        Tue, 04 May 2021 01:06:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybH1LFqY7rks+Hn7YEbWIOw03EQChstO5Gf6zE7RPJZokiRExRemQ/1tQ5EmeZinwbeVW0Fw==
X-Received: by 2002:a17:906:5285:: with SMTP id c5mr9840060ejm.282.1620115589186;
        Tue, 04 May 2021 01:06:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f24sm13707548edt.44.2021.05.04.01.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 01:06:28 -0700 (PDT)
Subject: Re: [PATCH 4/4] KVM: nVMX: Map enlightened VMCS upon restore when
 possible
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210503150854.1144255-1-vkuznets@redhat.com>
 <20210503150854.1144255-5-vkuznets@redhat.com>
 <87de6570-750c-5ce1-17a2-36abe99813ac@redhat.com>
 <87h7jjx6yh.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <83f9d6af-a3b1-a115-6f19-cbdf8693af11@redhat.com>
Date:   Tue, 4 May 2021 10:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87h7jjx6yh.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 10:02, Vitaly Kuznetsov wrote:
> I still dislike the divergence and the fact
> that 'if (vmx->nested.hv_evmcs)' checks scattered across the code are
> not fully valid. E.g. how do we fix immediate KVM_GET_NESTED_STATE after
> KVM_SET_NESTED_STATE without executing the vCPU problem?

You obviously have thought about this more than I did, but if you can 
write a testcase for that as well, I can take a look.

Thanks,

Paolo

