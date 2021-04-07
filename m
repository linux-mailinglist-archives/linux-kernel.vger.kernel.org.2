Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBE357468
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355356AbhDGSfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhDGSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:35:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0718C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wxDzh9qlCPHjoFTm6hkUMZ4Kdiz01AiQAJwtq0bC5uA=; b=dMSe2t2Yj/m86xcuOQ1LQRyb1s
        ggUwWVzcH1w7Y1E3mk6170CJeIw9FIvPRe7e8T8AJetO7q0bxzxD98sm8I5p8/R3y8JgpgMEiPFZI
        UCzRkg88xnzEpcxH/BeziYxmUUNTgz4brLo8rfGqEXmNE2f8/pzrTAeCFrEI/hu2CF03WLAma2cWd
        /Afg+vVnoXWwYi7mNe7bfdv+XfnFpyKSuYAz5AzNsPMfPoVRoxRJVMhhFUx8cr3Uw9ZZZlI+lqY3X
        CSDtrepkdauuZSmVTkcins7pjJjY9cOx/z/Th8sHwFyo6JsG8YmXL8YOVokRRi1X9n45MmUkpOCgM
        5otQ4LFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUD0T-00Euww-RH; Wed, 07 Apr 2021 18:34:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76E81300056;
        Wed,  7 Apr 2021 20:34:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5955D2BC07BA8; Wed,  7 Apr 2021 20:34:24 +0200 (CEST)
Date:   Wed, 7 Apr 2021 20:34:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, joel@joelfernandes.org,
        chris.hyser@oracle.com, joshdon@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YG37MBLBIXIPVv7u@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <YG3i2JF2vBY4CseK@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YG3i2JF2vBY4CseK@blackbook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 06:50:32PM +0200, Michal Koutn=FD wrote:
> Hello.
>=20
> IIUC, the premise is that the tasks that have different cookies imply
> they would never share a core.

Correct.

> On Thu, Apr 01, 2021 at 03:10:12PM +0200, Peter Zijlstra wrote:
> > The cgroup interface now uses a 'core_sched' file, which still takes 0,=
1. It is
> > however changed such that you can have nested tags. The for any given t=
ask, the
> > first parent with a cookie is the effective one. The rationale is that =
this way
> > you can delegate subtrees and still allow them some control over groupi=
ng.
>=20
> Given the existence of prctl and clone APIs, I don't see the reason to
> have a separate cgroup-bound interface too (as argued by Tejun).=20

IMO as long as cgroups have that tasks file, you get to support people
using it. That means that tasks joining your cgroup need to 'inherit'
cgroup properties.

That's not something covered by either prctl or clone.

> The potential speciality is the possibility to re-tag whole groups of
> processes at runtime (but the listed use cases [1] don't require that
> and it's not such a good idea given its asynchronicity).

That seems to be the implication of having that tasks file. Tasks can
join a cgroup, so you get to deal with that.

You can't just say, don't do that then.

> Also, I would find useful some more explanation how the hierarchical
> behavior is supposed to work. In my understanding the task is either
> allowed to request its own isolation or not. The cgroups could be used
> to restrict this privilege, however, that doesn't seem to be the case
> here.

Given something like:

	R
       / \
      A   B
         / \
	C   D

B group can set core_sched=3D1 and then all its (and its decendants) tasks
get to have the same (group) cookie and cannot share with others.

If however B is a delegate and has a subgroup D that is security
sensitive and must not share core resources with the rest of B, then it
can also set D.core_sched=3D1, such that D (and its decendants) will have
another (group) cookie.

On top of this, say C has a Real-Time tasks, that wants to limit SMT
interference, then it can set a (task/prctl) cookie on itself, such that
it will not share the core with the rest of the tasks of B.


In that scenario the D subtree is a restriction (doesn't share) with the
B subtree.

And all of B is a restriction on all its tasks, including the Real-Time
task that set a task cookie, in that none of them can share with tasks
outside of B (including system tasks which are in R), irrespective of
what they do with their task cookie.

