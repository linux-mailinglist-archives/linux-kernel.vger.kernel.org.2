Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6943E17FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhHEP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhHEP3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:29:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E267C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g6MySzxsjNJgC04riXxageoIBkjcOdfx8jG32o2Cq2k=; b=vazkebJFR09P5s20SCHAglwJr/
        7n2HPTO9ND6M8AQY4V4ctMSR4e6NnqUmUH/zDbcR1R2NL2CQB3Fsl6BTZRMcu4nZ/mmh/qYzAYhYd
        QenPzyrFI21oIgBmWHVqjvBhsxr8GXThY4MdmRexRchBU7wkK2f9K3zQck+SS/AJk1UH2Zgkw9Sn4
        hdIru8n8IgLdrMyQHJR4Nh0nQuu68XizBFJmPRq5m8d6C7VTKLSNnhVZbZv4jWV1v6++XMh3RUNsQ
        5lMGRS9hhRmC8IB3cJ1iD/kSfgQ1AJ0wxnJyDgWOsnY72QyOP2ea3RhoRJCaGhTYzYaQ/mFWXC1bl
        bLOjDRZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBfI1-007Dta-NZ; Thu, 05 Aug 2021 15:28:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EAEC300084;
        Thu,  5 Aug 2021 17:28:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29C9324C18599; Thu,  5 Aug 2021 17:28:08 +0200 (CEST)
Date:   Thu, 5 Aug 2021 17:28:08 +0200
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
Message-ID: <YQwDiORI3jsh8vNw@hirez.programming.kicks-ass.net>
References: <BYAPR05MB483975D437F293A40BEF3189A6EC9@BYAPR05MB4839.namprd05.prod.outlook.com>
 <87a6m4kk4f.mognet@arm.com>
 <BYAPR05MB520669C6C1A8A522B1DE0EAAA4F29@BYAPR05MB5206.namprd05.prod.outlook.com>
 <20210805105853.66425074@oasis.local.home>
 <YQv+HHwrMmiUYZ4+@hirez.programming.kicks-ass.net>
 <20210805112437.17604e2d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805112437.17604e2d@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:24:37AM -0400, Steven Rostedt wrote:
> On Thu, 5 Aug 2021 17:05:00 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Hmm, is this a user space breakage?  
> > 
> > All those files were under CONFIG_SCHED_DEBUG and a !DEBUG build would
> > not have them to begin with.
> 
> But you can have a config with CONFIG_DEBUG_FS disabled, and DEBUG and
> SCHED_DEBUG enabled, which means that there's now configs where this
> value is no longer available.

You already had that, notably: CONFIG_SCHED_DEBUG=n.

These have always been debug knobs, if you touch them you get to keep
the pieces.
