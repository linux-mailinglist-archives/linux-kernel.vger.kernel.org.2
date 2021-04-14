Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B3C35EE94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349640AbhDNHm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230488AbhDNHm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618386125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vh/Sbv2J9ATgTPWIHXpS7JkYnnlN0nFdVDxNhS58h1M=;
        b=dGvo1G73j6ofSc6tjRbE8x+lLbhsDnZIPpKaJ26h5EA3gNLf/NVo6vBKnAsPL0YqrwkJkX
        5toee6N2zROJbLFZztglBgDAF1xzNH8/o22d7nJTzAmMda63am3BseqPUwnfNiALl/U/BM
        PYQCobIfXoW0+5JOnjlG1TTE2JCVX4Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-pJLfj_sUNBe4iF3MvibegQ-1; Wed, 14 Apr 2021 03:42:03 -0400
X-MC-Unique: pJLfj_sUNBe4iF3MvibegQ-1
Received: by mail-wr1-f69.google.com with SMTP id w7-20020adfd4c70000b02900ffe4452aa4so667760wrk.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vh/Sbv2J9ATgTPWIHXpS7JkYnnlN0nFdVDxNhS58h1M=;
        b=jtsU4Nr7EWeXUbdULj8rI3BQNwFdiXaTIJsp8lutxzn4NuxWerrZ9FDQCRhLiopIm5
         MiL1/tNksSj9VLA+mqn256Bi0koyxbPre9gmZsrPkaRHDBmxQl9CR9VjtyIKo6IcvMIv
         CKh2qh/LQJN6Mdt5CEO2dfxiMgTxalTPRSBQckFdGLibMk1RZX0NlpYZtS7O8U6sMMne
         fEf9lnsoEdmwh8s5OY+HbELOEGsgX9wKYo11r5Q9+jDouc445nL0mFJF4gPfirxp53oa
         EoMeURnnRmJpcU7fjNrCrmmbOhkpKFGkOcjowkrrgm/4sWVzOJk+rPc0RihdgOJFKGmC
         bFzg==
X-Gm-Message-State: AOAM532/WcG2TrhFcB1tts97qRtEV2lw99fp07wTnVBq7TYf2xWnrbSb
        TQvPzZQRu+ZzxYivffwqdk/AVE/9Dk5oxcKfav1jmeNvb0WfMtomNDkaYGw8f04atQ45yMovyDo
        rtsQhO+BeDLu0MLEW8hISXiq+
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr1616444wmj.188.1618386122251;
        Wed, 14 Apr 2021 00:42:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3VKmTn+g+bpJPVe/b63TJ2zMcg9oEYc0cgtQiMGhO6j58kPjjkM9SLmTHK30EGqD8iMLRQw==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr1616427wmj.188.1618386122043;
        Wed, 14 Apr 2021 00:42:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id n3sm4567367wmi.7.2021.04.14.00.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 00:42:01 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <11752259.O9o76ZdvQC@kreacher>
 <dea11d82-4fe5-ac23-585c-a1f74e076ca7@redhat.com>
 <CAJZ5v0hHJYT6kSxoH-v7QQ7oOh=OgQXDpNB7BW7rPwrc0L3SOQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] ACPI: x86: Call acpi_boot_table_init() after
 acpi_table_upgrade()
Message-ID: <5cfba81b-fe73-b604-2442-011deee9bcb3@redhat.com>
Date:   Wed, 14 Apr 2021 09:42:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hHJYT6kSxoH-v7QQ7oOh=OgQXDpNB7BW7rPwrc0L3SOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.21 19:53, Rafael J. Wysocki wrote:
> On Tue, Apr 13, 2021 at 7:43 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 13.04.21 16:01, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by
>>> ACPI tables") attempted to address an issue with reserving the memory
>>> occupied by ACPI tables, but it broke the initrd-based table override
>>> mechanism relied on by multiple users.
>>>
>>> To restore the initrd-based ACPI table override functionality, move
>>> the acpi_boot_table_init() invocation in setup_arch() on x86 after
>>> the acpi_table_upgrade() one.
>>>
>>> Fixes: 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> George, can you please check if this reintroduces the issue addressed by
>>> the above commit for you?
>>>
>>> ---
>>>    arch/x86/kernel/setup.c |    5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> Index: linux-pm/arch/x86/kernel/setup.c
>>> ===================================================================
>>> --- linux-pm.orig/arch/x86/kernel/setup.c
>>> +++ linux-pm/arch/x86/kernel/setup.c
>>> @@ -1045,9 +1045,6 @@ void __init setup_arch(char **cmdline_p)
>>>
>>>        cleanup_highmap();
>>>
>>> -     /* Look for ACPI tables and reserve memory occupied by them. */
>>> -     acpi_boot_table_init();
>>> -
>>>        memblock_set_current_limit(ISA_END_ADDRESS);
>>>        e820__memblock_setup();
>>>
>>> @@ -1132,6 +1129,8 @@ void __init setup_arch(char **cmdline_p)
>>>        reserve_initrd();
>>>
>>>        acpi_table_upgrade();
>>> +     /* Look for ACPI tables and reserve memory occupied by them. */
>>> +     acpi_boot_table_init();
>>>
>>>        vsmp_init();
>>
>> This is fairly late; especially, it's after actual allocations -- see
>> e820__memblock_alloc_reserved_mpc_new().
>>
>> Can't the table upgrade mechanism fix up when adjusting something?
> 
> Not at this point of the cycle I'm afraid.
> 
>> Some details on what actually breaks would be helpful.
> 
> Generally speaking, the table overrides that come from the initrd are
> not taken into account if acpi_boot_table_init() runs before
> acpi_table_upgrade() and the latter cannot run before
> reserve_initrd().

I see. (looking at Documentation/acpi/initrd_table_override.txt I 
understand what acpi table overrides are for :) )

> 
> Honestly, I'm not sure how much effort it would take to untangle this ATM.

Also true; ideally, we wouldn't have any allocations (find+reserve) 
before ordinary reservations are done.

However, I have no idea if we can move 
e820__memblock_alloc_reserved_mpc_new() and reserve_real_mode() around 
easily. Also, reserve_initrd()->relocate_initrd() does allocations.

This is a mess.

-- 
Thanks,

David / dhildenb

