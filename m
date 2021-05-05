Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2124373EAD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhEEPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhEEPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:37:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 08:36:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so1045579pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uh5fnNg4PWYr5e3cV22y9vYtxdN1GmrpBB3SRm60g3I=;
        b=BAW6nWwMYE/qNeiD8Uv6sfc0s0VCmV87nng79Gp4ifLQZWxTEt+Y3n9e8mSwU41CON
         Kw/etwdSsl/FVeP+dqEkjelHig7+u5EXG+yBC1KAZ5wK13qIEmEV87+/Byfy8tFjitse
         +acufFHjk56KyNImGAzIj3gUWxS742gVQdMmIXnPT66Bq4k3fMvqqsxEA35GLH6xgGPT
         STUQiwE+dTla5M2kSkcGz0wy6RDlRGrS0q4atlyuSi6gFaOKXR1LriMnKepaK5eE572G
         Q9br1bd/QUse+1zRyqZIT3GlZ1jROgvt1I2z4Zb3RAoYjtaJWdWfOuXpoFufy7QvjIsl
         w/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uh5fnNg4PWYr5e3cV22y9vYtxdN1GmrpBB3SRm60g3I=;
        b=Luq2wJhbelUqAAiMusormK7MyIr8lJfl+Dc7mzJCKLz1rdoSwIvwvee5EWIl6+2fWv
         4lQTF5ulVdUCNWKpfblZYjjRexGIE4XwD+Pnu7uwIhE5b5vvVtep3+NCNx7MQaZlojPa
         2ZJNABD22OeERFMvYRQKPi+1kdiq1S85ZlK/i/EjxASb6vhEXTC3Qet8/Dc+wwArV+PG
         iSEKJuPikRIWjyBTFIXge5XJJbeSH1G/Kjs8qsVwN6xQX1Qg88Y2+kpUOgkQxTaeuPMZ
         mvx6OYNLjaw0mwujnpaGRd4CtAG2L8ASIkPoHYU9s1Eg2paD0UiTm6pD+SDluc3Tq+AQ
         R0PQ==
X-Gm-Message-State: AOAM533vK+HH+0/9pVhg7ykkFL8Agmz/ChLd/yL1NDVJGvQ8PBxudCR2
        Y4z7OHl0pvUiBaSi0TC0mjwRbA==
X-Google-Smtp-Source: ABdhPJwJshXIaDcc8ih2fcYI40swoQEQ4+4URUBGAeGDf8TBQWEjne7XmzoRhTQubVJItcu/gBjy1Q==
X-Received: by 2002:a17:90a:f491:: with SMTP id bx17mr12330618pjb.176.1620229011512;
        Wed, 05 May 2021 08:36:51 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id c13sm1829446pjc.43.2021.05.05.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 08:36:50 -0700 (PDT)
Date:   Wed, 5 May 2021 15:36:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 11/15] KVM: VMX: Disable loading of TSX_CTRL MSR the more
 conventional way
Message-ID: <YJK7jzbihzFIkb59@google.com>
References: <20210504171734.1434054-1-seanjc@google.com>
 <20210504171734.1434054-12-seanjc@google.com>
 <08a4afca-c3cb-1999-02a6-a72440ab2214@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a4afca-c3cb-1999-02a6-a72440ab2214@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021, Paolo Bonzini wrote:
> On 04/05/21 19:17, Sean Christopherson wrote:
> > Tag TSX_CTRL as not needing to be loaded when RTM isn't supported in the
> > host.  Crushing the write mask to '0' has the same effect, but requires
> > more mental gymnastics to understand.
> 
> This doesn't explain _why_ this is now possible.  What about:
> 
> Now that user return MSRs is always present in the list, we don't have

User return MSRs aren't always present in the list; this series doesn't change
that behavior at all.

> the problem that the TSX_CTRL MSR needs a slot vmx->guest_uret_msrs even
> if RTM is not supported in the host (and therefore there is nothing to
> enable).  Thus we can simply tag TSX_CTRL as not needing to be loaded
> instead of crushing the write mask to '0'.

Unless I'm missing something, it would have been possible to give TSX_CTRL a
slot but not load it even before this refactoring, we just missed that approach
when handling the TSX_CTRL without HLE/RTM case.  Several other MSRs rely on
this behavior, notably the SYSCALL MSRs, which are present in the list so that
the guest can read/write the MSRs, but are loaded into hardware iff the guest
has enabled SYSCALL.

All that said, I certainly have no objection to writing a longer changelog.
