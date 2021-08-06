Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC63E2F22
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbhHFSHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:07:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhHFSHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:07:11 -0400
Date:   Fri, 6 Aug 2021 20:06:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628273214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9B60GNwlGf4odiArXnXP8Ekr/AHmX5WOkT+csT5dOUY=;
        b=u7u5OVZhfAtMLVMgJubaAd0qkEesN6RXn7dGLvrOfeAy9x2TWGJpPyyuziyw7MDzI6i1ny
        KnNWl7MesCY6mD4z92fnNBsa1K14WxbcoHhBQIsfgVAacRfhtDknZPUrFWcPjrCd9WrZVC
        PGHSi6eaNUa2MdUyjFYz6VkFmS/e47/3OhylqaOdjFWsrOnwNGCGNHCt17uKoAbYo7kVFw
        ydB+JxOcWZXZTK3O8ZwJIcHaDqxmr3ZoHlybE7sbl2mTjbyOSCfY0rQj8f3kRRPfzSxVlx
        G66rAvYpjcrK80NvDsTUKV1399CjHKRtgfLqWTNBSkrN9SO0BnqWBVbiC687KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628273214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9B60GNwlGf4odiArXnXP8Ekr/AHmX5WOkT+csT5dOUY=;
        b=+/GH9xj42EXJkgT54SSQy4NFWnsI/zyZ0MlBX24wXywnyeAOyi97y3P6l7Ma7s/nY0u+5e
        CtAqhGi6oe60ElAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
Message-ID: <20210806180653.mohdmxgrt6h3valt@linutronix.de>
References: <20210806140718.mxss3cbqijfebdo5@linutronix.de>
 <20210806180242.GB2184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210806180242.GB2184@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-06 20:02:42 [+0200], Peter Zijlstra wrote:
> On Fri, Aug 06, 2021 at 04:07:18PM +0200, Sebastian Andrzej Siewior wrote:
> > What do we do with this?
> > Do we merge this as-is, add another "robust atomic notifier" using only
> > raw_spinlock_t for registration and notification (for only
> > cpu_pm_notifier_chain) instead of switching to raw_spinlock_t for all
> > atomic notifier in -tree?
> 
> Right, so the problem I see with this is that
> notifier_chain_{,un}register() are O(n). Hardly something we should be
> putting under raw_spin_lock :/

Yup, pretty much. So we make one robust notifier for
cpu_pm_notifier_chain?

Sebastian
