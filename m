Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E884340ABDE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhINKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:42:04 -0400
Received: from ozlabs.org ([203.11.71.1]:49355 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhINKmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631616042;
        bh=PgQZCFTfY6IZcgN58w46zz5hDYowlMLp1ghqMp4Hbg4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EGrBq3KtE7FY3m14RhG6YIW5oblfrdOfbZhgOWEM5IeSyeUFIJ/avloWh8HYU8BZR
         qGyKeFE5BzeOYdOA91GJ1LyYSmusJ/TOmpQ/UoD/omsdookewViKftpBRcpdfsLpbY
         exiKjbh9JeJQg4kTbRhRvIp0aDJCYPZKjjicwvtmICoEXJv0K68ZHNbzdhNTbJMw28
         WvcQcT7a4jwDunE0OxcRi6S2CNSbtr2eR6EqOJYveDylZ0larAzxpFey4n1PDxGnK6
         wckS1WiwMl7tmNDJ46aTSixUN725HjtzMzygV8R2h3/QO4HT10SAF3onZXTjvdc3oQ
         7a8E1Gxc5VDoA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H80HX53Zzz9sSn;
        Tue, 14 Sep 2021 20:40:40 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, yao.jin@linux.intel.com, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, paulus@samba.org
Subject: Re: [PATCH 1/3] perf: Add macros to specify onchip L2/L3 accesses
In-Reply-To: <YTob/xfn1gt901K4@hirez.programming.kicks-ass.net>
References: <20210904064932.307610-1-kjain@linux.ibm.com>
 <87ilzbmt7i.fsf@mpe.ellerman.id.au>
 <YTiBqbxe7ieqY2OE@hirez.programming.kicks-ass.net>
 <87czphnchp.fsf@mpe.ellerman.id.au>
 <YTob/xfn1gt901K4@hirez.programming.kicks-ass.net>
Date:   Tue, 14 Sep 2021 20:40:38 +1000
Message-ID: <87k0jjl9sp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Sep 09, 2021 at 10:45:54PM +1000, Michael Ellerman wrote:
>
>> > The 'new' composite doesnt have a hops field because the hardware that
>> > nessecitated that change doesn't report it, but we could easily add a
>> > field there.
>> >
>> > Suppose we add, mem_hops:3 (would 6 hops be too small?) and the
>> > corresponding PERF_MEM_HOPS_{NA, 0..6}
>> 
>> It's really 7 if we use remote && hop = 0 to mean the first hop.
>
> I don't think we can do that, becaus of backward compat. Currently:
>
>   lvl_num=DRAM, remote=1
>
> denites: "Remote DRAM of any distance". Effectively it would have the new
> hops field filled with zeros though, so if you then decode with the hops
> field added it suddenly becomes:
>
>  lvl_num=DRAM, remote=1, hops=0
>
> and reads like: "Remote DRAM of 0 hops" which is quite daft. Therefore 0
> really must denote a 'N/A'.

Ah yeah, duh, it needs to be backward compatible.

>> If we're wanting to use some of the hop levels to represent
>> intra-chip/package hops then we could possibly use them all on a really
>> big system.
>> 
>> eg. you could imagine something like:
>> 
>>  L2 | 		        - local L2
>>  L2 | REMOTE | HOPS_0	- L2 of neighbour core
>>  L2 | REMOTE | HOPS_1	- L2 of near core on same chip (same 1/2 of chip)
>>  L2 | REMOTE | HOPS_2	- L2 of far core on same chip (other 1/2 of chip)
>>  L2 | REMOTE | HOPS_3	- L2 of sibling chip in same package
>>  L2 | REMOTE | HOPS_4	- L2 on separate package 1 hop away
>>  L2 | REMOTE | HOPS_5	- L2 on separate package 2 hops away
>>  L2 | REMOTE | HOPS_6	- L2 on separate package 3 hops away
>> 
>> 
>> Whether it's useful to represent all those levels I'm not sure, but it's
>> probably good if we have the ability.
>
> I'm thinking we ought to keep hops as steps along the NUMA fabric, with
> 0 hops being the local node. That only gets us:
>
>  L2, remote=0, hops=HOPS_0 -- our L2
>  L2, remote=1, hops=HOPS_0 -- L2 on the local node but not ours
>  L2, remote=1, hops!=HOPS_0 -- L2 on a remote node

Hmm. I'm not sure about tying it directly to NUMA hops. I worry we're
going to see more and more systems where there's a hierarchy within the
chip/package, in addition to the traditional NUMA hierarchy.

Although then I guess it becomes a question of what exactly is a NUMA
hop, maybe the answer is that on those future systems those
intra-chip/package hops should be represented as NUMA hops.

It's not like we have a hard definition of what a NUMA hop is?

>> I guess I'm 50/50 on whether that's enough levels, or whether we want
>> another bit to allow for future growth.
>
> Right, possibly safer to add one extra bit while we can.... I suppose.

Equally it's not _that_ hard to add another bit later (if there's still
one free), makes the API a little uglier to use, but not the end of the
world.

cheers
