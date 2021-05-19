Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E773899EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhESXgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhESXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:36:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:34:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c17so11010219pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uhGbN9Jog+FC96345EUpiT1u57egVRed342Jt8fST8=;
        b=aNjrMwksMJuvYFFD9/LdGMHZuoi+Hc0znhC9f+npaoSm5w3MayeaWJG6eXJvcA6NZJ
         uaPpvdRDWylbu1xgU/zSw3sOKjwJz8jDsZ+1eaAbRJCx2i/1ExqzE1sL0dxppSqlrxSE
         LuPS8udXRtus1CMFPA5nPaK0dAbDt0jCaDkxOFcr+586HowgCccny6ZvTTH7gjRAcJdh
         Xk6j9ptvFm8FgPQ4uQQPLJExctRKXIJb0balVMkwwwvo4VJSbsPMsio3n2L6xJ1+uPQG
         YxB1lCOjnvU8Ea7umWsUSpgf3PB/MJ/X6qZDdhQl+ZNN0ag/ggjyn0hVitLJFUlxWI1P
         emNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0uhGbN9Jog+FC96345EUpiT1u57egVRed342Jt8fST8=;
        b=p98kIloeANdlb9nj33NAUqCUre2DQ3F+KsGWBfdxn2Yon4D+G8m7sZ0pslXLznF1zZ
         xYcRqQKmVq/mFSfIj45bvxUlLUKef3gn0Sp+7WFu3rrR4p6Nl7qeJTAZmSn9PbQtZMnE
         +4lNG0YNJidSdGF2JiJgf2rBbbcnNPLsNmL84ZIwHvvOtYbAKtfc8dDXNu6xaGYk8Um5
         WzqekUKfzH2RjHFMruDjzz5gY2DTzx5SNkIfkL1VM5qXYEaGjybmiGk4zX6e0uCffYzV
         uyXTlkpv2JqXXzfvRTpQIcQlB6ZElVD7c73ckz7uBeanksJLtDAAdrP039wM8hXZ1w/N
         R77Q==
X-Gm-Message-State: AOAM530EBebqg+5hQLqWzgtBTul6bFjNXlbgv92j/PCjDdX8bwj87obo
        Jgj65XpYeVbSbJdYZ9Dwf0lPtw==
X-Google-Smtp-Source: ABdhPJzyX+o4+rlb3VislTtgDMx/Tino+Lh0mid6nqa4cUEX9wG+d1WVZ9TYnbbrx4h4wUs5B92+cg==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr1610880pgc.45.1621467297929;
        Wed, 19 May 2021 16:34:57 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id kk7sm5054384pjb.16.2021.05.19.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:34:57 -0700 (PDT)
Date:   Wed, 19 May 2021 23:34:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] x86: Support Intel Key Locker
Message-ID: <YKWgnb/OO5TWmer5@google.com>
References: <20210514201508.27967-1-chang.seok.bae@intel.com>
 <9f556d3b-49d3-5b0b-0d92-126294ea082d@kernel.org>
 <C08CCADB-864B-48E0-89E0-4BF6841771E8@intel.com>
 <247d9a25-f32f-d01b-61ff-b1966e382907@kernel.org>
 <YKP+1cjRWN/IOEpd@google.com>
 <112f7ceb-d699-fc1e-ea5f-89d505e0d6d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112f7ceb-d699-fc1e-ea5f-89d505e0d6d8@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021, Andy Lutomirski wrote:
> On 5/18/21 10:52 AM, Sean Christopherson wrote:
> > On Tue, May 18, 2021, Andy Lutomirski wrote:
> >> On 5/17/21 11:21 AM, Bae, Chang Seok wrote:
> >>> First of all, there is an RFC series for KVM [2].
> >>>
> >>> Each CPU has one internal key state so it needs to reload it between guest and
> >>> host if both are enabled. The proposed approach enables it exclusively; expose
> >>> it to guests only when disabled in a host. Then, I guess a guest may enable it.
> >>
> >> I read that series.  This is not a good solution.
> >>
> >> I can think of at least a few reasonable ways that a host and a guest
> >> can cooperate to, potentially, make KL useful.
> >>
> >> a) Host knows that the guest will never migrate, and guest delegates
> >> IWKEY management to the host.  The host generates a random key and does
> >> not permit the guest to use LOADIWKEY.  The guest shares the random key
> >> with the host.  Of course, this means that a host key handle that leaks
> >> to a guest can be used within the guest.
> > 
> > If the guest and host share a random key, then they also share the key handle.
> > And that handle+key would also need to be shared across all guests.  I doubt this
> > option is acceptable on the security front.
> > 
> 
> Indeed.  Oddly, SGX has the exact same problem for any scenario in which
> SGX is used for HSM-like functionality, and people still use SGX.

The entire PRM/EPC shares a single key, but SGX doesn't rely on encryption to
isolate enclaves from other software, including other enclaves.  E.g. Intel could
ship a CPU with the EPC backed entirely by on-die cache and avoid hardware
encryption entirely.

> However, I suspect that there will be use cases in which exactly one VM
> is permitted to use KL.  Qubes might want that (any Qubes people around?)
