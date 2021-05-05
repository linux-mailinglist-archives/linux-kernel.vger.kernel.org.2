Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D8373C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhEENZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231774AbhEENZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620221044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMchfOp6Ltdn4ef76YgieWUBY94rW4g/5Cql6qMjVFQ=;
        b=LSdoC9qHLjhJsW3gcjqCELVMHwA4rdLcPNYriNShCzNU7M4ybSW8N+QlufXGuVH5UcR24O
        J2YsCWAnT4aCtZD8xwWiH9dF2ilYwfzMyuZEjZBM1BVUOrP9XXFz/x9xf2EIHdrUCZCl5v
        YKzFdJfxqHOY4+RqtRN0hzRph6fXWJw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-kfz5wfX7MHyWvtWPWX0Qkg-1; Wed, 05 May 2021 09:24:01 -0400
X-MC-Unique: kfz5wfX7MHyWvtWPWX0Qkg-1
Received: by mail-ej1-f71.google.com with SMTP id ne22-20020a1709077b96b02903803a047edeso447473ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gMchfOp6Ltdn4ef76YgieWUBY94rW4g/5Cql6qMjVFQ=;
        b=tCWJCHiLHDKMiUrkKHHnMrP6lFtdqdntJXvwnhJUdtu6KaKgZ/lT3PHvfKjHVQ6w6V
         khgAX0eboIhqKTsE/44b/19xMfITuYzR/oUWpqdBhchuTkQEYZmQZ+M6EGojGmTAVOXp
         xdVxTvpomjvWp+0zCVGl2rOv1wUvlIOpEVytbvb4OTX6MANGTR0Y3zlpKGTc8AK54Py2
         0wKXGtl0pyguDMW7O4n3s86dr7tLZJ6YgX2rEFzc4SZ0unmlhOyweySqD55pJd7PhSqF
         VxKHQo8a2tWD6ISJZZ1uDE5Ak8Le1wWb5mU+5VyjTzawbvyDtNQbhrXdOUl96WFXXEff
         2j9Q==
X-Gm-Message-State: AOAM531azwQAeunBXYpdGgwKiIFwexBH08ANiBFDMaiH0EGROs/OBZGw
        VEBLwuMsCCeWDUloHyE+RsS9F+Ewn6UTxS+DOpYe0WCz4tqQIakSmjjzw5VNFrTiMveYMgkwKL8
        W+uPeuiS1hrVs3vNynFwXK/4e
X-Received: by 2002:a05:6402:199:: with SMTP id r25mr32454485edv.128.1620221039869;
        Wed, 05 May 2021 06:23:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzptaWcBUE3+5K+c4ACcILgNlmN2lX6JQUeGNxEVsplyAAZ+H4vRTKzfad3Is7IycuqnDrkBQ==
X-Received: by 2002:a05:6402:199:: with SMTP id r25mr32454475edv.128.1620221039717;
        Wed, 05 May 2021 06:23:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b8sm16280702edu.41.2021.05.05.06.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:23:59 -0700 (PDT)
Subject: Re: [v3,1/1] adv_mix955x is a scheme that multiplexes PCA9554/PCA9555
 into LED and GPIO
To:     =?UTF-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "345351830@qq.com" <345351830@qq.com>,
        =?UTF-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>,
        =?UTF-8?B?eXVueGlhLmxpKOadjuS6kemcnik=?= 
        <yunxia.li@advantech.com.cn>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        =?UTF-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        Mark Gross <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <tencent_F8EEB847E2CD8A6813D0BF4863964CDF3508@qq.com>
 <b787cd95ad7746d9a04e8cd7f6c0b645@ACNMB2.ACN.ADVANTECH.CORP>
 <CAHp75Vce_-m5uXgpyRO300M1Vw8DX2BmnBPsF5OaUK2_hNDb_A@mail.gmail.com>
 <DFBFA86F-1A66-4351-9987-C63CCB40D82A@advantech.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ec4da512-76c7-acec-f41d-179fd469b615@redhat.com>
Date:   Wed, 5 May 2021 15:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DFBFA86F-1A66-4351-9987-C63CCB40D82A@advantech.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/21 3:16 PM, yuechao.zhao(赵越超) wrote:
> Hi Andy
> Sorry for the late reply
> 
> The reason for writing this driver is that our customers hope that the LED and GPIO can be used out of the box
> When they using our X86-Platform
> 
> About the document and ACPI expert, I will provide them after I improve them. Please wait for a few days.

So my initial assessment of this code matches Andy's I don't like the idea
of duplicating the GPIO chip functionality from drivers/gpio/gpio-pca953x.c here.

I understand that you want to have things working out of the box and I believe
that we all agree that that is what we want.

But you can get there without duplicating the code.

We already have cases where there is an I2C device with an existing driver
where we need some "glue" code to translate the ACPI provided info to
what the i2c drivers expect, some examples of these are:

drivers/platform/x86/i2c-multi-instantiate.c
drivers/platform/x86/intel_cht_int33fe_typec.c

So what you need to do is basically start writing a completely new driver
which:

1. Instantiates an i2c-client for the drivers/gpio/gpio-pca953x.c driver
to bind to.

2. Creates and attaches software-fwnodes which provide info for the 
drivers/leds/leds-gpio.c code to parse and have that code instantiate
LED class devices which drive the leds through the GPIO interface
offered by the drivers/gpio/gpio-pca953x.c driver.

Regards,

Hans


> ﻿在 2021/5/2 下午6:50，“Andy Shevchenko”<andy.shevchenko@gmail.com> 写入:
> 
>     On Fri, Apr 30, 2021 at 8:27 AM yuechao.zhao(赵越超)
>     <yuechao.zhao@advantech.com.cn> wrote:
>     >
>     > From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
>     >
>     > With this driver, we can multiplex PCA9554/PCA9555 into LED and GPIO
>     > based on the ACPI data of BIOS.
> 
>     NAK as per v2.
> 
>     Please, add a proper documentation and show ACPI excerpt, and last but
>     not least is missing justification.
> 
> 
>     -- 
>     With Best Regards,
>     Andy Shevchenko
> 

