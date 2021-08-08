Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647953E3C40
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 20:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhHHSns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 14:43:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44582 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhHHSns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 14:43:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 785501FD6F;
        Sun,  8 Aug 2021 18:43:27 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C53A413398;
        Sun,  8 Aug 2021 18:43:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cS6DIcwlEGGoHwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Sun, 08 Aug 2021 18:43:24 +0000
Date:   Sun, 8 Aug 2021 11:43:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 58/64] futex: Clarify comment in futex_requeue()
Message-ID: <20210808184320.zytackz5nf37brqu@offworld>
References: <20210805151300.330412127@linutronix.de>
 <20210805153956.161214930@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210805153956.161214930@linutronix.de>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021, Thomas Gleixner wrote:

>From: Thomas Gleixner <tglx@linutronix.de>
>
>The comment about the restriction of the number of waiters to wake for the
>REQUEUE_PI case is confusing at best. Rewrite it.

This certainly reads better.

>
>Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>---
> kernel/futex.c |   28 ++++++++++++++++++++--------
> 1 file changed, 20 insertions(+), 8 deletions(-)
>---
>--- a/kernel/futex.c
>+++ b/kernel/futex.c
>@@ -1960,15 +1960,27 @@ static int futex_requeue(u32 __user *uad
>		 */
>		if (refill_pi_state_cache())
>			return -ENOMEM;

Perhaps this can be moved after the nr_wake check below? No sense
in calling refill_pi_state_cache() if the user is passing bogus
parameters.

>		if (nr_wake != 1)
>			return -EINVAL;
>

Thanks,
Davidlohr
