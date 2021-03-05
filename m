Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424D832F26E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCESXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:23:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229589AbhCESXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614968602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cif4JRqiNpGdkfMRSZ/fYAiktCyfQJU6RgpMU5eJol0=;
        b=TIjuUB9f8rkK0xEoNsNk2LWnqHZhvpS4nZ4CqTJZzvfr63wrFG4T5lwN18OphlKdJ97DjQ
        /2hwA5DwTFYdxXiCmr6EYr9L4pUeKc4KUWa2hIVZ17meM7zI7wJTdNqmpCRocmT/6tcOx6
        /EvrCyUF2mBTOchq7ZzEwyu5pIF8M6Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-1uCIkNgxOVuuZsI2JrNzZA-1; Fri, 05 Mar 2021 13:23:21 -0500
X-MC-Unique: 1uCIkNgxOVuuZsI2JrNzZA-1
Received: by mail-wm1-f69.google.com with SMTP id v5so1153433wml.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 10:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cif4JRqiNpGdkfMRSZ/fYAiktCyfQJU6RgpMU5eJol0=;
        b=pXokPXOEqESfE9bEdcVDAptVxqnOA3lKl2bK50XlbW4gXbwclh505FwspDvxR4rjaU
         fBKxJmbYXbPHHsTa4V3ZVJHg7wykK4MK6/+Lhemlk9WfujiBmsaHLJV1YDj9/a6nyKUt
         lzQUScFTv2JajWaBep6uvhagmR4QcVFifaP2JQltICL88LkOTH4D1t8Fu0bDYhHlagzB
         U3Ud1B1myEL4u2bHE7DRVaH9ByGpuKhELCaRJEfBovWG7jdtyeVMOljLTF2qdW9BYJ40
         BmOdJqhNzww/+58V/ceCiRmwAHqPyPaGEQMdwjrEp3Ay/ayfks88/DC5VcsRjkWU4Nw/
         j+ZA==
X-Gm-Message-State: AOAM530VQmC710Q9YwFfhvB7O1D1X7npNCf/DRHNEQbrhLUgAE1r1I9d
        kFD6y8R/2/6pk7rsKnYbaKbCh4ThU7/XFnKxPwOSBa5oYu0mtRQ3I/F2RV6Bpmik52xw36j+ZxW
        TFnRcHATs/ZT+LwyHAdOzJKc8
X-Received: by 2002:adf:f851:: with SMTP id d17mr10572413wrq.267.1614968600001;
        Fri, 05 Mar 2021 10:23:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3epZPNLDLCGcU127fgtBb9iUrOAdZs2EfY770AltyxOXwJ9t8wyFIk7LamLdgEUUg+Ku2aA==
X-Received: by 2002:adf:f851:: with SMTP id d17mr10572398wrq.267.1614968599844;
        Fri, 05 Mar 2021 10:23:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x8sm5343865wru.46.2021.03.05.10.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 10:23:19 -0800 (PST)
Subject: Re: [PATCH v2 09/17] KVM: x86/mmu: Use '0' as the one and only value
 for an invalid PAE root
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210305011101.3597423-1-seanjc@google.com>
 <20210305011101.3597423-10-seanjc@google.com>
 <63d2a610-f897-805c-23a7-488a65485f36@redhat.com>
 <YEJ21vvQfBXnvlP8@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4e386f6-35f5-fdd7-10c9-c690615f1a47@redhat.com>
Date:   Fri, 5 Mar 2021 19:23:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YEJ21vvQfBXnvlP8@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 19:22, Sean Christopherson wrote:
> On Fri, Mar 05, 2021, Paolo Bonzini wrote:
>> On 05/03/21 02:10, Sean Christopherson wrote:
>>> Use '0' to denote an invalid pae_root instead of '0' or INVALID_PAGE.
>>> Unlike root_hpa, the pae_roots hold permission bits and thus are
>>> guaranteed to be non-zero.  Having to deal with both values leads to
>>> bugs, e.g. failing to set back to INVALID_PAGE, warning on the wrong
>>> value, etc...
>>
>> I don't dispute this is a good idea, but it deserves one or more comments.
> 
> Agreed.   What about adding macros?
> 
> /* Comment goes here. */
> #define INVALID_PAE_ROOT	0
> #define IS_VALID_PAE_ROOT(x)	(!!(x))

Yep, that's a nice solution.

Paolo

> 
> 
> Also, I missed this pattern in mmu_audit.c's mmu_spte_walk():
> 
> 	for (i = 0; i < 4; ++i) {
> 		hpa_t root = vcpu->arch.mmu->pae_root[i];
> 
> 		if (root && VALID_PAGE(root)) {
> 			root &= PT64_BASE_ADDR_MASK;
> 			sp = to_shadow_page(root);
> 			__mmu_spte_walk(vcpu, sp, fn, 2);
> 		}
> 	}
> 

