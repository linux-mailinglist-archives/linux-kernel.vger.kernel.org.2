Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FCB45061F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhKOOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhKOOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636984625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9DzvPWkK06n+ni/1MC77gLjtMv5YGXUlofXA3Q/O/c=;
        b=hdyBEUjF75T6HpCHTH5IJkrxHW6povhuNillWUIqJifKLVY2lrD3+xx03k3RW+trcWXqqo
        tmPqsXTTNdOaRy9aEpiWb26G/JfK7P3K499yPKOeR6RrLAbpIXtoM8M7FyL6qUjJXxe4r5
        4RxbMtm7IHae7g2DHwIAw37Jo+LdwmU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-uaJfisEmN_C7ybA__m8QMQ-1; Mon, 15 Nov 2021 08:57:04 -0500
X-MC-Unique: uaJfisEmN_C7ybA__m8QMQ-1
Received: by mail-pj1-f72.google.com with SMTP id pg9-20020a17090b1e0900b001a689204b52so8668366pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y9DzvPWkK06n+ni/1MC77gLjtMv5YGXUlofXA3Q/O/c=;
        b=FVFQ6SmmZ/VUVQEhpiCanZYkKTGDbVjT+Ep5J/pdKv2WpGsrRi8JJp8HvJicluQRm+
         VEav74f2asphIiB6vviTOP/dQpM+1nt2qdzuR+ssfrBR8xHLr4RNvUbL7MVap7lVmNTk
         kr6cAkybORsSOv2Qn1lmm63JilDvq1y4FXqu/apswAHeouenv3bsbBEAxUB1J6ZrTZt1
         3E3Kk4/gIu2uSovYSxM1W6DiOx0DrxT2VM4jGBmBHG+NNXfrdswwxNNCg6Sap17D9lks
         CO9942Ht2Rsxbk5NeaLS0YPDNQUAfC98uJsy8YzuuL2cbNniF5I8q8AOrgu7Q8nU5ZYo
         kpFg==
X-Gm-Message-State: AOAM532zpNBXlZWiaRPkI9Hw2Hvrc52OT8hb8hlVvgEZBWA6n3mShZR0
        VRhdSWn2vxipdHIvUyKIzrSTypK7/aGbtMJCXKj0dwQ8JguUp7cEc9f6P+r1Mt0HLRX/M7kzvsi
        YZja/iFiPeMSSTKtQungMGf5u
X-Received: by 2002:a63:6d49:: with SMTP id i70mr25535398pgc.40.1636984623386;
        Mon, 15 Nov 2021 05:57:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5cednGe778Wy/mBuz6qjfb0PVvKjg/S4inKv/KP14bnfhwMQ3ShFTx3x/j32fsOkLYg3zzA==
X-Received: by 2002:a63:6d49:: with SMTP id i70mr25535371pgc.40.1636984623145;
        Mon, 15 Nov 2021 05:57:03 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b12sm16405028pfv.118.2021.11.15.05.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:57:02 -0800 (PST)
Subject: Re: [RFC PATCH 0/5] Firmware Upload Framework
To:     Russ Weight <russell.h.weight@intel.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, "Gong, Richard" <richard.gong@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8b7bbdcd-ef48-9f48-10c0-021c41575522@redhat.com>
Date:   Mon, 15 Nov 2021 05:57:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211111011345.25049-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/21 5:13 PM, Russ Weight wrote:
> The Firmware Upload framework provides a common API for uploading firmware
> files to target devices. An example use case involves FPGA devices that
> load FPGA, Card BMC, and firmware images from FLASH when the card boots.
> Users need the ability to update these firmware images while the card is
> in use.
>
> Device drivers that instantiate the Firmware Upload class driver will
> interact with the target device to transfer and authenticate the firmware
> data. Uploads are performed in the context of a kernel worker thread in
> order to facilitate progress indicators during lengthy uploads.
>
> This driver was previously submitted in the context of the FPGA sub-
> system as the "FPGA Image Load Framework", but the framework is generic
> enough to support other devices as well. The previous submission of this
> patch-set can be viewed here:
>
> https://marc.info/?l=linux-kernel&m=163295640216820&w=2
>
> The n3000bmc-sec-update driver is the first driver to use the Firmware
> Upload API. A recent version of these patches can be viewed here:
>
> https://marc.info/?l=linux-kernel&m=163295697217095&w=2
>
> I don't think I am duplicating any functionality that is currently covered
> in the firmware subsystem. I appreciate your feedback on these patches.

This may be a common api for fpga/dfl-, but it is not likely common for 
general devices.

Could the scope of this patchset be reduced to just fpga/dfl for now ?

Something more like stratix10-rsu.

Tom

>
> - Russ
>
> Russ Weight (5):
>    firmware: Create firmware upload framework
>    firmware: upload: Enable firmware uploads
>    firmware: upload: Signal eventfd when complete
>    firmware: upload: Add status ioctl
>    firmware: upload: Enable cancel of firmware upload
>
>   .../driver-api/firmware/firmware-upload.rst   |  54 +++
>   Documentation/driver-api/firmware/index.rst   |   1 +
>   MAINTAINERS                                   |   9 +
>   drivers/firmware/Kconfig                      |   8 +
>   drivers/firmware/Makefile                     |   1 +
>   drivers/firmware/firmware-upload.c            | 413 ++++++++++++++++++
>   include/linux/firmware/firmware-upload.h      |  69 +++
>   include/uapi/linux/firmware-upload.h          |  73 ++++
>   8 files changed, 628 insertions(+)
>   create mode 100644 Documentation/driver-api/firmware/firmware-upload.rst
>   create mode 100644 drivers/firmware/firmware-upload.c
>   create mode 100644 include/linux/firmware/firmware-upload.h
>   create mode 100644 include/uapi/linux/firmware-upload.h
>

