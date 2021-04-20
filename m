Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F243A365AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhDTOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231422AbhDTOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618927679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDVmsZT82WF5IHvcZJyjG++DF0zOp7ksAtsJgyQLwio=;
        b=U7VfFL41Ij7PkorZC+d7NRKA6WKzS5UPxK+cwIOL31rMqOySUKTK5w92roTguFjebk6TLz
        PDE48KfxhGAHHMNqQN6xxeVhMm5g4MrvarZB0a9scmkmLAxMGfzF5fvvACBB6l15VP7fjU
        MT0FJJKY6TK5afGgZ5J+0MuyyMvUVPk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-FFI1ZFkEOM-9NLC_RwObjg-1; Tue, 20 Apr 2021 10:07:55 -0400
X-MC-Unique: FFI1ZFkEOM-9NLC_RwObjg-1
Received: by mail-ed1-f71.google.com with SMTP id t11-20020aa7d4cb0000b0290382e868be07so13172572edr.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDVmsZT82WF5IHvcZJyjG++DF0zOp7ksAtsJgyQLwio=;
        b=WE0t5Jtzo+chKkGxxGgW4ToEQKO8E0rNqBuJa/kkwODAEzWyAGi4u3NKDI9BHPuC5m
         uODJ+c0yd2+XHcSUJozgZ0nyPSKPHdgZuWhoowg7a876OMzTV8X/8YGMUgvdLajZZM1V
         W9gH1PF4tQvkoARx5ZgfLDNoc0G1PEwVmtHzN5sJqwGc4B+o1iuKThrSyjNzhwNlXUoi
         ttsgScCjgLXlCpg/1p7y7dJhCS0pzCR63PaWSQG61NkkKFD2QHdbi9gwinecaxu6+yX6
         3uu6VUxVBqTF4QAW5xTTSH9qy6SrX7fBNZ860+raBkxySThXV9VqmKb5jmVk1ITCOks1
         tqJQ==
X-Gm-Message-State: AOAM532u3UK2i38MIZvYmh+RHat9XxS8vinfH9UIJm+mZPaWdPRyD351
        Hpd0KMv72HO9bOI8kPTOX5jh+Hh8C1ptolwqaVOZQRrTKSzYS2hXxJbR8NGDblrnpdDWUFDMrl5
        o/Wgbvsb9zlxWNqNVGzXpQ6bo
X-Received: by 2002:a05:6402:278d:: with SMTP id b13mr32202748ede.34.1618927673702;
        Tue, 20 Apr 2021 07:07:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsIyaH/fgrNE9cx6DPFnsc2ZoUIN4T+efZ+L0gcuhnjAJpXVjXgEYOrwxoSGCxE6PwPWOSAw==
X-Received: by 2002:a05:6402:278d:: with SMTP id b13mr32202719ede.34.1618927673473;
        Tue, 20 Apr 2021 07:07:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id d1sm15235952ede.31.2021.04.20.07.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 07:07:52 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] KVM: selftests: Sync data verify of dirty logging
 with guest sync
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <20210417143602.215059-1-peterx@redhat.com>
 <20210417143602.215059-2-peterx@redhat.com> <20210418124351.GW4440@xz-x1>
 <60b0c96c-161d-676d-c30a-a7ffeccab417@redhat.com>
 <20210420131041.GZ4440@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e110673a-8422-bdff-4336-bdb486842d39@redhat.com>
Date:   Tue, 20 Apr 2021 16:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210420131041.GZ4440@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 15:10, Peter Xu wrote:
> On Tue, Apr 20, 2021 at 10:07:16AM +0200, Paolo Bonzini wrote:
>> On 18/04/21 14:43, Peter Xu wrote:
>>> ----8<-----
>>> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
>>> index 25230e799bc4..d3050d1c2cd0 100644
>>> --- a/tools/testing/selftests/kvm/dirty_log_test.c
>>> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
>>> @@ -377,7 +377,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
>>>           /* A ucall-sync or ring-full event is allowed */
>>>           if (get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC) {
>>>                   /* We should allow this to continue */
>>> -               ;
>>> +               vcpu_handle_sync_stop();
>>>           } else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL ||
>>>                      (ret == -1 && err == EINTR)) {
>>>                   /* Update the flag first before pause */
>>> ----8<-----
>>>
>>> That's my intention when I introduce vcpu_handle_sync_stop(), but forgot to
>>> add...
>>
>> And possibly even this (untested though):
>>
>> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
>> index ffa4e2791926..918954f01cef 100644
>> --- a/tools/testing/selftests/kvm/dirty_log_test.c
>> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
>> @@ -383,6 +383,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
>>   		/* Update the flag first before pause */
>>   		WRITE_ONCE(dirty_ring_vcpu_ring_full,
>>   			   run->exit_reason == KVM_EXIT_DIRTY_RING_FULL);
>> +		atomic_set(&vcpu_sync_stop_requested, false);
>>   		sem_post(&sem_vcpu_stop);
>>   		pr_info("vcpu stops because %s...\n",
>>   			dirty_ring_vcpu_ring_full ?
>> @@ -804,8 +805,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>>   		 * the flush of the last page, and since we handle the last
>>   		 * page specially verification will succeed anyway.
>>   		 */
>> -		assert(host_log_mode == LOG_MODE_DIRTY_RING ||
>> -		       atomic_read(&vcpu_sync_stop_requested) == false);
>> +		assert(atomic_read(&vcpu_sync_stop_requested) == false);
>>   		vm_dirty_log_verify(mode, bmap);
>>   		sem_post(&sem_vcpu_cont);
>>
>> You can submit all these as a separate patch.
> 
> But it could race, then?
> 
>          main thread                 vcpu thread
>          -----------                 -----------
>                                    ring full
>                                      vcpu_sync_stop_requested=0
>                                      sem_post(&sem_vcpu_stop)
>       vcpu_sync_stop_requested=1
>       sem_wait(&sem_vcpu_stop)
>       assert(vcpu_sync_stop_requested==0)   <----

Yes, it could indeed.

Thanks,

Paolo

