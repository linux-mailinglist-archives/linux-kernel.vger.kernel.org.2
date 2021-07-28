Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7F3D9708
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhG1UrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbhG1UrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:47:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D29946023D;
        Wed, 28 Jul 2021 20:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627505240;
        bh=sUr9rUMhKmkWqkvIgSpyknDGwP3uVqdQ3DgS/1MhoDU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hlPrHFlKqp1KEi8yeYEu4CFuqn+n3pv6Nv8u+qx/kqIrC4S5VI3oOvRZCP4wtqcX4
         6cIkMOcqeNBLlScKgKLlSQdal4mG9Q5GkFHqVgYeVjsgZ8YogFqmrcYdL9mGti/YUu
         lrlRj8P5QV/sFFUtumc5tyzfjtdnQXxmo2se32vrghw15834KkOj2DZHZtWt/c8nLe
         UMsP27sNIEGuoAvuU1VAyDBGnIsv/XFwjDhph43+Fq9xJy9P+VCDMmuTr5y+/FTRcn
         ecnlRgUkQxeVWa3UR7KG7Svom0IltQ6bcp4uAkKRX1RaZQJGhKO4glfFUIuGsMbqPY
         d8PhryUM3Dviw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ACB355C048D; Wed, 28 Jul 2021 13:47:20 -0700 (PDT)
Date:   Wed, 28 Jul 2021 13:47:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210728204720.GN4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <YQG//899pPl2JIWw@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQG//899pPl2JIWw@localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:37:19PM -0700, Josh Triplett wrote:
> On Wed, Jul 28, 2021 at 10:37:15AM -0700, Paul E. McKenney wrote:
> > This change makes the memory ordering requirements
> > more evident, and it might well also speed up the to-idle and from-idle
> > fastpaths on some architectures.
> 
> Cleaning up the memory ordering requirements certainly seems worthwhile.
> But is there any straightforward benchmark that might quantify the
> "might well also speed up" here? How much does weakening the memory
> ordering buy us, in practice?

None that I know of!

							Thanx, Paul
