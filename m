Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28FD3782D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhEJKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:37:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhEJKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:33:09 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620642722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2ABzFwgpTaNmSQzmNszmV3x7ptxwfOXkhkDPBcLXTA=;
        b=iewf3RLKD70SxS8pcWTZZgqtmAjkfyufDdjPACvnAduUe7C5yWbOn6+Q6BwqaQPPkAaZyU
        6F1tgHq0FjNhmziAp6iy49PRuu/gqPS85jhW1khDVqBQngTclNg/LCIyN/i07fYxOaggsK
        jE4PN4kgt2GIap9afY/S0V4l2AO+UEbu5ftzvyKdu0gadFmskerHZ1/F0+kdgzQVu7Lanf
        +5/zby8m8c7rKd5SHNf3tS6/ktJ3orV1Gjp91Fgytpv96YbqYU2L11v+dwEF6QiHvDNcHS
        q45OimTkmIYeoLbjNzTnqHyis6HSnWvk7lRbcvqHZ1JByy+yxpZZBxN/jhvVzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620642722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2ABzFwgpTaNmSQzmNszmV3x7ptxwfOXkhkDPBcLXTA=;
        b=nuiU5hD3oBZsdBwLk/r9mRamTgZGB87qxVynXYifEPVYuD2ZxByQswCHjPAkQHq+RJ0TrT
        NuK4gvBdVZpdfhBQ==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush prb
In-Reply-To: <YJkIK9cyHr46UAFP@alley>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com> <YJPxj83F1sBjHHAE@alley> <YJP4F1UIt/eRZ96s@google.com> <YJP5MnkJ8pJevXM6@google.com> <YJVsgPc66lhaAUN0@alley> <YJjuRV57eO3Pp/bp@google.com> <YJkIK9cyHr46UAFP@alley>
Date:   Mon, 10 May 2021 12:32:01 +0200
Message-ID: <871raeop5q.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-10, Petr Mladek <pmladek@suse.com> wrote:
> The current plan is to move console work to kthreads (separate
> preemptive context). Using IRQ is a complete opposite way.
>
> There is always the fight between getting the messages out as soon
> as possible and the risk of breaking the system (softlockups,
> deadlocks).
>
> The kthread approach reduces the risk of system breakage to a bare
> minimum. The price is that some messages might never reach console.
> There is finally a consensus to give it a try. If it fails, we might
> start looking for alternatives again.

+1

I think it is clear that any such fixups will disappear once
atomic-consoles and console printing kthreads arrive. That doesn't mean
we should ignore the fixups. We just need to decide if it is a real
problem that needs our immediate attention, thus warranting a fixup in
the current implementation.

I can see the suspend/resume issue might be a real problem. If this
should be addressed now, I would support Petr's patch, forcing the
backlog to be printed in the preemptible resuming context. But let's
just keep it a suspend/resume fixup. I do not think we want to start
playing with how console_unlock() behaves.

John Ogness
