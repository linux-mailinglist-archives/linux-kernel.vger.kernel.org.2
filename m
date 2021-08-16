Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4133ED96A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhHPPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhHPPCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:02:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4969C60C3F;
        Mon, 16 Aug 2021 15:02:19 +0000 (UTC)
Date:   Mon, 16 Aug 2021 11:02:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] tracing/trace: apply filters on all output channels
Message-ID: <20210816110139.13a433a7@oasis.local.home>
In-Reply-To: <20210814034538.8428-1-kernelfans@gmail.com>
References: <20210814034538.8428-1-kernelfans@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2021 11:45:38 +0800
Pingfan Liu <kernelfans@gmail.com> wrote:

> The event filters are not applied on all of the output, which results in
> the flood of printk when using tp_printk. Unfolding
> event_trigger_unlock_commit_regs() into trace_event_buffer_commit(), so
> the filters can be applied on every output.

Nice.

I'll even add a stable tag and:

Fixes: 0daa2302968c1 ("tracing: Add tp_printk cmdline to have tracepoints go to printk()")

and push this to urgent.

Thanks,

-- Steve


> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> To: linux-kernel@vger.kernel.org
> ---
