Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B815B42BF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhJMMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhJMMOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:14:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 482A060ED4;
        Wed, 13 Oct 2021 12:12:39 +0000 (UTC)
Date:   Wed, 13 Oct 2021 14:12:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 2/2] mm: use pidfd_get_task()
Message-ID: <20211013121236.rydqx27bgzh67y4h@wittgenstein>
References: <20211011133245.1703103-1-brauner@kernel.org>
 <20211011133245.1703103-3-brauner@kernel.org>
 <b91f642b-2b64-a60c-89e2-0317164c7b70@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b91f642b-2b64-a60c-89e2-0317164c7b70@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 04:13:31PM +0200, David Hildenbrand wrote:
> On 11.10.21 15:32, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Instead of duplicating the same code in two places use the newly added
> > pidfd_get_task() helper. This fixes an (unimportant for now) bug where
> > PIDTYPE_PID is used whereas PIDTYPE_TGID should have been used.
> 
> What would have been the effect of the BUG? Is it worth Fixes: or better

Right now, there's no issue. I hope my "unimportant for now" gets that
across.
Retrieving it via PIDTYPE_PID or PIDTYPE_TGID doesn't matter right now
because at pidfd creation time we ensure that:
- the pid used with pidfd_open()
- the task created via clone{3}()'s CLONE_PIDFD
are used as PIDTYPE_TGID, i.e. the struct pid the pidfd references is
used as PIDTYPE_TGID, i.e. is a thread-group leader.
The concern is for the future were we may want to enable pidfds to refer
to individual threads. Once that happens the passed in pidfd to e.g.
process_mrelease() or process_madvise() can refer to a struct pid that
is only used as PIDTYPE_PID and not as PIDTYPE_TGID, i.e. it might be a
pidfd refering to a non-threadgroup leader. Once that happens we want to
make sure that all users of pidfds are ok working with non-threadgroup
leaders. If we have on central helper that becomes a relatively simple
exercise in grepping and we're sure that all current callers use
PIDTYPE_TGID as they're using the helper. If we let places use
PIDTYPE_PID or PIDTYPE_TGID interchangeably this becomes a more arduous
task. So in a sense it's a bug-in-the-making. It's arguably fixes the
addition of process_mrelease() since I mentioned this pretty early on
and requested the addition of a helper as part of the patchset. I think
it just got lost in the reviews though.

> even separating out the fix?
> 
> > 
> > Link: https://lore.kernel.org/r/20211004125050.1153693-3-christian.brauner@ubuntu.com
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Matthew Bobrowski <repnop@google.com>
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Reviewed-by: Matthew Bobrowski <repnop@google.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */
> > unchanged
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!
Christian
