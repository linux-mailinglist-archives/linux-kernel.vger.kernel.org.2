Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21FD314F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBIMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:42:47 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:45219 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhBIMkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:40:52 -0500
Subject: Re: [PATCH v3] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
To:     Barry Song <song.bao.hua@hisilicon.com>,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        mgorman@suse.de, mingo@kernel.org, peterz@infradead.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@openeuler.org, xuwei5@huawei.com, liguozhu@hisilicon.com,
        tiantao6@hisilicon.com, wanghuiqiang@huawei.com,
        prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
        guodong.xu@linaro.org
References: <20210209082125.22176-1-song.bao.hua@hisilicon.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <d091f321-540c-acc7-4340-72b80cbe7296@linux.ee>
Date:   Tue, 9 Feb 2021 14:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209082125.22176-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did a rudimentary benchmark on the same 8-node Sun Fire X4600-M2, on top of todays  5.11.0-rc7-00002-ge0756cfc7d7c.

The test: building clean kernel with make -j64 after make clean and drop_caches.

While running clean kernel / 3 tries):

real    2m38.574s
user    46m18.387s
sys     6m8.724s

real    2m37.647s
user    46m34.171s
sys     6m11.993s

real    2m37.832s
user    46m34.910s
sys     6m12.013s


While running patched kernel:

real    2m40.072s
user    46m22.610s
sys     6m6.658s


for real time, seems to be 1.5s-2s slower out of 160s (noise?) User and system time are slightly less, on the other hand, so seems good to me.

-- 
Meelis Roos <mroos@linux.ee>
