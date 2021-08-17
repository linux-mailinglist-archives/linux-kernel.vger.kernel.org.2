Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C03EE9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhHQJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhHQJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:34:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDC6C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 02:34:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 11:34:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629192849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IZ6fACXUc9apVwlz8xHJ8mN1EdefFeUDadYvHeqk1X4=;
        b=3s8hAMQiMxa0vuIbKYwmkRIGf5kGXAurxh8BLI70WIR9mypWnYmZkIB/13g+wBQDJbJLmH
        PQyQF5ETYv+GrOHioyMtiadHUKVFELfNY0HCkz1GKFpQXWBb6a2BHiMzAXun2SJyCSwZ+n
        uA+jbQ+TpfovebZqJfOQ4qyhpbBEt2rWb/HY16Jui4OhgSfGDzpTJjsuVgQKNUnY0EzjZ5
        0hQflpoZYWg/be0Hue5mF19r63WQKEhh7fnkUM0GZwjpuV1ohB7IV5lVN6ps94PemKnV9i
        E9f5krH4zdz4jC52TfcnBiyi0Y0IwToD1rop0g2qQwuEDV99uCdaktcDB9Dtvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629192849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IZ6fACXUc9apVwlz8xHJ8mN1EdefFeUDadYvHeqk1X4=;
        b=bIGH2L88+AIsWN+iUd3kfGlZWpIcGLdQNkfOtDLmSa5eYpElsoU8Q4iTmGYdJJayifC69g
        vAWEvEJW849aIxCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sven Eckelmann <sven@narfation.org>, akpm@linux-foundation.org,
        brouer@redhat.com, cl@linux.com, efault@gmx.de,
        iamjoonsoo.kim@lge.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, penberg@kernel.org,
        rientjes@google.com, tglx@linutronix.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
Message-ID: <20210817093408.zanfoybsbnrdnav7@linutronix.de>
References: <2666777.vCjUEy5FO1@sven-desktop>
 <7329198a-2a4e-ebc2-abf8-f7f38f00d5e1@suse.cz>
 <20210817091224.nqnrro34cyb67chj@linutronix.de>
 <3da13f0a-2720-a38c-33a7-744668013390@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3da13f0a-2720-a38c-33a7-744668013390@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 11:31:56 [+0200], Vlastimil Babka wrote:
> On 8/17/21 11:12 AM, Sebastian Andrzej Siewior wrote:
> > On 2021-08-17 10:37:48 [+0200], Vlastimil Babka wrote:
> >> OK reproduced. Thanks, will investigate.
> > 
> > With the local_lock at the top, the needed alignment gets broken for dbl
> > cmpxchg.
> 
> Right. I wondered why the checks in __pcpu_double_call_return_bool
> didn't trigger. They are VM_BUG_ON() so they did trigger after enabling
> DEBUG_VM.

Without the right debugging enabled

| typedef struct {
| #ifdef CONFIG_DEBUG_LOCK_ALLOC
|         struct lockdep_map      dep_map;
|         struct task_struct      *owner;
| #endif
| } local_lock_t;

the struct is just empty.

Sebastian
