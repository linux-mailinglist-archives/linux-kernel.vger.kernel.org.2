Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF030D719
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhBCKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhBCKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:11:02 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B3C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 02:10:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id e19so16321348pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 02:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZd0sxiMrsAI62mIDfdUOe+wf35CUvLHKH0D4G57Q5A=;
        b=enSN+ZmRqWIFsKsbvRL5Gib+qzMYmPUTXrqorZ0yMZErKldKTxAuG1PZr2l8RzxU2X
         V+CMvZsd5J20zYDENU3cQngCjZXvyhl/5YfIzXAGtPVwv7A3IeBuClOylJFz8GKDPVYj
         hIyuIxDpwm5f+IPbbmzNzWwXhErBEvhlEECP63noY58FgxYgYqGf9s4yWNsAiQG79DTv
         KBeoz40PyjUOtUeHmTOsT1K823NtHHn5XXdrE/eOiQlC0zCDYZhHGk0utm5g/ZMRoNtL
         anRkd7lYf/GHURNnfk0PQYggQHEAUfmVK+YXVAcFykP1S7R70p4TkKi7Hi5YY7eizRHG
         0eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZd0sxiMrsAI62mIDfdUOe+wf35CUvLHKH0D4G57Q5A=;
        b=jSYqYuevGufdRWHmMhh/OVltwSmLtL/uRdnbKyrJVxp55pZQSVLpv6U6VJpjgoCMGd
         ESLjC9ZSuAp1ce4MfaIrYppkuiKfjkKAbKIlZhZOammSykUkinZ1hs9lCwC01KKlgH9+
         0pYvdW65SfZDr7LPbUcHZqZmkmop5WXjkZ3oU5Cj69YcV4tNVpe2eeOoGVbNue1IzpAw
         rvY018b+uIvaw9lxWE7s9LLdB8Ax2x24LtHt8oISfhnWeS4wmpohQVKLQAF/JDgnEAOQ
         Zu72DFgeyzRaR1i06IgyNFnNHASjFUbVCbJfhD0ccChgpUNAg2Y0h8esYATSCTFlTZNZ
         iG0w==
X-Gm-Message-State: AOAM532GvHLbVn9NxTsRESR96pA6+EM3m6MJT5KTScExvvZ2+5/N/PJF
        jzfpTPAz8RMo9VcsSrJNRTdSGCahY6O9j+HO
X-Google-Smtp-Source: ABdhPJyS3H/d0LCCOHLY3Hl3e4FKe+C74+fhA4UL61BazMsFCWEI5FgWHgbrVxr15aIs37DP4QKVyw==
X-Received: by 2002:a65:488d:: with SMTP id n13mr2693818pgs.315.1612347022143;
        Wed, 03 Feb 2021 02:10:22 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 3sm1758206pfw.204.2021.02.03.02.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Feb 2021 02:10:21 -0800 (PST)
Date:   Wed, 3 Feb 2021 18:10:19 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] sched/topology: Switch to sched_debug() for conditional
 sched domain printk
Message-ID: <20210203181019.00007024.zbestahu@gmail.com>
In-Reply-To: <20210203095256.vzduw2gpcpum6a7g@linux.vnet.ibm.com>
References: <20210203042010.799-1-zbestahu@gmail.com>
 <20210203095256.vzduw2gpcpum6a7g@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 15:22:56 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Yue Hu <zbestahu@gmail.com> [2021-02-03 12:20:10]:
> 
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, the macro sched_debug_enabled has same function as
> > sched_debug() with return false for !SCHED_DEBUG. And sched_debug()
> > is a wapper of variable sched_debug_enabled for SCHED_DEBUG. We
> > can use the sched_debug() for all cases. So, let's remove the
> > unnecessary marco, also use sched_debug() in sched_domain_debug()
> > for code consistency.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  kernel/sched/topology.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 5d3675c..402138c 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -131,7 +131,7 @@ static void sched_domain_debug(struct
> > sched_domain *sd, int cpu) {
> >  	int level = 0;
> >  
> > -	if (!sched_debug_enabled)
> > +	if (!sched_debug())
> >  		return;
> >    
> 
> sched_debug() would only be present in CONFIG_SCHED_DEBUG. Right?
> In which case there would be a build failure with your change in
> !CONFIG_SCHED_DEBUG config.
> 
> or Am I missing something?

sched_debug() is also defined for !CONFIG_SCHED_DEBUG as below:

static inline bool sched_debug(void)
{
	return false;
}

And I think define sched_debug() above is just to avoid
CONFIG_SCHED_DEBUG wrappery.

> 
> >  	if (!sd) {
> > @@ -152,7 +152,6 @@ static void sched_domain_debug(struct
> > sched_domain *sd, int cpu) }
> >  #else /* !CONFIG_SCHED_DEBUG */
> >  
> > -# define sched_debug_enabled 0
> >  # define sched_domain_debug(sd, cpu) do { } while (0)
> >  static inline bool sched_debug(void)
> >  {
> > @@ -2113,7 +2112,7 @@ static bool topology_span_sane(struct
> > sched_domain_topology_level *tl, if (has_asym)
> >  		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
> >  
> > -	if (rq && sched_debug_enabled) {
> > +	if (rq && sched_debug()) {  
> 
> Same as above.
> 
> >  		pr_info("root domain span: %*pbl (max cpu_capacity
> > = %lu)\n", cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
> >  	}
> > -- 
> > 1.9.1
> >   
> 

