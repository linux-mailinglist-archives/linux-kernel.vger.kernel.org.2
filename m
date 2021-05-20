Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413838B985
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 00:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhETWgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhETWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 18:36:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE405C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:34:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t30so12831701pgl.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bTS10J8Fh4/AouNMIjaBMXhuO+gGwEf47jXocC6JZwU=;
        b=Z5qQMq/4e1ey9FmErr3jqiPFdMJEGgWcJQcEzl82VmhbsDd0Tgy3HSm5aBoPa5DnBH
         7bDqehGpiSCtOltIvKVIHWrvm10Q0y3PqL8J/ccnX4iSdALIzJJFjxyLY+pGZ8u0edwW
         RGzRhD+AA+bsexpUJ5MB69eRn9QEQkjDVYjRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bTS10J8Fh4/AouNMIjaBMXhuO+gGwEf47jXocC6JZwU=;
        b=Kt1WlW7AbXc1fTneok1GQ82SscaQ8ZX+r7Qtb0siyTmJ8ATLS/jXpXUmSUqKBY3+ya
         03ROR1DqxpEl3tuCe45Y+rwiqJO+vlhFTgsU+SowK3ePdHqumkiHX0b0HHxShSveoqxG
         WD9ni1lM58tP85d5OtEk2FjXzdv6P1LUHeEPxSQmZyjBypiHMhqqQKq/5Shgxo0DRuU/
         RbF1vozi3kevDDelYVkUhftJjx7BARArpP47niVz6jvdz6ZBLgVEedi/Bont2w+S9t07
         kwqPWLxWXl5dLLlHfVp4rP+thYsHrIC4DNxf4/GydM3BIkEHJGe13VWI4RMl+D42WzR/
         ZtWA==
X-Gm-Message-State: AOAM531KWofk5n6gU4IoErGxEK9q8/3D7o5dnBBnRImR1zQH+FV5L2Jw
        upBTbh0Drg/ycXdeQMv7XYozyXTRH8V4bA==
X-Google-Smtp-Source: ABdhPJySvh04MDIPE23NVRcL5tmdYVXsmdK3rbDvUka+pcsQ57zAzLVvWxIh9RNuz/OKLm+tiNFs3A==
X-Received: by 2002:a63:5a01:: with SMTP id o1mr3705692pgb.313.1621550087293;
        Thu, 20 May 2021 15:34:47 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id 4sm2850883pgn.31.2021.05.20.15.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 15:34:46 -0700 (PDT)
Date:   Fri, 21 May 2021 07:34:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <YKbkAXELPxXJcsHA@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX4ueNIabfd1DAD@google.com>
 <20210520145708.GK4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520145708.GK4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/20 07:57), Paul E. McKenney wrote:
> > 
> > Sounds good. I can cook a patch and run some tests.
> > Or do you want to send a patch?
> 
> Given that you have the test setup, things might go faster if you do
> the patch, especially taking timezones into consideration.  Of course,
> if you run into difficulties, you know where to find me.

OK. Sounds good to me.

> > While VCPU-2 has PVCLOCK_GUEST_STOPPED set (resuming) and is in
> > check_cpu_stall(), the VCPU-3 is executing:
> > 
> > 	apic_timer_interrupt()
> > 	 tick_irq_enter()
> > 	  tick_do_update_jiffies64()
> > 	   do_timer()
> 
> OK, but the normal grace period time is way less than one second, and
> the stall timeout in mainline is 21 seconds, so that would be a -lot-
> of jiffies of skew.  Or does the restarting really take that long a time?

That's a good question. I see huge jiffies spike in the logs.
I suspect that resuming a VM can take some time, especially on a "not
powerful at all" overcommitted host (more virtual CPUs than physical
ones).
