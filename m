Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D0428201
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhJJO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhJJO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 10:58:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE974C061570;
        Sun, 10 Oct 2021 07:56:03 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k2-20020a056830168200b0054e523d242aso8772709otr.6;
        Sun, 10 Oct 2021 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I4jCJS90Gz2JHsm2ZZk4sJXD8ATVF4qZO2QfZKsg3r4=;
        b=WfmXYTZRRkJH6iit/65AqwC0WYNTURSv/Q2i3Zp431s7HsDVv8ztvnWn3NemmnGrZL
         67MpeihXd7KOGDYNw7Cz7DHq5X+SyoqHiCW62HIyxSRvV/CeYYFJo8MnPDPd48OHKCxj
         T2k5V23ZP2c0nxCEYY4+jiEHTQnLOE5boxU6J8bKLx5/OCVRcoSwt6tKJE4yYZYPl76H
         j5SXvdI/bu6AF2pMY/tOaOWxV7SLXRfGej0foJPO44CXUie3HYhZKUxGT/7p+0QDDfzN
         o0brkGAW2GblDSDWf9FUtg542mTUm8HEx72uxbH+7plMnTOo9s/NCZuu7p1CAHY0gqxH
         m17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4jCJS90Gz2JHsm2ZZk4sJXD8ATVF4qZO2QfZKsg3r4=;
        b=wRNUMtnJ/AHxhvIpyyws4/qbKgXMrggrVI4v4OhaLDPxUlm4b1gU9xJ17asXmxN+/8
         9TbDyCjVge/ftXDaHMYemm+VWnGMceMPN81smYseJ1pde8wqw6tOe5TIa24AiYLdn2h4
         wQaObCdbsN57w3CfaaLtba6vUNhu+bpZWC8jo0+HIldW/e1VkoOn6yNng8PaQes+/X8/
         gbcwIznrWEGCDaUZ7l5aFtG8A551ay92ASRFWY73PLPABv/vDS0SGkbxjAL7CrqciGis
         5h1ZYxsvyJmHKovwgpBrf7Vzydug5lCgVl90ZGxuv0uzvLEMCMKxB1JtPJViHYQyrcjP
         /7IQ==
X-Gm-Message-State: AOAM531diBz9V+SQABUtsEafSe02avZAAsHRpWb+BJOOICo5GV7q3al5
        7579echM6/Awu4SsFzgl1xo1mOwWhtk=
X-Google-Smtp-Source: ABdhPJzch+nEh1pNMCUTu9ExCIkHHYBA9h67AL2r4gVVdGqs2W64v6E0D/58zcgZ2vBz0JJxsAPyvQ==
X-Received: by 2002:a05:6830:2805:: with SMTP id w5mr17480753otu.248.1633877762504;
        Sun, 10 Oct 2021 07:56:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13sm1183953otf.3.2021.10.10.07.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 07:56:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Denis Pauk <pauk.denis@gmail.com>, eugene.shalygin@gmail.com,
        andy.shevchenko@gmail.com, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211010095216.25115-1-pauk.denis@gmail.com>
 <20211010095216.25115-3-pauk.denis@gmail.com>
 <0a037ce5-87bb-4aad-a30a-d954ff0910a7@t-8ch.de>
 <7658358e-5ba6-b764-463c-317f5b318707@roeck-us.net>
 <13b23940-88d9-4c72-a55b-a66e8c8edffb@t-8ch.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/2] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
Message-ID: <e25063b9-634b-3f56-bcaf-77d8526b9a67@roeck-us.net>
Date:   Sun, 10 Oct 2021 07:56:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <13b23940-88d9-4c72-a55b-a66e8c8edffb@t-8ch.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 7:10 AM, Thomas Weißschuh wrote:
> On 2021-10-10T06:38-0700, Guenter Roeck wrote:
>> On 10/10/21 3:20 AM, Thomas Weißschuh wrote:
>>> Hi,
>>>
>>> for WMI drivers the list platform-driver-x86@vger.kernel.org should probably be
>>> on CC too.
>>> Also all other WMI drivers, even for hwmon stuff are located in
>>> drivers/platform/x86 so it may be better to put it there, too.
>>>
>>
>> Not really. If any of those other drivers are pure hwmon drivers, they
>> should reside in drivers/hwmon instead. And, yes, that really includes
>> the gigabyte-wmi driver. We don't have arbitrary drivers in drivers/pci
>> either just because they are drivers for pci devices.
> 
> Fair enough.
> I suppose it would be too much churn to move gigabyte-wmi to
> hwmon now though, correct?
> 

Is it ? I don't recall the reason why it was added to drivers/platform/x86
in the first place. I see other single-use wmi drivers in that directory
as well (eg xiaomi-wmi, which should be in input). Is there some unwritten
rule stating that all wmi drivers shall reside in drivers/platform/x86,
no matter what subsystem they touch ?

> Having the platform-driver-x86 on Cc would still be useful as they can provide
> guidance about using the ACPI/WMI/platform APIs.
> 

Sure, but that is unrelated to the driver location, and the opposite argument
can be made as well (that drivers implementing subsystem code should be reviewed
by subsystem maintainers). That is a much stronger argument in my opinion.

Guenter

> For example by using the WMI bus as mentioned in my other mail would allow
> to completely remove the manually maintained DMI list and instead directly bind
> to the WMI GUID for any device that supports this GUID.
> (This is possible as this WMI API seems to be self-describing, so all
> specific parameters can be discovered by the driver)
> 
> Thomas
> 

