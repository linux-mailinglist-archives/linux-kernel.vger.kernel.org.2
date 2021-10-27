Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA4543C2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhJ0GRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:17:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25315 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhJ0GRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:17:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HfJFy2zS6zbhMT;
        Wed, 27 Oct 2021 14:10:30 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 14:14:57 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 14:14:57 +0800
Subject: Re: DAMON: problems when running DAMON on ARM64 with
 'transparent_hugepage' enabled
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <sj@kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5524985d-9494-db74-4870-2b9879b8f7fd@huawei.com>
Message-ID: <b2219330-66d2-de9d-534b-076d84d7d791@huawei.com>
Date:   Wed, 27 Oct 2021 14:14:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5524985d-9494-db74-4870-2b9879b8f7fd@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to Cc the maillist. Cc it in this mail.

On 2021/10/27 10:19, Xiongfeng Wang wrote:
> Hi SeongJae,
> 
> Sorry to disturb you. It's just that I came across some problems when running
> DAMON, but still didn't find the solution after several days.
> 
> A short description is that the result of DAMON is not as expected when running
> on ARM64 with 'transparent_hugepage' enabled. But the result is correct when
> 'transparent_hugepage' is disabled.
> 
> The following are the steps I came across the problems.
> 1. Firstly, I use 'damo record' to sample the 'stairs' demo.
>   damo record "./masim ./configs/stairs.cfg"
> 2. Then I use 'damo report' to show the results.
>   damo report heats --address_range xxx  xxx  --time_range xxx xxx    --heatmap
> stdout    --stdout_heatmap_color emotion
> The result doesn't show like a stair. I wrote a userspace demo to access a
> certain address range in loop and use DAMON to sample the demo. I added
> trace_print in 'damon_va_check_access()' and found out the pages in the address
> range are not always detected as accessed, which is not expected. When I disable
> transparent_hugepage by chance, the pages are marked as accessed. Then I test
> the 'stairs' demo again, the result is correct. It seems that, only when
> transparent_hugepage' is disabled, the access check works. I don't know where
> the bug is, the software or the hardware ? Appreciate it if you have time to
> reply. Thanks !
> 
> Thanks,
> Xiongfeng
> 
