Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE23CA169
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhGOP0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhGOP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:26:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8CEC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M5BuhxlRetjxwk3aIO2mhdXoXwLCgAo192GMMEmNGHQ=; b=btpOYnTLgWRM14ebatKKky+imq
        Tfkge9+tYk2iLN/UmStntyXetYyR8tWpRBjsNmSwZ76emVQLFGYods1wVzIk3ij6sjnkxucMSPzsp
        ULPRBwr0vqRBIB2ZsNF1kceZOHvCfAZYqhvNyTS3tyRm2mk/fjR3AXR/zdH0Eh8Ls8nyGi/1e0T58
        RdniPWXJhUpg3nWuFibb2OauWA9Nju2HE8T29htnHN8uYTa3D//U0C9bzSiZ2fJXRO7VY+0kicVAB
        OVA8wc7fOX0ChLTL+6MuMnSxvwtISfqJHbGPtZyu+5QgSkg2LNn9vwh4o+qLz2EvM3lRsZiyPAV65
        oG5S71FQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m43CC-003TBY-TF; Thu, 15 Jul 2021 15:22:47 +0000
Date:   Thu, 15 Jul 2021 16:22:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bin Wang <wangbin224@huawei.com>
Cc:     linux-mm@kvack.org, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org, wuxu.wu@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hwpoison: dissolve error hugepages of file mapping
Message-ID: <YPBSwEdagjXjx2jO@casper.infradead.org>
References: <20210715150852.1655-1-wangbin224@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715150852.1655-1-wangbin224@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:08:52PM +0800, Bin Wang wrote:
> We handle error on hugetlb file with hugetlbfs_error_remove_page(),
> which removes the error hugepages from page cache. And with the
> HWPoison flag in head page, it is safe to free the error hugepages
> and dissolve it.

How is that safe?  If you're going to dissolve the huge page, you
need to figure out which subpage needs to have the HWPoison flag set.

