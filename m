Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715A4366930
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhDUK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbhDUK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:27:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283DAC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:27:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso951725wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DfB1PskyNKQQCJWiqpnf2aCTUFDtX+OVVcg4l3dtuu0=;
        b=JLKCps/Zcs/UvWNUG+U/E5lImOR0QsazxPixbpLZqvjVJxq6y7XQpCKo78ErdmZ+tP
         au6+Neik1wA/a5fgngjhC5e/u+Oklcj0cpsDP7S4MaoCRMfjzdL8Z85wJ7vah/7UhxgT
         WmdR1RDjkQVIeI//3jaYhsBRpKg+2oBueWfLy66YT387t5TskbFddEaWRAhBe2ZemoBj
         PtxePg7gsA5DBG/aiCOInZrULgu5pT7CkcQ1bY/TrH7lA6i7H+Hc2ujyWdnDV3IvHOT3
         0IVVBf5AIPrDZ+fMwvgKRgNdUIjVTHrWgUUaRCtLxZHdASBh1LT11ZylKug6Ru4Z8QFA
         oquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DfB1PskyNKQQCJWiqpnf2aCTUFDtX+OVVcg4l3dtuu0=;
        b=uimPt7GXWPGcWVerv5Q78ebGFIMpH1sYjRT+7Vt/vBC81IBOsxMYRK+sfLOrr5RiPO
         lq1Frr4Vxh3CxFuh/YzmAa6giSi3QjrHchwnOXALeJgfHqYrXmwZ3rPvfrFswVncio/1
         Y9fzr9dznsSjJCZ74N4N1YIyaaGi5amiyAI8D8pB6Qm7v0bfBkjuBkrSvTqz+pUIg4gp
         63EgTjapHG1kt5fMrbLSQL8xA900BNfIn0rUfpDSKfxQqH7VRMmGcLpnErDNsviPb2+S
         uB2V4HxTGmolXLSQp4kvSS6Hs6TO9YN5gPjbEORP20VzR2J8em2Ei4vP0RbN5o29x74J
         K20Q==
X-Gm-Message-State: AOAM530SdJ0hkIhfucfO0GfcgmgJICatO8pptOztiLEqAtkOOFd4+RZF
        ZLGcL97AvOS2U5/YI0uwLQvH6w==
X-Google-Smtp-Source: ABdhPJx2FR9qi1jPU3sc3SVulZmm3AqTBeSEZoS6yKvAGaiKSJTgvJh0l87+4A0BR45YF0U2jce86A==
X-Received: by 2002:a05:600c:4fce:: with SMTP id o14mr9054440wmq.121.1619000830626;
        Wed, 21 Apr 2021 03:27:10 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:c552:ee7c:6a14:80cc])
        by smtp.gmail.com with ESMTPSA id c12sm2655220wro.6.2021.04.21.03.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:27:09 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:27:04 +0200
From:   Marco Elver <elver@google.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 1/3] kfence: await for allocation using wait_event
Message-ID: <YH/4qKUAy76qNxXR@elver.google.com>
References: <20210419085027.761150-1-elver@google.com>
 <20210419085027.761150-2-elver@google.com>
 <20210419094044.311-1-hdanton@sina.com>
 <CANpmjNMR-DPj=0mQMevyEQ7k3RJh0eq_nkt9M6kLvwC-abr_SQ@mail.gmail.com>
 <20210421091120.1244-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421091120.1244-1-hdanton@sina.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:11PM +0800, Hillf Danton wrote:
> On Mon, 19 Apr 2021 11:49:04 Marco Elver wrote:
> >On Mon, 19 Apr 2021 at 11:44, Marco Elver <elver@google.com> wrote:
> >> On Mon, 19 Apr 2021 at 11:41, Hillf Danton <hdanton@sina.com> wrote:
> >> > On Mon, 19 Apr 2021 10:50:25 Marco Elver wrote:
> >> > > +
> >> > > +     WRITE_ONCE(kfence_timer_waiting, true);
> >> > > +     smp_mb(); /* See comment in __kfence_alloc(). */
> >> >
> >> > This is not needed given task state change in wait_event().
> >>
> >> Yes it is. We want to avoid the unconditional irq_work in
> >> __kfence_alloc(). When the system is under load doing frequent
> >> allocations, at least in my tests this avoids the irq_work almost
> >> always. Without the irq_work you'd be correct of course.
> >
> >And in case this is about the smp_mb() here, yes it definitely is
> >required. We *must* order the write of kfence_timer_waiting *before*
> >the check of kfence_allocation_gate, which wait_event() does before
> >anything else (including changing the state).
> 
> One of the reasons why wait_event() checks the wait condition before anything
> else is no waker can help waiter before waiter gets themselves on the
> wait queue head list. Nor can waker without scheduling on the waiter
> side, even if the waiter is sitting on the list. So the mb cannot make sense
> without scheduling, let alone the mb in wait_event().

You are right of course. I just went and expanded wait_event():

	do {
		if (atomic_read(&kfence_allocation_gate))
			break;
		init_wait_entry(...);
		for (;;) {
			long __int = prepare_to_wait_event(...);
			if (atomic_read(&kfence_allocation_gate))
				break;
			...
			schedule();
		}
		finish_wait(...);
	} while (0);

I just kept looking at the first check. Before the wait entry setup and
finally the second re-check after the mb() in prepare_to_wait_event().
So removing the smp_mb() is indeed fine given the second re-check is
ordered after the write per state change mb().

And then I just saw we should just use waitqueue_active() anyway, which
documents this, too.

I'll send a v2.

Thank you!

-- Marco
