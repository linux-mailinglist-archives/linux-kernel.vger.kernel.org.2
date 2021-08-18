Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D723F0CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhHRUty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhHRUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629319752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbzZthqq85Mzm5v2qgNRHWx+Tco9li7Sl4qu+JxfsRo=;
        b=UKri+ZbTWc/5SM0X3DsRzeSE8IbB7hXrbORLAnBX2ErHxDNHxAHJMF7fIMcJl+ABEjbGOi
        XPass+91k97xrb6AtRrPUETRmViCYJ658p2CAHVTmLoVo3hnymdqvE51HCeqcA8xAIooXk
        jWC2WxQBj7pMu/qazeHfnJ4y/LrG2w8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-XzrDU4PvP8CQScLjiASbFA-1; Wed, 18 Aug 2021 16:49:11 -0400
X-MC-Unique: XzrDU4PvP8CQScLjiASbFA-1
Received: by mail-wr1-f70.google.com with SMTP id x18-20020a5d49120000b0290154e9dcf3dbso973527wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AbzZthqq85Mzm5v2qgNRHWx+Tco9li7Sl4qu+JxfsRo=;
        b=iW/6J6qpqFYW6vGGSdeIRBuLLGIuOs5Kt+ATuy9GcprivaxWA7dlX8PvEraOCT9Rr+
         xV+WC032xj/oSU65s/Sa3FSTo3LCywkqEk84cyRo+aglytjIp5n1n/R1TkSDjazkLMPn
         1FuYDAx3+nRhOZAeZAU9sguZ++GBaJ7vu7522OIq/7LgWW2keDdNjAYnX1QjwpjoIpgq
         PCsCtg1qailvFS8VUw1AuGYxrnTWHGZ2mnU8HN7/z9CzfA1OVeJd36ajrDz8CCqvjwd/
         bozwjcGg6Nzj4BGmr9SZEyNR9jtHJsbFRA7UAQTIRk+jCdaGyZKtXD9pBRvjl+QAzC9T
         fPnA==
X-Gm-Message-State: AOAM5304aWZTblSqTRp0W8rcm9emoTlkndpNDI2aR40NK8+G1Jv7lKH+
        GcUR7LZWqTnRAbnDUcUItrkObrLMPGY7N0mLbL6DrNuHmE6mMlyGgmKBaFB7LTSHSsHJDW1eFWq
        aUSpR8FB1Rat9xg6Cnz68aQbk
X-Received: by 2002:adf:c044:: with SMTP id c4mr12427206wrf.275.1629319750163;
        Wed, 18 Aug 2021 13:49:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Eo6oygWl8lAFdXSffqYVMIQaXeGAPcMmU5UMd7P96IRiGy+kHIlBCcOVqKfluWZbcw/kCw==
X-Received: by 2002:adf:c044:: with SMTP id c4mr12427171wrf.275.1629319749865;
        Wed, 18 Aug 2021 13:49:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id i8sm6144247wma.7.2021.08.18.13.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 13:49:09 -0700 (PDT)
Subject: Re: [v2 PATCH 3/4] x86/kvm: Add host side support for virtual suspend
 time injection
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     suleiman@google.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <john.stultz@linaro.org>,
        Sean Christopherson <seanjc@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86@kernel.org, Hikaru Nishida <hikalium@chromium.org>,
        linux-kernel@vger.kernel.org, dme@dme.org, tglx@linutronix.de,
        mlevitsk@redhat.com
References: <20210806100710.2425336-1-hikalium@chromium.org>
 <20210806190607.v2.3.Ib0cb8ecae99f0ccd0e2814b310adba00b9e81d94@changeid>
 <2ec642dd-dde6-bee6-3de3-0fa78d288995@redhat.com>
 <87o89vksiq.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89fa5648-e034-6435-9b21-a6ca0cb22a46@redhat.com>
Date:   Wed, 18 Aug 2021 22:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87o89vksiq.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/21 11:32, Vitaly Kuznetsov wrote:
> On the host side, I'd vote for keeping MSR_KVM_ASYNC_PF_INT for async PF
> mechanism only for two reasons:
> - We may want to use (currently reserved) upper 56 bits of it for new
> asyncPF related features (e.g. flags) and it would be unnatural to add
> them to 'MSR_KVM_HYPERVISOR_CALLBACK_INT'
> - We should probably leave it to the guest if it wants to share 'suspend
> time' notification interrupt with async PF (and if it actually wants to
> get one/another).

I agree that it's fine either way.  That said, more MSRs are more 
complexity and more opportunity for getting things wrong (in either KVM 
or userspace---for example, migration).  There are still 14 free bits in 
MSR_ASYNC_PF_EN (bits 63-52 and 5-4, so it should not be a problem to 
repurpose MSR_ASYNC_PF_INT.

Paolo

> On the guest side, it is perfectly fine to reuse
> HYPERVISOR_CALLBACK_VECTOR for everything.

