Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB74325487
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhBYR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229954AbhBYR1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614273934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfoUi7t51pK9HFWZ/xdYLsyI55sdKOp8q9jAOwWLQwo=;
        b=RHGx93u1Bgwh3qcccinubrWkicf22CJMnnjjIKDaXhyZ5Ual17109DPg7BIfWGpbKhDr1u
        9lHPIwQ6ZUSZSmwFg4xqWAUHJ0XRnYwHCtKO5NGInYN5NfGjv3TdKMkLJZr1jc0EKTRYzO
        vn6BW0qPaS4ugkOWHn2m915cBAHts1Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-ZdsUnf59OZi4ERupuyHxvA-1; Thu, 25 Feb 2021 12:25:32 -0500
X-MC-Unique: ZdsUnf59OZi4ERupuyHxvA-1
Received: by mail-wm1-f72.google.com with SMTP id b62so2414723wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HfoUi7t51pK9HFWZ/xdYLsyI55sdKOp8q9jAOwWLQwo=;
        b=m/rge0UQgCoH+eu3PDlhvyKKIoJjrU3tTTe0+4p/lzDzZ/yKWg8BIFklGAbfyOxDGE
         Ucsx5g2S9HuaH9ucmEw/AZ1HFeu/B4fgfA/BtWsQ/BHTR84AR0iij1xvf8GiT/QQy7uz
         9685001k4nZWDth8u8S8uX0gGcj7nONKlgi0PsLyFiqw3Rzs+OFZj6MXPnlIDMrXE/7n
         FNUWxy8k0pkRin4YoyyGf6/Blx90YvRYicmx7jxMxMb0pLosg+V9nbYr5EzNFIlUSebk
         ec9f9fQlXOQQP8bEy2b7KrD6m7F6TSkEYZDjt+h9+okv5oI1Se382ayN5uLfkaT+tLPu
         /+0g==
X-Gm-Message-State: AOAM5308UsOh1IOrfy5xxCYbra03i/uRByqIg490/90MPjjgGTT72l7e
        MILuqqzDm3laXUSJiMf0qa71Nr27xkSFqRkiB265liakMUbaTbHu6tvg6i49crOABZ0u0nS+iP0
        gboQyPgJEOz7QASg0PlcTNSxW
X-Received: by 2002:a05:6000:147:: with SMTP id r7mr167725wrx.25.1614273931393;
        Thu, 25 Feb 2021 09:25:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbfmESRDLsOdKw2Ki82Wnortooc+0ErseNRuOyNHMY/5XmlryNDpbMxT0CKCU8m51J9e/NPA==
X-Received: by 2002:a05:6000:147:: with SMTP id r7mr167711wrx.25.1614273931231;
        Thu, 25 Feb 2021 09:25:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z2sm8527384wml.30.2021.02.25.09.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 09:25:30 -0800 (PST)
Subject: Re: [PATCH 3/4] KVM: x86: pending exception must be be injected even
 with an injected event
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210225154135.405125-1-mlevitsk@redhat.com>
 <20210225154135.405125-4-mlevitsk@redhat.com>
 <358e284b-957a-388b-9729-9ee82b4fd8e3@redhat.com>
 <ac4e47fbfb7f884b87fd084fe4bc3c7e3db79666.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7efef706-3332-4894-350b-ed05c489fe20@redhat.com>
Date:   Thu, 25 Feb 2021 18:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <ac4e47fbfb7f884b87fd084fe4bc3c7e3db79666.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/21 17:06, Maxim Levitsky wrote:
> On Thu, 2021-02-25 at 17:05 +0100, Paolo Bonzini wrote:
>> On 25/02/21 16:41, Maxim Levitsky wrote:
>>> Injected events should not block a pending exception, but rather,
>>> should either be lost or be delivered to the nested hypervisor as part of
>>> exitintinfo/IDT_VECTORING_INFO
>>> (if nested hypervisor intercepts the pending exception)
>>>
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>
>> Does this already fix some of your new test cases?
> 
> Yes, this fixes the 'interrupted' interrupt delivery test,
> while patch fixes th 'interrupted' exception delivery.
> Both interrupted by an exception.

Could you post the tests, marking them as XFAIL if possible?

Thanks,

Paolo

