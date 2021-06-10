Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFAF3A294D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFJK0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:26:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE3E1613FF;
        Thu, 10 Jun 2021 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623320654;
        bh=M6AEleLc4JKp4M6OeGH/BH3NxyqfJE++xRcWRirs5qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+Qis6JAheBOaZ3dboJlNbAb1TDo1/FyqLWX70S1HQEkLRBwhZqg85uLAn1U9na5g
         Y1FqxJwB6ddwRdU52JWGuFXArb4ZA8GEc/yofuVOwPIuL5SeN1h6cQdA+XkTGxJNrt
         93eEUZeZU7SyumlvQ3Yd6jCAXbNOOLp/eFYzpScB16ytVz5oW7SKFyq86USB0bZJGW
         uMWrN9sD5EMZlOcoKsXoY4FH6rNSpqrpbI7xZ+VcrIxE3IjmaqqNst8T4VW0lkuNEU
         eRy3FXwokuGXW6H7NZPejdpTphj9OsaDTO0mSOKiChz+b0uwvP103euRG3070X5Z4/
         P0kpbtLfXTqzg==
Date:   Thu, 10 Jun 2021 12:24:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/6] posix-cpu-timers: Don't start process wide cputime
 counter if timer is disabled
Message-ID: <20210610102411.GA127975@lothringen>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-3-frederic@kernel.org>
 <20210609121832.GE104634@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609121832.GE104634@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 02:18:34PM +0200, Frederic Weisbecker wrote:
> On Fri, Jun 04, 2021 at 01:31:55PM +0200, Frederic Weisbecker wrote:
> > If timer_settime() is called with a 0 expiration on a timer that is
> > already disabled, the process wide cputime counter will be started
> > and won't ever get a chance to be stopped by stop_process_timer() since
> > no timer is actually armed to be processed.
> > 
> > This process wide counter might bring some performance hit due to the
> > concurrent atomic additions at the thread group scope.
> > 
> > The following snippet is enough to trigger the issue.
> > 
> > 	void trigger_process_counter(void)
> > 	{
> > 		timer_t id;
> > 		struct itimerspec val = { };
> > 
> > 		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
> > 		timer_settime(id, TIMER_ABSTIME, &val, NULL);
> > 		timer_delete(id);
> > 	}
> > 
> > So make sure we don't needlessly start it.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> 
> No Fixes tag for this one. It has been there since year 1 AG.
> 
> I suspect it's the same for most other commits in the series, checking...

Right, so only the first commit needs one.

Thanks.
