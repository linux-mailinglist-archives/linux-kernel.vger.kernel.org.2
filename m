Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE89C337928
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhCKQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:21:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:51026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhCKQUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:20:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615479631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCazLcUvicbjHvArKpub7shZHTSmNlrKDPwSJp39RjQ=;
        b=Ot+ZpznoDen4a6aIAaDKNvpnzNFuDCDrWlV6RxRWng0vBUfuagjC2NN8PIUPzyWhY4bYCJ
        qEdX5hhKL94mGWtpYY2cIXfdaqMz0pcbUJi/ftU5nOM/E9ijf8CJZetQ9JtN25oi2yg2T4
        ki3UmPhLnI1fvsmeZ9Pjp5HNpCe/esM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43B9EAC16;
        Thu, 11 Mar 2021 16:20:31 +0000 (UTC)
Date:   Thu, 11 Mar 2021 17:20:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: Re: [PATCH] mm/oom_kill: Ensure MMU notifier range_end() is paired
 with range_start()
Message-ID: <YEpDJ/pPioG9ndYX@dhcp22.suse.cz>
References: <20210310213117.1444147-1-seanjc@google.com>
 <20210311002807.GQ444867@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311002807.GQ444867@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-03-21 20:28:07, Jason Gunthorpe wrote:
> On Wed, Mar 10, 2021 at 01:31:17PM -0800, Sean Christopherson wrote:
> > Invoke the MMU notifier's .invalidate_range_end() callbacks even if one
> > of the .invalidate_range_start() callbacks failed.  If there are multiple
> > notifiers, the notifier that did not fail may have performed actions in
> > its ...start() that it expects to unwind via ...end().  Per the
> > mmu_notifier_ops documentation, ...start() and ...end() must be paired.
> 
> No this is not OK, if invalidate_start returns EBUSY invalidate_end
> should *not* be called.

Yes, this is what I remember when introducing nonblock interface. So I
agree with Jason this patch is not correct. The interface is subtle but
I remember we couldn't come up with something more robust and still
memory with notifiers to be reapable.
-- 
Michal Hocko
SUSE Labs
