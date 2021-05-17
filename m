Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE88383BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhEQR7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242168AbhEQR7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:59:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ECED610CD;
        Mon, 17 May 2021 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621274270;
        bh=OGU0kqJS/umyUFSB371IfYj/QH95engzAVRM/ksbiSk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SvsYm2KmBaMy/cik0OlsNfoG+xrkOuE3d4VnWk7POoqQUV+ADQYPwlaEyNYdz5dhH
         LV3pVE5UAT6Bh9CCfcjLGQC77VffM+8+A8PlQm8rcIMhbajLUobeVYfBxw3H7UW4S2
         16H5WscPxr0K4OuR4VAQWVscgNjkUpGTcWKzyxHbaoQt7kvWgguo8K/qtdExBTPJwy
         fyemF1m+fRLX34Eljjr7PfpyGiO2lhxk+X4DFsxJ/AticgzK72MYomJPCQH7mWvOyU
         DsiZVMBw8HsJaEf91TqXO8SW1BGhA4DChr6NwzGlyzAd2Jg8NeA7kQVwagB+U2Hk3n
         0iU7SRUSkC88A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0DBF35C00C6; Mon, 17 May 2021 10:57:50 -0700 (PDT)
Date:   Mon, 17 May 2021 10:57:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
Message-ID: <20210517175750.GJ4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210430195232.30491-1-michel@lespinasse.org>
 <20210430224649.GA29203@lespinasse.org>
 <20210503181118.GA21048@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503181118.GA21048@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 11:11:18AM -0700, Michel Lespinasse wrote:
> On Fri, Apr 30, 2021 at 03:46:49PM -0700, Michel Lespinasse wrote:
> > I- Maple tree
> > 
> > I do not think there is any fundamental conflict between the maple
> > tree patches currently being considered, and this patchset.
> > I actually have a (very lightly tested) tree merging the two together,
> > which was a fairly easy merge. For those interested, I made this
> > available at my github, as the v5.12-maple-spf branch.
> 
> People were still confused about it, so the instructions to fetch this are:
> git fetch https://github.com/lespinasse/linux.git v5.12-maple-spf

Finally getting around to actually testing this, apologies for the
delay!

Just checking to see if I am in the right place.  The warning below is
easily fixed, but I figured that I should check.

							Thanx, Paul

------------------------------------------------------------------------

  CC      arch/x86/kernel/asm-offsets.s
In file included from ./include/linux/mmap_lock.h:10,
                 from ./include/linux/mm.h:18,
                 from ./include/linux/kallsyms.h:12,
                 from ./include/linux/bpf.h:20,
                 from ./include/linux/bpf-cgroup.h:5,
                 from ./include/linux/cgroup-defs.h:22,
                 from ./include/linux/cgroup.h:28,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:13:
./include/linux/vmstat.h: In function ‘__mod_lruvec_page_state’:
./include/linux/vmstat.h:504:24: error: implicit declaration of function ‘page_pgdat’; did you mean ‘page_private’? [-Werror=implicit-function-declaration]
  __mod_node_page_state(page_pgdat(page), idx, val);
                        ^~~~~~~~~~
                        page_private
./include/linux/vmstat.h:504:24: warning: passing argument 1 of ‘__mod_node_page_state’ makes pointer from integer without a cast [-Wint-conversion]
  __mod_node_page_state(page_pgdat(page), idx, val);
                        ^~~~~~~~~~~~~~~~
./include/linux/vmstat.h:267:28: note: expected ‘struct pglist_data *’ but argument is of type ‘int’
 void __mod_node_page_state(struct pglist_data *, enum node_stat_item item, long);
                            ^~~~~~~~~~~~~~~~~~~~
./include/linux/vmstat.h: In function ‘mod_lruvec_page_state’:
./include/linux/vmstat.h:510:22: warning: passing argument 1 of ‘mod_node_page_state’ makes pointer from integer without a cast [-Wint-conversion]
  mod_node_page_state(page_pgdat(page), idx, val);
                      ^~~~~~~~~~~~~~~~
./include/linux/vmstat.h:275:26: note: expected ‘struct pglist_data *’ but argument is of type ‘int’
 void mod_node_page_state(struct pglist_data *, enum node_stat_item, long);
                          ^~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/kallsyms.h:12,
                 from ./include/linux/bpf.h:20,
                 from ./include/linux/bpf-cgroup.h:5,
                 from ./include/linux/cgroup-defs.h:22,
                 from ./include/linux/cgroup.h:28,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:13:
./include/linux/mm.h: At top level:
./include/linux/mm.h:1568:26: error: conflicting types for ‘page_pgdat’
 static inline pg_data_t *page_pgdat(const struct page *page)
                          ^~~~~~~~~~
In file included from ./include/linux/mmap_lock.h:10,
                 from ./include/linux/mm.h:18,
                 from ./include/linux/kallsyms.h:12,
                 from ./include/linux/bpf.h:20,
                 from ./include/linux/bpf-cgroup.h:5,
                 from ./include/linux/cgroup-defs.h:22,
                 from ./include/linux/cgroup.h:28,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:13:
./include/linux/vmstat.h:504:24: note: previous implicit declaration of ‘page_pgdat’ was here
  __mod_node_page_state(page_pgdat(page), idx, val);
                        ^~~~~~~~~~
cc1: some warnings being treated as errors
