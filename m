Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD83731C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhEDVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231445AbhEDVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620162738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHwgXcHWRd2lENvo0dCzHiD06sLJ4ursFftDNpNdpkQ=;
        b=M1JuK8kVwSSktIaxyVp9rD20T8EYScyUWaS+l53DbD4gk+mLtBu97DmXeDSaaeSWT0Ae9T
        AM1FBJgRFzie8RAl9b1P61DmyosPIFZDVziv4YgSfdpdCynOLFdvS6uv1h74I7500hYj7u
        OA3dONAkLx4mbCQzsV8P0q1NySjtAtY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-r3T5d7GdMJCQ1q__TlzYkA-1; Tue, 04 May 2021 17:12:16 -0400
X-MC-Unique: r3T5d7GdMJCQ1q__TlzYkA-1
Received: by mail-ed1-f69.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so7036695edu.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHwgXcHWRd2lENvo0dCzHiD06sLJ4ursFftDNpNdpkQ=;
        b=ZGpf1vwuF7YtvdpHO6Ar3EV/1YJaTeizCrexE7P4jDHz8tq8uVLgQbMupewu/njhxW
         ggrrq1oa6fxlIe5bflexRWPVqMMtCShmBcoFxsm4K0qkXaaD7RnXQnzGXxp4D2tja0M1
         4Jb8LH7mxV5/JYHwZpSdnenaRPhPNItyxO9ATIYDHeATJqwESOl3ZaEo7o5qv55JBZes
         YMEzLJyE5pJTmKioSlEbxCetOULjvpmPryT7f0JoSXi1p6SURyHTfTm9r+GW0TjzEvpf
         g55mx6KG5KMBy9xUAClSUeMeRzW5bDav8ur7cmm+WwjO8/MGRoKwAdeukaS69TlglwZM
         kXpg==
X-Gm-Message-State: AOAM532TJv6clVo4erxekyrzP94htD2zXSPlJHnP9/htLLgkFBxBr0tZ
        tk/0Vk6x64py0qhBPxqY49e/FUczOh2UTk0QbcdOowB0DxEcxoYwh6bi+/cj/wcwfYpbqp2hqIh
        HYHM5cpGhBIlsoge3+yvekuws
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr24227537ejc.326.1620162735041;
        Tue, 04 May 2021 14:12:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN43pVZO3WyEeeiixfya/5iDDr+u1HArUlWDk0CDNnHhhbYUDaZqN+N4AJMYYUnVz+LQJk9g==
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr24227513ejc.326.1620162734829;
        Tue, 04 May 2021 14:12:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id pw11sm1943513ejb.88.2021.05.04.14.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 14:12:14 -0700 (PDT)
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
References: <20210426230949.3561-1-jiangshanlai@gmail.com>
 <20210426230949.3561-3-jiangshanlai@gmail.com>
 <87bl9rk23k.ffs@nanos.tec.linutronix.de>
 <878s4vk1l9.ffs@nanos.tec.linutronix.de>
 <875yzzjxth.ffs@nanos.tec.linutronix.de>
 <87wnseis8v.ffs@nanos.tec.linutronix.de>
 <87r1imi8i1.ffs@nanos.tec.linutronix.de>
 <44e20d7cdbf0ffdb7d9dce7d480f86a6f14d16c1.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae801539-592a-af9a-55a1-3a4b8309ff1e@redhat.com>
Date:   Tue, 4 May 2021 23:12:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <44e20d7cdbf0ffdb7d9dce7d480f86a6f14d16c1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 23:05, Maxim Levitsky wrote:
> Does this mean that we still rely on hardware NMI masking to be activated?

No, the NMI code already handles reentrancy at both the assembly and C 
levels.

> Or in other words, that is we still can't have an IRET between VM exit and
> the entry to the NMI handler?

No, because NMIs are not masked on VM exit.  This in fact makes things 
potentially messy; unlike with AMD's CLGI/STGI, only MSRs and other 
things that Intel thought can be restored atomically with the VM exit.

Paolo

