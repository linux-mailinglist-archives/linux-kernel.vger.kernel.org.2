Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26DA3C21C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhGIJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhGIJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625824145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+D6hL7BjwsO7nJv1l4mm1Wl5x0ozJbYKdRinib4pKM=;
        b=NiUg5WC2eP9ADBW45YvK/Kwhdr9HeHlSOmN/L7ucCfNgOaVhGcThm/zV9E8tgqB9n81PS7
        bgM/bSOrCcUmzuajX8649s40QHaVeW0nXIJrO3TRrIakgeNqX+jzrcgirz+9KlE+4rfTbb
        reVdD2E87oGqmY8D4yQsN1MMhs34afg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-j2Y6nrnzOW-yfEDXCPs5EQ-1; Fri, 09 Jul 2021 05:49:03 -0400
X-MC-Unique: j2Y6nrnzOW-yfEDXCPs5EQ-1
Received: by mail-ej1-f69.google.com with SMTP id j13-20020a1709064b4db02904f6bfa03ec1so2584398ejv.16
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 02:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+D6hL7BjwsO7nJv1l4mm1Wl5x0ozJbYKdRinib4pKM=;
        b=iUapTVGFYv2lP8N2gaTHFbAG6gQgRFgIkNHoszsdcDPVMXFcmNk1Q01UK0uD5EscKG
         DOkev4trO8efjfRapAjQzHJuxf0lg9cQbrO9fGvs86E4IbFjCaUR9hKfLHVFDYr82Nkm
         +u5G9Ty7ixL4OxfddDAoLgT4X5dYvKEnmcJ6yc7by0PzU88tHwyP66HDj95oZeqoDRZ3
         /+orGG4WOfN8+Troz7BznIVVSMwfEGZUrNiDQj7afpJJTRzCS7mjchjOil5StnKfDlUN
         PvdkEArcHOhVyndtOY489EmWuiO84+1dDmCprV1T6I//k1sL20k4fcDFeL5YETl7PYkk
         yl6w==
X-Gm-Message-State: AOAM532Kl4bbVRVGW9oQaLOhnEY2VfyBi3Eqpr3eJz0F6m9nlLK++JC7
        xnd0/3jnmR6DScYY7abdkWXRI2MW1KTROgUNqOHHivT4ub4w+d+56N+GDo1q8cjwkxIZ0DDSoeA
        4cXO5DrGILB8j4jqCSzHsGRMG
X-Received: by 2002:a17:906:2dc9:: with SMTP id h9mr15124216eji.345.1625824142460;
        Fri, 09 Jul 2021 02:49:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMcoC8cVvcnlK0RHTXW2IGSwfoURzhJYFm4mvBzybLVkAzWqqjCuLOjxrWtnFKgsIJ95FmAg==
X-Received: by 2002:a17:906:2dc9:: with SMTP id h9mr15124188eji.345.1625824142287;
        Fri, 09 Jul 2021 02:49:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n13sm2111880ejk.97.2021.07.09.02.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 02:49:01 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Also reload the debug registers before
 kvm_x86->run() when the host is using them
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
References: <20210628172632.81029-1-jiangshanlai@gmail.com>
 <46e0aaf1-b7cd-288f-e4be-ac59aa04908f@redhat.com>
 <c79d0167-7034-ebe2-97b7-58354d81323d@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <397a448e-ffa7-3bea-af86-e92fbb273a07@redhat.com>
Date:   Fri, 9 Jul 2021 11:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c79d0167-7034-ebe2-97b7-58354d81323d@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/21 05:09, Lai Jiangshan wrote:
> I just noticed that emulation.c fails to emulate with DBn.
> Is there any problem around it?

Just what you said, it's not easy and the needs are limited.  I 
implemented kvm_vcpu_check_breakpoint because I was interested in using 
hardware breakpoints from gdb, even with unrestricted_guest=0 and 
invalid guest state, but that's it.

Paolo

> For code breakpoint, if the instruction didn't cause vm-exit,
> (for example, the 2nd instruction when kvm emulates instructions
> back to back) emulation.c fails to emulate with DBn.
> 
> For code breakpoint, if the instruction just caused vm-exit.
> It is difficult to analyze this case due to the complex priorities
> between vectored events and fault-like vm-exit.
> Anyway, if it is an instruction that vm-exit has priority over #DB,
> emulation.c fails to emulate with DBn.
> 
> For data breakpoint, a #DB must be delivered to guest or to VMM (when
> guest-debug) after the instruction. But emulation.c doesn't do so.
> 
> And the existence of both of effective DBn (guest debug) and guest DBn
> complicates the problem when we try to emulate them.

