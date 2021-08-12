Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7433EAB27
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhHLTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233823AbhHLTms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628797342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VMd9t1Nb4FeOHDdu/UYPvY9zAU3dF/VqguEioUUUfOM=;
        b=JLaypGyPe5+YT9LdANXEN8FKIAP7ed8LjF/ehXuRtuWj6tG/XFxchMiY0ODiPAFgqGNXYR
        zb8rNjZtXdjLeu6YRaXoVNzQMmRA69iNYCLV/IJBmhytLXyY7fSbcPORJnJtARADgkuBxS
        lkniG74Dds2Omxl8IKKVKlYcvI2HzNQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-vw7AvYlPOzOZggEaRlgA6w-1; Thu, 12 Aug 2021 15:42:21 -0400
X-MC-Unique: vw7AvYlPOzOZggEaRlgA6w-1
Received: by mail-qk1-f200.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so4293753qki.15
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VMd9t1Nb4FeOHDdu/UYPvY9zAU3dF/VqguEioUUUfOM=;
        b=R1pdZ3U/IyvvRBLJFB3RbYgb9s/kMd8Mt70ANb517q4HY1yVbFyDplaRNl9xMeHAG7
         t256V72wMBDTJrs7/2gP1biSs2kado2ZhmwtRBGGeCXouPq7QwohnNdXn3LNg4LBnOIa
         1kgyw0wEo6vCOHXuon21YefjClx8h5fgoCS6Nq8GIaYfcN9kP2hGcIGxqIodmSJcRyWl
         Z2sxCvE0yPssQ5lY4tGC2U1ck++M9076TADtL0WsgvinONR/FXjs5J5V9pPAj0XLls83
         ij6ZiGpcFeANfLOOlRaw2sSh7BLSAojQXy6iD795iVBeTMnMijPaTYY+MJ86J0knRYXv
         bYJw==
X-Gm-Message-State: AOAM533H5UFNNclWYq6+UefrBBnOBm0WO8iYoUnQfr6F4BGVP7ujtT7f
        qGfx4cbAl/hKhLzRynINBpUIpsDaruhga+7EcR0fLNiH4t9o+eX3hPmymyCPRwVz2xEbFc7Jwkd
        csTUUW5N/Gvx7tA8UniUYR3GZ
X-Received: by 2002:ac8:5503:: with SMTP id j3mr5320090qtq.53.1628797340496;
        Thu, 12 Aug 2021 12:42:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUUvZMpL7pSCm7q5XzMoYt2z1wevJP9H/EwWfdEYX35IIBypQ1jgNWDZP3M5c9bm3yA3odfA==
X-Received: by 2002:ac8:5503:: with SMTP id j3mr5320084qtq.53.1628797340331;
        Thu, 12 Aug 2021 12:42:20 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id o10sm1532330qtv.31.2021.08.12.12.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 12:42:19 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH -tip] locking: Move CONFIG_LOCK_EVENT_COUNTS into Kernel
 hacking section
To:     Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        mingo@redhat.com
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20210330020636.112594-1-dave@stgolabs.net>
 <20210812190526.mfrz5ifdodbncz3w@offworld>
Message-ID: <de40081c-82c8-e22a-4b24-f9fd91e3921e@redhat.com>
Date:   Thu, 12 Aug 2021 15:42:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812190526.mfrz5ifdodbncz3w@offworld>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/21 3:05 PM, Davidlohr Bueso wrote:
> Ping?
>
> On Mon, 29 Mar 2021, Davidlohr Bueso wrote:
>
>> It's a lot more intuitive to have it in the locking section of the 
>> kernel
>> hacking part rather than under "General architecture-dependent options".
>>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> ---
>> arch/Kconfig      | 9 ---------
>> lib/Kconfig.debug | 9 +++++++++
>> 2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index ecfd3520b676..d6f9aeaaf9f2 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -1113,15 +1113,6 @@ config HAVE_ARCH_PREL32_RELOCATIONS
>> config ARCH_USE_MEMREMAP_PROT
>>     bool
>>
>> -config LOCK_EVENT_COUNTS
>> -    bool "Locking event counts collection"
>> -    depends on DEBUG_FS
>> -    help
>> -      Enable light-weight counting of various locking related events
>> -      in the system with minimal performance impact. This reduces
>> -      the chance of application behavior change because of timing
>> -      differences. The counts are reported via debugfs.
>> -
>> # Select if the architecture has support for applying RELR relocations.
>> config ARCH_HAS_RELR
>>     bool
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 2779c29d9981..76639ff5998c 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1401,6 +1401,15 @@ config DEBUG_LOCKING_API_SELFTESTS
>>       The following locking APIs are covered: spinlocks, rwlocks,
>>       mutexes and rwsems.
>>
>> +config LOCK_EVENT_COUNTS
>> +    bool "Locking event counts collection"
>> +    depends on DEBUG_FS
>> +    help
>> +      Enable light-weight counting of various locking related events
>> +      in the system with minimal performance impact. This reduces
>> +      the chance of application behavior change because of timing
>> +      differences. The counts are reported via debugfs.
>> +
>> config LOCK_TORTURE_TEST
>>     tristate "torture tests for locking"
>>     depends on DEBUG_KERNEL
>> -- 
>> 2.26.2
>>
>
I have no objection to that.

Acked-by: Waiman Long <longman@redhat.com>

