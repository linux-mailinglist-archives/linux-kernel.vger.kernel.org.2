Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2438331E635
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhBRGNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231343AbhBRFvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 00:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613627411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1fy9S2r504yXagwrrD+x53jLzsYNs8ax8mmvB90Hdo=;
        b=NaxSBAlwQEA8pAtvovpWCJ0pClLTQuSl/uzw++FGQVYeOsXtXujmpxqjyLHOKuvhwpuIKa
        TUU2puqnIw8llz2fp4iR3U3blsicCjVCKySIWHJhAOmQ5W2OLQ3I0FecjuQXQgWKfDr5vG
        OMi/UqjO689Q8pvwKUjzMc4ZQe6KKeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-I0FBjGjFNySTrBwKIyiRQA-1; Thu, 18 Feb 2021 00:50:07 -0500
X-MC-Unique: I0FBjGjFNySTrBwKIyiRQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DFFC107ACE8;
        Thu, 18 Feb 2021 05:50:06 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAD565D72F;
        Thu, 18 Feb 2021 05:50:00 +0000 (UTC)
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210209091916-mutt-send-email-mst@kernel.org>
 <721bf1dc-0b06-7f2a-9685-064a7c281366@redhat.com>
 <20210210073404-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9d7e0477-9ccf-e516-9825-50523ac9d64a@redhat.com>
Date:   Thu, 18 Feb 2021 13:49:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210073404-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/10 下午8:35, Michael S. Tsirkin wrote:
> On Wed, Feb 10, 2021 at 12:44:03PM +0800, Jason Wang wrote:
>> On 2021/2/9 下午10:20, Michael S. Tsirkin wrote:
>>> On Mon, Jan 04, 2021 at 02:55:00PM +0800, Jason Wang wrote:
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>    drivers/virtio/Kconfig                 |  10 +-
>>>>    drivers/virtio/Makefile                |   1 +
>>>>    drivers/virtio/virtio_pci_common.h     |  27 +-
>>>>    drivers/virtio/virtio_pci_modern.c     | 617 -------------------------
>>>>    drivers/virtio/virtio_pci_modern_dev.c | 599 ++++++++++++++++++++++++
>>>>    include/linux/virtio_pci_modern.h      | 111 +++++
>>>>    6 files changed, 721 insertions(+), 644 deletions(-)
>>>>    create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
>>>>    create mode 100644 include/linux/virtio_pci_modern.h
>>>>
>>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>>> index 7b41130d3f35..6b9b81f4b8c2 100644
>>>> --- a/drivers/virtio/Kconfig
>>>> +++ b/drivers/virtio/Kconfig
>>>> @@ -12,6 +12,14 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>>>    	  This option is selected if the architecture may need to enforce
>>>>    	  VIRTIO_F_ACCESS_PLATFORM
>>>> +config VIRTIO_PCI_MODERN
>>>> +	tristate "Modern Virtio PCI Device"
>>>> +	depends on PCI
>>>> +	help
>>>> +	  Modern PCI device implementation. This module implements the
>>>> +	  basic probe and control for devices which are based on modern
>>>> +	  PCI device with possible vendor specific extensions.
>>>> +
>>>>    menuconfig VIRTIO_MENU
>>>>    	bool "Virtio drivers"
>>>>    	default y
>>>> @@ -20,7 +28,7 @@ if VIRTIO_MENU
>>>>    config VIRTIO_PCI
>>>>    	tristate "PCI driver for virtio devices"
>>>> -	depends on PCI
>>>> +	depends on VIRTIO_PCI_MODERN
>>>>    	select VIRTIO
>>>>    	help
>>>>    	  This driver provides support for virtio based paravirtual device
>>> Looks like VIRTIO_PCI_MODERN is actually just a library that
>>> virtio pci uses. Is that right?
>>
>> Right.
>>
>>
>>> In that case just select it
>>> automatically, let's not make users enable it manually.
>>
>> I've considered to do this but the problem is that the module depends on PCI
>> so it can't be selected I think.
> Drop the dependency, document that whoever selects it must depend on PCI.


Fine with me. Will post a patch.

Thanks


>
>> Thanks
>>
>>

