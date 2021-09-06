Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECD440175C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbhIFHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:55:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35518 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbhIFHzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:55:07 -0400
Date:   Mon, 6 Sep 2021 09:54:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630914842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8RQuuGnJ4q/3n62AEnDPTWPhYO/PiGcKRmtkDfr3LE=;
        b=ZFQerjN0VFoE/hpFCyuq0rvUttROlpOf9wJL2QSek7Ea+qRBo75PkGrcla6wbrwHJ0EvR6
        QfeQF5PAO6X4FxAyBeXIajqDPd3pTpJFhA0HlfpYHstW+AESUu6x0hKFmIRVh34rzP5kOr
        nNj8dSTJF+xRUb82CwvfpEqfd/FwFF0l4wyn0gH+AcyffApgwsTKnsTlQQB6JYnHjWeAH5
        brNcnY1BGRNmKCT9ccx96QVMg9/seSVuq/GLXgK0obQxX8v47FR7cjFG/q3fED2Jv0xOMr
        nR/Mw1Jz90DYP456NEjCxeYY6OSV5nUKebwa5/B/5VSMe+pmgX1GsVbm1BCy2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630914842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8RQuuGnJ4q/3n62AEnDPTWPhYO/PiGcKRmtkDfr3LE=;
        b=fWsbsx7WQx4qqOYADhmaz4m0WF4vH75f9g4O1n7vvlN0NjGcrS7I/kBBuL3go3/15LKE2T
        kD34ALZe6yqAONDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-rt-devel:linux-5.14.y-rt-rebase 242/262]
 kernel/locking/spinlock_rt.c:249:13: warning: no previous prototype for
 'rt_rwlock_is_contended'
Message-ID: <20210906075400.ladxwmlp75ovhgdx@linutronix.de>
References: <202109050346.dGuKq42k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202109050346.dGuKq42k-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-05 03:00:56 [+0800], kernel test robot wrote:
> >> kernel/locking/spinlock_rt.c:249:13: warning: no previous prototype for 'rt_rwlock_is_contended' [-Wmissing-prototypes]
>      249 | int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
>          |             ^~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/rt_rwlock_is_contended +249 kernel/locking/spinlock_rt.c
> 
> ca72c3eba593af Thomas Gleixner 2021-08-15  248  
> ca72c3eba593af Thomas Gleixner 2021-08-15 @249  int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
> ca72c3eba593af Thomas Gleixner 2021-08-15  250  {
> ca72c3eba593af Thomas Gleixner 2021-08-15  251  	return rw_base_is_contended(&rwlock->rwbase);
> ca72c3eba593af Thomas Gleixner 2021-08-15  252  }
> ca72c3eba593af Thomas Gleixner 2021-08-15  253  EXPORT_SYMBOL(rt_rwlock_is_contended);
> ca72c3eba593af Thomas Gleixner 2021-08-15  254  

| $ git grep rwlock_is_contended include/linux/rwlock_rt.h  
| include/linux/rwlock_rt.h:#define rwlock_is_contended(lock)             (((void)(lock), 0))

shouldn't we wire it up?

Sebastian
