Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6C434913
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhJTKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229864AbhJTKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634726258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yrUw21h+zQ2wXbMw73pU6qHpDvhPbFCoQi4iYgtHLM=;
        b=anKef6g46t2Vl5EU6d+mR8ma3AZQHiWAGAfvmpT13bE0dRDkByleNSMlWeve7OTDS/Kh4g
        /akgzy7dbefDEwJLiq2vxLBPW5uStymFnIN+/g8A1OdECxrNwB8dT4DVPStuo7PSVjXMtx
        264f8WixVRbVCLcBAJDQGYz0CpVzWtc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-bMAMkTsHN3CNVwUKl3-rug-1; Wed, 20 Oct 2021 06:37:36 -0400
X-MC-Unique: bMAMkTsHN3CNVwUKl3-rug-1
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso2871140edj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 03:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4yrUw21h+zQ2wXbMw73pU6qHpDvhPbFCoQi4iYgtHLM=;
        b=5FuLujhG40GWluvQIFBV11pUPuJ8FXqGZAhDr2NRg1wwytkxh7zfLtLL2sOs0IxcNk
         RJN4rM2ddsF3KVN0TdId6kRQwSwX49KiwXuf/ykH/yGz2TRcwHdu5UOh1F5RH4J/zay5
         bB/Fc0e21nkQj2+nJlx+VBBSatkvng3DHfEAzsaNBYLFtbSolBydvoTbmaeN4FoC1KZD
         pWv2KbHu4ILlJF674kWo/I6kBGAwsjSDqoxZIwlAV7Q8KRsQbZ0Ga8j7ac1cRVK3ijrQ
         p1e2fntxq5QyIjiZoB/IFCevgGrFRJjbjMp3fY6Wo1WxzY9SSOb2kMfxJ086gyN1UZEA
         2rpw==
X-Gm-Message-State: AOAM530kiJhPeNWhiD5R2eh52L8QkKh1SDDQh/3oId8d4TNSzCWGwIzO
        ilZ9rjHBXwKbLlUkP233kiUbLnTYwjHMb3bKtyZgbugs+8H2TS6+/+bhME2HLsoGZT2YMtysgtD
        xzbuTgIckcysgxXmaMHOxE3SZ
X-Received: by 2002:a17:907:7fa8:: with SMTP id qk40mr43860947ejc.445.1634726255672;
        Wed, 20 Oct 2021 03:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMWzsiJlUJ6VMXTDtVVr8gloUIzhLnBOqnnnGEXhwBkD3QwRLZPFhQxW/DrRYmOHfEnPhoVw==
X-Received: by 2002:a17:907:7fa8:: with SMTP id qk40mr43860927ejc.445.1634726255459;
        Wed, 20 Oct 2021 03:37:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e7sm1053267edk.3.2021.10.20.03.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 03:37:34 -0700 (PDT)
Message-ID: <e0f336e9-d167-18a8-0af8-0d5517bae9a5@redhat.com>
Date:   Wed, 20 Oct 2021 12:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 3/3] KVM: vCPU kick tax cut for running vCPU
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1634631160-67276-1-git-send-email-wanpengli@tencent.com>
 <1634631160-67276-3-git-send-email-wanpengli@tencent.com>
 <24e67e43-c50c-7e0f-305a-c7f6129f8d70@redhat.com>
 <YW8BmRJHVvFscWTo@google.com>
 <CANRm+CzuWnO8FZPTvvOtpxqc5h786o7THyebOFpVAp3BF1xQiw@mail.gmail.com>
 <45fabf5a-96b5-49dc-0cba-55714ae3a4b5@redhat.com>
 <CANRm+CyPznw0O2qwnhhc=YEq+zSD3C7dqqG8-8XE6sLdhL7aXQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CANRm+CyPznw0O2qwnhhc=YEq+zSD3C7dqqG8-8XE6sLdhL7aXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/21 12:02, Wanpeng Li wrote:
>> +#ifdef CONFIG_PREEMPT_RCU
>> +       /* The cost of rcu_read_lock() is nontrivial for preemptable RCU.  */
>> +       if (!rcuwait_active(w))
>> +               return ret;
>> +#endif
>> +
>> +       rcu_read_lock();
>> +
>>          task = rcu_dereference(w->task);
>>          if (task)
>>                  ret = wake_up_process(task);
>>
>> (If you don't, rcu_read_lock is essentially preempt_disable() and it
>> should not have a large overhead).  You still need the memory barrier
>> though, in order to avoid missed wakeups; shameless plug for my
>> article athttps://lwn.net/Articles/847481/.
> You are right, the cost of rcu_read_lock() for preemptable RCU
> introduces too much overhead, do you want to send a separate patch?

Yes, I'll take care of this.  Thanks!

Paolo

