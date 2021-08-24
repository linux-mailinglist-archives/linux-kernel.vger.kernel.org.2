Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98E23F5F60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhHXNni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237266AbhHXNng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:43:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E0F61248;
        Tue, 24 Aug 2021 13:42:50 +0000 (UTC)
Date:   Tue, 24 Aug 2021 09:42:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     CGEL <cgel.zte@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] kernel:fair: fix boolreturn.cocci warnings
Message-ID: <20210824094244.2a7ebe0f@oasis.local.home>
In-Reply-To: <20210824094128.58898319@oasis.local.home>
References: <20210824062359.59474-1-deng.changcheng@zte.com.cn>
        <YSSqusBah2AzUD7V@hirez.programming.kicks-ass.net>
        <YSSsWaXD5VX+HJNS@hirez.programming.kicks-ass.net>
        <20210824094128.58898319@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 09:41:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Doesn't hurt to just take the patch and then you wont have to spend
> time on new robots flagging this as a "bug".

Or if you don't want to give credit to theses silly robots, just go
through the code yourself, and make one big cleanup. It's really
trivial work.

-- Steve
