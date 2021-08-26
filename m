Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B53F8BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbhHZQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 12:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232555AbhHZQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629994677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dc80C4dit3QwOZ5pXnhfczxS8gOs+rep9eS8mfVRLco=;
        b=We54DdFMbVr6/Pw73QQRi0hmf6xRg6G12X1IXjpimt/CCHPG71KtN5NYjyqeCWVVEzcOCa
        K6/fmuxyK1F1Pl1OKCAiBmsGVVQQT0BzCuYPR8E0cMF2wyXmWDA3dCzBIUKq9/jIeSh8px
        ZntORrLw9zhlU+5azlYi/DjilNyiRP8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-0xSrOiy7P0q2intDuN8QKQ-1; Thu, 26 Aug 2021 12:17:54 -0400
X-MC-Unique: 0xSrOiy7P0q2intDuN8QKQ-1
Received: by mail-wr1-f72.google.com with SMTP id h6-20020a5d4fc6000000b00157503046afso1014779wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dc80C4dit3QwOZ5pXnhfczxS8gOs+rep9eS8mfVRLco=;
        b=loh18S1g3xPvzuLQ9RSMTjU9DjOrxxdZTa2LQIJ5su9frO9jmzrZ+l31rnMGut1EK+
         279f7w6s0t5z8Q48n0JywLLIGOB04GYmrseS4sjVp0zXDyuabTdku2Bp87emAM/DLu+G
         l7gyTFrdtfbQtq1MifBoibb2tjzOX+ODSP0TxMqZXB0yMO9XsgdYcqicsi59cxx/jKgQ
         VD4zST4BpuMG9i/3qdt1LvSc2hJWeU9XpOo8AEqDoGbTJ2wxtWqnE3h7qeA8wZpCPKkC
         fr437zT0TBVRG56D79NC8YbhZ+WCEZnNLeCNMT0CBBhnB6pDvAVQyFt6iofl/odPz7fX
         Si8Q==
X-Gm-Message-State: AOAM530Y1bXVqp88PFN68OXBonodr5dcFjcXYdAQHF+OijP5zBRBZIeI
        qhFnKlI2+TD66fLLuwiqzpnGA1fCoxaYLE9jR4PUxC6c755+qj7QLJtL3yYwbTaOOUtEcW7ord8
        IIgicomSf4j0GKne2iwfnj08XXTzGj5bydhUHZs396JQwfQgGYrHeqUbT2FbpDLVEWhr7TVWGnd
        Nu
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr4474007wmk.96.1629994672938;
        Thu, 26 Aug 2021 09:17:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyERgwCImWECf7qWig1zkLiUfQr++QiieKp+R0ZIoVmj3xDFRrIQEXTFDkgVFjgzSU79w72sg==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr4473979wmk.96.1629994672673;
        Thu, 26 Aug 2021 09:17:52 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z13sm3715665wrs.71.2021.08.26.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 09:17:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: Optimize kvm_make_vcpus_request_mask() a bit
In-Reply-To: <YSeyV9cWQXCd+UKk@google.com>
References: <20210826122442.966977-1-vkuznets@redhat.com>
 <20210826122442.966977-4-vkuznets@redhat.com>
 <YSeyV9cWQXCd+UKk@google.com>
Date:   Thu, 26 Aug 2021 18:17:51 +0200
Message-ID: <87fsuwi3io.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Aug 26, 2021, Vitaly Kuznetsov wrote:
>> Iterating over set bits in 'vcpu_bitmap' should be faster than going
>> through all vCPUs, especially when just a few bits are set.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> ...
>
>> +	if (vcpu_bitmap) {
>> +		for_each_set_bit(i, vcpu_bitmap, KVM_MAX_VCPUS) {
>> +			vcpu = kvm_get_vcpu(kvm, i);
>> +			if (!vcpu || vcpu == except)
>> +				continue;
>> +			kvm_make_vcpu_request(kvm, vcpu, req, tmp, me);
>> +		}
>> +	} else {
>> +		kvm_for_each_vcpu(i, vcpu, kvm) {
>> +			if (vcpu == except)
>> +				continue;
>> +			kvm_make_vcpu_request(kvm, vcpu, req, tmp, me);
>>  		}
>>  	}
>
> Rather than feed kvm_make_all_cpus_request_except() into kvm_make_vcpus_request_mask(),
> I think it would be better to move the kvm_for_each_vcpu() path into
> kvm_make_all_cpus_request_except() (see bottom of the mail).  That eliminates the
> silliness of calling a "mask" function without a mask, and also allows a follow-up
> patch to drop @except from kvm_make_vcpus_request_mask(), which is truly nonsensical
> as the caller can and should simply not set that vCPU in the mask. 

Both make perfect sense, thanks! v4 is being prepared.

-- 
Vitaly

