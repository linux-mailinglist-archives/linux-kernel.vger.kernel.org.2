Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0D31C22B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhBOTGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:06:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230216AbhBOTF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613415871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ImJRI1yuJ7O4+8pVfGV5azZCf98csp8Xgq02hsPklo8=;
        b=PkhSB2vX1t0B4pK3Gkw1ULtz5q14KXiXyKqaHm0xG10TUWo6qwCODiIwBYbNS/pJyuUDNf
        ag6cUFB9nQjquwKHn3qH1Z4hyuLpN2v1MMPuCAleS4jMqa1fufBloqtW7P1M1dyK9YGrhy
        tOxYGi1kNkkwYRgu2BP5LBYVcnO1ySY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-xHf1PWq8Mz2YXnzNEzSIHw-1; Mon, 15 Feb 2021 14:04:30 -0500
X-MC-Unique: xHf1PWq8Mz2YXnzNEzSIHw-1
Received: by mail-wm1-f70.google.com with SMTP id s131so7625831wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ImJRI1yuJ7O4+8pVfGV5azZCf98csp8Xgq02hsPklo8=;
        b=pxDIa9BJwTRZQS3riChKR7rTfVlH7feAY1VqNXsUKIJFjK/qRLIxaZwI+uj0mnsfMN
         XDjfy2u+F1pOWJWeN1ZU2ul6Vwh7sATJgyrktv+HLy9W/BfJXxdSPx/opUIu/andk4gx
         DgVJ2Sfq9r0cfqk7qdwMOWYSuH3G4MfBJfL2aTXzf1dxjZnHiLaObnnWMRmXD0T18fnv
         oGMu3sczvmmisVemk9iut4wCsAz8KhRGkcfyvTAAs2dPqjRvNCOFPWCGXbhlHiQAYPGw
         0p90f35BNJ9AwFqJj5A1TghaxWrXD2swudrTL2JDJuijqHSFp2A+kIWMBgIjD4+l4JcE
         Er7Q==
X-Gm-Message-State: AOAM533soo95aY9btfa5JpXKS9TNOshJXrciJroynm1VJKTEPK053glu
        FXE5UJSmF6VVunYZMDmGB9ZqRuYConS/jMgU1nSDsEzPDvUDA700gJIvDMaq7GhI/nTyZYI4lg8
        YCHxUKBTDbh0AQsXTBbXzEipG
X-Received: by 2002:adf:bb54:: with SMTP id x20mr20480953wrg.112.1613415869037;
        Mon, 15 Feb 2021 11:04:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuXw4FHbMOBKae+oWDB5mUcaF7jO1E7sfWFLf95KC5dNp0Yy6wmPhWvxW4ObReRsg9YJisPg==
X-Received: by 2002:adf:bb54:: with SMTP id x20mr20480939wrg.112.1613415868802;
        Mon, 15 Feb 2021 11:04:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c9sm278741wmb.33.2021.02.15.11.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 11:04:28 -0800 (PST)
Subject: Re: [PATCH 5.10 048/104] KVM: x86: cleanup CR3 reserved bits checks
To:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Sasha Levin <sashal@kernel.org>
References: <20210215152719.459796636@linuxfoundation.org>
 <20210215152721.031370031@linuxfoundation.org> <20210215184644.GA8689@amd>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5107037-63b2-a745-1c3e-ba1960bc507b@redhat.com>
Date:   Mon, 15 Feb 2021 20:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215184644.GA8689@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/21 19:46, Pavel Machek wrote:
> Hi!
> 
>> [ Upstream commit c1c35cf78bfab31b8cb455259524395c9e4c7cd6 ]
>>
>> If not in long mode, the low bits of CR3 are reserved but not enforced to
>> be zero, so remove those checks.  If in long mode, however, the MBZ bits
>> extend down to the highest physical address bit of the guest, excluding
>> the encryption bit.
>>
>> Make the checks consistent with the above, and match them between
>> nested_vmcb_checks and KVM_SET_SREGS.
> 
>> +++ b/arch/x86/kvm/x86.c
>> @@ -9558,6 +9558,8 @@ static int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>>   		if (!(sregs->cr4 & X86_CR4_PAE)
>>   		    || !(sregs->efer & EFER_LMA))
>>   			return -EINVAL;
>> +		if (sregs->cr3 & vcpu->arch.cr3_lm_rsvd_bits)
>> +			return false;
>>   	} else {
> 
> Function has different return type between 5.10 and 5.11, so this
> needs fixing.

I'll check that c1c35cf78bfab31b8cb455259524395c9e4c7cd6 is enough and 
send either a backport of that one, or a fixed patch for <= 5.10. 
Thanks Pavel.

Paolo

