Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66083186BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBKJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:15:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhBKJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613034287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUh3btrpAi+FUHWUWD/UqAB9fZT3iRfs3I41QKzDr1I=;
        b=A/PKF8Agm4YzXpKR0YTgdh3WqBPSdWpyfLVa8OcGTlaRAUHrnujgH9/bwL8uuEa7zdyfMD
        nMlRhAT+uP5wQ+NMH8PUSba7Iae/dWMbs+jFvhExJb2JA7D863sGS/Jh4mkr9ZUwFDZ1v9
        fegytXm82eq+GWIVM+kVW91ysb2YhOc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-cG43RO2nNcuEU81vkAwCTQ-1; Thu, 11 Feb 2021 04:04:45 -0500
X-MC-Unique: cG43RO2nNcuEU81vkAwCTQ-1
Received: by mail-wm1-f71.google.com with SMTP id y18so2886459wma.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:04:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUh3btrpAi+FUHWUWD/UqAB9fZT3iRfs3I41QKzDr1I=;
        b=Qo0atZC/vSp7QDSj7os1Q5OfTmv/mpW2ZNgwgOPS6SdZeaJsGranJSDls3lewiMXcu
         WZNl3IBpD29Fvxljdbkb3HwDHKhvpqYyF4Nyk+Kh7fmmSBmS4fHmFzC9ju9b6XZ0KtzW
         4A0He4/YE+6VwC3Tk+vQds6DPb2lL/7r9WRCNYSwafJVoWHaSLk4Q5/kUP/pvYCRJvF9
         tON0pB+a8Df55oJAGtJhLu8zA5HjndR37lYHbBckAW+gQ0fMS1xQpgnVkwRBBWVhi4Mk
         8fPLJT1+GzAV7oqtBv3uGPRny4dRYBTJFQ/jN1OlDZaIatu8W7dmkEsOBavetocPieV9
         WYSw==
X-Gm-Message-State: AOAM53213NpuYzy70QJFljyt+7MzcDHothFoQXTK9PJZ3o9gBIAYmY/c
        mdWXZsLsnN+lkZHzd1tuWz+PPHyb96Ty8Dmkcent28oWgqR0jDaxPPfpSQR+HtD0LOFSIC2hbCf
        EbRuX2hI5sFM1G2Pf4v7ZDNPJ
X-Received: by 2002:a7b:c215:: with SMTP id x21mr4271349wmi.61.1613034284614;
        Thu, 11 Feb 2021 01:04:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4jVrYnD5gqRlpBFHbY3hwKi/T7kAxI5a04+w+9jI6nET5iaHm1TFgae9EvUpDBGz4t2Ft7A==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr4271326wmi.61.1613034284409;
        Thu, 11 Feb 2021 01:04:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n66sm9487437wmn.25.2021.02.11.01.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 01:04:43 -0800 (PST)
Subject: Re: [RESEND PATCH ] KVM: VMX: Enable/disable PML when dirty logging
 gets enabled/disabled
To:     Sean Christopherson <seanjc@google.com>,
        Makarand Sonare <makarandsonare@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pshier@google.com, jmattson@google.com,
        Ben Gardon <bgardon@google.com>
References: <20210210212308.2219465-1-makarandsonare@google.com>
 <YCSAh31LP4QwBfHZ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6dbe1e3-eaa9-f171-ce5f-6a00b21f1c9a@redhat.com>
Date:   Thu, 11 Feb 2021 10:04:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCSAh31LP4QwBfHZ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/21 01:55, Sean Christopherson wrote:
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index ee4ac2618ec59..c6e5b026bbfe8 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -307,6 +307,7 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
>>   {
>>   	return kvm_make_all_cpus_request_except(kvm, req, NULL);
>>   }
>> +EXPORT_SYMBOL_GPL(kvm_make_all_cpus_request);
> If we move enable_pml into x86.c then this export and several of the kvm_x86_ops
> go away.  I know this because I have a series I was about to send that does that,
> among several other things.  I suspect that kvm->arch.pml_enabled could also go
> away, but that's just a guess.

I don't like the idea of moving enable_pml into x86.c, but I'm ready to 
be convinced otherwise.  In any case, for sure you can _check_ 
enable_pml from x86.c via kvm_x86_ops.flush_log_dirty or 
kvm_x86_ops.cpu_dirty_log_size.

Paolo

