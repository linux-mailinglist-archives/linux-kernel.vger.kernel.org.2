Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0FA43F1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhJ1Vii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:38:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:7162 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhJ1Vig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:38:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="217704023"
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="scan'208";a="217704023"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 14:36:09 -0700
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="scan'208";a="466289015"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.137.85])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 14:36:08 -0700
Message-ID: <8f6b4ab17a319117cbed8751aa4fa9f2d6e0ca5b.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Date:   Thu, 28 Oct 2021 14:36:08 -0700
In-Reply-To: <20211028121530.GA19512@vingu-book>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
         <7128695d64e9161637b67315b5beb51c4accdc82.camel@linux.intel.com>
         <CAKfTPtAv7vPGYAwUSmGL5wtbY=if8G+3geWMKpHu3vLGqthPfg@mail.gmail.com>
         <720fd26424927dd27fea4e5719dafe8a0afaa8c4.camel@linux.intel.com>
         <20211028121530.GA19512@vingu-book>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-28 at 14:15 +0200, Vincent Guittot wrote:
> 
> > It seems to make sense to skip the call
> > to nohz_newidle_balance() for this case? 
> 
> nohz_newidle_balance() also tests this condition :
> (this_rq->avg_idle < sysctl_sched_migration_cost)
> and doesn't set NOHZ_NEWILB_KICKi in such case
> 
> But this patch now used the condition :
> this_rq->avg_idle < sd->max_newidle_lb_cost
> and sd->max_newidle_lb_cost can be higher than
> sysctl_sched_migration_cost
> 
> which means that we can set NOHZ_NEWILB_KICK:
> -although we decided to skip newidle loop
> -or when we abort because this_rq->avg_idle < curr_cost + sd-
> >max_newidle_lb_cost 
> 
> This is even more true when sysctl_sched_migration_cost is lowered
> which is your case IIRC
> 
> The patch below ensures that we don't set NOHZ_NEWILB_KICK in such
> cases:
> 

Thanks. Will ask our benchmark team to give it a spin.

Tim

