Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59E9395F63
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhEaOKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:10:47 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3306 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhEaNob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:44:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FtxFF3VqMz1BG6n;
        Mon, 31 May 2021 21:38:09 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 21:42:49 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 21:42:49 +0800
Subject: Re: [PATCH 01/15] mm: add setup_initial_init_mm() helper
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
 <20210529105504.180544-2-wangkefeng.wang@huawei.com>
 <CAMuHMdVHCFiwVUq9jBobw0adwe9-x3AUB8cSxrf6gHnQTfUMTA@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <2d20b6c4-532a-282c-5184-4c0151eb30ce@huawei.com>
Date:   Mon, 31 May 2021 21:42:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVHCFiwVUq9jBobw0adwe9-x3AUB8cSxrf6gHnQTfUMTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/31 15:45, Geert Uytterhoeven wrote:
> Hi Kefeng,
>
> On Sat, May 29, 2021 at 12:47 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Add setup_initial_init_mm() helper to setup kernel text,
>> data and brk.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Thanks for your patch!
>
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -564,6 +564,16 @@ struct mm_struct {
>>   };
>>
>>   extern struct mm_struct init_mm;
>> +static inline void setup_initial_init_mm(char *start_code,
>> +                                        char *end_code,
>> +                                        char *end_data,
>> +                                        char *brk)
> "void *" (for all four)?
The original users are all "char*",  so same here ;)
>
>> +{
>> +       init_mm.start_code = (unsigned long)start_code;
>> +       init_mm.end_code = (unsigned long)end_code;
>> +       init_mm.end_data = (unsigned long)end_data;
>> +       init_mm.brk = (unsigned long)brk;
>> +}
> Gr{oetje,eeting}s,
>
>                          Geert
>
