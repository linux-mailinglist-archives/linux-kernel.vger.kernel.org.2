Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6E33B3FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFYJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhFYJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624611904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Vf7eQafJpn+Km6dnUrld2h7erdnsGXaWtmQA8sYWrM=;
        b=Aoj9BUx2FCuRk+aJSz3/D/T543r5cNAvIof5kHXFgixW2CPDabjyrcF7Y2gGE2USpUwtGn
        d7nOfKcMK99h8QS1dQa8IPA04PCSm0uIGk7z780SzGvDLk2LbHVdotTWXo/RMgbFma10K/
        ejGAEwSYOO96aPrEdd/KDTDo3V5ViP0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-WCqn1PINOeCdUIZnp-fqYA-1; Fri, 25 Jun 2021 05:05:03 -0400
X-MC-Unique: WCqn1PINOeCdUIZnp-fqYA-1
Received: by mail-ej1-f70.google.com with SMTP id ci22-20020a170906c356b0290492ca430d87so2866604ejb.14
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 02:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Vf7eQafJpn+Km6dnUrld2h7erdnsGXaWtmQA8sYWrM=;
        b=hzsm/kZHi65gA+6YWz/mFyGH1OQolTSBO7eTp6uFCe2IywfDD7BMXpNM+z15EYkFA5
         QKMxUos35e3/KPk0vehG/vPbGbrIKRgXuFwfbWyWlY3celhvYQ9+cVF54XCdbTvU99kf
         UFU6lpCT01o2+4Nfwzio+1lcSePLWbWTxv2dwMWfGLpMk8wgFGvFOZDAwACdxH0HB4It
         WPe2eHpSeQAKkY21mMEdo+gDaOIfNiW1NJ6UqgcFH8tbgg7yK3QvTYafw72gsuo2Co1z
         u9iPgGxi4Gd6B3KNE/O8UJ90/Tp+iuQbmhtLVrjW4kU69Jx+oiwkU1hqgf/vVyZQtBQa
         VKqg==
X-Gm-Message-State: AOAM531dXDYVvTfqmDktkwnEsh32/o/a4eNYh0YVeiI5qvj2DcAY8gEq
        4gMzHDiiLEoZab7HuzF18e8sr8WitTCW8m7eofiz2FHrotS4m3dkCm6T3+5r3mJ8Rc5Hc08dq5g
        bVpzsRJivmFv+j6pCrCgbP7NpStzx1GFhj24Wx39wajuKEHlLFvfv7jqQYAkAn3Ww9lI9aOxqFj
        Jv
X-Received: by 2002:a17:906:b215:: with SMTP id p21mr10141817ejz.237.1624611901640;
        Fri, 25 Jun 2021 02:05:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfEt+Mcicq18UzSdQy2+ca/CS9XiyaFqrwUOm+ZVOjBEnrIF6U+hhzb0ccOUQ+FYXzVWitZQ==
X-Received: by 2002:a17:906:b215:: with SMTP id p21mr10141785ejz.237.1624611901306;
        Fri, 25 Jun 2021 02:05:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id jl21sm2423410ejc.42.2021.06.25.02.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 02:05:00 -0700 (PDT)
Subject: Re: [PATCH 3/4] KVM: x86: WARN and reject loading KVM if NX is
 supported but not enabled
To:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210615164535.2146172-1-seanjc@google.com>
 <20210615164535.2146172-4-seanjc@google.com> <YNUITW5fsaQe4JSo@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad85c5db-c780-bd13-c6ce-e3478838acbe@redhat.com>
Date:   Fri, 25 Jun 2021 11:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNUITW5fsaQe4JSo@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/21 00:33, Sean Christopherson wrote:
> On Tue, Jun 15, 2021, Sean Christopherson wrote:
>> WARN if NX is reported as supported but not enabled in EFER.  All flavors
>> of the kernel, including non-PAE 32-bit kernels, set EFER.NX=1 if NX is
>> supported, even if NX usage is disable via kernel command line.
> 
> Ugh, I misread .Ldefault_entry in head_32.S, it skips over the entire EFER code
> if PAE=0.  Apparently I didn't test this with non-PAE paging and EPT?
> 
> Paolo, I'll send a revert since it's in kvm/next, but even better would be if
> you can drop the patch :-)  Lucky for me you didn't pick up patch 4/4 that
> depends on this...
> 
> I'll revisit this mess in a few weeks.

Rather, let's keep this, see if anyone complains and possibly add a 
"depends on X86_PAE || X86_64" to KVM.

Paolo

