Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A140342C566
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhJMQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhJMQAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:05 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0DAC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id g125so4412072oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xCJp57jNMOnyj4DLcTosLHG2ISZNxkYQUmY+8tgKxKg=;
        b=SHIqroMqBP2YjQev++CFKxcm3UVfC3vc5kWMPDMUfxGHziM0GeoVgiB/43mb2FYyqN
         CoAPTeaZbATeR2XY1XQVWm2Nd2WmbJTXBMbvhRtA04oPL3zRhlJGdLF0dODkc2oc2Ln2
         Gh2YW56WuI7kzog4BP/bHCYmFgJ1NsbvyKAiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCJp57jNMOnyj4DLcTosLHG2ISZNxkYQUmY+8tgKxKg=;
        b=6PvFoelurXRj0d4dO8FIrw7UiyoYNWyr/gTFecB9EBExO/BYcVEPpKcz8yDN/LVgIc
         9UxIxmEwuZ/aoZwnXdIkr2Ay8QbAlpaYx5DJ8gOxic1PHIbShWCOSjSe0XySsJcxAYSs
         SXEvzGKimXMljCh+ulZnvUt9sgRTGY0/d0ghgUcgjn3ryZToIr5VFFKbaNbBoT9ipx/D
         ofFXGxGLTXTNxGjo6wQb6dLtc39O1fF5ak6TIh9vpPknFkkcZXR/FaItx4Xr3fp8x8C4
         DZiS61vkStBfcDgn9YR5PspQC9t6yajbZ5oU3WGYcIKOpkfB0FiMSfIaT0eNFHDOqiM3
         VzGw==
X-Gm-Message-State: AOAM533H9zRelupq+lqAehUezI1j1TN99ndsVySMOnxTblHl5yTqGEsw
        zA/kZqu5vlObzlBAJLRmVZ8PwA==
X-Google-Smtp-Source: ABdhPJzke8L96NKcvX4M1awJBUAYsQux4GxSw1lEubPV8lGyaoSDSauqfFuO6xURklVpg/j1aEoGAw==
X-Received: by 2002:a05:6808:1aa9:: with SMTP id bm41mr8703077oib.55.1634140681136;
        Wed, 13 Oct 2021 08:58:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n13sm3101356otf.3.2021.10.13.08.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:58:00 -0700 (PDT)
Subject: Re: [PATCH] usbip: tools: usbipd: fix duplicate option definition
To:     Alyssa Ross <hi@alyssa.is>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Dominik Paulus <dominik.paulus@fau.de>,
        "open list:USB OVER IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211013145741.2597290-1-hi@alyssa.is>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <178457ee-4f66-07fd-e7bd-cee353414810@linuxfoundation.org>
Date:   Wed, 13 Oct 2021 09:57:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211013145741.2597290-1-hi@alyssa.is>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 8:57 AM, Alyssa Ross wrote:
> This seems to have been introduced by mistake in
> f49ad35cd124 ("staging: usbip: Fix IPv6 support in usbipd").
> 

Thanks for the patch.

Add a sentence or two to say what is being fixed and use Fixes tag
for the commit.

> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>   tools/usb/usbip/src/usbipd.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
> index 48398a78e88a..33e8512de7c4 100644
> --- a/tools/usb/usbip/src/usbipd.c
> +++ b/tools/usb/usbip/src/usbipd.c
> @@ -589,7 +589,6 @@ int main(int argc, char *argv[])
>   		{ "ipv4",     no_argument,       NULL, '4' },
>   		{ "ipv6",     no_argument,       NULL, '6' },
>   		{ "daemon",   no_argument,       NULL, 'D' },
> -		{ "daemon",   no_argument,       NULL, 'D' },
>   		{ "debug",    no_argument,       NULL, 'd' },
>   		{ "device",   no_argument,       NULL, 'e' },
>   		{ "pid",      optional_argument, NULL, 'P' },
> 

thanks,
-- Shuah
