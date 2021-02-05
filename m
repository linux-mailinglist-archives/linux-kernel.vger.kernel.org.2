Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EB93117BE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhBFAVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhBEMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:47:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5764DC061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yZtaSID4IKfZtizwfG4fctsBjAHUidpBxga8TSTfwP0=; b=DJPrg52QOixXzF09sp9pUvEFlS
        2BkMjat5ZRmhY1ak97exF7o3DLev2Wi+1lbispocZLgILGbYlByhLe+ojKZ6ORm33pHGIjH2Qa1pA
        T/PWCx535qakBlIWZB077lmcahjuDkD8AKAYjZpt9K3Ao+1Uoy+mk+BkQZT+V9OFRAWPzw268NxAB
        x5ZxVqapMyIh4YX1h5zyuRhCw9olHug3jgKTR7Nefv17JJt3Y8LD7wYdI1s7ZFWDSucS4znYmO3gL
        J5EMMK+CLD/yA/mk1hrMSmHErC6eNcOu+zArt+24TFDfb7fu8+E7X8Xnra2jZ4jnYC66jVDFYNv5M
        OkMchSaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l80Vk-0005R5-OU; Fri, 05 Feb 2021 12:46:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24C1F30066E;
        Fri,  5 Feb 2021 13:46:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E0142BC43FF0; Fri,  5 Feb 2021 13:46:55 +0100 (CET)
Date:   Fri, 5 Feb 2021 13:46:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] x86/hw_breakpoint: Prevent data breakpoints on
 __per_cpu_offset
Message-ID: <YB0+P3LiduCpWctO@hirez.programming.kicks-ass.net>
References: <20210204152708.21308-1-jiangshanlai@gmail.com>
 <CALCETrXk_xp5+tZiTOGzFLk76Pc3gGsnO80UzmHf=ZoqrUgr5w@mail.gmail.com>
 <877dnmagb1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dnmagb1.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:45:54PM +0100, Thomas Gleixner wrote:
> On Thu, Feb 04 2021 at 16:11, Andy Lutomirski wrote:
> > On Thu, Feb 4, 2021 at 6:26 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >> When FSGSBASE is enabled, paranoid_entry() fetches the per-CPU
> >> GSBASE value via __per_cpu_offset or pcpu_unit_offsets.
> >>
> >> When data breakpoint is set on __per_cpu_offset[cpu] (read-write
> >> operation), the specific cpu will be stuck in the infinite #DB loop.
> >> RCU will try to send NMI to the specific cpu, but it is not working
> >> either since NMI also relies on paranoid_entry().
> >
> > Should we consider having a .percpu..noinstr section and having
> > objtool enforce this?
> 
> I think so.

I'll put it on the TODO list somewhere ...
