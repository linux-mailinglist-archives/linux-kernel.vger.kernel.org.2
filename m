Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B73098CF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhA3X1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 18:27:34 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:42194 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhA3X1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:27:32 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 158A4EB;
        Sat, 30 Jan 2021 15:26:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 158A4EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1612049189;
        bh=jZOTqEpC48fB1VEQWYsLTBGcGIZMEYSHtVoTXvQqjSk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FRz7TRRHG+7nqWtXEtxqK5Dlluv0hfEZP4aBxHh/wL/HOhJubtdlRaofD5UgHLRms
         VeFYoVhfW6tsPUv7WI5ZtU43tQ0DkvcsZkPtqIGKXhd4J+WlNcUXFwKq+8cfUfMGSK
         NkgH4zgrFMvI1ZKPFfXCNFoGMGs8GrKB9fMQw7EI=
Subject: Re: [PATCH v2] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20210129220627.22641-1-scott.branden@broadcom.com>
 <YBUe58hiyI81oUOp@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0c9be399-9565-8596-48c9-439dc094c543@broadcom.com>
Date:   Sat, 30 Jan 2021 15:26:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBUe58hiyI81oUOp@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-01-30 12:55 a.m., Greg Kroah-Hartman wrote:
> On Fri, Jan 29, 2021 at 02:06:27PM -0800, Scott Branden wrote:
>> Correct compile issue if CONFIG_TTY is not set by
>> only adding ttyVK devices if CONFIG_TTY is set.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>
>> ---
>> Changes since v1:
>> Add function stubs rather than compiling out code
>> ---
>>  drivers/misc/bcm-vk/Makefile     |  4 ++--
>>  drivers/misc/bcm-vk/bcm_vk.h     | 35 +++++++++++++++++++++++++++++---
>>  drivers/misc/bcm-vk/bcm_vk_dev.c |  3 +--
>>  drivers/misc/bcm-vk/bcm_vk_tty.c |  6 ++++++
>>  4 files changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
>> index e4a1486f7209..8d81a734fcad 100644
>> --- a/drivers/misc/bcm-vk/Makefile
>> +++ b/drivers/misc/bcm-vk/Makefile
>> @@ -7,6 +7,6 @@ obj-$(CONFIG_BCM_VK) += bcm_vk.o
>>  bcm_vk-objs := \
>>  	bcm_vk_dev.o \
>>  	bcm_vk_msg.o \
>> -	bcm_vk_sg.o \
>> -	bcm_vk_tty.o
>> +	bcm_vk_sg.o
>>  
>> +bcm_vk-$(CONFIG_TTY) += bcm_vk_tty.o
>> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
>> index 3f37c640a814..4a1d515374c7 100644
>> --- a/drivers/misc/bcm-vk/bcm_vk.h
>> +++ b/drivers/misc/bcm-vk/bcm_vk.h
>> @@ -258,7 +258,11 @@ enum pci_barno {
>>  	BAR_2
>>  };
>>  
>> +#ifdef CONFIG_TTY
>>  #define BCM_VK_NUM_TTY 2
>> +#else
>> +#define BCM_VK_NUM_TTY 0
>> +#endif
>>  
>>  struct bcm_vk_tty {
>>  	struct tty_port port;
>> @@ -366,11 +370,15 @@ struct bcm_vk {
>>  	struct miscdevice miscdev;
>>  	int devid; /* dev id allocated */
>>  
>> +#ifdef CONFIG_TTY
>>  	struct tty_driver *tty_drv;
>>  	struct timer_list serial_timer;
>>  	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];
>>  	struct workqueue_struct *tty_wq_thread;
>>  	struct work_struct tty_wq_work;
>> +#else
>> +	struct bcm_vk_tty *tty;
> Why do you still need this pointer?
vk->tty is still in one location in bcm_vk_dev.c when installing the IRQ.
The loop is never executed as VK_MSIX_TTY_MAX = 0 when CONFIG_TTY is not defined.

I'll move setting vk-tty[i].irq_enabled into an inline function in the header file to clean this up.

    for (i = 0;
         (i < VK_MSIX_TTY_MAX) && (vk->num_irqs < irq);
         i++, vk->num_irqs++) {
        err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
                       bcm_vk_tty_irqhandler,
                       IRQF_SHARED, DRV_MODULE_NAME, vk);
        if (err) {
            dev_err(dev, "failed request tty IRQ %d for MSIX %d\n",
                pdev->irq + vk->num_irqs, vk->num_irqs + 1);
            goto err_irq;
        }
        vk->tty[i].irq_enabled = true;
    }


> And should you just have a separate config option for your tty driver
> instead that depends on CONFIG_TTY?  Would you ever want to run this
> driver without the tty portion?
Yes, an additional config option could be added.
Looking at the code, it would simplify (a non-upstreamable) patch that allows the driver to run on
an ancient kernel where we compile out some features that don't work due to kernel api changes since then.

I hadn't added such a config as some are of the opinion having a full featured driver without config options is better.
For example, someone builds the driver without the feature enabled,
then someone needs to use the feature and the driver would need to be rebuilt.

Since it sounds like you are for such CONFIG options I will add it as it simplifies some legacy kernel support used in manufacturing.
> Oh, and much better than the previous version, thanks for cleaning it
> up.
Thanks - your comments do highlight some issues and we are learning from them.
>
> thanks,
>
> greg k-h

