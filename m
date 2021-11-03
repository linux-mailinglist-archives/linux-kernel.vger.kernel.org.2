Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536E7443DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKCHyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:54:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14707 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhKCHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:54:20 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hkf746QSQzZcgV
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 15:49:36 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 15:51:22 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 15:51:22 +0800
Subject: Re: [Question]: questions about 'Use sysidle detection to let the
 timekeeper sleep'
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <fweisbec@gmail.com>
CC:     Xie XiuQi <xiexiuqi@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <93236de5-f76e-3915-bbdf-9d060435937a@huawei.com>
Message-ID: <197f0d3a-dd7c-b90f-4a9d-8a21e289fd6b@huawei.com>
Date:   Wed, 3 Nov 2021 15:51:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <93236de5-f76e-3915-bbdf-9d060435937a@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to Cc the maillist again. Cc it in this mail.

On 2021/11/3 10:59, Xiongfeng Wang wrote:
> Hi Frederic,
> 
> Sorry to disturb you. It's just that I came across the same problem as you
> mentioned in the below link.
> https://lwn.net/Articles/577424/
> 
> This is the problem in my situation. All the CPUs on my machine are in the same
> power domain. When nohz_full is enabled, if one of the CPUs keep receiving tick
> interrupts, all the CPUs can not be put into powerdown state, even thought all
> other CPUs are idle.
> 
> I found your first version patchset in the below link.
> https://lore.kernel.org/lkml/1387320692-28460-1-git-send-email-fweisbec@gmail.com/
> But I couldn't found other verions. Even 'full-system-idle' is reverted in the
> mailline in the following commit.
>   commit fe5ac724d81a3c7803e60c2232718f212f3f38d4
>   rcu: Remove nohz_full full-system-idle state machine
> 
> I am not sure if we have any other alternative solutions, or do we have rebased
> the patchset to mainline kernel. The first version patchset I found is based on
> v3.13.
> 
> Thanks,
> Xiongfeng
> 
