Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E030C503
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhBBQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235874AbhBBQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612281910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GoHqkcd1GD6lYKRpDHWZ6PFpXaEZ93xMiO7nY5L+AQ8=;
        b=X6z/xyJ+qU0eu/4PUETjqfolGeNWJ35Puog9fUl+FbptZW8Kfw4rddMal/ys9C/csvcOH6
        szhBaZvA+XHUKY6xgplMB1Bn/D+LUeTq7edYb/Ml40PjlwOfF0pfbXqu3ezs/+eBCPj5IZ
        z7dPSnn5uwb0wQszDPYJdgWNi5JY5X4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-KPH9zAxzMmiAhd2jB5qlyQ-1; Tue, 02 Feb 2021 11:05:08 -0500
X-MC-Unique: KPH9zAxzMmiAhd2jB5qlyQ-1
Received: by mail-ej1-f72.google.com with SMTP id le12so10219051ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GoHqkcd1GD6lYKRpDHWZ6PFpXaEZ93xMiO7nY5L+AQ8=;
        b=BUzHGsmyNGsR1ds9inTdjGdd3eByKm6RIzhZzgwZ+iz25wbsHBFDZXxkrfqKYNRn3L
         9Q5opBEnWh+kYMGz9lASk61hWNDKZdNDcY1/7ycgwgEuV7rskvGWLQA4SB6sda3pVOYO
         JfiOtweEHV+Zc7EUWrWbeEha1jfAyOVQE58U6G8OAiSG1XZjZUHEsM1zzmAHC03tKBwp
         AUoVo2h0bGRIxAFwKIyaB+1D4aGqhkU8x94h9X5SDa9QxFPr6gevAdxahEJt33p4YlTZ
         0MN+58AsiUH6WgFZdV7I6gMxrMhz8Ufjhj7WD5w0Fj2uB2i3R06IZNbgZ6B89u3wJkpJ
         tTGQ==
X-Gm-Message-State: AOAM533dzxnIxN9mtlJ0EjFLtMzaEc6wWirhaC32i1wpALW4D2QsuRoT
        /6ad30NFlv5xuRMeuLRgvGhAkIkEg2/0VMUoA/JQLHSaIvWujYXiCUGO4EANnlhCY5qH226oNY9
        x3UM7PDIUIl31BjfmdJNupO/pJyE7KED4YAP9e9a6xVDWdVRwu1kk7pR+9iAxBJKwdJvKz+Y+m2
        CC
X-Received: by 2002:aa7:d0d4:: with SMTP id u20mr23467804edo.203.1612281906880;
        Tue, 02 Feb 2021 08:05:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPM7p5TyqnwHjGKi0caOD1YfB9dGRpowZ+WQHtxS6E6Y0e0Ymh7IbcVOjUFtqL6dXlAH2MJg==
X-Received: by 2002:aa7:d0d4:: with SMTP id u20mr23467772edo.203.1612281906630;
        Tue, 02 Feb 2021 08:05:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q16sm9657765ejd.39.2021.02.02.08.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 08:05:05 -0800 (PST)
Subject: Re: [PATCH v2 1/3] KVM: X86: Rename DR6_INIT to DR6_ACTIVE_LOW
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210202090433.13441-1-chenyi.qiang@intel.com>
 <20210202090433.13441-2-chenyi.qiang@intel.com>
 <3db069ba-b4e0-1288-ec79-66ac44938682@redhat.com>
 <6678520f-e69e-6116-88c9-e9d6cd450934@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea9eaa84-999b-82cb-ef40-66fde361704d@redhat.com>
Date:   Tue, 2 Feb 2021 17:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6678520f-e69e-6116-88c9-e9d6cd450934@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 16:02, Xiaoyao Li wrote:
> On 2/2/2021 10:49 PM, Paolo Bonzini wrote:
>> On 02/02/21 10:04, Chenyi Qiang wrote:
>>>
>>>  #define DR6_FIXED_1    0xfffe0ff0
>>> -#define DR6_INIT    0xffff0ff0
>>> +/*
>>> + * DR6_ACTIVE_LOW is actual the result of DR6_FIXED_1 | 
>>> ACTIVE_LOW_BITS.
>>> + * We can regard all the current FIXED_1 bits as active_low bits even
>>> + * though in no case they will be turned into 0. But if they are 
>>> defined
>>> + * in the future, it will require no code change.
>>> + * At the same time, it can be served as the init/reset value for DR6.
>>> + */
>>> +#define DR6_ACTIVE_LOW    0xffff0ff0
>>>  #define DR6_VOLATILE    0x0001e00f
>>>
>>
>> Committed with some changes in the wording of the comment.
>>
>> Also, DR6_FIXED_1 is (DR6_ACTIVE_LOW & ~DR6_VOLATILE).
> 
> Maybe we can add BUILD_BUG_ON() to make sure the correctness?

We can even

#define DR_FIXED_1  (DR6_ACTIVE_LOW & ~DR6_VOLATILE)

directly.  I have pushed this patch to kvm/queue, but the other two will 
have to wait for Fenghua's bare metal support.

Paolo

