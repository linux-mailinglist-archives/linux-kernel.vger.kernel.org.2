Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9443EB9D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhHMQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhHMQN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:13:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B068C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:13:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a20so12661115plm.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kgEwqaMXas/gINmvu6DHt4AAtxtOhJftfQkG8U2AMqQ=;
        b=uFWr7KTM06wIgz0mjW60tVP7wO0TmJ8v4RJFZr6hMx2hXy4TKa7SumsWtqezVBxAHe
         RcQi1bVKo0BOA1/+h90j5Oilv8CNaSNB+g1ufyp0S7jhjiaxLuvQ7/91SnmXDlnvdxT7
         TIHKJS2O18dWd9hZfrwufke9B8WAkCqtuQxiL6g/LHCDt2TcZiT9V5depEPo5Vcf3bv3
         FfKX3SFrFY7BiBrR28M0iNwc8RLp1jGDWf9NhahUw4eeOkwUH11m0Ubbx0LWYeS42PrZ
         EWdbG4dZOKK0eDXvcNzqhJgjoHG0lAeedX0vfbQicLwrj4glbndRIwfUrENnA8l+9aEo
         odSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kgEwqaMXas/gINmvu6DHt4AAtxtOhJftfQkG8U2AMqQ=;
        b=KYco9jJYzEOA7iMvso/bU+KE3roorvN0oSlNPmfkwKdLJQu/DwIY+7eaIquNGbp9Oc
         lUYmoe6x2iqGAW4aZGRDsJloG9LHaCljDXELbMpg+yTULqQasP6kwkkgy2/Q43pUC0Kw
         ZlJ7NS2/+vNiXn19PR9JMMaIf+e7sq+O/9khxzWhMfYGkLZ/ItSQy92qg0zrk5i5w44B
         P7QxRya7iownUxDQBkReZe3YTVQkvAQ+u79rWLT7wGMjhwo44uSGbJ8v4Ob1wxvpP4BD
         hl+ZU30THVWBxfJ4d5VGRIrik41XY1eLiMeJlS4oVkb88a5Y8+BYYjxuBVdlsXGp4EYm
         YOcA==
X-Gm-Message-State: AOAM533mpyKHc8u+lnynAxVpVEYdYqQenPravl6etWtOD7DedG4r35Iu
        OxTqanfgI4H4jI+6GQi2z36EKw==
X-Google-Smtp-Source: ABdhPJy9NUBZKSxbiMd/jy9FHfW9074y2neNJoLC4L0Bb660MJqYsWE86HB5EAVAbiRs7r/NckyxYA==
X-Received: by 2002:a63:df0d:: with SMTP id u13mr2896558pgg.417.1628871208868;
        Fri, 13 Aug 2021 09:13:28 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x81sm2720481pfc.22.2021.08.13.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:13:28 -0700 (PDT)
Date:   Fri, 13 Aug 2021 16:13:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Don't step down in the TDP iterator
 when zapping all SPTEs
Message-ID: <YRaaIi9Go38E3mUh@google.com>
References: <20210812050717.3176478-1-seanjc@google.com>
 <20210812050717.3176478-3-seanjc@google.com>
 <CANgfPd8HSYZbqmi21XQ=XeMCndXJ0+Ld0eZNKPWLa1fKtutiBA@mail.gmail.com>
 <YRVVWC31fuZiw9tT@google.com>
 <928be04d-e60e-924c-1f3a-cb5fef8b0042@redhat.com>
 <YRVbamoQhvPmrEgK@google.com>
 <7a95b2f6-a7ad-5101-baa5-6a19194695a3@redhat.com>
 <YRVebIjxEv87I55b@google.com>
 <b08a7751-20c3-26fc-522e-c4cf274d9a6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b08a7751-20c3-26fc-522e-c4cf274d9a6c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021, Paolo Bonzini wrote:
> On 12/08/21 19:46, Sean Christopherson wrote:
> > > > 	if (iter->level == iter->min_level)
> > > > 		return false;
> > > > 
> > > > 	/*
> > > > 	 * Reread the SPTE before stepping down to avoid traversing into page
> > > > 	 * tables that are no longer linked from this entry.
> > > > 	 */
> > > > 	iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));  \
> > > >                                                                        ---> this is the code that is avoided
> > > > 	child_pt = spte_to_child_pt(iter->old_spte, iter->level);   /
> > > > 	if (!child_pt)
> > > > 		return false;
> > > Ah, right - so I agree with Ben that it's not too important.
> > Ya.  There is a measurable performance improvement, but it's really only
> > meaningful when there aren't many SPTEs to zap, otherwise the cost of zapping
> > completely dominates the time.
> 
> I don't understand.  When try_step_down is called by tdp_iter_next, all it
> does is really just the READ_ONCE, because spte_to_child_pt will see a
> non-present PTE and return immediately.  Why do two, presumably cache hot,
> reads cause a measurable performance improvement?

It's entirely possible my measurements were bad and/or noisy.  Ah, and my kernel
was running with CONFIG_PROVE_RCU=y, which makes the rcu_dereference() quite a bit
more expensive.
