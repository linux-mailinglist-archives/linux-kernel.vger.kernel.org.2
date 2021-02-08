Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AA31408C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhBHUdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:33:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235054AbhBHTNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612811540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTiu3UzG/iGc9IqjW06TnQn3gQrqCGP+HJYPlasxAhM=;
        b=MZwBDViCa2t0Y5tvorH8hZAmx1C+GzR09n9CuJfKkx8p6LRr2HKRbpFZFxvQeJJ8jUsJiO
        rtOtcu6lUvUALaqKjYnwfXugUJErclyHz0VXpCeo+RPU0RdCcd015sKfTwSZ7hsG8Fam3G
        I4ep+rVSZX8YwDHbVafd9m4iJrPUHeU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-onL1xAbFP_2QgO8I8CSUkA-1; Mon, 08 Feb 2021 14:12:18 -0500
X-MC-Unique: onL1xAbFP_2QgO8I8CSUkA-1
Received: by mail-ej1-f71.google.com with SMTP id 7so3095399ejh.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 11:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sTiu3UzG/iGc9IqjW06TnQn3gQrqCGP+HJYPlasxAhM=;
        b=OLZ9fJA/oqPKGykF+2LRhpwgcswsn2S9HGgGk2GIii/NMzDwOR8uf/WA8itI4hWkO2
         YkSCkumxf8G8q0qGYfPmMXlaqlqrF7m4frS3VM+EcrVDRErBT20ZzvJ84o/RamTEBO63
         H6TphWBVFj2+bC+Mk9lWwtPSgFv2LXzj8J1A0NhwAF64DCfdlhLM9kNR2V2UWEDb9cE4
         R+foMlwzTJddKUQDCY4uKxTOQNdKe1W3ABgZYrjAypA/p+9V69AwW2ekqtp4ZOaMYIbE
         V2ib6W2/AsoxXqx/wkhhkk55GGHSToAYP2tfTaaFEWCU1EhfPe+rEQZGwRxUhOmuogRz
         RQPQ==
X-Gm-Message-State: AOAM531AlyQWGJSQEc7Duij5v6wcNX+0lrEKOeqhbW+DzDhU1KPpe46Q
        Hu8xvrnQJl8aYsu5cYPmBWD1zf9vBuV/7DBG7dgbBInAfU5aHBigmyP2mqd2hFEfhPbkUF3WZAo
        BbQO24S8UP3R8lqDSiRHZFJ+i
X-Received: by 2002:aa7:d808:: with SMTP id v8mr18651975edq.380.1612811537081;
        Mon, 08 Feb 2021 11:12:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLtw3J8PubnCu1t850YVdWN9lEvlS4rw9kSNrlLF1jcKCDScRdW0yMp3uB4RjVlOi25gLdKg==
X-Received: by 2002:aa7:d808:: with SMTP id v8mr18651957edq.380.1612811536950;
        Mon, 08 Feb 2021 11:12:16 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lc11sm4006899ejc.95.2021.02.08.11.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 11:12:16 -0800 (PST)
Subject: Re: (subset) [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail
 boards with WM5102 codec
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        patches@opensource.cirrus.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <161280948306.10741.6212553639750410303.b4-ty@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1d5ca89f-8862-cdb7-838e-350e178915e1@redhat.com>
Date:   Mon, 8 Feb 2021 20:12:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <161280948306.10741.6212553639750410303.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2/8/21 7:38 PM, Mark Brown wrote:
> On Wed, 20 Jan 2021 22:49:52 +0100, Hans de Goede wrote:
>> Here is v4 of my series to add support for Intel Bay Trail based devices
>> which use a WM5102 codec for audio output/input.
>>
>> This was developed and tested on a Lenovo Yoga Tablet 1051L.
>>
>> The MFD and ASoC parts do not have any build-time dependencies
>> on each other. But the follow-up jack-detect series does have
>> patches depending on each-other and on this series. So IMHO it
>> would be best if this entire series would be merged through the
>> MFD tree to make merging the follow-up series easier.
>>
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [4/5] ASoC: Intel: Add DMI quirk table to soc_intel_is_byt_cr()
>       commit: 8ade6d8b02b1ead741bd4f6c42921035caab6560
> [5/5] ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102
>       commit: 9a87fc1e061900e81ab13d823e85012a78849244

Thank you.

Regards,

Hans

