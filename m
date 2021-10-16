Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8043010E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhJPIFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 04:05:44 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25194 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbhJPIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 04:05:02 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HWbDc2y01z8tf3;
        Sat, 16 Oct 2021 16:01:04 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 16 Oct 2021 16:02:14 +0800
Subject: Re: [PATCH -next,v2 2/2] audit: return early if the rule has a lower
 priority
To:     Paul Moore <paul@paul-moore.com>
CC:     Eric Paris <eparis@redhat.com>, <linux-audit@redhat.com>,
        <linux-kernel@vger.kernel.org>, <xiujianfeng@huawei.com>,
        <wangweiyang2@huawei.com>
References: <20211013091208.36209-1-cuigaosheng1@huawei.com>
 <20211013091208.36209-3-cuigaosheng1@huawei.com>
 <CAHC9VhQTD86Y9ryGNkVKsChJ573GAka_gBuTgXR8q5OpV-zMbw@mail.gmail.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <0e4cf616-c362-9748-7803-07aedde5f62e@huawei.com>
Date:   Sat, 16 Oct 2021 16:02:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQTD86Y9ryGNkVKsChJ573GAka_gBuTgXR8q5OpV-zMbw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have done some testing with this patch, we have some testsuites to 
verify the

function of audit, and i will test it with the audit-testsuite.

Thanks.

Gaosheng

在 2021/10/14 5:15, Paul Moore 写道:
> On Wed, Oct 13, 2021 at 5:10 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>> It is not necessary for audit_filter_rules() functions to check
>> audit fileds of the rule with a lower priority, and if we did,
>> there might be some unintended effects, such as the ctx->ppid
>> may be changed unexpectedly, so return early if the rule has
>> a lower priority.
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   kernel/auditsc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
> Thanks for this patch, it looks reasonable to me but have you done any
> testing with this patch?  If so, what have you done?
>
> As a FYI, the audit-testsuite project lives here:
> * https://github.com/linux-audit/audit-testsuite
>
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 42d4a4320526..b517947bfa48 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -470,6 +470,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>>          u32 sid;
>>          unsigned int sessionid;
>>
>> +       if (ctx && rule->prio <= ctx->prio)
>> +               return 0;
>> +
>>          cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
>>
>>          for (i = 0; i < rule->field_count; i++) {
>> @@ -737,8 +740,6 @@ static int audit_filter_rules(struct task_struct *tsk,
>>          }
>>
>>          if (ctx) {
>> -               if (rule->prio <= ctx->prio)
>> -                       return 0;
>>                  if (rule->filterkey) {
>>                          kfree(ctx->filterkey);
>>                          ctx->filterkey = kstrdup(rule->filterkey, GFP_ATOMIC);
>> --
>> 2.30.0
