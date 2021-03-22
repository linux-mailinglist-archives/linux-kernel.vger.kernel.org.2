Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86634522F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCVWAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhCVWAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:00:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6B9619A3;
        Mon, 22 Mar 2021 22:00:42 +0000 (UTC)
Date:   Mon, 22 Mar 2021 18:00:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: shut up -Wcast-function-type warning for
 ftrace_ops_no_ops
Message-ID: <20210322180040.77a00e86@gandalf.local.home>
In-Reply-To: <20210322215006.1028517-1-arnd@kernel.org>
References: <20210322215006.1028517-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 22:49:58 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> With 'make W=1', gcc warns about casts between incompatible function
> types:
> 
> kernel/trace/ftrace.c:128:31: error: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Werror=cast-function-type]
>   128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
>       |                               ^
> 
> As the commet here explains, this one was intentional, so shut up the
> warning harder by using a double cast.

Bonus points for reading the comment ;-)

I'll take this patch for the next merge window, thanks!

-- Steve
