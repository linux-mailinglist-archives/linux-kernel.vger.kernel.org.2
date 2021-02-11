Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D2318BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBKNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:22:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231574AbhBKNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613048381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybZn3d2XBDvNjlVg1AnQGIRBw4qlOB9GZH4ToCSQri8=;
        b=GBBry7JBPsiEPDCbJgaWbhwRhW3zypC6RQjxOuFTCJKpt+9rqXyrZF00KS/d9Mzdp8Fscs
        Pib/4eg/lJGSfiAaNd2BbQ4PofLvmOe8bhqcPwrkMPvLBzxHahCzyzg9LmXrGMAc/Iq0o9
        BcsbOWPt5UjOGWfqiC8BGOWMT8qhwK4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-qfEp10rMNYeDSA8nLoYw9A-1; Thu, 11 Feb 2021 07:59:38 -0500
X-MC-Unique: qfEp10rMNYeDSA8nLoYw9A-1
Received: by mail-wm1-f69.google.com with SMTP id m25so3190146wmi.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ybZn3d2XBDvNjlVg1AnQGIRBw4qlOB9GZH4ToCSQri8=;
        b=o1aMLL5nn9HePwaGTFpHMUwNCrHLq2wABLZ9pClb++kFW+z96wFm49Bz/kG794kE9S
         4CmyyvuikUSm9nkvPSXApsAS7sHyrybDrVrqQzUG0pEBLo2X6YfY5OOMygOBZ1/1Br8A
         l6jMZqI7ulQogu7MOR8VxXIymdMfUMaNtfdG3wHN39RPWprSgfO9pad4gc8vVd/FZOcF
         VU/FGTiym1M5wkO1aZslrr1h1PNZEGozx1QKQzKvq5W30I4B93iR8amwWD38e+wTpRe/
         LGXj3OrlHKZd4338Jj/QiwgRXPi6gkqJKG+VgR1RXP/L54h+d6dm8Q2otKrXlKiW3zUE
         ldmw==
X-Gm-Message-State: AOAM530eH5IoGD5gRRJW1UKAU4GkY92p2EyORm0f30mgBRSH7L4gh7OE
        fgEqQ9rt+BfYSYOx6W3/icUMnT2SSuh++aPSBl+uAyuiS+NP8Jn0SyOD6F9LZgBpfXGonBJ+h5/
        8I5o5hmkI99ETNEI7irTMjOY0
X-Received: by 2002:a05:600c:41d6:: with SMTP id t22mr5036029wmh.74.1613048377113;
        Thu, 11 Feb 2021 04:59:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKG7eAG0XcSg/s0zlm8I9ljQMxpTxeeBtUPQ69+MFBYk/CquAaX/PsHupPB3w0WTmXY93dLg==
X-Received: by 2002:a05:600c:41d6:: with SMTP id t22mr5036012wmh.74.1613048376950;
        Thu, 11 Feb 2021 04:59:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f14sm9790395wmc.32.2021.02.11.04.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 04:59:36 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] locking/arch: Move qrwlock.h include after qspinlock.h
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ben Gardon <bgardon@google.com>
References: <20210210144556.10932-1-longman@redhat.com>
 <20210210161942.GA5683@alpha.franken.de>
Message-ID: <64241753-49cb-a49d-63e3-e2ef5820836d@redhat.com>
Date:   Thu, 11 Feb 2021 13:59:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210210161942.GA5683@alpha.franken.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/21 17:19, Thomas Bogendoerfer wrote:
>>   arch/arm64/include/asm/spinlock.h  | 2 +-
>>   arch/mips/include/asm/spinlock.h   | 2 +-
>>   arch/xtensa/include/asm/spinlock.h | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> which tree should this go through ? I can take it via mips-next,
> if everybody agrees.

The breakage is in the KVM tree, and the existing patch has acked-by 
from the locking primitives folks.  So I'll queue it there in order to 
limit the range that breaks bisection.

Paolo

