Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9D3C9D69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbhGOLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:06:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15019 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhGOLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:06:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQWcS658kzbc5f;
        Thu, 15 Jul 2021 19:00:24 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:03:42 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:03:42 +0800
Subject: Re: [PATCH -next v2] drm/bochs: Fix missing pci_disable_device() on
 error in bochs_pci_probe()
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <airlied@linux.ie>, <kraxel@redhat.com>
References: <20210715020551.1030812-1-yangyingliang@huawei.com>
 <49771e7d-666a-bac3-2cd7-23008a95ad8e@suse.de>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <22ff114a-9810-37f4-43c2-22ce55d6482f@huawei.com>
Date:   Thu, 15 Jul 2021 19:03:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <49771e7d-666a-bac3-2cd7-23008a95ad8e@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/15 17:30, Thomas Zimmermann wrote:
> Hi,
>
> for the change
>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
>
> but there are some style issues AFAICS.
OK, need I resend it with the style changes and your ack ?
>
> Am 15.07.21 um 04:05 schrieb Yang Yingliang:
>> Replace pci_enable_device() with pcim_enable_device(),
>> pci_disable_device() will be called in release automatically.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>
> S-o-b line goes first
>
>> ---
>> v2:
>>    use pcim_enable_device()
>
> This changelog should rather be located between the commit description 
> and the first S-o-b line.
>
> Best regards
> Thomas
>
>> ---
>>   drivers/gpu/drm/tiny/bochs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
>> index a2cfecfa8556..73415fa9ae0f 100644
>> --- a/drivers/gpu/drm/tiny/bochs.c
>> +++ b/drivers/gpu/drm/tiny/bochs.c
>> @@ -648,7 +648,7 @@ static int bochs_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *ent
>>       if (IS_ERR(dev))
>>           return PTR_ERR(dev);
>>   -    ret = pci_enable_device(pdev);
>> +    ret = pcim_enable_device(pdev);
>>       if (ret)
>>           goto err_free_dev;
>>
>
