Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6396D34998E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYSeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhCYSdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:33:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ABA561A01;
        Thu, 25 Mar 2021 18:33:54 +0000 (UTC)
Date:   Thu, 25 Mar 2021 14:33:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH] task_struct::state frobbing
Message-ID: <20210325143352.0e459baf@gandalf.local.home>
In-Reply-To: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
References: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 19:11:37 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
> index 5a3b65a6eb4f..17ee771e0051 100644
> --- a/drivers/net/ethernet/qualcomm/qca_spi.c
> +++ b/drivers/net/ethernet/qualcomm/qca_spi.c
> @@ -653,8 +653,7 @@ qcaspi_intr_handler(int irq, void *data)
>  	struct qcaspi *qca = data;
>  
>  	qca->intr_req++;
> -	if (qca->spi_thread &&
> -	    qca->spi_thread->state != TASK_RUNNING)
> +	if (qca->spi_thread)
>  		wake_up_process(qca->spi_thread);
>  
>  	return IRQ_HANDLED;
> @@ -777,8 +776,7 @@ qcaspi_netdev_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	netif_trans_update(dev);
>  
> -	if (qca->spi_thread &&
> -	    qca->spi_thread->state != TASK_RUNNING)
> +	if (qca->spi_thread)
>  		wake_up_process(qca->spi_thread);
>  
>  	return NETDEV_TX_OK;

I would break out the above changes (and the like) into a separate patch,
as it's changing the logic that doesn't match what the change log is doing.

That is, I would make all the changes that doesn't care about what the
state variable is (that is, removing the reference to it) first. Then do
the type change in a later patch.

-- Steve
