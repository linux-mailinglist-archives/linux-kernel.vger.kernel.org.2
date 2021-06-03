Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA08399F01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFCKfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:35:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3530 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:35:12 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwhxY0g7yzZcDb;
        Thu,  3 Jun 2021 18:30:41 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by dggeme759-chm.china.huawei.com
 (10.3.19.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 18:33:26 +0800
Subject: Re: [PATCH v3 1/3] lib: bitmap: introduce bitmap_print_to_buf
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
 <1622712162-7028-2-git-send-email-tiantao6@hisilicon.com>
 <YLil8ZOpQSsAB5i0@smile.fi.intel.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <95f5e01d-79c1-28f3-f27b-bee4398308de@huawei.com>
Date:   Thu, 3 Jun 2021 18:33:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YLil8ZOpQSsAB5i0@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 17:50, Andy Shevchenko 写道:
> On Thu, Jun 03, 2021 at 05:22:40PM +0800, Tian Tao wrote:
>> New API bitmap_print_to_buf() with bin_attribute to avoid maskp
>> exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
>> of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
>> bitmap_print_to_buf().
> ...
>
>>   /**
>> + * bitmap_print_to_buf - convert bitmap to list or hex format ASCII string
>> + * @list: indicates whether the bitmap must be list
>> + * @buf: the kernel space buffer to read to
>> + * @maskp: pointer to bitmap to convert
>> + * @nmaskbits: size of bitmap, in bits
>> + * @off: offset in data buffer below
>> + * @count: the maximum number of bytes to print
>> + *
>> + * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is
>> + * the same, the difference is that buf of bitmap_print_to_buf()
>> + * can be more than one pagesize.
>> + */
>> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
>> +			int nmaskbits, loff_t off, size_t count)
>> +{
>> +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
>> +	ssize_t size;
>> +	void *data;
>> +
>> +	if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
>> +		return scnprintf(buf, count, fmt, nmaskbits, maskp);
>> +
>> +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
> Are you sure you have put parameters in the correct order?

yes, I already test it.

ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
                                 const void *from, size_t available)

>
>> +	kfree(data);
>> +
>> +	return size;
>> +}
> I guess you have to provide the test case(s).
>

