Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBC451D86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349866AbhKPAaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345919AbhKOT3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:33 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B8C06F69D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:06:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w1so10339833edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCbqKs1ZcW/d50rZafmZ+SyLk/Uguxy204CBYFA2gEw=;
        b=ZNFnn/GoqMfn2uOtaWD4XYyNUAuMEtxNSMZr4cJumapKrsn2DcW2/pxhHC1JS3djHf
         L0XLZ4SwtSrW6cseMin9NI53UmyIbtSPnvMjxtMZ9mr6oh114gi4cazu68z6inUkMWmD
         1F5xqaVpv60aRaai4JsyzFHfrds0Db4suzcI0wunwG2al/E73Dwhr0nHCpcIcr2VKhBC
         a3y0Xjv/ZV6E9rTu3yN/Mj93mRKIq19H0clkFrrG1KMX9cw6tL4jGC76IdZP0eEv3VT9
         QckyVHgDCPUyYa/fw34mTGeG1BipFA4nYxfJ1Gqwi0pLAEfiWew+k6lZxgiM+5GohEDz
         pjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCbqKs1ZcW/d50rZafmZ+SyLk/Uguxy204CBYFA2gEw=;
        b=IV7VqLxwpzyFjhiOy45fi/H3yolJooi9lqVKMDgXmVDMjh2qH2yVB2zoDZdeLp+zJ1
         uc64FCuPb0pj11kOz3YCcuZXP700lDzVCv5BpLlOb0Yx51nNAs78DCBC5TZYL/czrxZM
         l7QBJPTS4G4rk6wVu9WcsF7kyOmTKgdE1y07AL28C0gElmzhg8DWfE1uBt3k9rpNi+cS
         42KBmzuwdgjNyVDQ257WoVYPbkM6w0AcaGPh0bHL/3i2gUAg1NxAQSWWy8PlsuYahQ+i
         sDobNvacc7V12KebI+NB1LrhvFVHWGVZQaXUxuy+dX0GkyHLxf0PivD5pbPgo89+R4bo
         A5wg==
X-Gm-Message-State: AOAM533DN/WsKN9qdapBXr064dgcKZb0Ldu8aTOiTFZ8iiMNCuTHOlWL
        Evljl9qv/R7al941zhU0emuivFsU/15x2YwEWRU=
X-Google-Smtp-Source: ABdhPJwMLXzdDIvmeIdYTuS5wG0oJ87UJwctiuV18ZCm3LyqYdqClQ4WdBRrWFmirungf3BfBhNer5/8bCSLWasyEMo=
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr1422987edb.71.1637003198157;
 Mon, 15 Nov 2021 11:06:38 -0800 (PST)
MIME-Version: 1.0
References: <a31dc065a7901bcdca0d9642d0def0f57e865e20.1636683991.git.baolin.wang@linux.alibaba.com>
 <CAHbLzkpTo0yW9YWPyE6omiiP2QiwMRETe1ZJ1x4sEJCk0WZOkg@mail.gmail.com> <d953e533-e175-17ba-c065-dfd1354a858f@linux.alibaba.com>
In-Reply-To: <d953e533-e175-17ba-c065-dfd1354a858f@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 15 Nov 2021 11:06:26 -0800
Message-ID: <CAHbLzkqSqCL+g7dfzeOw8fPyeEC0BBv13Ny1UVGHDkadnQdR=g@mail.gmail.com>
Subject: Re: [PATCH v3] mm: migrate: Support multiple target nodes demotion
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        zhongjiang-ali@linux.alibaba.com,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 6:40 AM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2021/11/13 3:05, Yang Shi wrote:
> > On Thu, Nov 11, 2021 at 6:28 PM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >> We have some machines with multiple memory types like below, which
> >> have one fast (DRAM) memory node and two slow (persistent memory) memory
> >> nodes. According to current node demotion policy, if node 0 fills up,
> >> its memory should be migrated to node 1, when node 1 fills up, its
> >> memory will be migrated to node 2: node 0 -> node 1 -> node 2 ->stop.
> >>
> >> But this is not efficient and suitbale memory migration route
> >> for our machine with multiple slow memory nodes. Since the distance
> >> between node 0 to node 1 and node 0 to node 2 is equal, and memory
> >> migration between slow memory nodes will increase persistent memory
> >> bandwidth greatly, which will hurt the whole system's performance.
> >>
> >> Thus for this case, we can treat the slow memory node 1 and node 2
> >> as a whole slow memory region, and we should migrate memory from
> >> node 0 to node 1 and node 2 if node 0 fills up.
> >>
> >> This patch changes the node_demotion data structure to support multiple
> >> target nodes, and establishes the migration path to support multiple
> >> target nodes with validating if the node distance is the best or not.
> >>
> >> available: 3 nodes (0-2)
> >> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> >> node 0 size: 62153 MB
> >> node 0 free: 55135 MB
> >> node 1 cpus:
> >> node 1 size: 127007 MB
> >> node 1 free: 126930 MB
> >> node 2 cpus:
> >> node 2 size: 126968 MB
> >> node 2 free: 126878 MB
> >> node distances:
> >> node   0   1   2
> >>    0:  10  20  20
> >>    1:  20  10  20
> >>    2:  20  20  10
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >> Changes from v2:
> >>   - Redefine the DEMOTION_TARGET_NODES macro according to the
> >>     MAX_NUMNODES.
> >>   - Change node_demotion to a pointer and allocate it dynamically.
> >>
> >> Changes from v1:
> >>   - Add a new patch to allocate the node_demotion dynamically.
> >>   - Update some comments.
> >>   - Simplify some variables' name.
> >>
> >> Changes from RFC v2:
> >>   - Change to 'short' type for target nodes array.
> >>   - Remove nodemask instead selecting target node directly.
> >>   - Add WARN_ONCE() if the target nodes exceed the maximum value.
> >>
> >> Changes from RFC v1:
> >>   - Re-define the node_demotion structure.
> >>   - Set up multiple target nodes by validating the node distance.
> >>   - Add more comments.
> >> ---
> >>   mm/migrate.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++-------------
> >>   1 file changed, 132 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index cf25b00..9b8a813 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -50,6 +50,7 @@
> >>   #include <linux/ptrace.h>
> >>   #include <linux/oom.h>
> >>   #include <linux/memory.h>
> >> +#include <linux/random.h>
> >>
> >>   #include <asm/tlbflush.h>
> >>
> >> @@ -1119,12 +1120,25 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >>    *
> >>    * This is represented in the node_demotion[] like this:
> >>    *
> >> - *     {  1, // Node 0 migrates to 1
> >> - *        2, // Node 1 migrates to 2
> >> - *       -1, // Node 2 does not migrate
> >> - *        4, // Node 3 migrates to 4
> >> - *        5, // Node 4 migrates to 5
> >> - *       -1} // Node 5 does not migrate
> >> + *     {  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
> >> + *     {  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
> >> + *     {  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
> >> + *     {  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
> >> + *     {  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
> >> + *     {  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
> >> + *
> >> + * Moreover some systems may have multiple slow memory nodes.
> >> + * Suppose a system has one socket with 3 memory nodes, node 0
> >> + * is fast memory type, and node 1/2 both are slow memory
> >> + * type, and the distance between fast memory node and slow
> >> + * memory node is same. So the migration path should be:
> >> + *
> >> + *     0 -> 1/2 -> stop
> >> + *
> >> + * This is represented in the node_demotion[] like this:
> >> + *     { nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
> >> + *     { nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
> >> + *     { nr=0, nodes[0]=-1, }, // Node 2 does not migrate
> >>    */
> >>
> >>   /*
> >> @@ -1135,8 +1149,20 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >>    * must be held over all reads to ensure that no cycles are
> >>    * observed.
> >>    */
> >> -static int node_demotion[MAX_NUMNODES] __read_mostly =
> >> -       {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
> >> +#define DEFAULT_DEMOTION_TARGET_NODES 15
> >> +
> >> +#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
> >> +#define DEMOTION_TARGET_NODES  (MAX_NUMNODES - 1)
> >> +#else
> >> +#define DEMOTION_TARGET_NODES  DEFAULT_DEMOTION_TARGET_NODES
> >> +#endif
> >> +
> >> +struct demotion_nodes {
> >> +       unsigned short nr;
> >> +       short nodes[DEMOTION_TARGET_NODES];
> >> +};
> >> +
> >> +static struct demotion_nodes *node_demotion __read_mostly;
> >>
> >>   /**
> >>    * next_demotion_node() - Get the next node in the demotion path
> >> @@ -1149,8 +1175,15 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
> >>    */
> >>   int next_demotion_node(int node)
> >>   {
> >> +       struct demotion_nodes *nd;
> >> +       unsigned short target_nr, index;
> >>          int target;
> >>
> >> +       if (!node_demotion)
> >> +               return NUMA_NO_NODE;
> >> +
> >> +       nd = &node_demotion[node];
> >> +
> >>          /*
> >>           * node_demotion[] is updated without excluding this
> >>           * function from running.  RCU doesn't provide any
> >> @@ -1161,9 +1194,28 @@ int next_demotion_node(int node)
> >>           * node_demotion[] reads need to be consistent.
> >>           */
> >>          rcu_read_lock();
> >> -       target = READ_ONCE(node_demotion[node]);
> >> -       rcu_read_unlock();
> >> +       target_nr = READ_ONCE(nd->nr);
> >> +
> >> +       switch (target_nr) {
> >> +       case 0:
> >> +               target = NUMA_NO_NODE;
> >> +               goto out;
> >> +       case 1:
> >> +               index = 0;
> >> +               break;
> >> +       default:
> >> +               /*
> >> +                * If there are multiple target nodes, just select one
> >> +                * target node randomly.
> >> +                */
> >> +               index = get_random_int() % target_nr;
> >
> > Sorry for chiming in late. I don't get why not select demotion targe > node interleave? TBH, it makes more sense to me. Random is ok, but at
> > least I'd expect to see some explanation about why random is used.
>
> My first version patch[1] already did round-robin to select target node.
> For interleave (or round-robin), we should introduce another member to
> record last selected target node, as Dave and Ying said, that will cause
> cache ping-pong to hurt performance, or introduce per-cpu data to avoid
> this, which seems more complicated now.

Thanks. It should be better to have some words in the commit log or
code to elaborate this? Someone else may have the same question in the
future.

>
> [1]
> https://lore.kernel.org/all/c02bcbc04faa7a2c852534e9cd58a91c44494657.1636016609.git.baolin.wang@linux.alibaba.com/
