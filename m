Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93644393AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhJYKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhJYKaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:30:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113AC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 03:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=in4IFwjDZaZ0jxfE46hO/uPo60PwbMg0MhH/hqMvgU8=; b=vYDoA31DsQ8dfs8OAL2UgHcYSK
        GJvak3dhI4ZE9Ai7pQA/WDt4R58fSc79ZUoBmK/+vfrVfCR0qlKYMGMcUI4X1PbmIAwM5QnqOBB4W
        zU5i3N7uFJgg68t6gyNJiczKnfbeX6wH92UAiQwdV2uddJgYvx8doJNtMIPDrpNPVjxxGhzz/rkvK
        9PKSLxIBHKlUkwxLntbMB9jIVPKOpiCK0XhHDlGmGDXnpHYS+osgiiW80G+VJZoKA4cbIXIHwlAXP
        IOhLtvR5WzyKe6Pgj0PAaTilp4IBVgTc5A1GFGhL1I8d5XNw3wfm1U4q9NFPUsSkCW8MYJViS0AmZ
        whx2z3ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mex9m-00G1do-ON; Mon, 25 Oct 2021 10:25:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27E83300095;
        Mon, 25 Oct 2021 12:24:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 034FF20C6C142; Mon, 25 Oct 2021 12:24:39 +0200 (CEST)
Date:   Mon, 25 Oct 2021 12:24:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] sched: Fix implicit type conversion
Message-ID: <YXaF56oFBaDAuX6b@hirez.programming.kicks-ass.net>
References: <1635156000-2426673-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635156000-2426673-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:00:00AM +0000, Jiasheng Jiang wrote:
> On Mon, Oct 25, 2021 at 08:57:31AM +0000, Peter Zijlstra wrote:
> >> The variable 'n' is defined as ULONG. However in the cpumask_next(),
> >> it is used as INT.
> >> That is vulnerable and may cause overflow.
> >> Therefore, it might be better to define 'n' as INT.
> 
> >-ENOPARSE
> 
> I don't understand the 'ENOPARSE'.
> Please give me more details.

I've no idea what your changelog is trying to say, or how your patch
makes a difference.
