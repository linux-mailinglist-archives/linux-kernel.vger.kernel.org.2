Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A6E34E77B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhC3M15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:27:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14964 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhC3M1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:27:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8pZ53h4YzyN9H;
        Tue, 30 Mar 2021 20:25:33 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 20:27:33 +0800
Subject: Re: [PATCH -next] sched/fair: Move update_nohz_stats() under
 CONFIG_NO_HZ_COMMON
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20210330120657.54173-1-wangkefeng.wang@huawei.com>
 <CAKfTPtB54L4Eq+Fh2bfJfc24T603O5QRwZNH3_AVmFumMx6Uxw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <00ded869-9eed-1d6c-4748-73587cde4f3c@huawei.com>
Date:   Tue, 30 Mar 2021 20:27:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB54L4Eq+Fh2bfJfc24T603O5QRwZNH3_AVmFumMx6Uxw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/3/30 20:22, Vincent Guittot wrote:
> On Tue, 30 Mar 2021 at 14:06, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> update_nohz_stats() only call _nohz_idle_balance() under CONFIG_NO_HZ_COMMON.
> a similar patch has already been sent and reviewed :
> 20210329144029.29200-1-yuehaibing@huawei.com
ok please ignore it.

