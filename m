Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE8E3B2211
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFWUz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbhFWUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624481586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9n3NgC3GAu3lDi6hAVapBvNOzF/zUAHWZGT/SQUjfn8=;
        b=arf5DbcBcm92Nv7Ac/acwSDw6/wUpxUeZt8M71eWhwzie5rEFtQqIiS1P7f1kvMsspoie6
        QGCp8uCInzqH3SrLkqTyp3DkBlfh+4wx+U3VM9L6QpAhqAN17NdihFADC7XK0NBZS0p8XP
        t62vIOYz3LuB9b2xs9IgwHSW6BKKJKg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-sodyH3z4OO-JcgZhRjbp0g-1; Wed, 23 Jun 2021 16:53:05 -0400
X-MC-Unique: sodyH3z4OO-JcgZhRjbp0g-1
Received: by mail-ed1-f71.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso2008868edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9n3NgC3GAu3lDi6hAVapBvNOzF/zUAHWZGT/SQUjfn8=;
        b=qar2rOP1sESZnae4gjH1ET5C3w7J4URsQGJvSDPxV5Tx5KtLdMtTghqCpi86kKzlcD
         9pxDcYMRKblEoMM+vV3rvNL/rj5y5+Mp4vC3QtqZ6yDB2mXyq6wzLxB31Y0r6AuHPkPS
         XXcqe8m49WjKZTaKwhPUJvxQH8SD3Rjl2np24z1zm8zJ1F69G8hOYuXLl60g1gMYElIL
         JCslhUWqbkVBdgcFDPCOucnw6JfRlWjNFmEXxzFMcRAP5c+NZm2SLxndJsr1XdHrBxnt
         LjmFshl+xpVzow6XzAzSiU+syUdIGu3ecLVyrQwpSrUuwCAIRQX7thqFi/t0B2TmyBSA
         W5og==
X-Gm-Message-State: AOAM530v9CyXKfncrIFgKcj4CO3P836rA6sLbVlwaHdteujcQ5P3pQI4
        bzIHZyJs/bCFy4PeXK6HbOfdlxN3CM65MfFu4CtZQc3mf80cFvcsSEI0FxpddhxHHbFlKwf2oUH
        OSMqXKeezBoKeetVqCktfih/P
X-Received: by 2002:a17:907:9854:: with SMTP id jj20mr1868385ejc.365.1624481584366;
        Wed, 23 Jun 2021 13:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMe8FJ9wIRFyAgHMyMvQXoIdX9CLLTCkw4YE+5D5Tm+jGV+RsdTr7SgoZV9o6Y/HIs60T5nQ==
X-Received: by 2002:a17:907:9854:: with SMTP id jj20mr1868376ejc.365.1624481584214;
        Wed, 23 Jun 2021 13:53:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s5sm613146edi.93.2021.06.23.13.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 13:53:03 -0700 (PDT)
Subject: Re: [PATCH 25/54] KVM: x86/mmu: Add helpers to query mmu_role bits
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-26-seanjc@google.com>
 <1babfd1c-bee1-12e5-a9d9-9507891efdfd@redhat.com>
 <YNOd/0RxSnqmDBvd@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c1cc822-4604-9e04-dd4c-e5005bfee7c5@redhat.com>
Date:   Wed, 23 Jun 2021 22:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNOd/0RxSnqmDBvd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/21 22:47, Sean Christopherson wrote:
>> What do you think about calling these is_mmu_##name?  The point of having
>> these helpers is that the register doesn't count, and they return the
>> effective value (e.g. false in most EPT cases).
>
> I strongly prefer to keep <reg> in the name, both to match the mmu_role bits and
> to make it a bit more clear that it's reflective (modified) register state, as
> opposed to PTEs or even something else entirely.  E.g. I always struggled to
> remember the purpose of mmu->nx flag.

No problem.  I do disagree that it's register state ("modified" seems to 
be more than a parenthetical remark), but not enough to argue about it 
and even less to do the work to rename the accessors.

Paolo

