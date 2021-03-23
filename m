Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0034657B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhCWQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233276AbhCWQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616517544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6weZtocFnBCEx2KB5301dgGufT240mULVdpXRdDCN0=;
        b=TJTAE7xPRdyGR5DuArQcmMfStDPThO2PemoLbkFplHIPTsMkzGFpKuyN8zf6Z53dLe4P0L
        Qg7dXNpmsAa598nIteWC8fulQEtrRR3F3g3lmeerq4onsHXT4VlU6ZhtwU0o6Zs3rqzVWq
        LJLG9e3SiH5uon9s9AIXLqTJq0umwio=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-E4PgojVhMkyVefymlAs4oA-1; Tue, 23 Mar 2021 12:39:03 -0400
X-MC-Unique: E4PgojVhMkyVefymlAs4oA-1
Received: by mail-wm1-f70.google.com with SMTP id a65so700959wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6weZtocFnBCEx2KB5301dgGufT240mULVdpXRdDCN0=;
        b=reQ+/4hfxzQVbn2X/E/MQUQSzSCnpB4EW7edfI44JLEktRqo+jFQh7LMGeq8rVk1m6
         l4XacWdUww7cXk0c0TlFfF4QM32DfKhvVbWwP/aypFzpsYR5f+xVVLzNdBD8b5xuaMd7
         lH3FCAegPXDja5W0cVlxYdS3FpORXAbjhSy8jkExbu3o7niJNJGJS29o3kMLHSbfyfsV
         n7B+a8OQnnkGNlqhFbB10xa8Zzg/DhYYu2mabaTjWkjeb+2sJbx0+g3jZwOPCrlqr66T
         IWMn8FBu8/Vm7HtkHQ5CBUIuk2tcGxxaESwEe5NZJAbBjnUsYAOgYPAnghcNAttpulLP
         iaMQ==
X-Gm-Message-State: AOAM533sk7Q49Mb8dL9GGUuoW3lp9FB21/7ZcosQ4UC9o1bHyjim8uQG
        LcrtHW8flWCQ53ObmpRDbgUA2NSFaPe8nECgvgVvF2cjoasQlIaBXmij0V5SGCdc2+yKG3a2Yru
        vABbEXRn7Qs2GR1tR6ImbvtEd
X-Received: by 2002:adf:8562:: with SMTP id 89mr4930808wrh.101.1616517541375;
        Tue, 23 Mar 2021 09:39:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKvUUe1NQSERBzHVlgA+GOPmHPOwJubTjgP1O9G/oYv5jEATOiJ0EW7ujfn570henkj75IQA==
X-Received: by 2002:adf:8562:: with SMTP id 89mr4930777wrh.101.1616517541194;
        Tue, 23 Mar 2021 09:39:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j136sm3281428wmj.35.2021.03.23.09.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:39:00 -0700 (PDT)
Subject: Re: [PATCH v3 03/25] x86/sgx: Wipe out EREMOVE from
 sgx_free_epc_page()
To:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>
Cc:     Kai Huang <kai.huang@intel.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com
References: <062acb801926b2ade2f9fe1672afb7113453a741.1616136308.git.kai.huang@intel.com>
 <20210322181646.GG6481@zn.tnic> <YFjoZQwB7e3oQW8l@google.com>
 <20210322191540.GH6481@zn.tnic> <YFjx3vixDURClgcb@google.com>
 <20210322210645.GI6481@zn.tnic>
 <20210323110643.f29e214ebe8ec7a4a3d0bc2e@intel.com>
 <20210322223726.GJ6481@zn.tnic>
 <20210323121643.e06403a1bc7819bab7c15d95@intel.com>
 <YFoNCvBYS2lIYjjc@google.com> <20210323160604.GB4729@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41dd6e78-5fe4-259e-cd0b-209de452a760@redhat.com>
Date:   Tue, 23 Mar 2021 17:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323160604.GB4729@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/21 17:06, Borislav Petkov wrote:
>> Practically speaking, "basic" deployments of SGX VMs will be insulated from
>> this bug.  KVM doesn't support EPC oversubscription, so even if all EPC is
>> exhausted, new VMs will fail to launch, but existing VMs will continue to chug
>> along with no ill effects....
>
> Ok, so it sounds to me like*at*  *least*  there should be some writeup in
> Documentation/ explaining to the user what to do when she sees such an
> EREMOVE failure, perhaps the gist of this thread and then possibly the
> error message should point to that doc.

That's important, but it's even more important *to developers* that the 
commit message spells out why this would be a kernel bug more often than 
not.  I for one do not understand it, and I suspect I'm not alone.

Maybe (optimistically) once we see that explanation we decide that the 
documentation is not important.  Sean, Kai, can you explain it?

Paolo

