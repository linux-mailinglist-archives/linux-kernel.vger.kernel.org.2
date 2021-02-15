Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391FE31BA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhBONa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:30:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:35868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhBON3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:29:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613395699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iF1BRjXQMTisniUtNADTMpFVGQna/LODXZPKPHQVe4M=;
        b=o88tO8yO6q1u06QX8QKb1J8knO2KxhW/C+tXVzOehbr5VwK4IPD+vkAMC+5mEXH3nOGhln
        dxvxYdtuYrTnfdzkmG4mqttXFjfvoOQJ/zAWyraXxuAfPtuXs1U5bP5vTi83Tvyva5YPt8
        3oEB/QeU47jsMB3vCwZmA/hQxWsISJE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD7C6ADF0;
        Mon, 15 Feb 2021 13:28:19 +0000 (UTC)
Date:   Mon, 15 Feb 2021 14:28:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yiwei Zhang <zzyiwei@android.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
Message-ID: <YCp288w57eYnjPl0@alley>
References: <20210214000611.2169820-1-zzyiwei@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214000611.2169820-1-zzyiwei@android.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-02-14 00:06:11, Yiwei Zhang wrote:
> The existing kthread_mod_delayed_work api will queue a new work if
> failing to cancel the current work due to no longer being pending.
> However, there's a case that the same work can be enqueued from both
> an async request and a delayed work, and a racing could happen if the
> async request comes right after the timeout delayed work gets
> scheduled,

By other words, you want to modify the delayed work only when
it is still waiting in the queue. You do not want to queue new
work when it has not been already queued. Do I get it correctly?

Could you please provide a patch where the new API is used?

> because the clean up work may not be safe to run twice.

This looks like a bad design of the code. There is likely
another race that might break it. You should ask the following
questions:

Why anyone tries to modify the clean up work when it has been already
queued? There should be only one location/caller that triggers the clean up.

Could anyone queue any work to the workqueue after the clean up
work was queued? The cleanup work should be the last queued one.
The workqueue user must inform all other users that the queue
is being destroyed and nobody is allowed to queue any work
any longer.

Best Regards,
Petr
