Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2B435E20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhJUJpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:45:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57596 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhJUJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:45:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 078F11FDAC;
        Thu, 21 Oct 2021 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634809395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nAAXadDi6/fpR3j85eAznPcX2X6xtLyC6KlMM4QxiUk=;
        b=cBABVvzxpF8ORKUey/ExhOz5MxVml6irudJDkpVxemF6I+QSFee4+oFwpYumXNmqy4B/ko
        SWyPJGVa2TSvJBx/2xx54adgV9hgOiVlVKxUhtYWI5XMy5ZYYTgajGsl1SpcBNJSMLEaGc
        2etR+/Zt59nF4GdmkZClhNsrO71CoIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634809395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nAAXadDi6/fpR3j85eAznPcX2X6xtLyC6KlMM4QxiUk=;
        b=4LIcgOPAAnao4jUjWGoTVpQhWcoLlX6OTP+eKifnQ9A5b9F9vzRlbC1Q8u7v9vttKyGwvP
        InlK4W4KwIVmxmBw==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CEE49A3B91;
        Thu, 21 Oct 2021 09:43:13 +0000 (UTC)
Date:   Thu, 21 Oct 2021 10:43:11 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 1/5] sched/fair: Account update_blocked_averages in
 newidle_balance cost
Message-ID: <20211021094311.GB3891@suse.de>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211019123537.17146-2-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:35:33PM +0200, Vincent Guittot wrote:
> The time spent to update the blocked load can be significant depending of
> the complexity fo the cgroup hierarchy. Take this time into account in
> the cost of the 1st load balance of a newly idle cpu.
> 
> Also reduce the number of call to sched_clock_cpu() and track more actual
> work.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
