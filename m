Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6344207D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhKATJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhKATJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635793616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bi90UX8d49/Jz6VaT/YCT1/DeafcfQd3kffKdo8pv1M=;
        b=IuW4yJKxiEiKq3uNxHmQbg73eJQPP3r08RfP/EM6hInrBIpqv4xM6OM4RT6vh7m/cwMgDt
        d9OETCQr2yH03CN5yrSD6K9UYbZH5T4pVazojhP6dKIsOz9vuxW4IiHEyOce2M9oBySv2u
        KH2xsNNoaMdgpR7YMovENR5Qc2LfZrA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-HU14ZvvFP7uB1kRnXAcPfA-1; Mon, 01 Nov 2021 15:06:55 -0400
X-MC-Unique: HU14ZvvFP7uB1kRnXAcPfA-1
Received: by mail-ed1-f72.google.com with SMTP id m8-20020a056402510800b003e29de5badbso1205552edd.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bi90UX8d49/Jz6VaT/YCT1/DeafcfQd3kffKdo8pv1M=;
        b=2i+UeAtDrT+L8BytlPVX+Z6toi7MWhG2DZbEqCwraBsE7OtRZj7WLbaqmhg2brkM2e
         al3KgWWe0+i94aHW3C5rbVUaqXJFAtjpjQQJgSB8QGbR+wbl6VudnY6r8YNcgo+M3M/W
         04xxaqdK9oxTlADWu8jGgVYSJ1fh0m9L2dX6tHopS5YGWQC0cibZOYmG4B4nD0ay4bZM
         E8tI8vyS8Cb8Ex/OxdRgpGecuDSQRNf5J5eQd0JMmGodB6P8CSC63lYkZ25iV3nJFOPT
         6VDP+pmumOvMI9BPBo7wuHNJ9MwFMri3l1cM+hLGNUKcZte+Df6HU3sSqIMKsboYKk0V
         N8Gg==
X-Gm-Message-State: AOAM533DWeSDSFf0V258GOjjxihReyg+eR5EdggqbvoYZAUOUc8d9Pgu
        Pg4z9oY+q7W8FONhjj2P+wSzj5Q/59+vBdJ2p1Yon+rqVo2Dq+SBx9q01WwozsqU+rMCPTLEnI2
        t2kiaiH9jgi9q+p2bynJ1pPyq
X-Received: by 2002:a17:906:3542:: with SMTP id s2mr39000914eja.379.1635793614375;
        Mon, 01 Nov 2021 12:06:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkFHYcCJ7BYV9Qf/ACeB8nPnE2xq5dPY32ips+nJeDfo4W1dQQJfueSCrrdWvG2tzbhez3ng==
X-Received: by 2002:a17:906:3542:: with SMTP id s2mr39000872eja.379.1635793614136;
        Mon, 01 Nov 2021 12:06:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h17sm3614189ede.38.2021.11.01.12.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:06:53 -0700 (PDT)
Message-ID: <2b81ca7e-fcaa-5449-5662-4eb72e746b02@redhat.com>
Date:   Mon, 1 Nov 2021 20:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 04/17] media: atomisp: pci: do not use err var when
 checking port validity for ISP2400
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nable <nable.maininbox@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        "andrey.i.trufanov" <andrey.i.trufanov@gmail.com>,
        Patrik Gfeller <patrik.gfeller@gmail.com>
References: <20211017161958.44351-1-kitakar@gmail.com>
 <20211017161958.44351-5-kitakar@gmail.com> <20211026092637.196447aa@sal.lan>
 <1a295721fd1f1e512cd54a659a250aef162bfb6f.camel@gmail.com>
 <20211028123944.66c212c1@sal.lan>
 <af7cdf9de020171567c2e75b713deb2ed073e4e3.camel@gmail.com>
 <20211101141058.36ea2c8e@sal.lan>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211101141058.36ea2c8e@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/21 15:10, Mauro Carvalho Chehab wrote:

<snip>

>>> Did you test on Baytrail (ISP2400), and with the compile-time option
>>> enabled/disabled?  
>>
>> Sorry, I should have clarified on the cover later. For ISP2400, I did
>> compile test only (CONFIG_VIDEO_ATOMISP_ISP2401 enabled/disabled).
> 
> Maybe Hans could help us on that. I guess he has an Asus T100 device, 
> which is BYT based.
> 
> Hans, if you're willing to do the tests, you could either use nvt
> or v4l2grab to test it.
> 
> It seems that BYT has an additional issue, though: the ISP seems to
> require 12 non-visible lines/columns (in addition to 16 ones required
> by CHT?) for it to work.
> 
> So, you may need to tweak the resolution a bit, as otherwise the
> driver will return an -EINVAL.
> 
> See:
> 
> 	https://git.linuxtv.org/media_stage.git/commit/?id=dcbc4f570495dbd490975979471687cbe2246f99
> 
> For the workaround I had to add for CHT to properly report the
> visible resolution.

Testing BYT support definitely is on my radar. Note that BYT
also has the additional issue that the atomisp2 on BYT can be
enumerated as either a PCI dev (which may work) or an ACPI/platform
dev which is unsupported in the original atomisp2 code-drop and
seems non trivial (because of pci config space writes) to get to
work.

On the T100TA the device is actually enumerated as an ACPI/platform
device and the BIOS option to change this is hidden. In the mean
time I've gained quite a lot of experience with changing hidden
BIOS options though, so I can easily put it in PCI mode for
testing. But eventually we also need to tackle ACPI enumeration
support...

Anyways I've let me self get distracted (hobby time wise) by
looking into PMIC/charger/fuel-gauge issues on the Xiaomi Mi Pad 2.
I've made a list of 3 (small-ish) loose ends which I want to
tie up there and then I plan to start looking into atomisp2
support in my hobby time. ATM my plan is:

   -Test on T101HA to reproduce Mauro's work
   -Try to get things to work on the T116
   -Patch to not load atomisp_foo sensor drivers on !BYT && !CHT
   
And I've just added:

   -Try out BYT support 

As 4th item. Eventually I want to look into writing a proper
regulator driver for the PMICs and then try to make the atomisp2
code work with the non "atomisp_xxx" versions of the sensor drivers.

Regards,

Hans


