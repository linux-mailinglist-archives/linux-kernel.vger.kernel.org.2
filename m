Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31F041C02A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244369AbhI2HyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:54:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38890 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbhI2Hx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:53:59 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4FCAA1FFD5;
        Wed, 29 Sep 2021 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632901938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKJATqPQedgRX5cal1JGI6obKkcGL2h8yUla7SJy7q0=;
        b=iv2c9afdPj+6JUZRul0C2M5dm763OJMphokNYaCglmBOODSydDJhJLnhe9+JCVRGEOLzay
        Jykvm0RGzK+S1GUMktE39PiLhRyNuMosnt0dRav3nsBBZWhTnHwvIpMOnFaAaaNK+o4GNo
        QwNihs3cuG1J2MQ4/X5xZSywHcXjb6o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id CD9B325D4F;
        Wed, 29 Sep 2021 07:52:17 +0000 (UTC)
Date:   Wed, 29 Sep 2021 09:52:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
Message-ID: <YVQbMREcRaCbUaUv@dhcp22.suse.cz>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <YVG2DJx9t6FGr4kX@dhcp22.suse.cz>
 <0FC3F99A-9F77-484A-899B-EDCBEFBFAC5D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0FC3F99A-9F77-484A-899B-EDCBEFBFAC5D@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-09-21 12:12:46, Nadav Amit wrote:
> 
> > On Sep 27, 2021, at 5:16 AM, Michal Hocko <mhocko@suse.com> wrote:
> > 
> > On Mon 27-09-21 05:00:11, Nadav Amit wrote:
> > [...]
> >> The manager is notified on memory regions that it should monitor
> >> (through PTRACE/LD_PRELOAD/explicit-API). It then monitors these regions
> >> using the remote-userfaultfd that you saw on the second thread. When it wants
> >> to reclaim (anonymous) memory, it:
> >> 
> >> 1. Uses UFFD-WP to protect that memory (and for this matter I got a vectored
> >>   UFFD-WP to do so efficiently, a patch which I did not send yet).
> >> 2. Calls process_vm_readv() to read that memory of that process.
> >> 3. Write it back to “swap”.
> >> 4. Calls process_madvise(MADV_DONTNEED) to zap it.
> > 
> > Why cannot you use MADV_PAGEOUT/MADV_COLD for this usecase?
> 
> Providing hints to the kernel takes you so far to a certain extent.
> The kernel does not want to (for a good reason) to be completely
> configurable when it comes to reclaim and prefetch policies. Doing
> so from userspace allows you to be fully configurable.

I am sorry but I do not follow. Your scenario is describing a user
space driven reclaim. Something that MADV_{COLD,PAGEOUT} have been
designed for. What are you missing in the existing functionality?

> > MADV_DONTNEED on a remote process has been proposed in the past several
> > times and it has always been rejected because it is a free ticket to all
> > sorts of hard to debug problems as it is just a free ticket for a remote
> > memory corruption. An additional capability requirement might reduce the
> > risk to some degree but I still do not think this is a good idea.
> 
> I would argue that there is nothing bad that remote MADV_DONTNEED can do
> that process_vm_writev() cannot do as well (putting aside ptrace).

I am not arguing this would be the first syscall to allow tricky and
hard to debug corruptions if used without care.

> process_vm_writev() is checking:
> 
> 	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS)
> 
> Wouldn't adding such a condition suffice?

This would be a minimum requirement. Another one is a sensible usecase
that is not covered by an existing functionality.

-- 
Michal Hocko
SUSE Labs
