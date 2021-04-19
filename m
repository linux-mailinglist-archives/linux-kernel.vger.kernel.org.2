Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C521363DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhDSIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbhDSIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:41:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDAC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VzeWP4zJA6xj/Smu+oaSjYCS709eKSRqbaWP/R0qRCg=; b=uqfA8iLMJTaNVhRw7uhIniWw3a
        8CoHZ1ITZJ4cv0SuY9xvtxOFt9Nvsr4fwnFuP27NDNFtQL7pi3+OHUVsjodT5xR121Ricgxhghm8n
        QNeZabGvQgTJizoM6xl4PkHy46pNGxUUl4Av3n7AUkXdtVAePuBDUNnsbUImajXVwUjUa/GnxYrgf
        PlCnVkfhfEWBWodgprx6qF5b/tgR3UrR46qKe09cONkmYs3DBuCxqX3Ky6+zM9WYh8WJ5KleFLPSC
        dxX01MWXXXsKdjzXlLOMLkE/e9+Oj3wojPilqraS2N1P/8RsdUueNuKSuUVn6Q2bkfaxsYGFDv+Jz
        7gBO6zHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYPRG-00DTFv-9V; Mon, 19 Apr 2021 08:39:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 623F130020C;
        Mon, 19 Apr 2021 10:39:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F87F2C14C5BD; Mon, 19 Apr 2021 10:39:25 +0200 (CEST)
Date:   Mon, 19 Apr 2021 10:39:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     tglx@linutronix.de, luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt/dynamic: fix typo in macro conditional statement
Message-ID: <YH1BvajpwWei60Gp@hirez.programming.kicks-ass.net>
References: <20210410073523.5493-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410073523.5493-1-zhouzhouyi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 03:35:23PM +0800, Zhouyi Zhou wrote:
> commit 40607ee97e4e ("preempt/dynamic: Provide irqentry_exit_cond_resched()
>  static call") tried to provide irqentry_exit_cond_resched() static call
> in irqentry_exit, but has a typo in macro conditional statement.
> 
> This patch fix this typo.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Fixes: 40607ee97e4e ("preempt/dynamic: Provide irqentry_exit_cond_resched() static call")

Thanks!
