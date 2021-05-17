Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C300382E26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhEQODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237558AbhEQODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621260143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6s1yDNXr5UsIpHaO+R8G1tNC83nwkRLaMHkcLolQzE=;
        b=S6B0U5Zr2XwpoC+uIB4UYroKTMdVfM7t0wavbqWg4EkZtcmlt3rarfKsB2yL2u7hdNiz0K
        Zk6faOZQgwez+9IpcIgGL2JxQ6utJSvMDjVMsIq3bM2r8MhqHBJga/pKjbjJh2Hc37WDGZ
        pmMdTPPaXHadby22yDknYLcgAfVj+30=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-x01rq60HMBmiN2RE6h5I9A-1; Mon, 17 May 2021 10:02:21 -0400
X-MC-Unique: x01rq60HMBmiN2RE6h5I9A-1
Received: by mail-qv1-f69.google.com with SMTP id t1-20020a0ca6810000b029019e892416e6so4816947qva.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w6s1yDNXr5UsIpHaO+R8G1tNC83nwkRLaMHkcLolQzE=;
        b=ruOXKvcyGo/zktt9q68PCC4WbuaibWukddZmetZb0l/nldSATX4xeP+1U/npB1JieJ
         n79dmaJtY5irqKT1effx+U62awUndlGhFLEs6h5OlVWo8Zq3esF+V6Pj+HooTCWX+evE
         qq3fm5a25a7QuwcCMlFKP2gziJEhIeC6hPE9xxTR1zm83ctZV1X8p7RCMSvRcr48sHE9
         lGVEujWufXPnfdR3TmsEzHsazRGu7MfMCoZMCGhLk4FmQETz5fGQzl7NKFkxbzJIOaQx
         k8uTyQ6nn/wsFytelLMThjlRkVDIhv8RMiJsUbrKlRB5wxcvQOxX1D+5Ae6a9Q8OFRdN
         y3qQ==
X-Gm-Message-State: AOAM532UXsJV1/+KbZnb7SyCcctOAX8zmRkA6RUWnyE6moEGMG5HNt2n
        LdRqSn487msNXLXNUmtk6v3a/DjfJRWHIWZSqt8AAINh46DC5MgV0FLkW4zUaXYTwQ8ANiR+0U1
        VBhqs/DVxEETVet57FhyhThuI
X-Received: by 2002:a0c:eed4:: with SMTP id h20mr8343785qvs.40.1621260140563;
        Mon, 17 May 2021 07:02:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPIfQ6kOCYXBacv0G7uf1D/efSyaB9HxTwcqdqsE59i1IWqhcqDas3fJRiGamTBohV+PHPQg==
X-Received: by 2002:a0c:eed4:: with SMTP id h20mr8343742qvs.40.1621260140330;
        Mon, 17 May 2021 07:02:20 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id k2sm8893323qtg.68.2021.05.17.07.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:02:19 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
To:     Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
References: <20210517034430.9569-1-rdunlap@infradead.org>
 <YKIXBpxyvhzdb1uv@gmail.com>
Message-ID: <1284b997-b9da-769f-2d36-4d4232c7df88@redhat.com>
Date:   Mon, 17 May 2021 10:02:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YKIXBpxyvhzdb1uv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 3:11 AM, Ingo Molnar wrote:
> * Randy Dunlap <rdunlap@infradead.org> wrote:
>
>> Both arch/um/ and arch/xtensa/ cause a Kconfig warning for LOCKDEP.
>> These arch-es select LOCKDEP_SUPPORT but they are not listed as one
>> of the arch-es that LOCKDEP depends on.
>>
>> Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
>> intend to have LOCKDEP support, replace the awkward list of
>> arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.
>>
>> Fixes this kconfig warning: (for both um and xtensa)
>>
>> WARNING: unmet direct dependencies detected for LOCKDEP
>>    Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>>    Selected by [y]:
>>    - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>    - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>    - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>> Cc: linux-xtensa@linux-xtensa.org
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: linux-um@lists.infradead.org
>> ---
>>   lib/Kconfig.debug |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20210514.orig/lib/Kconfig.debug
>> +++ linux-next-20210514/lib/Kconfig.debug
>> @@ -1383,7 +1383,7 @@ config LOCKDEP
>>   	bool
>>   	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>>   	select STACKTRACE
>> -	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
>> +	depends on FRAME_POINTER || LOCKDEP_SUPPORT
> Ok - the FRAME_POINTER bit is weird. Are there any architectures that have
> FRAME_POINTER defined but no LOCKDEP_SUPPORT?

LOCK_DEBUGGING_SUPPORT depends on LOCKDEP_SUPPORT. So this patch is 
equivalent to just delete the second depends-on line. Beside LOCKDEP, 
LATENCYTOP also have exactly the same depends-on line.

So isn't FRAME_POINTER used mainly to support STACK_TRACE? However, 
LOCK_DEBUGGING_SUPPORT has already included STACK_TRACE_SUPPORT in its 
dependency. So why there is a FRAME_POINTER dependency?

Cheers,
Longman

