Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B704351EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhDASvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235556AbhDASdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617301981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zV8gIwvUm/KU6YRC6HTfZNfZbn7owoKKDfoum0B8FQg=;
        b=HOsMbCNlsc5dnN1kqa3CFueKiy/ZqlGFJP2GV688DnITeIy73HwhV9F9hi4LUD+4+vt2HD
        vIvFxPs6QqkSS69WXlFpsKjrxBvC24tfmi/X17JLo91vCFsmFjABMzU3YbS5xWunRPVqZu
        ojExcdzka0ZmcKmp3x8mjrrMFnAETrs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-j2jLVOxgOY2MPbrBZxiBGQ-1; Thu, 01 Apr 2021 11:31:25 -0400
X-MC-Unique: j2jLVOxgOY2MPbrBZxiBGQ-1
Received: by mail-ej1-f72.google.com with SMTP id k16so2376210ejg.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zV8gIwvUm/KU6YRC6HTfZNfZbn7owoKKDfoum0B8FQg=;
        b=Mb+YoF5sAs0Yk3QDERlGoqPnYoUeTHRXKEfoOuFPK7PJ8Ms8q666OfUzAokpj+qg9G
         0Xmh1h03/yY7MldoIKEU4W/SWN5iHJ+c59S2hJvyEFzXABNooGq8o5J8CH2nCCaa9UFq
         4r1n6R+Ws9J2IQrGfmEndS4x1CIq6F1iDwh2f9PdzOGPC3GlDfVeFTMADHOgmFRk4cv4
         RD8Py3McZNHOWVxbwvIzNaH1OfJQsF/FO6U0T/+jTeB6NW49L9NECQk4GG+/t6ZrErcJ
         onHBncN4IvtrGqJm9Go3rvCZXLZaCATxVJjhHYdcQ02G/++tCHAsvQMgfTvu+2eD2GTN
         Kvbg==
X-Gm-Message-State: AOAM530/qCvnjp1SsCHLy8zAA8yTINVXUObOzcRLJU0AAx9hf+ORLaVf
        jn0cOzROFEethBu7Zeb5odk8o9dv8DFU/RAnWHbtHO1UD7Y3XU9SOdW1LkbbVDdV2x1LWWBCm2C
        XTpNDyLX58RjkuNoDISPdCkMT
X-Received: by 2002:a17:907:76b3:: with SMTP id jw19mr9506184ejc.202.1617291084824;
        Thu, 01 Apr 2021 08:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2OyaXOnqsMAdV9O9/OpOj49/Etytctob8p7D5zvVV46D//28nISt7Li1rmBfAywC50ToRKA==
X-Received: by 2002:a17:907:76b3:: with SMTP id jw19mr9506170ejc.202.1617291084698;
        Thu, 01 Apr 2021 08:31:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a17sm2918642ejf.20.2021.04.01.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:31:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 2/2] KVM: nSVM: improve SYSENTER emulation on AMD
In-Reply-To: <6f138606-d6c3-d332-9dc2-9ba4796fd4ce@redhat.com>
References: <20210401111928.996871-1-mlevitsk@redhat.com>
 <20210401111928.996871-3-mlevitsk@redhat.com>
 <87h7kqrwb2.fsf@vitty.brq.redhat.com>
 <6f138606-d6c3-d332-9dc2-9ba4796fd4ce@redhat.com>
Date:   Thu, 01 Apr 2021 17:31:23 +0200
Message-ID: <87zgyic984.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 01/04/21 15:03, Vitaly Kuznetsov wrote:
>>> +		svm->sysenter_eip_hi = guest_cpuid_is_intel(vcpu) ? (data >> 32) : 0;
>> 
>> (Personal taste) I'd suggest we keep the whole 'sysenter_eip'/'sysenter_esp'
>> even if we only use the upper 32 bits of it. That would reduce the code
>> churn a little bit (no need to change 'struct vcpu_svm').
>
> Would there really be less changes?  Consider that you'd have to look at 
> the VMCB anyway because svm_get_msr can be reached not just for guest 
> RDMSR but also for ioctls.
>

I was thinking about the hunk in arch/x86/kvm/svm/svm.h tweaking
vcpu_svm. My opinion is not strong at all here)

-- 
Vitaly

