Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3050D435E29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhJUJqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:46:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44844 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhJUJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:46:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 858BF21989;
        Thu, 21 Oct 2021 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634809456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pulkmnjKtTAwPpTZ13P67pyFhgsOOgsgaWJ8hYgbYgs=;
        b=nNhoC1JbbnmyPzzNLyv+QtZvu6nZ68vm1Uiyd7BA68XCmkPEpoe7S8JeEqnKPcn7jF+rZo
        MhnBGpJ8Ed8alSLJVySdfPFalV44lMJz7yXwkfXaU2xxPr4WSizHn+RaD5awJ9JJe8qZPy
        diBp5vSDUyqCs0ZBUCOhopAZDGrWkEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634809456;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pulkmnjKtTAwPpTZ13P67pyFhgsOOgsgaWJ8hYgbYgs=;
        b=lIQuSWpqSA0wlaCDrP51iU7IWkM7LBCJ7mpliyl9jtT5zMMN7ES7ZCwdfwkTZ9eFtP7Rc/
        otnvceAmDl1vpBDw==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DCBC8A3B8F;
        Thu, 21 Oct 2021 09:44:15 +0000 (UTC)
Date:   Thu, 21 Oct 2021 10:44:12 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 2/5] sched/fair: Skip update_blocked_averages if we
 are defering load balance
Message-ID: <20211021094412.GC3891@suse.de>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211019123537.17146-3-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:35:34PM +0200, Vincent Guittot wrote:
> In newidle_balance(), the scheduler skips load balance to the new idle cpu
> when the 1st sd of this_rq is:
> 
>    this_rq->avg_idle < sd->max_newidle_lb_cost
> 
> Doing a costly call to update_blocked_averages() will not be useful and
> simply adds overhead when this condition is true.
> 
> Check the condition early in newidle_balance() to skip
> update_blocked_averages() when possible.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

The Signed-off-by seems to be in the wrong order but otherwise

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
