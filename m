Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B65D30D645
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhBCJ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:27:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233152AbhBCJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612344249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1AJOvNcVAHjnbmTLHPbHCklE5DkACQ51lJEvjK17KnY=;
        b=cGcOvv4eR20wmF0PR3E/9TH+zneGfa4bIH0WNtkAHLrUHJ8pPju3FMuYeuSPLE0rbGQMIz
        iXcUIhgzgUV9mg5oAP/bQZ2QnaH3Ib5XLjC/Xv92qNRrheFvoPw5ygjuRsoJQgeWnnG1QO
        QQrNJ1dJltu3YY7SXThiKj6jfvI4eUs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-IiCTgk6XP9e0NDRF0eZWTQ-1; Wed, 03 Feb 2021 04:24:04 -0500
X-MC-Unique: IiCTgk6XP9e0NDRF0eZWTQ-1
Received: by mail-ed1-f71.google.com with SMTP id ay16so2218391edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1AJOvNcVAHjnbmTLHPbHCklE5DkACQ51lJEvjK17KnY=;
        b=tYmitgoJpHPXQUekEiloXjhPUkseJrS5jrbXxFoa9gP+HBrTEzcL+uR9rvm22F+Xd3
         c/GjYAXh+t8jg1MnBRsL/ujREmnHv9okVmw9YcdVoVaVmbbEyeSdu+pm/nIghxsQE4Zp
         Pha3NUYheR4yVT+3my6vjNqHcTMoUDMQud1XZW8TkQD8s4VrDRDMJd//fYj1EuZqfPh0
         78tsxXc7J5V1Pf3BWNXRYE7LhQx+1QxfkS2Qc9oUnvu0ez7UrJRJERydoPu4q+ip5jpD
         J/5s8V11zna31ksktgvcHGb+CR0NB1oGa8KMYw6ju25uZAsjy6XuGZHleulbrUzY/tSi
         pPgA==
X-Gm-Message-State: AOAM530vEMuX/igZfwoeJibVyeOEbhEuTMv/QbokiyPmcO7b8QJpbLnU
        Kg5a0qIxDjadbBejUS64hptcZ6JjpGb4dTwXKpp45b2y1a4hMCRxBlMuvZSvn35Mo5gjgOEbq2i
        fo3i1xNBaRBZ8D4Fm+oI8QG/w
X-Received: by 2002:a05:6402:1bc7:: with SMTP id ch7mr2091777edb.124.1612344242740;
        Wed, 03 Feb 2021 01:24:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaAh0RhIxuArmFdv/po32/tcmIaKCC+5BlRfjZI28Vt6YtI4dzn5QmkclPNHfxI6/by0mCBg==
X-Received: by 2002:a05:6402:1bc7:: with SMTP id ch7mr2091763edb.124.1612344242397;
        Wed, 03 Feb 2021 01:24:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x42sm576330ede.64.2021.02.03.01.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 01:24:01 -0800 (PST)
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210202165141.88275-1-pbonzini@redhat.com>
 <20210202165141.88275-4-pbonzini@redhat.com> <YBmXLJPPTS7yzClF@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] KVM: x86: move kvm_inject_gp up from kvm_set_dr to
 callers
Message-ID: <63f19b57-7189-4b36-5159-a42df15336a5@redhat.com>
Date:   Wed, 3 Feb 2021 10:24:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBmXLJPPTS7yzClF@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:17, Sean Christopherson wrote:
>> @@ -2617,19 +2618,18 @@ static int dr_interception(struct vcpu_svm *svm)
>>   	reg = svm->vmcb->control.exit_info_1 & SVM_EXITINFO_REG_MASK;
>>   	dr = svm->vmcb->control.exit_code - SVM_EXIT_READ_DR0;
>>   
>> +	if (!kvm_require_dr(&svm->vcpu, dr & 15))
> 
> Purely because I suck at reading base-10 bitwise operations, can we do "dr & 0xf"?

I would have never said that having this => 
https://www.youtube.com/watch?v=nfUY3_XVKHI as a kid would give me a 
competitive advantage as KVM maintainer. :)

(Aside: that game was incredibly popular in the 80s in Italy and as you 
can see from the advertisement at 
https://www.youtube.com/watch?v=o6L9cegnCrw it even had "the binary 
teacher" in it, yes in English despite no one spoke English fluently at 
the time.  The guy who invented it was an absolute genius.  Also, the 
name means "branches").

But seriously: I think the usage of "-" was intentional because the AMD 
exit codes have READ first and WRITE second---but it's (almost) a 
coincidence that CR/DR intercepts are naturally aligned and bit 4 means 
read vs. write.

So v2 will remove the kvm_require_dr (I tested your hypothesis with 
debug.flat and KVM_DEBUGREG_WONT_EXIT disabled, and you're right) and have:

         dr = svm->vmcb->control.exit_code - SVM_EXIT_READ_DR0;
         if (dr >= 16) { /* Move to dr.  */
                 dr -= 16;
                 val = kvm_register_read(&svm->vcpu, reg);
                 err = kvm_set_dr(&svm->vcpu, dr, val);
         } else {
                 kvm_get_dr(&svm->vcpu, dr, &val);
                 kvm_register_write(&svm->vcpu, reg, val);
         }

Paolo

> Technically, 'err' needs to be checked, else 'reg' will theoretically be
> clobbered with garbage.  I say "theoretically", because kvm_get_dr() always
> returns '0'; the CR4.DE=1 behavior is handled by kvm_require_dr(), presumably
> due to it being a #UD instead of #GP.  AFAICT, you can simply add a prep patch
> to change the return type to void.
> 
> Side topic, is the kvm_require_dr() check needed on SVM interception?  The APM
> states:
> 
>    All normal exception checks take precedence over the by implicit DR6/DR7 writes.)
> 
> I can't find anything that would suggest the CR4.DE=1 #UD isn't a "normal"
> exception.
> 
>>   		kvm_register_write(&svm->vcpu, reg, val);
>>   	}
>>   
>> -	return kvm_skip_emulated_instruction(&svm->vcpu);
>> +	return kvm_complete_insn_gp(&svm->vcpu, err);
>>   }
>>   
>>   static int cr8_write_interception(struct vcpu_svm *svm)
> 

