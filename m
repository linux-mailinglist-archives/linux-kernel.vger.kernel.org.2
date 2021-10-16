Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F34300F0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbhJPHth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:49:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24322 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239843AbhJPHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:49:36 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HWZqh16Y9zbg2y;
        Sat, 16 Oct 2021 15:42:56 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 16 Oct 2021 15:47:26 +0800
Subject: Re: [PATCH -next,v2 1/2] audit: fix possible null-pointer dereference
 in audit_filter_rules
To:     Paul Moore <paul@paul-moore.com>
CC:     Eric Paris <eparis@redhat.com>, <linux-audit@redhat.com>,
        <linux-kernel@vger.kernel.org>, <xiujianfeng@huawei.com>,
        <wangweiyang2@huawei.com>
References: <20211013091208.36209-1-cuigaosheng1@huawei.com>
 <20211013091208.36209-2-cuigaosheng1@huawei.com>
 <CAHC9VhQR4OZWRrQODEjBxhjpH3yPRqPFE4X6RkVFEmv1e9Z8iw@mail.gmail.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <f751d3c6-617c-4ae4-83d1-3b460e312f02@huawei.com>
Date:   Sat, 16 Oct 2021 15:47:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQR4OZWRrQODEjBxhjpH3yPRqPFE4X6RkVFEmv1e9Z8iw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review, and i have droped the redundant commit message 
and add a Fixes tag to the patch.

https://patchwork.kernel.org/project/linux-audit/patch/20211016072351.237745-2-cuigaosheng1@huawei.com/ 
<https://patchwork.kernel.org/project/linux-audit/patch/20211016072351.237745-2-cuigaosheng1@huawei.com/>

Gaosheng.

在 2021/10/14 5:12, Paul Moore 写道:
> On Wed, Oct 13, 2021 at 5:10 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>> Fix this possible null-pointer dereference in audit_filter_rules.
> Thanks for fixing this, just a couple of small comments:
>
> I think you can drop the description text below here, the code snippet
> is just a duplicate of the code and the error message is pretty
> obvious.
>
>> If ctx is null, a null-pointer dereference will occur:
>>      case AUDIT_SADDR_FAM:
>>          if (ctx->sockaddr)
>>                  ...
>>          break;
>>
>> audit_filter_rules() error: we previously assumed 'ctx' could be null
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> I would also add a Fixes tag, for example:
>
> Fixes: bf361231c295 ("audit: add saddr_fam filter field")
>
>> ---
>>   kernel/auditsc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 4ba3b8573ff4..42d4a4320526 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -647,7 +647,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>>                          result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
>>                          break;
>>                  case AUDIT_SADDR_FAM:
>> -                       if (ctx->sockaddr)
>> +                       if (ctx && ctx->sockaddr)
>>                                  result = audit_comparator(ctx->sockaddr->ss_family,
>>                                                            f->op, f->val);
>>                          break;
>> --
>> 2.30.0
