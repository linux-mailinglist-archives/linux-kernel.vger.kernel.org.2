Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58A34B343
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 01:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhC0AMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 20:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhC0AMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 20:12:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A8C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 17:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g7CX3ObKEZFPHfE2CrxoZpsvFPZB8ASiYPTz2KR8q0Q=; b=Y18hNRKwse5r4jkAnvBT/wTpGh
        SL5BfZDIQvlzN3INiqTDT5fT+e9VXnLotEeTX18jJmEMIgw1E1SkUXNkX1KjQ9NJRnrGlKMFoEM71
        +/ogPpr5G8E31mIgbPOCynvT5b6wGWOzRzbu8fgjgj2EcPIcRXlwlP+A9iDjueYUjvNMy0DcxjMFB
        cHz7x0VRVPXYR3zbe8u6iBLAMUZ4NSr0AsMElm3zLnSf3jnlUMq16I1IjHhhYZdnyNUiNNoXgsY31
        pPYqFkwGUgZezkhHGJTl6hnRnteggsjPqBwKDt7MVPmEH8ICVGxTnTdr7Ze4Xs/WLPQKV6t2r2D5e
        rg+k8yMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPwWO-00Fez6-CC; Sat, 27 Mar 2021 00:09:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27F9698108D; Sat, 27 Mar 2021 01:09:43 +0100 (CET)
Date:   Sat, 27 Mar 2021 01:09:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, dhiatt@digitalocean.com
Subject: Re: [PATCH resend 2/8] sched: core scheduling tagging infrastructure
Message-ID: <20210327000943.GQ4746@worktop.programming.kicks-ass.net>
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324214020.34142-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 05:40:14PM -0400, Joel Fernandes (Google) wrote:
> From: Josh Don <joshdon@google.com>
> 
> A single unsigned long is insufficient as a cookie value for core
> scheduling. We will minimally have cookie values for a per-task and a
> per-group interface, which must be combined into an overall cookie.
> 
> This patch adds the infrastructure necessary for setting task and group
> cookie. Namely, it reworks the core_cookie into a struct, and provides
> interfaces for setting task and group cookie, as well as other
> operations (i.e. compare()). Subsequent patches will use these hooks to
> provide an API for setting these cookies.
> 

*urgh*... so I specifically wanted the task interface first to avoid /
get-rid of all this madness. And then you keep it :-(

I've spend the past few hours rewriting patches #2 and #3, and adapting
#4. The thing was working before I added SHARE_FROM back and introduced
GET, but now I'm seeing a few FAILs from the selftest.

I'm too tired to make sense of anything much, or even focus my eyes
consistently, so I'll have to prod at it some more next week, but I've
pushed out the lot to my queue.git:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/core-sched

Also, we really need a better name than coretag.c.
