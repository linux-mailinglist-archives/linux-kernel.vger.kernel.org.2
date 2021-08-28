Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E093FA4F2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhH1KOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhH1KOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:14:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F5C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:13:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g13so19958957lfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7h+WubBbM0HNO31JZ6P6oW4fOf4+jDWFF9hWKBluJfY=;
        b=mvQL/Pd2HScrwbX0OBzMm+G8PH5lhZTi4r4FhI7aVY4HoYl/6RCmb28AjOTM/5QJdJ
         QnF4o3G6pzJrZzjSikPM6+XesUSJXVW1SACqy07KUm/UUmFpILi9SIW8BWQL8nB5dQKC
         hdIVjZfnzcssYY6Eq0yGOhdIVzgzDGJ42xHEWEeBnG7tym0GGp5D0G19rnPrYecC1mTC
         vS7K5Fmkk8cBW78Q6lyVOMiy7lPm2383mBfb1oC4N/XnGYaPPEWaf0eOU1AFrQKddNwb
         igcXMYXDpD8vs5NHQy8i6UGrrwjbrfB3iTMXc62Dz9dBafPsfk3WJo8yviTCPSe0GhF4
         vTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7h+WubBbM0HNO31JZ6P6oW4fOf4+jDWFF9hWKBluJfY=;
        b=AyPeYQEuBAs1pzJgPupCqulkHhDW4nw8G+5P/St8bhanpX7OOOMyY5tckUoH/vgEAB
         F2MmUeQ9a9OpdDPs1CfqAoEvPHacXk7u2foXbl/yroD5OxZZL7H3Bpx4mfyzg1NF0XLH
         7p++pmYAZNyLDFqM6+nvkxSxTX9nxrq+br7EwV3nXGYBwgvMK5LsWDRR9jPeBnTSlFY7
         a//Ceva8LIanastfu8mZrQsji5/MqXzjVRGI0qbpK6QZ3FspPXqFFRbxWDTQcUUm3WVi
         xxNHkCLcHArM8yvjr1pkMpgxLnm9LpWiAy/ND2yMpIgU9bK5LY/ZQCveOtqIYqPtHMIS
         fy2Q==
X-Gm-Message-State: AOAM533/EcFg1XES2Rmv/mdFk1Tdy/waSyppP594HAf+LrNBRT58fV0E
        B7odx00pGW1zucFsogwfUMBWPeTM96UY5g==
X-Google-Smtp-Source: ABdhPJyqidQ8uHqebw51IZD4d3VGpShDLbzvk/g25Xgfe27FS5yBIz24luNn5mnpUzytXhlP9Y+CqA==
X-Received: by 2002:a05:6512:e88:: with SMTP id bi8mr10181517lfb.328.1630145625141;
        Sat, 28 Aug 2021 03:13:45 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.213])
        by smtp.gmail.com with ESMTPSA id r8sm998939ljc.7.2021.08.28.03.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 03:13:44 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: add extra TODO entries
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com
References: <20210828000231.1458-1-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <4ed7a185-0be2-82cb-5460-73a3e27cd6e7@gmail.com>
Date:   Sat, 28 Aug 2021 13:13:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210828000231.1458-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/21 3:02 AM, Phillip Potter wrote:
> Add entry for CFG80211 to reflect that it is currently being worked on
> and is a desirable feature to have for this driver. Leave entries for
> LIB80211 and MAC80211 in case anyone else wishes to work on them - they
> can always be removed later, but MAC80211 in particular would certainly
> be good to aim for. Also, include an entry for improving error handling,
> as this is another goal of the cleanup effort.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/TODO | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/TODO b/drivers/staging/r8188eu/TODO
> index 98f918480990..ab9d5d145b3b 100644
> --- a/drivers/staging/r8188eu/TODO
> +++ b/drivers/staging/r8188eu/TODO
> @@ -11,3 +11,6 @@ To-do list:
>     the driver.
>   * Switch to use LIB80211.
>   * Switch to use MAC80211.
> +* Switch to use CFG80211.
> +* Improve the error handling of various functions, particularly those that use
> +  existing kernel APIs.
> 


Cool, I like it. There is one more extra task, but I will take care of 
it. I hope. We need to delete dead proc code and move to sysfs. I have a 
plan to finish this part until next weekends, but maybe it worth adding 
to TODO.

Thank you



With regards,
Pavel Skripkin
