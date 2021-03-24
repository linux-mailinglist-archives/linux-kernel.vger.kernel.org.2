Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3376F347B30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhCXOxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236398AbhCXOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:53:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8466561A10;
        Wed, 24 Mar 2021 14:53:14 +0000 (UTC)
Date:   Wed, 24 Mar 2021 10:53:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210324105313.4ff3ad07@gandalf.local.home>
In-Reply-To: <20210324144853.GA5718@roeck-us.net>
References: <20210210144409.36ecdaed@xhacker.debian>
        <20210324143407.GA8717@roeck-us.net>
        <20210324144853.GA5718@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 07:48:53 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Mar 24, 2021 at 07:34:07AM -0700, Guenter Roeck wrote:
> > On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote:  
> > > Add tracepoints to retrieve information about the invoke_fn. This would
> > > help to measure how many invoke_fn are triggered and how long it takes
> > > to complete one invoke_fn call.
> > > 
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>  
> > 
> > arm64:defconfig:
> > 
> > make-arm64 -j drivers/tee/optee/call.o
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> >   CC      drivers/tee/optee/call.o
> > In file included from drivers/tee/optee/optee_trace.h:67,
> >                  from drivers/tee/optee/call.c:18:
> > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such file or directory
> >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >       |                                          ^
> > compilation terminated.
> >   
> 
> The problem also affects arm:imx_v6_v7_defconfig.
> 

I think it affects everything. The problem is that the
drivers/tee/optee/Makefile needs to be updated with:

CFLAGS_call.o := -I$(src)

otherwise the compiler wont know how to find the path to optee_tree.h.

This is described in:

   samples/trace_events/Makefile

-- Steve
