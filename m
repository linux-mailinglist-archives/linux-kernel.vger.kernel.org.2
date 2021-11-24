Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E345CD47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349607AbhKXThE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbhKXThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:37:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF595C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:33:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637782430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90FvGVC7EdAPtxotR5UqHdHI/PU1RpDaH4xpC6rggH8=;
        b=GiTKoYLOTLu5h5l8EPUjnl3hV4ourWpcOPZP2oLGheLOr6PuUCHJKRGErjGxPpVNz2SYFj
        Gf9+ezCuMUMm8n+zrLA80+m6ncwGxSDzvNRD5NflIkSdEUJjeLUH3X//pYZqBzyV6nE7JR
        L47vfeucr74FxTW/qwHREhcG8M/O/NzZ9LSGuaNMOBjMAJrvOLEgfzNt+ja+WK6KefW4b6
        KLsZxKXPdZ0zlOIJ5A9581ddX/KgaiQgPXKdcXZCuISVlyMNH6P9y9psYcwk6eTHcBmjML
        W5q/XFzfYyEFpK7vJoDW0yGypiwtwDBvlWYoES9QQ3lM1Kn0vrBAwZbnEIB/9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637782430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90FvGVC7EdAPtxotR5UqHdHI/PU1RpDaH4xpC6rggH8=;
        b=Lcjxq+vgNfWTD+GVekF/3fmjiSkoCtgBN42H4MzM9oJks0+NKkNAyPzyl0HtfVugPdvphY
        mGvcQ+FVLpvjjzBw==
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, yamamoto.rei@jp.fujitsu.com,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <maz@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] irq: consider cpus on nodes are unbalanced
In-Reply-To: <20211029082730.6728-1-yamamoto.rei@jp.fujitsu.com>
References: <20211029082730.6728-1-yamamoto.rei@jp.fujitsu.com>
Date:   Wed, 24 Nov 2021 20:33:49 +0100
Message-ID: <878rxdl55u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rei,

On Fri, Oct 29 2021 at 17:27, Rei Yamamoto wrote:

Cc'ing a few people who worked on this code.

> If cpus on a node are offline at boot time, there are
> difference in the number of nodes between when building affinity
> masks for present cpus and when building affinity masks for possible
> cpus. This patch fixes 2 problems caused by the difference of the
> number of nodes:
>
>  - If some unused vectors remain after building masks for present cpus,
>    remained vectors are assigned for building masks for possible cpus.
>    Therefore "numvecs <= nodes" condition must be
>    "vecs_to_assign <= nodes_to_assign". Fix this problem by making this
>    condition appropriate.
>
>  - The routine of "numvecs <= nodes" condition can overwrite bits of
>    masks for present cpus in building masks for possible cpus. Fix this
>    problem by making CPU bits, which is not target, not changing.
>
> Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
> ---
>  kernel/irq/affinity.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index f7ff8919dc9b..1cdf89e5e2fb 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -267,10 +267,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  	 * If the number of nodes in the mask is greater than or equal the
>  	 * number of vectors we just spread the vectors across the nodes.
>  	 */
> -	if (numvecs <= nodes) {
> +	if (numvecs - (curvec - firstvec) <= nodes) {
>  		for_each_node_mask(n, nodemsk) {
> +			unsigned int ncpus;
> +
> +			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> +			ncpus = cpumask_weight(nmsk);
> +			if (!ncpus)
> +				continue;
>  			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
> -				   node_to_cpumask[n]);
> +				   nmsk);
>  			if (++curvec == last_affv)
>  				curvec = firstvec;
>  		}
