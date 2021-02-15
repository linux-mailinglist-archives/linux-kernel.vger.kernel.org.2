Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F131C0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhBORfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:35:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231929AbhBOQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613407529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2lFUCX+4kgOW9WJ4+n8lk62Y3uHoeoTMYbOZCSXAAQ=;
        b=b2GLpVcZTyBf4bt8r/ElESAfdq/W3HI6pAYmFl+Fot8n9sADLnmpL6cPb+PYWEVk9YeLqy
        VRjJv7pSkeJ69xdTVYMk4dkyjPmoUoaplv82NXMxcRC98X4sxyxQVOmGilIQ9Z+UOjQFE7
        qVYcuxsu5TSlIsQgsFIDWIVeZ1OcWGE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-os9IXTeZPbeOUc0AWtrn6Q-1; Mon, 15 Feb 2021 11:45:27 -0500
X-MC-Unique: os9IXTeZPbeOUc0AWtrn6Q-1
Received: by mail-ed1-f69.google.com with SMTP id f21so5465686edx.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v2lFUCX+4kgOW9WJ4+n8lk62Y3uHoeoTMYbOZCSXAAQ=;
        b=V/gFZN9Jalmw7lq98+nMXYk2VMqs1EE0mnPM4UnqRKY4UFLF0oKW3lVzLol62YW8WO
         VdB6Lgp+y/LgUs3yJr8Yx/+bt2hadUk7nmHRd9BzZ/GiLd1uXfTp01QtZCga92ktLgrY
         gZfuRFlpeB2bM3SaXJs5wdffVfhd4Z3G6VBOA/onTjWsRJUretnf9/QnsOOXLm69fAT7
         YV4T1GjGwAJQtN88hz0e68C1BVuytMcxOOlYUgxhe2OyOmALn6qhNmrvuL8lJmEEFFbs
         edg0c6bo1x5pb6Lt6xR3JOU85Hiu4FR7O+4SzVo3gXZ0wWgvc9lM1rviIULDzC96hhgn
         eIIg==
X-Gm-Message-State: AOAM532hh0EPKtEMFnmTGENNPFWDakH/hKlb7kz0HizCfFx+CjWDSLRV
        593HSUK1EUq/FZgd6VNrLAp4NAqVZ9wLWQHpen6piOupCjwrfW/NsDLlOkJ469nX6fX6/m8YYPu
        tG4Oav4LFbXoZCUTW2MAsXufC
X-Received: by 2002:a17:907:11c7:: with SMTP id va7mr16473917ejb.351.1613407526358;
        Mon, 15 Feb 2021 08:45:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBfHqnRxLbv+dwOEC17d5YwjhX3h5Z8eCWeAyeZ1sOKlSQFTMM6XcrEZIe5j+tRH/AafsC8A==
X-Received: by 2002:a17:907:11c7:: with SMTP id va7mr16473899ejb.351.1613407526163;
        Mon, 15 Feb 2021 08:45:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id hc40sm10301803ejc.50.2021.02.15.08.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 08:45:25 -0800 (PST)
Subject: Re: [PATCH 0/3] KVM: x86: SVM INVPCID fix, and cleanups
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>
References: <20210212003411.1102677-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65fa42a3-4f7b-4708-ffce-e77fe32aaed7@redhat.com>
Date:   Mon, 15 Feb 2021 17:45:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210212003411.1102677-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/21 01:34, Sean Christopherson wrote:
> Fix an INVPCID bug on SVM where it fails to injected a #UD when INVPCID is
> supported but not exposed to the guest.  Do a bit of cleanup in patch 02
> now that both VMX and SVM support PCID/INVPCID.
> 
> Patch 03 address KVM behavior that has long confused the heck out of me.
> KVM currently allows enabling INVPCID if and only if PCID is also enabled
> for the guest, the justification being that the guest will see incorrect
> fault behavior (#UD instead of #GP) due to the way the VMCS control works.
> 
> But that makes no sense, because nothing is forcing KVM to disable INVCPID
> in the VMCS when PCID is disabled.  AFACIT, the myth was the result of a
> bug in the original _submission_, not even the original _commit_ was buggy.
> 
> Digging back, the very original submission had this code, where
> vmx_pcid_supported() was further conditioned on EPT being enabled.  This
> would lead to the buggy scenario of unexpected #UD, as a host with PCID
> and INVCPID would fail to enable INVPCID if EPT was disabled.
> 
>>> +	if (vmx_pcid_supported()) {
>>> +		exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
>>> +		if (exec_control & SECONDARY_EXEC_ENABLE_INVPCID) {
>>> +			best = kvm_find_cpuid_entry(vcpu, 0x1, 0);
>>> +			if (best && (best->ecx & bit(X86_FEATURE_PCID)))
>>> +				vmx->invpcid_enabled = true;
>>> +			else {
>>> +				exec_control &= ~SECONDARY_EXEC_ENABLE_INVPCID;
>>> +				vmcs_write32(SECONDARY_VM_EXEC_CONTROL,
>>> +						exec_control);
>>> +				best = kvm_find_cpuid_entry(vcpu, 0x7, 0);
>>> +				best->ecx &= ~bit(X86_FEATURE_INVPCID);
>>> +			}
>>> +		}
>>> +	}
> 
> The incorrect behavior is especially problematic now that SVM also
> supports INVCPID, as KVM allows !PCID && INVPCID on SVM but not on VMX.
> 
> Patches to fix kvm-unit-tests are also incoming...
> 
> Sean Christopherson (3):
>    KVM: SVM: Intercept INVPCID when it's disabled to inject #UD
>    KVM: x86: Advertise INVPCID by default
>    KVM: VMX: Allow INVPCID in guest without PCID
> 
>   arch/x86/kvm/cpuid.c   |  2 +-
>   arch/x86/kvm/svm/svm.c | 11 ++++-------
>   arch/x86/kvm/vmx/vmx.c | 14 ++------------
>   3 files changed, 7 insertions(+), 20 deletions(-)
> 

Queued, thanks.

Paolo

