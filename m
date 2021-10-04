Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD34217E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhJDTrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbhJDTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:47:23 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E0C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:45:34 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so23055355ota.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=07R5gtr0thKi8lqLlG7iaoLNNPBfHPfEwZ/0yOtKxFE=;
        b=WacU43aABjY1hTR7biZosffgSg/bbqO1aVw+ELOz2yAzExtR3dbygI9G0SDdePbGON
         Uxn9y/SYbtAQdFHW9ITIiKWu00McMfc7XNk4zU+hgi0efjHDgBVLNGggIRkFxEK2x/Qw
         l4ThxeZHSrFoYsMzQkWEwvKTEq5qtP34ajWLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=07R5gtr0thKi8lqLlG7iaoLNNPBfHPfEwZ/0yOtKxFE=;
        b=Mk2vyrDKaBUij2AVrOogWdzwPYtVJpgpHm8zYYpLjXc7G+nEtbLHINDwj5cqkLd6L+
         GHZ8HqmM1tqb65bu8YSzws5OVaILDEzf2UiBdBI9Cs4S7PfJTSE2/HRp1t5HH3uT72nX
         k6qcVsCaVKsseQzXLqhbXtVPcVX+fpT/M8FxwOSk6S0LhkqAZZ12O9O7MRetYabpvBQY
         XdpfEEhnMLxdTtK6iLB22xrSIBQLGfXYO91Q+W/1LgHBL9ntgQeabsulHvYcbYPdSDeP
         Mzo3L4/0N41OEtFN4pSPD59DW4OE639ot214QjRm9RgfFVq9ct0J+5r1TzsUHwWfv8te
         RXWw==
X-Gm-Message-State: AOAM530i8Htwuisp/RSAW4Vlz6+wSCdz/9nJ1S/+F4ARTUl4LJ3fgl2r
        xfjQ86FK6tJhAnKlOichNF1t6g==
X-Google-Smtp-Source: ABdhPJy3nRsOFNUpTnUX826E1YhNIUSsAil3VO1RNvSiGEF3H5QAMR/1WIwJlr6xx6dYoPwSPEde+w==
X-Received: by 2002:a05:6830:1644:: with SMTP id h4mr10446196otr.199.1633376732264;
        Mon, 04 Oct 2021 12:45:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 30sm1795392otu.18.2021.10.04.12.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 12:45:31 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/93] 5.10.71-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211004125034.579439135@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0fcac942-a969-1bc1-7f8b-15abbe4dbf0f@linuxfoundation.org>
Date:   Mon, 4 Oct 2021 13:45:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211004125034.579439135@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 6:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.71 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Oct 2021 12:50:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.71-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
