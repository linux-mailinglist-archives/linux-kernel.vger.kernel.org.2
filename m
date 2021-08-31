Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB85E3FC67D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhHaLSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:18:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18994 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhHaLSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:18:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GzPh30mGbzbkk6;
        Tue, 31 Aug 2021 19:13:39 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 19:17:33 +0800
Received: from [10.67.101.251] (10.67.101.251) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 19:17:33 +0800
To:     <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <vincent.guittot@linaro.org>,
        <peterz@infradead.org>, <pjt@google.com>
CC:     <daniel.m.jordan@oracle.com>, <zhangqiao22@huawei.com>
References: <20210716022756.193817-1-zhangqiao22@huawei.com>
Subject: Re: [PATCH -next v3] sched: Dec cfs_bandwidth_used in
 destroy_cfs_bandwidth()
In-Reply-To: <20210716022756.193817-1-zhangqiao22@huawei.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
Message-ID: <588b807a-38f8-e405-7de3-53d559702259@huawei.com>
Date:   Tue, 31 Aug 2021 19:17:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.251]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a ping...

thanks,
Qiao Zhang.
