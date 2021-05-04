Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D623B373217
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhEDV5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232254AbhEDV5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620165394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35MCkg8lIjxu3w+Nhjw8LO1uMN40Ae2wEaumOo5OJ64=;
        b=NhB6b2xKDfMNlF9NPRrlSQi0uwMhBIXr0/4DgHdxY6CA8oRqiniRc67fnTHlJnT6xhvuEU
        iWTZZkO7kCnVuALZvjc18Am8CE6I6ZnExq++6iccoJaggkjmaCIWcEpTW2pQfU00F2clES
        3Xq7QyoLO0LD4hJxJwdhZIHVvAVietA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-f1n3f6-DO764EIQmqHdAgw-1; Tue, 04 May 2021 17:56:32 -0400
X-MC-Unique: f1n3f6-DO764EIQmqHdAgw-1
Received: by mail-ej1-f69.google.com with SMTP id v1-20020a1709064001b02903a60e5b4521so1426605ejj.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=35MCkg8lIjxu3w+Nhjw8LO1uMN40Ae2wEaumOo5OJ64=;
        b=KRuPQdIzORNr5xkRe+9ub/CvYJ/a60/tJ3Ny87MkrxqeJ5zAyDvpNixI/leCDipBS7
         i22ccNxpw4zEInrfoMOabao9+zm/EN+wp9sglRcW77H05a90OQtzpPwgh1YlKcf5Gue7
         YuticUmv7070lIOxLD7ZPaJd7pzYcylGO88BFbKKHrLdm7rx7tjZTs2vAOsDjvvU08SC
         EyAo/E8LM97neLROkI5Y5rck+S1FNgDS8F06iMSmW3I2p7boaWij6MpdTNwYXkHtkSTx
         IFdcWkPuParlH07RoJVNhg08ksjAp0vE7RFy/iUawgOETBNSgyCnHfQqxy2RquzusxSU
         poQA==
X-Gm-Message-State: AOAM533lOGm+n3q5Uif1MYo1PJRDi/Xt5YhCA2jibrKiJ2eeKQZxYrzr
        3tArrZcDJC+o/jtZoGE5zZeQYFMd3r4nEdZn/53tR72Nmo2VQxGohpU3PQv3u1zCDID5DMpHPZg
        mmuRf4cGT9NZuG9E2/tQIVfpu
X-Received: by 2002:a17:906:85da:: with SMTP id i26mr24666450ejy.287.1620165391690;
        Tue, 04 May 2021 14:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGZJwGOt/aIRwDYPFToyovMvFSaobj/kKF52SOnsxzPRmiVfQO92sEnYoz5nSNupv6Mr46Xw==
X-Received: by 2002:a17:906:85da:: with SMTP id i26mr24666438ejy.287.1620165391527;
        Tue, 04 May 2021 14:56:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id gn36sm1982567ejc.23.2021.05.04.14.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 14:56:30 -0700 (PDT)
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
References: <YJG6ztbGjtuctec4@google.com>
 <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net>
 <625057c7-ea40-4f37-8bea-cddecfe1b855@redhat.com>
 <YJHBxvR2mqsSX0pU@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d7ca301-a0b2-d389-3bc2-feb304c9f5b5@redhat.com>
Date:   Tue, 4 May 2021 23:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJHBxvR2mqsSX0pU@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 23:51, Sean Christopherson wrote:
> On Tue, May 04, 2021, Paolo Bonzini wrote:
>> On 04/05/21 23:23, Andy Lutomirski wrote:
>>>> On May 4, 2021, at 2:21 PM, Sean Christopherson <seanjc@google.com> wrote:
>>>> FWIW, NMIs are masked if the VM-Exit was due to an NMI.
>>
>> Huh, indeed:  "An NMI causes subsequent NMIs to be blocked, but only after
>> the VM exit completes".
>>
>>> Then this whole change is busted, since nothing will unmask NMIs. Revert it?
>> Looks like the easiest way out indeed.
> 
> I've no objection to reverting to intn, but what does reverting versus handling
> NMI on the kernel stack have to do with NMIs being blocked on VM-Exit due to NMI?
> I'm struggling mightily to connect the dots.

Nah, you're right: vmx_do_interrupt_nmi_irqoff will not call the handler 
directly, rather it calls the IDT entrypoint which *will* do an IRET and 
unmask NMIs.  I trusted Andy too much on this one. :)

Thomas's posted patch ("[PATCH] KVM/VMX: Invoke NMI non-IST entry 
instead of IST entry") looks good.

Paolo

