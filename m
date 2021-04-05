Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0A353A3A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 02:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhDEA3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 20:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231693AbhDEA3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 20:29:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97C0E61393;
        Mon,  5 Apr 2021 00:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617582575;
        bh=pmtpTDqR2nGCmr0Vop6k1ed2SfbfuyXUT6VyzaqmPFo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d3Mui+TTGdFhE063lyhluObE1WI/64sv5Vg8/FgkKyx+LFGMqNiQp5PfcRbh5S1Qq
         E40QZ8Gex8/+Ic12qt3wAc+C3dRxNR5+J8b7kPmvVumwiOwpVua6cn0Q87QrN6yxx2
         fdUsKH1AlKEDsKN3SVu4Umc2DPoF8Ytj0V3u1Q9RP3s+8LqXHrNGEyCbNRkfjrZUxT
         AvsCUfEcMnxNhoJA5AB0SjHRnQYJj+GwzY3pxYR2zku3aK/lZgJZfTO6Mt9yB6iHUJ
         1XMpFGpdGTZrDFyBe2wUJP7JyYkHhgrf1CQ3PxZKw7Bxw+AszRIsciOqmNAO2kGgRa
         3ergUJpMFvIUw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5F9E83522F84; Sun,  4 Apr 2021 17:29:35 -0700 (PDT)
Date:   Sun, 4 Apr 2021 17:29:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] doc: Fix mistaken diagram references in RCU
Message-ID: <20210405002935.GD2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210404215843.8413-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404215843.8413-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 11:58:43PM +0200, Frederic Weisbecker wrote:
> The 3 diagrams describing rcu_gp_init() all spuriously refer to the same
> figure, probably due to some copy/paste issue. Fix the references.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> index 3f6ce41ee0c5..11cdab037bff 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> @@ -339,14 +339,14 @@ The diagram below shows the path of ordering if the leftmost
>  leftmost ``rcu_node`` structure offlines its last CPU and if the next
>  ``rcu_node`` structure has no online CPUs).
>  
> -.. kernel-figure:: TreeRCU-gp-init-1.svg
> +.. kernel-figure:: TreeRCU-gp-init-2.svg
>  
>  The final ``rcu_gp_init()`` pass through the ``rcu_node`` tree traverses
>  breadth-first, setting each ``rcu_node`` structure's ``->gp_seq`` field
>  to the newly advanced value from the ``rcu_state`` structure, as shown
>  in the following diagram.
>  
> -.. kernel-figure:: TreeRCU-gp-init-1.svg
> +.. kernel-figure:: TreeRCU-gp-init-3.svg
>  
>  This change will also cause each CPU's next call to
>  ``__note_gp_changes()`` to notice that a new grace period has started,
> -- 
> 2.25.1
> 
