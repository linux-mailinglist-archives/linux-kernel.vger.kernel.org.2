Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759E038C57F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhEULPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhEULPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:15:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30506C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0/gKbT4XPFGT8RdAbzxdXpYucSr4PKIBU2GcTbdSPyY=; b=jp67YWLBHzZUsrUc2u4j6lk9GK
        P1lQ502wb5oOwh9upczZ9udmH9BARgepMuAH9kP4ue2C6qM5E5gM7i3cR+0hFXgPN+ez6F0+aYTFa
        2kjneMcqYZs+9lZhRUlTULdQicq6fASyE5w4lZiP3r0QtxRPUPq3qFafWIfbygOrSSXuCL9EMbXAV
        aq3yeNUk9rAnJ3SMPVJq/RI6Nmu91Hvxmo2rLfM0E2ieKaiOmyk7Rk+d8bE8TaBUMP2R/+y3kjXl5
        JXTIrEkTKz4p/tWTxm9M7gf9p4Ps6aF9cUIDhRRQv5LY8jWtERADBteB7FzRWlW5+h9i0TNT39EpC
        M9rc3odQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lk34B-00Gu9m-2w; Fri, 21 May 2021 11:12:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4082300103;
        Fri, 21 May 2021 13:11:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A33743119BA4F; Fri, 21 May 2021 13:11:42 +0200 (CEST)
Date:   Fri, 21 May 2021 13:11:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] notifier: Return non-null when callback already
 registered
Message-ID: <YKeVbsLnAdpVUwAa@hirez.programming.kicks-ass.net>
References: <20210520202033.23851-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520202033.23851-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:20:33PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> The notifier registration routine doesn't return a proper error value
> when a callback has already been registered, leading people to track
> whether that regisration has happened at the call site:
> 
>   https://lore.kernel.org/amd-gfx/20210512013058.6827-1-mukul.joshi@amd.com/
> 
> Which is unnecessary.
> 
> Return a non-null to signal that case so that callers can act
> accordingly.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  kernel/notifier.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index 1b019cbca594..ff7a3198c5fc 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -25,7 +25,7 @@ static int notifier_chain_register(struct notifier_block **nl,
>  	while ((*nl) != NULL) {
>  		if (unlikely((*nl) == n)) {
>  			WARN(1, "double register detected");

That should give a big clue^

> -			return 0;
> +			return 1;

How about -EBUSY here?
