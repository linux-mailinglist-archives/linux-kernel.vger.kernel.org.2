Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAD30599F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhA0L0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:26:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:42112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236573AbhA0LYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:24:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30C22B7CB;
        Wed, 27 Jan 2021 11:23:32 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:23:31 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3 v2] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20210127112331.bew6os5jfyvjzhwj@beryllium.lan>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-4-bigeasy@linutronix.de>
 <20210125083012.GD942655@infradead.org>
 <20210125083204.ahddujk5m6njwbju@linutronix.de>
 <20210125083903.GB945284@infradead.org>
 <20210125095412.qxknd2vbsmgtrhqb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125095412.qxknd2vbsmgtrhqb@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:54:12AM +0100, Sebastian Andrzej Siewior wrote:
> With llist_head it is possible to avoid the locking (the irq-off region)
> when items are added. This makes it possible to add items on a remote
> CPU without additional locking.
> llist_add() returns true if the list was previously empty. This can be
> used to invoke the SMP function call / raise sofirq only if the first
> item was added (otherwise it is already pending).
> This simplifies the code a little and reduces the IRQ-off regions.
> 
> blk_mq_raise_softirq() needs a preempt-disable section to ensure the
> request is enqueued on the same CPU as the softirq is raised.
> Some callers (USB-storage) invoke this path in preemptible context.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I did a quick test run with the whole series. Looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
