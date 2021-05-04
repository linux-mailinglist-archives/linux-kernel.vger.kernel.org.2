Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A937267D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEDHWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229839AbhEDHWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620112913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzxyYk+E3TZaXdPs/5yJWZXWsj4+CrfW8cvS2xik3SI=;
        b=VQHK+S/6d7M5ISInqK2bpSZ2n+yxtGJMEkC8uE74ihMhfKCZKutgWJ5LiR3hOEvU9kwf6g
        kUNH8nrCo7TpiPHQczvJuCGG2gj/7V4eOUzhacnoDR9B3Fysp7nnlHh0ef2RHllGjgkmBd
        FqwZL6SPP8g68CLA+e0yKeZ4EczIPi8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-iWX3ajGTPMmX6wT55syhQw-1; Tue, 04 May 2021 03:21:51 -0400
X-MC-Unique: iWX3ajGTPMmX6wT55syhQw-1
Received: by mail-ej1-f72.google.com with SMTP id w2-20020a1709062f82b0290378745f26d5so2762572eji.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 00:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mzxyYk+E3TZaXdPs/5yJWZXWsj4+CrfW8cvS2xik3SI=;
        b=GuNBBHumw3L3CUZPal8roHjmFDTkkhr+05soYukGXtF4uuQB+/mEtJr4G06bCng2WM
         TmNgqSyHVzel695MmAVOgljjv1hyB+UBDZAbgROvtJe7YB+cADtsBsvs5M9KkDDjO6so
         S41FVVSew59rTTga2Q676FkXC+HES/ah36eL8aDHx3p8HJJM50oveSjBZED/Bi8QjinC
         Qiiqmo1A63IC+2RHI4LzivyvxiPyYF7SRSGzQwfBQGYz0KIGEutr9fHGs/XxTx5T5EHT
         gD6Ip5iaOis51hDKPE0OCA3cPvmUaAHaq0nOQTy96yMIpdNpWrG2ygcOBphJwnBodP0Z
         cAjQ==
X-Gm-Message-State: AOAM530tG5lm5LDFvXqn4kRHLSDQHhrnm4f9vLWtAr4T2G83+6DKoQ+i
        VCPZglQ/d9+v+0o1Uu/ZhvDBn95tgDe/GKyT/svnjCV3i3OvrNlmAUPvvuuEqvo6rSaSqObJuPQ
        +OXgR7KlS1ZhPEJO6xA1B8Ez6
X-Received: by 2002:a17:906:14c1:: with SMTP id y1mr21141614ejc.481.1620112910355;
        Tue, 04 May 2021 00:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRsBX3qH22ZDe7HFwQAGaSzb/h/VEshNKyP0gOzeupSDWjVGD20Y0KicFMLZe3yIEPXZZmug==
X-Received: by 2002:a17:906:14c1:: with SMTP id y1mr21141601ejc.481.1620112910215;
        Tue, 04 May 2021 00:21:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dj17sm10446123edb.7.2021.05.04.00.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 00:21:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Lazily allocate memslot rmaps
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210429211833.3361994-1-bgardon@google.com>
 <a3279647-fb30-4033-2a9d-75d473bd8f8e@redhat.com>
 <CANgfPd-fD33hJkQP_MVb2a4CadKQbkpwwtP9r5rMrC_Mripeqg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d27e9d6-42db-3aa1-053a-552e1643f46d@redhat.com>
Date:   Tue, 4 May 2021 09:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd-fD33hJkQP_MVb2a4CadKQbkpwwtP9r5rMrC_Mripeqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 19:31, Ben Gardon wrote:
> On Mon, May 3, 2021 at 6:45 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 29/04/21 23:18, Ben Gardon wrote:
>>> This series enables KVM to save memory when using the TDP MMU by waiting
>>> to allocate memslot rmaps until they are needed. To do this, KVM tracks
>>> whether or not a shadow root has been allocated. In order to get away
>>> with not allocating the rmaps, KVM must also be sure to skip operations
>>> which iterate over the rmaps. If the TDP MMU is in use and we have not
>>> allocated a shadow root, these operations would essentially be op-ops
>>> anyway. Skipping the rmap operations has a secondary benefit of avoiding
>>> acquiring the MMU lock in write mode in many cases, substantially
>>> reducing MMU lock contention.
>>>
>>> This series was tested on an Intel Skylake machine. With the TDP MMU off
>>> and on, this introduced no new failures on kvm-unit-tests or KVM selftests.
>>
>> Thanks, I only reported some technicalities in the ordering of loads
>> (which matter since the loads happen with SRCU protection only).  Apart
>> from this, this looks fine!
> 
> Awesome to hear, thank you for the reviews. Should I send a v3
> addressing those comments, or did you already make those changes when
> applying to your tree?

No, I didn't (I wanted some oversight, and this is 5.14 stuff anyway).

Paolo

