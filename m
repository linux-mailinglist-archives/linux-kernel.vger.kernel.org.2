Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF443DD30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1Iyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1Iyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:54:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85C7C061570;
        Thu, 28 Oct 2021 01:52:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d3so8801702wrh.8;
        Thu, 28 Oct 2021 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tzu0RNNBTPaqNsLe02IxHPLyiJxwWMpn9+HjYr+hVDU=;
        b=T4qN1O1lMD+uikVnWV32oFYJU2Log7q4Fb17glFo27AgKpBXRISXOJg1ebLkyumr98
         pDgyctp7tUwMWZS15GR5anXhzzgEZNOg1hz7Q9wcnW6AFcuuZi0gwckfIeJpYBM+/xjP
         TxNgojWvbZg02a9+gF3cvtft3zHUXeBV0cW1PCsmTEVMB5Xcr4AhhlqFQjReTCFJd68p
         Y9fVKepWQdhS9gF19GgY0pFli2oihlreWaTtkUxsWY1zBIjrvGjz4c09FEYYrEF30UF8
         aU6seeGV804eEpAq3IVYaTHt8zvzdylJImOqIUHa6jrZfCiPi52FfXtmFJNKUJEH6cjU
         91cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tzu0RNNBTPaqNsLe02IxHPLyiJxwWMpn9+HjYr+hVDU=;
        b=YxRJMadSpp+G19uZvFmn8HuV3jiumG5NMDWBS84U0gH8THlnakWdsj3I8jwAJf9ZkK
         w4sibx7p3jlZNGCfJzX+Iw44AZMPmaYYi/Cr7ocaFH+sArLJnqiK/lwHP3tKcWxDGC4W
         TlxXEBnztq+rMDo0xljtQCtuRD1YwOvHMtOBlOM5x8wKOagwc4av5odQv8TbiqmZFG8P
         wuGKGBJo3euaT0bJD2O80avzvP+XyRqZ0R0maoVIWCaIrTLKwNJhI02sZpmYB4/bBpd5
         PRTJC4Ct4Ro19wGMcfzHyzP8KiJQKXZzszyGzYxZEc6MT0pgc9AngxzCHnpDqfw9ZKmI
         Miyg==
X-Gm-Message-State: AOAM533mMLuKofLXdRA4orKjGEA7gcftUGM9F7zh7KXTs1pRFdOl1VHT
        xTobXyMBPEyFpDz9zIMzXRY=
X-Google-Smtp-Source: ABdhPJw1mp5/RlztuKN6Y0E1V0XcKAcPG6yl/I5JbL4Ry2CHscU4CheEMpuOfOzbRDMmBRRSX4nCQw==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr3862509wrn.291.1635411142257;
        Thu, 28 Oct 2021 01:52:22 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a5e1.dip0.t-ipconnect.de. [217.229.165.225])
        by smtp.gmail.com with ESMTPSA id k21sm1908713wmj.45.2021.10.28.01.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 01:52:21 -0700 (PDT)
Message-ID: <9f60df78-d32b-c622-1c0d-7c55d1aa1d10@gmail.com>
Date:   Thu, 28 Oct 2021 10:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] platform/surface: aggregator_registry: Add initial
 support for Surface Pro 8
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
References: <20211028012845.1887219-1-luzmaximilian@gmail.com>
 <f7ac5427-b03a-2d3a-3255-e37ba9b15dcd@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <f7ac5427-b03a-2d3a-3255-e37ba9b15dcd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/21 09:58, Hans de Goede wrote:
> Hi Maximilian,
> 
> On 10/28/21 03:28, Maximilian Luz wrote:
>> Add preliminary support for the Surface Pro 8 to the Surface Aggregator
>> registry. This includes battery/charger status and platform profile
>> support.
>>
>> In contrast to earlier Surface Pro generations, the keyboard cover is
>> now also connected via the Surface Aggregator Module (whereas it was
>> previously connected via USB or HID-over-I2C). To properly support the
>> HID devices of that cover, however, more changes regarding hot-removal
>> of Surface Aggregator client devices as well as a new device hub driver
>> are required. We will address those things in a follow-up series, so do
>> not add any HID device IDs just yet.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Since it is just device-id additions I can still pick this up for
> 5.16 if you want / if this is useful.
> 
> Do you want me to pick this up for 5.16 ?

Hmm, usefulness is somewhat limited, because the device currently has
neither touchscreen nor keyboard cover support, so external peripherals
are required.

I think including it might still be a good idea though because it at
least makes that scenario somewhat viable by providing battery stats.

Thanks,
Max

> Regards,
> 
> Hans
> 
> 
> 
>> ---
>>   .../platform/surface/surface_aggregator_registry.c   | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
>> index 2e0d3a808d47..ce2bd88feeaa 100644
>> --- a/drivers/platform/surface/surface_aggregator_registry.c
>> +++ b/drivers/platform/surface/surface_aggregator_registry.c
>> @@ -228,6 +228,15 @@ static const struct software_node *ssam_node_group_sp7[] = {
>>   	NULL,
>>   };
>>   
>> +static const struct software_node *ssam_node_group_sp8[] = {
>> +	&ssam_node_root,
>> +	&ssam_node_bat_ac,
>> +	&ssam_node_bat_main,
>> +	&ssam_node_tmp_pprof,
>> +	/* TODO: Add support for keyboard cover. */
>> +	NULL,
>> +};
>> +
>>   
>>   /* -- Device registry helper functions. ------------------------------------- */
>>   
>> @@ -520,6 +529,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
>>   	/* Surface Pro 7+ */
>>   	{ "MSHW0119", (unsigned long)ssam_node_group_sp7 },
>>   
>> +	/* Surface Pro 8 */
>> +	{ "MSHW0263", (unsigned long)ssam_node_group_sp8 },
>> +
>>   	/* Surface Book 2 */
>>   	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
>>   
>>
> 
