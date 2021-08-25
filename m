Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46D73F7516
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbhHYMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhHYMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:33:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F67C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P8DLRm8dhb8cxoBJMcofA0/ZqgobKk2ZU1RLjliumBY=; b=utqaDxVqomTlR9GEn/UFXtw9o4
        1ynT7Zz1vSCp69TRqzsYqtl1TBnTaNYhHcSYB+5fJ3kZOFty1KrtheKl4neCW+kk+kwmQnRs1jBQg
        FOYZNFVhS4zRPNFZppE3+H05LPfJNaPnksyzFk3YIEW42Dz6EEUA0KnDkZrKDghr1I3nmkVEnplHM
        rdQWKasGdl77Zw2oolGZHwksE1wxx8iCXxs0ZhsBjRNzDaFXvW1LsQweW89+cSg2lsS+VhrqEDOhf
        oQWO0zIJVHxR727vwe8iYxRv7JJiMw7RZlU00s6041WgGixbLsB2lXpLIw12/3uK1KitDbncrfdnv
        N2/KIjuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIs44-00CI7v-FL; Wed, 25 Aug 2021 12:31:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FD26300593;
        Wed, 25 Aug 2021 14:31:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10F7D2D86274A; Wed, 25 Aug 2021 14:31:32 +0200 (CEST)
Date:   Wed, 25 Aug 2021 14:31:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Li RongQing <lirongqing@baidu.com>, dbueso@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: stop iteration early in rb_find_first
Message-ID: <YSY4I/C4a44W5n+U@hirez.programming.kicks-ass.net>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org>
 <20210825115859.GB4645@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825115859.GB4645@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:58:59AM -0700, Michel Lespinasse wrote:
> Actually, my explanation is wrong too :) but so is the code.
> A failing example would searching 10 in the following tree
> 
> 
>                       10
> 		       /
> 		      5
> 		       \
> 		        10
> 
> The search would stop after visiting node 5, and miss the leaf which
> is the expected node to be returned.

Ah! You're quite right.
