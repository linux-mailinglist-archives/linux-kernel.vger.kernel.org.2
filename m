Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE2452B33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhKPG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhKPG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:57:52 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D1C061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 22:54:55 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d11so41052559ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 22:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tgBKL1gwg50IdtXGM8JUdFNg/4ozOvpcD5xZOg8bVc8=;
        b=ap51xdduefnfmJEJ9+lScdp4gCQVU3tO4hk9rk5rtXLOfaTfr6/PJ9oR9OGD3pGANB
         PykPbs+Zt3kKij7UElGaO2aGopSKBH+D4QR4oyYfBe5xdtY4BVRbYBqFUqTJTesspf0f
         wNpSKClG2IOQVbPDFc6Y4Gmk4o3YQBEJn3yDTLmJwQotAwuVerTAXAPKOCxFEHxkKbXA
         tTbexpY51P2b+qT2j70haY1g66tUsz/YxnsTAr+tYY0eDtViHItDQQ2fN9AbjfH/Dt1x
         1UZt5+kTCcbl27A9RklapBpu/1w/Xivven1OHqvNODLNtdDgGfxuTo24YWAz52nIIL7y
         ZkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tgBKL1gwg50IdtXGM8JUdFNg/4ozOvpcD5xZOg8bVc8=;
        b=oM/6A/KcurReVtvFigYbk64QYP/ys4uhOzSGDRt8Zumqyz/RAKQFr2wrodO5vr3rEF
         5EIkerxJ4nkEdN0HfOlA+RCX2WChKmW1C5ih1aAoVXrgwncnpV+LKk/ZG4+DzowOMXIA
         jBZJNsZt8Q4P1nfWytKtgD7t5mp5HqRyhYP0PzwDXyBK2/ODjtXEqV7uIVVpzYedBd8w
         qEYTxIIOryt2oYCPyGLlegC3djaHg54CO2iKFTpQu3P02ViAxuZtxmzqUtNYF+kiP9jE
         0Ie4oz/g4zEiElNAELQ6zcgfBz668iNf+b91618AGaqsscYY9LdW9l4XRMGFcj3GjBff
         CXSQ==
X-Gm-Message-State: AOAM531p0vkL5U8qs4qq9yrFgQi60+G8rqnP2V8dOMPdY1nhit7Ac0+r
        zjnvdy8TgwUUzkHR7Vpss+Y=
X-Google-Smtp-Source: ABdhPJzhu7UG20u9shq47ulRZh4I7gnE6XXmyD7/ZnUX6PLHP9RWOXtkM2nGHsvyrpL1Ft/NIyHrcA==
X-Received: by 2002:a2e:4b0a:: with SMTP id y10mr4838760lja.334.1637045694135;
        Mon, 15 Nov 2021 22:54:54 -0800 (PST)
Received: from [172.28.2.233] ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id w15sm1660927lfe.184.2021.11.15.22.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 22:54:53 -0800 (PST)
Message-ID: <39236708-f668-e99e-e749-6b7b863241a8@gmail.com>
Date:   Tue, 16 Nov 2021 09:54:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] staging: r8188eu: fix array_size.cocci warning
Content-Language: en-US
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Cc:     kernel@vivo.com
References: <20211116064124.8833-1-guozhengkui@vivo.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211116064124.8833-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 09:41, Guo Zhengkui wrote:
> diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
> index 2ec56012516e..e704092d31d0 100644
> --- a/drivers/staging/r8188eu/core/rtw_rf.c
> +++ b/drivers/staging/r8188eu/core/rtw_rf.c
> @@ -35,7 +35,7 @@ static struct ch_freq ch_freq_map[] = {
>   	{216, 5080},/* Japan, means J16 */
>   };
>   
> -static int ch_freq_map_num = (sizeof(ch_freq_map) / sizeof(struct ch_freq));
> +static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
>   
>   u32 rtw_ch2freq(u32 channel)
>   {
> 

Hm, do we need this variable to be static? It's used only in 2 
expressions in rtw_ch2freq() (and 2nd one can be removed by 
per-initializing freq with 2412).

I think, it can be places on stack to reduce binary size.




With regards,
Pavel Skripkin
