Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B553BF134
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhGGVJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:09:00 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44998 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhGGVI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:08:57 -0400
Received: by mail-io1-f48.google.com with SMTP id q2so5374729iot.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 14:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+0wM/2+93HPOOZpIMUtQMPBQcZGKatuACzxxoFN87Do=;
        b=jMmJ0yxNZyWDdhSr1C5LMLiFUP00Ctx0RdETkaHxbXeVDZbTdZXS5ftYnC+vAHa8mM
         aWcq51s2abKpxIYOZZCDSO7t3omso8I6+qpI2qjW43qKBrC/PHTUqD4drn36ABQRiYH7
         7T1krUjULVWETsTnQ2aHG/5vh6ELnMQ8x8zt7mkv+9ZxY958Cr63vlYaKUQIKtcJYoTG
         OCzitpIuFrlBgRob8uROIY7kNQuVLXT0Ags4MN6+QFkA7OMJnfsXaHerr0p59PvuXZ7S
         Dh665qkxnkn0uWOBRS4JVit3jp2SVB18nH3qozzXsgXKqaJ051PoQ+C8W2oqAgmt9TbJ
         Sqtg==
X-Gm-Message-State: AOAM533iNAuf7cR8G7wN7nfz6l7EHeumrN72sEk6Cx5gxDWexUS3t9Z0
        ZjkXQg2jvdG6j3s+yFG3bVU=
X-Google-Smtp-Source: ABdhPJxeTrGLZn2M7PhsKro+3iFOnM2bXcS3AptZckdRj5vtaqs5UD3Yn1wmRIRpoNQMl8O7LtrGhA==
X-Received: by 2002:a02:cd1a:: with SMTP id g26mr11273707jaq.38.1625691976865;
        Wed, 07 Jul 2021 14:06:16 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id k5sm10203ilu.70.2021.07.07.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:06:16 -0700 (PDT)
Date:   Wed, 7 Jul 2021 21:06:15 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] percpu fixes for v5.14-rc1
Message-ID: <YOYXR3SK/8fwJ/To@google.com>
References: <YOWld9O5CZpzOUKA@google.com>
 <CAHk-=wgMnammhbrevngFKwP31k9fO2npok26XnVCR0B3HJOUqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMnammhbrevngFKwP31k9fO2npok26XnVCR0B3HJOUqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 11:40:45AM -0700, Linus Torvalds wrote:
> On Wed, Jul 7, 2021 at 6:00 AM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > This is just a single change to fix percpu depopulation. The code relied
> > on depopulation code written specifically for the free path and relied
> > on vmalloc to do the tlb flush lazily. As we're modifying the backing
> > pages during the lifetime of a chunk, we need to also flush the tlb
> > accordingly.
> 
> I pulled this, but I ended up unpulling after looking at the fix.
> 
> The fix may be perfectly correct, but I'm looking at that
> pcpu_reclaim_populated() function, and I want somebody to explain to
> me what it's ok to drop and re-take the 'pcpu_lock' and just continue.
> 
> Because whatever it was protecting is now not protected any more.
> 
> It *looks* like it's intended to protect the pcpu_chunk_lists[]
> content, and some other functions that do this look ok. So for
> example, pcpu_balance_free() at least removes the 'chunk' from the
> pcpu_chunk_lists[] before it drops the lock and then works on the
> chunk contents.
> 
> But pcpu_reclaim_populated() seems to *leave* chunk on the
> pcpu_chunk_lists[], drop the lock, and then continue to use 'chunk'.
> 
> That odd "release lock and continue to use the data it's supposed to
> protect" seems to be pre-existing, but
> 
>  (a) this is the code that caused problems to begin with
> 
> and
> 
>  (b) it seems to now happen even more.
> 
> So maybe this code is right. But it looks very odd to me, and I'd like
> to get more explanations of _why_ it would be ok before I pull this
> fix, since there seems to be a deeper underlying problem in the code
> that this tries to fix.
> 

Yeah I agree. I think I've inadvertently made this more complex than it
needs to be and intend to clean it up.

Percpu has a mutex lock and spinlock. The mutex lock is responsible for
lifetime of a chunk and correctness of the backing pages,
chunk->populated[]. The spinlock protects the other members of the chunk
as well as pcpu_chunk_lists[].

The pcpu_balance_workfn() is used to serialize the freeing of chunks and
maintenance of a floating # of pages to suffice atomic allocations. This
is where depopulation is being bolted onto. It uses the serialization
of:
  mutex_lock(&pcpu_alloc_mutex);
  pcpu_balance_free()
  pcpu_reclaim_populated()
  pcpu_balance_populated()
  mutex_unlock(&pcpu_alloc_mutex);

while holding the mutex lock to know that the chunk we are modifying
will not be freed. It's this that makes it okay to just pick up the lock
and continue.

Depopulation adds complexity to the lifecycle of a chunk through others
freeing back percpu allocations. So, unlike pcpu_balance_free(), taking
the chunk off of pcpu_chunk_lists[] doesn't guarantee someone else isn't
accessing the chunk because they are freeing an object back.

To handle this, a notion of isolated chunks is introduced and these
chunks become effectively hidden to the allocation path. We are also
holding the mutex lock throughout this process which prevents the
allocation path from simultaenously adding backing pages to a chunk.

I hope this explanation makes sense.

Thanks,
Dennis
