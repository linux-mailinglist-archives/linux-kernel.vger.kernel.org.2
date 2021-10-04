Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6C942110B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhJDONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:13:21 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:57140 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233188AbhJDONU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:13:20 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2021 10:13:20 EDT
Received: by gentwo.de (Postfix, from userid 1001)
        id 97F73B00261; Mon,  4 Oct 2021 16:05:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 95917B00189;
        Mon,  4 Oct 2021 16:05:23 +0200 (CEST)
Date:   Mon, 4 Oct 2021 16:05:23 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] mm, slab: Reduce space complexity of alien_cache
 using rbtree
In-Reply-To: <20211003051750.8296-1-42.hyeyoo@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110041601170.294708@gentwo.de>
References: <20211003051750.8296-1-42.hyeyoo@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2021, Hyeonggon Yoo wrote:

> As remote node allocation isn't that frequent and better avoided,
> this patch tries to compromise some execution time for memory usage.

Remote node allocation is typical for large memory loads and essential to
balance the memory allocation over multiple nodes. Large NUMA systems
exist because the memory requirements of the application cannot be
satisfied by what a single node has to offer and usually code threads from
multiple nodes may access remote memory.


> This patch introduces red-black tree for alien cache. Tree nodes are
> allocated at cache creation and the pool of tree nodes is same size with
> cache's limit.

??? A red-black tree?? Gosh how much will performance suffer now? A lookup
for every allocation?

> Remove init_reap_node, next_reap_node and related variables
> introduced by commit 8fce4d8e3b9e ("[PATCH] slab: Node rotor for freeing
> alien caches and remote per cpu pages."), Because it has only one tree
> for all remote nodes.

Rotors to spread the memory allocated are essential for the performance
of large memory loads! Memory must be spread evenly otherwise memory
accesses will overload a single node.


