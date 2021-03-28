Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DC34BEB5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 22:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhC1UDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhC1UDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 16:03:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC0CC061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Gr2M1jMug+JO4h08sIzmzmOzqwA2/BwbcA23gnbi9JY=; b=qThYJYzaZWFCYkoEtuavPASvdA
        zhnEgw76kUh8FFj5PeWUfYW4yZS6dHpvPFAEgTVanOTdJUWyqTpVN/r5xgSH7oKSOJip5DtYVf7cu
        2sKowgFFkiGnvejOFZuzluKVt/J6ftQmWwh83SrLJYw6QXPs9d8Vn1P03BweFDFRkEAapWZPKbs2V
        1Pg4pF9vjGiIqPfeM/zkrpQINBCBuBGmk/OVPCSg/Q8Tgdx49JFexDhXAZWMRcmtkMKW9FxjgS/Is
        iWPiw1MxSeP4S0RpUXOvbebp2YA8lo5mIL8bPCQgdpNH+60NFHR1c6UV5Mh6gJUreo+7bB+mqK7nZ
        iNbiP2Jg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQbdE-000VZH-GS; Sun, 28 Mar 2021 20:03:32 +0000
Date:   Sun, 28 Mar 2021 21:03:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: tools/testing/radix-tree/idr-test gets a failed assertion on
 single cpu systems
Message-ID: <20210328200332.GB33249@casper.infradead.org>
References: <def0fd33-da11-6283-d98f-66eb9a8dd201@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <def0fd33-da11-6283-d98f-66eb9a8dd201@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 02:23:39PM -0400, Chris von Recklinghausen wrote:
> Hi Matthew,
> 
> I made the observation that while tools/testing/radix-tree/idr-test runs and
> passes just fine on a system with more than one cpu, it gets an assertion
> failure when run on a single cpu system. My test system is Fedora 34 running
> on an x86_64 system. It can be easily reproduced by offlining all cpus but
> cpu0.

I'm delighted (a) that you're running idr-test (sometimes I feel like I'm
the only one) and (b) to receive such a detailed and thoughtful bug report.
Thank you.

There's an easier way to reproduce this than offlining all the CPUs
-- use taskset:

$ taskset -c 3 ./idr-test 
vvv Ignore these warnings
assertion failed at idr.c:269
assertion failed at idr.c:206
^^^ Warnings over
idr-test: idr-test.c:312: idr_find_test_1: Assertion `!(entry != xa_mk_value(id))' failed.
Aborted

After fixing the current build (git rm
tools/testing/radix-tree/linux/compiler_types.h), I suspected this would fix
the problem:

+++ b/tools/testing/radix-tree/idr-test.c
@@ -577,6 +577,7 @@ void ida_tests(void)
 
 int __weak main(void)
 {
+       rcu_register_thread();
        radix_tree_init();
        idr_checks();
        ida_tests();
@@ -584,5 +585,6 @@ int __weak main(void)
        rcu_barrier();
        if (nr_allocated)
                printf("nr_allocated = %d\n", nr_allocated);
+       rcu_unregister_thread();
        return 0;
 }

However, that only gets me to the next problem:

==2312666==ERROR: AddressSanitizer: heap-use-after-free on address 0x60c0048fda80 at pc 0x563186e34300 bp 0x7fffa5d4f2b0 sp 0x7fffa5d4f2a8
READ of size 1 at 0x60c0048fda80 thread T0
    #0 0x563186e342ff in radix_tree_descend /home/willy/kernel/linux/tools/testing/radix-tree/radix-tree.c:86
    #1 0x563186e38e98 in radix_tree_next_chunk /home/willy/kernel/linux/tools/testing/radix-tree/radix-tree.c:1193
    #2 0x563186e3c429 in idr_get_next_ul /home/willy/kernel/linux/tools/testing/radix-tree/idr.c:236
    #3 0x563186e3c56a in idr_get_next /home/willy/kernel/linux/tools/testing/radix-tree/idr.c:267
    #4 0x563186dfbf82 in idr_find_test_1 /home/willy/kernel/linux/tools/testing/radix-tree/idr-test.c:311
    #5 0x563186dfc146 in idr_find_test /home/willy/kernel/linux/tools/testing/radix-tree/idr-test.c:323
    #6 0x563186dfc957 in idr_checks /home/willy/kernel/linux/tools/testing/radix-tree/idr-test.c:408

so I'll have to dive into that a bit further.

> [root@hpe-ml110g7-01 linux]# tools/testing/radix-tree/idr-test
> vvv Ignore these warnings
> assertion failed at idr.c:250
> assertion failed at idr.c:206
> ^^^ Warnings over
> idr-test: idr-test.c:320: idr_find_test_1: Assertion `!(entry !=
> xa_mk_value(id))' failed.
> Aborted (core dumped)
> 
> I bisected the change to 5c089fd0c734 ("idr: Fix idr_get_next race with
> idr_remove").
> 
> Since idr_get_next can return NULL, I stuck a BUG_ON(!entry) just above the
> failing assert, and in this case idr_get_next is returning NULL.
> 
> Next, I stuck a BUG_ON in the place that idr_get_next_ul returns NULL and
> commented out the contents of idr_u32_test1 so we're not knowingly passing
> it bad values, and we seem to fail because the list has been gone through.
> 
> void *idr_get_next_ul(struct idr *idr, unsigned long *nextid)
> {
>     struct radix_tree_iter iter;
>     void __rcu **slot;
>     void *entry = NULL;
>     unsigned long base = idr->idr_base;
>     unsigned long id = *nextid;
> 
>     id = (id < base) ? 0 : id - base;
>     radix_tree_for_each_slot(slot, &idr->idr_rt, &iter, id) {
>         entry = rcu_dereference_raw(*slot);
>         if (!entry)
>             continue;
>         if (!xa_is_internal(entry))
>             break;
>         if (slot != &idr->idr_rt.xa_head && !xa_is_retry(entry))
>             break;
>         slot = radix_tree_iter_retry(&iter);
>     }
>     if (!slot)
>         return NULL; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> 
>     *nextid = iter.index + base;
>     return entry;
> }
> EXPORT_SYMBOL(idr_get_next_ul);
> 
> I'm not sure if this is a test issue or possibly an issue with user level
> RCU when there's only a single cpu in the system, but I figured it was worth
> bringing it to your attention. If there's anything I can do to help to
> further analyze this or try out a fix, I'm happy to help.
> 
> Thanks,
> 
> Chris von Recklinghausen
> 
> Red Hat
> 
