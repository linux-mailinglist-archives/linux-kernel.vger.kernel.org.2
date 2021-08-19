Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73333F1FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhHSSdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:33:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHSSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:33:36 -0400
Date:   Thu, 19 Aug 2021 20:32:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629397979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKgZhZoP6Wr1nXwBtX0/HCtsp+aYuWSOG1oyXtBF99s=;
        b=Y+GSlhC+wTcAmQwOzmJlkO4NnxNQxjS6ze5xQq6EnGvWJG2igtpHoQT8RZIHcbl3azEdk9
        2OUOIi38fOGKM9MICG2VzR3BgaultFfRTbmvhZ531aT6aR6ENclVrGijjmoGeV0F2to0SO
        +RnCgkfgilu0vU5eAlsdzNOclNc/InuUZI/abifwlM6POzH4P6NPR2BWaL1YcpOkQMzJl2
        GQjeSP4E/EjOk2S8+2lwFIE5bLDsHv9R1ca666DpekUSpKk/iA3riUmBaCNP8+YzBxe/hz
        sGFMVuAwM56NcQgo30zv8et3ELsGhL8Fa4yGkEuTZYFLBe52udKq44tSe0OsPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629397979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKgZhZoP6Wr1nXwBtX0/HCtsp+aYuWSOG1oyXtBF99s=;
        b=+xyDxGHPDDH8kJSZaoFaqKiO4fje9IPp1OXMaEsioUspZks+B/I6ctWvpZnXg8stW+/xe7
        EYzcGMZ/wJYsMzCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] locking/ww_mutex: Initialize waiter.ww_ctx properly
Message-ID: <20210819183257.5dk35kvnuoipgcqa@linutronix.de>
References: <20210815203225.710392609@linutronix.de>
 <20210815211304.281927514@linutronix.de>
 <20210819165409.GA2335652@roeck-us.net>
 <20210819180850.koqw3ujmxga5wo4n@linutronix.de>
 <YR6hbiQLYYpadhkT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YR6hbiQLYYpadhkT@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-19 20:22:38 [+0200], Peter Zijlstra wrote:
> > @@ -630,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> >  		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
> >  		if (ret)
> >  			goto err_early_kill;
> > +		waiter.ww_ctx = ww_ctx;
> 
> Yeah, I suppose this works too, but I wanted to keep the waiter
> initialization together. Note how you've already called
> __ww_mutex_add_waiter() on it before you actually set part of the waiter
> state.

The wait_lock is held but yes, it ain't pretty.

Sebastian
