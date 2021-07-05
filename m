Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF13BBECF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhGEPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhGEPYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:24:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 204BA61964;
        Mon,  5 Jul 2021 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625498501;
        bh=THseaQgjU2+y6NfeKYm0CL8Lzo+LwsyR7ZelOw0YQSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX4XEFFfA32WqrwBY+Ad9SF6YpaH86mzk4LTr7E7JrcnhX+F9zITx5oyWNv7a7lVU
         eu3N9k+5Em2t4JGBPFcJD1/eNdROvhPy6Do/f16K0H4up4lY1EWeXT5OvkA69ytsyb
         80YdYKLkL9WyNp61wsEBZXqva3sIXa6LDTuQ2Ee9UarisWj13K/+W8/WandjLn/rUv
         WoJ/R+bjQiKQSmNnXZBIiQFh8iRKII3wgdJByQri+VwXq9FK3P356tOsd/qjgRLNbQ
         K+YSErePd7PJFKSufys1NZy5lblwv09u//hO0czMilshGz2LuGyhalKFHcuhS+ED05
         xgCfpj47hvJYw==
Date:   Mon, 5 Jul 2021 16:21:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Xu, Yanfei" <yanfei.xu@windriver.com>, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/atomic_t: Document cmpxchg() vs
 try_cmpxchg()
Message-ID: <20210705152136.GA19127@willie-the-truck>
References: <20210630153516.832731403@infradead.org>
 <20210630154114.834438545@infradead.org>
 <cac55711-585a-4e08-3b5e-a6890e2f548d@windriver.com>
 <YOMQYQr1loxIuZbU@hirez.programming.kicks-ass.net>
 <YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 05:07:41PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 05, 2021 at 04:00:01PM +0200, Peter Zijlstra wrote:
> 
> > No, when try_cmpxchg() fails it will update oldp. This is the reason old
> > is now a pointer too.
> 
> Since you're not the first person confused by this, does the below
> clarify?
> 
> ---
> Subject: Documentation/atomic_t: Document cmpxchg() vs try_cmpxchg()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Jul  5 17:00:24 CEST 2021
> 
> There seems to be a significant amount of confusion around the 'new'
> try_cmpxchg(), despite this being more like the C11
> atomic_compare_exchange_*() family. Add a few words of clarification
> on how cmpxchg() and try_cmpxchg() relate to one another.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/atomic_t.txt |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

With the "CMPXHG" typo fixed:

Acked-by: Will Deacon <will@kernel.org>

Will
