Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3933EA988
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhHLReD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhHLReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:34:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6CBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:33:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso11852364pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OCSFs2wsqNJ3bFCNyBwkye5Bq6faNmmLufS+mm/TQAE=;
        b=mGcICMR7rx638At7ngR1d9J773nsQi6pNa8uEU/ceAr9EW9tc3Zlfhsjb9VHeekKh5
         beaknm2x7D2UVCHO3iqQbJoVyAowCjxeuk4N/VXis8mB64iAKExgKhMLTDUqJYC9bx9r
         pWF0oNoGPqvLY00GYV5rf+BYe7ISUhzUUtiahZ2irePnaxlzJ8/fys34rDsN2M2j0E68
         qsLzDcUratAD04OtJmXhJLWgFtwPIkgoIYG2ft1uZJyl7Jx2uAvgMhQ7ITFygLm18+Lp
         fJM1FYToFPPxCMtlmFrF45rLooMdUlDqfxRahvHwC+IxCusGrAtFCHz7zJGGly61SsS5
         iDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCSFs2wsqNJ3bFCNyBwkye5Bq6faNmmLufS+mm/TQAE=;
        b=qlZLvyGy464MNwGJ+wiV8qdcKKYMK9rSLoKdLdVyzlVKkLtFjpoRoJoSeHmeC+orRr
         l6ZGMeihSXN7fq95efQA9A7o1Er+vVy/8SowAjWKfoKgNXgv0nE3qOjhLyUoK5f70Eob
         aUNazDSVE/nfK+Dsv34Jw3SJp5SnQgX7UGrDQyWtNzPLZ/vvHWey99xryQzqdM60IxmZ
         7QoHMBSpX/qI/eEUr69mfsCTVzBkS9U5N+0Yv3STJ4oxt6b8BAdn0icRlM/0HV9vIumE
         GQQYyuwQ7McmQg4n+GDAjangIkYaVNsSYsb3A4TtfbLLagAR79zX6G5Q/nlhf/DPPn/R
         83dQ==
X-Gm-Message-State: AOAM531WiRGCb6kfW/D6124GPCDOqolzDJBOl9OR/5Am0BOl25hdim68
        sj1F+RhlOI5piDgX2VNTVRzVVA==
X-Google-Smtp-Source: ABdhPJyKIF90NlCpvAlOolOko4CmRkVKPyLMJjr+0D9a9GA9qBmPJzm9JXWst0uuQVi63/Rc70grEQ==
X-Received: by 2002:a63:170a:: with SMTP id x10mr4639265pgl.305.1628789616423;
        Thu, 12 Aug 2021 10:33:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j22sm4242780pgb.62.2021.08.12.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:33:35 -0700 (PDT)
Date:   Thu, 12 Aug 2021 17:33:30 +0000
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
Message-ID: <YRVbamoQhvPmrEgK@google.com>
References: <20210812050717.3176478-1-seanjc@google.com>
 <20210812050717.3176478-3-seanjc@google.com>
 <CANgfPd8HSYZbqmi21XQ=XeMCndXJ0+Ld0eZNKPWLa1fKtutiBA@mail.gmail.com>
 <YRVVWC31fuZiw9tT@google.com>
 <928be04d-e60e-924c-1f3a-cb5fef8b0042@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <928be04d-e60e-924c-1f3a-cb5fef8b0042@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021, Paolo Bonzini wrote:
> On 12/08/21 19:07, Sean Christopherson wrote:
> > Yeah, I was/am on the fence too, I almost included a blurb in the cover letter
> > saying as much.  I'll do that for v2 and let Paolo decide.
> 
> I think it makes sense to have it.  You can even use the ternary operator

Hah, yeah, I almost used a ternary op.  Honestly don't know why I didn't, guess
my brain flipped a coin.

> 
> 	/*
> 	 * When zapping everything, all entries at the top level
> 	 * ultimately go away, and the levels below go down with them.
> 	 * So do not bother iterating all the way down to the leaves.

The subtle part is that try_step_down() won't actually iterate down because it
explicitly rereads and rechecks the SPTE.  

	if (iter->level == iter->min_level)
		return false;

	/*
	 * Reread the SPTE before stepping down to avoid traversing into page
	 * tables that are no longer linked from this entry.
	 */
	iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));  \
                                                                     ---> this is the code that is avoided
	child_pt = spte_to_child_pt(iter->old_spte, iter->level);   /
	if (!child_pt)
		return false;


My comment wasn't all that accurate either.  Maybe this?

	/*
	 * No need to try to step down in the iterator when zapping all SPTEs,
	 * zapping the top-level non-leaf SPTEs will recurse on their children.
	 */
	 int min_level = zap_all ? root->role.level : PG_LEVEL_4K;

> 	 */
> 	int min_level = zap_all ? root->role.level : PG_LEVEL_4K;
> 
> Paolo
> 
