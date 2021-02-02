Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B630C7F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbhBBRgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:36:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237576AbhBBReE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612287159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xDLoqFXJnyWYsI4MjhMkfY1XcxzM75c7CRhYvFGAKo=;
        b=bUAZeU36oXGuo66PXFza/qo1avxlcLsqqkO4fIqFwBDDcjxWgkvYLiq54qMpMNGV44prpb
        dJPFpuxNz3qFXX4HyW4B9LMMLR6ICU7wyxEs/qdFkRQBIK9Bhim6lpEJtoxk5Trfal/rrl
        zP7gC+OaiZJ1ixD/MWROV2q9cu1Sn8E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-o5ZfxP6SNAmg3wmrrA0RQg-1; Tue, 02 Feb 2021 12:32:37 -0500
X-MC-Unique: o5ZfxP6SNAmg3wmrrA0RQg-1
Received: by mail-ed1-f71.google.com with SMTP id w23so710099edr.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xDLoqFXJnyWYsI4MjhMkfY1XcxzM75c7CRhYvFGAKo=;
        b=kdz+zOUX1b8mmkRc8Ky8HDghxytZDsVKtdPgPfpvx0seB3CMqPkz/5YIqCT3ZVTAfE
         naOsCwQzDTnrGBf4Pu3KOFe/4q5zjimJX4549Vc9El3Jqr8VhhqmLRf5p1/t4Ao4HgLV
         cgWELc7o7nAE0gVVIAFCBFphskMxVakjPdbHulb2zQmPhuzb5JyPzsnCjdYu+cr+GCnZ
         7GAfpai9EzASLBiW22NLlXobBz4E20mkjqwnr80hAbvP6MQs0KgEiXjL+GPATeA5IuJS
         nZTil7ctBRq7aNkssFQR4xHzKpci+wu4kMxACWxHahivIggNYCCRgdtbWnNNzceYxx3p
         OyUw==
X-Gm-Message-State: AOAM530yXV9wrFhOTZ+ZUhDMryvPEi96YplDJKgN65ZdMYnh0fACvuew
        3SxLshQnVOHXVK+bDDWSbeOXd30PUr75xhpmA4HsLCbKr0lk3soGFkMBjZ+zlhYsSnlNxARELDg
        oPnmq1FzdKn25nWD/vo+fPo7G
X-Received: by 2002:a17:906:8a59:: with SMTP id gx25mr15904107ejc.310.1612287156706;
        Tue, 02 Feb 2021 09:32:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyxdr9tXVjSGSY8Z18kK8M0fX2Y4E1fTIs2+vtrLnxj2RqkiIr7nT+YUWnd2gPVlnNcZErnQ==
X-Received: by 2002:a17:906:8a59:: with SMTP id gx25mr15904076ejc.310.1612287156547;
        Tue, 02 Feb 2021 09:32:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id hr31sm9559435ejc.125.2021.02.02.09.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 09:32:35 -0800 (PST)
Subject: Re: [PATCH v3 1/3] KVM: SVM: use vmsave/vmload for saving/restoring
 additional host state
To:     Sean Christopherson <seanjc@google.com>,
        Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210105143749.557054-1-michael.roth@amd.com>
 <20210105143749.557054-2-michael.roth@amd.com> <X/Sfw15OWarseivB@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e3faa02d-e7b2-5ab7-22a8-fc625245ad00@redhat.com>
Date:   Tue, 2 Feb 2021 18:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/Sfw15OWarseivB@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/21 18:20, Sean Christopherson wrote:
> This VMLOAD needs the "handle fault on reboot" goo.  Seeing the code, I think
> I'd prefer to handle this in C code, especially if Paolo takes the svm_ops.h
> patch[*].  Actually, I think with that patch it'd make sense to move the
> existing VMSAVE+VMLOAD for the guest into svm.c, too.  And completely unrelated,
> the fault handling in svm/vmenter.S can be cleaned up a smidge to eliminate the
> JMPs.
> 
> Paolo, what do you think about me folding these patches into my series to do the
> above cleanups?  And maybe sending a pull request for the end result?  (I'd also
> like to add on a patch to use the user return MSR mechanism for MSR_TSC_AUX).

I have queued that part already, so Mike can rebase on top of kvm/queue.

Paolo

> [*]https://lkml.kernel.org/r/20201231002702.2223707-8-seanjc@google.com
> 

