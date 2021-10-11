Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8AD428588
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhJKDVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:21:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28911 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhJKDU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:20:58 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HSP6H1bpKzbn0h;
        Mon, 11 Oct 2021 11:14:31 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 11:18:57 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 11:18:56 +0800
Subject: Re: [PATCH] static_call: fix null-ptr-deref in static_call_del_module
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <jpoimboe@redhat.com>, <jbaron@akamai.com>, <rostedt@goodmis.org>,
        <ardb@kernel.org>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211009074428.1668662-1-wanghai38@huawei.com>
 <20211009100037.GU174703@worktop.programming.kicks-ass.net>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <eb197332-5a33-49a9-85f3-e95a745c6de9@huawei.com>
Date:   Mon, 11 Oct 2021 11:18:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211009100037.GU174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/9 18:00, Peter Zijlstra 写道:
> On Sat, Oct 09, 2021 at 03:44:28PM +0800, Wang Hai wrote:
>> I got a NULL pointer dereference report when doing fault injection test:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000009
>> ...
>> RIP: 0010:static_call_del_module+0x7a/0x100
>> ...
>> Call Trace:
>>   static_call_module_notify+0x1e1/0x200
>>   notifier_call_chain_robust+0x6f/0xe0
>>   blocking_notifier_call_chain_robust+0x4e/0x70
>>   load_module+0x21f7/0x2b60
>>   __do_sys_finit_module+0xb0/0xf0
>>   ? __do_sys_finit_module+0xb0/0xf0
>>   __x64_sys_finit_module+0x1a/0x20
>>   do_syscall_64+0x34/0xb0
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> When loading a module, if it fails to allocate memory for static
>> calls, it will delete the non-existent mods (mods == 1) in the
>> static_call_module_notify()'s error path.
>>
>> static_call_module_notify
>> 	static_call_add_module
>> 		__static_call_init
>> 			site_mod = kzalloc() // fault injection
>> 	static_call_del_module // access non-existent mods
>>
>> This patch fixes the bug by skipping the operation when the key
>> has no mods.
>>
>> Fixes: a945c8345ec0 ("static_call: Allow early init")
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> ---
>>   kernel/static_call.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/static_call.c b/kernel/static_call.c
>> index 43ba0b1e0edb..c3f8ffc5a52f 100644
>> --- a/kernel/static_call.c
>> +++ b/kernel/static_call.c
>> @@ -400,7 +400,7 @@ static void static_call_del_module(struct module *mod)
>>   
>>   	for (site = start; site < stop; site++) {
>>   		key = static_call_key(site);
>> -		if (key == prev_key)
>> +		if (key == prev_key || !static_call_key_has_mods(key))
>>   			continue;
>>   
>>   		prev_key = key;
> Should you not update prev_key in that case? Also have you looked at
> jump_label_del_module() which is very similar in construction?
> .
Thanks for your guidance, as with jump_label_del_module(),
the prev_key needs to be updated, can it be fixed like this?

--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -404,9 +404,9 @@ static void static_call_del_module(struct module *mod)
                         continue;

                 prev_key = key;
+               site_mod = static_call_key_next(key);

-               for (prev = &key->mods, site_mod = key->mods;
-                    site_mod && site_mod->mod != mod;
+               for (prev = &key->mods; site_mod && site_mod->mod != mod;
                      prev = &site_mod->next, site_mod = site_mod->next)
                         ;

-- 
Wang Hai

