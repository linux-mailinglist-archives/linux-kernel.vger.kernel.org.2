Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7241560B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhIWDbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:31:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9909 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbhIWDbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:31:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFLCS56bjz8ylZ;
        Thu, 23 Sep 2021 11:25:40 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 11:30:08 +0800
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 11:30:07 +0800
Subject: Re: [PATCH] sched: Make cookie functions static
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210922085735.52812-1-zhangshaokun@hisilicon.com>
 <20210922125034.GS4323@worktop.programming.kicks-ass.net>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <641d5dfb-1c72-9fc3-0844-d4eab8115173@hisilicon.com>
Date:   Thu, 23 Sep 2021 11:30:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210922125034.GS4323@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2021/9/22 20:50, Peter Zijlstra wrote:
> On Wed, Sep 22, 2021 at 04:57:35PM +0800, Shaokun Zhang wrote:
>> Make cookie functions static as these are no longer invoked directly
>> by other code.
> 
> Yeah, this was supposed to get used from the cgroup code, but that never
> happened. I suppose we can do this for now, easy enough to revert

Got it,

Thanks your reply.

> if/when etc..
> .
> 
