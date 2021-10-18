Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515C0431985
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhJRMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhJRMn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:43:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04741C061769
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D0on4HUpG42haSYLV1uyg0Ra8eavO6yawrcHNA7JqNE=; b=l1tP7h9zicMHO1Xl3MTeMZbAT1
        gJVT86FtE9nPC2sc0ibmEvIPQEDPSU0V9hJxWPOyjPMkYKziza66AzI69pZyuAYFyQmLn/Gtow2zi
        HIA/Q4qJWRePWGKRP451c/rVvpMvkiPcNYi4pybAPoyzP2sqERIJjGrejKDzxBEAQMZDAtmpyn9mN
        dsADP2grJEGxFGHqjYrgM5+M6s8/Fu6PJE2mfG6HmSwBeGjUk++9HM2GdDqymQRBM5lkUkpZna6rC
        ShpjksJnog80uPOXkahDcSaKZA3SJnFqYbgyEqNZy2fb6/7xA69CBpteX6UROr1fL48yrSkaDenGt
        GPo4lN8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcRve-00Awmf-Uo; Mon, 18 Oct 2021 12:40:06 +0000
Date:   Mon, 18 Oct 2021 13:39:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        shakeelb@google.com, urezki@gmail.com
Subject: Re: [PATCH v2 1/2] mm/vmalloc: fix numa spreading for large hash
 tables
Message-ID: <YW1rEt0u2CSCYgnJ@casper.infradead.org>
References: <20211018123710.1540996-1-chenwandun@huawei.com>
 <20211018123710.1540996-2-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018123710.1540996-2-chenwandun@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 08:37:09PM +0800, Chen Wandun wrote:
> Eric Dumazet reported a strange numa spreading info in [1], and found
> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
> this issue [2].

I think the root problem here is that we have two meanings for
NUMA_NO_NODE.  I tend to read it as "The memory can be allocated from
any node", but here it's used to mean "The memory should be spread over
every node".  Should we split those out as -1 and -2?
