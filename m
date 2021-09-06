Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2615401775
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbhIFIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbhIFIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:04:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C4C061796
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yhsez13STG6J7J5L5MmBsOcg+6XZ1TXjQyFULBqbcS8=; b=sCrmIiylKZYgWkzKln9qGYnOzD
        /Yv1Emgf2N7ikulvlwJqmJAgnPW0qX5cKZizUWsbZnGK4xghYYLwrgdWKaeWTGoCb9tRVOgo/AeQL
        nh9ElVx6A4VZ7V+fVFA/UPbXUfqfNnOWWr+3ncZKEu2a0pWFoMq0gkGSCdoRJcDE8QwtF4NhSEWZm
        +SqN+gfLXmhxOASmtT1c2PLrzaqAdJ9m7v/qbzsAzSvXIC7RBqxnzDMCRbveAtam32j5Zz5YtCZ35
        WPcRCatziGk8y4b4K9+b3s8pHfb6h/eSBSxe/N0wW22HSGQ9YTFy9dAVPoE6a5c+Ln6XhvF8AdhGl
        7efr9jnQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mN9Yu-006kyn-Cp; Mon, 06 Sep 2021 08:01:12 +0000
Date:   Mon, 6 Sep 2021 09:01:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: avoid race in shutdown namespace removal
Message-ID: <YTXKwOvCtJOHnhpu@infradead.org>
References: <20210902092002.67614-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902092002.67614-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:20:02AM +0200, Daniel Wagner wrote:
> When we remove the siblings entry, we update ns->head->list, hence we
> can't separate the removal and test for being empty. They have to be
> in the same critical section to avoid a race.
> 
> To avoid breaking the refcounting imbalance again, add a list empty
> check to nvme_find_ns_head.

Hannes, can you look over this and run your tests on it?
