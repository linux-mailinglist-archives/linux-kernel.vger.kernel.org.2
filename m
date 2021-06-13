Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9533A59FE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhFMSVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 14:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhFMSVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 14:21:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3448C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 11:19:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a11so11874237wrt.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4d/imazEagkhQ425TvhHIJ+mpNOn1pVq8jS+CKK1QM=;
        b=sOPRIa6agjbd6Bh2PwJOISVNR1sjEitwWIIAZ81ZrECozWeaBMeW/LA2nTc2yNq+Vz
         /bgEbvjNgIekifWYgvE9iu+7ijfNjakVXM9ys8KBRa2paGr2E2K9hExSPhwbA2zCzbOG
         mI1KNVuLKoKQut1SIkKlgXU+19qWJiM32dvkhoeM/FBCz0VA97Z3vJYJOJSM65c/V1Lm
         xOpMGe+EJVvEZmm4r3AHSXTrGqHMNdQncxnURBAIF8bIjcp/MeCfLOuPFn056Bu3C0xD
         CvBCjr06aBM/kzIzle+qQGcDSYQXhwVJ9EYwqS50gagmenLqp3KqT8t+NQ2XvYiVMxGa
         xUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4d/imazEagkhQ425TvhHIJ+mpNOn1pVq8jS+CKK1QM=;
        b=Pp0yfA/dlDXEWVJ7z1IkFwlKannzCHVvZvznd0uF0ZOY86NQHwbaXh7wrctfsM+070
         05hmTgaecxAdVVjS73ZCh/s9Rop5FVnQsgHVldUC79zetrvN2NKtDp7e751Vh3gLIvWK
         M45qsKkc+4L0P0LW0pEXRSJ3kanRsZnBKG0DjBdNtfRB1GKhzf54a6t7Hwj/yOGsV6rO
         nJXt1j4OeYM/pOSQTn8ElBSktbOquvgViT6haAs/2h+JIvr/whC3f0cJ/yvC2s6M530q
         2YTHrHzqpbDVZWYIlDSzjfpxaPs0NHZ+V6ORMimN8M7GOa/Eg8wNDE1O6Skk+zNfCf1M
         g1DQ==
X-Gm-Message-State: AOAM531vym/cE09t7Yxd1tlDXi4t2UjMTgbp0ZTGdDnuS//qcKU0oRQD
        uUEiRwe3ajTpi6ZWFlBa9/HVct8d3P8UM+8l
X-Google-Smtp-Source: ABdhPJyZPKxlkgUaN3s1SYbc5n4JbV6v9GU9GsKYsi7K2gZVZA3B6rWdoKOAIjoaUuehL/1izWLlZg==
X-Received: by 2002:a5d:59a5:: with SMTP id p5mr14353911wrr.27.1623608374047;
        Sun, 13 Jun 2021 11:19:34 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:28c8:8dc7:5312:94e2? ([2a01:e34:ed2f:f020:28c8:8dc7:5312:94e2])
        by smtp.googlemail.com with ESMTPSA id v8sm14992443wrc.29.2021.06.13.11.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 11:19:33 -0700 (PDT)
Subject: Re: [PATCH v1 03/10] ARM: tegra: acer-a500: Bump thermal trips by 10C
To:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Agneli <poczt@protonmail.ch>, Paul Fertser <fercerpav@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210510202600.12156-1-digetx@gmail.com>
 <20210510202600.12156-4-digetx@gmail.com>
 <20210514211601.GA1969@qmqm.qmqm.pl>
 <ecc89faf-97f5-65e9-0eb8-93c8414c69e5@linaro.org>
 <eedb5792-d3a5-78b3-ec89-b26d2e45f9c4@gmail.com>
 <c65a732d-b203-a1a0-e90b-0aa0664cfb55@linaro.org>
 <e73b64b2-77a8-3671-1fc6-0bf77e2287c4@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1abadc69-1dd1-5939-c089-37a84be4781b@linaro.org>
Date:   Sun, 13 Jun 2021 20:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e73b64b2-77a8-3671-1fc6-0bf77e2287c4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2021 02:25, Dmitry Osipenko wrote:

[ ... ]

>> You should set the trip points close to the functioning boundary
>> temperature given in the hardware specification whatever the resulting
>> heating effect is on the device.
>>
>> The thermal zone is there to protect the silicon and the system from a
>> wild reboot.
>>
>> If the Nexus 7 is too hot after the changes, then you may act on the
>> sources of the heat. For instance, set the the highest OPP to turbo or
>> remove it, or, if there is one, change the thermal daemon to reduce the
>> overall power consumption.
>> In case you are interested in: https://lwn.net/Articles/839318/
> 
> The DTPM is a very interesting approach. For now Tegra still misses some
> basics in mainline kernel which have a higher priority, so I think it
> should be good enough to perform the in-kernel thermal management for
> the starter. We may consider a more complex solutions later on if will
> be necessary.
> 
> What I'm currently thinking to do is:
> 
> 1. Set up the trips of SoC/CPU core thermal zones in accordance to the
> silicon limits.
> 
> 2. Set up the skin trips in accordance to the device limits.
> 
> The breached skin trips will cause a mild throttling, while the SoC/CPU
> trips will be allowed to cause the severe throttling. Does this sound
> good to you?

The skin temperature must be managed from userspace. The kernel is
unable to do a smart thermal management given different thermal zones
but if the goal is to go forward and prevent the tablet to be hot
temporarily until the other hardware support is there, I think it is
acceptable.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
