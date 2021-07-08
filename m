Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7743BF766
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhGHJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231190AbhGHJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625735918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHU1Vmvm7F12r1PAslF5dEr4adP4DAjY+fw1RfKa6y0=;
        b=aaMDZFVgPUQpwaABvphhaAiKYlyPd6jGTMxe3GUaitzMTkLMrPU41AfKZ3y7Mo/orC9DDQ
        Ttp89+jnetxloE6i0X0c8RwqyT34fmSg9/YLHquLCgEBvskUw1QYRtKzuZZQ9XAtDYpLwV
        Kl7gvDvFUQ4ZuJ5zozHi/P0DTd4UXWg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-cZLgfcrvPAS2z4j59fRWag-1; Thu, 08 Jul 2021 05:18:37 -0400
X-MC-Unique: cZLgfcrvPAS2z4j59fRWag-1
Received: by mail-ej1-f71.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so1547653ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 02:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHU1Vmvm7F12r1PAslF5dEr4adP4DAjY+fw1RfKa6y0=;
        b=PhyvEkNi35o5CEVPVwhNvGWTqadkrBgYiYF3IBkfEGGmHsxz0nrlSrvqMpxySzMFq7
         ow7xQr0majL6SNSu3VFY8zhqGmMKUBfLKlZzv9X0/FyxqdA69RktgX4jy5ytHoTuGVZg
         DWgt3FrLXZsvb0WyHf7Jqa1AFQUX5teGQpQYy9rlqmgI7Mv/0ZQruqw06iYcdAB0Hl6u
         i3CUCIa3VLt0QAxLXALMtP07VjT/3EQB9vAjO/dzSxBLnil69UzWSsWJvqzK34ef+JTc
         3tCKTC48s0uMj8cHSEJJOHTXCfq3oOtxSx2e7UJ2CogGmy+SpQgqP13l4cjLF79M9/s0
         KzMQ==
X-Gm-Message-State: AOAM532RQb5HCZFBVdWcgckopTqhq7bBW/EmUdZkumd++gsLPlgqsJNP
        x/3B6EZXJvX57HD6/DbZ7h0f8chNYKkIOt0yLta/GNKfPzQdR2vj3jK4sYFjsJiFOdw8W7anJiB
        XKhB5F0B6PoIKhjkyVUxaSKNZC7GzlIEpwHx8ArjG/KP34rn5VWAgqEPod2SPGH6EC/rLb3JUeM
        oK
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr9138394eji.501.1625735915619;
        Thu, 08 Jul 2021 02:18:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxifn4rGSLVNiWgp2jP6bilACMyMlJDH3BLCSzTzOMJEiHwS01lRdGsL3R/9D4VvMBOp99ILA==
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr9138354eji.501.1625735915367;
        Thu, 08 Jul 2021 02:18:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q24sm940031edc.82.2021.07.08.02.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 02:18:34 -0700 (PDT)
Subject: Re: [PATCH V2] x86/kvmclock: Stop kvmclocks for hibernate restore
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lenny Szubowicz <lszubowi@redhat.com>, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210326024143.279941-1-lszubowi@redhat.com>
 <YOawSzWrNtUIlSuE@8bytes.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee8c4344-b6b2-07b4-bb5c-48f6462f0931@redhat.com>
Date:   Thu, 8 Jul 2021 11:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOawSzWrNtUIlSuE@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/21 09:59, Joerg Roedel wrote:
> Hi Paolo,
> 
> On Thu, Mar 25, 2021 at 10:41:43PM -0400, Lenny Szubowicz wrote:
>> Reported-by: Xiaoyi Chen <cxiaoyi@amazon.com>
>> Tested-by: Mohamed Aboubakr <mabouba@amazon.com>
>> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
>> ---
>>   arch/x86/kernel/kvmclock.c | 40 ++++++++++++++++++++++++++++++++++----
>>   1 file changed, 36 insertions(+), 4 deletions(-)
> 
> What is the status of this patch? Are there any objections?

It was replaced by these:

0a269a008f83 x86/kvm: Fix pr_info() for async PF setup/teardown
8b79feffeca2 x86/kvm: Teardown PV features on boot CPU as well
c02027b5742b x86/kvm: Disable kvmclock on all CPUs on shutdown
3d6b84132d2a x86/kvm: Disable all PV features on crash
384fc672f528 x86/kvm: Unify kvm_pv_guest_cpu_reboot() with kvm_guest_cpu_offline()

Thanks,

Paolo

