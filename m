Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF233D105
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhCPJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhCPJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:42:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E98C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NDNqJ87ah9iwtWeelWRtR81DTZqzhakhgaGhPf9ZGZw=; b=Jh8cZ6/Dkjr2v7D+O6D8TPmGub
        kSnUSs3G8eM0PT2wxAgy/uSBzT00dMmXSuNG9W9szWBjKjntsqLPORebUcXU7jRsqY8VCW/Cv8PVI
        td+Ni377lKNBOTBMjMlcZjr1L3cVMYezYARQ993TpR6lqht0MuSUN0Co1iGIiUyq9t+Fb0dXKKoAP
        AdsZ6mXm3fcvlq+yb5YV0Dp59sIkR2uOhek3utFnW0mklrOFivL2rynCBC1W1la25tDxuMep9KScO
        uT91n0UrbILSFQGKPJBUjApwwssE88zy9eJwmrK+Q5J41tGw3kj7vugw1h34x0tqNXdTOJFm6XFm+
        JsH51N4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM6CU-001l0l-Q6; Tue, 16 Mar 2021 09:41:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A361304D58;
        Tue, 16 Mar 2021 10:41:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 175392D1CC08F; Tue, 16 Mar 2021 10:41:14 +0100 (CET)
Date:   Tue, 16 Mar 2021 10:41:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS
 bandwidth burst
Message-ID: <YFB9OtuAEXPfSJk3@hirez.programming.kicks-ass.net>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:49:28PM +0800, Huaixin Chang wrote:
> In this patch, we introduce the notion of CFS bandwidth burst. Unused
> "quota" from pervious "periods" might be accumulated and used in the
> following "periods". The maximum amount of accumulated bandwidth is
> bounded by "burst". And the maximun amount of CPU a group can consume in
> a given period is "buffer" which is equivalent to "quota" + "burst in
> case that this group has done enough accumulation.

Complete lack of why though. Why am I going to spend time looking at
this?
