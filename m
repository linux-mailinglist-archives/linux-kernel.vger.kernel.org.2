Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A550F36F72A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhD3Ieb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:34:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhD3Iea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:34:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43327ED1;
        Fri, 30 Apr 2021 01:33:42 -0700 (PDT)
Received: from [10.57.32.47] (unknown [10.57.32.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 865383F70D;
        Fri, 30 Apr 2021 01:33:38 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        qperret@qperret.net
References: <20210420125604.15796-1-Pierre.Gondois@arm.com>
 <YILvUkgZXu4swVvj@google.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
Message-ID: <c0c99cfd-cf3d-32a1-2088-21960abae8ad@arm.com>
Date:   Fri, 30 Apr 2021 09:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YILvUkgZXu4swVvj@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

I sent a v2 yesterday. This is just to answer your question:
> Not that I disagree with the approach, just being curious: do we know
> how much this is helping in practice to reduce the window by moving the
> compute_energy() calls down here?
I don't have any numbers. However, moving the computation of base_energy_pd

after looping over the CPUs of a performance domain allows to skip this 
computation

if no CPU is available in the performance domain. This should justify 
moving the

compute_energy() call.


Regards,

Pierre

