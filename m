Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06303F4229
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhHVW3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhHVW3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:29:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8122DC061575;
        Sun, 22 Aug 2021 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VYc0cebh9WyW+/AmQmTYh9Oy2IvgR3B25x4AO50Bd3c=; b=iUFR0qDay2GKm3us9NSKmSwoWo
        zpeLOa+tAMUa899Fm1f7itxN38/2XX2ctNA/yWQYChtSpV2icp5BBIE1IGgmXi8Ah2ijAL+TyNFrd
        GyUFGHMu3+qqX1WgQoJRgvenXH5G1GCgypXLiyCC4/GoMOqRKom09lvuBDX4CY+pd379UM4D+oLNA
        NzseNDo883RTILni2bhcFcodaIkcJQwXTBaYJ9wTCX8ZCfhWzZszmRiveu6C9u7De0JyTlmYtMwYx
        Okwej64ggsUddcFjrnrQt1E6tTCe4q/MmL/Fy6Z111lVNoIlIslYuw42jZ9o3vMcAil+bsuIzA7Wt
        w8G9ww0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHvwJ-008zGP-6Z; Sun, 22 Aug 2021 22:27:46 +0000
Date:   Sun, 22 Aug 2021 23:27:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     yaozhenguo <yaozhenguo1@gmail.com>, mike.kravetz@oracle.com,
        corbet@lwn.net, yaozhenguo@jd.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] hugetlbfs: add hugepages_node kernel parameter
Message-ID: <YSLPWybBCyE/6x7s@casper.infradead.org>
References: <20210820030536.25737-1-yaozhenguo1@gmail.com>
 <20210822151952.23ca9547316dc34c9f3bd482@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822151952.23ca9547316dc34c9f3bd482@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 03:19:52PM -0700, Andrew Morton wrote:
> On Fri, 20 Aug 2021 11:05:36 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:
> 
> > We can specify the number of hugepages to allocate at boot. But the
> > hugepages is balanced in all nodes at present. In some scenarios,
> > we only need hugepags in one node. For example: DPDK needs hugepages
> > which is in the same node as NIC. if DPDK needs four hugepags of 1G
> > size in node1 and system has 16 numa nodes. We must reserve 64 hugepags
> > in kernel cmdline. But, only four hugepages is used. The others should
> > be free after boot.If the system memory is low(for example: 64G), it will
> > be an impossible task. So, add hugepages_node kernel parameter to specify
> > node number of hugepages to allocate at boot.
> > For example add following parameter:
> > 
> > hugepagesz=1G hugepages_node=1 hugepages=4
> > 
> > It will allocate 4 hugepags in node1 at boot.
> 
> If were going to do this, shouldn't we permit more than one node?
> 
> 	hugepages_nodes=1,2,5

I'd think we'd be better off expanding the definition of hugepages.
eg:

hugepagesz=1G hugepages=1:4,3:8,5:2

would say to allocate 4 pages from node 1, 8 pages from node 3 and 2
pages from node 5.
