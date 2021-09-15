Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD240BE06
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhIODMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:12:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19976 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhIODMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:12:03 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H8Q992wfFzblrD;
        Wed, 15 Sep 2021 11:06:37 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 11:10:43 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 11:10:43 +0800
Subject: Re: [PATCH v2] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
To:     Tejun Heo <tj@kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>
References: <20210911075054.6358-1-zhangqiao22@huawei.com>
 <YT+R3EnFgs78Vyvh@slm.duckdns.org>
 <b30205b0-bf54-7255-fc1c-9dfa5dbb4940@huawei.com>
 <YUDMhMgM4ZECVBo8@slm.duckdns.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
Message-ID: <65e75c42-e846-c571-582f-b52938b26973@huawei.com>
Date:   Wed, 15 Sep 2021 11:10:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YUDMhMgM4ZECVBo8@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/9/15 0:23, Tejun Heo Ð´µÀ:
> On Tue, Sep 14, 2021 at 04:20:02PM +0800, Zhang Qiao wrote:
>> Perhaps we can fix this bug at sched_post_fork(), which is executed between cgroup_can_fork()
>> and cgroup_post_fork(). Relocate the fectching of task_group and access it at sched_post_fork().
> 
> Can't we just add a can_fork callback in cpu_cgrp_subsys?

Because __set_task_cpu and task_fork callback need access the sched_task_group field, so the task_fork
callback must be called after update the child's sched_task_group, if perform these
operations in the newly added can_fork callback, it may lead to some dependencies(the can_fork will
not be executed when !CONFIG_CGROUP_SCHED).

__set_task_cpu and task_fork callback mainly do some field initialization and vruntime calculation,
these things just need to be done before waking up the new task. So i think it is no problem to defer
do this things at sched_post_fork().

thanks.

> 
