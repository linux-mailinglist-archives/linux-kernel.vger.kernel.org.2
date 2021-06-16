Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9400D3AA26E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFPRgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:36:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9gNz19wM+fC67a3J6k98aG2swd11Ci5D+eY1oF5ODtA=; b=bGeItEgi3anUDihg6pqp7DpSGJ
        VabYcpecBh9yNBuzGEzkH/Pf4InzXEM9+Vcr/Nj0d07n8YxZTTPztgZuPnDSU3xYyKV0UoEkMbBG9
        8FvngSXs9xp3PHf42lozhrcjzabobyhRcnviE81rqFKQplPOIw7F0V780HBVP8zUZgVfMd8qvYVwk
        f0FQnKXxuFjUaQ0l+pDVMpLnf+IYE31tB0zyY0vOJBP4NKTNG+6x3gGvtmzPu2MxIQu4cKOjn/cTQ
        XQl1Y9yAh7qOmidmqUVqnuRoaPxrbhUY8+lIspdI5yDPg75xAekWuJnezFqQkM2DteNjC4+qRD9lJ
        IU2mAFkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltZPG-008IwK-7F; Wed, 16 Jun 2021 17:32:58 +0000
Date:   Wed, 16 Jun 2021 18:32:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Janghyuck Kim <janghyuck.kim@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Gavin Shan <gshan@redhat.com>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: support fastpath if NUMA is enabled with numa off
Message-ID: <YMo1wik1plVotC1N@casper.infradead.org>
References: <CGME20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38@epcas2p3.samsung.com>
 <20210616083745.14288-1-janghyuck.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616083745.14288-1-janghyuck.kim@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:37:41PM +0900, Janghyuck Kim wrote:
> Architecture might support fake node when CONFIG_NUMA is enabled but any
> node settings were supported by ACPI or device tree. In this case,
> getting memory policy during memory allocation path is meaningless.
> 
> Moreover, performance degradation was observed in the minor page fault
> test, which is provided by (https://lkml.org/lkml/2006/8/29/294).
> Average faults/sec of enabling NUMA with fake node was 5~6 % worse than
> disabling NUMA. To reduce this performance regression, fastpath is
> introduced. fastpath can skip the memory policy checking if NUMA is
> enabled but it uses fake node. If architecture doesn't support fake
> node, fastpath affects nothing for memory allocation path.

This patch doesn't even apply to the current kernel, but putting that
aside, what's the expensive part of the current code?  That is,
comparing performance stats between this numa_off enabled and numa_off
disabled, where do you see taking a lot of time?

