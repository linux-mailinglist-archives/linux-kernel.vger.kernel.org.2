Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE2231E3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhBRBfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:35:37 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:25438 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBRBfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:35:33 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8602dc428253-939d3; Thu, 18 Feb 2021 09:34:32 +0800 (CST)
X-RM-TRANSID: 2ee8602dc428253-939d3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1602dc41c5f8-83fcc;
        Thu, 18 Feb 2021 09:34:31 +0800 (CST)
X-RM-TRANSID: 2ee1602dc41c5f8-83fcc
Subject: Re: [PATCH] virtio-mmio: Use to_virtio_mmio_device() to simply code
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210210030401.5532-1-tangbin@cmss.chinamobile.com>
 <b7043be4-46cf-e72c-b3aa-4a8d487e82ad@redhat.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <740b0c1f-24d4-de31-8753-4c5ec07b92f9@cmss.chinamobile.com>
Date:   Thu, 18 Feb 2021 09:34:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b7043be4-46cf-e72c-b3aa-4a8d487e82ad@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jason：

       Sorry for the late reply this email.

在 2021/2/10 16:09, Jason Wang 写道:
>
> On 2021/2/10 上午11:04, Tang Bin wrote:
>> The file virtio_mmio.c has defined the function to_virtio_mmio_device,
>> so use it instead of container_of() to simply code. And remove
>> superfluous blank lines in this file.
>>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>>   drivers/virtio/virtio_mmio.c | 16 +---------------
>>   1 file changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index 627ac0487..449d0f209 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c
>> @@ -69,14 +69,10 @@
>>   #include <uapi/linux/virtio_mmio.h>
>>   #include <linux/virtio_ring.h>
>>   -
>> -
>
>
> It's better not mix the patch with style changes.
>
> Other looks good.
>
> Thanks

Whether should I send patch V2？

Thanks

>
>
>>   /* The alignment to use between consumer and producer parts of vring.
>>    * Currently hardcoded to the page size. */
>>   #define VIRTIO_MMIO_VRING_ALIGN        PAGE_SIZE
>>   -
>> -
>>   #define to_virtio_mmio_device(_plat_dev) \
>>       container_of(_plat_dev, struct virtio_mmio_device, vdev)
>>   @@ -100,8 +96,6 @@ struct virtio_mmio_vq_info {
>>       struct list_head node;
>>   };
>>   -
>> -
>>   /* Configuration interface */
>>     static u64 vm_get_features(struct virtio_device *vdev)
>> @@ -264,8 +258,6 @@ static void vm_reset(struct virtio_device *vdev)
>>       writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
>>   }
>>   -
>> -
>>   /* Transport interface */
>>     /* the notify function used when creating a virt queue */
>> @@ -307,8 +299,6 @@ static irqreturn_t vm_interrupt(int irq, void 
>> *opaque)
>>       return ret;
>>   }
>>   -
>> -
>>   static void vm_del_vq(struct virtqueue *vq)
>>   {
>>       struct virtio_mmio_device *vm_dev = 
>> to_virtio_mmio_device(vq->vdev);
>> @@ -512,13 +502,11 @@ static const struct virtio_config_ops 
>> virtio_mmio_config_ops = {
>>       .bus_name    = vm_bus_name,
>>   };
>>   -
>>   static void virtio_mmio_release_dev(struct device *_d)
>>   {
>>       struct virtio_device *vdev =
>>               container_of(_d, struct virtio_device, dev);
>> -    struct virtio_mmio_device *vm_dev =
>> -            container_of(vdev, struct virtio_mmio_device, vdev);
>> +    struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>>       struct platform_device *pdev = vm_dev->pdev;
>>         devm_kfree(&pdev->dev, vm_dev);
>> @@ -608,8 +596,6 @@ static int virtio_mmio_remove(struct 
>> platform_device *pdev)
>>       return 0;
>>   }
>>   -
>> -
>>   /* Devices list parameter */
>>     #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
>


