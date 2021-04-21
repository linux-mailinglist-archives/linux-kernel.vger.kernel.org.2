Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431E0366A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbhDUMET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238956AbhDUMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619006622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aoa98lbKIkfUuinek7AZtQ3bY9C9ca5MGA8QkBftOUQ=;
        b=TjrXiz/vcuWFDHx7w+FLZTruxWpRQon0tkRtXQroErsgzUBmYuoe6UrYVCEbY0sSu+TacC
        Jf+Ohm+qe1SLdbeshEhcOzuKXxFn2blDbRD2crfxB9zLoQCFA/Gw9UZmkifMUhoEYRcmzc
        LzrEQKWAa3PrhOpzLi3FqVmYMyB7/cs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-AMOfeaQyN2-PKS8iCJWjkw-1; Wed, 21 Apr 2021 08:03:41 -0400
X-MC-Unique: AMOfeaQyN2-PKS8iCJWjkw-1
Received: by mail-ed1-f70.google.com with SMTP id c13-20020a05640227cdb0290385526e5de5so4856391ede.21
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aoa98lbKIkfUuinek7AZtQ3bY9C9ca5MGA8QkBftOUQ=;
        b=eUy5Lz3sv0FGMV/bA95cvMj7wbpLLDGTzSRUa49SExitP4dPd7zsM0oCR9lx+GNgqt
         vfC/TLLXYkFlcx3vd6HzTJGfNOZ72okchNR6oQYYJx6MyAF1dmVDZM6h2nJfQSNSTB0V
         kdSU1WsLSeFu8jwCPQQDxPhvvn5uTPTJ73Hf51TAxLQhxnBSdgTrqrF09juY4H45lulg
         AouMSfcoyrQsSFRhc9NkzqjXYoG3TJfqDOyPGg0kNPEwkx8ce4ZJpa9SaFoKZarJBrvq
         398/QkBFAF7HJv2IcwNRgiKbM3wB3ZdTkK0xegCaNoJAapTHMehVhP6H3a6KBQy8XFvw
         8CoA==
X-Gm-Message-State: AOAM530201Qr0XKS/GvopkKEdA63hA3QVuhF3E8qP87B43ndbWVc9KTO
        QsyHB3XmlTMVJKOGge4Vm9NLboXAbipiJrSlsb+EJt3a96GuUbKff5cbcr2+prjDO7zc89xkF3z
        rx6ca6ACaxXRkWDkhn5xB0nya
X-Received: by 2002:a17:906:48c6:: with SMTP id d6mr19684012ejt.376.1619006619765;
        Wed, 21 Apr 2021 05:03:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmO54JKOiecI4sAlWSGZNU5i0/sa3KUAYs6Z7y0lYplS6vtWGxsQ3sDXkE6LHhUqB82AYBSA==
X-Received: by 2002:a17:906:48c6:: with SMTP id d6mr19683983ejt.376.1619006619601;
        Wed, 21 Apr 2021 05:03:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id br14sm2296525ejb.61.2021.04.21.05.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 05:03:38 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86: guest interface for SEV live migration
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        srutherford@google.com, joro@8bytes.org, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, Ashish Kalra <ashish.kalra@amd.com>
References: <20210420112006.741541-1-pbonzini@redhat.com>
 <YH8P26OibEfxvJAu@google.com>
 <05129de6-c8d9-de94-89e7-6257197433ef@redhat.com>
 <YH8lMTMzfD7KugRg@google.com> <YH82qgTLCKUoSyNa@google.com>
 <4b96c4fc-23a4-0bd2-ea58-fa6d81e50b15@redhat.com>
 <YH9aj8FLQ4z4Po/x@google.com> <YH9hyid+zyQN1GUw@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <478030b2-7521-4080-c3de-46533c2cc3cf@redhat.com>
Date:   Wed, 21 Apr 2021 14:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YH9hyid+zyQN1GUw@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/21 01:20, Sean Christopherson wrote:
> If userspace blindly copies CPUID, but doesn't
> enable the capability, the guest will think the hypercall is supported.  The
> guest hopefully won't freak out too much on the resulting -KVM_ENOSYS, but it
> does make the CPUID flag rather useless.

Yes that's why the CPUID bit must *not* be in KVM_GET_SUPPORTED_CPUID.

> The
> guest hopefully won't freak out too much on the resulting -KVM_ENOSYS, but it
> does make the CPUID flag rather useless.
> 
> We can make it work with:
> 
> 		u64 gpa = a0, npages = a1, enc = a2;
> 
> 		if (!guest_pv_has(vcpu, KVM_FEATURE_HC_PAGE_ENC_STATUS))
> 			break;
> 
> 		if (!PAGE_ALIGNED(gpa) || !npages ||
> 		    gpa_to_gfn(gpa) + npages <= gpa_to_gfn(gpa)) {
> 			ret = -EINVAL;
> 			break;
> 		}
> 
> 		if (!vcpu->kvm->arch.hypercall_exit_enabled) {
> 			ret = 0;
> 			break;
> 		}
> 
> 		[...]

The interaction with KVM_CAP_ENFORCE_PV_FEATURE_CPUID scares me.  But 
I'll take it into account when posting v2.

>>>> (BTW, it's better to return a bitmask of hypercalls that will exit to
>>>> userspace from KVM_CHECK_EXTENSION.  Userspace can still reject with -ENOSYS
>>>> those that it doesn't know, but it's important that it knows in general how
>>>> to handle KVM_EXIT_HYPERCALL).
>
> Speaking of bitmasks, what about also accepting a bitmask for enabling the
> capability?  (not sure if the above implies that).  E.g.

Yes, makes sense.

Paolo

