Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E071E31E8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhBRK2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:28:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12188 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhBRJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:15:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dh89d5pSZzlLj5;
        Thu, 18 Feb 2021 17:12:21 +0800 (CST)
Received: from [10.174.178.140] (10.174.178.140) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Feb 2021 17:14:09 +0800
Subject: Re: [PATCH v3 1/2] perf tools: add 'perf irq' to measure the hardware
 interrupts
To:     Hagen Paul Pfeifer <hagen@jauu.net>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <john.wanghui@huawei.com>,
        <abudankov@huawei.com>, <yz.yuzhou@huawei.com>
References: <20210116011920.34487-1-cuibixuan@huawei.com>
 <20210116011920.34487-2-cuibixuan@huawei.com> <YBQUZ/LmiZkYSVCg@laniakea>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <078a209a-087c-3fc3-d568-1a65e450b154@huawei.com>
Date:   Thu, 18 Feb 2021 17:14:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YBQUZ/LmiZkYSVCg@laniakea>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.140]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/29 21:57, Hagen Paul Pfeifer wrote:
> Idea: why now pre-calc the max IRQ name length and adjust the columns
> dynamically? Time consume us, entry time and exit time can be threatet static
> in (max) length lenght. This overlong, static ASCII lines are no pleasure! ;-)
> 
> Furthermore, why not a --format feature?
> *perf irq report --format csv* option? Your human readable ASCII version is
> okay, but often you had thousands of IRQs where just one IRQ is an outliner.
> Pipe the output to numpy and matplotlib is often the required post-precessing
> step, but parsing the ASCII output is tortuous.
> 
Good idea. In fact, I plan to output part of (maximum) data.
I'll consider adding '--format csv*' option.

Thanks
Bixuan Cui
> hgn
