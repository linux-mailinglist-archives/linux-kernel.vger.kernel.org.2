Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6057838B3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhETQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhETQDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:03:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D8C061760
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:02:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so18214025wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kI0h2gVSUj9JWqorLy8/VvL2RU0jPQm/IzG0Q3Yviek=;
        b=zA2v7Id9RNtXBF1yfPJZXWmlZzKpRxIluaZ+MJG4ysFRqhuqV9gtxi8W0FTlb8w5vs
         mOn5gzPyeakHxZm6gnTCx2RgLqjO7vCnILfN2PTN4jFQXm+dyJIlwBs0hAwUR2xzW5ZW
         YtB53Z7Js8Aha5NVL2BLuOY/+VqqJ14T/75cuvmost68QSlUyp/CFFma5zhLIUkpbbnN
         Bv5sVWiVRFfjMbSwza/onKX4zfNRJ5qBSDxUlLclEC7HOShSI3x3WaRE5ZA6eKhi9YXL
         2EU4E3pA+T8uzDPZHy2pEBtP8OSPfwmbd1BZgpL6ITrUGIrJA78OuCvQ/8zxUDsLm0TE
         ONMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kI0h2gVSUj9JWqorLy8/VvL2RU0jPQm/IzG0Q3Yviek=;
        b=ae8e/+cMa0nS49YeI343QIH/AqCE/x0uVfEYC6X6pSgmA1s46TC57O6PeTxvY2GODv
         +mH9FOatweaW0inoMqH/XuU04ApKKcVHx46+kwlLUVICnY4Izx1MFBnXqZrQgAopW8XM
         qbTAWBcUhcg75u6ZdI8JdQHwjjzdDUjIwmKCXa5HF8mqrsxdeOXIXs36MTqPGkqpWmuV
         yabT2E7KsqUdonzG4NLvL+qQI65vI0r6/XrtzzOM57JLZvwIn3J3B2MssJyF70YM/pOw
         XqTBNhxWtp9EHm9cyA8C7C5tSG4xfp3Eq1dgaSV1BM4L9snC25ZnbHDXHjAO66IZxbV7
         ZemQ==
X-Gm-Message-State: AOAM533MAA0Myr5QwHZtVH+Ny0DQCINoYkFDYICx1OF6UM0PXeuaD0Eh
        XQutOBn7XqKna8k5JCeSvKppsA==
X-Google-Smtp-Source: ABdhPJxgQAwFG5+mH7h5jPT67M2rVkEPPjlqDBRPWJAWkDvOx5Hw09oefZRhL1be3OStGsdJWAT/UQ==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr5047900wro.408.1621526521508;
        Thu, 20 May 2021 09:02:01 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:d88a:b479:b222:83bb? ([2a01:e0a:90c:e290:d88a:b479:b222:83bb])
        by smtp.gmail.com with ESMTPSA id q3sm3518095wrr.43.2021.05.20.09.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 09:02:01 -0700 (PDT)
Subject: Re: [PATCH 0/3] tty: serial: meson: add amlogic,uart-fifosize
 property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
 <9c6ce679-1721-be40-c1b2-6ae90503d2cb@baylibre.com>
 <YKZt7lCBhesXzoQP@kroah.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9f4f2dce-79ce-bef5-0725-2e3cbf530999@baylibre.com>
Date:   Thu, 20 May 2021 18:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKZt7lCBhesXzoQP@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2021 16:10, Greg KH wrote:
> On Thu, May 20, 2021 at 03:55:35PM +0200, Neil Armstrong wrote:
>> Hi Greg,
>>
>> On 18/05/2021 09:58, Neil Armstrong wrote:
>>> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
>>> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
>>> a different FIFO size from the other ports (64bytes).
>>>
>>> This adds a property in the bindings, reads the property from the driver and updates
>>> the DT with the new property.
>>>
>>> Changes since v2:
>>> - removed spurious blank line from bindings
>>>
>>> Changes since v1:
>>> - switched to a more generic "fifo-size"
>>>
>>> Neil Armstrong (3):
>>>   dt-bindings: serial: amlogic,meson-uart: add fifo-size property
>>>   tty: serial: meson: retrieve port FIFO size from DT
>>>   arm64: dts: meson: set 128bytes FIFO size on uart A
>>>
>>>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
>>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   | 1 +
>>>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi            | 1 +
>>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 1 +
>>>  drivers/tty/serial/meson_uart.c                              | 5 ++++-
>>>  5 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>
>> Could you apply patches 1 & 2 ?
> 
> Sure, will go do so now...
> 

thanks !

Neil
