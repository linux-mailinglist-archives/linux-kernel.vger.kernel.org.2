Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FA409734
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhIMPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345672AbhIMPYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:24:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A4C03D413
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 07:20:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g16so15012149wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O8wS1+sNPRvLr9/odqtW8j5vtaz640FsxM1Sy4aZraE=;
        b=zUBlJhHnIxCu1VQebaWtOTcojpoxcqf8Qil1UfYKUm269Nj4QGsIrqfFUPEKCgOCvj
         YKKwj5PXov8glQvMvfwiPlTQNBAZLjHvRykWxxcjPO+B5LeEAXV+CF0JniLntM/XXp8a
         qDzd0LGSnT4rhQzdHvVuwFOuGZpcZzmTjO6WUUZxcoeWqBZISAJJWDCnGtsOQ77xjPXW
         ZXpqOEBrve0eO1b6ZI6o4HS1umsI28TXB36MBOhTaeJf1AeCxmV4kFX7cLi4pJ3+lT53
         T4wUAXA5CIFSIOG6wgxMaDZWw7Nj0s2NeYAxCQE+G2uQw4CQYGQmLfacwmFFkYLCObIm
         C39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O8wS1+sNPRvLr9/odqtW8j5vtaz640FsxM1Sy4aZraE=;
        b=YcbmDctTw0cIjD719uW9ZSgpfC8pH8r7lx1C0wWEDDNQbQ7aTGU5lw3cR6HXzNNuV3
         k7bxtdiC5eUaIHt0+vlGl0NW7cZ7YN2MtaiqZn1PWKUJBrT9Bw7zNDv5F48Mpml+RdUJ
         LEyZVsBxL+U4CxLC+VcHSYhj/Zv9cLKg/+s3s7CVJ50x4d/vyYLNdtDXajeTkVz67pNy
         zRP/YZTbD8+2KnsCXRIamhaZnm/g1ZEu9HTj6m4pdMcij9WGEYRY1PvuOhO+JLgtmvvH
         V4CCG6g6epZy1nQFHKgBvPsJlukXSF0IFR6+GAC9q+Cfl6O/nFbd3q8fBRZhIvFLYzxL
         N3DA==
X-Gm-Message-State: AOAM532I+8W/QcZ16J6g2TcSktbcLs5u0f+GCQCgblV/qduOO0mcsj6a
        OUMkAyLGye3wrzxzpVQ3XDOZ0+wtDMmFdQ==
X-Google-Smtp-Source: ABdhPJzMHe5HCthXhhGzcU/HUaYAkZHU7J7+wRvuKVdeLuGClMUEH72WUtiPwg/TRe6z7s0Aap1rbg==
X-Received: by 2002:adf:916f:: with SMTP id j102mr12802317wrj.422.1631542805025;
        Mon, 13 Sep 2021 07:20:05 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id b16sm7688776wrp.82.2021.09.13.07.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 07:20:04 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvmem: add ONIE nvmem cells parser
To:     John Thomson <lists@johnthomson.fastmail.com.au>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-4-vadym.kochan@plvision.eu>
 <b54325f156eaaa6535667a1a7fb695c7688d2db4.camel@pengutronix.de>
 <vrcxh2wnnrl7a7.fsf@plvision.eu>
 <7d1a7607-15fc-4dd6-9317-c6161c4984db@www.fastmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ceaf0e29-2306-37af-f170-281d7c097fad@linaro.org>
Date:   Mon, 13 Sep 2021 15:20:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7d1a7607-15fc-4dd6-9317-c6161c4984db@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2021 22:06, John Thomson wrote:
> Hi Vadym,
> 
> On Wed, 8 Sep 2021, at 09:56, Vadym Kochan wrote:
>>
>> Hi Jan,
>>
>> Jan Lübbe <jlu@pengutronix.de> writes:
> …
>>
>>> I think it would be useful to have a way to express this setup for systems with
>>> many interfaces, but am unsure of where this should be described. Maybe a "mac-
>>> address-offset" property in the generic ethernet controller binding?
>>>
>>> Regards,
>>> Jan
>>
>> May be something like eth_address_provider should be introduced in
>> net/ethernet/ ?
>>
>> This provider can provide something like eth_provider_address_next() which
>> will consider "mac-address-num" (or other specific fields).
>>
> 
> A patch series proposed the devicetree property
> mac-address-increment, but it did not get support at the time:

Please have a look at some recent nvmem patches 
https://lkml.org/lkml/2021/9/8/270 that adds support for vendor specific 
post-processing of nvmem-cells.

Am hoping that increment usecase (along with other variants) should also 
be dealt in similar way.


--srini
> of_net: add mac-address-increment support
> https://lore.kernel.org/all/20200920095724.8251-4-ansuelsmth@gmail.com/
> dt-bindings: net: Document use of mac-address-increment
> https://lore.kernel.org/all/20200920095724.8251-5-ansuelsmth@gmail.com/
> 



> Cheers,
> 
