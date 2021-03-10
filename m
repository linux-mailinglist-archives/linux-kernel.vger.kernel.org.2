Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8333400E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhCJON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhCJON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:13:27 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926FA64FE5;
        Wed, 10 Mar 2021 14:13:26 +0000 (UTC)
Date:   Wed, 10 Mar 2021 09:13:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: The killing of ideal_nops[]
Message-ID: <20210310091324.0c346d5f@oasis.local.home>
In-Reply-To: <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
        <20210309120519.7c6bbb97@gandalf.local.home>
        <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
        <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
        <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
        <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net>
        <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net>
        <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 11:22:48 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> After this FEATURE_NOPL is unused except for required-features for
> x86_64. FEATURE_K8 is only used for PTI and FEATURE_K7 is unused.
> 
> AFAICT this negatively affects lots of 32bit (DONTCARE) and 32bit on
> 64bit CPUs (CARELESS) and early AMD (K8) which is from 2003 and almost
> 2 decades old by now (SHRUG).
> 
> Everything x86_64 since AMD K10 (2007) was using p6_nops.
> 
> And per FEATURE_NOPL being required for x86_64, all those CPUs can use
> p6_nops. So stop caring about NOPs, simplify things and get on with life
> :-)

Before ripping out all the ideal_nop logic, I wonder if we should just
force the nops you want now (that is, don't change the selected
ideal_nops, just "pretend" that the CPU wants p6_nops), and see if anyone
complains. After a few releases, if there's no complaints, then we can
rip out the ideal_nop logic.

-- Steve
