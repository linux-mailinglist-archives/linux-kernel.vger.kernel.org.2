Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7630C68D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhBBQvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:51:36 -0500
Received: from foss.arm.com ([217.140.110.172]:53308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236868AbhBBQtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:49:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13426ED1;
        Tue,  2 Feb 2021 08:48:28 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D30DE3F73B;
        Tue,  2 Feb 2021 08:48:25 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Barry Song <song.bao.hua@hisilicon.com>,
        vincent.guittot@linaro.org, mgorman@suse.de, mingo@kernel.org,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-kernel@vger.kernel.org
Cc:     linuxarm@openeuler.org, xuwei5@huawei.com, liguozhu@hisilicon.com,
        tiantao6@hisilicon.com, wanghuiqiang@huawei.com,
        prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
        guodong.xu@linaro.org, Barry Song <song.bao.hua@hisilicon.com>,
        Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH] sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2
In-Reply-To: <jhj4kiu4hz8.mognet@arm.com>
References: <20210201033830.15040-1-song.bao.hua@hisilicon.com> <jhj4kiu4hz8.mognet@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 02 Feb 2021 16:48:23 +0000
Message-ID: <jhj1rdy4drc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 15:17, Valentin Schneider wrote:
> That is, rather than building overlapping groups and fixing them whenever
> that breaks (distance > 2), we could have:
> - the local group being the child domain's span (as always)
> - all non-local NUMA groups spanning a single node each, with the right sgc
>   cross-referencing.
>
> Thoughts?
>

Hmph I'm thinking this can be broken by domain degeneration, as nothing
will come fix up the ->sgc link and we'd be back to having a reference to a
group that doesn't get updated... 
