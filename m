Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B264357DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhDHIPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhDHIPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617869724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECoTbH7o9LRUh51pR4p9sKZq3aoS5gstK1YCFgpfQSc=;
        b=fwezxu74Mk5h7YQpEtAe6wF053DmMIjuWY9a94+HtfkCJMEoKUygrkeOAUUN89GV+hepcV
        8T3owIiqxCS+MGv4Zqi0JX/isdxYXaP9p3F86hPPE7DhyNgVcEPQA+A0Er3PH0E5HY2mCE
        eXJS18nZL5qUetN9cQY6V5Xn+JVfeFE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-r6TW6rfhMb-g20OZRi1JLA-1; Thu, 08 Apr 2021 04:15:19 -0400
X-MC-Unique: r6TW6rfhMb-g20OZRi1JLA-1
Received: by mail-ed1-f70.google.com with SMTP id w8so654915edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 01:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ECoTbH7o9LRUh51pR4p9sKZq3aoS5gstK1YCFgpfQSc=;
        b=C8iyT6DwS0V+yY9FNAZpk5rwSY0A4OgQ73GIdaASOI47PlgOdJpEjtNQF6vtCi3hBY
         K5ksqZXWfs3yukfrGN2jcJQaXq21k+lLuONykymjFWlN+7ZRbAXcnjQbqiT4m3DTl8rz
         CSgPq4l/HvVoxbn745af4PMBzb7Jn7PedMbk/uEttFnTpObfz/zz8aswiFCGL4/yQtNG
         6bmTMoIfdwwpzdaqldqQYfqWD/FJlmqfI5bYSUaXO/I49wvIvh4ZCqCO81KnuS2x1k6X
         JRn/h23DiYLFDin4jx9H10d+tuNmTUGFDJUtD4sjvYP/t5/DC1+nB1Gf4vyUdCYhBoA/
         0A0g==
X-Gm-Message-State: AOAM531OkT7CZABj5sQg/E+TUIFUkq9gdAWBLc0T+lluakXl4Mh7V8EA
        OU7hHdnhPutkmPj7noTQ9hgIYhPAeZviHkxZZTWh8xqDWVEX77mkpej+uwagvBpZZRbgSsrJISu
        cqI4G+JnCHyTBZ5xuzyY6v1qj
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr8795302eje.104.1617869718243;
        Thu, 08 Apr 2021 01:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhyXYMZinDvRVyw5WxA8BlhYx5A8sIWRaAJtUqZGlQ+jt2l1v6VE6WZQNkXJPDdHi4P725KQ==
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr8795285eje.104.1617869718100;
        Thu, 08 Apr 2021 01:15:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id mj3sm5262774ejb.3.2021.04.08.01.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 01:15:17 -0700 (PDT)
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, dwmw@amazon.co.uk
References: <20210330165958.3094759-1-pbonzini@redhat.com>
 <20210330165958.3094759-2-pbonzini@redhat.com>
 <20210407174021.GA30046@fuller.cnet>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: x86: reduce pvclock_gtod_sync_lock critical
 sections
Message-ID: <51cae826-8973-5113-7e12-8163eab36cb7@redhat.com>
Date:   Thu, 8 Apr 2021 10:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210407174021.GA30046@fuller.cnet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/21 19:40, Marcelo Tosatti wrote:
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index fe806e894212..0a83eff40b43 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2562,10 +2562,12 @@ static void kvm_gen_update_masterclock(struct kvm *kvm)
>>   
>>   	kvm_hv_invalidate_tsc_page(kvm);
>>   
>> -	spin_lock(&ka->pvclock_gtod_sync_lock);
>>   	kvm_make_mclock_inprogress_request(kvm);
>> +
> Might be good to serialize against two kvm_gen_update_masterclock
> callers? Otherwise one caller could clear KVM_REQ_MCLOCK_INPROGRESS,
> while the other is still at pvclock_update_vm_gtod_copy().

Makes sense, but this stuff has always seemed unnecessarily complicated 
to me.

KVM_REQ_MCLOCK_INPROGRESS is only needed to kick running vCPUs out of 
the execution loop; clearing it in kvm_gen_update_masterclock is 
unnecessary, because KVM_REQ_CLOCK_UPDATE takes pvclock_gtod_sync_lock 
too and thus will already wait for pvclock_update_vm_gtod_copy to end.

I think it's possible to use a seqcount in KVM_REQ_CLOCK_UPDATE instead 
of KVM_REQ_MCLOCK_INPROGRESS.  Both cause the vCPUs to spin. I'll take a 
look.

Paolo

