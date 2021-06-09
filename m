Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F3C3A1420
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhFIMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233935AbhFIMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:20:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB67260E0C;
        Wed,  9 Jun 2021 12:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623241114;
        bh=BaD5ZvWzoMu1DaZ8oWfiyesJjgOA3KCp3Qb400oOzNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joCUR5AWCQHba6t6brL/hcILJeOyvdeA947e5B59c9wKeyFZWPc9T4Jx4WYbzKNvU
         y5dHKctv6+ulH+QewymCwO8Xdhvj6rP2Ep81TKAjcxyDMEAj9q6HyE3sE0+cil5AsY
         UjaGyX40ERIAylW1yc3NEiUsSEs0XAXMxKZQfRv/YebHUbCgi+8EG/Ta44l3mkDJmq
         CTVUQU9bhCXOXznNiKBc31bF8to9tgr3/Oo+kkW8rmtv02Y87+JZFHDP64V68vtnLc
         RP4uI5aANrMYdXKA2bq/ZDHfdFDl4xC8gf4jaGYyisgsoLgPsOsNnRueadpw2O9Tk+
         nRing9dp+NYBw==
Date:   Wed, 9 Jun 2021 14:18:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/6] posix-cpu-timers: Don't start process wide cputime
 counter if timer is disabled
Message-ID: <20210609121832.GE104634@lothringen>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604113159.26177-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:31:55PM +0200, Frederic Weisbecker wrote:
> If timer_settime() is called with a 0 expiration on a timer that is
> already disabled, the process wide cputime counter will be started
> and won't ever get a chance to be stopped by stop_process_timer() since
> no timer is actually armed to be processed.
> 
> This process wide counter might bring some performance hit due to the
> concurrent atomic additions at the thread group scope.
> 
> The following snippet is enough to trigger the issue.
> 
> 	void trigger_process_counter(void)
> 	{
> 		timer_t id;
> 		struct itimerspec val = { };
> 
> 		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
> 		timer_settime(id, TIMER_ABSTIME, &val, NULL);
> 		timer_delete(id);
> 	}
> 
> So make sure we don't needlessly start it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>

No Fixes tag for this one. It has been there since year 1 AG.

I suspect it's the same for most other commits in the series, checking...
