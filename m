Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869653E89FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 08:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhHKGCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 02:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhHKGCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:02:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC08C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=JgUqUwUQ1hasPhftYsiPUKHkCk
        ZSYe5c8lPl3tZ0Lox7CXTMlKmuas85oVO72k788D3nWKOPjsV39thqarACHLf3C7DRlknpw2QIMVa
        s375o9WQDtfKEgIoMNMzov0RJm11DJNhj9yBYkx2k9t97dDUtKC6xp0ZqdLfvdo90HVGCuVaEx1OI
        LKBk9c9M8T+W4w5meJqcxiO0czMdDyHMc8exIvgukclxG6QKToPOd7CGw0HyRi+hY9fBoP8wKLLAQ
        vuCm5OPDsDMyXoid09utkkAx+Ets6URYnW/tfsMU6w207qM7yNT9OCzBQD6X+jPBUCx7d26R3jL4E
        LhfgEEpA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDhJ4-00D2gf-6P; Wed, 11 Aug 2021 06:01:49 +0000
Date:   Wed, 11 Aug 2021 07:01:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
Message-ID: <YRNnwn71E+v6kXYq@infradead.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-3-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811024247.1144246-3-stevensd@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
