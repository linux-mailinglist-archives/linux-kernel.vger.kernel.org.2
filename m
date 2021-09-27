Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648C8419810
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhI0PmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbhI0PmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:42:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D90C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:40:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so79801862lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7uZ+gRol/KIudEZLw050U1sUe4rvi6xJlQLIYjTorQM=;
        b=rL77yan5j9TgD01AEbbvHMzXYMfKv4dJ26BM4zP8IZ6+cYTvwMuBGNfRQNDgT3Vzex
         FvKQUR6kkwiGaWS3YX3PuKuzKCjqUZA/1JTOtA/NMrNf7MzJxTXh9PB/SUx5RFdf5j5v
         vKtH6iN3iIxJogpizrlG0WYQMZfruwlFZloIxakBRsyQZ8dp2FWYE1XNuah5bcGiHHeN
         pJL/uLYuj8HUHG6ecfHIMiF74aIM1QTyi9+v07MM/c8HfztymCExC4sw8pdEeKArKFaF
         Acy4Lz3Q6W5Ksg2voyH0oTeyCHijuaah5Rle+Cr2nPjawOYm+lTXJ2YJfSkG8ZDAZdCn
         iWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7uZ+gRol/KIudEZLw050U1sUe4rvi6xJlQLIYjTorQM=;
        b=Llx9AxyE8rxdRFU4HowGntzMDxHjrxSO/jsdmQmsyxpPZjF1yE1PGuWhncxQNkBW9z
         oHhJuv82QEjFVS4EAHexFPt9mL9ubB+OE6bOijMrv1IBqr0u6QxjZHAYg2L7dVRC2om7
         f5RkMLC14zkr2bQoMDxSR+7vgWqiDyBC1Emhe7F3ANGQ56kOQcVn/XxFt3vOjhW/obfk
         MF+/cKCKRT+ECn+tQ6bf53qnThSzrlE/YkxwgZArN8r0/Boj1MX6ebm4qeqEXyjC3Tvk
         /xqC/pjscxZz1ymNqQ5dQ/mICdOP+BlP+tfa6tXDUU+2i09FXacf7c40CREvGiS8Bec7
         /MBA==
X-Gm-Message-State: AOAM5304rG48uw+p9ECpyWhuFA757cnzqWFXOoYJav0twZQVlCOawZti
        Je6gtNc7Svzej6scSvSVuY77OOk0wAtVBeoJ
X-Google-Smtp-Source: ABdhPJzghrKub0OezplaDpxg3KRDVv3kVAzRjV6EiLmXpfkTimU7SUxOcd+xcDA9Cc5G16NdaS3K2w==
X-Received: by 2002:a05:651c:21b:: with SMTP id y27mr547301ljn.106.1632757215039;
        Mon, 27 Sep 2021 08:40:15 -0700 (PDT)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id a11sm1635394lfo.5.2021.09.27.08.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:40:14 -0700 (PDT)
Subject: Re: [PATCH] staging: most: dim2: force fcnt=3 on Renesas GEN3
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210921165130.24178-1-nikita.yoush@cogentembedded.com>
 <YVHjQ95lbDjvVR73@kroah.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <17e51208-18b9-56d8-e8e3-2e40d6e94438@cogentembedded.com>
Date:   Mon, 27 Sep 2021 18:40:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVHjQ95lbDjvVR73@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +	dev_fcnt = pdata && pdata->fcnt ? pdata->fcnt : fcnt;
> 
> Please use a real if () statement here and do not bury real logic in a
> crazy line like this one, as that is all but impossible to maintain over
> time.

The same source file already uses the same form of conditional expressions several lines above:

 > ret = pdata && pdata->enable ? pdata->enable(pdev) : 0;

 > dev->disable_platform = pdata ? pdata->disable : NULL;

Shall I use real if statement for my expression while keeping those as-is? This looks ... strange.
Or shall I convert all conditional expressions to if statements?

Nikita
