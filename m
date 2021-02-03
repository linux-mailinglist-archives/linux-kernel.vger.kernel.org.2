Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8430D536
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhBCI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232531AbhBCI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612340892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hwrk+FTuLG7Q9mmQWSF89fyayVM9Juk+kBi6JrWoyJM=;
        b=DudyKzUXbQb66jy16nOaArrT4HDD/JQji7+xMuk1qBPCIgKSDQtK+W2LTRl7AuQu0Ey0xG
        NXvJv9iTL8AYByT/VpYCoZLjNV8FwkZEFRYa1jV/WxpQxtc0238p/g43noWON/oTXMt1zx
        25rWdVnMgrTBTqeu4S4DE1bsQSHJfgY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-6QMWNdyUOVqUh5SDyRZtEw-1; Wed, 03 Feb 2021 03:28:10 -0500
X-MC-Unique: 6QMWNdyUOVqUh5SDyRZtEw-1
Received: by mail-ej1-f70.google.com with SMTP id aq28so524325ejc.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hwrk+FTuLG7Q9mmQWSF89fyayVM9Juk+kBi6JrWoyJM=;
        b=J/RlpamqkfKLyi7fph3a72iw5CdlNu9Z+rqmOB1xSuwJPM9ExthPZq4PywtysN0ifD
         u3efPBtXWzptuU4iOxBhWSEj1FZtL/OU0zf/XvPRbnsUVcPoD0KPdCbxTexzdlMhtMY5
         ctEjhs0i68jQh+FSSCgOxXWDB2GHzXtHUuASS4AtgJhnRvus8StXhTHsUGURfUlK1QSj
         B100zO7wnN7bPD+F6HbIYdxL4c+TWiLpPLAjvI8DD1xoDDDECIKTBesnDkxd+hp7nCNo
         JMGSNmFZbwpq54RHTvnRZs++kNnn/dj3ekrNfCopW+U4Cp3U4F9fKnDFordeL+3hP+E2
         rPyw==
X-Gm-Message-State: AOAM531cjiBK49UG5jFEVlP6pa6YhapYu5SuxHwJcVBTgJEnzvBy8bIT
        kiMWDBv9gHY1mcvvs/G0YMbqJnOzGg+kK7eBwT8pkWN66rtQwYFwQtW2LE0XG2aRoTQyziTyoI8
        UU2IssHYprH41VB1i00+5TqpF
X-Received: by 2002:a17:906:c00a:: with SMTP id e10mr2091754ejz.501.1612340889176;
        Wed, 03 Feb 2021 00:28:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUvkxOC7hKKIz7OGBgJZSpg8doxelK0Cjst9iB13YoHobfg46zDnGcT5IzRnbxhQ0vS+MkRw==
X-Received: by 2002:a17:906:c00a:: with SMTP id e10mr2091744ejz.501.1612340888985;
        Wed, 03 Feb 2021 00:28:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l13sm649535eji.49.2021.02.03.00.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:28:08 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: cleanup CR3 reserved bits checks
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210202170244.89334-1-pbonzini@redhat.com>
 <YBmbM8PToDWr9ti/@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7077098b-d5f0-afe1-9924-def460d06f96@redhat.com>
Date:   Wed, 3 Feb 2021 09:28:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBmbM8PToDWr9ti/@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:34, Sean Christopherson wrote:
> On Tue, Feb 02, 2021, Paolo Bonzini wrote:
>> If not in long mode, the low bits of CR3 are reserved but not enforced to
>> be zero, so remove those checks.  If in long mode, however, the MBZ bits
>> extend down to the highest physical address bit of the guest, excluding
>> the encryption bit.
>>
>> Make the checks consistent with the above, and match them between
>> nested_vmcb_checks and KVM_SET_SREGS.
>>
> Fixes + Cc:stable@?

Difficult to say what it fixes, it's been there forever for KVM_SET_SREGS.

For the nSVM part I'll go with

Fixes: 761e41693465 ("KVM: nSVM: Check that MBZ bits in CR3 and CR4 are 
not set on vmrun of nested guests")

Paolo

>> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> Reviewed-by: Sean Christopherson<seanjc@google.com>  
> 

