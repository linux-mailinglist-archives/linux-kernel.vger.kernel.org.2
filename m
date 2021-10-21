Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A654435E33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhJUJtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:49:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45038 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhJUJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:49:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EB27921989;
        Thu, 21 Oct 2021 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634809615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iL0FGkgQ+00vIDzyXvU4qGdZhYe9TsBrYAloXnNsW5c=;
        b=QFBZTZp8dgDLWkL3LnD/T2DUQOpApheTrDjxaTFd52sL8wXrDBwcqVywFgYDSBhKZJiwQn
        TBEtO32KdFaS5WnuCbPLV9aw7uE+TRrAbqvBlR5Ns4H3OK7evIhDX4pLOceWE1NFhUmHw3
        gzc4MzXEJ4q8gaEkX7VoxkO1Wp/jZfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634809615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iL0FGkgQ+00vIDzyXvU4qGdZhYe9TsBrYAloXnNsW5c=;
        b=YFOsr2pE1quQYA9N82FNUkP3kxA4aDjuYl252O/R5PZJvHTx44/DR0ZGW1s2OzCxOf3v3/
        YXUsSbxuf+U27NBQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5326BA3B81;
        Thu, 21 Oct 2021 09:46:55 +0000 (UTC)
Date:   Thu, 21 Oct 2021 10:46:53 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 5/5] sched/fair: cleanup newidle_balance
Message-ID: <20211021094653.GF3891@suse.de>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211019123537.17146-6-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:35:37PM +0200, Vincent Guittot wrote:
> update_next_balance() uses sd->last_balance which is not modified by
> load_balance() so we can merge the 2 calls in one place.
> 
> No functional change
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
