Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90214331D26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCICuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:50:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13581 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCICtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:49:55 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvflV5rbMz17Hf5;
        Tue,  9 Mar 2021 10:48:06 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 9 Mar 2021
 10:49:49 +0800
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: add compress_inode to cache
 compressed blockst
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210202080056.51658-1-yuchao0@huawei.com>
 <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
 <YDsleDjeIcpuBXKA@google.com> <YEFBAuP26t0RzVHZ@google.com>
 <01a0ff76-6fa7-3196-8760-e7f6f163ef64@huawei.com>
 <YEa66ekikyuPWSyd@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a40929d4-a8de-98ea-8dd8-6c807d8a6adc@huawei.com>
Date:   Tue, 9 Mar 2021 10:49:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YEa66ekikyuPWSyd@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/9 8:01, Jaegeuk Kim wrote:
> On 03/05, Chao Yu wrote:
>> On 2021/3/5 4:20, Jaegeuk Kim wrote:
>>> On 02/27, Jaegeuk Kim wrote:
>>>> On 02/04, Chao Yu wrote:
>>>>> Jaegeuk,
>>>>>
>>>>> On 2021/2/2 16:00, Chao Yu wrote:
>>>>>> -	for (i = 0; i < dic->nr_cpages; i++) {
>>>>>> +	for (i = 0; i < cc->nr_cpages; i++) {
>>>>>>     		struct page *page = dic->cpages[i];
>>>>>
>>>>> por_fsstress still hang in this line?
>>>>
>>>> I'm stuck on testing the patches, since the latest kernel is panicking somehow.
>>>> Let me update later, once I can test a bit. :(
>>>
>>> It seems this works without error.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=4e6e1364dccba80ed44925870b97fbcf989b96c9
>>
>> Ah, good news.
>>
>> Thanks for helping to test the patch. :)
> 
> Hmm, I hit this again. Let me check w/o compress_cache back. :(

Oops :(
