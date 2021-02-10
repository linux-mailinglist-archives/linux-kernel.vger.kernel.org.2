Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7DE315E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 05:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBJEpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 23:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhBJEpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 23:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612932253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34e+K3bIAHZ2pffqYYmkrbH3MIGZjfK+/+CoC5oZ8Qk=;
        b=fRBhF7Po+YdhyXBr+GvC4Amf5e12LyzUfqiDBTmQPyzgqtT+t6xa2F/TxgSELgCB973lXx
        8UEF1+PDELMi1SKoGRS1gPIL+DISUQFkxr0g1lZTON2YcunWi9DGsQjBZQDNbo0D4hxoxN
        Li67zwyxbLfZ4H0crvlcnP2QAZTSF84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-moaQdiKINfSIGndpbArQsg-1; Tue, 09 Feb 2021 23:44:11 -0500
X-MC-Unique: moaQdiKINfSIGndpbArQsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA941005501;
        Wed, 10 Feb 2021 04:44:10 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB9DD10013D7;
        Wed, 10 Feb 2021 04:44:04 +0000 (UTC)
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210209091916-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <721bf1dc-0b06-7f2a-9685-064a7c281366@redhat.com>
Date:   Wed, 10 Feb 2021 12:44:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209091916-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/9 下午10:20, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2021 at 02:55:00PM +0800, Jason Wang wrote:
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/virtio/Kconfig                 |  10 +-
>>   drivers/virtio/Makefile                |   1 +
>>   drivers/virtio/virtio_pci_common.h     |  27 +-
>>   drivers/virtio/virtio_pci_modern.c     | 617 -------------------------
>>   drivers/virtio/virtio_pci_modern_dev.c | 599 ++++++++++++++++++++++++
>>   include/linux/virtio_pci_modern.h      | 111 +++++
>>   6 files changed, 721 insertions(+), 644 deletions(-)
>>   create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
>>   create mode 100644 include/linux/virtio_pci_modern.h
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 7b41130d3f35..6b9b81f4b8c2 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -12,6 +12,14 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>   	  This option is selected if the architecture may need to enforce
>>   	  VIRTIO_F_ACCESS_PLATFORM
>>   
>> +config VIRTIO_PCI_MODERN
>> +	tristate "Modern Virtio PCI Device"
>> +	depends on PCI
>> +	help
>> +	  Modern PCI device implementation. This module implements the
>> +	  basic probe and control for devices which are based on modern
>> +	  PCI device with possible vendor specific extensions.
>> +
>>   menuconfig VIRTIO_MENU
>>   	bool "Virtio drivers"
>>   	default y
>> @@ -20,7 +28,7 @@ if VIRTIO_MENU
>>   
>>   config VIRTIO_PCI
>>   	tristate "PCI driver for virtio devices"
>> -	depends on PCI
>> +	depends on VIRTIO_PCI_MODERN
>>   	select VIRTIO
>>   	help
>>   	  This driver provides support for virtio based paravirtual device
> Looks like VIRTIO_PCI_MODERN is actually just a library that
> virtio pci uses. Is that right?


Right.


> In that case just select it
> automatically, let's not make users enable it manually.


I've considered to do this but the problem is that the module depends on 
PCI so it can't be selected I think.

Thanks


>

