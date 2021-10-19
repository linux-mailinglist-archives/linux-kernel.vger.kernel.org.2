Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165E7432BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 04:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJSCmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 22:42:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25231 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhJSCmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 22:42:04 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HYHxB4bXqz8tj0;
        Tue, 19 Oct 2021 10:38:38 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 10:39:48 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 10:39:48 +0800
Subject: Re: [QUESTION] Performance deterioration caused by commit
 85f726a35e504418
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <tom.zanussi@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
 <20211018093731.2dd5917f@gandalf.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <19e4222c-c9ac-5c1a-0c3a-b8bfd3524ab7@huawei.com>
Date:   Tue, 19 Oct 2021 10:39:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211018093731.2dd5917f@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 2021/10/18 21:37, Steven Rostedt wrote:
> On Mon, 18 Oct 2021 11:23:14 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> Hi Tom and Steven,
>>
>> commit 85f726a35e504418 use strncpy instead of memcpy when copying comm,
>> on ARM64 machine, this commit causes performance degradation.
>>
>> I test the number of instructions executed by invoking the
>> trace_sched_switch function once on an arm64 machine:
>> 1. Use memcpy, the number of instructions executed is 850.
>> 2. Use strncpy, the number of instructions executed 1100.
>> That is, use strncpy is almost 250 more instructions than memcpy.
>>
>> Has the impact on performance been considered in this commit? :)
>> What is the impact of revert the patch?
>>
> 
> It's a security issue. And like everything security, there's always going
> to be a performance impact. Look at the performance impact due to spectre
> and meltdown!
> 
> That said, although memcpy() may not be used, we don't need strncpy.
> strncpy() will pad the rest of the string with nul bytes. But since the
> memory the string is being recorded into is already initialized (or can be
> if it isn't), we could use the faster strlcpy().
> 
> Have you tried testing it by switching strncpy() with strlcpy()?
> 
I have tried testing it by switching strncpy() with strlcpy(), there is 
no performance improvement, probably because the strlen function is 
called in strlpy and the string is traversed each time.

Kind regards,
Jihong
> -- Steve
> .
> 
