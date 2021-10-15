Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD342E61F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJOB3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:29:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24315 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhJOB3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:29:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVpRv3K1bzbd3p;
        Fri, 15 Oct 2021 09:23:07 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 09:27:36 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 09:27:35 +0800
Subject: Re: [PATCH] tracing: save cmdline only when task does not exist in
 savecmd for optimization
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20211011115018.88948-1-yangjihong1@huawei.com>
 <20211014103201.685d3647@gandalf.local.home>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <3d07f3c9-3636-9563-fab5-603bfad4a3af@huawei.com>
Date:   Fri, 15 Oct 2021 09:27:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211014103201.685d3647@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2021/10/14 22:32, Steven Rostedt wrote:
> On Mon, 11 Oct 2021 19:50:18 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 7896d30d90f7..a795610a3b37 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2427,8 +2427,11 @@ static int trace_save_cmdline(struct task_struct *tsk)
>>   		savedcmd->cmdline_idx = idx;
>>   	}
>>   
>> -	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
>> -	set_cmdline(idx, tsk->comm);
>> +	/* save cmdline only when task does not exist in savecmd */
>> +	if (savedcmd->map_cmdline_to_pid[idx] != tsk->pid) {
>> +		savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
>> +		set_cmdline(idx, tsk->comm);
>> +	}
>>   
> 
> I now remember why I never did it this way. This breaks saving the command
> line when we do an exec.
> 
> That is, just because mapped_pid == tsk->pid does not mean that the comm is
> the same.
> 
If do an exec, the original process is replaced with a new binary. 
Therefore, the command changes but the tsk->pid does not change. 
Therefore, we need to savecmd here again?

Okay, I see. Thank you for the detailed explanation. :)

Thanks,
Jihong
> -- Steve
> .
> 
