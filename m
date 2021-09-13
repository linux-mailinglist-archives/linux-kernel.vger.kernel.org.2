Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8744088FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbhIMK2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhIMK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:28:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9CFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 03:27:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso6105089pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4ojy6cEsFHk10XZ8gTjQ+8LmjK4t0ENByVBTa8Pq7oU=;
        b=QuwYcmThUMsaKLPdimS74jJZtMpt3AGfCzcrliBD84wbo8kIKgW2stgTtjKVEPOXzT
         vK9j9FtLGWqdxd6JBDkTbSw7MzcmTUtHHx+dCGDznrQl20OvaAzYP3TYfHi2eMMB5YFp
         YCkUY17hm27ZRdbvTJgKTQ0nJX132ZwjKAu2TcGOyHglENSby2fAe19CY5+OJ1lJs/Nu
         Bwr91VjUS+jm5EFG/8ZyIXrPRxbKQ4aYh4rt4sCDZgA6IFSQJcjUmb8xcmj10W+S4/kd
         3thgZ1vmfDQJNAI6o6aVXaEtJ18Ie5qHSQK4ytd6+usHvlg09Em1q5wuNTzsT1gu7klb
         clHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ojy6cEsFHk10XZ8gTjQ+8LmjK4t0ENByVBTa8Pq7oU=;
        b=a6q3QrNEEjxQDoSx9Mdrv8ucidw8XlGn21KOTzOLCmn9+Ka98/86ovUuySTH5ypCp3
         I6H3Tf6Ta2lCJ6OKIWyzYGDrgZ6KkpJLRimGIhHUoaaTefqOtxiGy+Q+kJWigLaCF3DA
         Gua8zpzd62TmPwRUz7kIR96v7WOfbszLVT77mm0HpSXO6dlaimFbzv0ogkcK4VWJDpz/
         XkLr+PZK7xHrqLn77+yjRy2sAb5Yrff9nxjRQyzjyPsCPwhXeHld5fzTfn2IXx77x3Ew
         H+qiOItk4t2m1v3TBrjhPSnouRszvixcS6pZJqnC02z3ZvrIk6C17/+F0Aih3eXQjAmY
         m1ew==
X-Gm-Message-State: AOAM531e8U2jgoy302uXV5BkmwV9FfZIKz/i1KeZIFucM9NosNyu8efw
        gThtkDIj2ahOmziOEm6PyEkTLQyIYIxrqQ==
X-Google-Smtp-Source: ABdhPJy/mVKPNDDtD4/hvsKtLutn7O4PYcsfQlygwftXaH5JMs9hcX/42bjEZeujoWBt0V4KD/A4xQ==
X-Received: by 2002:a17:902:b218:b029:11a:bf7b:1a80 with SMTP id t24-20020a170902b218b029011abf7b1a80mr9787613plr.82.1631528845385;
        Mon, 13 Sep 2021 03:27:25 -0700 (PDT)
Received: from [192.168.10.23] (124-171-108-209.dyn.iinet.net.au. [124.171.108.209])
        by smtp.gmail.com with ESMTPSA id q12sm6663523pfj.153.2021.09.13.03.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 03:27:24 -0700 (PDT)
Message-ID: <f73fc95b-9164-536f-99b2-f46bf0d06837@ozlabs.ru>
Date:   Mon, 13 Sep 2021 20:27:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:92.0) Gecko/20100101
 Thunderbird/92.0
Subject: Re: [PATCH V3 5/5] virtio: Bind virtio device to device-tree node
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
 <d5f87715-5a3e-1e85-68ba-3e4d35163c68@ozlabs.ru>
 <20210913053816-mutt-send-email-mst@kernel.org>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210913053816-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/09/2021 19:45, Michael S. Tsirkin wrote:
> On Mon, Sep 13, 2021 at 07:19:17PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 26/07/2021 14:51, Viresh Kumar wrote:
>>> Bind the virtio devices with their of_node. This will help users of the
>>> virtio devices to mention their dependencies on the device in the DT
>>> itself. Like GPIO pin users can use the phandle of the device node, or
>>> the node may contain more subnodes to add i2c or spi eeproms and other
>>> users.
>>>
>>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>  drivers/virtio/virtio.c | 57 ++++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 54 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>> index 4b15c00c0a0a..d001e84a5b23 100644
>>> --- a/drivers/virtio/virtio.c
>>> +++ b/drivers/virtio/virtio.c
>>> @@ -4,6 +4,7 @@
>>>  #include <linux/virtio_config.h>
>>>  #include <linux/module.h>
>>>  #include <linux/idr.h>
>>> +#include <linux/of.h>
>>>  #include <uapi/linux/virtio_ids.h>
>>>  
>>>  /* Unique numbering for virtio devices. */
>>> @@ -292,6 +293,9 @@ static int virtio_dev_remove(struct device *_d)
>>>  
>>>  	/* Acknowledge the device's existence again. */
>>>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>>> +
>>> +	of_node_put(dev->dev.of_node);
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> @@ -319,6 +323,43 @@ void unregister_virtio_driver(struct virtio_driver *driver)
>>>  }
>>>  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
>>>  
>>> +static int virtio_device_of_init(struct virtio_device *dev)
>>> +{
>>> +	struct device_node *np, *pnode = dev_of_node(dev->dev.parent);
>>> +	char compat[] = "virtio,XXXXXXXX"; /* Reserve enough space 32-bit id */
>>> +	int ret, count;
>>> +
>>> +	if (!pnode)
>>> +		return 0;
>>> +
>>> +	count = of_get_available_child_count(pnode);
>>> +	if (!count)
>>> +		return 0;
>>> +
>>> +	/* There can be only 1 child node */
>>> +	if (WARN_ON(count > 1))
>>> +		return -EINVAL;
>>> +
>>> +	np = of_get_next_available_child(pnode, NULL);
>>> +	if (WARN_ON(!np))
>>> +		return -ENODEV;
>>> +
>>> +	BUG_ON(snprintf(compat, sizeof(compat), "virtio,%x", dev->id.device) >=
>>> +	       sizeof(compat));
>>> +
>>> +	if (!of_device_is_compatible(np, compat)) {
>>
>>
>> This broke powerpc/pseries as there these virtio devices are PCI so
>> there is no "compat" - PCI vendor id/device ids play role of "compat".
>> Thanks,
> 
> Hmm now that you say this I wonder why do we bother
> with this check, too. When can this be invoked for something
> that is not a virtio device? And is it enough to just
> skip of_node initialization then?


I am not following here, the problem device is virtio-scsi which is
virtio-derived, or you meant that virtio which hosts virtio-bus?

> 
>>
>>
>>
>>> +		ret = -EINVAL;
> 
> 
> So basically ret = 0 above?


Yup, this does fix it. Thanks,

> 
> 
>>> +		goto out;
>>> +	}
>>> +
>>> +	dev->dev.of_node = np;
>>> +	return 0;
>>> +
>>> +out:
>>> +	of_node_put(np);
>>> +	return ret;
>>> +}
>>> +
>>>  /**
>>>   * register_virtio_device - register virtio device
>>>   * @dev        : virtio device to be registered
>>> @@ -343,6 +384,10 @@ int register_virtio_device(struct virtio_device *dev)
>>>  	dev->index = err;
>>>  	dev_set_name(&dev->dev, "virtio%u", dev->index);
>>>  
>>> +	err = virtio_device_of_init(dev);
>>> +	if (err)
>>> +		goto out_ida_remove;
>>> +
>>>  	spin_lock_init(&dev->config_lock);
>>>  	dev->config_enabled = false;
>>>  	dev->config_change_pending = false;
>>> @@ -362,10 +407,16 @@ int register_virtio_device(struct virtio_device *dev)
>>>  	 */
>>>  	err = device_add(&dev->dev);
>>>  	if (err)
>>> -		ida_simple_remove(&virtio_index_ida, dev->index);
>>> +		goto out_of_node_put;
>>> +
>>> +	return 0;
>>> +
>>> +out_of_node_put:
>>> +	of_node_put(dev->dev.of_node);
>>> +out_ida_remove:
>>> +	ida_simple_remove(&virtio_index_ida, dev->index);
>>>  out:
>>> -	if (err)
>>> -		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>>> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>>>  	return err;
>>>  }
>>>  EXPORT_SYMBOL_GPL(register_virtio_device);
>>>
>>
>> -- 
>> Alexey
> 

-- 
Alexey
