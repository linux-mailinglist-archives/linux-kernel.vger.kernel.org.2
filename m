Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F7440DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 10:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJaJhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJaJhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 05:37:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D31C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 02:35:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y1so9688117plk.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6O98232Vij+PsyWFCpTQWglMqymNrueCAn1H0Rq6Bug=;
        b=koMEyF2l4KOuOY8yk+asdHTlS30EB4Pibh5/aMNQAdYOtzKQaSJEtyxHomR9jTicqT
         zDGh+XXRaqn2bvC9Nd6YclWNnfb767KLBT3Mxbs+EVECXtPucimW7K58irykND0JHREt
         V+oJkNw6zDA+vzTwOqKdRfx+Zpb42tiSVJDAEyOykMnt0Vgze/4sgkBAbR2wvo0S0jn5
         df+dPWbaqWe3a6yv/hvKE8lBwqoOQCB7oeC1b08D07MmchEmW4MZjHpZ7v0MPAxFufbR
         KgOaChf2irAcWAT+Q7uWJBt+yK9DCUNwqztH7JOFtFjB+OjnTRs1YMRaTXtrOLrKo5wa
         u6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6O98232Vij+PsyWFCpTQWglMqymNrueCAn1H0Rq6Bug=;
        b=osHX1E0g3dKhi3iXEQ6pm3Ls0JPWa41AKkn+teLcmoKWJbuDEbdyRpeHC6XxMejV1j
         f7tF97JvPmdFskK9LACqzmAbKLoqM0H996Tv6xspRNN1BAqvVLGTmDDFQTdTXkQjE6eo
         WSqtSFkOny2NePNkY/QRd1R5T4/4D52IkB62YNZumjEbuh+36JwL0LgtOyL5weG+pkD4
         wwmCLlsjhhGoTjriWtML02fm9qnVatyYrwtlZQ8zhG1dGjINTtAopo555Mq7+Ykd5G11
         sjTs42eowlHCAPRa8bljKmt/G9UdGxnSM3i3W1IAJz2kUQfYyMt/rI9HC8C5fIbNE4/H
         Dz8g==
X-Gm-Message-State: AOAM533TLJXwq42sPkBPUesnNF+zls8yyJBMXoDFu1Q2GywWaD6N5IHj
        WM/25tDzEmK+FH7V2pCSv8Y=
X-Google-Smtp-Source: ABdhPJxcta6pHhrQyx7sf8tNpYU1FtyyZJX58/Bfpt9HLs5YyH0dXd0lLky2UZLkZLqDyjc8z+nBsg==
X-Received: by 2002:a17:902:ce8f:b0:141:93d7:6bfb with SMTP id f15-20020a170902ce8f00b0014193d76bfbmr17358779plg.7.1635672907295;
        Sun, 31 Oct 2021 02:35:07 -0700 (PDT)
Received: from [192.168.160.115] ([217.146.10.210])
        by smtp.gmail.com with ESMTPSA id co4sm1920232pjb.2.2021.10.31.02.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 02:35:06 -0700 (PDT)
Message-ID: <bf93fce2-6669-1e0e-3117-c84e7e7b4de9@gmail.com>
Date:   Sun, 31 Oct 2021 15:05:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: rtl8712: remove the condition with no effect
Content-Language: en-GB
To:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        alec@vc-celle.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YXonpdnCatbuOo8H@Sauravs-MacBook-Air.local>
 <d4ee4591-0642-002b-ddd8-41693c0f1ccb@gmail.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <d4ee4591-0642-002b-ddd8-41693c0f1ccb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/21 4:56 pm, Pavel Skripkin wrote:
> On 10/28/21 07:31, Saurav Girepunje wrote:
>> Remove the if condition check and else code section in
>> query_rx_phy_status(). As variable cck_highpwr is assign a value of '0'
>> after this assignment, if condition check !cck_highpwr is always
>> going to be true. So remove the if condition check as well as else
>> section which will be never true.
>>
>> After removing the if condition there is no use of local variable
>> cck_highpwr. Remove the local variable cck_highpwr.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
> 
> [code snip]
> 
>> +        report = pcck_buf->cck_agc_rpt & 0xc0;
>> +        report >>= 6;
>> +        switch (report) {
>> +        /* Modify the RF RNA gain value to -40, -20,
>> +         * -2, 14 by Jenyu's suggestion
>> +         * Note: different RF with the different
>> +         * RNA gain.
>> +         */
>> +        case 0x3:
>> +            rx_pwr_all = -40 - (pcck_buf->cck_agc_rpt &
>> +                     0x3e);
> 
> You can move "0x3e);" part on previous line, since it will fit even 80 characters boundary. It will improve readability, IMO
> 
> Same below.
> 
Yes, This is also can be done on same patch.
Thanks for review Pavel
>> +            break;
>> +        case 0x2:
>> +            rx_pwr_all = -20 - (pcck_buf->cck_agc_rpt &
>> +                     0x3e);
>> +            break;
>> +        case 0x1:
>> +            rx_pwr_all = -2 - (pcck_buf->cck_agc_rpt &
>> +                     0x3e);
>> +            break;
>> +        case 0x0:
>> +            rx_pwr_all = 14 - (pcck_buf->cck_agc_rpt &
>> +                     0x3e);
>> +            break;
>>           }
>> +
> 
> 
> 
> With regards,
> Pavel Skripkin

Regards,
Saurav 
