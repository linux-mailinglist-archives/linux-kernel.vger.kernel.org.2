Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6EC392CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhE0LlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232402AbhE0Lk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622115566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kbsRy4yX2mhml7m2s3ORItDTZlRjZ7de6F2VDSxKrsQ=;
        b=A+bvOQS+z34PSaHMqvuODMtiOzRuzlVZZ6VggyaFriXmDwyNE4zM/EMjpBIFFSQAVQ7k5K
        TfuVQ5VMvyZ/3/xbnOOCvRKFodOpj16SI4fqxikP5YyFUIwrp/hJA9wPfY4P83KK3jVXkF
        OD7fpU1cZtjE5qMKaj8v7x5MFrvCu3s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-0y6LfvPRMV650bQMo8B8pw-1; Thu, 27 May 2021 07:39:25 -0400
X-MC-Unique: 0y6LfvPRMV650bQMo8B8pw-1
Received: by mail-ed1-f69.google.com with SMTP id b8-20020a05640202c8b029038f1782a77eso157035edx.15
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kbsRy4yX2mhml7m2s3ORItDTZlRjZ7de6F2VDSxKrsQ=;
        b=jcrrGj7ytqh2ohu5g/J5HX33WaRKxl2vcQYCjIuRmUmwYfXtoU8iPe2uJNdlt924e5
         hMUEoeD7HXgrY3fYDpA3rKBftkiLsWWy40ZQyYgigiXr7a4KpPi8nMD7w2Ozihwme84r
         eLu80YAmmQdGBvB8qLUdML38hSMeCjcS8YLkGvLAym7UaOixrkw06Lz7oRK0njGWCglV
         Vj9p03lYPHPH9cuzO82cAaVZ96dzHCiv9nOKhCATFI9QfXqZdgVYEfv7W0evqISQGFli
         oige0xsGybUI4xDrNtf4MvMJTD9xA9Iimxo+FQj8erAOTcnyDVY8mYWgNt3r51mHy+ze
         oZkQ==
X-Gm-Message-State: AOAM530OCetTWzujT/HVNiFjEmcUFLIbAub9Ssu+neJgq0Xhty6BCMQo
        m7PTS74wrwV6WVEYXS7fCYshTzKgbHxjklE7J2aQ1VReZJgzb6U18o9g1ACXYGQalgmkE0Xm1KL
        yCOR2/QQSGAOoV56vDfG7+TpLjc2b2xbj1TT5YMxDK6SaB0HJMaFifh2Cffur8YZ6KZcmNbEamG
        Ok
X-Received: by 2002:a17:906:55d6:: with SMTP id z22mr3341129ejp.355.1622115563575;
        Thu, 27 May 2021 04:39:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy86WpCiOdqBh4wme4cy+CcSZS1+N308jva+E+wDM/0gIAiIta5QAfU0Z9aRAUYKb33Guf0RQ==
X-Received: by 2002:a17:906:55d6:: with SMTP id z22mr3341108ejp.355.1622115563367;
        Thu, 27 May 2021 04:39:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ho32sm832997ejc.82.2021.05.27.04.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 04:39:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] KVM: x86: Use common 'enable_apicv' variable for
 both APICv and AVIC
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-4-vkuznets@redhat.com>
 <1b9a654596f755ee5ef42ce11136ed2bbb3995a0.camel@redhat.com>
 <YK5kQcTh8LmE0+8I@google.com>
 <8e2570c580baf6d4d650ebc28b98a5ed76cb4f9b.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d8b607b-f280-fd3e-c147-94111468d5a1@redhat.com>
Date:   Thu, 27 May 2021 13:39:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8e2570c580baf6d4d650ebc28b98a5ed76cb4f9b.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/21 17:52, Maxim Levitsky wrote:
>> I don't love the intermediate "avic" either, but there isn't a good alternative.
>> Forcing VMX to also use an intermediate doesn't make much sense, we'd be penalizing
>> ourselves in the form of unnecessary complexity just because AVIC needs to be
>> disabled by default for reasons KVM can't fix.
> This is also something we should eventually reconsider.
> These days, the AVIC works quite well and disables itself when needed.
> When do you think it will be the time to enable it by default?

We can probably enable it, but most guests won't use it because of x2apic.

Paolo

