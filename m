Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9533149B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBIHsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhBIHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612856810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60Yl/vDmWhz8mPXWE8Nyh/nzPl1IEHtsGhYX5nxRI0s=;
        b=SduoRG+uHXSB5OmXnoch9KXFxOSwFF+B3ZT5g2AcL46kh+3fBDdLwLC0tZMY5EnbyINcsv
        sMHmv6RSObzz3e4LRVNXQQgYk/8S3Xiobg4QDOPte1armGy0C8QO1EKJo5g3o9bX4sp8Yp
        uXq1Kc1NHV8OCcrtEQxdduPiTMS6REM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205--o2ZXpoIMLm8M5kpnoZtRA-1; Tue, 09 Feb 2021 02:46:46 -0500
X-MC-Unique: -o2ZXpoIMLm8M5kpnoZtRA-1
Received: by mail-wm1-f69.google.com with SMTP id y84so1815833wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=60Yl/vDmWhz8mPXWE8Nyh/nzPl1IEHtsGhYX5nxRI0s=;
        b=SZJA3A4NaVklx4LM3TLW3gCTRTVOIz2ovbhToHwsLfreH2DoIfBaZOBy4xvkDPxxka
         tmKNfA0KRc7Lk9eFc4HXhvcFvGOLAXzsaB1yglhN7nvCkcJcqks3VjyMZY84JhB3I5LA
         M65bAB2iF7gi0Az39Mv9GThCgAQthick0YrBjMwEoM9KR1UhrWT1CfvZrE5WxAbFj5R6
         MuHPpzoA8R6iMopUSxDFYYMhcJIIjkeLXA5vOH9QOO9oBJrsRJr+iBLM5xAlMDRp/y5T
         J0iNq62Gn7sxkbG1RzdpjB/zE9VusOZb5K2Ouz9HnrJqyKGKK0XHz/cFIbLO/l3wKxiz
         iasg==
X-Gm-Message-State: AOAM531uhs+9lAxywQyscVCK0A/vkqkPGH8XB+Hz5fSKma8KMseeKQCF
        UdzTAJSb+UADNF/Xe8qP0QEGyrKmMWwmcarRObzkZi1RhhkIMByrFGbfaKIBiH+xOGjAVgHAawt
        B9JIoU7T+D119o/bCD8iVnso/
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr2150315wmd.92.1612856805065;
        Mon, 08 Feb 2021 23:46:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwj6liW9hyxjHByLK8Qc6qMnvgWOabUHGWBhV1hhcFdO2HPRd3a01X3y3tPTQLMty+2i3lDHA==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr2150288wmd.92.1612856804802;
        Mon, 08 Feb 2021 23:46:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u14sm2837840wmq.45.2021.02.08.23.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 23:46:43 -0800 (PST)
Subject: Re: [PATCH v2] KVM: x86/MMU: Do not check unsync status for root SP.
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     seanjc@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org
References: <20210207122254.23056-1-yu.c.zhang@linux.intel.com>
 <671ae214-22b9-1d89-75cb-0c6da5230988@redhat.com>
 <20210208134923.smtvzeonvwxzdlwn@linux.intel.com>
 <404bce5c-19ef-e103-7b68-5c81697d2a1f@redhat.com>
 <20210209033319.w6nfb4s567zuly2c@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ca2d73c-703a-9964-48ae-e3d910bebc48@redhat.com>
Date:   Tue, 9 Feb 2021 08:46:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210209033319.w6nfb4s567zuly2c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 04:33, Yu Zhang wrote:
> On Mon, Feb 08, 2021 at 05:47:22PM +0100, Paolo Bonzini wrote:
>> On 08/02/21 14:49, Yu Zhang wrote:
>>> On Mon, Feb 08, 2021 at 12:36:57PM +0100, Paolo Bonzini wrote:
>>>> On 07/02/21 13:22, Yu Zhang wrote:
>>>>> In shadow page table, only leaf SPs may be marked as unsync.
>>>>> And for non-leaf SPs, we use unsync_children to keep the number
>>>>> of the unsynced children. In kvm_mmu_sync_root(), sp->unsync
>>>>> shall always be zero for the root SP, , hence no need to check
>>>>> it. Instead, a warning inside mmu_sync_children() is added, in
>>>>> case someone incorrectly used it.
>>>>>
>>>>> Also, clarify the mmu_need_write_protect(), by moving the warning
>>>>> into kvm_unsync_page().
>>>>>
>>>>> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
>>>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>>>
>>>> This should really be more of a Co-developed-by, and there are a couple
>>>> adjustments that could be made in the commit message.  I've queued the patch
>>>> and I'll fix it up later.
>>>
>>> Indeed. Thanks for the remind, and I'll pay attention in the future. :)
>>
>> Also:
>>
>> arch/x86/kvm/mmu/mmu.c: In function ‘mmu_sync_children’:
>> arch/x86/kvm/mmu/mmu.c:2002:17: error: ‘sp’ is used uninitialized in this
>> function [-Werror=uninitialized]
>>    WARN_ON_ONCE(sp->unsync);
> 
> Oops. This is wrong. Should be WARN_ON_ONCE(parent->unsync);
> 
>>
>> so how was this tested?
>>
> 
> I ran access test in kvm-unit-test for previous version, which hasn't
> this code(also in my local repo "enable_ept" was explicitly set to
> 0 in order to test the shadow mode). But I did not test this one. I'm
> truely sorry for the negligence - even trying to compile should make
> this happen!
> 
> Should we submit another version? Any suggestions on the test cases?

Yes, please send v3.

The commit message can be:

In shadow page table, only leaf SPs may be marked as unsync; instead, 
for non-leaf SPs, we store the number of unsynced children in 
unsync_children.  Therefore, in kvm_mmu_sync_root(), sp->unsync
shall always be zero for the root SP and there is no need to check
it.  Remove the check, and add a warning inside mmu_sync_children() to 
assert that the flags are used properly.

While at it, move the warning from mmu_need_write_protect() to 
kvm_unsync_page().

Paolo

