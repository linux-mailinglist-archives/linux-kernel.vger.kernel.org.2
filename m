Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DEF4149B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhIVMyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbhIVMyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:54:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gOtWAXPkE7Jj3zHwPpD9L8jpJqEQe61GW4OZCLnfXu8=; b=T6k6X8N6TpTAULuPbBYFusFr6Y
        wN1+Ep0dx6NRS7ZQP3gzw4LXacV/Nxv2aSHrOxkoVCyCOFa3MYNE529OjLILlbaxJHlv6DrkYhk3P
        HgGkxjniiZyYGu6mMJOYXoq9vGBX1i580z6KrQ/2x7byxNvPJw/4ZT1Sxs78LpEOU4HJxRHViUNFq
        ES93j2NQr3HSoufcQcbKxiRhKC+A2GX07wND35dvlb5k1r4M6IbyFRa+lqTw1zlPvqpXkdgWu+zET
        MJuEGRJnM5c+p9Ihiw9LPFVZOc+NizeX6f1TU+J1mWJ5lp5tDFwRqygoF2xfWDcD4+GqLtYl66cbR
        YPBaTFcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT1hq-004nD9-Jr; Wed, 22 Sep 2021 12:50:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39A2B9816EA; Wed, 22 Sep 2021 14:50:34 +0200 (CEST)
Date:   Wed, 22 Sep 2021 14:50:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Make cookie functions static
Message-ID: <20210922125034.GS4323@worktop.programming.kicks-ass.net>
References: <20210922085735.52812-1-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922085735.52812-1-zhangshaokun@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 04:57:35PM +0800, Shaokun Zhang wrote:
> Make cookie functions static as these are no longer invoked directly
> by other code.

Yeah, this was supposed to get used from the cgroup code, but that never
happened. I suppose we can do this for now, easy enough to revert
if/when etc..
