Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC130DC9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhBCOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:23:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhBCOXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612362106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Gz45RAaG0RN/DlSdY8vAkKkFby4wOMzLVK7KgBbu6E=;
        b=AvdLrWUxSyriJn+UkyLUEyLEy7SKOYR2luKzE5kRVpnzLADksfksSqFdj2l3u9Et1DOYXo
        zVn+JyO+Gq0FI/VTEqaoWJ7HJlD0+dQPatQCzb5XQKXuxmtJZ1J6MGRSh2qDYPPD6o280/
        WUY/96sHTevp505glyVADDm03Rs/Umc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-za86oDrHNWa1PEe7gSLGFw-1; Wed, 03 Feb 2021 09:21:44 -0500
X-MC-Unique: za86oDrHNWa1PEe7gSLGFw-1
Received: by mail-ed1-f69.google.com with SMTP id i13so5622622edq.19
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3Gz45RAaG0RN/DlSdY8vAkKkFby4wOMzLVK7KgBbu6E=;
        b=go9TF39q0pU7rSwj3z3JA1wsXfVLCOYWjkYC7QcaLJy9rarqsru9VycBvHlAaRH+wl
         y2qIesJfLByfT/7rUS5fq7MXaTi9IFEFiEoRRpOLbXKNLQEKiDebTp6LNTi6RotAMQ25
         ywdtAQ1paQrfLCNJDAcE5qc+lFYnVpKWwnWc8IRo6AQVhoHMI24HYhqyHioYEei4BI4E
         ERDXfKX02YJ2bqrHPJEQUtfah5slcX8QxCzfHfjbY8SHzFUb7COTJQDa/fndVYlGAEIm
         Typ9aDc6lvijLUxULhOecZHsP32XlxOayCn0V7Gw20nWYHWELBmr1be2SqqWEs6FtJi7
         LkBg==
X-Gm-Message-State: AOAM533ebh4eKtnhu/VwZieWCW9gE05r3KhSr1M7+7BmJ4ewu91Hu6Ph
        B0QoQTlJDH0st2U98ehITCn2DkmhjUlDmSgTGY9V6ouurr3q+JCJhRJ1hHsJ9nEbzrtP4V6uTVp
        wC/YPSYygmE8e0z5oWed3ycLDKUVMlvcf7zYuIXODcOwah0+hOCyvKA37Kvp/UmFyUHGNETbFut
        se
X-Received: by 2002:a17:906:2ccb:: with SMTP id r11mr3524849ejr.39.1612362103205;
        Wed, 03 Feb 2021 06:21:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPpUB0ezXo1LvKeNxRyPbFs9ggkNMObtTwJRJceIdlFSWGFMsPlQlELHxma0PAa/UVPu7pDA==
X-Received: by 2002:a17:906:2ccb:: with SMTP id r11mr3524639ejr.39.1612362100893;
        Wed, 03 Feb 2021 06:21:40 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e11sm1063004ejx.77.2021.02.03.06.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:21:40 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: Scalable memslots implementation
In-Reply-To: <dd76955e-710a-61b0-9739-28623f985508@maciej.szmigiero.name>
References: <ceb96527b6f7bb662eec813f05b897a551ebd0b2.1612140117.git.maciej.szmigiero@oracle.com>
 <4d748e0fd50bac68ece6952129aed319502b6853.1612140117.git.maciej.szmigiero@oracle.com>
 <YBisBkSYPoaOM42F@google.com>
 <9e6ca093-35c3-7cca-443b-9f635df4891d@maciej.szmigiero.name>
 <YBnjso2OeX1/r3Ls@google.com>
 <dd76955e-710a-61b0-9739-28623f985508@maciej.szmigiero.name>
Date:   Wed, 03 Feb 2021 15:21:38 +0100
Message-ID: <875z39p6z1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 03.02.2021 00:43, Sean Christopherson wrote:
>> On Tue, Feb 02, 2021, Maciej S. Szmigiero wrote:
>>> On 02.02.2021 02:33, Sean Christopherson wrote:

...

>>>
>>> I guess you mean to still turn id_to_index into a hash table, since
>>> otherwise a VMM which uses just two memslots but numbered 0 and 508
>>> will have a 509-entry id_to_index array allocated.
>> 
>> That should be irrelevant for the purposes of optimizing hva lookups, and mostly
>> irrelevant for optimizing memslot updates.  Using a hash table is almost a pure
>> a memory optimization, it really only matters when the max number of memslots
>> skyrockets, which is a separate discussion from optimizing hva lookups.
>
> While I agree this is a separate thing from scalable hva lookups it still
> matters for the overall design.
>
> The current id_to_index array is fundamentally "pay the cost of max
> number of memslots possible regardless how many you use".
>
> And it's not only that it takes more memory it also forces memslot
> create / delete / move operations to be O(n) since the indices have to
> be updated.

FWIW, I don't see a fundamental disagreement between you and Sean here,
it's just that we may want to eat this elephant one bite at a time
instead of trying to swallow it unchewed :-)

E.g. as a first step, we may want to introduce helper functions to not
work with id_to_index directly and then suggest a better implementation
(using rbtree, bynamically allocated array,...) for these helpers. This
is definitely more work but it's likely worth it.

>
> By the way, I think nobody argues here for a bazillion of memslots.
> It is is enough to simply remove the current cap and allow the maximum
> number permitted by the existing KVM API, that is 32k as Vitaly's
> patches recently did.

Yea, there's no immegiate need even for 32k as KVM_MAX_VCPUS is '288',
we can get away with e.g. 1000 but id_to_index is the only thing which
may make us consider something lower than 32k: if only a few slots are
used, there's no penalty (of course slot *modify* operations are O(n)
so for 32k it'll take a lot but these configurations are currently
illegal and evem 'slow' is better :-)

-- 
Vitaly

