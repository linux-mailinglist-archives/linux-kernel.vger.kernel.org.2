Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1D3212D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhBVJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:12:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230253AbhBVJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613984805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KO2eAxv01FOB+ShIuZKE9lvyTzxRP1g6QCSFRiLbDqI=;
        b=Lkjw0LB9Uus/inIKT8ittdR/xAAKfkWERBf+QH7O2Crl/R+5nLBfPLWZaW6J9SnvgzpRW1
        uDeUvFJNbtRr8czmPqoFDzDeVnysI5YcXnJyiVWH3wIgqtpovi1sN1Ti8GR+fJ3JN9Cskx
        W+4WstaET79qaU+z9PkbubMQkpHyUpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-JJuZURN-PpCo1tLSn0cESA-1; Mon, 22 Feb 2021 04:06:43 -0500
X-MC-Unique: JJuZURN-PpCo1tLSn0cESA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF59A80402C;
        Mon, 22 Feb 2021 09:06:41 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-244.pek2.redhat.com [10.72.12.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC0AF57;
        Mon, 22 Feb 2021 09:06:35 +0000 (UTC)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
 <2cf598ee-38cf-3c1c-33a9-1890e892a8e6@redhat.com>
 <20210222022550-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <48cc339b-a23e-7e56-5234-5b439173209e@redhat.com>
Date:   Mon, 22 Feb 2021 17:06:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222022550-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/22 3:29 下午, Michael S. Tsirkin wrote:
> On Mon, Feb 22, 2021 at 11:42:44AM +0800, Jason Wang wrote:
>> On 2021/2/19 11:38 下午, Guenter Roeck wrote:
>>> On 2/19/21 12:45 AM, Jason Wang wrote:
>>>> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
>>>> lot of confusion. E.g it may break various default configs which want
>>>> virtio devices.
>>>>
>>>> So this patch fixes this by hide the prompot and document the
>>> ... by hiding the prompt and documenting ...
>>
>> Hi Michael:
>>
>> Would you like me to post a new version or you can fix those typos when
>> applying the patch?
>>
>> Thanks
>
> A new version. However I have a suggestion.
>
> How about we call the new library VIRTIO_PCI_LIB? That would be
> a new auto-selected symbol.
>
> We can then keep VIRTIO_PCI as a symbol enabling the actual driver.


Ok, will do.

Thanks


>
>
>
>>>> dependency.
>>>>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Anders Roxell <anders.roxell@linaro.org>
>>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>>> Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>>> ---
>>>>    drivers/virtio/Kconfig | 9 +++++----
>>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>>> index 6b9b81f4b8c2..be7df369bc2b 100644
>>>> --- a/drivers/virtio/Kconfig
>>>> +++ b/drivers/virtio/Kconfig
>>>> @@ -13,12 +13,12 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>>>    	  VIRTIO_F_ACCESS_PLATFORM
>>>>    config VIRTIO_PCI_MODERN
>>>> -	tristate "Modern Virtio PCI Device"
>>>> -	depends on PCI
>>>> +	tristate
>>>>    	help
>>>>    	  Modern PCI device implementation. This module implements the
>>>>    	  basic probe and control for devices which are based on modern
>>>> -	  PCI device with possible vendor specific extensions.
>>>> +	  PCI device with possible vendor specific extensions. Any
>>>> +	  module that selects this module must depend on PCI.
>>>>    menuconfig VIRTIO_MENU
>>>>    	bool "Virtio drivers"
>>>> @@ -28,7 +28,8 @@ if VIRTIO_MENU
>>>>    config VIRTIO_PCI
>>>>    	tristate "PCI driver for virtio devices"
>>>> -	depends on VIRTIO_PCI_MODERN
>>>> +	depends on PCI
>>>> +	select VIRTIO_PCI_MODERN
>>>>    	select VIRTIO
>>>>    	help
>>>>    	  This driver provides support for virtio based paravirtual device
>>>>

