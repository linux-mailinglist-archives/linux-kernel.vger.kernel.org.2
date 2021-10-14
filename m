Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AFB42D72B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJNKcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:32:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3F5C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:30:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i12so17873928wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=us6+HCE+GUwum0s7he3QqgDzEk4c+WE4j1FhKg15OwQ=;
        b=Ghe4/en6QpzuPARQaskuM409QmklUAvGw+F17sjWiRaNSofRKr4Z0gvgfW4hoY+Az0
         0eWxBA2OLajwd6HR+JbSI1I4Gsr/7WxKQEU+OTt57uVFSXh7rQToDWni4J+2MLVeJK9q
         TrYjmBzX+ariMNhef5xZ2geesmOnkvHajZq9L2qZkjMLlsBbhbEm6/PHmG9kxhr11I0A
         PSFq0SIx9UtB3DwjXsKvrnnFWePx50jo8y+Z4iysgAAIXOl+PnLUJ3q7H3vpPz5ABi8T
         +Nlz5lqy6COrNeOoD3A8riVSDIIHKDWKFDenDXSddjVFXRlwl+dOzRwwDqPW88N2l91e
         dbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=us6+HCE+GUwum0s7he3QqgDzEk4c+WE4j1FhKg15OwQ=;
        b=3CuQ1T5gwhlD9QYLpgOqGt4Hjvi3tNOuUGfJsXVg6wCceeR7yyrQO1vzqXL1PHrVqF
         gOJ63EUuzH9ckKcDemZNqR+XtSJaRkxu0h6mL5Y500ATyMqIrVqZF/hQBKB3K9glkHyl
         eWW5NKOKzBr8mNpe/h1zIlXL+ZiD+/JrHGiZsg2tDrKexI+8dWiuZb15JBwACuB38GqS
         maIsrCJ2GxvmKd7zzkmdNQcvrRPknSBY4q18vCqFuGUIHHwM9VjIADuvAbV8Kpl2dxCW
         zmVci7jtHXnRb4OPR0aycepQ6Qd1o/tLSym9KrN5Pa8e+H7ORAMMUesjqnY0/KQgJ2Bn
         tygQ==
X-Gm-Message-State: AOAM530eSqMDn+/Jgqjno5IUPDXgY1xMvp0Y7m+GkScEzdTM6n6zVXno
        SV4JYn2jYQ0UqoWJsk7Tp4x+rw==
X-Google-Smtp-Source: ABdhPJw+YOMsuTTrRgZkFZDux7XgVNdWOpK/aaniXEYtjjI2eu73YUhLPxHoRc0c/ssQtITjRv9Cuw==
X-Received: by 2002:adf:9787:: with SMTP id s7mr5493617wrb.191.1634207414553;
        Thu, 14 Oct 2021 03:30:14 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id o26sm7697211wmc.17.2021.10.14.03.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 03:30:14 -0700 (PDT)
Subject: Re: [PATCH RFC linux] dt-bindings: nvmem: Add binding for U-Boot
 environment NVMEM provider
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Luka Kovacic <luka.kovacic@sartura.hr>
References: <20211013232048.16559-1-kabel@kernel.org>
 <629c8ba1-c924-565f-0b3c-8b625f4e5fb0@linaro.org>
 <20211014120601.133e9a84@dellmb>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <857c27a6-5c4b-e0ed-a830-35762799613f@linaro.org>
Date:   Thu, 14 Oct 2021 11:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014120601.133e9a84@dellmb>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/10/2021 11:06, Marek Behún wrote:
> On Thu, 14 Oct 2021 09:26:27 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
>> On 14/10/2021 00:20, Marek Behún wrote:
>>> Add device tree bindings for U-Boot environment NVMEM provider.
>>>
>>> U-Boot environment can be stored at a specific offset of a MTD
>>> device, EEPROM, MMC, NAND or SATA device, on an UBI volume, or in a
>>> file on a filesystem.
>>>
>>> The environment can contain information such as device's MAC
>>> address, which should be used by the ethernet controller node.
>>>    
>>
>> Have you looked at
>> ./Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml ?
> 
> Hello srini,
> 
> yes, I have. What about it? :)
> 
> That binding won't work for u-boot-env, because the data are stored
> in a different way. A cell does not have a constant predetermined
> offset on the MTD.

Can't you dynamically update the nodes before nvmem-provider is registered?

> The variables are stored as a sequence of values of format
> "name=value", separated by '\0's, for example:
>    board=turris_mox\0ethaddr=00:11:22:33:44:55\0bootcmd=run distro_bootcmd\0....
> Chaning lengths of values of variables, or deleting variables, moves
> the data around. Integers and MAC addresses are stored as strings, and so on.
> 

Do you already have a provider driver for handing this.

How is pre parsing cell info and post processing data planned to be handled?

Currently in nvmem core we do check for "reg" property for each cell, 
unless the provider driver is adding/updating dt entries dynamically 
before registering nvmem provider, It will not work as it is. Alteast 
this is what I suggested in similar case where cell information is in 
tlv format.

Secondly mac-address seems to be delimited, we recently introduced post 
processing callback for provider driver [1], which should help in this case.

If the nvmem-cell names are standard like "mac-address" then you do not 
need to add a new "type" binding to cell too, you can do post-processing 
based on name.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/nvmem/imx-ocotp.c?id=823571f8c6f8968d8f14e91972fa350ce200f5db


--srini

> Also the mtd/partitions/nvmem-cells.yaml doesn't take into account
> u-boot-env stored on non-MTD devices.
> 
> Marek
> 
>    
> 
