Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8453945D910
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbhKYLWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:22:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49406 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhKYLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:20:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 55B0F2114D;
        Thu, 25 Nov 2021 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637839054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jn00Br2z13eq+N/xHXiYesCdqcll2rp3dBLk2AO3OQ=;
        b=ceWZM0hl4arGpDOnxI6KexwLg6TNGk0xXhe1TDn+KgqUKlhCiu37qK7fdn5w03AoqHT9e+
        byhIY8klO8SRnL0WEVYgbWoM3mxRihtI4waX2LD8YBHNp5vlOWibxw+Y6rgw6G6asoVALw
        2YjqFIjsomnYnHzBd4oAoQ12g+nT9ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637839054;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jn00Br2z13eq+N/xHXiYesCdqcll2rp3dBLk2AO3OQ=;
        b=CYXsQCeAcKMe0INF00cPQX1SQHc4AdfJtZw0yDk8a5F2VtpT6UuPacdGRjIBvVt3cnioFp
        8LyGIpt7ZAHW+bBg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3DFF2A3B83;
        Thu, 25 Nov 2021 11:17:32 +0000 (UTC)
Date:   Thu, 25 Nov 2021 11:17:31 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, song.bao.hua@hisilicon.com,
        prime.zeng@huawei.com, linuxarm@huawei.com, 21cnbao@gmail.com
Subject: Re: [PATCH] sched/fair: Clear target from cpus to scan in
 select_idle_cpu
Message-ID: <20211125111731.GE3301@suse.de>
References: <20211124085401.14411-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211124085401.14411-1-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:54:01PM +0800, Yicong Yang wrote:
> Commit 56498cfb045d noticed that "When select_idle_cpu starts scanning for
> an idle CPU, it starts with a target CPU that has already been checked
> by select_idle_sibling. This patch starts with the next CPU instead."
> It only changed the scanning start cpu to target + 1 but still leave
> the target in the scanning cpumask. The target still have a chance to be
> checked in the last turn. Fix this by clear the target from the cpus
> to scan.
> 
> Fixes: 56498cfb045d ("sched/fair: Avoid a second scan of target in select_idle_cpu")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Did you check the performance of this? When I tried something like this
in a different context, I found that the cost of clearing the bit was
more expensive than simply using target + 1. For the target to be
rescanned, the whole mask would have to be scanned as no other CPUs are
idle which is the unlikely case. By clearing the bit, a cost is always
incurred even if the first CPU scanned is idle.

-- 
Mel Gorman
SUSE Labs
