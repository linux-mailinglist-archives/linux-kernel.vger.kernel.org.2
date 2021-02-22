Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3C3219FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhBVOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhBVNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:43:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863E1C06178C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:40:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l12so19128330wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5qOMDXlKwKGSMV0dlhtm+r1Bnt4FJ+MlLzZVDJ1zkEc=;
        b=Mh/2qaQtNuQNMCkbqq+geipvjRWb70c42leZ19DU69VpYCGyx+NjV+iDpvYSFqciCK
         c2zHjXAVfUPW24qBAycBSICjQqrSfvU0IKGRf/sV5RuT1uX+h89hD7lRg8Sj4vvFVg8S
         lcbkCuLCIY682aZOxEUv7AYmH6VUadI1w6pYcMzfioD487441I/pQA9YwlDxCShXsKlz
         NUIJ9w6r42gf+UclKwVHqRGksoyRm5Bdd6EpKLzfXtCssNoiAqjKJ8zPQCkPKijfdERd
         vQOcjga4fRrCfcAoh21BDrSHSx/I1sJddbw291w5G+bnnMGvh7CU1jVUB2pqhKCMi4GD
         F6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5qOMDXlKwKGSMV0dlhtm+r1Bnt4FJ+MlLzZVDJ1zkEc=;
        b=VioCFQ2OI3v2ev7bMH66nZHIaC4tagnLyPjfvBKJcdKB7HWzTvd8PVhRKe/zSg4EYm
         ClSRWEm6j/prOqdKAaIyL5/IzXlVBr5dYNFNku+SEWWDZsWJ7zktAqboaHR+j9pDtAVa
         K6xYIQZ4i3NaPjHjxrxAfVuVFjQNYHIBEOmND9m47X/3LCF5cLuA355o0MnSqWkFQhve
         WcdPV18cj6Rbmy4uH5V3y6YWtMC4Yw6UHJ2D1HOPPIcjBnHHvvlBJj7DeKOy92zsVgX0
         SNd1tmw2FSG83F1cleGfQKgRCNeM9plCpKCaASPB7jKSsVXTOYSsnAM8eQ90M35qh3W7
         cuNA==
X-Gm-Message-State: AOAM5334nRilmiZQJYHVCaPbUwyz3K6Hl6VMP4TYPqEm9z+Hn01f1pJ2
        rx859uWdJvPYOO29jYCP6O5tLQ==
X-Google-Smtp-Source: ABdhPJw9RcE06nyg386pAnlKMsKfG97+mTmnmPYASTXN9C7glWlOgfek2esNfIW4y98mzcQ/Yw+TcA==
X-Received: by 2002:adf:8b0d:: with SMTP id n13mr22007529wra.94.1614001254340;
        Mon, 22 Feb 2021 05:40:54 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n10sm2189077wrt.83.2021.02.22.05.40.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 05:40:53 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <9a688b02-80a6-fb1f-d6fa-36ba2d88d3b9@linux.intel.com>
 <c6278763-57d9-2631-7b43-829259a9ea1f@linaro.org>
 <3ee60ad9-9635-649e-ba67-d40a96b25256@linux.intel.com>
 <487c91f9-f6ea-75c2-9150-52db2de42a3a@linaro.org>
 <eaf13d70-86fe-3e18-7a5a-4043f2d8a22d@linux.intel.com>
 <aaf34f07-5eed-3045-e4c6-dc9416689b20@linaro.org>
 <f960757f-ec8b-6d3f-f00e-27242c687926@linux.intel.com>
 <e962caa8-89c3-4a22-5932-4498c406e8f8@linaro.org>
 <adb91730-35db-db7a-75b3-4771723de945@linux.intel.com>
 <31ff9d2b-760a-374e-5b37-45d8e8116f7b@linaro.org>
 <20210201102709.GT2771@vkoul-mobl>
 <c8bb718d-c06d-2942-9c0b-2a6f97031e10@linaro.org>
 <64d2537a-bd60-e0a3-c4aa-4f802c34102b@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <caaca3cb-77b2-7137-3319-b0af887f563e@linaro.org>
Date:   Mon, 22 Feb 2021 13:40:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <64d2537a-bd60-e0a3-c4aa-4f802c34102b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/2021 19:52, Pierre-Louis Bossart wrote:
> 
> 
>>>>> It seems you are in a different solution-space, where the codec driver
>>>>> needs to notify the master of which ports it needs to use?
>>>> Correct! As Codec is the place where we have mixer controls ant it can
>>>> clearly tell which master ports should be used for that particular
>>>> configuration.
>>> And that should come from firmware (DT etc) and driver should pass on
>>> this info
>>
>> Are you okay with the patch as it is, provided this information is 
>> populated from DT?
> 
> I am fine with the direction at a high-level. The premise for SoundWire 
> is that the bus is simple enough that it can be used in different 
> contexts and architectures, so if Qualcomm need something that differs 
> from what is needed for Intel we are really not in a position to object.
> 
> That said, I could use more explanations on how the mapping is defined: 
> I don't think we have the same definition of 'static port mapping'. For 
> SDCA integration, we plan to have a static mapping in some sort of ACPI 
> table that will describe which port on the Manager side is connected to 
> which ports on Peripheral XYZ. That's static as in set in stone in 
> platform firmware. I understand the reference to DT settings as the same 
> idea.

Yes, we are talking about the same static mapping here!

> 
> But if the mapping depends on the value of mixer controls as you 
> describe it, then it's not static and defined by DT settings, but 
> run-time defined.
I think there is some miss understanding here, the mapping is static but 
the port selection is based on the mixer controls!

> 
> Also maybe we'd want to have a more opaque way of passing the 
> information, maybe with a stream private data or a callback, instead of 
> hard-coding fields that are only used by Qualcomm.

Let me try the callback way and see how it will endup!

thanks,
srini

> 
> 
