Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA43DB9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhG3OBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhG3OBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:01:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780BC06175F;
        Fri, 30 Jul 2021 07:01:46 -0700 (PDT)
Date:   Fri, 30 Jul 2021 16:01:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627653704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLd6T+G+Mt7/rauFlAnBkB5WnhfOZZe5ZifZfPgsjEE=;
        b=NgBGpLFwJHy2Zx3P08eqKVosjuppDKML/0V3noGdJSBOSCErBbX+d6fKLIH/52h2K4JD6+
        k0zu9ogcRvFYqVY40khZjpvsJcwAhSwLqGgL1owFBRBnQWHbR2NASSB4En/R1uG7MKk/pI
        5tsADbCeVGS5xsb5uLb/M7JnNduzE1EQCBcFqNi2U5vZ75N5r+vfUuQCyW+SbzjMoymsYU
        EBYMu22+7AKCLBrLwvjXwAnlTcVcAdpELcmiS8WTJMVZ4NuK6l4xtjHdWlbhe4UKs3xOA8
        IdvAX3ivvB9s0XiNBYfwbdsAiyOYFKp9fxaN15ZruwK/cnRPWjEU4Dkdq3jy9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627653704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLd6T+G+Mt7/rauFlAnBkB5WnhfOZZe5ZifZfPgsjEE=;
        b=5P1GWPtijxHgSPVxdJeP76cA938Z7RfEtFGjLZnABKVnGI1P1RSxHhc4VRs8V9Cz11aIif
        ezL6LNPXFPomOiDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     chao.qin@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, mgross@linux.intel.com, paul.mei@intel.com,
        lili.li@intel.com
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of
 msleep in pr_flush()
Message-ID: <20210730140143.53wls2g7xf2ktdgv@linutronix.de>
References: <20210719022649.3444072-1-chao.qin@intel.com>
 <87mtqiuzd4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mtqiuzd4.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-19 17:01:51 [+0206], John Ogness wrote:
> On 2021-07-19, chao.qin@intel.com wrote:
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3620,7 +3620,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
> >  	u64 diff;
> >  	u64 seq;
> >  
> > -	may_sleep = (preemptible() && !in_softirq());
> > +	may_sleep = (preemptible() && !in_softirq()
> > +			&& (system_state >= SYSTEM_RUNNING));

I don't have more context but scheduling should work starting with
SYSTEM_SCHEDULING.

> >  
> >  	seq = prb_next_seq(prb);
> >  
> >

Sebastian
