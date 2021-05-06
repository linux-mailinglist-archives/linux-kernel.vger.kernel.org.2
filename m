Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B71375250
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhEFKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhEFKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:30:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1994C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CYLSOjlrwGnBEHOx2Mrq6Tk6p1DDIvuRuysXe8CHcZc=; b=irbulzRcQ2P8k/6t6IC9lfO8SJ
        /lwf7/emhV4PrbG0+eo3jDl8cQqGQoAzTvAsH4dRxqqZip6Ff66jRdkt+lk9Dlc6LEV4nKEK5zfKF
        dkkgdQPCr0Dm4eGGKzU2mqHrJcci9ze+i6sU2HmAAz1dPGz06fhN5kD7KonvlRRcBMpzeZxnO+FMX
        ryMkndnJmxcfzpinh01opVAUOhtq1QbOR3qHFyUG1PQm6A0kURCYLpMO4wJpmGMqfiXllTd+x6juw
        82Be14RjmmklzEVIBroxd+PX/uysBItu6GAEqWmTRecT/xhxCRdExkCXC04FLeUhwpCSPqiKDLgli
        OY/TBymg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lebG1-003ydw-EF; Thu, 06 May 2021 10:29:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 394B5300103;
        Thu,  6 May 2021 12:29:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C8F5203E5063; Thu,  6 May 2021 12:29:23 +0200 (CEST)
Date:   Thu, 6 May 2021 12:29:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 00/19] sched: Core Scheduling
Message-ID: <YJPFA/s44ChuGV9+@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <a49ea23a-998e-2282-4c93-5c6c94f2c28d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49ea23a-998e-2282-4c93-5c6c94f2c28d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 02:47:00PM +0800, Ning, Hongyu wrote:
> Adding sysbench/uperf/wis performance results for reference:
> 
> - kernel under test:
> 	-- above patchset of core-scheduling + local fix for softlockup issue: https://lore.kernel.org/lkml/5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com/
> 	-- coresched_v10 kernel source: https://github.com/digitalocean/linux-coresched/commits/coresched/v10-v5.10.y

Shall I summarize all this as:

Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>

?
