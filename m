Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70C33AA872
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhFQBNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:13:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4952 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFQBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:13:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G53nn2nDPz70bb;
        Thu, 17 Jun 2021 09:07:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:11:07 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 09:11:06 +0800
Subject: Re: [PATCH v2 1/3] scripts: add spelling_sanitizer.sh script
To:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210616122507.896-1-thunder.leizhen@huawei.com>
 <20210616122507.896-2-thunder.leizhen@huawei.com>
 <87bl85yi68.fsf@meer.lwn.net>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4c8ca535-398c-0d19-5242-27ed1d3905ec@huawei.com>
Date:   Thu, 17 Jun 2021 09:11:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87bl85yi68.fsf@meer.lwn.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/16 22:53, Jonathan Corbet wrote:
> Zhen Lei <thunder.leizhen@huawei.com> writes:
> 
>> The file scripts/spelling.txt recorded a large number of spelling
>> "mistake||correction" pairs. These entries are currently maintained in
>> order, but the results are not strict. In addition, when someone wants to
>> add some new pairs, he either sort them manually or write a script, which
>> is clearly a waste of labor. So add this script. For all spelling
>> "mistake||correction" pairs, sort based on "correction", then on "mistake",
>> and remove duplicates. Sorting based on "mistake" first is not chosen
>> because it is uncontrollable.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  scripts/spelling_sanitizer.sh | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100755 scripts/spelling_sanitizer.sh
>>
>> diff --git a/scripts/spelling_sanitizer.sh b/scripts/spelling_sanitizer.sh
>> new file mode 100755
>> index 000000000000..603bb7e0e66b
>> --- /dev/null
>> +++ b/scripts/spelling_sanitizer.sh
>> @@ -0,0 +1,27 @@
>> +#!/bin/sh -efu
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# To get the traditional sort order that uses native byte values
> 
> So I am of the naive opinion that everything we drop into scripts/
> should start with a comment saying why it exists and how to use it.
> Otherwise how are people going to benefit from it?

Rigth, I will add the description, thanks.

> 
> Thanks,
> 
> jon
> 
> .
> 

