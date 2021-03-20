Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE93342DDF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCTPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:41:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1023FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gBDlxI5aKGe9pRGaE6ne/ZiP0D7haWjgEgkUbjp2XBM=; b=OTR2P7DFdhIULWG/o79CJlzewh
        kY4o62NxS7wei1AgKrU94aSyX0YWsp8rlsU9iFc6PMAW9QyVQW7kQZh4AiqFDWsI0p9CjSUPdzHsw
        ZmjyWzFND5Zxk/E9mg1sS1hY2z18jqnbr5YxULaQdGlX9JMeCNiA4ZTS9tx36L4wQ2vuq06jS7jSQ
        V06TZsvHEBep1icB0fnzxzEK/WQk2sW0LzVZRp1X8r6uA0wStxo8oLm+n8+yagXSIw5IhzOE5i4YW
        uS0GXlVyALWMKQ8yVnpvozpJvBrNmXELePund44ds8mCgxOco+HF0gy6Uk2Sgt1m5DHsDjznycP1q
        +A5Ce6rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNdi9-008znu-BE; Sat, 20 Mar 2021 15:40:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFCB59864FF; Sat, 20 Mar 2021 16:40:20 +0100 (CET)
Date:   Sat, 20 Mar 2021 16:40:20 +0100
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 0/6] Core scheduling remaining patches
Message-ID: <20210320154020.GY4746@worktop.programming.kicks-ass.net>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319203253.3352417-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 04:32:47PM -0400, Joel Fernandes (Google) wrote:
> Enclosed is interface related core scheduling patches and one for migration.
> The main core scheduling patches were already pulled in by Peter with these
> bits left.

Funny thing, they don't appear to apply to my sched/core-sched branch...
:/ Either I really shouldn't be working weekends or something went
wobbly on your end...
