Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB17368824
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhDVUnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:43:12 -0400
Received: from foss.arm.com ([217.140.110.172]:55746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236877AbhDVUnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:43:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B2CB13A1;
        Thu, 22 Apr 2021 13:42:36 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDBCE3F694;
        Thu, 22 Apr 2021 13:42:33 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [sched/fair]  38ac256d1c:  stress-ng.vm-segv.ops_per_sec -13.8% regression
In-Reply-To: <87wnsutzi9.mognet@arm.com>
References: <20210414052151.GB21236@xsang-OptiPlex-9020> <87im4on5u5.mognet@arm.com> <20210421032022.GA13430@xsang-OptiPlex-9020> <87bla8ue3e.mognet@arm.com> <20210422074742.GE31382@xsang-OptiPlex-9020> <87wnsutzi9.mognet@arm.com>
Date:   Thu, 22 Apr 2021 21:42:31 +0100
Message-ID: <87mttqt5jc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 10:55, Valentin Schneider wrote:
> I'll go find myself some other x86 box and dig into it;
> I'd rather not leave this hanging for too long.

So I found myself a dual-socket Xeon Gold 5120 @ 2.20GHz (64 CPUs) and
*there* I get a somewhat consistent ~-6% regression. As I'm suspecting
cacheline shenanigans, I also ran that with Peter's recent
kthread_is_per_cpu() change, and that brings it down to ~-3%

I'll leave it at here for today, but at least that's something I can work
with.
