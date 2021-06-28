Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F513B5A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhF1Ias (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhF1Iar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:30:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE1C061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:28:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o33-20020a05600c5121b02901e360c98c08so11366827wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jO+3RGr+y6NVVh1FqaniB3igkozK5F2rs2J9PP1CIIA=;
        b=YguKwKN4a0V3L/TLOfpJP1B3B6i+xqV5e7RLVQFpql2LuKNaEqRvcFBD9J6wCnfDq7
         utpq0mMnfNWMNktbKTGdnJDEFWvxy2d0Ceoy7AT1C/fVnMFjtIdSeKducvG4xjteOqaR
         jyOX4A6d5uq+uWGtR88h/i4eWFUhqQbbjDx6lAvj5fyFnSEyMbTTYGl14PKh6H++WV9n
         7zXPbQRW/HuO55VRdfFgtOYd2nbZU5MEFUpLYNmmQTxkCz0O6xHj/seObTua1QO/vIVY
         t7vW1Yzh7KTyLVJqf7iEcwT0wC1yxZ00ZC818eXdLCN2RtqKZbOX/qrsKseWaLH6mwOa
         2bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jO+3RGr+y6NVVh1FqaniB3igkozK5F2rs2J9PP1CIIA=;
        b=Ns7Sc4rXEt+fN7O0Xrm+ulwtgHQHRJqn9iDGFO18hxo3nZPSLOpBZkgv0v+SYl8u8W
         oyqppwFC5cE9WmvLhNyzP02ITGRC9PSYaibtRNwy2oXNv3wl3OivGNRtZz8be93fDfKH
         LZ37qDQl486PCsFVwGUqOuX3pwm6Ci5zjvBiObgdC+FNUVQhVKiYJxKmhaj87ecJNlu4
         fREGkTrkH48hHwVB9PeWJ1rv7kOrY9+Zee3sKRg/YdOF6aYGRP+DzTrpiu+J/XdQb1+G
         LtVuPrpeMw3NdZ+6Xbq78wCDMvM1/pvpU2zGKkSRlVdENvHVnen2NeeMSJPjU0uFA2Oc
         kDGQ==
X-Gm-Message-State: AOAM531RSRlezaLbmJaKZr3mzX5wzd/Bt8qF8H8/zzQ19W2Iya82HnZf
        3iYIjiBTY2Xokb+rkp+QDAubGg==
X-Google-Smtp-Source: ABdhPJz0qU0L+jfgWftJwj1BEv67vBd/SVpqq9dTQ0ggI5vKleT3pE4PD0ThoZRJnaspnhlJ5ypqew==
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr24238017wmh.183.1624868900140;
        Mon, 28 Jun 2021 01:28:20 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:e503:e76:4043:c4f7? ([2001:861:44c0:66c0:e503:e76:4043:c4f7])
        by smtp.gmail.com with ESMTPSA id l5sm15996476wmq.9.2021.06.28.01.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 01:28:19 -0700 (PDT)
Subject: Re: [GIT PULL] MMC fixes for v5.13-rc8
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210624123251.191299-1-ulf.hansson@linaro.org>
 <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
 <CAPDyKFrLSMpPJOgd5e4B1x3Vwfg4q23zgy4ESc8EmFL2MnyK7g@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ae18ec4e-b91d-93a5-7f5f-f830646ed11a@baylibre.com>
Date:   Mon, 28 Jun 2021 10:28:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrLSMpPJOgd5e4B1x3Vwfg4q23zgy4ESc8EmFL2MnyK7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/06/2021 09:49, Ulf Hansson wrote:
> + Neil, Robin
> 
> On Thu, 24 Jun 2021 at 20:00, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Thu, Jun 24, 2021 at 5:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> Neil Armstrong (1):
>>>       mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
>>
>> Ugh. How horribly ugly.
>>
>> Why is that 'host->dram_access_quirk' test _inside_ the loop, rather
>> than be something like
>>
>>         if (host->dram_access_quirk)
>>                 return sg_copy_to_buffer(data->sg, data->sg_len,
>>                                 host->bounce_buf, xfer_bytes);
>>
>> at the top of the function, with meson_mmc_copy_buffer() then only
>> handling the mmio case?
>>
>> No, I don't know this code, I'm just looking at the patch and going
>> "that looks really ugly".
>>
>> Anyway, I've pulled it, but I thought I'd voice my reaction to it..
> 
> Thanks, good point!
> 
> Robin and Neil did discuss some cleanup that could be made on top [1],
> but it looks like that was targeting a different part.

Yes this was a quick hack (and obviously not the optimal way to) to address the fatal system crash.

> 
> In any case, Neil, would you mind sending a cleanup according to the
> comment from Linus?

Sure, as discussed with Robin, the plan is to introduce sg_copy_to_buffer_to/fromio
and remove this crappy hack, but this requires multiple subsystems involved.

> 
> Kind regards
> Uffe

Thanks,
Neil

> 
> [1]
> https://www.spinics.net/lists/arm-kernel/msg901045.html
> 

