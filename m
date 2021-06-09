Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B283A1594
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhFIN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233302AbhFIN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623245229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ohr3+N5+xISuDSpVy5HLd2jlXJtsoJDH7zUknKOaVE=;
        b=Pbyq3avq+eG3xosDAZfc/FYyJPgsaM0fpzrMWk5XkcMXPxIJp3RDJ8EvM9v2TVrHw+HbkZ
        QizTg0RUgQz5/Ttx/dhS2fuZ5QnFoiKvteK8bW6xD4ziet8a3iy+vxDp4hii6HhRjlWcIf
        RgIGp44yaYMF1F5HbWll3GuxRBC5kPE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-IDPNACDtPai5U8AEuSbAGA-1; Wed, 09 Jun 2021 09:27:08 -0400
X-MC-Unique: IDPNACDtPai5U8AEuSbAGA-1
Received: by mail-oo1-f72.google.com with SMTP id o2-20020a4ad4820000b0290208a2516d36so15523407oos.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9ohr3+N5+xISuDSpVy5HLd2jlXJtsoJDH7zUknKOaVE=;
        b=TOtb+gtEwNgjq4H75NmWSftqRzVJ0Uv0CE4N1TvQHBLMRLqsNt3jH5OVppklBxZlb+
         OzV4wuptN8vHuKxX+v/DRtItV09MLYdR7U8/lPxu79iGuALVHwyJF8i23i51+rqkxp3j
         vhlOFBSk2xDshN9fmyWSu3/vnAhF+8tnr+zfwqkPPze/O3mcr0b2E32LvIc6lqSZj3wM
         uLzSk/dSQpSec5sdDKRYKoNgglHt/CGNRAuHDztPk1kB1mpBsAupUhkMmkXJia8f7sva
         PKERLfxcSyyx2VOfEJozhcKxuRffVlKrVztXo/EVxmNaSXEobx9U1rjVzW9BM6Ui5ZSl
         4Qvg==
X-Gm-Message-State: AOAM5316MKTqCb06CW3QnVSThTZZNL6nDsbd06N5PNOyGSECYsDv90Hk
        1WrD/L7CmcQTbcd6jmGE3hOScZKdsyG00eXEoQVci3GmDoQc8Cd1CmIsE7lQSgi4+aStRblc6ee
        pbhASGAfCLupPccjOH9uErY1Uq7hdBAELR7U/+u5272WhiK/mjfwYEubDRcXmCO0XzUcEtiI=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr1480965otj.79.1623245227491;
        Wed, 09 Jun 2021 06:27:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxknDhyZXQ2dREilj+RsfQ2CcUmDo/spMg54cPqAUNtnKCISJ8SIDWlXQ2kuypYzZqZH5QCnA==
X-Received: by 2002:a9d:7096:: with SMTP id l22mr1480942otj.79.1623245227268;
        Wed, 09 Jun 2021 06:27:07 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z14sm3760901oti.29.2021.06.09.06.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:27:07 -0700 (PDT)
Subject: Re: [PATCH 6/7] fpga: xilinx: remove xilinx- prefix on files
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, michal.simek@xilinx.com, nava.manne@xilinx.com,
        luca@lucaceresoli.net, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210608162551.3010533-1-trix@redhat.com>
 <YMCQ9rNKAtXaCiuw@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ec407ae2-ea5a-5c97-aea6-1ba2451116b7@redhat.com>
Date:   Wed, 9 Jun 2021 06:27:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMCQ9rNKAtXaCiuw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/21 2:59 AM, Greg KH wrote:
> On Tue, Jun 08, 2021 at 09:25:51AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> It is not necessary to have a xilinx- prefix on a file
>> when the file is in a xilinx/ subdir.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/xilinx/Makefile                                  | 4 ++--
>>   drivers/fpga/xilinx/{xilinx-pr-decoupler.c => pr-decoupler.c} | 0
>>   drivers/fpga/xilinx/{xilinx-spi.c => spi.c}                   | 0
>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>   rename drivers/fpga/xilinx/{xilinx-pr-decoupler.c => pr-decoupler.c} (100%)
>>   rename drivers/fpga/xilinx/{xilinx-spi.c => spi.c} (100%)
>>
>> diff --git a/drivers/fpga/xilinx/Makefile b/drivers/fpga/xilinx/Makefile
>> index 7bb7543412790..4ac727d03e140 100644
>> --- a/drivers/fpga/xilinx/Makefile
>> +++ b/drivers/fpga/xilinx/Makefile
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>> -obj-$(CONFIG_XILINX_PR_DECOUPLER) += xilinx-pr-decoupler.o
>> -obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += xilinx-spi.o
>> +obj-$(CONFIG_XILINX_PR_DECOUPLER) += pr-decoupler.o
>> +obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += spi.o
> You just renamed the module to be called "spi.ko"????
>
> Did you test this thing?  You can not rename modules without good
> reasons, and calling a device specific kernel module "spi.ko" is not ok.

yes, this is a problem, I will drop the renaming patches.

Tom

> greg k-h
>

