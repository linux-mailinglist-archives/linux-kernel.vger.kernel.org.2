Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC1363E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbhDSJBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhDSJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:01:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B48EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oNPztqcdqyx6JFOIavwAKe8o2/Cul+TUzAXD8xOCmWY=; b=LRMLz1VL+by3ZtCLEfq0npNriT
        jLm/ICpYz6N5vlbrI/cN9sT4wS5kectcvGFtfT0QCn84N6joG/iyYmJEActhFdd71WGtI+YN0IcHn
        aeceDFsJ+028KAV0Rvyc0xOa52d9/fRRCArvveSmam0IDOo7E4Z/zq72TVl9k+YnMlJwM4iJldU0o
        c9m8eDkU6XrCds+MkNwGhQspRkWo7dU2Xv9fwFyp3EVNniyMh7P7FCeu8+BzQj6eya8B2gk8nuzEE
        XT3/R/I/PvrN2ICOirlBWDmKt0lc5x+kBbihLAR9ot+p8X7oAsfbH6vdoWbQwFW7c5PQWbE5M6OkJ
        UmWYkd2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYPm6-009VsE-IT; Mon, 19 Apr 2021 09:00:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CE6830020C;
        Mon, 19 Apr 2021 11:00:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07F5D2C14C5BD; Mon, 19 Apr 2021 11:00:57 +0200 (CEST)
Date:   Mon, 19 Apr 2021 11:00:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YH1GyFA96tioW4kZ@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <CAEXW_YSS0ex8xK7t2R7c1jiE4eNbwxdwP2uyGPDK78YAaYQr5A@mail.gmail.com>
 <YGxtLOxCb4LO8kN0@slm.duckdns.org>
 <YHuMy0o7gRd+kIVN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHuMy0o7gRd+kIVN@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 09:35:07PM -0400, Joel Fernandes wrote:
> On Tue, Apr 06, 2021 at 10:16:12AM -0400, Tejun Heo wrote:
> > Hello,
> > 
> > On Mon, Apr 05, 2021 at 02:46:09PM -0400, Joel Fernandes wrote:
> > > Yeah, its at http://lore.kernel.org/r/20200822030155.GA414063@google.com
> > > as mentioned above, let me know if you need any more details about
> > > usecase.
> > 
> > Except for the unspecified reason in usecase 4, I don't see why cgroup is in
> > the picture at all. This doesn't really have much to do with hierarchical
> > resource distribution. Besides, yes, you can use cgroup for logical
> > structuring and identificaiton purposes but in those cases the interactions
> > and interface should be with the original subsystem while using cgroup IDs
> > or paths as parameters - see tracing and bpf for examples.
> 
> Personally for ChromeOS, we need only the per-task interface. Considering
> that the second argument of this prctl is a command, I don't see why we
> cannot add a new command PR_SCHED_CORE_CGROUP_SHARE to do what Tejun is
> saying (in the future).
> 
> In order to not block ChromeOS and other "per-task interface" usecases, I
> suggest we keep the CGroup interface for a later time (whether that's
> through prctl or the CGroups FS way which Tejun dislikes) and move forward
> with per-task interface only initially.

Josh, you being on the other Google team, the one that actually uses the
cgroup interface AFAIU, can you fight the good fight with TJ on this?

> Peter, any thoughts on this?

Adding CGROUP_SHARE is not sufficient to close the hole against CLEAR.
So we either then have to 'tweak' the meaning of CLEAR or replace it
entirely, neither seem attractive.


I'd love to make some progress on all this.
