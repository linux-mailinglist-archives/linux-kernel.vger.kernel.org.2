Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C93055FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhA0Ilj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:41:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11514 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhA0Ijl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:39:41 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DQcRr3BQLzjF18;
        Wed, 27 Jan 2021 16:37:44 +0800 (CST)
Received: from [10.174.178.140] (10.174.178.140) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 16:38:47 +0800
Subject: Re: [PATCH v3 1/2] perf tools: add 'perf irq' to measure the hardware
 interrupts
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <john.wanghui@huawei.com>, Alexei Budankov <abudankov@huawei.com>,
        <yz.yuzhou@huawei.com>
References: <20210116011920.34487-1-cuibixuan@huawei.com>
 <20210116011920.34487-2-cuibixuan@huawei.com>
 <CAM9d7cgPpeCyjd2Z3Ld6yya7BCE3KxVg0P4xeF2gDZ0Y5mw2HQ@mail.gmail.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <58f6576a-4e17-57df-3b61-e0f594102907@huawei.com>
Date:   Wed, 27 Jan 2021 16:38:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgPpeCyjd2Z3Ld6yya7BCE3KxVg0P4xeF2gDZ0Y5mw2HQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.140]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/27 15:37, Namhyung Kim wrote:
> Note that strncpy doesn't guarantee the NUL-termination.
> You'd better do it by yourself just in case.
Thanks，
I'll fix these bugs.


> 
> Thanks,
> Namhyung
