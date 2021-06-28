Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464933B5FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhF1OP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhF1OP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:15:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 629B361C75;
        Mon, 28 Jun 2021 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624889582;
        bh=10OGvJ3sV5SvCdwDzuwVsEK0pFrJzuzIqJkU4Gcps6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fanLLj7weVcWfc7hX6CBz3vT3zNr4JjKaMFYB6fHBl2d1b6yO1kweoa+5bkknFj8Z
         Bs+evzbqWlyOP2RSMVmCdQeP6yqC0Hc6tDE/LLNNcSxqb69FCnkPrPlumXpY3MlEV0
         qx18nmQaDOvwl/f2l5jYFtCIItIAOwzf3VgEm9jtiPZJNcow0PyL+fsd7INsYIvAFb
         2xiccBDaL4myquws9eRxZFOCyvuXrki1cU0BXgIISsuVZRjqNyE+j2RevUzacRAGvq
         Xo7hqJICXsOrAPCfJbv/LAg7cwYxJEbAkKDL9+oOKY2kBWT0XxdkJmnpewKOC7EaCO
         Dc3bN26Sopnjg==
Date:   Mon, 28 Jun 2021 16:13:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>,
        "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Message-ID: <20210628141300.GA5710@lothringen>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>
 <20210616125452.GE801071@lothringen>
 <OSBPR01MB21836F532CA384C7378C1284EB099@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183D3C6B2BBF25B22DD09FAEB039@OSBPR01MB2183.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2183D3C6B2BBF25B22DD09FAEB039@OSBPR01MB2183.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 02:36:27AM +0000, hasegawa-hitomi@fujitsu.com wrote:
> Hi Frederic, Peter, and Mel
> 
> > I tested this and confirmed that it gives accurate values.
> > Also, task_sched_runtime () is done only on nohz_full CPU, so I think
> > it's a better idea than before.
> > I hope you will incorporate this fix into your mainline.
> 
> I have also confirmed that CPUs other than nohz_full have very little overhead.
> Please consider merging it into the mainline.

Ok, I'm going to submit a proper patch.

Thanks!
