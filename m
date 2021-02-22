Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0E7320FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 04:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBVDoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 22:44:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhBVDoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613965376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5FgwOcgARw510tfV3ROtFeyWaKvqfB9V+RtxJnvgu0=;
        b=CcpAzPqKlGYwxMlpq0qSnRppawVJz1xZI7mGe16DZyzYlA6VLMPO+FW6vQrolN/WyRgNWh
        5hzBSH1hYqQQVU0U7khJEKRl1jXaB+JM7SgM6wTqSXo4G/uy3QR3NGpYAl+2o6tOaHi684
        Qc52QjVogYp/MubajA5pKgTLEFTK1s4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-YdGSBIKFOyG22CGdpSMG_w-1; Sun, 21 Feb 2021 22:42:52 -0500
X-MC-Unique: YdGSBIKFOyG22CGdpSMG_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB59410066EE;
        Mon, 22 Feb 2021 03:42:50 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-112.pek2.redhat.com [10.72.13.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABAB2614FD;
        Mon, 22 Feb 2021 03:42:45 +0000 (UTC)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To:     Guenter Roeck <linux@roeck-us.net>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2cf598ee-38cf-3c1c-33a9-1890e892a8e6@redhat.com>
Date:   Mon, 22 Feb 2021 11:42:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/19 11:38 下午, Guenter Roeck wrote:
> On 2/19/21 12:45 AM, Jason Wang wrote:
>> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
>> lot of confusion. E.g it may break various default configs which want
>> virtio devices.
>>
>> So this patch fixes this by hide the prompot and document the
> ... by hiding the prompt and documenting ...


Hi Michael:

Would you like me to post a new version or you can fix those typos when 
applying the patch?

Thanks


>
>> dependency.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Anders Roxell <anders.roxell@linaro.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
>> ---
>>   drivers/virtio/Kconfig | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 6b9b81f4b8c2..be7df369bc2b 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -13,12 +13,12 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>   	  VIRTIO_F_ACCESS_PLATFORM
>>   
>>   config VIRTIO_PCI_MODERN
>> -	tristate "Modern Virtio PCI Device"
>> -	depends on PCI
>> +	tristate
>>   	help
>>   	  Modern PCI device implementation. This module implements the
>>   	  basic probe and control for devices which are based on modern
>> -	  PCI device with possible vendor specific extensions.
>> +	  PCI device with possible vendor specific extensions. Any
>> +	  module that selects this module must depend on PCI.
>>   
>>   menuconfig VIRTIO_MENU
>>   	bool "Virtio drivers"
>> @@ -28,7 +28,8 @@ if VIRTIO_MENU
>>   
>>   config VIRTIO_PCI
>>   	tristate "PCI driver for virtio devices"
>> -	depends on VIRTIO_PCI_MODERN
>> +	depends on PCI
>> +	select VIRTIO_PCI_MODERN
>>   	select VIRTIO
>>   	help
>>   	  This driver provides support for virtio based paravirtual device
>>

