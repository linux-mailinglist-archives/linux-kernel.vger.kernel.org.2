Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD6944B1CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhKIRSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231695AbhKIRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636478132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGhgPsu0z2GFCYg9O+d6y/Kg2u3fb1TKd+Ptumf/b6w=;
        b=VLkG8BiVcSz6KGTdvq+q4x1Pe5knQ39te/jF2KGygojFRoozJMXYoL/xLYFRaWvo234pCc
        ih0gq6V79zGnx6zPrE6RbS93iL5M9f80etZBcoT0GxfjiewMr4d7QoRArQbfSbFGaf+2Sv
        Su7YqzCVMxiH+/hc65Rc0ZQgPot2k9g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-5OVjJEqaMbCOnnXOhfHKLA-1; Tue, 09 Nov 2021 12:15:28 -0500
X-MC-Unique: 5OVjJEqaMbCOnnXOhfHKLA-1
Received: by mail-ed1-f69.google.com with SMTP id o15-20020a056402438f00b003e32b274b24so8024406edc.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 09:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AGhgPsu0z2GFCYg9O+d6y/Kg2u3fb1TKd+Ptumf/b6w=;
        b=LQeULESmyyOzG/vOSS7dIn7YnY/7SA+Xhyv4B6zVo1DADYMqaxno4XPXn7/ClIwc1W
         aPB5TGo71eF4yvfLg1SrMA93Juwp/RHGsniKuJrZdbWMr0GXmJjg8HKQ9CfK5SvqXr+J
         B/GNCOoN3eziuOPCvDdGt8Mnavls+2jW2BvnxeMi3H5RhW3JrPdLyZDBU+yGuXUN0x5+
         Akgge+7j1OaUPa2mSaWq0u7zUV7oQlfZz2ChNVfZwUNNy8q/0OkpVPVcjNIqeLkY7MsB
         MzBJoH1TmY9MgwAmgl6mt2zi1Eek3AXHEHCstOUpkBS8Kf0xE29kOxbumprc/MRHcwvb
         P9vw==
X-Gm-Message-State: AOAM533ZRmScKaH+4CDhxtbITG9ao3watcuC1UfpFFW7W1vScvzT5r/x
        3HfAl0J4aINBft+IhlToce2StcEXKOwXd1pjyqEwcAt7UXARBfJ+apxe9GoqwW5jqC6e3Xrqo8a
        gqptafTLTq1djCEwko5BgKcsl
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr11366153ejc.474.1636478126752;
        Tue, 09 Nov 2021 09:15:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMlrtNZLLC+LMoCplKRl736/WYqV75KfF9PMIgfwt9lgWe8WiRGO0qDW9yGOAmKphSgesVAg==
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr11366104ejc.474.1636478126547;
        Tue, 09 Nov 2021 09:15:26 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id nd36sm10045328ejc.17.2021.11.09.09.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 09:15:25 -0800 (PST)
Message-ID: <3966eaf0-ed8e-c356-97dd-f8c5c3057439@redhat.com>
Date:   Tue, 9 Nov 2021 18:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v2 24/69] KVM: x86: Introduce "protected guest"
 concept and block disallowed ioctls
Content-Language: en-US
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     isaku.yamahata@gmail.com,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <482264f17fa0652faad9bd5364d652d11cb2ecb8.1625186503.git.isaku.yamahata@intel.com>
 <02ca73b2-7f04-813d-5bb7-649c0edafa06@redhat.com>
 <209a57e9-ca9c-3939-4aaa-4602e3dd7cdd@amd.com>
 <6f0d243c-4f40-d608-3309-5c37536ab866@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <6f0d243c-4f40-d608-3309-5c37536ab866@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 14:37, Xiaoyao Li wrote:
> 
> Tom,
> 
> I think what you did in this commit is not so correct. It just silently 
> ignores the ioctls insteaf of returning an error to userspace to tell 
> this IOCTL is not invalid to this VM. E.g., for 
> kvm_arch_vcpu_ioctl_get_fpu(), QEMU just gets it succesful with fpu 
> being all zeros.

Yes, it's a "cop out" that removes the need for more complex changes in 
QEMU.

I think for the get/set registers ioctls 
KVM_GET/SET_{REGS,SREGS,FPU,XSAVE,XCRS} we need to consider SEV-ES 
backwards compatibility.  This means, at least for now, only apply the 
restriction to TDX (using a bool-returning function, see the review for 
28/69).

For SMM, MCE, vCPU events and for kvm_valid/dirty_regs, it can be done 
as in this patch.

Paolo

