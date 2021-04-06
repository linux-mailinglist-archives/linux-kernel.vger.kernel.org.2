Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB41D355CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347123AbhDFUAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbhDFUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:00:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE24C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 13:00:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso489wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Em3BrHYCkw2DM6lIWLuJHnJBfcbjTRbHrryEqft8SFU=;
        b=SMNqtcqTNXZ4MQaPnNebupFO3q7PjtlUqD3RleYi+OVVnk6LJ3T3HdTNtNteLc0CnO
         YUtPTtsbO6BRmwb0fCEe3bgJYVr+gF/eRmzbdOdpwMsyW/HV7dKsP2paaU6tWZHNl8hg
         /vqpxkqmZDCapI0KKliMnTkEnTjvsRssOx93gnH9SrY4GFmvH2mIv1lOTvdxIR519i2w
         O4qRnsIjJjez96QsSdrjPLXQNSzcTnFsPr6ywCxEP8BQq6MQuQrp/5uauWFmsvzmfOz9
         S2hoZJUWKTrsR6hMUDw2tvvGbL7rozACNZCyoRZ0sBnL8WqG55ZtBGDxXwfkPrihVM+v
         s5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Em3BrHYCkw2DM6lIWLuJHnJBfcbjTRbHrryEqft8SFU=;
        b=YBc0tmpaqu5j7RxVGwN5Dn/hPV6k3bzyRqj3bELvg46Q90oYIsPMugQ4xsHm3wgyRF
         REbNmKnB/A542RcUvnvIr0OtGvXn4KiPOqsJkdwQVuVyj8z2i/eaFg8RSf1lkXv3jprW
         2u5Z085Lv98w395Y+JLbqdLLDugN/pqKnuNuAee9celvifda3kH/jlUrUEmT96KbMz8D
         EHR8hr1CK50c+lHHl99JQTcgc719IWFSGwCeWOvyg0S5XGJKJdSzpagaqUrbTbLHqzE4
         z2O3km6Lby2N9LjMIXhKmRozl4WJr8J4eLHRIYWkeH3s1Ye2XgWJGZit7xF12rclnPaO
         8E7w==
X-Gm-Message-State: AOAM532Ulwocce83H8Zl1doeb9YtmXmPcKxW+SAcBeq8FkFyY4XUv2QI
        XfG6bSy2bMxmGbt1xEBLHNM=
X-Google-Smtp-Source: ABdhPJyqu2X+eKGoD247lTs4UX4BHvF5sob3AARwmQLGMqjzdeXheC/fpFe/3LmAkCYnyZzRxMSJqA==
X-Received: by 2002:a1c:2704:: with SMTP id n4mr5705317wmn.143.1617739208376;
        Tue, 06 Apr 2021 13:00:08 -0700 (PDT)
Received: from ?IPv6:2001:818:de85:7e00:ef5c:3f2a:a646:d6ec? ([2001:818:de85:7e00:ef5c:3f2a:a646:d6ec])
        by smtp.gmail.com with ESMTPSA id t20sm4129952wmi.15.2021.04.06.13.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 13:00:08 -0700 (PDT)
Subject: Re: [RESEND PATCH] staging: emxx_udc: Ending line with argument
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
 <YGy4LXHBrBb/r3dk@kroah.com>
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Message-ID: <4c7df741-4e73-2ac4-f0d8-c9513ae29c88@gmail.com>
Date:   Tue, 6 Apr 2021 21:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGy4LXHBrBb/r3dk@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Em 06/04/21 20:36, Greg KH escreveu:
> On Tue, Apr 06, 2021 at 08:34:09PM +0100, Beatriz Martins de Carvalho wrote:
>> Cleans up check of "Lines should not end with a '('"
>> with argument present in next line in file emxx_udc.c
>>
>> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
>> ---
>>   drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
> Why is this a [RESEND] ?
>
> What happened to the first version?
Sorry, I didn't receive your review, and in kernelnewbies tutorial, they 
say if not receive a response, may have missed the patch, so I resent it.
>
> Also, your subject is odd, please look at the documentation for how to
> write good subject lines for patches.

Yes, I know. It was my second patch, and I was learning, and when I 
resent it, I didn't know if I can change the subject.

>
> thanks,
Thanks for you review
>
> greg k-h
Beatriz Carvalho
