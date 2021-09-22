Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD84150BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhIVTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237262AbhIVTxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632340341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKJgefLdWJy0dp9TYiGmtdcSy+WA2ewqvdcD0wX0UjM=;
        b=GfCwVW7gBe6f2cLwBpZlazaSDDefEFmdU9kFIjM7dG0iZlLtFFFeDqfReWio1q1tG1kud5
        F7vRt3S+vzf7Z9WdCYqNuemWu4b7uCP9PLmhShH/j2o+ijZkmOtkZwMbyUtR9ERImjsqOw
        iXeJayXt6bpyZZyKoSVaBs/Sp8DBcIg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-G5zSQINEPkmGkcBBXwUKkQ-1; Wed, 22 Sep 2021 15:52:20 -0400
X-MC-Unique: G5zSQINEPkmGkcBBXwUKkQ-1
Received: by mail-qt1-f200.google.com with SMTP id z16-20020ac86b90000000b0029eec160182so11006789qts.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xKJgefLdWJy0dp9TYiGmtdcSy+WA2ewqvdcD0wX0UjM=;
        b=cccklwJ+K+YDPX4KjAGYpeaD5qZ5gH3C+s/1jUT6j2DqDljKU0z6C/L5yOcqFFSaJl
         Zyqw7vcGN11fox9QAi+wEKL6R7Ig5sGiRf3rRuJy2XPSL/v+LZw74c6DaiUW8ftiL/9t
         s10rcSwspZaleHPMI5ow14z9ydmz6WXXHMuC+IqM1tBO0jciVoFZXCGG3jQca6LeP2JF
         DGYutGjX3jrh/WfJpzG2WSUEwkOduP1bMUs6Vk8pwFca0EVjzv4pYklnNfNEcoGn/qc3
         p19at1YukLGbIRJvEvtH5AqWcyJxSLi5aQeIK7me4c16/Hfosb0/vGPIP94nUVVHve4+
         zrFQ==
X-Gm-Message-State: AOAM5339Wh0KDTxgSss0DRI8FocycfJjDfDlb2C7jb569v9nyHafGgoQ
        llYSB2sR3cDaOqiFZUD1cPvvk0464pG8GvBAa9dWge8IeWwlC/bQDGj8rg6UN69hWySCyH6mjjN
        2Uu//80aAuUjd0tCTp280/z8I
X-Received: by 2002:a37:a8c1:: with SMTP id r184mr1063024qke.389.1632340340190;
        Wed, 22 Sep 2021 12:52:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvWXlOT4CAVdD5eoMa4qYxPLr98GVG+fY6djJAvqKhRJ80pZbxe74g2EjlcdKhL3xmrArIxw==
X-Received: by 2002:a37:a8c1:: with SMTP id r184mr1062990qke.389.1632340339926;
        Wed, 22 Sep 2021 12:52:19 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 188sm2533277qkm.21.2021.09.22.12.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 12:52:19 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v15 3/6] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com>
 <20210922192528.ob22pu54oeqsoeno@offworld>
Message-ID: <8e743acb-ec75-ea03-493a-d57154ab8fed@redhat.com>
Date:   Wed, 22 Sep 2021 15:52:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922192528.ob22pu54oeqsoeno@offworld>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/21 3:25 PM, Davidlohr Bueso wrote:
> On Fri, 14 May 2021, Alex Kogan wrote:
>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index a816935d23d4..94d35507560c 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3515,6 +3515,16 @@
>>             NUMA balancing.
>>             Allowed values are enable and disable
>>
>> +    numa_spinlock=    [NUMA, PV_OPS] Select the NUMA-aware variant
>> +            of spinlock. The options are:
>> +            auto - Enable this variant if running on a multi-node
>> +            machine in native environment.
>> +            on  - Unconditionally enable this variant.
>
> Is there any reason why the user would explicitly pass the on option
> when the auto thing already does the multi-node check? Perhaps strange
> numa topologies? Otherwise I would say it's not needed and the fewer
> options we give the user for low level locking the better.

I asked Alex to put in a command line option because we may want to 
disable it on a multi-socket server if we want to.


>
>> +            off - Unconditionally disable this variant.
>> +
>> +            Not specifying this option is equivalent to
>> +            numa_spinlock=auto.
>> +
>>     numa_zonelist_order= [KNL, BOOT] Select zonelist order for NUMA.
>>             'node', 'default' can be specified
>>             This can be set from sysctl after boot.
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 0045e1b44190..819c3dad8afc 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1564,6 +1564,26 @@ config NUMA
>>
>>       Otherwise, you should say N.
>>
>> +config NUMA_AWARE_SPINLOCKS
>> +    bool "Numa-aware spinlocks"
>> +    depends on NUMA
>> +    depends on QUEUED_SPINLOCKS
>> +    depends on 64BIT
>> +    # For now, we depend on PARAVIRT_SPINLOCKS to make the patching 
>> work.
>> +    # This is awkward, but hopefully would be resolved once 
>> static_call()
>> +    # is available.
>> +    depends on PARAVIRT_SPINLOCKS
>
> We now have static_call() - see 9183c3f9ed7.
I agree that it is now time to look at using the static call for 
slowpath switching.
>
>
>> +    default y
>> +    help
>> +      Introduce NUMA (Non Uniform Memory Access) awareness into
>> +      the slow path of spinlocks.
>> +
>> +      In this variant of qspinlock, the kernel will try to keep the 
>> lock
>> +      on the same node, thus reducing the number of remote cache 
>> misses,
>> +      while trading some of the short term fairness for better 
>> performance.
>> +
>> +      Say N if you want absolute first come first serve fairness.
>
> This would also need a depends on !PREEMPT_RT, no? Raw spinlocks 
> really want
> the determinism. 

Agreed

Cheers,
Longman

