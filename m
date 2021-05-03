Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842AE37165F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhECOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233992AbhECOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620050587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dli2hA9V91jNU1uVhC91EUBTOsr+YjBKusIKdCkZYKU=;
        b=LaRLqU0OSk4SlldWk/OnwZE3UcdZVAFGpmwCIkquqK/QB7BYZoMP2IvTCpN1AmZjWetK3w
        OpCY9RcRbw+g5yw/rzG9E7tw0teHJSsONkj/Mz+nnrvdT2kMC+kNFIUstx++07e8bNrRoV
        1vmIRrLa0zOrYeNuu4XxeoPn5zSYLHg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-m3pOy0-lNuC-Kio2sgVzEA-1; Mon, 03 May 2021 10:03:06 -0400
X-MC-Unique: m3pOy0-lNuC-Kio2sgVzEA-1
Received: by mail-ed1-f72.google.com with SMTP id d13-20020a056402144db0290387e63c95d8so4596440edx.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dli2hA9V91jNU1uVhC91EUBTOsr+YjBKusIKdCkZYKU=;
        b=WNV0Ij/8249ZHbI3YdpyQTGcUxbciHhL9lpPYOl9Owa/Yc300YdWYAD9Q6rg8G80tW
         E/l/Myl6r+VwwzZV/wTpUzSMcK6S7gTMjYeiDAfmnrls4EcOtVw0iZsooaMi5hVxBpml
         CQP2e8k0RgTOPjfyOOeW4GqcgPQC+M2z5T37Jb3ZxvXpQ1mprb1q0tuj1honPLkNlz5Z
         CaxJPozTPyPDJl7euLICoZ4sQtD4KyFny0lww7qjWEg6029TndQ1YwmE0hQ05cmJATv+
         x6K+JewRnCvWcADnVfvALTfQYJHzZIRFhQCuJ8v8PAyZykeEqmZRDvW9hIAWEZ9SuWaC
         AA0g==
X-Gm-Message-State: AOAM531bzDyZIN13FobolpySinWhV82wkzxGs83NPC4TU7bAKnGzFxRh
        5nE/gMvkDAulPSfxpMSCTpXLjNLD3z5PeCmsm3LpZtSUF4E1HXlbe/o3cocXjkqMHVsLYnviMWX
        Z69K9ac6r02F6V086ZVahO87N
X-Received: by 2002:aa7:d146:: with SMTP id r6mr16489326edo.344.1620050584890;
        Mon, 03 May 2021 07:03:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO8d/PrGuqhERyc2VXANVbuEyQKlzvZTSxdVnqElH4sgaEFlDH0GbNy9lWT3MgxmBLjEt7mA==
X-Received: by 2002:aa7:d146:: with SMTP id r6mr16489292edo.344.1620050584671;
        Mon, 03 May 2021 07:03:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j16sm12717416edr.9.2021.05.03.07.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:03:04 -0700 (PDT)
Subject: Re: [PATCH 0/5] KVM: nSVM: few fixes for the nested migration
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Cathy Avery <cavery@redhat.com>
References: <20210503125446.1353307-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <358f9624-eb77-5449-845c-c92676fed8ed@redhat.com>
Date:   Mon, 3 May 2021 16:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503125446.1353307-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 14:54, Maxim Levitsky wrote:
> Those are few fixes for issues I uncovered by doing variants of a
> synthetic migration test I just created:
> 
> I modified the qemu, such that on each vm pause/resume cycle,
> just prior to resuming a vCPU, qemu reads its KVM state,
> then (optionaly) resets this state by uploading a
> dummy reset state to KVM, and then it uploads back to KVM,
> the state that this vCPU had before.
> 
> I'll try to make this test upstreamable soon, pending few details
> I need to figure out.
> 
> Last patch in this series is for false positive warning
> that I have seen lately when setting the nested state,
> in nested_svm_vmexit, where it expects the vmcb01 to have
> VMRUN vmexit, which is not true after nested migration,
> as it is not fully initialized.
> If you prefer the warning can be removed instead.
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (5):
>    KVM: nSVM: fix a typo in svm_leave_nested
>    KVM: nSVM: fix few bugs in the vmcb02 caching logic
>    KVM: nSVM: leave the guest mode prior to loading a nested state
>    KVM: nSVM: force L1's GIF to 1 when setting the nested state
>    KVM: nSVM: set a dummy exit reason in L1 vmcb when loading the nested
>      state
> 
>   arch/x86/include/asm/kvm_host.h |  1 +
>   arch/x86/kvm/svm/nested.c       | 29 ++++++++++++++++++++++++++---
>   arch/x86/kvm/svm/svm.c          |  4 ++--
>   3 files changed, 29 insertions(+), 5 deletions(-)
> 

Queued patches 1-3.

Paolo

