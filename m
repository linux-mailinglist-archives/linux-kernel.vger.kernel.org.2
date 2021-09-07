Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289F7402D37
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbhIGQyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344220AbhIGQyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:54:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 142AE610A3;
        Tue,  7 Sep 2021 16:53:11 +0000 (UTC)
Date:   Tue, 7 Sep 2021 12:53:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mmap_lock: Change trace and locking order
Message-ID: <20210907125309.7af5cd19@gandalf.local.home>
In-Reply-To: <c2fc9aff-4275-3025-fced-83c0f69e69b1@suse.cz>
References: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
        <c2fc9aff-4275-3025-fced-83c0f69e69b1@suse.cz>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2021 17:00:18 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 9/3/21 04:21, Liam Howlett wrote:
> > Print to the trace log before releasing the lock to avoid racing with
> > other trace log printers of the same lock type.  
> 
> That description could use more details maybe?

Agreed, perhaps add something like this:

Due to the tracing of taking the mmap_lock happened outside the lock
itself, the trace can become confusing, making it look like more than one
task has the same lock:

     task-749     [006] ....     14437980: mmap_lock_acquire_returned: mm=00000000c94d28b8 memcg_path= write=true success=true
     task-750     [007] ....     14437981: mmap_lock_acquire_returned: mm=00000000c94d28b8 memcg_path= write=true success=true
     task-749     [006] ....     14437983: mmap_lock_released: mm=00000000c94d28b8 memcg_path= write=true

When in actuality the following occurred:

   task-749 [006] - take mmap_lock
   task-749 [006] - trace taking of mmap_lock
   task-749 [006] - release mmap_lock

   task-750 [007] - take mmap_lock
   task-750 [007] - trace taking of mmap_lock

   task-749 [006] - trace releasing of mmap_lock

Although the mmap_lock was taken and released then taken again by another
process, the lack of protection around the tracing of the activity caused
it to show the events out of order. If the tracing of the taking and
releasing of the mmap_lock is done inside the lock, it will protect this
from happening.

Andrew, I see you took this into your tree. Not sure if you sent it to
Linus yet. Perhaps add the above to the patch if you have not yet sent it
(with Liam's permission of course).

Seeing that the patch has this as a link in the commit, at the very least,
the above explanation will be archived.

-- Steve



> 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

