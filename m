Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF5361D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbhDPJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhDPJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:34:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:33:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c15so17076210wro.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6UyUK/PLZR7RRPxa5IwMOvQk8P6IAfMpv+pLHnWIWk=;
        b=QZQkZJdBI8z4aSv5GPjE/sdUZF5KNDwCq5LFScZU1aQwxesSrQTgs2rloNEdifvRkG
         kutHzoba1sPCUsWxZjyPd2edgncUU/2Qdt9sFwNZxbEF/1AErUeJce7TeCo0pSweY58F
         sRTu860WAz3M8uM6/XAdDMy37xtCeDXbzcYA4VB33RITm7AgkBtdz6HoJzEcpvxdPbLG
         6VszU67q5srWYwsySecPDR5vGbtoUxsQgBhu1aR08i9iuDhhJLiIrAbvsw6Jp+K38Pnf
         O0fxY7RTMTlhQ6p9NrrYcoaNPcY6+cIWLP6ln+KF4a9iWUuZqCUIWK/lyj7Occ3Y3Hwz
         bTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y6UyUK/PLZR7RRPxa5IwMOvQk8P6IAfMpv+pLHnWIWk=;
        b=q+ADfuILfoyLm7mm3yGt51tqjEadtCjTThoLM8iIu8uygH4yDZZe9H6nAwM+HvcGGd
         cR8UwJBJtiGgnit6f2xcxHOIq/i9Q3JEqhRVeAD4Pv7nMry7Z0gNINJQMVcp2zNVSVos
         Ubsi/CHmN93iVi4GX4oc1Nhp53PBCr751qC3JajyaH/O3eY+5crDowWwJ9Z6AietvDYN
         mEvHnAQh0MWwFcFHnqqeKWFOSqKEuiWjSmsBKyONnfKE6JxZ11clcDTdSEPWyHGvwoV4
         PJZ4rUgYLueLfeAcOgrLMHKpgKlKq+1g9zoIzZK2Hr8vVPbQWaA3Jq2B6GHM2Yv6WLBA
         CdjA==
X-Gm-Message-State: AOAM530KyX0Wa1Tnh++YguI9JoawGu8GW2MnhFHFSPILuzXM+6zZnnnd
        AFejSWyjVxQUM0bgSTiUZMlsiA==
X-Google-Smtp-Source: ABdhPJyi9TudN5b27GdAZGQawwbe7hN4TWTVODnrXz7f90bs+B7teKNt5eKgfJN+j0eEBk4vPKX/tg==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr8068180wrx.241.1618565615984;
        Fri, 16 Apr 2021 02:33:35 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7? ([2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7])
        by smtp.gmail.com with ESMTPSA id s14sm9473716wrm.51.2021.04.16.02.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 02:33:35 -0700 (PDT)
Subject: Re: [PATCH] mmc: meson-gx: remove useless warning about scatterlist
 size alignment in block mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Lebed <lebed.dmitry@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414100010.3877669-1-narmstrong@baylibre.com>
 <CAPDyKFpNLu3R+7ODZaC7yWMYbSOujswgLTkN97FQNg5zhwSxgw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ff1d8605-4f45-c272-9bd6-e55ea8a9c68c@baylibre.com>
Date:   Fri, 16 Apr 2021 11:33:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpNLu3R+7ODZaC7yWMYbSOujswgLTkN97FQNg5zhwSxgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2021 11:07, Ulf Hansson wrote:
> On Wed, 14 Apr 2021 at 12:00, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Since commit e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode"),
>> support for SDIO SD_IO_RW_EXTENDED transferts are properly filtered but some driver
>> like brcmfmac still gives a block sg buffer size not aligned with SDIO block,
>> triggerring a warning even if the transfer works in degraded mode.
>>
>> This should be ultimately fixed in brcmfmac, but since it's only a performance issue
>> the warning should be removed.
>>
>> Fixes: e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode")
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index eb6c02bc4a02..6bc151045843 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -246,11 +246,8 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>>                  * size, otherwise chain mode could not be used.
>>                  */
>>                 for_each_sg(data->sg, sg, data->sg_len, i) {
>> -                       if (sg->length % data->blksz) {
>> -                               WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
>> -                                         sg->length, data->blksz);
> 
> Rather than removing this warning, perhaps an option could be to use
> dev_warn_once() instead?


Yep, I'll re-spin.

Neil

> 
>> +                       if (sg->length % data->blksz)
>>                                 return;
>> -                       }
>>                 }
>>         }
>>
> 
> Kind regards
> Uffe
> 

