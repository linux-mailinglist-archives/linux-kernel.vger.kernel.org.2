Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DAB3AA2F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFPSPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230055AbhFPSPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623867218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2ZgS+GCY+zeGtNmbikEY7JDq0qDESkYvLCgyzZHxds=;
        b=gJj7F+4osYo9W/2PySYTDpxbEUBbvKGUKXudluqjW7zsaCycUVFLG7g8eAKmgR3h8UIO/r
        s/YtnB8V5gPlwBN2K387kmRtdToWx/NgTK79dfp8xFh9UYrISGcyHb3bNPNPBZn09+RX4V
        heRGEtF0VHKza9iQ3hggaNtl0dK/pcg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-f4iwcH47M0S-zxvuwIyf3g-1; Wed, 16 Jun 2021 14:13:37 -0400
X-MC-Unique: f4iwcH47M0S-zxvuwIyf3g-1
Received: by mail-ed1-f71.google.com with SMTP id x8-20020aa7d3880000b029038fe468f5f4so137090edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2ZgS+GCY+zeGtNmbikEY7JDq0qDESkYvLCgyzZHxds=;
        b=t7TBax6lHTwZ9Sruhz5Gsb2WcVs0C2EwsO2P48EmT0nELFqmAEjq06QbCjosHse3hy
         afHJ4tQugpVx8vb+Eu5RfXv8D+24s8C+YbBldRJ0Emo5j/cwiCQ3ri47Mxf8bK8ZNtiP
         ZYfViWn2M5nl5SAOuUQiM01QWLpDNPlcY3yfcWSaLOISWeAEJeCTZuoC+PLs8o4w2eQm
         p7+Ueg2YPmZeCFnruhOZXtxmbSV817+p4Xxgo9RBX5v0FK6vITwaxYj+za1DfERr+f7/
         0CcuXwbAw87P5OORz5ZjtEvS2dho1qNmfWsalkWwIaISNQ5w58yI4gfHvn+mzkZGfTdN
         sfPg==
X-Gm-Message-State: AOAM533bPGKz2kfTWI1mC/YFIXXI7nsDXFT2fPHAUeAIJl53349ZdoOx
        iA5SBPOvCmKhWPIOwjlop3ukC2lSRSRgKcoNfkS9VegDabJqh5GNUOpBScuvgzJIffzy/R2m96G
        oNOh7415YSk934MNcO0cUGacy
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr1297300edy.32.1623867216491;
        Wed, 16 Jun 2021 11:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9vMHLTBq5mDNxgautgv3pvtkh5NJQutUbOxh1CWqXkx9hBbr+BTgHCyzxPgjYIs3J1MTEVA==
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr1297274edy.32.1623867216371;
        Wed, 16 Jun 2021 11:13:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l26sm2498581edt.40.2021.06.16.11.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 11:13:36 -0700 (PDT)
Subject: Re: [PATCH v5 5/6] platform/x86: Add intel_skl_int3472 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
References: <20210603224007.120560-1-djrscally@gmail.com>
 <20210603224007.120560-6-djrscally@gmail.com>
 <ea322abe-fa78-bbc3-b4c5-b372a4f28235@redhat.com>
 <CAHp75VccZbv8+u-jO8wYSsyQrw+Bd_zeDa==aiTvkh=fteuT3w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0991caf2-1b7b-c8b5-8558-03b8f0dbb604@redhat.com>
Date:   Wed, 16 Jun 2021 20:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VccZbv8+u-jO8wYSsyQrw+Bd_zeDa==aiTvkh=fteuT3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/21 8:08 PM, Andy Shevchenko wrote:
> On Wed, Jun 16, 2021 at 8:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 6/4/21 12:40 AM, Daniel Scally wrote:
>>> ACPI devices with _HID INT3472 are currently matched to the tps68470
>>> driver, however this does not cover all situations in which that _HID
>>> occurs. We've encountered three possibilities:
>>>
>>> 1. On Chrome OS devices, an ACPI device with _HID INT3472 (representing
>>> a physical TPS68470 device) that requires a GPIO and OpRegion driver
>>> 2. On devices designed for Windows, an ACPI device with _HID INT3472
>>> (again representing a physical TPS68470 device) which requires GPIO,
>>> Clock and Regulator drivers.
>>> 3. On other devices designed for Windows, an ACPI device with _HID
>>> INT3472 which does **not** represent a physical TPS68470, and is instead
>>> used as a dummy device to group some system GPIO lines which are meant
>>> to be consumed by the sensor that is dependent on this entry.
>>>
>>> This commit adds a new module, registering a platform driver to deal
>>> with the 3rd scenario plus an i2c driver to deal with #1 and #2, by
>>> querying the CLDB buffer found against INT3472 entries to determine
>>> which is most appropriate.
>>>
>>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>>
>> Thank you for your patch, I've applied this patch to my review-hans
>> branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>> I've fixed up the missing static marking of skl_int3472_tps68470_calc_type()
>> spotted by lkp@intel.com while applying the patch to my tree.
> 
> Are you going to apply patch 6 as well?
> IIRC it's acked by Lee.

Ah you are right, it is Acked, but I'm not sure if that ack was for
Lee being ok with it being merged through the pdx86 tree. I'll coordinate
this with Lee off list.

Regards,

Hans

