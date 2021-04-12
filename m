Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84035C8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbhDLO3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:29:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbhDLO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:29:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618237768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=ir1a5pcI6hvlmi/+nshHENDS+iFVrw4hNYIaGGZaApE=;
        b=diyQzeR72OWGCKCir1W9aPmtuSDrzArSDaa6eC9Z+YrGao/lsVUswKO+40MuNF3NeCGJE5
        gBINLwSBR/CHhJMoc/fJEqf1rR4Tj3h37jbrzMS0iT+A+xgP8XiNcJFFuAfP7ixxFdEjMY
        xg2VMI+Sv8FKiUlcv6nIh435mG9u5YjzQqplMWDSRzC13W0ZrVBPBr5qYQTTB6pU/90pLI
        uVkAGpZ3xW7QHpJ5xhIYK7N80AU/2ZpzRtDe7mdjaIVR3ElwLfw71cwKbh/hc48vf6VUka
        EQ2UTl9NxycaUhgOyFdWvLe9RMffWsHRFp2zEP80KVKwqY5EP11Xkux2dRl4Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618237768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=ir1a5pcI6hvlmi/+nshHENDS+iFVrw4hNYIaGGZaApE=;
        b=U8xbT79vc3nF9bEXGZyBC8oZfldj63wGrLLptGk+q6pzp9V033nDwga0O6E4rZaTH2BKz8
        TzhkTkE9xXdGDPAg==
To:     "Matthew Wilcox \(Oracle\)" <willy@infradead.org>
Cc:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] locking: Add split_lock
In-Reply-To: <20210409025131.4114078-3-willy@infradead.org>
Date:   Mon, 12 Apr 2021 16:29:28 +0200
Message-ID: <87blaj1sqf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09 2021 at 03:51, Matthew Wilcox wrote:
> Bitlocks do not currently participate in lockdep.  Conceptually, a
> bit_spinlock is a split lock, eg across each bucket in a hash table.
> The struct split_lock gives us somewhere to record the lockdep_map.

I like the concept, but the name is strange. The only purpose of 

> +struct split_lock {
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map dep_map;
> +#endif
> +};

is to have a place to stick the lockdep map into. So it's not a lock
construct as the name suggests, it's just auxiliary data when lockdep is
enabled.

I know you hinted that RT could make use of that data structure and the
fact that it's mandatory for the various lock functions, but that's not
really feasible if this is related to a hash with a bit spinlock per
bucket as the data structure is hash global.

Sure, we can do pointer math to find out the bucket index and do
something from there, but I'm not sure whether that really helps. Need
to stare at the remaining few places where bit spinlocks are an issue on
RT.

Thanks,

        tglx


