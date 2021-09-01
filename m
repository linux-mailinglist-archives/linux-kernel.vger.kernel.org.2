Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAFC3FE3F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhIAUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:25:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56488 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhIAUZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:25:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01E52202E2;
        Wed,  1 Sep 2021 20:24:32 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B66313B03;
        Wed,  1 Sep 2021 20:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F//bCH7hL2FmBgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 01 Sep 2021 20:24:30 +0000
Date:   Wed, 1 Sep 2021 13:24:25 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] futex: fix assigned ret variable that is never read
Message-ID: <20210901202425.v5sym64dqjzakimb@offworld>
References: <20210818131840.34262-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210818131840.34262-1-colin.king@canonical.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021, Colin King wrote:

>From: Colin Ian King <colin.king@canonical.com>
>
>Currently the check on the rt_waiter and top_waiter->pi_state is
>assigning an error return code to ret but this later gets re-assigned,
>hence the check is currently ineffective. I believe the original
>intent was to return -EINVAL rather than assign it to ret. Fix this.

LGTM.

Acked-by: Davidlohr Bueso <dbueso@suse.de>

>
>Addresses-Coverity: ("Unused value")
>Fixes: dc7109aaa233 ("futex: Validate waiter correctly in futex_proxy_trylock_atomic()")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> kernel/futex.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/futex.c b/kernel/futex.c
>index e7b4c6121da4..30e7daebaec8 100644
>--- a/kernel/futex.c
>+++ b/kernel/futex.c
>@@ -2025,7 +2025,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
>	 * and waiting on the 'waitqueue' futex which is always !PI.
>	 */
>	if (!top_waiter->rt_waiter || top_waiter->pi_state)
>-		ret = -EINVAL;
>+		return -EINVAL;
>
>	/* Ensure we requeue to the expected futex. */
>	if (!match_futex(top_waiter->requeue_pi_key, key2))
>--
>2.32.0
>
