Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAC3F7059
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhHYH02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbhHYHZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:25:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7897C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kXhulwCsHpOwdnbocHy5ZJeMGvemrXslAdvnV0AL1CE=; b=f4Jr6paYDUsArFWQQeaso3Ly2j
        LKkz88V7T/pCM2TPUFD3hHHQSro50JZG4JWT90ArEdwC3WBQMNfurEvWZtbaqUGa4TZgWViIelpsc
        Tt0/qc3P1xWUfuEFNgmdoj/39nGvok9uUtlSpGz0/CHIe9SAh4qvCph8HJa3rQ2RYIex04n/y1gPj
        7jIjP80+6F1ieWLYEs8Bkv+uHWi1Bc86YzCMSZtg3exrgBU9oPsDlc5BvQCcV2Sbty91b9aT5OSFS
        8NjVzZuIrAql6ExgG0XRVUDeweLaFj2WXyBCCHMMoqwlgXW2Ap01sB7DOIXbOjk5oZV6WLke7/E7T
        UmEZWQ0Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mInFo-00C1Eh-F1; Wed, 25 Aug 2021 07:23:41 +0000
Date:   Wed, 25 Aug 2021 08:23:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4] nvme-multipath: revalidate paths during rescan
Message-ID: <YSXv6E7vIQ+UdMBp@infradead.org>
References: <20210824145742.94212-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824145742.94212-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've replaced the version in nvme-5.15 with this one.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [dwagner: - introduce NVME_NS_READY flag instead of NVME_NS_INVALIDATE
>           - use 'revalidate' instead of 'invalidate' which
> 	    follows the zoned device code path.
> 	  - clear NVME_NS_READY before clearing current_path]
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

I've dropped the Tested-by here - the tag is for people not in the
signoff chain.
