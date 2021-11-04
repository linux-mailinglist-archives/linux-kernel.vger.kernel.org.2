Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0216144548B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKDOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhKDOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:11:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE8C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:09:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so4372084wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dtZoDNcRK9WnLb2NTNZZwLf7tfdr2NWuYkwNvRK2mbo=;
        b=RdSKhyiBBBduAUZ+6urJp2cqptTXf/SNHkGb7rWujq5gvI327BdIrSisVOZhuTH82X
         L4pku0LB+dKMt8Wwy2SQrxOXS+5aK5oKDuiKTdx7YTpSQ79QJgR5PPohtR/BISPQckuo
         q6HoxY+HEHDsFElt7FSI1yLoUVnLd0cv3YqWgvyJEhgj4Je7F0kR5RgjWBZt6jbcxEfU
         QnXOl2M3JfT3ahUPKkkgzZtfsDUEh8cF8ESZ36qMBEzxxUGan1B5F5/z7drJI+UK/z4o
         DVAAT67iTX5oGy8lmcmXpPUqFrJUN4xcz53WIXhspDwcB1mwcsv+dZ0AIGDbZHAag10d
         MZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dtZoDNcRK9WnLb2NTNZZwLf7tfdr2NWuYkwNvRK2mbo=;
        b=x7b7z+wNiwDRQ8P8/7czmG3NLzcxN4ZxHi2VUnoTMl9qUIyaLfdv3Pvn6hKxWFVBDa
         Mvm+yH5RFZISrB7MEOU2vYaK+t1ljLWyZAKic5xjKe3pUK+1sV4cjTzmkUzLBwlDmqHS
         302aDV3q3eJjdUhR3m/wp7F97x4kJXn2mfaYudGGjeJoiezt7zC6L03gvBmwD4xHKEvp
         OVRjlMTZQDebJ/ep3L63inkWNaMy2Avr6eOgjuP+d2S9g9EDEM8+6pYt08YybC0Fm6Le
         FKhtek668kN+EH9warZm5IBjQgGFC5WXRZWBAe0M3mTTMdSpE0J813+xFq1BFO+/Pb+e
         Hr3g==
X-Gm-Message-State: AOAM530eabEe92kJYYc1WdSSh9ODLUZydUxBVbOivVTWu6e8aisrKUTn
        JTxS7CWB8zmb3pfirgfpSClv577bg2F3uQ==
X-Google-Smtp-Source: ABdhPJxggghv6lZe+pIeL+TbfhccVq1A/vsRzF+Ccm0nsyLCXNRqfwkR+5sdHVLU7ncTmQ3ElQDk1g==
X-Received: by 2002:a05:600c:2149:: with SMTP id v9mr23762986wml.59.1636034941399;
        Thu, 04 Nov 2021 07:09:01 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id n32sm4953465wms.42.2021.11.04.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:09:00 -0700 (PDT)
Date:   Thu, 4 Nov 2021 14:08:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Fix linker error due to new
 mfd-core dependency
Message-ID: <YYPpewMhot95DceK@google.com>
References: <20211103190426.1511507-1-tyhicks@linux.microsoft.com>
 <YYOYvDnX7yA932re@google.com>
 <20211104135347.GD3600@sequoia>
 <CA+HBbNFPN91SF8CGVHt1bLptj4rbD7MDFgHNWQ+ry_y_wR+-NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNFPN91SF8CGVHt1bLptj4rbD7MDFgHNWQ+ry_y_wR+-NA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021, Robert Marko wrote:

> On Thu, Nov 4, 2021 at 2:53 PM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> >
> > On 2021-11-04 08:24:28, Lee Jones wrote:
> > > On Wed, 03 Nov 2021, Tyler Hicks wrote:
> > >
> > > > Select CONFIG_MFD_CORE from CONFIG_MFD_SIMPLE_MFD_I2C, now that
> > > > simple-mfd-i2c.c calls devm_mfd_add_devices(), to fix the following
> > > > linker error:
> > > >
> > > >  ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> > > >  simple-mfd-i2c.c:(.text+0x62): undefined reference to `devm_mfd_add_devices'
> > > >  make: *** [Makefile:1187: vmlinux] Error 1
> > > >
> > > > Fixes: c753ea31781a ("mfd: simple-mfd-i2c: Add support for registering devices via MFD cells")
> > > > Cc: stable@vger.kernel.org # 5.15.x
> > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > ---
> > > >  drivers/mfd/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > >
> > > Looks like the same change that has already been applied.
> > >
> > > Could you rebase on top of the MFD tree please?
> >
> > Ah, that commit wasn't in for-mfd-next when I wrote up this patch
> > yesterday.
> >
> > I think that the Fixes line in that patch is wrong as I didn't see this
> > issue in 5.10 and reverting c753ea31781a fixes the build failure.
> 
> Hi Tyler, I would agree with you on the fixes tag.
> I messed that one up, c753ea31781a is the correct one.

All good.  I fixed it for you.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
