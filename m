Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1403A362FB4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhDQLvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbhDQLvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:51:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC21C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oWCSjXq9cCrRHXmsTIGL+nDa8uwGrLxoVpVcRfRLUwA=; b=UhDw7RFqU6kf1UX3IAZfUoSdhJ
        u9ZVv8WI1bMUcC+mgJiEeW8TK5Qbtapg4ZdloRS47UFP8xlSRqTWiFGt0CmEdV9KetY1psxY/ciWy
        wbv21+lWevlkrhi2TDwZ5Rs1KpcPo0lU+U8eyfIlHmp/Bj+OJsEbtQfukwSXpS4/+FTg1RaPBNRRD
        /3mxoTC3mcxLtglVEzY7608FQ0k3indO5RZU1hxz8KJ+vfKeqgsScjN7dXIXV5ogvWnCEBOXgY2KM
        81FZsNMwiaOzXk++YYb98U64grgwVVTUcQeAQCCPmHZZUKQDqlBC6n5b8V8n+6i2EakYzeNpEsA/O
        Fs9cZ3Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXjTc-00BDSS-KJ; Sat, 17 Apr 2021 11:51:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CF91300212;
        Sat, 17 Apr 2021 13:42:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0592F28591526; Sat, 17 Apr 2021 13:42:05 +0200 (CEST)
Date:   Sat, 17 Apr 2021 13:42:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:sched/core 23/23] kernel/sched/topology.c:17:2: error:
 'sched_debug_verbose' undeclared; did you mean 'sched_debug_setup'?
Message-ID: <YHrJjbbyhcpI8IAK@hirez.programming.kicks-ass.net>
References: <202104171441.AKFwtRfO-lkp@intel.com>
 <20210417090628.GA9196@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417090628.GA9196@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 11:06:28AM +0200, Borislav Petkov wrote:
> On Sat, Apr 17, 2021 at 02:47:46PM +0800, kernel test robot wrote:
> >    kernel/sched/topology.c: In function 'sched_debug_setup':
> > >> kernel/sched/topology.c:17:2: error: 'sched_debug_verbose' undeclared (first use in this function); did you mean 'sched_debug_setup'?
> >       17 |  sched_debug_verbose = true;
> 
> I guess it needs this:
> 
> ---
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 55232db745ac..916bb96ff9a6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2364,6 +2364,7 @@ extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
>  
>  #ifdef	CONFIG_SCHED_DEBUG
>  extern bool sched_debug_enabled;
> +extern bool sched_debug_verbose;
>  
>  extern void print_cfs_stats(struct seq_file *m, int cpu);
>  extern void print_rt_stats(struct seq_file *m, int cpu);
> 

Right, sorry for messing that up. Pushed out that commit with this
folded. If it gives any more trouble just kill the commit, it's the
topmost commit anyway.
