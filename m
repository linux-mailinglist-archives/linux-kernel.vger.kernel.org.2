Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB5351BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhDASKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236765AbhDARzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpC0Pma1PFWAjwr0iJYckO0JsmXmNzZhIFWhXwl6Ie0=;
        b=GbI9sizh/YSXQzaRX6S7Fn3Yx9vOSAz+uW7Bzv3r71X50ahYy1xhoy32/tQMguo1O53zdz
        IO3HwqtUNvrF+ebBxr7+JNwCcxFhZmM6N8I9OPiVFaHtRc1O5kt94lpTitPOY1UPF7rIvL
        tx+c1J/A9WYAogQNuDK3ixZ/Y+HNZXM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-U5K9xpB2N6u1fU1pO5NTgQ-1; Thu, 01 Apr 2021 08:54:22 -0400
X-MC-Unique: U5K9xpB2N6u1fU1pO5NTgQ-1
Received: by mail-ej1-f69.google.com with SMTP id kx22so2168593ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 05:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OpC0Pma1PFWAjwr0iJYckO0JsmXmNzZhIFWhXwl6Ie0=;
        b=bT6I64lt+CqPlYpydlZ92WrcfE5+TMKDaI+pVLj/TtrMimttoq50ezeH4ADq9cf+NX
         DuXPwskLmSZO6hG2HTPOOFzCr6wVsCSKwxmmafIDISBQXRnAffLycV/Bu/SPBQOmQlSH
         wTOh94N7NXa3BCqTQg91X1liG0+wOcDe4a29bFBjVDxqshC/Clvv6UGS1AZIuddDv+Rw
         9a7jULYGoBKKPSsJpk2X4Q1E1K6XNmuqQ94mjVWO+t00TvVgbQqDL6xDXwM2FF42c3th
         aA3MrUbzVa3YsFMgKGd17vkqNJp33DEuB5LGflJdODJP8zXFcsmj3fi85Pt23dPDF+op
         8VZg==
X-Gm-Message-State: AOAM533keDj5gTMMKjcc8rKNkNHkMiDF/1bay4cjnGGuvfVzI9cOE+FU
        hPHcuGfj5eakvtJcqinWVc973v5Lx/7E6Mtjpg36wqNp6PShup0aaSf7HxALuSqsDRK/ar1UUeK
        bJqJoM9Z8Pk578IYii7nx62+3
X-Received: by 2002:a17:907:76a3:: with SMTP id jw3mr9124307ejc.353.1617281660489;
        Thu, 01 Apr 2021 05:54:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMYpcr1VxmrLPcRqAXFqV+5+DVqQuWK1tQ2PT+nlPN+mKom8Wytem2m1aqXpphzINgdJwsZQ==
X-Received: by 2002:a17:907:76a3:: with SMTP id jw3mr9124288ejc.353.1617281660342;
        Thu, 01 Apr 2021 05:54:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gr16sm2753013ejb.44.2021.04.01.05.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 05:54:19 -0700 (PDT)
Subject: Re: [PATCH v5 0/5] KVM: x86: dump_vmcs: don't assume GUEST_IA32_EFER,
 show MSR autoloads/autosaves
To:     David Edmondson <david.edmondson@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20210318120841.133123-1-david.edmondson@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7bbf736c-efd8-6169-171c-098a2869944f@redhat.com>
Date:   Thu, 1 Apr 2021 14:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210318120841.133123-1-david.edmondson@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/21 13:08, David Edmondson wrote:
> v2:
> - Don't use vcpu->arch.efer when GUEST_IA32_EFER is not available (Paolo).
> - Dump the MSR autoload/autosave lists (Paolo).
> 
> v3:
> - Rebase to master.
> - Check only the load controls (Sean).
> - Always show the PTPRs from the VMCS if they exist (Jim/Sean).
> - Dig EFER out of the MSR autoload list if it's there (Paulo).
> - Calculate and show the effective EFER if it is not coming from
>    either the VMCS or the MSR autoload list (Sean).
> 
> v4:
> - Ensure that each changeset builds with just the previous set.
> 
> v5:
> - Rebase.
> - Remove some cruft from changeset comments.
> - Add S-by as appropriate.
> 
> David Edmondson (5):
>    KVM: x86: dump_vmcs should not assume GUEST_IA32_EFER is valid
>    KVM: x86: dump_vmcs should not conflate EFER and PAT presence in VMCS
>    KVM: x86: dump_vmcs should consider only the load controls of EFER/PAT
>    KVM: x86: dump_vmcs should show the effective EFER
>    KVM: x86: dump_vmcs should include the autoload/autostore MSR lists
> 
>   arch/x86/kvm/vmx/vmx.c | 58 +++++++++++++++++++++++++++++-------------
>   arch/x86/kvm/vmx/vmx.h |  2 +-
>   2 files changed, 42 insertions(+), 18 deletions(-)
> 

Queued, thanks.

Paolo

