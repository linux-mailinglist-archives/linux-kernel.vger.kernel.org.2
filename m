Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6233E34CD90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhC2KCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhC2J1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:27:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qZ3M3nbcYig1T0+sNysEy6eKT+TCnQNoW5WfBPGFHhc=; b=Witj7OTUWLQUd8GHfYMEBB4JUF
        EU4WxwrRURr0mrq9MEhEZCLr5m/6vQjFyrOeHQRMKljvPLPSTe3YnB3H3LybQoqYVFRfNTms9oT/1
        KJoHeIvMjkPBDWBD6uZiF/VoDf4Uyu3u734FVNoLSIvQZq1JdmwhH6zPBJnqx6I/2/2kYqkC+s7Sj
        Qln0TGrvpyqEDp2wilKccWI8EqNAUnqL3cdkkbGuNW5t5b5lwfLm+kfxaWuCuCOnIAYbgAexx4xhk
        vipBUwwd4QQwlWlgeCri+ZzrTB0STT6n6g7Un0NGlvssGYDZn2UK9W0rsp97GWm9BdYARwWCqzdn9
        8u35KWPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQoAF-001K1x-Aw; Mon, 29 Mar 2021 09:26:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 918593003E5;
        Mon, 29 Mar 2021 11:24:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81707207189D6; Mon, 29 Mar 2021 11:24:19 +0200 (CEST)
Date:   Mon, 29 Mar 2021 11:24:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 00/15] locking/rtmutex: Spring cleaning
Message-ID: <YGGcww3coJWhDJBT@hirez.programming.kicks-ass.net>
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326152929.709289883@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:29:29PM +0100, Thomas Gleixner wrote:
>  a/kernel/locking/rtmutex-debug.c |  182 -----------------
>  a/kernel/locking/rtmutex-debug.h |   37 ---
>  a/kernel/locking/rtmutex.h       |   35 ---
>  include/linux/rtmutex.h          |   35 ---
>  kernel/locking/Makefile          |    2 
>  kernel/locking/rtmutex.c         |  402 ++++++++++++++-------------------------
>  kernel/locking/rtmutex_common.h  |  104 +++++-----
>  7 files changed, 202 insertions(+), 595 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
