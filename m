Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09B357475
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhDGSlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhDGSlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:41:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A5AC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TevWoQq5Glq6ytD9AXpDyqi4WvX3U1InyNLnaDshZWg=; b=AHWVjJW9sXMfdWd06nX21+YP7H
        7IdMnbmvoOgZ+ECTL1Grbnkrp4mqzmanNEMnx5cxhvnMz+RlgMAGM9aejmpl3NywWL7IT4iRko3ZS
        oQEJI0JtN1XUy37VT0sIISDanaPeYhtMwLPB2zIKtHrLrU53dMzuqANprqPrhJG4UW3Xir88vW37P
        j1Vg4X/pZ7u7RQ9uXk5RXYclwsNTxKj/GI9qZuAUbsHgtQNVtw6UK3xVkEaNpleBW+orp+U1K5X24
        I5FtXYE5UT4Qx12rygEncgNdNGJaT1AMpQ1aoRPcdidsOS3SAvCwYTys8umi7yaoQ6i0WPJ33Gd7W
        hxA0vuOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUD5Z-00EvH0-Op; Wed, 07 Apr 2021 18:39:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ED3D3001FB;
        Wed,  7 Apr 2021 20:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA4B62BC07BB4; Wed,  7 Apr 2021 20:39:40 +0200 (CEST)
Date:   Wed, 7 Apr 2021 20:39:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YG38bBm+JJXIwgYq@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <YGx+9EVS5kDrLOD0@hirez.programming.kicks-ass.net>
 <YGyHknFJhHO99e5a@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyHknFJhHO99e5a@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 12:08:50PM -0400, Tejun Heo wrote:

> I see. Yeah, if we really need it, I'm not sure it fits in cgroup interface
> proper. As I wrote elsewhere, these things are usually implemented on the
> originating subsystem interface with cgroup ID as a parameter.

This would be something like:

  prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, cgroup-fd, PIDTYPE_CGROUP, NULL);

right? Where we assign to self the cookie from the cgroup.

The problem I see with this is that a task can trivially undo/circumvent
this by calling PR_SCHED_CORE_CLEAR on itself, at which point it can
share with system tasks again.

Also, it doesn't really transfer well to the group/tasks thing. When a
task joins a cgroup, it doesn't automagically gain the cgroup
properties. Whoever does the transition will then also have to prctl()
this, which nobody will do.

