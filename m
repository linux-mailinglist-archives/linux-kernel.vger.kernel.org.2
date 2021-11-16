Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F4D45329B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhKPNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236537AbhKPNKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:10:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032716127C;
        Tue, 16 Nov 2021 13:07:50 +0000 (UTC)
Date:   Tue, 16 Nov 2021 08:07:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>, mark-pk.tsai@mediatek.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
Message-ID: <20211116080749.1ef6337f@gandalf.local.home>
In-Reply-To: <20211116081020.GW174703@worktop.programming.kicks-ass.net>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211116024942.60644-1-yinan@linux.alibaba.com>
        <20211116024942.60644-3-yinan@linux.alibaba.com>
        <20211116081020.GW174703@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 09:10:20 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Nov 16, 2021 at 10:49:42AM +0800, Yinan Liu wrote:
> > In some business scenarios, GCC versions are so old that
> > optimizations in ftrace cannot be completed, such as
> > -mrecord-mcount and -mnop-mcount. The recordmCount in the
> > kernel is actually used. In this case, ftrace_init will
> > consume a period of time, usually around 9~12ms. Do nop
> > substitution in recordmcount.c to speed up ftrace_init.  
> 
> I really don't buy this.. if you can build a fresh kernel, you can
> install a fresh gcc too -- and if you care about performance that's a
> very good idea anyway.
> 

I'm not sure this is true for all archs, is it? That is, is the nop
substitution available in all archs that support mcount updates. Some
(most) archs are special, because they have to deal with link registers and
such.

And because of that, I'm not sure the patch works for all those archs.

-- Steve
