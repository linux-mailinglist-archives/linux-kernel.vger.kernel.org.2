Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A2D363020
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhDQNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 09:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236437AbhDQNAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618664392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWecu6SQYs8uhFs35a7UYYtKfFOnP5nbm6nErBWz6m0=;
        b=W9u0a6E5nKrh5tjuxAVitWgMNeuqeyfZjsn36dvWGn9LIburHfhvr+0qNtfevb4zfy/5m0
        tpYeAzx16l/VZDFZhNmSH8U0lZkroNZg0+7lpkC+SaDx5YtCnSwvWpsh4Jd6CVaBDdlQyO
        8QQbBtHN/nOX1yqKa2suk2b1CJlAddE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-63Dl1yi7N-CBazIIGmGuGA-1; Sat, 17 Apr 2021 08:59:50 -0400
X-MC-Unique: 63Dl1yi7N-CBazIIGmGuGA-1
Received: by mail-ed1-f70.google.com with SMTP id l7-20020aa7c3070000b029038502ffe9f2so2858841edq.16
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 05:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWecu6SQYs8uhFs35a7UYYtKfFOnP5nbm6nErBWz6m0=;
        b=MjmbT+EazJaW9tSBbU+FSkPiVNAqVIB2yuCkHp0FjygIKtqtwedZfwF3aVjJsVogGD
         7COuqvfwhjQehlZJiDXrtH6LSE1IEssXbUHXQp9iD5oMiYH0wPww92sWXkdgLq9VoyYB
         UBspiqhwMeK6hGU8sg6IQs8GLEprBEpdGfX13iVpwXIOa/MVPbEylGf/UG0WwPEjdn/e
         RgIjVaku+LjpafO1Y3KxITPyGMPi/sfPjj7aJOyoj2lqd74Xf8Pfo+ItXhg3xfl1sw3E
         ZDplOumS5Cb1bKaA4RQbAxZTSb9rENbadPIpIQ4Z4K1u+p5r+UByb8GNQKHfGzx6DyBY
         9HwA==
X-Gm-Message-State: AOAM533CGX9oSQgsXZvWiUEvRsrHLNtNtKHb0Ebo0LAkqIu1o5q3nL49
        EHxQlP4q9MhZGT3uztFrMVktqE1xlG76Yi+/uyhkZlSB7bfQYJjNRhobIxZHgUogGMitLUEVIEl
        4LCXU6i4cm8KhcUWlJkFlVwis
X-Received: by 2002:a05:6402:8:: with SMTP id d8mr15182658edu.368.1618664389798;
        Sat, 17 Apr 2021 05:59:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrZVptaxnk5HQjF08VjV788QyYwVXW9cClbLU20UdnwK7Oy+o3Do4arDm4F4eZhNef8G8c/w==
X-Received: by 2002:a05:6402:8:: with SMTP id d8mr15182646edu.368.1618664389665;
        Sat, 17 Apr 2021 05:59:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o17sm3517851edt.92.2021.04.17.05.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 05:59:49 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <20210413213641.23742-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] kvm/selftests: Fix race condition with dirty_log_test
Message-ID: <f5f5f2c8-6edd-129d-b570-47d8eaca94c0@redhat.com>
Date:   Sat, 17 Apr 2021 14:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210413213641.23742-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/21 23:36, Peter Xu wrote:
> This patch closes this race by allowing the main thread to give the vcpu thread
> chance to do a VMENTER to complete that write operation.  It's done by adding a
> vcpu loop counter (must be defined as volatile as main thread will do read
> loop), then the main thread can guarantee the vcpu got at least another VMENTER
> by making sure the guest_vcpu_loops increases by 2.
> 
> Dirty ring does not need this since dirty_ring_last_page would already help
> avoid this specific race condition.

Just a nit, the comment and commit message should mention KVM_RUN rather 
than vmentry; it's possible to be preempted many times in 
vcpu_enter_guest without making progress, but those wouldn't return to 
userspace and thus would not update guest_vcpu_loops.

Also, volatile is considered harmful even in userspace/test code[1]. 
Technically rather than volatile one should use an atomic load (even a 
relaxed one), but in practice it's okay to use volatile too *for this 
specific use* (READ_ONCE/WRITE_ONCE are volatile reads and writes as 
well).  If the selftests gained 32-bit support, one should not use 
volatile because neither reads or writes to uint64_t variables would be 
guaranteed to be atomic.

Queued, thanks.

Paolo

[1] Documentation/process/volatile-considered-harmful.rst

