Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031D136F6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhD3IDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhD3IDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:03:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B92C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:02:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gx5so11818725ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=gEXOq4bTfcSUdUpLFcNhC6eN04AyrduIgQ9uuxLC6OQ=;
        b=CyLMRHNZPKD5a43+OjCNpQu0X+iMse+Mr2s56g3TR5iXy+jXFzudjJpE2fTY4RhNBj
         4V8hEHqAG7ZxzBoVsDu4/+iassEyaCRU+seGci3cHCaPgMa7O1v9riFc45YLhEzJ2VLs
         qWKOrXNo3xeXuo8CDVK5AQWFvHgggovEvtvxZrLztYPbJG8tkcZTYNYlpgwHyjSkSPBZ
         lbu9SRDRXQqGvEKSHcr3qbsVzwQdqGr6CV4kfMIMcOR7un+52eImiIMbSDR4dngbdH+6
         +ih3cdClm3/L/I/Nt0KRkGBhKQovaluwXwzYoE6z58qK5mgRHdROcwNWLG+HAEzNSMR0
         c7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=gEXOq4bTfcSUdUpLFcNhC6eN04AyrduIgQ9uuxLC6OQ=;
        b=gBZSxi4+1YmBxRfLpI0+P5VLDix6+Nwh7ZdpRevdrjdKTpLbQKc7UHbb9p9v5ZbuYo
         21JlbzEd0tTo9ikp0NDs4q11Tx1GYp/LXIX3EEIWC2YmJisCzxe93OQlxELiDNVrfrS/
         RbpQ+TNgVaegFG/imEYPwn9A6h8N98jft0LchTa8xXFAR6qNLdboshDZN5NGdsytmXUS
         u0Yn7400iHgMjxIQ8riOjOD9zcQtX/IZYF+92zekx7QQHYTap55Qegy1nn4TP0dTn1vt
         t/fWpCM2GA2omvmborGMa1doWxGdu+05Boz9hw2tayCM5VoHFAM34ZvhOVsFKbK8zIyz
         W22w==
X-Gm-Message-State: AOAM533Ucgn9X58hg/96DhOrBNMXOkDYGLdhLrNUDvB1wPOYun5nU/hz
        zjkRyMFHm8pfQRFUToBIvoMG5A==
X-Google-Smtp-Source: ABdhPJwWRSCUbw6PZjmgVFMqTWKuf9gCMZIlgo3uw/ckGNvacB1VpAMS8tzpBCnM3QlRu6BINi1NpQ==
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr2884072ejy.323.1619769777683;
        Fri, 30 Apr 2021 01:02:57 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id x20sm666852edd.58.2021.04.30.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 01:02:57 -0700 (PDT)
References: <20210429090516.61085-1-jbrunet@baylibre.com>
 <CAFBinCCcKHqd7Mh3bV9NyyWzi=96pCWxzSZBOjg5Puy9wOuihQ@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: axg-audio: do not print error on defer
In-reply-to: <CAFBinCCcKHqd7Mh3bV9NyyWzi=96pCWxzSZBOjg5Puy9wOuihQ@mail.gmail.com>
Message-ID: <1jlf909p3j.fsf@starbuckisacylon.baylibre.com>
Date:   Fri, 30 Apr 2021 10:02:56 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 29 Apr 2021 at 22:49, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Thu, Apr 29, 2021 at 11:06 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
>> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
>> index 7c8d02164443..5e501eff0840 100644
>> --- a/drivers/clk/meson/axg-audio.c
>> +++ b/drivers/clk/meson/axg-audio.c
>> @@ -1811,7 +1811,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>>
>>         ret = device_reset(dev);
>>         if (ret) {
>> -               dev_err(dev, "failed to reset device\n");
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "failed to reset device\n");
> many drivers are switching to dev_err_probe nowadays
> According to it's documentation:
>   In case of -EPROBE_DEFER it sets also defer probe reason, which can be
>   checked later by reading devices_deferred debugfs attribute.
>
> so I think it makes sense to use dev_err_probe here as well

Old habits ;) thanks for pointing this out. Will do

>
>
> Best regards,
> Martin

