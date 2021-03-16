Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589CB33D234
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhCPK4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCPKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:55:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69325C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fJg6GHGovgQHmM0kQSRyfXRZjcSHrNAE4iyqVwiI9no=; b=Ui/0k/XCr3zU8amLKvcet+NNTx
        OpMvSky/jZoK7ne15PGFMxvFBheONzSxh5OTD57Mn+qFXJ5PDh7xHatI9gzH8OEXHqZ+0PN8I58hZ
        pTYSPrMh6j60c7HgytvUboXSK5cOj/1e9qbTrM3Dwr5Nxhn5USLlFCLS4rgF8a7hVBqAwEFrACEXS
        mw6U0DUuoeheNi1M3qg8Sezd5Gl9V4vFEtHxRu+nIwN0gBYOpAKSAr3k2XPbdtcMgzvMAIA7BK1zD
        +G4PRSlcKfFXFLM1u1LiS7CbkbKA6Yoo591vvQCMvPkE2E6+5tp/Mp43VoxMkSAGhxamwhqvD5xtQ
        wnJwCpZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM7M0-000UQi-LA; Tue, 16 Mar 2021 10:55:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D38F73012DF;
        Tue, 16 Mar 2021 11:55:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4F6920435CFD; Tue, 16 Mar 2021 11:55:06 +0100 (CET)
Date:   Tue, 16 Mar 2021 11:55:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, pauld@redhead.com, Paul Turner <pjt@google.com>,
        rostedt@goodmis.org, Shanpei Chen <shanpeic@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v3 2/4] sched/fair: Make CFS bandwidth controller
 burstable
Message-ID: <YFCOiiEi84ioMXfA@hirez.programming.kicks-ass.net>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210121110453.18899-3-changhuaixin@linux.alibaba.com>
 <YEjDyADiVjVyt3ur@hirez.programming.kicks-ass.net>
 <448372EF-B943-4E3E-8041-96884DF63BB8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448372EF-B943-4E3E-8041-96884DF63BB8@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 09:54:33PM +0800, changhuaixin wrote:
> > On Mar 10, 2021, at 9:04 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> > There's already an #ifdef block that contains that bandwidth_slice
> > thing, see the previous hunk, so why create a new #ifdef here?
> > 
> > Also, personally I think percentages are over-represented as members of
> > Q.
> > 
> Sorry, I don't quite understand the "members of Q". Is this saying that the percentages
> are over-designed here?

You know the number groups (in order): N, Z, Q, R, C, H, O.

Percent being 1/100 is a fraction and thus part of Q (and anything
higher ofcourse).

Some people seem to think percent is magical and special. It's just a
fraction like the inifinite many others in Q. It's also a very crappy
one when we consider computers.

Basically I hate percentages, they're nothing special and often employed
where they should not be.
