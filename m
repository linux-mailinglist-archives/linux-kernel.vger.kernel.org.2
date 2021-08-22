Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC953F41E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhHVWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhHVWUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:20:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 892AF61267;
        Sun, 22 Aug 2021 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629670792;
        bh=9QiEIQNGBi9nfvqgJV5eTtXQ+nYy4w+IVMveVo1QNHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KC9ACjBAbvdERDZUfnmGTzJOxTRFJU9//f1GKDlopXubbyDOcDgvh6S6vlaqgpw1p
         KmmoRTO6nNFOlNV7MhikA4K6QoOIshP2cQFp9+YAmuApcP2Idu51qqrCYIK5IBWwQH
         LKmuFexhzTPa/fzt0YJ0SYVPShbkgpbpwUdnU48U=
Date:   Sun, 22 Aug 2021 15:19:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     yaozhenguo <yaozhenguo1@gmail.com>
Cc:     mike.kravetz@oracle.com, corbet@lwn.net, yaozhenguo@jd.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] hugetlbfs: add hugepages_node kernel parameter
Message-Id: <20210822151952.23ca9547316dc34c9f3bd482@linux-foundation.org>
In-Reply-To: <20210820030536.25737-1-yaozhenguo1@gmail.com>
References: <20210820030536.25737-1-yaozhenguo1@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 11:05:36 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:

> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepags in one node. For example: DPDK needs hugepages
> which is in the same node as NIC. if DPDK needs four hugepags of 1G
> size in node1 and system has 16 numa nodes. We must reserve 64 hugepags
> in kernel cmdline. But, only four hugepages is used. The others should
> be free after boot.If the system memory is low(for example: 64G), it will
> be an impossible task. So, add hugepages_node kernel parameter to specify
> node number of hugepages to allocate at boot.
> For example add following parameter:
> 
> hugepagesz=1G hugepages_node=1 hugepages=4
> 
> It will allocate 4 hugepags in node1 at boot.

If were going to do this, shouldn't we permit more than one node?

	hugepages_nodes=1,2,5
