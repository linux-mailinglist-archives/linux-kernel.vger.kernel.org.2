Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E0533FA09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhCQUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:38:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52806 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhCQUic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:38:32 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616013511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yjql/aOMJbjlnHwFwLzLLfx54fAPIBQNZbBTEZhesWI=;
        b=eJZZczjb8BMBYkxGC7Qs1trHgm765FNLInG0nmLubFvi7s+hypJjiFF1DyVp3/tswjYe/y
        51TevoCSUAbOKfBwxlOng4QWXcayNgQex+Z5BZJ0jXLx0KUTcQewOy1XghtLZlwHosNjnv
        xN4FVxYAxEqbvw3TN31DFdopomublgU4MNpT8bBlI2KDG455EAo0JozlWfWuIZJqr2T0hq
        rtoPpJUd96ThaSkdaZNn0F/zXPYZac/vFc5ECOZPeLgzOjpLyuqZ3wozrsYNpR4RZY3PRt
        9sU9Bd2Nj/rjmV7PbihvoVYJOgrBaB0aO2pyCTR57EMQKzlrLBayBP1SXpZFmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616013511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yjql/aOMJbjlnHwFwLzLLfx54fAPIBQNZbBTEZhesWI=;
        b=9r1SBHMjWT0T7jqbgqIcvxMmSHaypZjk2iY7ux2u9hwSaTNBJt1vluEhQtd2CbGEONUKL3
        a77Rdu60lep/RRDg==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] genirq/matrix: WARN_ON_ONCE() when cm->allocated/m->total_allocated go negative
In-Reply-To: <20210219113101.967508-3-vkuznets@redhat.com>
References: <20210219113101.967508-1-vkuznets@redhat.com> <20210219113101.967508-3-vkuznets@redhat.com>
Date:   Wed, 17 Mar 2021 21:38:30 +0100
Message-ID: <87eegdy0qh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19 2021 at 12:31, Vitaly Kuznetsov wrote:

> When irq_matrix_assign()/irq_matrix_free() calls get unsynced, weird
> effects are possible, e.g. when cm->allocated goes negative CPU hotplug
> may get blocked. Add WARN_ON_ONCE() to simplify detecting such situations.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  kernel/irq/matrix.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
> index 651a4ad6d711..2438a4f9d726 100644
> --- a/kernel/irq/matrix.c
> +++ b/kernel/irq/matrix.c
> @@ -189,7 +189,9 @@ void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit,
>  	set_bit(bit, m->system_map);
>  	if (replace) {
>  		BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
> +		WARN_ON_ONCE(!cm->allocated);
>  		cm->allocated--;
> +		WARN_ON_ONCE(!m->total_allocated);

This hunk is not really useful. It already dies when the bit is not set
in the alloc map.

>  		m->total_allocated--;
>  	}
>  	if (bit >= m->alloc_start && bit < m->alloc_end)
> @@ -424,12 +426,17 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
>  		return;
>  
>  	clear_bit(bit, cm->alloc_map);
> +	WARN_ON_ONCE(!cm->allocated);
>  	cm->allocated--;

WARN and then decrement is not necessarily any better than just
decrementing unconditionally. It's just more noisy.

Why would you let the counter wrap into negative space if you already
know it's 0?

There is a way more useful way to handle this. In such a case the bit is
NOT set in the alloc map. So:

    if (!WARN_ON_ONCE(test_and_clear_bit(bit, cm->alloc_map)))
    	   return;

would have caught the problem at hand nicely and let the machine survive
while just throwing warns and continuing is broken to begin with.

Thanks,

        tglx
