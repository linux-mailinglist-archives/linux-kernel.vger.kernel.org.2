Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB93DBF58
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhG3UDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhG3UDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:03:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D663E60F46;
        Fri, 30 Jul 2021 20:03:26 +0000 (UTC)
Date:   Fri, 30 Jul 2021 16:03:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints
Message-ID: <20210730160319.6dfeaf7a@oasis.local.home>
In-Reply-To: <585f936d-9d27-a481-f590-bd07f98f34de@bytedance.com>
References: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
        <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
        <585f936d-9d27-a481-f590-bd07f98f34de@bytedance.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 13:32:12 +0800
Gang Li <ligang.bdlg@bytedance.com> wrote:

> Thanks! I have tried your suggestion. They are great, especially 
> synthetic-events.
> 
> If don't print ip per event, we can only guess which one cause the 
> contention by "hitcount".
> 
>  >   
> (https://www.kernel.org/doc/html/latest/trace/histogram.html#synthetic-events)
> 
> But it seems that they only support histogram, can I print the
> synthetic-events args per event in /sys/kernel/debug/tracing/trace
> like other events? I haven't found that in kernel doc.

Yes, synthetic events are just like normal events, and have triggers,
stack traces, and do pretty much anything that another event can do.

I'm just finishing up a libtracfs called tracefs_sql() (hopefully
posting it today), that allows you to create a synthetic event via an
SQL statement. But I don't think this is what you are looking for.

What about using function tracing? Because the tracepoint is called
from __mmap_lock* helper functions that function tracer can see, you
can just do the following:

 # trace-cmd start -e mmap_lock -p function -l '__mmap_lock_*' 
 # trace-cmd show
[..]
       trace-cmd-1840    [006] ....   194.576801: __mmap_lock_do_trace_start_locking <-do_user_addr_fault
       trace-cmd-1840    [006] ...1   194.576805: mmap_lock_start_locking: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false

       trace-cmd-1840    [006] ....   194.576806: __mmap_lock_do_trace_acquire_returned <-do_user_addr_fault
       trace-cmd-1840    [006] ...1   194.576807: mmap_lock_acquire_returned: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false success=true

       trace-cmd-1840    [006] ....   194.576811: __mmap_lock_do_trace_released <-do_user_addr_fault
       trace-cmd-1840    [006] ...1   194.576812: mmap_lock_released: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false

       trace-cmd-1840    [006] ....   194.576815: __mmap_lock_do_trace_start_locking <-do_user_addr_fault
       trace-cmd-1840    [006] ...1   194.576816: mmap_lock_start_locking: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false

       trace-cmd-1840    [006] ....   194.576816: __mmap_lock_do_trace_acquire_returned <-do_user_addr_fault
       trace-cmd-1840    [006] ...1   194.576817: mmap_lock_acquire_returned: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false success=true

       trace-cmd-1840    [006] ....   194.576820: __mmap_lock_do_trace_released <-do_user_addr_fault
       trace-cmd-1840    [006] ...1   194.576821: mmap_lock_released: mm=000000006515cb1f memcg_path=/user.slice/user-0.slice/session-2.scope write=false


This looks exactly like the robots you are looking for.

-- Steve
