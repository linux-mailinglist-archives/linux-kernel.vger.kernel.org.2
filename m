Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D086351916
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhDARuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbhDARkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28907C08EC3C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xWuW6DllhK9JF+DFKMKd1igMk+bjQL2yPWcdW6CIbNc=; b=mgXVzIFzPxxbmQ7LIA0Y8BiZDS
        Bg8+zbytxYIqoWywMCbE9aU27M8Wi3gMJhwRdyquzYgohBZQpZU+PVUN6GliG3gWMeAZqQdkn9xJ2
        rrRyfOHVV1w+GYGgZ25nKkw9Z21F+s8lb8yeBBIgnvKl0skTZwyDpRYq7V3t5PkDoONNq6iRF+DUc
        2KNDnzekFUFIAQM/7WCC7dsNtHxUu5u6MB4gDppcJmxf8DUv3bbz4Ou8O4TYAZTfA3BgD75csI4Gc
        NRdo+gRT8OHoBjOzRCxEPy7ane3pMYVLDtIvYfVmrth4IxUnNy7KSDBaSN9EzfXAGbI0BbmQAHtoS
        CR1p8LsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxag-009ise-Q6; Thu, 01 Apr 2021 13:44:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 02F25304B90;
        Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C0D81235FA3BF; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401131012.395311786@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 0/9] sched: Core scheduling interfaces
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a rewrite of the core sched interface bits, and mostly replaces patches
2-5 from this set here:

  https://lkml.kernel.org/r/20210324214020.34142-1-joel@joelfernandes.org

The task interface is extended to include PR_SCHED_CORE_GET, because the
selftest. Otherwise the task interface is much the same, except completely new
code.

The cgroup interface now uses a 'core_sched' file, which still takes 0,1. It is
however changed such that you can have nested tags. The for any given task, the
first parent with a cookie is the effective one. The rationale is that this way
you can delegate subtrees and still allow them some control over grouping.

The cgroup thing also '(ab)uses' cgroup_mutex for serialization because it
needs to ensure continuity between ss->can_attach() and ss->attach() for the
memory allocation. If the prctl() were allowed to interleave it might steal the
memory.

Using cgroup_mutex feels icky, but is not without precedent,
kernel/bpf/cgroup.c does the same thing afaict.

TJ, can you please have a look at this?

The last patch implements the prctl() / cgroup interaction, up until that point
each task carries the cookie set last between either interface, which is not
desirable. It really isn't the nicest thing ever, but it does keep the
scheduling core from having to consider multiple cookies.

Also, I still hate the kernel/sched/core_sched.c filename, but short of using
gibberish names to make tab-completion easier I simply cannot come up with
a remotely sane alternative :/

The code seems to not insta crash, and I can run the prctl() selftest while in
a cgroup and have it pass, not leak any references etc.. But it's otherwise
lightly tested code. Please read carefully etc..

Also of note; I didn't seem to need the css_offline and css_exit handlers the
other set added.

FWIW, I have a 4 day weekend ahead :-)

