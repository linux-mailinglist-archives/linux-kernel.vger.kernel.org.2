Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB133526DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhDBHNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhDBHNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:13:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33BC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 00:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GMUeC6Yjmhg5mc50fJijq6amkmPkeHC8IG7waCTSkRY=; b=vTKUD4VKmNB8R6iPR8VAQ7Knm6
        VBnFbH5/bzlJi3qAGDErh2CKrF6LKvRRUgSY2WqHIvYUu4DsMUxw8/PYQDVTsLWQmdLcHg0R8yAD8
        hjysrpAx8pH9Bwue0VgPbESXSng0lcQhVGoMhGi6RI3w5rlcL9UliuQmsqYBp5UTM+V+Y51MvktNa
        PuQb3lQfw/5O5rsmbYHhdPAlO/ZoG0eTAv0SVzFZ9ej8C2Eciua5bTBmw8xFsBwK5vbSGueCGJfVG
        ozuSfNJPFoCMBzSGniKXApipCWZUlXTBPpoQQKqq7hV6yGW60a0jvSTzQs4yqoW1qDkWsEaMsMUb+
        hrjH2snw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lSDzQ-007KC7-C8; Fri, 02 Apr 2021 07:13:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EB0F9864CC; Fri,  2 Apr 2021 09:13:07 +0200 (CEST)
Date:   Fri, 2 Apr 2021 09:13:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/9] sched: Trivial core scheduling cookie management
Message-ID: <20210402071307.GS4746@worktop.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <20210401133917.231259659@infradead.org>
 <CABk29NtHj47DXiFBkJpG748bj2HSG09BCb-h5fXUatFMWn2qCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NtHj47DXiFBkJpG748bj2HSG09BCb-h5fXUatFMWn2qCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:04:58PM -0700, Josh Don wrote:
> > +/*
> > + * sched_core_update_cookie - Common helper to update a task's core cookie. This
> > + * updates the selected cookie field.
> > + * @p: The task whose cookie should be updated.
> > + * @cookie: The new cookie.
> > + * @cookie_type: The cookie field to which the cookie corresponds.
> 
> No cookie_type in this patch (or cookie fields). Also might want to
> call out that the caller is responsible for put'ing the return value.

Lol, I don't think I've even seen the comment. Yes that needs more than
a rewording.
