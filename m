Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF42D33685A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCKAGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:06:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhCKAGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:06:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B832064E33;
        Thu, 11 Mar 2021 00:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615421173;
        bh=qIPv+EoOptfJXUMF6cMDeGl3znse9/XkHNkaEbNi/wo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f0b8REnlxOBN8ozqESJf7N3DVplCLI7jYw+q348zHSIhwQCfrfsFtNd23ZY45OI+o
         fkVBWygiVgNKmtF4zeg5tO/6shw5cXu+7/3RPweYzJQNssPQJExGppZwYYsx4C4pwT
         mR5/Nop6DsNFsOxtV9y2TdB5VCiKrEvY0J9EEbG0=
Date:   Wed, 10 Mar 2021 16:06:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>,
        =?ISO-8859-1?Q? "J=E9r=F4m?= =?ISO-8859-1?Q?e_Glisse" ?= 
        <jglisse@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: Re: [PATCH] mm/oom_kill: Ensure MMU notifier range_end() is paired
 with range_start()
Message-Id: <20210310160612.dd57fcc60cbc4cc4bf86b869@linux-foundation.org>
In-Reply-To: <20210310213117.1444147-1-seanjc@google.com>
References: <20210310213117.1444147-1-seanjc@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 13:31:17 -0800 Sean Christopherson <seanjc@google.com> wrote:

> Invoke the MMU notifier's .invalidate_range_end() callbacks even if one
> of the .invalidate_range_start() callbacks failed.  If there are multiple
> notifiers, the notifier that did not fail may have performed actions in
> its ...start() that it expects to unwind via ...end().  Per the
> mmu_notifier_ops documentation, ...start() and ...end() must be paired.
> 
> The only in-kernel usage that is fatally broken is the SGI UV GRU driver,
> which effectively blocks and sleeps fault handlers during ...start(), and
> unblocks/wakes the handlers during ...end().  But, the only users that
> can fail ...start() are the i915 and Nouveau drivers, which are unlikely
> to collide with the SGI driver.
> 
> KVM is the only other user of ...end(), and while KVM also blocks fault
> handlers in ...start(), the fault handlers do not sleep and originate in
> killable ioctl() calls.  So while it's possible for the i915 and Nouveau
> drivers to collide with KVM, the bug is benign for KVM since the process
> is dying and KVM's guest is about to be terminated.
> 
> So, as of today, the bug is likely benign.  But, that may not always be
> true, e.g. there is a potential use case for blocking memslot updates in
> KVM while an invalidation is in-progress, and failure to unblock would
> result in said updates being blocked indefinitely and hanging.
> 
> Found by inspection.  Verified by adding a second notifier in KVM that
> periodically returns -EAGAIN on non-blockable ranges, triggering OOM,
> and observing that KVM exits with an elevated notifier count.

Given that there's no way known of triggering this in 5.11 or earlier,
I'd normally question the need to backport into -stable kernels.

But I guess that people might later develop modules which they want to
load into earlier kernels, in which case this might bite them.  So I
agree on the cc:stable thing.


