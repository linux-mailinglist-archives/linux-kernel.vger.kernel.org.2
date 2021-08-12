Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF523EA9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhHLRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhHLRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:46:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583FDC0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:46:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so8624050pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MLzpz5FJ/bAh1Ll32cDrqfBMeLtXwbzVAN6uEI5IppM=;
        b=So4//MqN3ifH/Aw1xop0UccL3tSLF258xwuGXpyGzzWNblqBSU8eaAu4YEJwmk0L8r
         TYq37/F5s90Y8pSnMsiV+3lTcU9FP/oIdxaKk//JFyU3zPfQZw4a/4RU9Mh00UQxZ6Nb
         qeTjiSs2o8wOlriF4J5CDF/n7Emc3+RFBKdju+fv/Hor3I92Ojm5/yRJfQPwB2+SVoTb
         T76PMJ9LT6XjYVMPGXlGgJsJV/3sKdTH0f0il6o8Oga52up3hmJ3bMxsH7YLXfnSzN4z
         E6aMSLeUBMnyo3NWsM3wJXZ+U9k3a9nsBbDv+GVzeSOhzPuzEc6gC0kQ4BSn80HYEFTL
         K+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MLzpz5FJ/bAh1Ll32cDrqfBMeLtXwbzVAN6uEI5IppM=;
        b=QJfltWl4+aBxqCe6+FZPp5E5QCZZRk+8PLHKHOtOgAapOhoFjpB+Xv/R73YvMPXMlh
         9fnr3wRu8vL1KMPzR7yqneATB9uuDXKg5uwq/l160K96ENycN+gP4jwg7bqAptkm6VIs
         TGMNFI8FoafZbBscL3JdGvvX/xgqIN8uy2sw83PjPjlHcx6MHq7k0DdxL78PV2gb9tIZ
         DnN1MRUaw9dPFpOMuYh5il37YzTtTuX7V6nQJJIxtygC1dpE6pzk7RfAP9Jtj0EGSjO4
         nER2E9mGhSPJLNsjwncnAfGPnAsEd1bC0UU0UjrfZYCg/Tqk1opnyNzXd23f/rVdc/Xm
         M4rw==
X-Gm-Message-State: AOAM533Z3TD19R9s+ZNGWH7vlcgrj7UOv9aWRdDmuiQOvkoWyS8Uz3DD
        bwOeet4mlTp4nJ1xUfHi8h9BrA==
X-Google-Smtp-Source: ABdhPJxezDWsGATFWaXM1+RQG1qmr0dl+WiM8kXxSaSGJGAivcJbWBZoBEdVFEXQcXOWBJqGv3Lb+g==
X-Received: by 2002:a17:90a:d709:: with SMTP id y9mr9585479pju.153.1628790386729;
        Thu, 12 Aug 2021 10:46:26 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y3sm779568pgc.67.2021.08.12.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:46:26 -0700 (PDT)
Date:   Thu, 12 Aug 2021 17:46:20 +0000
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
Message-ID: <YRVebIjxEv87I55b@google.com>
References: <20210812050717.3176478-1-seanjc@google.com>
 <20210812050717.3176478-3-seanjc@google.com>
 <CANgfPd8HSYZbqmi21XQ=XeMCndXJ0+Ld0eZNKPWLa1fKtutiBA@mail.gmail.com>
 <YRVVWC31fuZiw9tT@google.com>
 <928be04d-e60e-924c-1f3a-cb5fef8b0042@redhat.com>
 <YRVbamoQhvPmrEgK@google.com>
 <7a95b2f6-a7ad-5101-baa5-6a19194695a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a95b2f6-a7ad-5101-baa5-6a19194695a3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021, Paolo Bonzini wrote:
> On 12/08/21 19:33, Sean Christopherson wrote:
> > On Thu, Aug 12, 2021, Paolo Bonzini wrote:
> > > On 12/08/21 19:07, Sean Christopherson wrote:
> > > > Yeah, I was/am on the fence too, I almost included a blurb in the cover letter
> > > > saying as much.  I'll do that for v2 and let Paolo decide.
> > > 
> > > I think it makes sense to have it.  You can even use the ternary operator
> > 
> > Hah, yeah, I almost used a ternary op.  Honestly don't know why I didn't, guess
> > my brain flipped a coin.
> > 
> > > 
> > > 	/*
> > > 	 * When zapping everything, all entries at the top level
> > > 	 * ultimately go away, and the levels below go down with them.
> > > 	 * So do not bother iterating all the way down to the leaves.
> > 
> > The subtle part is that try_step_down() won't actually iterate down because it
> > explicitly rereads and rechecks the SPTE.
> > 
> > 	if (iter->level == iter->min_level)
> > 		return false;
> > 
> > 	/*
> > 	 * Reread the SPTE before stepping down to avoid traversing into page
> > 	 * tables that are no longer linked from this entry.
> > 	 */
> > 	iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));  \
> >                                                                       ---> this is the code that is avoided
> > 	child_pt = spte_to_child_pt(iter->old_spte, iter->level);   /
> > 	if (!child_pt)
> > 		return false;
> 
> Ah, right - so I agree with Ben that it's not too important.

Ya.  There is a measurable performance improvement, but it's really only
meaningful when there aren't many SPTEs to zap, otherwise the cost of zapping
completely dominates the time.

The one thing that makes me want to include the optimization is that it will kick
in if userspace is constantly modifying memslots, e.g. for option ROMs, in which
case many of the memslot-induced zaps will run with relatively few SPTEs.  The
thread doing the zapping isn't a vCPU thread, but it still holds mmu_lock for
read and thus can be a noisy neighbor of sorts.
