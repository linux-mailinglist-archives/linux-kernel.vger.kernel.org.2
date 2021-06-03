Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A214399EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFCKdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:33:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7089 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFCKdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:33:43 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fwhvr5rb0zYpX2;
        Thu,  3 Jun 2021 18:29:12 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by dggeme759-chm.china.huawei.com
 (10.3.19.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 18:31:57 +0800
Subject: Re: [PATCH v3 3/3] drivers/base/node.c: use bin_attribute to avoid
 buff overflow
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
 <1622712162-7028-4-git-send-email-tiantao6@hisilicon.com>
 <YLimj+KPaQ2P/cnl@smile.fi.intel.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <be871547-5fbc-e273-a8ae-97defe75b85c@huawei.com>
Date:   Thu, 3 Jun 2021 18:31:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YLimj+KPaQ2P/cnl@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 17:53, Andy Shevchenko 写道:
> On Thu, Jun 03, 2021 at 05:22:42PM +0800, Tian Tao wrote:
>> Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
>> However, the size of this file is limited to PAGE_SIZE because of the
>> limitation for sysfs attribute. so we use bin_attribute instead of
>> attribute to avoid NR_CPUS too big to cause buff overflow.
> ...
>
>>   }
>>   
>> -static DEVICE_ATTR_RO(cpumap);
>>   
>> -static inline ssize_t cpulist_show(struct device *dev,
>> -				   struct device_attribute *attr,
>> -				   char *buf)
>> +static BIN_ATTR_RO(cpumap, 0);
> So, you will have 2 blank lines in a row after this. Why one is not enough?
> Same question for other similar cases, if any.

  I can delete the line 55. this is the only problem, are there any 
other problems?

47 static inline ssize_t cpumap_read(struct file *file, struct kobject 
*kobj,

   48                                   struct bin_attribute *attr, char 
*buf,
   49                                   loff_t off, size_t count)
   50 {
   51         struct device *dev = kobj_to_dev(kobj);
   52
   53         return node_read_cpumap(dev, false, buf, off, count);
   54 }
   55
   56
   57 static BIN_ATTR_RO(cpumap, 0);
   58
   59 static inline ssize_t cpulist_read(struct file *file, struct 
kobject *kobj,
   60                                    struct bin_attribute *attr, 
char *buf,
   61                                    loff_t off, size_t count)
   62 {
   63         struct device *dev = kobj_to_dev(kobj);
   64
   65         return node_read_cpumap(dev, true, buf, off, count);
   66 }
   67
   68 static BIN_ATTR_RO(cpulist, 0);

>

