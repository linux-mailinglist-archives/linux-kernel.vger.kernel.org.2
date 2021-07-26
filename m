Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD453D592D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhGZL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233755AbhGZL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627301397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dR3iMn5XpVkez/+wHkSECFYP9sgFxn9jkjpt8nIR5Uc=;
        b=bDZHSofPgtZaqb51+KbSQkDtLS5KMarZZFI65RhXPkP8M91OXFz8j+dmvxC+43nnEu2lJf
        89tX/FLOv90NrcGyr2xMq6VCpH6ZyhXdNV1RwYCD+m1GwlFDEcmR8xXhF4JcedZXH2E6og
        eyWWR/KhutzFpzRhKafiObPt6KKVEJQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-On6aPjYcNKKsLcdBaUMlQw-1; Mon, 26 Jul 2021 08:09:56 -0400
X-MC-Unique: On6aPjYcNKKsLcdBaUMlQw-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020aa7cd490000b02903ae404e7fb4so4654032edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dR3iMn5XpVkez/+wHkSECFYP9sgFxn9jkjpt8nIR5Uc=;
        b=QSs2U97Ra6al4VwFI4CFAJqPetfCsiPqtY69EeuB9u2ZhPiBjBe5WUkwnDBD7krMxz
         ilXk67l+H/OFxDbHvDFR3t7dlL2WXwKBPbJnZhHm2q2oLLvaGESFR0Q6Tr1Ey/MQjPYz
         2Xd9WFWf5mMZMuGqyNxFVuPuwzmkcbfbR7VGTFBltTe4cpsaYFl+Vag9a2USdDx0A+ef
         IYO2qLqtJTq6fJD7nisDTIBnojUlQHM2+9OTh9drBm0dT5O/qflaeeiQDuNCMQGBxYvw
         Ygv74s5UJ0f6FVb4JOQRnqFVzMhQ3ID8Gm/esMQdRch//j9z2rh9rMyipTMIs+ShmQ46
         dtig==
X-Gm-Message-State: AOAM531kzpBCVc+IwjNTWT/A7yPgqSRvZSqCZBbfdKF6E4GEzJhN5xpX
        QK/pFJ/w6kpi6YwvxoQK/GrvOPjIapa0nvn+TBdCDvwfq74VZiNmNxlC+VPKIP7kuO2PpYuCk1a
        Au5fQ8imNzy6ChnEOl6c8PtlgvJ9P+9iYRDkaFSi9SdNwwcZXWYg7OqHByzd59qcIS36HhdcFs6
        QT
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr20836498ede.277.1627301394864;
        Mon, 26 Jul 2021 05:09:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG/K6orRo8FdAJeANVHYVJ7oWfky5S48VStZ68j2xJl+uCgPs+Dvd7uIrzacxbfwHidHnLqw==
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr20836460ede.277.1627301394623;
        Mon, 26 Jul 2021 05:09:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id em9sm14213522ejc.88.2021.07.26.05.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 05:09:54 -0700 (PDT)
Subject: Re: [PATCH] KVM: nSVM: Rename nested_svm_vmloadsave() to
 svm_copy_vmloadsave_state()
To:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210716144104.465269-1-vkuznets@redhat.com>
 <YPG7XVwkze/3YDaI@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a28699c3-d557-2c8f-f79e-c97a5cdb9035@redhat.com>
Date:   Mon, 26 Jul 2021 14:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPG7XVwkze/3YDaI@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/21 19:01, Sean Christopherson wrote:
> On Fri, Jul 16, 2021, Vitaly Kuznetsov wrote:
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index 3bd09c50c98b..8493592b63b4 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -722,7 +722,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *from_save,
>>   	to_save->cpl = 0;
>>   }
>>   
>> -void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb)
>> +void svm_copy_vmloadsave_state(struct vmcb *from_vmcb, struct vmcb *to_vmcb)
> 
> And swap the parameter order for both functions in a follow-up patch?  I.e. have
> the destination first to match memcpy().
> 

Queued, thanks.

Paolo

