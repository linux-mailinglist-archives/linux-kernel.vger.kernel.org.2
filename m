Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC038B961
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 00:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhETWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhETWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 18:11:59 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8976FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:10:36 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 191so18956534ybn.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cv+VF88O//9RPdfggPYjWdSdgDtDa86C3Ull6eQ/XI4=;
        b=hYsAuj2mIN+GveHmlUeIi8ZyqzPH8DvA+rMcytXdue4I82a9TNGqQWmW0P0qS8h02J
         dhGFUgryjsqhzpEMvKd4/H6kQxr5vO9+Rbi1id5TE0/PJAVOo4vkG0KquYivpaqJbbJA
         lu4xkjOfxGkz9LG+6bKgJTxVQ9FdOPO0ssMBUK5gMTzILplUzcgoYJNuZOpCAm5UVwXH
         P06Y293f9od02kqBouQtlbXDLwECiHiX8wWnccHOra31RyYdbKQI1CqNnKKa7VbJBhlR
         XcxZE5SU2CUSRzDw1Sdza9myU8pABv+9zkm+patPIf4Y0K/T61EGqHoqrFrCxfqjwaFe
         y70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cv+VF88O//9RPdfggPYjWdSdgDtDa86C3Ull6eQ/XI4=;
        b=UOoZcN7Wdhxk3BZnmVA6xqeUz3H7TlA5s/Mg1bxWsfC/Fnoh0JyIjj5fF3mszaxvbh
         9I7XKqFwEzn4I4tX2fTzDO9dID9QGDL49a7hgSPMw21o2Q/TnRmSBJeKrma8eP5GFO9T
         /6LfQOJde5UO5I9D6HvQM8ZeisZ8gYs59/tou3XhAFHap1AhvLY7WJc/mccu0HGgdOVo
         oJyh3B2H2B3LGDVVipJtnBfLX5bRNujmqYiEs7wJgbKzUz7gK8Q8R4bGTXMTB4yCOB+p
         gkqbfbAyNLE8trg464fT+8CxmiB2fPU5HjO4RiVJcEZ3HH9Ci7JcG93qwBMb01A07c27
         tvCQ==
X-Gm-Message-State: AOAM532oaL3cVZfk52NRPZ3sfKSNY/3BRp/WcYCcRG4r5/DMEIvOxt0b
        h+PR9YWQf4c8teLAeqzZzhg8R62ayGHUu0cWFqtS2w==
X-Google-Smtp-Source: ABdhPJz3gKhh5eo38dfQ8Q5auhgwe1OWL3SRpeb9Wg8+v/BWQ0fvUvVeAwyzzvRgylyi99uQkccRWgWKD2/EXgtIT24=
X-Received: by 2002:a25:9c88:: with SMTP id y8mr9621140ybo.294.1621548635461;
 Thu, 20 May 2021 15:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210430195232.30491-1-michel@lespinasse.org> <20210430224649.GA29203@lespinasse.org>
 <20210503181118.GA21048@lespinasse.org> <20210517175750.GJ4441@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210517175750.GJ4441@paulmck-ThinkPad-P17-Gen-1>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 May 2021 15:10:24 -0700
Message-ID: <CAJuCfpHD=GN2UMhbAhpp+UfvF0doBWcZDNx+u4RzcDezUW2+0g@mail.gmail.com>
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:57 AM Paul E. McKenney <paulmck@kernel.org> wrot=
e:
>
> On Mon, May 03, 2021 at 11:11:18AM -0700, Michel Lespinasse wrote:
> > On Fri, Apr 30, 2021 at 03:46:49PM -0700, Michel Lespinasse wrote:
> > > I- Maple tree
> > >
> > > I do not think there is any fundamental conflict between the maple
> > > tree patches currently being considered, and this patchset.
> > > I actually have a (very lightly tested) tree merging the two together=
,
> > > which was a fairly easy merge. For those interested, I made this
> > > available at my github, as the v5.12-maple-spf branch.
> >
> > People were still confused about it, so the instructions to fetch this =
are:
> > git fetch https://github.com/lespinasse/linux.git v5.12-maple-spf
>
> Finally getting around to actually testing this, apologies for the
> delay!
>
> Just checking to see if I am in the right place.  The warning below is
> easily fixed, but I figured that I should check.
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from ./include/linux/mmap_lock.h:10,
>                  from ./include/linux/mm.h:18,
>                  from ./include/linux/kallsyms.h:12,
>                  from ./include/linux/bpf.h:20,
>                  from ./include/linux/bpf-cgroup.h:5,
>                  from ./include/linux/cgroup-defs.h:22,
>                  from ./include/linux/cgroup.h:28,
>                  from ./include/linux/memcontrol.h:13,
>                  from ./include/linux/swap.h:9,
>                  from ./include/linux/suspend.h:5,
>                  from arch/x86/kernel/asm-offsets.c:13:
> ./include/linux/vmstat.h: In function =E2=80=98__mod_lruvec_page_state=E2=
=80=99:
> ./include/linux/vmstat.h:504:24: error: implicit declaration of function =
=E2=80=98page_pgdat=E2=80=99; did you mean =E2=80=98page_private=E2=80=99? =
[-Werror=3Dimplicit-function-declaration]
>   __mod_node_page_state(page_pgdat(page), idx, val);
>                         ^~~~~~~~~~
>                         page_private
> ./include/linux/vmstat.h:504:24: warning: passing argument 1 of =E2=80=98=
__mod_node_page_state=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
>   __mod_node_page_state(page_pgdat(page), idx, val);
>                         ^~~~~~~~~~~~~~~~
> ./include/linux/vmstat.h:267:28: note: expected =E2=80=98struct pglist_da=
ta *=E2=80=99 but argument is of type =E2=80=98int=E2=80=99
>  void __mod_node_page_state(struct pglist_data *, enum node_stat_item ite=
m, long);
>                             ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/vmstat.h: In function =E2=80=98mod_lruvec_page_state=E2=
=80=99:
> ./include/linux/vmstat.h:510:22: warning: passing argument 1 of =E2=80=98=
mod_node_page_state=E2=80=99 makes pointer from integer without a cast [-Wi=
nt-conversion]
>   mod_node_page_state(page_pgdat(page), idx, val);
>                       ^~~~~~~~~~~~~~~~
> ./include/linux/vmstat.h:275:26: note: expected =E2=80=98struct pglist_da=
ta *=E2=80=99 but argument is of type =E2=80=98int=E2=80=99
>  void mod_node_page_state(struct pglist_data *, enum node_stat_item, long=
);
>                           ^~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/kallsyms.h:12,
>                  from ./include/linux/bpf.h:20,
>                  from ./include/linux/bpf-cgroup.h:5,
>                  from ./include/linux/cgroup-defs.h:22,
>                  from ./include/linux/cgroup.h:28,
>                  from ./include/linux/memcontrol.h:13,
>                  from ./include/linux/swap.h:9,
>                  from ./include/linux/suspend.h:5,
>                  from arch/x86/kernel/asm-offsets.c:13:
> ./include/linux/mm.h: At top level:
> ./include/linux/mm.h:1568:26: error: conflicting types for =E2=80=98page_=
pgdat=E2=80=99
>  static inline pg_data_t *page_pgdat(const struct page *page)
>                           ^~~~~~~~~~
> In file included from ./include/linux/mmap_lock.h:10,
>                  from ./include/linux/mm.h:18,
>                  from ./include/linux/kallsyms.h:12,
>                  from ./include/linux/bpf.h:20,
>                  from ./include/linux/bpf-cgroup.h:5,
>                  from ./include/linux/cgroup-defs.h:22,
>                  from ./include/linux/cgroup.h:28,
>                  from ./include/linux/memcontrol.h:13,
>                  from ./include/linux/swap.h:9,
>                  from ./include/linux/suspend.h:5,
>                  from arch/x86/kernel/asm-offsets.c:13:
> ./include/linux/vmstat.h:504:24: note: previous implicit declaration of =
=E2=80=98page_pgdat=E2=80=99 was here
>   __mod_node_page_state(page_pgdat(page), idx, val);
>                         ^~~~~~~~~~
> cc1: some warnings being treated as errors

Hi Paul,
I promised you to look into this but somehow forgot to reply, sorry
about that. The issue is the new "#include <linux/mm_types.h>" in mm.h
which causes page_pgdat() usage before it is defined:

mm.h includes mm_types.h
mm_types.h includes vmstat.h
vmstat.h uses page_pgdat()
mm.h defines page_pgdat()

Not sure if this is the best way to fix it but this worked fine for me:

---
 include/linux/mmap_lock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 98f24a9910a9..13d4a706c0eb 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -7,7 +7,7 @@
 #include <linux/rwsem.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
-#include <linux/vmstat.h>
+#include <linux/vm_event_item.h>

 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 #define MMAP_LOCK_SEQ_INITIALIZER(name) \
@@ -113,6 +113,8 @@ static inline bool __mmap_seq_read_check(struct
mm_struct *mm,
 }

 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+static inline void count_vm_event(enum vm_event_item item);
+
 static inline bool mmap_seq_read_check(struct mm_struct *mm, unsigned long=
 seq,
         enum vm_event_item fail_event)
 {
--

Thanks,
Suren.
