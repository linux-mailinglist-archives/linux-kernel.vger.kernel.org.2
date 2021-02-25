Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081C432484A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 02:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhBYBF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 20:05:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13373 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhBYBFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 20:05:15 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DmDzc6j8Dz7q0v;
        Thu, 25 Feb 2021 09:02:52 +0800 (CST)
Received: from [10.174.178.140] (10.174.178.140) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 09:04:20 +0800
Subject: Re: [PATCH v4 0/2] perf tools: add 'perf irq' to measure the hardware
 interrupts
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>,
        <hagen@jauu.net>, <john.wanghui@huawei.com>,
        <abudankov@huawei.com>, <yz.yuzhou@huawei.com>
References: <20210218104312.50171-1-cuibixuan@huawei.com>
 <YDZKXKBJx0/yygDB@krava>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <55da2013-a65a-0163-afcb-5961ea52b718@huawei.com>
Date:   Thu, 25 Feb 2021 09:04:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YDZKXKBJx0/yygDB@krava>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.140]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/24 20:45, Jiri Olsa wrote:
> hi,
> I can't apply this on later Arnaldo's perf/core,
> what commit/branch is this based one?
Thanks，I check it.

> 
> thanks,
> jirka
