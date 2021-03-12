Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D613396E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhCLSrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233833AbhCLSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:47:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7ADC64F69;
        Fri, 12 Mar 2021 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615574839;
        bh=2uFjKfwKbLyw+Q48WFWexw++e7YWReq36hDzFWGURzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=11lbXaZazkSyO8mzf6Bd3Q81q09SN6oY8X5PSMkC3ViyDi9hfVyA+/DyKwHWT0uom
         ItvIE7ISsTaeNyEvQC4oWEIr82aoFbEPRlrIbEAVyFuyUYoy8aHStwY0Vovj/MFpuE
         CtGeoI1uBgBQ0tj3jrunP7BnZTbM9SdaQU741DeI=
Date:   Fri, 12 Mar 2021 10:47:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-Id: <20210312104718.0685c3902fd0d22915aeacc6@linux-foundation.org>
In-Reply-To: <ccfef0d5-c419-0a8d-cf75-9642e9d11f94@torproject.org>
References: <20210312173855.24843-1-jnewsome@torproject.org>
        <20210312102207.a347e38db375226a78cc37bf@linux-foundation.org>
        <ccfef0d5-c419-0a8d-cf75-9642e9d11f94@torproject.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 12:39:12 -0600 Jim Newsome <jnewsome@torproject.org> wrote:

> On 3/12/21 12:22, Andrew Morton wrote:
> > 
> > Could we please see some performance testing results to permit us to
> > evaluate the value of this change?
> 
> Sure. I've been doing some ad-hoc measurements with the code below. It
> forks 8k children and then waits for them in reverse order (forcing a
> full list traversal each time). I'll need to reboot a couple times to
> get apples-to-apples measurements on bare metal, though. I'll plan to
> run with NUMCHILDREN = 0 -> 8000, by 100.
> 
> Does this look like it'd be sufficient, or is there more you'd like to
> see? The current form doesn't use ptrace, but I expect the results to be
> similar; (maybe more pronounced when tracing threaded children, since
> every thread is in the tracee list instead of just the group leaders).

A very specific microbenchmark which tickles a particular corner case
is useful, as long as there's some realistic chance that someone's
workload is adequately modeled by that test.

Also very useful would be some words which describe what led you to do
this work (presumably some real-world was being impacted) and a description
of how the patch improves that workload (or is expected to improve it).

IOW, please spend a bit of time selling the patch!  What is the case
for including it in Linux?  What benefit does it provide our users?
