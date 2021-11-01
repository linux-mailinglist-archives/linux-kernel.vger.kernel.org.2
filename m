Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC34420C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhKAT0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhKAT0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:26:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3EC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 12:23:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v20so12224186plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bR0N16YD9pFySBhO3WCHcKlYqsCgjFWUHZOc4OZkB9E=;
        b=O5J573nyl6G+ENM+iMVSjRtWiJgNOdI97EEhG73Z4JmNJtMB7weL5A99X3RfCUVsw0
         c3lFKS3+xe7ERFqVLkX8PHoavuUbYMXGJZqHelYHdJXDGHjDxUEBz0wyfs6fIGYVHGGy
         Ph58E9imcqMMt0aecNiQvvhibcehl+tj9/h6HsCNXYQmAvdFVk7ECJdWXQmY1ZBPwi5y
         LdNGMKLEqla7uIUkBosL3KYSwKwBwbaB0X/pEwuK4BMiHZ3IKj1lpZPTSlPLrroau6Mz
         2YsHOSyzRFA7krISo4rtXHzWnQ8d9QDb7bgvODyZtU2CN5kqX33U7jSqIWRQyDxW/gND
         +h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bR0N16YD9pFySBhO3WCHcKlYqsCgjFWUHZOc4OZkB9E=;
        b=1LedlR4utkLZ5wFFkPrg2SBb/pVAOYXEffKudFUAbdXtrLIeRdnJSkHsW6bxnlE+vi
         ypGhePmmt3AILDs5UVZ4RNhQipSwU7JxnixnwkRjKYS0NZTZuHuaYFMtJql2IdPuCa4z
         RFaMt8HFVToS8Z8xdFmZ3Eq+YIffw7xDy/HWYItj9KiXT/Mh+PUtxwbAdsVJ4BEpccY1
         CBx5OuuV0S80YbXFd3/uvX70GIQf3awNW/MqiCdvyJL7yg4s/F60Us5fis2Clb2FJVWx
         w5xlFARjCwBIbST0TUDHxPvDut48fc0vFfLaRzSIjUw6tNfcPo+/7Ua/uOJH1OHro2Du
         kuTQ==
X-Gm-Message-State: AOAM532M3UdGDorQwFBVyxzCjRyw+MuUCNdQLUDE37hbuWE4SQ9mfinK
        prxkPBcrgHvzZesxy0y/u4M=
X-Google-Smtp-Source: ABdhPJy5WlJp8FgWOCQPol5iGyp+S/Q1efBq3hU4sebWunOHNUAhvD6mILb2yAuX93fzXftTPF5iQw==
X-Received: by 2002:a17:902:8690:b0:13f:ffd6:6c63 with SMTP id g16-20020a170902869000b0013fffd66c63mr26973677plo.23.1635794619261;
        Mon, 01 Nov 2021 12:23:39 -0700 (PDT)
Received: from [192.168.1.2] ([59.95.93.69])
        by smtp.gmail.com with ESMTPSA id e9sm12121255pfv.132.2021.11.01.12.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:23:38 -0700 (PDT)
Message-ID: <5013033b-b1f1-aef7-9fb8-a8431e83960b@gmail.com>
Date:   Tue, 2 Nov 2021 00:53:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: hal: else is not useful after a return
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
References: <YX7iBmKKNZfj8Gca@Sauravs-MacBook-Air.local>
 <YX/lRMNGsCZMKAV3@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <YX/lRMNGsCZMKAV3@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/21 6:31 pm, Greg KH wrote:
> On Mon, Nov 01, 2021 at 12:05:50AM +0530, Saurav Girepunje wrote:
>> In the function rtl8188eu_hal_init() else after the return statement
>> of the if section is not useful. As if condition is true function will
>> return from if section, On the other case if condition is false
>> function will not return and statement after the if section will
>> execute, So there is no need to have else in this case. Remove the
>> else after a return statement of the if section.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>  drivers/staging/r8188eu/hal/usb_halinit.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You sent multiple patches, yet no indication of which ones should be
>   applied in which order.  Greg could just guess, but if you are
>   receiving this email, he guessed wrong and the patches didn't apply.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for a description of how
>   to do this so that Greg has a chance to apply these correctly.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot>

Hi Greg,

I have send only one patch for usb_halinit.c.
However I have send another patch staging: r8188eu: hal: break after the return not useful
for another file HalPwrSeqCmd.c both are on same path drivers/staging/r8188eu/hal/ 

Regards,
Saurav
 
