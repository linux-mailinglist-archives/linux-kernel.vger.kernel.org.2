Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A67435DD02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344762AbhDMK7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:59:49 -0400
Received: from foss.arm.com ([217.140.110.172]:40372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344499AbhDMK7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:59:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2971611B3;
        Tue, 13 Apr 2021 03:58:58 -0700 (PDT)
Received: from [10.57.29.116] (unknown [10.57.29.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A29E03F73B;
        Tue, 13 Apr 2021 03:58:54 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in
 eas
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
 <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com>
 <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
 <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com>
 <CAB8ipk_J-W35+iZqsmAm+VO2=OUXRR3EsW6BuhYmvmBiPcHxMA@mail.gmail.com>
 <d80b7b3e-7eb3-4d0a-99fd-167e14ab86bc@arm.com>
 <CAB8ipk8RhhBvRq3jUnP2ENfSG_L=LonnVfweymYkQJrZQyA9jQ@mail.gmail.com>
 <b4631807-9b10-ce11-c206-ba347980f771@arm.com>
 <CAB8ipk_vgtg5d1obH36BYfNLZosbwr2k_U3xnAD4=H5uZt_M_g@mail.gmail.com>
Message-ID: <d017749a-697e-9cda-4940-df4cdbdd3a55@arm.com>
Date:   Tue, 13 Apr 2021 11:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAB8ipk_vgtg5d1obH36BYfNLZosbwr2k_U3xnAD4=H5uZt_M_g@mail.gmail.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> >
> > In fair.c:select_task_rq_fair(), if feec() returns a error (< 0), then
> > prev_cpu is selected. I think it's better to still let feec() signal
> > that something happened and let select_task_rq_fair() select prev_cpu by
> > itself.
> In fair.c:select_task_rq_fair(), when feec() returns a error (< 0),
> the new_cpu = find_idlest_cpu() or select_idle_sibling().
> In your patch, you should return prev_cpu instead of -1 if you want to
> select the prev_cpu.
Having a negative delta doesn't imply that prev_cpu is still available.
E.g.: If prev_cpu cannot receive the task (and is skipped), and a  
negative delta appears when evaluating the other CPUs. In such case  
feec() cannot select prev_cpu. dst_cpu must be selected by another function.

> > Are you planning to submit a V2 with the bail out mechanism ?
> Maybe it would be better if you submitted the V2 ? I just check the
> patch and raised some questions.

I m ok to send a V2. I will submit it once we agreed.

Regards

