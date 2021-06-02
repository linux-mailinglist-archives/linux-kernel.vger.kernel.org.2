Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424BD3984D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFBJCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:02:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2845 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFBJCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:02:01 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw2tF6fY4zWqMK;
        Wed,  2 Jun 2021 16:55:33 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by dggeme759-chm.china.huawei.com
 (10.3.19.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 2 Jun
 2021 17:00:16 +0800
Subject: Re: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
 <1622516210-10886-2-git-send-email-tiantao6@hisilicon.com>
 <YLW+hZwoImx2wjwS@kroah.com>
 <4c9c7c17-e8d1-d601-6262-8064293a06a9@huawei.com>
 <YLcivXNwm75V+I2m@kroah.com>
 <d3c1ec35-fa62-46ed-9227-866e0a3c96b8@huawei.com>
 <CAHp75VeL4UMFX6oZWaFscTX6Ta5s714NeisR=vTh6mYMjyPi6w@mail.gmail.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <f84f92f5-8462-0556-e457-4e302e1e8cb6@huawei.com>
Date:   Wed, 2 Jun 2021 17:00:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeL4UMFX6oZWaFscTX6Ta5s714NeisR=vTh6mYMjyPi6w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/2 16:48, Andy Shevchenko 写道:
> On Wed, Jun 2, 2021 at 9:45 AM tiantao (H) <tiantao6@huawei.com> wrote:
>> 在 2021/6/2 14:18, Greg KH 写道:
>>> On Wed, Jun 02, 2021 at 02:14:49PM +0800, tiantao (H) wrote:
>>>> 在 2021/6/1 12:58, Greg KH 写道:
>>>>> On Tue, Jun 01, 2021 at 10:56:49AM +0800, Tian Tao wrote:
> ...
>
>>>>>>     /**
>>>>>> + * bitmap_print_to_buf - convert bitmap to list or hex format ASCII string
>>>>>> + * @list: indicates whether the bitmap must be list
>>>>>> + * @buf: page aligned buffer into which string is placed
>>>>>> + * @maskp: pointer to bitmap to convert
>>>>>> + * @nmaskbits: size of bitmap, in bits
>>>>>> + * @off: offset in buf
>>>>>> + * @count: count that already output
>>>>>> + *
>>>>>> + * the role of bitmap_print_to_buf and bitmap_print_to_pagebuf is
>>>>>> + * the same, the difference is that the second parameter of
>>>>>> + * bitmap_print_to_buf can be more than one pagesize.
>>>>>> + */
>>>>>> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
>>>>>> +                  int nmaskbits, loff_t off, size_t count)
>>>>>> +{
>>>>>> +  int len, size;
>>>>>> +  void *data;
>>>>>> +  char *fmt = list ? "%*pbl\n" : "%*pb\n";
>>>>>> +
>>>>>> +  len = snprintf(NULL, 0, fmt, nmaskbits, maskp);
>>>>>> +
>>>>>> +  data = kvmalloc(len+1, GFP_KERNEL);
>>>>>> +  if (!data)
>>>>>> +          return -ENOMEM;
>>>>>> +
>>>>>> +  size = scnprintf(data, len+1, fmt, nmaskbits, maskp);
>>>>>> +  size = memory_read_from_buffer(buf, count, &off, data, size);
>>>>>> +  kvfree(data);
>>>>>> +
>>>>>> +  return size;
>>>>> Why is this so different from bitmap_print_to_pagebuf()?  Can't you just
>>>>> use this function as the "real" function and then change
>>>>> bitmap_print_to_pagebuf() to call it with a size of PAGE_SIZE?
>>>> Do you mean do following change, is that correct? :-)
>>> Maybe, it is whitespace corrupted, and it still feels like this function
>>> is much bigger than it needs to be given the function it is replacing is
>>> only a simple sprintf() call.
>>>
>>>> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
>>>> +                       int nmaskbits, loff_t off, size_t count)
>>>> +{
>>>> +       int len, size;
>>>> +       void *data;
>>>> +       const char *fmt = list ? "%*pbl\n" : "%*pb\n";
>>>> +
>>>> +       if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
>>>> +               return scnprintf(buf, count, fmt, nmaskbits, maskp);
>>>> +
>>>> +       len = snprintf(NULL, 0, fmt, nmaskbits, maskp);
>>>> +
>>>> +       data = kvmalloc(len+1, GFP_KERNEL);
>>> Why do you need to allocate more memory?  And why kvmalloc()?
>> Because the memory here will exceed a pagesize and we don't know the
>> exact size, we have to call
>>
>> snprintf first to get the actual size. kvmalloc() is used because when
>> physical memory is tight, kmalloc
>>
>> may fail, but vmalloc will succeed. It is not so bad that the memory is
>> not requested here.
> To me it sounds like the function is overengineered / lacks thought
> through / optimization.
> Can you provide a few examples that require the above algorithm?

so you think we should use kmalloc instead of kvmalloc ?


>
>>>> +       if (!data)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       size = scnprintf(data, len+1, fmt, nmaskbits, maskp);
>>>> +
>>>> +       size = memory_read_from_buffer(buf, count, &off, data, size);
>>>> +       kvfree(data);
>>>> +
>>>> +       return size;
>>>> +}
>
> --
> With Best Regards,
> Andy Shevchenko
> .
>

