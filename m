Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E743B6BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhF2BKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhF2BK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:10:27 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718F861360;
        Tue, 29 Jun 2021 01:08:00 +0000 (UTC)
Date:   Mon, 28 Jun 2021 21:07:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, dvyukov@google.com, elver@google.com
Subject: Re: [PATCH v2 03/24] objtool: Handle __sanitize_cov*() tail calls
Message-ID: <20210628210758.46a85e56@oasis.local.home>
In-Reply-To: <YNbixBy+s4ca6PU+@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
        <20210624095147.818783799@infradead.org>
        <20210625093824.03eb3cf7@oasis.local.home>
        <YNbixBy+s4ca6PU+@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2021 10:18:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > +	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
> > > +		if (sibling)
> > > +			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);  
> > 
> > Have you ever triggered the above?  
> 
> No, that would be really daft. But since this function is to be called
> for both regular and tail calls, I figured I'd at least pretend to
> handle the case.

OK. I thought this was like one of those weird laws that were made
because you know that someone did something really stupid once.

-- Steve
