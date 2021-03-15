Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8633C4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhCOR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229713AbhCOR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615830968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1kmtbisPwSoThfREWhg9euwF5pmgKyEO+1jHxVyvEg=;
        b=ODNe9oGzAD8AACCyZfyGi9zr2LwO1bWTVt0obt+d9nJOBA2Bg0CAyi8eXQ+7nhcT8RBlBM
        r8RyrYEJb3FgjzRemxexg2iD08O8HfiTHFrp8T/JSrDhEkiYOaug1VnoSzRdV19cELccy0
        0Vboz+5e4FWDP5CoP8Bxt9KiUuCs9fA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-6OTOVKRvOHijzCweYg-e8Q-1; Mon, 15 Mar 2021 13:56:06 -0400
X-MC-Unique: 6OTOVKRvOHijzCweYg-e8Q-1
Received: by mail-ej1-f70.google.com with SMTP id h14so12420229ejg.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j1kmtbisPwSoThfREWhg9euwF5pmgKyEO+1jHxVyvEg=;
        b=HWeRJXV+Wjr7PlFbyxdHKY9j4pm//4Pds5+6OEBhM25AtrJi+xpZcPVsRgwLrJRkR5
         oAVhFj2qhz9llQbDRLLx840tkNtTPSO4h7oK0iQtOFZjDc64++Vs6atyQ48LSKE0m8Wd
         tbL98jcw60SQcxC7KzieoDEMSPY0qJVkKWDvMq3N4SgJQQ3xz1SlLnJ8P07qO3qZsvr0
         zqzs+Hp19ZkuzrqsFyxnOkdw8roqVktzln2GB/daYcajv5ZNu3RRhLtGK4m8udr4lwMG
         /creXvhs6RUZ7gaCOgdzM3UimpvOiXj0eKzB02f6p0hQSeIG17ItifHg/yhVGKQ06P/A
         Y6mQ==
X-Gm-Message-State: AOAM533+325Pf5DjonGxci5+/a8EhzTxwpfbGZ2JWBewzS0A/etrnt49
        7c5K1uPlwTlgtBImcopAAIHT16MlgEuZcM6dWY3vj9A46y/7S1ZfQtm1/gjkFvh6Wu62HHYpFvV
        dxctRGJ1LNiw1vHvsT2dY3uZQ
X-Received: by 2002:a17:907:20e4:: with SMTP id rh4mr25396808ejb.369.1615830965578;
        Mon, 15 Mar 2021 10:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYS/S6RGenL0C9uMdNJZ5VHvxi3+MYTPCdVCM3+O9GQ3zLKEMu86WW4iJP/f9HtQWI5RUrjA==
X-Received: by 2002:a17:907:20e4:: with SMTP id rh4mr25396785ejb.369.1615830965381;
        Mon, 15 Mar 2021 10:56:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id la15sm7992488ejb.46.2021.03.15.10.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 10:56:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: nSVM: improve SYSENTER emulation on AMD
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>
References: <20210315174316.477511-1-mlevitsk@redhat.com>
 <20210315174316.477511-3-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0dbcff57-8197-8fbb-809d-b47a4f5e9e77@redhat.com>
Date:   Mon, 15 Mar 2021 18:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210315174316.477511-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/21 18:43, Maxim Levitsky wrote:
> +	if (!guest_cpuid_is_intel(vcpu)) {
> +		/*
> +		 * If hardware supports Virtual VMLOAD VMSAVE then enable it
> +		 * in VMCB and clear intercepts to avoid #VMEXIT.
> +		 */
> +		if (vls) {
> +			svm_clr_intercept(svm, INTERCEPT_VMLOAD);
> +			svm_clr_intercept(svm, INTERCEPT_VMSAVE);
> +			svm->vmcb->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
> +		}
> +		/* No need to intercept these msrs either */
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_EIP, 1, 1);
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_ESP, 1, 1);
> +	}

An "else" is needed here to do the opposite setup (removing the "if 
(vls)" from init_vmcb).

This also makes the code more readable since you can write

	if (guest_cpuid_is_intel(vcpu)) {
		/*
		 * We must intercept SYSENTER_EIP and SYSENTER_ESP
		 * accesses because the processor only stores 32 bits.
		 * For the same reason we cannot use virtual
		 * VMLOAD/VMSAVE.
		 */
		...
	} else {
		/* Do the opposite.  */
		...
	}

Paolo

