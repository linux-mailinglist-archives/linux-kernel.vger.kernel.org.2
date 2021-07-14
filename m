Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9833C8601
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhGNOZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231919AbhGNOZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626272546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+PCijAFK+zc4yebc2+Chhr3mPpRnKROJHkGBmiJexA=;
        b=daMsUFLrPw7y5v7SOmSJ/yNBp9uNJOuZzJfs/x7GH342EBBbnsHomUxI3TDiDMmmQOx5Ev
        tu6GNipa3f8ybti3oRlQAsUqzF/qsKsL92L/ptw5na9VHyguamITyIW2OrILfY0xFAc7ma
        8cQwSL9tVhCEETNMnEJv1NWajGEXHEE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-T2iSfuhhPDyRSfFNEziSig-1; Wed, 14 Jul 2021 10:22:25 -0400
X-MC-Unique: T2iSfuhhPDyRSfFNEziSig-1
Received: by mail-qv1-f69.google.com with SMTP id r13-20020a0cf60d0000b02902f3a4c41d77so1745079qvm.18
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M+PCijAFK+zc4yebc2+Chhr3mPpRnKROJHkGBmiJexA=;
        b=lBHMqrsRrFpykveMSEqkkf2DI4jtvFUiTc/io9guR6TlwDn41zJpbkXEkPvxOE/WG6
         9zHLdBa5NXlKz3F2D87WXcpyIEoUn/sTQscJZSa4DbgaJ9UjsPLdyMZEUKal/iOjMrTs
         c3G2zKNOYK4sHqzLnVFWBUNRdgxdLVoX32r/Dj1VsYjMuvV+i5waHgLjcKWe9oLITyiS
         8EhBatsuGqu5auYg+CQ1I6S6m4E2bx9ypBQBUmfLvcMvPyX2Pux6q0//r8aef29TBuT+
         oyE2Iig7s6FodsIs4nvPnCxaXBFRRVWdWX90dqN5tedpz0Wi0WBgrXspk4NZMKRh2taX
         B17g==
X-Gm-Message-State: AOAM531NsZC2yclIpGglV6HJO4qgMdMcxpS4b/qbPcAryisEcBUu/gNf
        PWSq1EG8Z1MjoSEg+r5ay7Isvf7lkIqyIGLa/yxy77upjL7c3DVTNgskONIdV2l+gQ+3cEZaVaC
        wcJczRgbMZn15rjjmJhn9qbaO
X-Received: by 2002:a37:cd0:: with SMTP id 199mr10167161qkm.69.1626272545192;
        Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIl4qQxdtL1RBVqFykTv9nwuH3HGdWbTZY5hynMAyEJAyRrYZKgBknquu9Xi3Ou9JMvCGkcA==
X-Received: by 2002:a37:cd0:: with SMTP id 199mr10167145qkm.69.1626272545038;
        Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f12sm1102779qke.37.2021.07.14.07.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 07:22:24 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] spi: spi-altera-dfl: support n5010 feature
 revision
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210705101645.2040106-1-martin@geanix.com>
 <20210705101645.2040106-3-martin@geanix.com>
 <d6250f86-db93-bcc2-d46e-6dba30976cc4@redhat.com>
 <f3bbe112-b105-07ac-9d2e-8ffc89c0a89c@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <99abfd17-4307-0b88-32a3-c80f61da587b@redhat.com>
Date:   Wed, 14 Jul 2021 07:22:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f3bbe112-b105-07ac-9d2e-8ffc89c0a89c@silicom.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/21 4:33 AM, Martin Hundebøll wrote:
>
>
> On 06/07/2021 16.56, Tom Rix wrote:
>>> diff --git a/drivers/spi/spi-altera-dfl.c 
>>> b/drivers/spi/spi-altera-dfl.c
>>> index 3e32e4fe5895..f6cf7c8d9dac 100644
>>> --- a/drivers/spi/spi-altera-dfl.c
>>> +++ b/drivers/spi/spi-altera-dfl.c
>>> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>>>       .chip_select = 0,
>>>   };
>>> +static struct spi_board_info m10_n5010_bmc_info = {
>>> +    .modalias = "m10-n5010",
>>> +    .max_speed_hz = 12500000,
>>> +    .bus_num = 0,
>>> +    .chip_select = 0,
>>> +};
>>
>> Other then the modalias, this is exactly the same as m10_bmc_info.
>>
>> Why not set platform_data?
>
> So like this?
>
> +static struct spi_board_info m10_n5010_bmc_info = {
> +    .platform_data = "m10-n5010",
> +    .max_speed_hz = 12500000,
> +    .bus_num = 0,
> +    .chip_select = 0,
> +};
>
> I don't see how that should improve the situation, but we might allocate
> the board info on the stack and set modalias dynamically instead?

No, I mean that instead of have two *bmc_info's generalize the existing one.

This could be done by using the as yet unused platform_data field to 
hold the identity as a bit/enum in an int.

Tom

>
> // Martin
>

