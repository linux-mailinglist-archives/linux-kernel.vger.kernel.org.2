Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4F37B986
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhELJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELJsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:48:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3A5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:47:16 -0700 (PDT)
Date:   Wed, 12 May 2021 11:47:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620812835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ySA3aSsj20Cn6C9T/IKLrCmJdYiO5OTnDgVQE6/spek=;
        b=iVYG7JT5QdXWcOtzkHdMkMqOnJtWdyKBOkjqb61Mm2stIKfY/nGTz8Bs7HJZ6yG+1Iy1OZ
        em+Esu3nRhmwR+jCzIvUjE7JxaccevO6j5gsH9Qqxwx8QfUSo6AzfuvbXTFdjumxRommmg
        xQpvRGdlujLDP0r4hoscvB2gXlc1m6GYVT9A/FhuNWo2l7TJDqc3fc4+BVg2NEfMxDYAWZ
        CKTutevaETAy0iD45HJvL3TUU3W0ooNgGbHVJbf+APSYObPI2bsAuAVd/2kopDKfgJrGKi
        9ULxATVBamqXccQYlhdw+5QIGCai7ZqW5IAa/pauznWrTz6MYa6+eU76eBjGOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620812835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ySA3aSsj20Cn6C9T/IKLrCmJdYiO5OTnDgVQE6/spek=;
        b=sSMRvYiC0dJFDYa9e4SzV3B7TCWegK5Anu3mwGk8YTtOULF92G59V913O24UwF4twoOiFK
        lKPyck4Ghah2C6DQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     bigeasy@linutronix.de, peterz@infradead.org, tglx@linutronix.de,
        shung-hsi.yu@suse.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] seqlock,lockdep: Only check for preemption_disabled in
 non-rt
Message-ID: <YJukIUXFVdp1Fr7t@lx-t490>
References: <20210507233951.78950-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507233951.78950-1-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021, Davidlohr Bueso wrote:
> This silences the writer hitting this nonsensical warning on PREEMPT_RT.
>
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  include/linux/seqlock.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index f61e34fbaaea..c8f9253f1a2f 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -268,7 +268,9 @@ static inline bool __seqprop_preemptible(const seqcount_t *s)
>
>  static inline void __seqprop_assert(const seqcount_t *s)
>  {
> +#ifndef CONFIG_PREEMPT_RT
>  	lockdep_assert_preemption_disabled();
> +#endif
>  }
>

Nope, it is more complicated than that.

In general, for RT, seqcount_LOCKNAME_t variants should be used instead
of plain seqcount_t, as they can be safely used while preemption is
enabled on the write side.

For plain seqcount_t (which __seqprop_assert() is about), preemption
must be disabled, even for PREEMPT_RT. So the patch above is invalid.

Now, there are still some call sites in the kernel which needs
conversion obviously. I have a large patch series in queue which convert
a number of remaining networking call sites (the changes are locking
algorithm changes, not just direct substitution).

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
