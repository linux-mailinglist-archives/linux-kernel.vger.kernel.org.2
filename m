Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC34392DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhE0MPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:15:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233836AbhE0MPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:15:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622117653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ubri0iTXqSbG4njMyHYok09VeFeexWDkKI6v4avoIG4=;
        b=uz4U3LqIOrgVdW7xvJqCSVErZZkOB8eKU14+17k84gUlYnvW9kIDqoMzqyuB6Pks2mBjn1
        0hxpoknVhz1w98liL/fO1195C1bY/29CkbgBHga2cmUU/AKmYmQxDKiBNl2+Pj0dvio7ol
        K5CsDAJUL6L8A/wrBqV1qD3VSfvIUsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622117653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ubri0iTXqSbG4njMyHYok09VeFeexWDkKI6v4avoIG4=;
        b=xwFb2HZ0dLN8bDwk3tUFRPpOkaq/kJiyPzYxKVrmrAU7gHvKkDTFt28l3+SkGyGaVyhdLB
        U7hacXdAXs1tiSCw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03ABBAE39;
        Thu, 27 May 2021 12:14:13 +0000 (UTC)
Date:   Thu, 27 May 2021 13:14:09 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        tangchengchang <tangchengchang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] sched: fair: don't depend on wake_wide if waker and
 wakee are already in same LLC
Message-ID: <20210527121409.GK3672@suse.de>
References: <20210526091057.1800-1-song.bao.hua@hisilicon.com>
 <YK474+4xpYlAha+2@hirez.programming.kicks-ass.net>
 <7dd00a98d6454d5e92a7d9b936d1aa1c@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7dd00a98d6454d5e92a7d9b936d1aa1c@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 09:38:19PM +0000, Song Bao Hua (Barry Song) wrote:
> > And no supportive numbers...
> 
> Sorry for the confusion.
> 
> I actually put some supportive numbers at the below thread which
> derived this patch:
> https://lore.kernel.org/lkml/bbc339cef87e4009b6d56ee37e202daf@hisilicon.com/
> 
> when I tried to give Dietmar some pgbench data in that thread,
> I found in kunpeng920, while software ran in one die/numa with
> 24cores sharing LLC, disabling wake_wide() brought the best
> pgbench result.
> 
>                 llc_as_factor          don't_use_wake_wide
> Hmean     1     10869.27 (   0.00%)    10723.08 *  -1.34%*
> Hmean     8     19580.59 (   0.00%)    19469.34 *  -0.57%*
> Hmean     12    29643.56 (   0.00%)    29520.16 *  -0.42%*
> Hmean     24    43194.47 (   0.00%)    43774.78 *   1.34%*
> Hmean     32    40163.23 (   0.00%)    40742.93 *   1.44%*
> Hmean     48    42249.29 (   0.00%)    48329.00 *  14.39%*
> 
> The test was done by https://github.com/gormanm/mmtests
> and
> ./run-mmtests.sh --config ./configs/config-db-pgbench-timed-ro-medium test_tag
> 

Out of curiousity, I briefly tested this on a Zen2 machine which also
has multiple LLCs per node. Only tbench4 was executed and I cancelled
the other tests because of results like this

tbench4
                          5.13.0-rc2             5.13.0-rc2
                             vanilla sched-nowakewidellc-v1r1
Hmean     1        349.34 (   0.00%)      334.18 *  -4.34%*
Hmean     2        668.49 (   0.00%)      659.12 *  -1.40%*
Hmean     4       1307.90 (   0.00%)     1274.35 *  -2.57%*
Hmean     8       2482.08 (   0.00%)     2377.84 *  -4.20%*
Hmean     16      4460.06 (   0.00%)     4656.28 *   4.40%*
Hmean     32      9463.76 (   0.00%)     8909.61 *  -5.86%*
Hmean     64     15865.30 (   0.00%)    19682.77 *  24.06%*
Hmean     128    24350.06 (   0.00%)    21593.20 * -11.32%*
Hmean     256    39593.90 (   0.00%)    31389.33 * -20.72%*
Hmean     512    37851.54 (   0.00%)    30260.23 * -20.06%*

-- 
Mel Gorman
SUSE Labs
