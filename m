Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70B544C38D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhKJPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:04:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231593AbhKJPEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636556522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYakPG8m8nj7mUbHHgIj188615K8TQbntmqQ4hJteXU=;
        b=FMU0xMt+vjWYps+UqLxdhvZM0vVljy0WyFEuwfViCcqEZrWNy1zlauXaTaa+eYN61GrWvp
        AAXxGbK6rPgb+4rY273n4iBOFDhem2jLrZtoEtWvKw8SibfyQnjQxkolPbTbeJm/AnqTQ4
        TwlO4ZFQCKtFHg1xmkz7FTQm32Sg8lA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-MXSzi9FLPzulg5sHPrFdwg-1; Wed, 10 Nov 2021 10:01:59 -0500
X-MC-Unique: MXSzi9FLPzulg5sHPrFdwg-1
Received: by mail-ed1-f70.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so2569923edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qYakPG8m8nj7mUbHHgIj188615K8TQbntmqQ4hJteXU=;
        b=DML1RP4vkuomigY4nF2/cQgi8cuSQFDF6iSfV3oGFewXepnYk5y7KxMEfKt08VJ7AA
         aoTbzAk5KEcT7BClMU4wkqETzRx0dfaADxARdCEm1+RIyY5AhboX4O6gXTZbhFc/pHWa
         kjPKBLwsPprehvtwQIxKbwxEGI9c+GZLZEb+SqLflxe8P5r6jiKoPibs/uDE1MANr878
         vPiVr86hqCuSpPHOoJhRQDyOfvqw3WrjVWrE04gVlDbP+43j4gYqkXXKv3wBwriqLCuJ
         oP1QTW+88X1P6NcnvEGgldwtezJ7JmuY1Zuz6GvWGxr92fEpCqFcJvCpJEBcKYKNIx/v
         45Fw==
X-Gm-Message-State: AOAM531SYURBuor67SzVLhTzq4uev/u/8fSUxeUi6sDR1Dyy+rMJkwkX
        v565f1UeKwV2tfjo1E4vaLEcKXnMq2c/CSdLIUPeIy8PigKewouMg2wmo63DlrziGND1HgwwaXV
        yXpDMI0tXHzJENhKS3adYMHis
X-Received: by 2002:a17:906:6c83:: with SMTP id s3mr281942ejr.13.1636556518414;
        Wed, 10 Nov 2021 07:01:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvOjbPA69/eXXMSlLUDWi54zKelckxROYRUebWhGzQfts3OilQ4IdFnDoQ94kyo5jRzBnNOQ==
X-Received: by 2002:a17:906:6c83:: with SMTP id s3mr281910ejr.13.1636556518180;
        Wed, 10 Nov 2021 07:01:58 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id h7sm19403edt.37.2021.11.10.07.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 07:01:57 -0800 (PST)
Message-ID: <e6d4e268-da50-c55f-1485-f4a871afdff0@redhat.com>
Date:   Wed, 10 Nov 2021 16:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] KVM: nVMX: restore L1's EFER prior to setting the
 nested state
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>
References: <20211110100018.367426-1-mlevitsk@redhat.com>
 <20211110100018.367426-3-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211110100018.367426-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 11:00, Maxim Levitsky wrote:
> +	/*
> +	 * The vcpu might currently contain L2's IA32_EFER, due to the way
> +	 * some userspace kvm users (e.g qemu) restore nested state.
> +	 *
> +	 * To fix this, restore its IA32_EFER to the value it would have
> +	 * after VM exit from the nested guest.
> +	 *
> +	 */
> +
> +	vcpu->arch.efer = nested_vmx_get_vmcs12_host_efer(vcpu, vmcs12);
> +

In principle the value of LOAD_HOST_EFER on exit need not be the same as 
on entry.  But you don't need all of EFER, only EFER.LME/EFER.LMA, and 
those two bits must match ("the values of the LMA and LME bits in the 
field must each be that of the “host address-space size” VM-exit 
control" from the "Checks on Host Control Registers, MSRs, and SSP"; 
plus the "Checks Related to Address-Space Size").

At least it's worth adjusting the comment to explain that.  But the root 
cause of the issue is just nested_vmx_check_* accessing vcpu->arch.  So 
you can instead:

- split out of nested_vmx_check_host_state a new function 
nested_vmx_check_address_state_size that does

#ifdef CONFIG_X86_64
	if (CC(!!(vmcs12->vm_exit_controls & VM_EXIT_HOST_ADDR_SPACE_SIZE) !=
	       !!(vcpu->arch.efer & EFER_LMA)))
		return -EINVAL;
#endif
	return 0;

- call it from vmentry but not from migration

- in nested_vmx_check_host_state, assign ia32e from 
vmcs12->vm_exit_controls instead of vcpu->arch.efer

Paolo

