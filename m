Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD13E1782
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbhHEPFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhHEPF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:05:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26306C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q2j4Uc/1JxFNLSIGvFFv05XtciGEifuPGPdbXEcTRNI=; b=Hwgh/orUdnj/c2Fz6VAsH+lIIO
        jIsFInIHRQ9bdjMwFZThcT56K8D1Pg0nGTgO2cTvZnbJcGW3h35V9pqibNAg9gExzJtO+2m5wjkLn
        udcywxb01LWgY+7Xhok24BQCAfjnhq6PZpYJ6+siiL9P+O6BDlYVx2J98f10IkDeS6RW9Y2HLdqj0
        aMmWsMraxWNgQnfCkqsR2CkdKk+cOWQmG5JLmcLNKRFbipgf/wk2QPTh6esna9KfvdUE8zqbRyFAL
        O00e2KFQ2We/HWK+v9wO5SOCfBAPs8hIfyMAHwhOQTLtcHCPeVNLxLOk436RoBY+QFySY2P2z0A6E
        R4kaXilA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBeve-0065ZN-Bx; Thu, 05 Aug 2021 15:05:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 16E203001CD;
        Thu,  5 Aug 2021 17:05:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E82CC201DCD23; Thu,  5 Aug 2021 17:05:00 +0200 (CEST)
Date:   Thu, 5 Aug 2021 17:05:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Rahul Gopakumar <gopakumarr@vmware.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        Rajender M <manir@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Linux Kernel 5.13 GA] ESXi Performance regression
Message-ID: <YQv+HHwrMmiUYZ4+@hirez.programming.kicks-ass.net>
References: <BYAPR05MB483975D437F293A40BEF3189A6EC9@BYAPR05MB4839.namprd05.prod.outlook.com>
 <87a6m4kk4f.mognet@arm.com>
 <BYAPR05MB520669C6C1A8A522B1DE0EAAA4F29@BYAPR05MB5206.namprd05.prod.outlook.com>
 <20210805105853.66425074@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805105853.66425074@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:58:53AM -0400, Steven Rostedt wrote:
> On Thu, 5 Aug 2021 14:33:52 +0000
> Rahul Gopakumar <gopakumarr@vmware.com> wrote:
> 
> > In our testing, we use RHEL 8.1 distro. It looks like tuned daemon updates
> > 15ms (per tuned virtual-guest profile) in /proc/sys/kernel/sched_wakeup_granularity_ns
> > file during tuned's startup.
> > 
> > Now tuned daemon is not able to update the value as the commit moves those
> > files to debugs and thus sched_wakeup_granularity_ns file remains with the
> > default value.
> 
> Hmm, is this a user space breakage?

All those files were under CONFIG_SCHED_DEBUG and a !DEBUG build would
not have them to begin with.
