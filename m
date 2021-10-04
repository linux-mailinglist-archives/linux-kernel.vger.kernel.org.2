Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9248421A74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 01:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhJDXJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 19:09:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:32533 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231273AbhJDXJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 19:09:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="205730319"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="205730319"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 16:07:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="439279781"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.66.53])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 16:06:59 -0700
Message-ID: <82a781785fd7933d5fa0317de4ba6fe6081c7be0.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] sched/fair: Improve cost accounting of
 newidle_balance
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 04 Oct 2021 16:06:58 -0700
In-Reply-To: <20211004171451.24090-1-vincent.guittot@linaro.org>
References: <20211004171451.24090-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-04 at 19:14 +0200, Vincent Guittot wrote:
> Improve the precision of the cost of newidle_balance by taking into
> account
> the time spent in updating blocked load and skipping load balance
> loop 
> entirely if there is no chance to run at least one.
> 

Thanks Vincent.

I'll ask our benchmark team to give it a spin.  They've been fairly
busy. I hope to get some bandwidth from them in next couple of
weeks.

Tim

> Vincent Guittot (2):
>   sched/fair: account update_blocked_averages in newidle_balance cost
>   sched/fair: Skip update_blocked_averages if we are defering load
>     balance
> 
>  kernel/sched/fair.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

