Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453F030D8AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhBCL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234341AbhBCL2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612351616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yf1gMS5lzQEVg3r7cZkjC3YL7CF1bZPMLFMUXZG5850=;
        b=fyiFvYHejRzLRkK0i5dUNGRBd94rvFNgI/Gfmc5HT6e37W6ZWcO/t8q5ExT1yzo9tItsXu
        S0Idx20qVP651xD2XZeekKmDpITD3Bdse1MaYJqxJhsIzxDHdEXN+sU91RkWUgWy2dvt/s
        J+UcjD3EemXd14o5UusIfwCL5WE0TBg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-3j0m7MMUPkCDFk5fUmV41g-1; Wed, 03 Feb 2021 06:26:53 -0500
X-MC-Unique: 3j0m7MMUPkCDFk5fUmV41g-1
Received: by mail-ej1-f69.google.com with SMTP id h4so11875457eja.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yf1gMS5lzQEVg3r7cZkjC3YL7CF1bZPMLFMUXZG5850=;
        b=ZpNYxFs5l2k5b2DNur8E5g4e4gxOr2O8TPtTnRwIkwgPungXp4a/kUeE6Ln7Al8ra+
         vXB/V3nGxAj+lCPYu3wHTihhcr/aS0yAlvUgyi4kehSxPJX4MpKNURdjUmlbvIMqZnfJ
         I0/6RBqM3M7Vj9MbZIbtWL96/QKIPhlplWFfQax17x5nOtSAM5uo0aNOjfpyjvQ1qC/5
         EzTbr4XJcGc+wRyfr6zn9sMQvboqUZsUhNrEDjAeHjq5IX3pWllnKVYcSfVTbLEsbIrN
         nnhvxJHLsGbKdF0b6LDq5qUM9nqW4m4gEKULR7xBG2shgmeEyvfeodOuK5R8Pt3FLWMF
         na/A==
X-Gm-Message-State: AOAM531drBW8dDtj1F8EdwVD8EmqyZYpjLAASNAWzS4h2ZEgVHmdN+dT
        2XDJu90a5sbUV1pYwuHxbXjcnSTlo2Yzo2XaM1fU2y4DAIIOtBRCmTAQtvWjzISYu3k4pDmMZyd
        I1q29BH1x4cjeV6ccgMwKmtog
X-Received: by 2002:aa7:c407:: with SMTP id j7mr2390423edq.28.1612351612331;
        Wed, 03 Feb 2021 03:26:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFgG9dKnLjuQhzh0H7zffJi1oxnAdxTuCnrxpIi4XAb4Dgz66tAS3JhIwt2dJZg4gB37VSNg==
X-Received: by 2002:aa7:c407:: with SMTP id j7mr2390392edq.28.1612351611968;
        Wed, 03 Feb 2021 03:26:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g2sm851915ejk.108.2021.02.03.03.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:26:51 -0800 (PST)
Subject: Re: [PATCH v2 24/28] KVM: x86/mmu: Allow zap gfn range to operate
 under the mmu read lock
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <813695b1-bcfc-73ea-f9fe-76ffd42044cd@redhat.com>
Date:   Wed, 3 Feb 2021 12:26:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202185734.1680553-25-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:57, Ben Gardon wrote:
> +#ifdef CONFIG_LOCKDEP
> +	if (shared)
> +		lockdep_assert_held_read(&kvm->mmu_lock);
> +	else
> +		lockdep_assert_held_write(&kvm->mmu_lock);
> +#endif /* CONFIG_LOCKDEP */

Also, there's no need for the #ifdef here.  Do we want a helper 
kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm, bool shared)?

Paolo

