Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4484321F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhBVS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231816AbhBVS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614020211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHg9HBe21T8aNYDULFVYUPlUSoyVR/CXm3vwO0QOYbs=;
        b=L+I9OzLEGaI2Mj8m9FI87gFVUDH1BFciHyl/5nUfESref7Qx9zt7aJ2fK0wYHeslGjaRrb
        0mf//7bREKiILrJp1R7pUdOpnRv2qNsD5qN2gQmVlQ50Jf49+R+cmSTkYI+I5sSp2ASz+M
        hngx3Mhdp/2qc8BvBqFkgfKKoVOOn0k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-z8BmI0lZOq6gElNfBLMIJg-1; Mon, 22 Feb 2021 13:56:48 -0500
X-MC-Unique: z8BmI0lZOq6gElNfBLMIJg-1
Received: by mail-qt1-f199.google.com with SMTP id l1so8340617qtv.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rHg9HBe21T8aNYDULFVYUPlUSoyVR/CXm3vwO0QOYbs=;
        b=Iw8mf+D2wqFWFtBVOv+Lslz8Ro/v8pKCATRETAMuOHr+mx02jmQJwJ7cf63/UZLznm
         gBGW0UvDgMPQ8X/aoiuZ4c0Jj5wIDlw25ZY5ds7umllIVXaOr0JBEhCxrk/t7pABn3rZ
         fe9dK9BihSnSUpIQEXUUyVWj/aZZE/KfuxQ0FMSHr/EyftbQJxkXahEj92NjZtEvAHoL
         jSTsaCcP/ab0fjuZwWM/cGBU9IEC8Gppi7Q/8fM+1QeXANlLv35AwdD503dtTDgFxfun
         jyLjxcLjJhDYB21ZaF7a3LTi0R4AkakErXPD+kij1VBcjSTbauYinRuhLAbk+5CgU3lv
         Svdw==
X-Gm-Message-State: AOAM533eUPBdkXY6hkxjBdxcCYRl8SL9miL3rFQPFhjNeNSiQCCl945e
        DnJHvXD/6Mi1YvwV7qgx3gKA6oDRid4kvOEiBd4AS2X7u80CQS2Xm9Ge7vbtjjtTbePS48VrJOg
        GhaQ3sTLQLlW+PGaRvAjHwrjj
X-Received: by 2002:a0c:abce:: with SMTP id k14mr21747502qvb.23.1614020207772;
        Mon, 22 Feb 2021 10:56:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/AMx9vVcs0qiOU4dEFXY7oJr5YRPBT1Zk6NdMEC00pqTTu9EDaFcj25uu4N7WZVpErziydw==
X-Received: by 2002:a0c:abce:: with SMTP id k14mr21747480qvb.23.1614020207539;
        Mon, 22 Feb 2021 10:56:47 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm11386133qtj.50.2021.02.22.10.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 10:56:47 -0800 (PST)
Subject: Re: [PATCH v11 0/2] UIO support for dfl devices
To:     Xu Yilun <yilun.xu@intel.com>, gregkh@linuxfoundation.org,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1612403971-13291-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9b5f6e54-7122-8cfb-39f8-a84599e081f1@redhat.com>
Date:   Mon, 22 Feb 2021 10:56:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612403971-13291-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yilun,

Is there anything outstanding or remaining to be done ?

Tom

On 2/3/21 5:59 PM, Xu Yilun wrote:
> This patchset supports some dfl device drivers written in userspace.
>
> In the patchset v1, the "driver_override" interface should be used to bind
> the DFL UIO driver to DFL devices. But there is concern that the 
> "driver_override" interface is not OK itself.
>
> In v2, we use a new matching algorithem. The "driver_override" interface
> is abandoned, the DFL UIO driver matches any DFL device which could not be
> handled by other DFL drivers. So the DFL UIO driver could be used for new 
> DFL devices which are not supported by kernel. The concern is the UIO may 
> not be suitable as a default/generic driver for all dfl features, such as
> features with multiple interrupts.
>
> In v4, we specify each matching device in the id_table of the UIO driver,
> just the same as other dfl drivers do. Now the UIO driver supports Ether
> Group feature. To support more DFL features, their feature ids should be
> added to the driver's id_table.
>
> Before v9, we create a "uio_pdrv_genirq" platform device using DFL devices'
> resources. Then we leverage the uio_pdrv_genirq driver for UIO support. It
> is suggested that we implement a driver in drivers/uio that directly calls
> UIO framework APIs. So we implement the uio_dfl driver in v9. The driver
> now only binds the ether group feature, which has no irq. So the irq 
> support is not implemented yet.
>
>
> Main changes from v1:
> - switch to the new matching algorithem. It matches DFL devices which could
>   not be handled by other DFL drivers.
> - refacor the code about device resources filling.
> - add the documentation.
>
> Main changes from v2:
> - split the match ops changes in dfl.c to an independent patch.
> - move the declarations needed for dfl-uio-pdev from include/linux/dfl.h
>   to driver/fpga/dfl.h
> - some minor fixes.
>
> Main changes from v3:
> - switch to specifying each matching device in the driver's id_table.
> - refactor the irq handling code.
>
> Main changes from v4:
> - refactor the irq handling code.
>
> Main changes from v5:
> - fix the res[] zero initialization issue.
> - improve the return code for probe().
> - some doc improvement.
>
> Main changes from v6:
> - use platform_device_register_resndata() for pdev creation.
>
> Main changes from v7:
> - some doc fixes.
>
> Main changes from v8:
> - switch to add a uio driver in drivers/uio
>
> Main changes from v9:
> - add this source file in MAINTAINERS
> - improve the Kconfig, add more descriptive Kconfig header, add detailed
>   path for opae uio example in Kconfig.
>
> Main changes from v10:
> - add description in doc that interrupt support is not implemented yet.
>
>
> Xu Yilun (2):
>   uio: uio_dfl: add userspace i/o driver for DFL bus
>   Documentation: fpga: dfl: Add description for DFL UIO support
>
>  Documentation/fpga/dfl.rst | 26 ++++++++++++++++++
>  MAINTAINERS                |  1 +
>  drivers/uio/Kconfig        | 17 ++++++++++++
>  drivers/uio/Makefile       |  1 +
>  drivers/uio/uio_dfl.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 111 insertions(+)
>  create mode 100644 drivers/uio/uio_dfl.c
>

