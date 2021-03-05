Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F332F07E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCEQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230387AbhCEQ7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:59:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B31D64F1E;
        Fri,  5 Mar 2021 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614963551;
        bh=Anr2szlxokrML4bcZ0Hk4njlruTj6i3bBKAsz8Ik/i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUPrT4WrxDvcA5waC/JCToBDhp1Kk6d3fuhFTFtApJbxl0DgugRoL98HlHKCN+L7k
         tDU5jCwdV+7H8hoi0mdwLKsCb6Sb6+QgoyLpevCgAngM79HAAGqMdDWgx6G4KN1p0z
         3jQAWjeCtBm8z+uq76vuvHzUu3XyyM/ucb1oWgdgFZeql/ibvBWxASXsCw5Ya/5Bj9
         66KUukox4oZMKGGxtCD3+ISsnUhlVKb4PZPuMde71ut26Ojz2C/0qfpL0Lex4NeBt9
         /cwZFHGTuCvZyl0jAguHl1gtlz88pIRcTXtKzXA0H3PgovHmIkSq6dLJSpA1aSfQur
         Wkmsn/I2oG+ZQ==
Date:   Fri, 5 Mar 2021 16:59:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 28/32] KVM: arm64: Add
 kvm_pgtable_stage2_idmap_greedy()
Message-ID: <20210305165904.GA23172@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-29-qperret@google.com>
 <20210305143941.GA23017@willie-the-truck>
 <YEJISCQOHNbs363+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEJISCQOHNbs363+@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 03:03:36PM +0000, Quentin Perret wrote:
> On Friday 05 Mar 2021 at 14:39:42 (+0000), Will Deacon wrote:
> > On Tue, Mar 02, 2021 at 02:59:58PM +0000, Quentin Perret wrote:
> > > +	/* Reduce the kvm_mem_range to a granule size */
> > > +	ret = __stage2_reduce_range(&data, range->end);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Walk the range to check permissions and reduce further if needed */
> > > +	do {
> > > +		ret = kvm_pgtable_walk(pgt, range->start, range->end, &walker);
> > 
> > (we spent some time debugging an issue here and you spotted that you're
> > passing range->end instead of the size ;)
> 
> Yep, I have the fix applied locally, and ready to fly in v4 :)
> 
> > > +	} while (ret == -EAGAIN);
> > 
> > I'm a bit nervous about this loop -- what guarantees forward progress here?
> > Can we return to the host after a few tries instead?
> 
> -EAGAIN only happens when we've been able to successfully reduce the
> range to a potentially valid granule size. That can't happen infinitely.
> 
> We're guaranteed to fail when trying to reduce the range to a
> granularity smaller than PAGE_SIZE (the -EINVAL case of
> __stage2_reduce_range), which is indicative of a host memory abort in a
> page it should not access (because marked PROT_NONE for instance).

Can you compute an upper bound on the number of iterations based on the
number of page-table levels then? I'm just conscious that all of this is
effectively running with irqs disabled, and so being able to reason about
the amount of work we're going to do makes me much more comfortable.

Will
