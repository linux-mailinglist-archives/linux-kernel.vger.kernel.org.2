Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7E3AFF93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFVItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:49:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5065 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFVIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:49:38 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G8Kdb0HxqzXjjy;
        Tue, 22 Jun 2021 16:42:11 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 16:47:19 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 22 Jun
 2021 16:47:18 +0800
Subject: Re: [PATCH 1/3] scripts: add spelling_sanitizer.sh script
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>
References: <20210611071241.16728-1-thunder.leizhen@huawei.com>
 <20210611071241.16728-2-thunder.leizhen@huawei.com>
 <f8e5efe388de9cfc78e1aa163d66096b09eb8a9e.camel@perches.com>
 <6cff5719-9548-a49e-6c47-8bc92c5bd6b8@huawei.com>
 <e2b35246-00fa-37a9-0c11-be178c974f65@huawei.com>
Message-ID: <7431be94-ccda-70a9-429d-29c988433eb7@huawei.com>
Date:   Tue, 22 Jun 2021 16:47:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e2b35246-00fa-37a9-0c11-be178c974f65@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/16 19:58, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/6/15 15:01, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/6/11 23:36, Joe Perches wrote:
>>> On Fri, 2021-06-11 at 15:12 +0800, Zhen Lei wrote:
>>>> The file scripts/spelling.txt recorded a large number of
>>>> "mistake||correction" pairs. These entries are currently maintained in
>>>> order, but the results are not strict. In addition, when someone wants to
>>>> add some new pairs, he either sort them manually or write a script, which
>>>> is clearly a waste of labor.
>>>
>>> Try using lintian's make sort
>>>
>>> https://salsa.debian.org/lintian/lintian
> 
> I installed lintian and found no option to support sort. Can anyone give me more
> specific instructions on how to use it?
> 
> Although I don't understand the perl language, after reading commit 66b47b4a9dad
> ("checkpatch: look for common misspellings"), it seems to match from top to bottom.
> So, as Andy Shevchenko says, they should be sorted by frequency of the word usage.
> 
> I really don't know the details of the implementation of
> scripts/checkpatch.pl --types=typo_spelling. Are only misspelled words involved in
> spelling.txt matching? Otherwise, if correctly spelled words are also traversed,
> sorting by frequency makes no sense. Because the correct number of words is far more
> than the wrong number of words. If that's the case, then my modified script could
> come in handy.
> 
> And if only misspelled words involved in spelling.txt matching, do we really need
> spelling.txt? Just output the misspelled words is enough. I don't think anyone needs
> to follow the tips to complete the fix.

Hi all:
  I did a little test:
  git rm -r drivers/usb  --> then revert to generate patch 'usb, 553988 insertions(+)
  git rm -r mm/          --> then revert to generate patch 'mm', 157606 insertions(+)

  Two Stages(Test twice each, unit: seconds)：
  Before sorted by this patch:
  mm    264   264
  usb  1049  1047

  After sorted by this patch:
  mm    264   265
  usb  1047  1045

  According to the test results, the performance before and after sorting is basically the same.

  The test method is as follows:
  start=$(date +%s)
  scripts/checkpatch.pl --types=TYPO_SPELLING 0001-Revert-usb-remove.patch > /dev/null
  end=$(date +%s)
  seconds=$((end - start))
  echo $seconds


> 
>>>
>>>
>>
>> Okay, I'll try it
>>
>>>
>>> .
>>>

