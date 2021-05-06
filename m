Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9BE37516B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhEFJVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhEFJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:21:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gqwbzSXbrw1GKfT0NFkEh+Wl8x5nZXjehzcXALXxRbo=; b=syZXdjjijpJDxxhmNaevOdZ/ed
        IOmongEzh9jClU8ysIJlUEzGaXOXdCWMg79/bFjg58v2l2mVNPiqJQ3aiP3MxvDM8XwQpr/QBe1g9
        tMaLmjucUGX8HyrcrRVDyllHyKlRQAkUVmVK4mG5OACmBffg4JL+erihHVznJAiUiD44QRcFaZsn7
        jamnjK/nfQq2XHcKtaf9eCFN+H7PNZPTmjfcWXlNPWbecrTJPN7hg7yANSRkj4dfIXK5Ql973ugvN
        iulgjBR98H0cKUQPeP6jry+7tWvtmleqANL7MeQ7OPr3oqDD8DB5Lybzxmo4BDaUETDuzVjCNKnZG
        5hbL27zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lea8Z-001X1j-N8; Thu, 06 May 2021 09:17:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF209300103;
        Thu,  6 May 2021 11:17:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CF4D2018C406; Thu,  6 May 2021 11:17:38 +0200 (CEST)
Date:   Thu, 6 May 2021 11:17:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 3/4] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <YJO0MiHsdeW7umUL@hirez.programming.kicks-ass.net>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
 <YI/H2dBB5M5da6ba@hirez.programming.kicks-ass.net>
 <20210506042844.GB3388@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506042844.GB3388@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 09:28:44PM -0700, Ricardo Neri wrote:
> Thank you Peter! This code worked well and it looks better than what I
> proposed. May I add your Originally-by: and Signed-off-by: tags in a
> patch when I post v3?

Sure
