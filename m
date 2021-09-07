Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1B402FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbhIGU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346879AbhIGU0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531E261152;
        Tue,  7 Sep 2021 20:25:39 +0000 (UTC)
Date:   Tue, 7 Sep 2021 16:25:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] mmap_lock: Change trace and locking order
Message-ID: <20210907162537.27cbf082@gandalf.local.home>
In-Reply-To: <20210907201456.4036910-1-Liam.Howlett@oracle.com>
References: <20210907201456.4036910-1-Liam.Howlett@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021 20:15:19 +0000
Liam Howlett <liam.howlett@oracle.com> wrote:

> The ordering of the printed messages from the mmap_lock trace can occur
> out of order.  This results in confusing trace logs such as:
> 
> task          cpu     atomic counter: message
> ---------------------------------------------
> task-749     [006] ....     14437980: mmap_lock_acquire_returned: mm=00000000c94d28b8 memcg_path= write=true success=true
> task-750     [007] ....     14437981: mmap_lock_acquire_returned: mm=00000000c94d28b8 memcg_path= write=true success=true
> task-749     [006] ....     14437983: mmap_lock_released: mm=00000000c94d28b8 memcg_path= write=true
> 
> When the actual series of evens are as follows:
> 
> task-749     [006]  mmap_lock_acquire_returned: mm=00000000c94d28b8 memcg_path= write=true success=true
> task-749     [006]  mmap_lock_released: mm=00000000c94d28b8 memcg_path= write=true
> 
> task-750     [007]  mmap_lock_acquire_returned: mm=00000000c94d28b8 memcg_path= write=true success=true
> 
> The incorrect ordering of the trace log happens because the release log
> is outside of the lock itself.  The ordering can be guaranteed by
> protecting the acquire success and release trace logs by the lock.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

FYI,

If you received Acks for a patch, and you resend just to update the change
log, you can then include those acks in that email, as the acks were
already done for the code change. If you change the code, you may need to
ask to get the review/acks again.

But since this time you only changed the change log, and the code is still
the same, you should have included:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>

-- Steve



> ---
>  include/linux/mmap_lock.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 0540f0156f58..b179f1e3541a 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -101,14 +101,14 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
>  
>  static inline void mmap_write_unlock(struct mm_struct *mm)
>  {
> -	up_write(&mm->mmap_lock);
>  	__mmap_lock_trace_released(mm, true);
> +	up_write(&mm->mmap_lock);
>  }
>  
>  static inline void mmap_write_downgrade(struct mm_struct *mm)
>  {
> -	downgrade_write(&mm->mmap_lock);
>  	__mmap_lock_trace_acquire_returned(mm, false, true);
> +	downgrade_write(&mm->mmap_lock);
>  }
>  
>  static inline void mmap_read_lock(struct mm_struct *mm)
> @@ -140,8 +140,8 @@ static inline bool mmap_read_trylock(struct mm_struct *mm)
>  
>  static inline void mmap_read_unlock(struct mm_struct *mm)
>  {
> -	up_read(&mm->mmap_lock);
>  	__mmap_lock_trace_released(mm, false);
> +	up_read(&mm->mmap_lock);
>  }
>  
>  static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
> @@ -155,8 +155,8 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
>  
>  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>  {
> -	up_read_non_owner(&mm->mmap_lock);
>  	__mmap_lock_trace_released(mm, false);
> +	up_read_non_owner(&mm->mmap_lock);
>  }
>  
>  static inline void mmap_assert_locked(struct mm_struct *mm)

