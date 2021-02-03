Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528C030E296
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhBCSd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232145AbhBCSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612377147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7Kj/iu1RRPsN/U0D5eoCVnquVK6zdSdB3X85PNeWrs=;
        b=GET7OWIYoab8XPU5waCWCfoPmTcR2/VBe7r1dtLrGxtE+0YgIVqM4BfRd5M6cVYE9FUMJl
        d5q/ADkFrsexY/+x/NYS2zv0nNKXh0xZA02o7nCz00GehOGCx5yMp1j+uZWewqoIo2KdsU
        WhCvdZKdZNpgGyQQIkNehy6ljYP9+Yo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-inuftIAdOLOH_VxmbdfGRA-1; Wed, 03 Feb 2021 13:32:25 -0500
X-MC-Unique: inuftIAdOLOH_VxmbdfGRA-1
Received: by mail-ej1-f69.google.com with SMTP id q11so281564ejd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y7Kj/iu1RRPsN/U0D5eoCVnquVK6zdSdB3X85PNeWrs=;
        b=pc+4BqpLyKNC5fmYs8rKY4AC5ANmt/9uLggn0lu/JCkzWYe9jMpdRT/sYXwS3Hs3os
         Pb2EFRWPc2k58RHXuxrP+85292xrn7KhekaoOnkKltYOMzOvKlG700dc71POsGUCQM4c
         pJ//3no6DoADHkNgxLdbvNQAXLuLqPY5e84UWC+O1jsCB+F9ClKovf2MyeAxS7tqkYMG
         N5RLJ0EhLpPKl8XDvc/7B9d/VCBpW2Ijwp1eHiauumAxYx6yh28nbZetOP3xN5NfXXTD
         9Tho89R2lUSJt4WkX/9iTGYZ7c7ieKTCU0742soAan0dWVESNuzYy6Jw/ap5xKguHf7N
         eR1A==
X-Gm-Message-State: AOAM532JSb+QqQ2abgn7XKes18WwzI3HA/3UTlmVVSxz6DmGbgPfNbqq
        3YpKOvcEsLmCufculfs8j2hHRi765u9AeVjcGsPdiTQq+UVar3F6iX3bBfeqp94jh91QphbyhUg
        kMivixF164is4V5NnPXzpzHWg
X-Received: by 2002:a05:6402:104e:: with SMTP id e14mr4490707edu.316.1612377143951;
        Wed, 03 Feb 2021 10:32:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3qjXbqSfe3KuRrIZ5u6TMphYJ/AUj+jHjyXPdoqq+cU7Rh9zy30ng/IRgBuDMak1o1YNO0w==
X-Received: by 2002:a05:6402:104e:: with SMTP id e14mr4490684edu.316.1612377143776;
        Wed, 03 Feb 2021 10:32:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r7sm1352098ejo.20.2021.02.03.10.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 10:32:22 -0800 (PST)
Subject: Re: [PATCH v2 24/28] KVM: x86/mmu: Allow zap gfn range to operate
 under the mmu read lock
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-25-bgardon@google.com>
 <813695b1-bcfc-73ea-f9fe-76ffd42044cd@redhat.com>
 <CANgfPd9OTKUJfnuRtMguC7kBf1GZz5Ba0yT1ssX29YQ2Zm54aA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7104de85-0b01-a950-91f9-04fb3d5eb1be@redhat.com>
Date:   Wed, 3 Feb 2021 19:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd9OTKUJfnuRtMguC7kBf1GZz5Ba0yT1ssX29YQ2Zm54aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 19:31, Ben Gardon wrote:
> On Wed, Feb 3, 2021 at 3:26 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 02/02/21 19:57, Ben Gardon wrote:
>>> +#ifdef CONFIG_LOCKDEP
>>> +     if (shared)
>>> +             lockdep_assert_held_read(&kvm->mmu_lock);
>>> +     else
>>> +             lockdep_assert_held_write(&kvm->mmu_lock);
>>> +#endif /* CONFIG_LOCKDEP */
>>
>> Also, there's no need for the #ifdef here.
> 
> I agree, I must have misinterpreted some feedback on a previous commit
> and gone overboard with it.
> 
> 
>> Do we want a helper
>> kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm, bool shared)?
> 
> There are only two places that try to assert both ways as far as I can
> see on a cursory check, but it couldn't hurt.

I think there's a couple more after patches 25/26.  But there's no issue 
in having them in too (and therefore having a more complete picture) 
before figuring out what the locking API could look like.

Paolo

