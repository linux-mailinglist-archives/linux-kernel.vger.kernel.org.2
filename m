Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AADB3F40B1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhHVRg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 13:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHVRg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 13:36:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C041C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 10:36:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w5so31830223ejq.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAXlU/N5qMilNeBSVzad3n2eVBQ6RHD0rjHnWw+B6JY=;
        b=jTsAP2pce+UWk82UZjYNxeTKnoSz2l77jQ5h8g1V7LEGd8ceuojoR3wG7ptSDMNEkf
         PTIHfyroGEgoCWvU0pxcJjOnMs0ivK9iNDfhLwFGLeY10uCwQSBZ8otFCueRZxWarDj3
         RoFQD4wbVOag2t4THOTlGCiFbYzDIp3q9qMnKG9EwzIQkcChnTWhzeAWxjqqtvHHePLv
         lMdjSeQPB6CYzuFdmcSij/ib0IEsbWku+flUwrkmkEHUfdWHwi2R/bIXmnzqstxLC67V
         y1FBHx9AYM6OZR5CsRWpNw2nFVqFSu0/aO7FiZxzEOf24hWrBcRDzXg5zLEXHR+sfxWp
         Vx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAXlU/N5qMilNeBSVzad3n2eVBQ6RHD0rjHnWw+B6JY=;
        b=bSElIInbH5IgU2f/t30OirbRM/zBIJ7xdHyD18Pc3fI6WSoDIgIil4qGnmRJL07yBy
         l8tbTbEf8grswR+MBMd/JDEeT7xig8wzWiqQKguI0YSTdlZ0wJ2SoTFbyR2CptSyFUhI
         nWXbZAHGgYNfJMkpvfcrqH+uzUKKk8P1BbenjiCPTY7e4jMK8eIsuwGf+KW7oYl6Ki1q
         3ITHj1qOx2RqDQvbMfeZgRSOgO/OgbEgH+CFdAn0RRjssBfjDs/0EPR16srugI08MAmK
         XiaCnNCqKZhtXHqL8lQSJ6WHkcJ0TJnV98viUa8221/TmKfFXJljA+SjyqtFw8BDVpSS
         Q3JQ==
X-Gm-Message-State: AOAM533ER6HC1mKFalOgdJksAJcRM1jQH3ox6dzIwLn8ObOmxTt/Bo3U
        tCPuk15av1HoyggEWB6AZYM=
X-Google-Smtp-Source: ABdhPJzxqPcDUhcrBPyCoFgod+ISXsdbZH5+UH6MTrGT8KrFjYOkpW36THDVTAE8eUtFYh0iY9DB9w==
X-Received: by 2002:a17:906:348c:: with SMTP id g12mr31990835ejb.365.1629653775135;
        Sun, 22 Aug 2021 10:36:15 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id t1sm3075378edq.31.2021.08.22.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 10:36:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
Date:   Sun, 22 Aug 2021 19:36:13 +0200
Message-ID: <15979623.JslXr83I74@localhost.localdomain>
In-Reply-To: <cover.1629642658.git.paskripkin@gmail.com>
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com> <cover.1629642658.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 22, 2021 4:35:05 PM CEST Pavel Skripkin wrote:
> Hi, Greg, Larry and Phillip!
> 
> I noticed, that new staging driver was added like 3 weeks ago and I decided
> to look at the code, because drivers in staging directory are always buggy.
> 
> The first thing I noticed is *no one* was checking read operations result, but
> it can fail and driver may start writing random stack values into registers. It
> can cause driver misbehavior or device misbehavior.
> 
> To avoid this type of bugs, I've changed rtw_read* API. Now all rtw_read
> funtions return an error, when something went wrong with usb transfer.
> 
> It helps callers to break/return earlier and don't write random values to
> registers or to rely on random values.
> 
> Why is this pacth series RFC?
>   1. I don't have this device and I cannot test these changes.
>   2. I don't know how to handle errors in each particular case. For now, function
>      just returns or returns an error. That's all. I hope, driver maintainers will
>      help with these bits.
>   3. I guess, I handled not all uninit value bugs here. I hope, I fixed
>      at least half of them
> 
> v1 -> v2:
>   1. Make rtw_read*() return an error instead of initializing pointer to error
>   2. Split one huge patch to smaller ones for each rtw_read{8,16,32} function
>      changes
>   3. Add new macro for printing register values (It helps to not copy-paste error
>      handling)
>   4. Removed {read,write}_macreg (Suggested by Phillip)
>   5. Rebased on top of staging-next
>   6. Cleaned checkpatch errors and warnings
> 
> Only build-tested, since I don't have device with r8118eu chip
> 
> Pavel Skripkin (6):
>   staging: r8188eu: remove {read,write}_macreg
>   staging: r8188eu: add helper macro for printing registers
>   staging: r8188eu: add error handling of rtw_read8
>   staging: r8188eu: add error handling of rtw_read16
>   staging: r8188eu: add error handling of rtw_read32
>   staging: r8188eu: make ReadEFuse return an int

Hi Pavel,

I've just read your v2 of the series. I had no time to read each and every line, 
however, I suppose that I saw enough to say that I think they are a huge 
improvement over v1. I really like your patches and if I were you, I'd drop
that RFC tag.

Thanks,

Fabio
v1 design.
not needed because 


