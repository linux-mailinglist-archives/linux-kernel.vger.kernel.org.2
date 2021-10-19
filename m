Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C541743423E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhJSXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhJSXoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:44:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B2C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 16:42:06 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i5so8586431pla.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ayHhE+6XCVFF1QvZ1U7r9RCr+fUbo2x5fP4Eznimt8o=;
        b=H0LZl7Df4YfevTzGObWrE97eDMtWfb1FRyb6qMTlbiaq6YvdCL/dm+go6ySGHWwDJv
         qQkjCEsWF1OPgAlLMcFKKPdsz1SxEfwtTQdJAotcr3kxo3ALeN1DUoX8rMhXLLLvxsLS
         Nc3mFfu98KFJkMIk71LZ9LufxsB2Jt7sz9HtDpGjJyU+uSzRWyy0fSsrVj44LHLXUlqW
         gQLp/ab0LMFetX1K85OadIVOobanRJoH3CRfe6hsJ1D81mNpqLsZYbtJYP5l76NWRQX6
         NZejJ+zy1rcLfOD8yQyIK+WDyi6BOw/M+EBUKgoA9xsgMZ9RD2+od4BJp5EJVGejPZqJ
         Fp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ayHhE+6XCVFF1QvZ1U7r9RCr+fUbo2x5fP4Eznimt8o=;
        b=j5T+KyF/NxhtZ4cGuURNbp3jVWmmdtzdye2UkHaHf8BE1xjWDg5U9kyvX8eqiwEC4a
         bkA8HCFBB2OWdnpshA8Dne8ql0e3IwZDoDLqhJe5zE39n9QGau1nnXJEkFmvXEnL+Pwz
         oQE2kAckQu3DaKUBQmWva+dgf9JcNxqT6L6LXj7y0IOIFO6Zn3nZMHolPcVGyShSVaf+
         cAc7n28qhdGdA8LldIUvL6tL2mCZfT4bPbL2PX3KPPEdZMyNtI1YuRnfPuDtXOrBM5sl
         xK8afEFUabrzK9Ikz2M/P6+sra1yTSf2e6Ps2A0nfJwOtjnyOhqRh4Uc7RM176ofiKAs
         YqOg==
X-Gm-Message-State: AOAM532V0X8P/qDe7JCTl+F2tkztKoejb+KR91/RM2NGWDLzJivpCNM8
        e0+A/FA6t4hAkoydaa69mg66eQ==
X-Google-Smtp-Source: ABdhPJy6skvDdoMKt3FdfUe6JrQXh75WR3xWXhRMf4e3wuOPvQm6AGdG+qsX6fzObHU2Jqy6aAPJHA==
X-Received: by 2002:a17:902:7781:b0:13d:c9fe:6184 with SMTP id o1-20020a170902778100b0013dc9fe6184mr36010239pll.25.1634686926078;
        Tue, 19 Oct 2021 16:42:06 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id pc18sm3434680pjb.0.2021.10.19.16.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:42:05 -0700 (PDT)
Date:   Tue, 19 Oct 2021 23:42:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
Subject: Re: [PATCH v5 06/13] KVM: Move WARN on invalid memslot index to
 update_memslots()
Message-ID: <YW9Xydg2NMObx5H4@google.com>
References: <cover.1632171478.git.maciej.szmigiero@oracle.com>
 <f01919799c5cac1f6cf90c7d1f3fc17b389a3bee.1632171479.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f01919799c5cac1f6cf90c7d1f3fc17b389a3bee.1632171479.git.maciej.szmigiero@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Since kvm_memslot_move_forward() can theoretically return a negative
> memslot index even when kvm_memslot_move_backward() returned a positive one
> (and so did not WARN) let's just move the warning to the common code.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
