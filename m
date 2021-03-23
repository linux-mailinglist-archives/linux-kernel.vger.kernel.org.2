Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFA93464E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhCWQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233167AbhCWQUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:20:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54572600EF;
        Tue, 23 Mar 2021 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616516445;
        bh=4SOpkTuDA9eYZ16hzZgMyAqwgp/dr3nrBLtmwkmitb0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=os4RkiXLH9pS3aDbilF8+IMltkV3srVdqbWMdAs8Y9r5Vg6sBUy3MhfWkXMGyrSrz
         h7nMOwpWmvCLev28WoJZsLY8zf7Hljbncn/sR59MicTCuDiZx28ohwv4IWZxLsuOGe
         n8coOf3oai1cbPlRZ1rVFUQaBPjwQGAv1mwr6OlLeuQdw8N+i1lN/01TUPdY02SSUJ
         atEh2q6SIZenp/0LKQVJ8EHwv28CWqTHdGV+PHE6yvtD43/hEQZ3/P9I2oFfq02fLs
         v/Cpx2sTNdQRRn3VFt486S0kjI1j81ZP0zOrV6awukXGM8p+tg+9sO3nxyyBtuYYUL
         m0ckrXdxogQgQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1EE34352261C; Tue, 23 Mar 2021 09:20:45 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:20:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] rcu: Fix various typos in comments
Message-ID: <20210323162045.GX2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210322230258.GA1983587@gmail.com>
 <YFlYzkY7h+OD0WCb@ArchLinux>
 <20210323053618.GU2696@paulmck-ThinkPad-P72>
 <20210323111753.GB3939639@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323111753.GB3939639@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:17:53PM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > > >  * there are no read-side primitives analogous to rcu_read_lock() and
> > > >  * rcu_read_unlock() because this primitive is intended to determine
> > > >  * that all tasks have passed through a safe state, not so much for
> > > > - * data-strcuture synchronization.
> > > > + * data-structure synchronization.
> > > >  *
> > > 
> > > The "hyphen" in the middle of the word "data structure" is required or keeping by
> > > convention or has some significance?
> > 
> > Yes, this is one of many peculiarities of English, and an optional one
> > at that.  English is not a block-structured language, so grouping can
> > be ambiguous.  Is is "(data structure) synchronization" or is it instead
> > "data (structure synchronization)"?  The default is the latter, and
> > the hyphen indicates the former.  In this case, the former is intended,
> > hence the hyphen.
> 
> The other point is that there are a *lot* of hyphen variations in the 
> kernel, and unless the primary author or maintainer is iterating the 
> text would be insane to categorize them as 'typos' and create churn to 
> 'fix' them...
> 
> 'data-structure' or 'datastructure' are both perfectly readable, just 
> like 'fast-path' or 'fastpath', 'cache-miss' or 'cachemiss' and a 
> million other examples.

Agreed.  Plus even though "data structure initialization" would look
funny to me, I would know what was meant.  And even automated systems
that fix typos have some chance of creating other typos, as I have
recently had considerably experience with.  ;-)

							Thanx, Paul
