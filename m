Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0443D33DC11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbhCPSEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:04:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239862AbhCPSDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:03:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEBC2AE8F;
        Tue, 16 Mar 2021 18:03:13 +0000 (UTC)
Date:   Tue, 16 Mar 2021 11:03:05 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] futex: Leave the pi lock stealer in a consistent
 state upon successful fault
Message-ID: <20210316180305.sh7nyi4xjskd3e3j@offworld>
References: <20210315050224.107056-1-dave@stgolabs.net>
 <20210315050224.107056-3-dave@stgolabs.net>
 <YFCUYimuDkUonySp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YFCUYimuDkUonySp@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Peter Zijlstra wrote:
>
>IIRC we made the explicit choice to never loop here. That saves having
>to worry about getting stuck in in-kernel loops.
>
>Userspace triggering the case where the futex goes corrupt is UB, after
>that we have no obligation for anything to still work. It's on them,
>they get to deal with the bits remaining.

I was kind of expecting this answer, honestly. After all, we are warned
about violations to the 10th:

  * [10] There is no transient state which leaves owner and user space
  *      TID out of sync. Except one error case where the kernel is denied
  *      write access to the user address, see fixup_pi_state_owner().

(btw, should we actually WARN_ON_ONCE this case such that the user is
well aware things are screwed up?)

However, as 34b1a1ce145 describes, it was cared enough about users to
protect them against spurious runaway tasks. And this is why I decided
to even send the patch; it fixes, without sacrificing performance or
additional complexity, a potentially user visible issue which could be
due to programming error. And unlike 34b1a1ce145, where a stealer that
cannot fault ends up dropping the lock, here the stealer can actually
amend things and not break semantics because of another task's stupidity.
But yeah, this could also be considered in the category of inept attempts
to fix a rotten situation.

Thanks,
Davidlohr
