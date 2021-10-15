Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59742E9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhJOHOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:14:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28945 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhJOHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:14:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HVy5q1vvBzbnCB;
        Fri, 15 Oct 2021 15:07:59 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 15:12:28 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 15:12:27 +0800
Subject: Re: [PATCH] USB: serial: Fix possible memleak in keyspan_port_probe()
To:     Johan Hovold <johan@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211014132033.554304-1-wanghai38@huawei.com>
 <YWg6fBsl/1ui2vcR@hovoldconsulting.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <92fd3812-4b20-1a59-f58d-be1b6a88d2e7@huawei.com>
Date:   Fri, 15 Oct 2021 15:12:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YWg6fBsl/1ui2vcR@hovoldconsulting.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/14 22:11, Johan Hovold Ð´µÀ:
> On Thu, Oct 14, 2021 at 09:20:33PM +0800, Wang Hai wrote:
>> I got memory leak as follows when doing fault injection test:
>>
>> unreferenced object 0xffff888258228440 (size 64):
>>    comm "kworker/7:2", pid 2005, jiffies 4294989509 (age 824.540s)
>>    hex dump (first 32 bytes):
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<ffffffff8167939c>] slab_post_alloc_hook+0x9c/0x490
>>      [<ffffffff8167f627>] kmem_cache_alloc_trace+0x1f7/0x470
>>      [<ffffffffa02ac0e4>] keyspan_port_probe+0xa4/0x5d0 [keyspan]
>>      [<ffffffffa0294c07>] usb_serial_device_probe+0x97/0x1d0 [usbserial]
>>      [<ffffffff82b50ca7>] really_probe+0x167/0x460
>>      [<ffffffff82b51099>] __driver_probe_device+0xf9/0x180
>>      [<ffffffff82b51173>] driver_probe_device+0x53/0x130
>>      [<ffffffff82b516f5>] __device_attach_driver+0x105/0x130
>>      [<ffffffff82b4cfe9>] bus_for_each_drv+0x129/0x190
>>      [<ffffffff82b50a69>] __device_attach+0x1c9/0x270
>>      [<ffffffff82b518d0>] device_initial_probe+0x20/0x30
>>      [<ffffffff82b4f062>] bus_probe_device+0x142/0x160
>>      [<ffffffff82b4a4e9>] device_add+0x829/0x1300
>>      [<ffffffffa0295fda>] usb_serial_probe.cold+0xc9b/0x14ac [usbserial]
>>      [<ffffffffa02266aa>] usb_probe_interface+0x1aa/0x3c0 [usbcore]
>>      [<ffffffff82b50ca7>] really_probe+0x167/0x460
>>
>> If it fails to allocate memory for an out_buffer[i] or in_buffer[i],
>> the previously allocated memory for out_buffer or in_buffer needs to
>> be freed on the error handling path, otherwise a memory leak will result.
>>
>> Fixes: bad41a5bf177 ("USB: keyspan: fix port DMA-buffer allocations")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> ---
>>   drivers/usb/serial/keyspan.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
>> index 87b89c99d517..ba27a9f0275b 100644
>> --- a/drivers/usb/serial/keyspan.c
>> +++ b/drivers/usb/serial/keyspan.c
>> @@ -2901,7 +2901,7 @@ static int keyspan_port_probe(struct usb_serial_port *port)
>>   
>>   	p_priv->inack_buffer = kzalloc(INACK_BUFLEN, GFP_KERNEL);
>>   	if (!p_priv->inack_buffer)
>> -		goto err_inack_buffer;
>> +		goto err_out_buffer;
>>   
>>   	p_priv->outcont_buffer = kzalloc(OUTCONT_BUFLEN, GFP_KERNEL);
>>   	if (!p_priv->outcont_buffer)
>> @@ -2953,13 +2953,12 @@ static int keyspan_port_probe(struct usb_serial_port *port)
>>   
>>   err_outcont_buffer:
>>   	kfree(p_priv->inack_buffer);
>> -err_inack_buffer:
>> +err_out_buffer:
>>   	for (i = 0; i < ARRAY_SIZE(p_priv->out_buffer); ++i)
>>   		kfree(p_priv->out_buffer[i]);
>> -err_out_buffer:
>> +err_in_buffer:
>>   	for (i = 0; i < ARRAY_SIZE(p_priv->in_buffer); ++i)
>>   		kfree(p_priv->in_buffer[i]);
>> -err_in_buffer:
>>   	kfree(p_priv);
>>   
>>   	return -ENOMEM;
> Good catch. Fortunately these small allocations would currently never
> fail, but we should fix it up nonetheless.
>
> The fix looks correct, but you're now mixing two styles of error labels
> (i.e. naming them after where you jump from and after what they do,
> respectively).
>
> Since you're touching all but one label, could you rename also the last
> one after what is done and include a "free_" infix in the label names
> (e.g. err_free_in_buffer, etc)?
Okay, thank you for your suggestion, I will send the v2 patch.
>
> Johan
> .
>
-- 
Wang Hai

