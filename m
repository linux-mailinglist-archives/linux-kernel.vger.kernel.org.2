Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCB03A4BE1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 03:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFLBPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 21:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhFLBPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 21:15:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61268610F8;
        Sat, 12 Jun 2021 01:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623460430;
        bh=hOWj5oxUzKrR7TOCf/4ZU1SJcAZxb5xvcGCReAuhJ3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oi1FHr0Ehnn0ao9HxhLQB3q8Yt8hjSQNYQkdnj8h5Mipb3IQJcZ22uIWNhYUtvC/u
         w55wS1XQwM0a1Pa8kPetHN7P2Ugb37kTOvVq1o4nuQ9epEZXVNNS/K++3CMfvLCRZ5
         5zpT8giWvmciecWimABZDSI3VYwIp7e3fupPk5Ya1kIHVUAv7wjhiSQAbK8ZyJ1Fiq
         qXoPXHPW7cWZCdfpegrLtO3KdAu8TbL6Tnbw5HW2CXUcGNKB2DkE8eUPstqbZ+6Ebu
         RD2KQWoXP6HFRmocEhs4+NJZi75cjCgeSkmR1TmEQPXtPzjNEb49tfc7cSkflAWheW
         LEzlRP4b6WYcg==
Date:   Sat, 12 Jun 2021 10:13:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
Message-Id: <20210612101347.a8e317344b0e6380d41f1cfe@kernel.org>
In-Reply-To: <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Fri, 11 Jun 2021 19:25:38 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Hi Masami,
> Thanks for the review.
> 
> 
> Masami Hiramatsu wrote:
> > Hi Naveen,
> > 
> > On Thu, 10 Jun 2021 14:26:17 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> When probing at different locations in the kernel, it is not always
> >> evident if the location can be probed or not. As an example:
> >> 
> >>     $ perf probe __radix__flush_tlb_range:35
> >>     Failed to write event: Invalid argument
> >>       Error: Failed to add events.
> >> 
> >> The probed line above is:
> >>      35         if (!mmu_has_feature(MMU_FTR_GTSE) && type == FLUSH_TYPE_GLOBAL) {
> >> 
> >> This ends up trying to probe on BUILD_BUG_ON(), which is rejected.
> >> However, the user receives no indication at all as to why the probe
> >> failed. Print an error in such cases so that it is clear that the probe
> >> was rejected.
> > 
> > Hmm, Nack for this way, but I understand that is a problem.
> > If you got the error in perf probe, which uses ftrace dynamic-event interface.
> > In that case, the errors should not be output in the dmesg, but are reported
> > via error_log in tracefs.
> 
> That would be a nice thing to add to perf, but I don't see why this 
> should be a either/or. I still think it is good to have the core kprobe 
> infrastructure print such errors in the kernel log.

Yes, but that is only when if there is any unexpected errors.

For the expected error (e.g. rejecting user input), the design policy is
- kprobes API should return correct error code.
- kprobe tracefs I/F should return correct error code and put a human
  readable error mesage in the error_log.
Thus, the perf probe should decode the error code or reuse the error_log.

> It is easier to look 
> up such error strings in the kernel source to understand why a probe was 
> rejected.

I don't like to put a log message for rejecting user input on dmesg anymore.


> We also have perf_event_open() as an interface to add probes, and I 
> don't think it would be helpful to require all tools to utilize the 
> error log from tracefs for this purpose.

No, perf probe doesn't use perf-event interface to add probes. It uses
the tracefs for adding probes.

Thank you,


> 
> 
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
