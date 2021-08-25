Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C152C3F751A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbhHYMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhHYMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:34:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF8C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iMWexHkxQK+v4WvwMV6Vf/g3mdTQ/M0VOYENuF1dePo=; b=o93qyg1tsRVJD6ldO2cElTsLGn
        T8PWSZ5Rt4iHvEs5NnjktYvpVoYgHaD7WOIAZ6lZ4+plS9i7M1aV83kKWOiqS4aG5yAaqz7gOlbR1
        e8yeF4vZ3y8PJfNTUFR0DfLR/Vx2AWWDJ4lRMaN/mi0eyNQ6ZHiE7MRmvUMfOriGtzNvLuljuTxVT
        fkoBmBdLdd06S8gmZZidS1O/umcmz1zzBu92YY/9DaQ1+HvkXYAVXoG8avutOV7mRHENfLK9tqHkM
        xkpHK4JIG5+lkzu8IlQOZiv8bwx9sWIDsj+Z5+ajA8sHTZedorRwsN2vEHcbLwx4DYWmgQAvwiRLt
        WzL40F7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIs5H-00CIB5-GW; Wed, 25 Aug 2021 12:32:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B4D3300252;
        Wed, 25 Aug 2021 14:32:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B13E20EEFE52; Wed, 25 Aug 2021 14:32:47 +0200 (CEST)
Date:   Wed, 25 Aug 2021 14:32:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Li RongQing <lirongqing@baidu.com>, dbueso@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: stop iteration early in rb_find_first
Message-ID: <YSY4byZYxId7k0ow@hirez.programming.kicks-ass.net>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org>
 <YSY3nwCY/IDl1hpj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSY3nwCY/IDl1hpj@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 02:29:19PM +0200, Peter Zijlstra wrote:
> More specifically, can you draw me a (binary) tree with elements: A B B
> B C, such that a search for B might have match set, hit c!=1 and not
> have found the leftmost B ?

We crossed emails, you just did :-)
