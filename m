Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF76A383A82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhEQQvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240985AbhEQQvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:51:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5810B611C2;
        Mon, 17 May 2021 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621270204;
        bh=De3YhfTavFJB9q9QnY+jZUdZt1l8lHhABcXtG5g8ouQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AMOcvHR0DY0ceW5eQfxugFxPq+dtloHhN+L2DAJAJHzLzIT5gUztLvFHFMyUZ/NDg
         vPJJBajQQvM8QQZOxo8ZkW5wNVVnKaVKDFofNeHZ91AMmoSLxm3lEUvKQcMXovneI+
         qFYPgyZZ/Qq77HYXlTZBQghLKQLjpwzdJZ6268uGuceFKy6Y+w2DhXp5Pr9HWxkn2v
         a1jT2RkH0rNjsnb54fgeq41037IX35QCqJl7VcYFK2+osh9x4Z5jnaTRXCFfdT1PB4
         mcykzb0sDTP8wpSxXDu9uzn4hyOnGttX/K19Gb0hmod0S2SV9PBPoFRTvu5aie2jBg
         ilP9H+EtVXXPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 204F75C00C6; Mon, 17 May 2021 09:50:04 -0700 (PDT)
Date:   Mon, 17 May 2021 09:50:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: RCU tests for Maple Tree
Message-ID: <20210517165004.GI4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210517154048.GA2013926@paulmck-ThinkPad-P17-Gen-1>
 <20210517163048.7zcg2435lsvg25ef@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517163048.7zcg2435lsvg25ef@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:30:53PM +0000, Liam Howlett wrote:
> * Paul E. McKenney <paulmck@kernel.org> [210517 11:40]:
> > Hello, Liam!
> > 
> > Apologies for my being so slow here, but just wanted to double-check my
> > understanding of this code.
> > 
> > There appear to be two tests that execute from run_check_rcu():
> > 
> > o	rcu_loop().  This appears to have RCU readers scanning the tree
> > 	while an updater is adding a single range.  (Or replacing it,
> > 	as the case might be.)
> > 
> > o	rcu_val().  This appears to have RCU readers repeatedly reading a
> > 	given value while an updater is adding/replacing a single range.
> > 	The test complains if no one sees the new value.
> > 
> > These tests appear to be the only use of threads, though perhaps the
> > test harness has some way of creating threads that I missed.
> > 
> > Are there other tests that I should be looking for?
> 
> No, those are the only ones I'm running with threads right now.  I think
> all RCU tests are run from check_rcu() iirc.  This did yield results of
> failures that had to be addressed so I'm somewhat confident that it's
> actually working.

OK, I guess I can feel relieved that I can still read code.  ;-)

> >From your wording I'm gathering I need to increase this by a lot more
> test cases?

I would feel better with the addition of something that looked more
like a stress test.  For but one example, is there some combination
of several successive update operations that can mess up slow readers
(that is, readers that are interrupted or preempted, and thus have
multiple updates happen while they are traversing the tree)?  If so,
the current tests will not find it.

							Thanx, Paul
