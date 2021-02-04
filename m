Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0330F3B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhBDNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbhBDNLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:11:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64265C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UZgksNxm6SOw/gXdBnvP4EnQzkpmeiBlC2lCiXVt8AE=; b=oXS9HxGii1LL4ZtEbzJwHNBxCq
        DG4gZ1VgPF0D02+0H/rUyE3sgE/THb6wbRmK7XNOwCPLmUY7Mxf7vD2auu5Uj9Md3GCN/VIrT5Ows
        /Sii0vPxK7OYoOCb21hQ6IHvOTteyMPLX87GzZWcqnzR8fw3XFydS+IX7s4AnXiT/09trjXz/HeX7
        R7CFR4uaKFid3xMHzNxIHXJedu5hbv4InmofWR+Ikw1sh1xRwZAlO2jxDDh+wS33Lkehp1W/i/7te
        WLdJofKGmDPPgr8Rtw/uAnbvpU3TnPUHHeyFVGDKFIbh9zWo8JprUn5dciCE/Je9J4Sx44YneVBVX
        1xtk5mGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7eP8-0005WU-My; Thu, 04 Feb 2021 13:10:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 425073003D8;
        Thu,  4 Feb 2021 14:10:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27616213D2E27; Thu,  4 Feb 2021 14:10:36 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:10:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <YBvyTDR+q0M62vKR@hirez.programming.kicks-ass.net>
References: <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
 <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
 <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
 <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
 <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
 <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 01:53:59PM +0100, Dmitry Vyukov wrote:
> Humm... I was thinking of perf_event_open(pid == 0).
> It does not make sense to send SIGTRAP in a remote process, because it
> does not necessarily cooperate with us.
> 
> But is there any problem with clone w/o CLONE_THREAD? Assuming the
> current process has setup the signal handler, the child will have the
> same handler and the same code/address space. So delivery of SIGTRAP
> should work the same way in the child.

Nothing should be doing CLONE_VM without CLONE_THREAD. Yes, it's
possible, but if you do so, you get to keep the pieces IMO.

Current libc either does a full clone (fork) or pthread_create,
pthread_create does CLONE_THREAD.
