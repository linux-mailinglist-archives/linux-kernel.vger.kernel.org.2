Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC04C3621F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244517AbhDPOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:18:37 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:40612 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbhDPOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:18:36 -0400
Received: by mail-io1-f47.google.com with SMTP id e186so27831707iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w0G38QrpTF9MzxLWljSX9jB3Wbky6X+aYyRCi5ivhBQ=;
        b=qevJaupITJHUtNsiL+1NtrNo6FUJWQMf5TUqcks/JCfvQCFeVDLbrDUmMR75n8kLJT
         4FhgVhas+N5dyCDWbbmkWo4No5eP1m5xCOjbWzl3EdQjtqblB/Qxqjt+LgzptDbrC5fk
         +8rtwUtMIBP4IploUcDSNns/Gk6WbbZuZuBKRm+cpAiVBfq5DlXxdBdZdx6zm9bUUeue
         Biaenu628wHHqi/65tnWd1Y2E2Vwhl6YTMNe/37dTkPKbP4NnQV0JG/F12UdeUAmlwYO
         +kMevnRwD8diwfXCZnocoM5bLpqKytoCeiFfWCyGmQWMq2bxIGt+ikWOCmCJ6a7JWxv0
         H4Rg==
X-Gm-Message-State: AOAM5329Q+1WkBsOhARGrWGQjTjxWRpJBxSF7RqFxrG49otN6oUfqKxB
        n8Gt2DI0kpHCU0B1SZutw5o=
X-Google-Smtp-Source: ABdhPJzr//Wvbj6gzK9N85FCZkc9Q5EEvcu4lbI/lhVYJMcTXpxwfE/K3x1EMefnhAIJoG1qSBasBQ==
X-Received: by 2002:a5e:c117:: with SMTP id v23mr3681418iol.54.1618582691852;
        Fri, 16 Apr 2021 07:18:11 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d16sm2761964ils.48.2021.04.16.07.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:18:11 -0700 (PDT)
Date:   Fri, 16 Apr 2021 14:18:10 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pratik.r.sampat@gmail.com
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
Message-ID: <YHmcorqNE5NpAN3G@google.com>
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
> Hello Roman,
> 
> I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
> 
> My results of the percpu_test are as follows:
> Intel KVM 4CPU:4G
> Vanilla 5.12-rc6
> # ./percpu_test.sh
> Percpu:             1952 kB
> Percpu:           219648 kB
> Percpu:           219648 kB
> 
> 5.12-rc6 + with patchset applied
> # ./percpu_test.sh
> Percpu:             2080 kB
> Percpu:           219712 kB
> Percpu:            72672 kB
> 
> I'm able to see improvement comparable to that of what you're see too.
> 
> However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
> 
> POWER9 KVM 4CPU:4G
> Vanilla 5.12-rc6
> # ./percpu_test.sh
> Percpu:             5888 kB
> Percpu:           118272 kB
> Percpu:           118272 kB
> 
> 5.12-rc6 + with patchset applied
> # ./percpu_test.sh
> Percpu:             6144 kB
> Percpu:           119040 kB
> Percpu:           119040 kB
> 
> I'm wondering if there's any architectural specific code that needs plumbing
> here?
> 

There shouldn't be. Can you send me the percpu_stats debug output before
and after?

> I will also look through the code to find the reason why POWER isn't
> depopulating pages.
> 
> Thank you,
> Pratik
> 
> On 08/04/21 9:27 am, Roman Gushchin wrote:
> > In our production experience the percpu memory allocator is sometimes struggling
> > with returning the memory to the system. A typical example is a creation of
> > several thousands memory cgroups (each has several chunks of the percpu data
> > used for vmstats, vmevents, ref counters etc). Deletion and complete releasing
> > of these cgroups doesn't always lead to a shrinkage of the percpu memory,
> > so that sometimes there are several GB's of memory wasted.
> > 
> > The underlying problem is the fragmentation: to release an underlying chunk
> > all percpu allocations should be released first. The percpu allocator tends
> > to top up chunks to improve the utilization. It means new small-ish allocations
> > (e.g. percpu ref counters) are placed onto almost filled old-ish chunks,
> > effectively pinning them in memory.
> > 
> > This patchset solves this problem by implementing a partial depopulation
> > of percpu chunks: chunks with many empty pages are being asynchronously
> > depopulated and the pages are returned to the system.
> > 
> > To illustrate the problem the following script can be used:
> > 
> > --
> > #!/bin/bash
> > 
> > cd /sys/fs/cgroup
> > 
> > mkdir percpu_test
> > echo "+memory" > percpu_test/cgroup.subtree_control
> > 
> > cat /proc/meminfo | grep Percpu
> > 
> > for i in `seq 1 1000`; do
> >      mkdir percpu_test/cg_"${i}"
> >      for j in `seq 1 10`; do
> > 	mkdir percpu_test/cg_"${i}"_"${j}"
> >      done
> > done
> > 
> > cat /proc/meminfo | grep Percpu
> > 
> > for i in `seq 1 1000`; do
> >      for j in `seq 1 10`; do
> > 	rmdir percpu_test/cg_"${i}"_"${j}"
> >      done
> > done
> > 
> > sleep 10
> > 
> > cat /proc/meminfo | grep Percpu
> > 
> > for i in `seq 1 1000`; do
> >      rmdir percpu_test/cg_"${i}"
> > done
> > 
> > rmdir percpu_test
> > --
> > 
> > It creates 11000 memory cgroups and removes every 10 out of 11.
> > It prints the initial size of the percpu memory, the size after
> > creating all cgroups and the size after deleting most of them.
> > 
> > Results:
> >    vanilla:
> >      ./percpu_test.sh
> >      Percpu:             7488 kB
> >      Percpu:           481152 kB
> >      Percpu:           481152 kB
> > 
> >    with this patchset applied:
> >      ./percpu_test.sh
> >      Percpu:             7488 kB
> >      Percpu:           481408 kB
> >      Percpu:           135552 kB
> > 
> > So the total size of the percpu memory was reduced by more than 3.5 times.
> > 
> > v3:
> >    - introduced pcpu_check_chunk_hint()
> >    - fixed a bug related to the hint check
> >    - minor cosmetic changes
> >    - s/pretends/fixes (cc Vlastimil)
> > 
> > v2:
> >    - depopulated chunks are sidelined
> >    - depopulation happens in the reverse order
> >    - depopulate list made per-chunk type
> >    - better results due to better heuristics
> > 
> > v1:
> >    - depopulation heuristics changed and optimized
> >    - chunks are put into a separate list, depopulation scan this list
> >    - chunk->isolated is introduced, chunk->depopulate is dropped
> >    - rearranged patches a bit
> >    - fixed a panic discovered by krobot
> >    - made pcpu_nr_empty_pop_pages per chunk type
> >    - minor fixes
> > 
> > rfc:
> >    https://lwn.net/Articles/850508/
> > 
> > 
> > Roman Gushchin (6):
> >    percpu: fix a comment about the chunks ordering
> >    percpu: split __pcpu_balance_workfn()
> >    percpu: make pcpu_nr_empty_pop_pages per chunk type
> >    percpu: generalize pcpu_balance_populated()
> >    percpu: factor out pcpu_check_chunk_hint()
> >    percpu: implement partial chunk depopulation
> > 
> >   mm/percpu-internal.h |   4 +-
> >   mm/percpu-stats.c    |   9 +-
> >   mm/percpu.c          | 306 +++++++++++++++++++++++++++++++++++--------
> >   3 files changed, 261 insertions(+), 58 deletions(-)
> > 
> 

Roman, sorry for the delay. I'm looking to apply this today to for-5.14.

Thanks,
Dennis
