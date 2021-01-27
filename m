Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8463063A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbhA0TBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343859AbhA0TBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611774013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APajRwOUhB/DnHMvT5OqMUzlrRCmi9nx0c/ZETqKX9c=;
        b=T+O/lxO/OS+i2V98LM6wwI5cTLHJWhqZPfaoYZgN+qk12C4oMzg9b2BmSVpootOXjut5Ve
        k0PLkiJQf6lNFuW0aT4uGcDgxOW6LdpZHUahL/LieGRMCPYU9VRBBvGXE+tj77iWaeBRnH
        6Da2dYjyDXvAG4oeYZfkFrx/EvmiwKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-YaI5HWa7Ojecp2J6660MlA-1; Wed, 27 Jan 2021 14:00:09 -0500
X-MC-Unique: YaI5HWa7Ojecp2J6660MlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3318E802B45;
        Wed, 27 Jan 2021 19:00:07 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFE1D6F929;
        Wed, 27 Jan 2021 19:00:05 +0000 (UTC)
Date:   Wed, 27 Jan 2021 13:00:03 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210127190003.64rdwoxyjgnq2rtx@treble>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
 <20210127163308.cgiq7jxx2uziuhcc@treble>
 <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 07:44:01PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 27, 2021 at 10:33:08AM -0600, Josh Poimboeuf wrote:
> 
> > What did you think about .static_call_tramp_key?  I could whip up a
> > patch later unless you beat me to it.
> 
> Yeah, I'm not sure.. why duplicate information already present in
> kallsyms?

Well, but it's not exactly duplicating kallsyms.  No need to store
symbol names, just the pointer relationships.  And kallsyms is
presumably slow.

> There's a fair number of features that already require KALLSYMS, I can't
> really be bothered about adding one more (kprobes, function_tracer,
> stack_tracer, ftrace_syscalls).

Right, but I don't think they rely on KALLSYMS_ALL?

-- 
Josh

