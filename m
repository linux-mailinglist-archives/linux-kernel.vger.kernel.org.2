Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5C344C92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhCVRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhCVRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:00:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27684C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o6v/zfMN7cP3Lwj/tSzWNB8OGnpUUKIljfTnOZ6Had0=; b=FHHq2DkUkE/53iQTvTmDsTq2si
        gTvOn1lx1kbl7J4elBqsc5zqAUrsRrTXTsD8b3Tv2Jey5ICRBLivk3BQXPDQVY42qM7caY6DT/xm9
        Y6DKHwlp7Dj0p0fcH20BPWwWxSm+YnC2fI7H7cHeb+CLGm6+sET1JDbs8y/zkpR05xGvaUQCOQ11r
        /q5NL/mCDOmG5GHSY0Ir//ENZsAKp+zVsqGV3YhKTCsR/lZzxZmv9bwUEhdG7jKwf4KmuT2ICsjbL
        9/70QbZG0RfVGysuZZXzM+ZiViMZg7NrnSghy6GUSh4u4hpZ/Nq49oyGbvhzyVxFnXt6b4RhuDATC
        tufVW+Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lONtU-008oXp-NY; Mon, 22 Mar 2021 16:59:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2967B301A32;
        Mon, 22 Mar 2021 17:59:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D7E62C1677EF; Mon, 22 Mar 2021 17:59:08 +0100 (CET)
Date:   Mon, 22 Mar 2021 17:59:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 2/3] static_call: Align static_call_is_init() patching
 condition
Message-ID: <YFjM3HgyZS14x0m/@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.636651340@infradead.org>
 <f5ce3975-bda6-0e83-3a59-2fac25cc4f08@rasmusvillemoes.dk>
 <YFSxorIVeuA2zCXt@hirez.programming.kicks-ass.net>
 <c4e9dfdf-c83a-3314-8c55-5b2371a56ec8@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e9dfdf-c83a-3314-8c55-5b2371a56ec8@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 03:40:46PM +0100, Rasmus Villemoes wrote:
> On 19/03/2021 15.13, Peter Zijlstra wrote:
> 
> >> Dunno, probably overkill, but perhaps we could have an atomic_t (or
> >> refcount, whatever) init_ref inited to 1, with init_ref_get() doing an
> >> inc_unless_zero, and iff you get a ref, you're free to call (/patch)
> >> __init functions and access __initdata, but must do init_ref_put(), with
> >> PID1 dropping its initial ref and waiting for it to drop to 0 before
> >> doing the *free_initmem() calls.
> > 
> > I'd as soon simply add another SYSTEM state. That way we don't have to
> > worry about who else looks at RUNNING for what etc..
> 
> I don't understand. How would that solve the
> 
> PID1                           PIDX
>                                ok = system_state < INIT_MEM_GONE;
> system_state = INIT_MEM_GONE;
> free_initmem();
> system_state = RUNNING;
>                                if (ok)
>                                    poke init mem
> 
> race?

Argh, I meant to put it before SMP bringup, but then still have to run
the smp_init calls :/

N/m, you're quite right.
