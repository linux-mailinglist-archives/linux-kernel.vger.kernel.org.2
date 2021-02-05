Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1339F310ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhBEL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231455AbhBELxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612525917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmCktuOnRm7rRjEffV558V46c1+z05lPxqdaC1i8oXk=;
        b=aagROOB6ceRekl24mZUjnC5CPrGm/bfGsiLrfwW0dav/8UW4dvNwcCLLLpOGyq4W4IUCQq
        Ww9pFQ531aB7LlALPyQFDLsTu7cNUG1IQdtsRDjtXLoq3H4XF0JQZ3pQtIy2OXdNff3A9H
        NjUF8vF2H9Qet0WiUjavSAXYlsyfOiU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-RLF7ows2P1KDaw37ZkAdwA-1; Fri, 05 Feb 2021 06:51:55 -0500
X-MC-Unique: RLF7ows2P1KDaw37ZkAdwA-1
Received: by mail-wm1-f72.google.com with SMTP id m25so3665808wmi.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmCktuOnRm7rRjEffV558V46c1+z05lPxqdaC1i8oXk=;
        b=S4eygc/rtKU/44ZZ0GRb1tswMPMXylNDEOmxkQsHMZEvtzDxx+Pe/s24HxUYV5sNI/
         uG2+duH8RUnzGpCMaS9Znzj+5PWvRU4GqD9FbiQuy9AwTYLotasErIGelZ4yQ76cAg2o
         oNKfE3KQwzyt1RIlEqzPw5JfbqtpvlgUZv1+iCSYfd2y82Sw7q0/Z5RGkdeVqGMWJO8I
         poLy+PTRcbcr3j3BOomjhrXImF6w7D/c6ppDSZCZihBr2Zja67BJbPHxBV7nM+kcBjF5
         L54Qj5tmn95Gc6FuImTa3wrHXhulcqKvINILJgG3THEJHMUpcKIGLLgHHGgGSyoMwyzB
         dRug==
X-Gm-Message-State: AOAM530++eJClOqv1KSvT9prS5MtmOR0eW42W4ZNw/m2rgRdLTSY2vU/
        i9dBnfV3qa96K8nCfVICGBc8guv+qJ9lcNNOY9FWyDZ11E/wKyKyoOlX2YchvwSiNXn8s9oR/h6
        Wv0MwD6yAj454eOixFDqtd0jq
X-Received: by 2002:a05:600c:4fce:: with SMTP id o14mr3263769wmq.140.1612525914671;
        Fri, 05 Feb 2021 03:51:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2gHg/2LaVDfOa4pIwMU2N3KtRRpiG6VEYIyPS0S37HVi+oNl+bw+W5N9Ew7QjDxE+m8sczQ==
X-Received: by 2002:a05:600c:4fce:: with SMTP id o14mr3263752wmq.140.1612525914440;
        Fri, 05 Feb 2021 03:51:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o18sm8586376wmh.20.2021.02.05.03.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:51:53 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20210205083706.14146-1-chenyi.qiang@intel.com>
 <20210205083706.14146-3-chenyi.qiang@intel.com>
 <8768ad06-e051-250d-93ec-fa4d684bc7b0@redhat.com>
 <20210205095603.GB17488@zn.tnic>
 <e90dadf9-a4ad-96f2-01fd-9f57b284fa3f@redhat.com>
 <87czxeah1z.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/5] KVM: X86: Expose PKS to guest
Message-ID: <8da4bfbb-b2fc-968f-dfea-aa73f11c6405@redhat.com>
Date:   Fri, 5 Feb 2021 12:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87czxeah1z.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 12:29, Thomas Gleixner wrote:
> On Fri, Feb 05 2021 at 11:10, Paolo Bonzini wrote:
>> On 05/02/21 10:56, Borislav Petkov wrote:
>>>> This would need an ack from the x86 people.  Andy, Boris?
>>>
>>> This looks like the PKS baremetal pile needs to be upstream first.
>>
>> Yes, it does.  I would like to have an ack for including the above two
>> hunks once PKS is upstream.
>>
>> I also have CET and bus lock #DB queued and waiting for the bare metal
>> functionality, however they do not touch anything outside arch/x86/kvm.
> 
> What's the exact point of queueing random stuff which lacks bare metal
> support?

The code is often completely independent of bare metal support even if 
it depends of it (CET and bus lock for example only share the #defines; 
for PKS this is not the case just because Intel decided not to use 
XSAVES *shrug*).

I prefer to queue early, because it keeps my backlog small and because 
every resend comes with the risk of random changes sneaking in since the 
version that I reviewed.  An early ack would also mean that I don't have 
to bug you in the middle of the merge window.  But it's not a problem, 
I'll ask for acks again once PKS is merged into tip.

Thanks,

Paolo

> Once PKS, CET or whatever is merged into tip then it's the point for
> resending the KVM patches for inclusion and that's the point where it
> gets acked and not $N month ahead when everything is still in flux.

