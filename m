Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4783A8E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhFPBN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:13:28 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7281 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFPBN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:13:28 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G4RpN1w4Kz1BN1y;
        Wed, 16 Jun 2021 09:06:20 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 09:11:05 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 09:11:05 +0800
Subject: Re: [PATCH -next] tracing: Remove set but not used variable 'ret'
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210527091032.3878436-1-libaokun1@huawei.com>
 <4ab45eeb-ad26-03e8-f2c5-2dc4582a2946@huawei.com>
 <20210615113925.27ad04ea@oasis.local.home>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <ff4437bb-5285-5bf5-8c87-757dd07e51ef@huawei.com>
Date:   Wed, 16 Jun 2021 09:11:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210615113925.27ad04ea@oasis.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reminder.

Best Regards.


在 2021/6/15 23:39, Steven Rostedt 写道:
> On Tue, 15 Jun 2021 09:59:10 +0800
> "libaokun (A)" <libaokun1@huawei.com> wrote:
>
>> ping
>>
>> 在 2021/5/27 17:10, Baokun Li 写道:
>>> Fixes gcc '-Wunused-but-set-variable' warning:
>>>
>>> kernel/trace/trace_events_hist.c: In function 'unregister_field_var_hists':
>>> kernel/trace/trace_events_hist.c:5228:6: warning:
>>>    variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>>
>>> It never used since introduction.
> Which was a bug.
>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> This was fixed differently:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6c610dba6e2beb1a16ac309672181d0090fb8d30
>
> -- Steve
> .
