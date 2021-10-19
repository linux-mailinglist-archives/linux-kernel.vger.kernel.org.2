Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B524F432BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 04:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhJSCx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 22:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhJSCx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 22:53:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF636128E;
        Tue, 19 Oct 2021 02:51:14 +0000 (UTC)
Date:   Mon, 18 Oct 2021 22:51:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <tom.zanussi@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] Performance deterioration caused by commit
 85f726a35e504418
Message-ID: <20211018225112.3f6bda99@gandalf.local.home>
In-Reply-To: <19e4222c-c9ac-5c1a-0c3a-b8bfd3524ab7@huawei.com>
References: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
        <20211018093731.2dd5917f@gandalf.local.home>
        <19e4222c-c9ac-5c1a-0c3a-b8bfd3524ab7@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 10:39:47 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> Hi Steve,
> 
> On 2021/10/18 21:37, Steven Rostedt wrote:
> > On Mon, 18 Oct 2021 11:23:14 +0800
> > Yang Jihong <yangjihong1@huawei.com> wrote:
> >   
> >> Hi Tom and Steven,
> >>
> >> commit 85f726a35e504418 use strncpy instead of memcpy when copying comm,
> >> on ARM64 machine, this commit causes performance degradation.
> >>
> >> I test the number of instructions executed by invoking the
> >> trace_sched_switch function once on an arm64 machine:
> >> 1. Use memcpy, the number of instructions executed is 850.
> >> 2. Use strncpy, the number of instructions executed 1100.
> >> That is, use strncpy is almost 250 more instructions than memcpy.
> >>
> >> Has the impact on performance been considered in this commit? :)
> >> What is the impact of revert the patch?
> >>  
> > 
> > It's a security issue. And like everything security, there's always going
> > to be a performance impact. Look at the performance impact due to spectre
> > and meltdown!
> > 
> > That said, although memcpy() may not be used, we don't need strncpy.
> > strncpy() will pad the rest of the string with nul bytes. But since the
> > memory the string is being recorded into is already initialized (or can be
> > if it isn't), we could use the faster strlcpy().
> > 
> > Have you tried testing it by switching strncpy() with strlcpy()?
> >   
> I have tried testing it by switching strncpy() with strlcpy(), there is 
> no performance improvement, probably because the strlen function is 
> called in strlpy and the string is traversed each time.

Then there's not much we can do. Security trumps performance. Not to
mention, the garbage in the comm after the '\0' causes the histograms to
produce strange results.

Now for the saved_cmdlines, since it isn't exported directly to user space,
that one may be put back to memcpy().

Tom, was there a reason to change saved_cmdlines(), as I'm not sure that is
leaked. It looks like it is printed with the normal seq_printf() in
saved_cmdlines_show().

And it doesn't even look like the saved_cmdlines() is even initialized to
zero, so it itself could leak memory if it was exposed.

-- Steve
