Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483074072CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhIJVHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhIJVH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:07:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95A7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:06:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so2386184wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TLj/ONS/sld60sqpERNMaRNSbW3piuAZR1aelVesNnA=;
        b=oqt0cnUo8pv7evLVlDPWL3BXa3YP8fcn/cOCTgH8vK/bPCqsSpNX5Xh4U20UwQo8M7
         +ASBUrAHSx7h2DXlCsDS3XNFhYoR3mbl1vMqAc2bwGYrj2724OitCf8Ue9xHQrTY4yjX
         8OmZIBo4gxd836Zs/m3/HrL1VAYITLn+HwsEm+mKjCYGr1n0WLRMBJIBLKUJ69Irdbpi
         UgANyYYdt3TMjaON4V+XzJy+5l2JAFWB2RJHkqTzywYDLL6GzvN5mqu0NoKbCTfUoluK
         QGf1EWzl6PlTtt98g8sPqYhbJVCilGqZrg0u03JCKLSIrNxXdDn/YfIicRH4sBqLeg01
         iYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TLj/ONS/sld60sqpERNMaRNSbW3piuAZR1aelVesNnA=;
        b=IwxJ1pTXZ2bBxH81+1SKb58YHXf7Nd9blkCVJB3FRWOCrlPSeHLvueMbHR/cr1WmRQ
         fMvS87eJaCiMqfFHretYJAE1M1jrS1yfnSa17ANtOZj1kBMqeOA7k2N28PtbN1X1BgvD
         1/iotZKcFYarY83i+CiPPV2byn6uiZFWm0vXmwWRr6zPZPEupWi6Gf3OZhNGfCmr42wL
         lK/9rFshxGgETPhFDHGstktbEf9PunqzGnkZaCYddlIlywLmvZNjoLLzQCbiSsDnmQFY
         xzbL3vOqskdjfP59GB8qCo337AOZYtkqVo2e9/vFwK/1jRopmCzmDFPJ/LworVYQA9/n
         Xmrg==
X-Gm-Message-State: AOAM530rLkd+gdYOrJYZv+42wbV9jNOiD/8xiWiCx+RaCgsZV7O+IRck
        33zDvd+O8UNsIHbR9Jjr8H0=
X-Google-Smtp-Source: ABdhPJwSciMCagUQIW5NgDmk7rlPZNnNKEx4aYuocKIOMM/Xa+9+e9yPCBSsYmmvEvjGKxe2xfkTMw==
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr10302816wmq.98.1631307975545;
        Fri, 10 Sep 2021 14:06:15 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::8fe1? ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id m18sm3132448wrn.85.2021.09.10.14.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:06:15 -0700 (PDT)
Message-ID: <79d75d2f-c55f-eb4a-a03a-c54d00b50de5@gmail.com>
Date:   Fri, 10 Sep 2021 23:06:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 0/4] remove unused usb endpoint functions
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210910202151.4007-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210910202151.4007-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 22:21, Martin Kaiser wrote:
> Remove driver-specific functions to detect the type and direction of a
> usb endpoint. Their callers have already been updated to use the helper
> functions from the usb core.
> 
> Martin Kaiser (4):
>    staging: r8188eu: remove unused function usb_endpoint_is_int
>    staging: r8188eu: remove unused function RT_usb_endpoint_is_bulk_in
>    staging: r8188eu: remove unused function RT_usb_endpoint_num
>    staging: r8188eu: remove the remaining usb endpoint functions
> 
>   drivers/staging/r8188eu/os_dep/usb_intf.c | 40 -----------------------
>   1 file changed, 40 deletions(-)
> 

Compiles and looks good to me.

For all 4 patches

Acked-by: Michael Straube <straube.linux@gmail.com>

