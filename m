Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555FB3A6EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhFNT1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhFNT1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:27:06 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:24:48 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so11919326otr.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g4WUeLs2D1l7ROEskHRsmjDVIRiSibTt/wIIvDS1csE=;
        b=Mv2PMc2r7gdaDG1/wkwAIZxF2YIP09VFhR+iT79QvLBmb0xczbXHToPwd9fQaIeUIM
         seCbuXfraa9RTC5VR0DhK0Q2qgp2TG77ZrH90QmGB5DBKtsoq5rd1w3rVc6T0pXLO03A
         9FGVaH4xrzvWeo86m2dmnWmNlsLf4Q4DBzpEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4WUeLs2D1l7ROEskHRsmjDVIRiSibTt/wIIvDS1csE=;
        b=jph3XlKZsAjvw/TYJ6vq03A712v0Kb16GW0kvNt03mEi5qf5CGpkDXALHxYgyviWm5
         PAtnvbFyQABC6D9OaGewIarTQbKn0IlQ4Cggnm+sRFK+8Y0UvZn0TLrzzz0HNauvEptO
         Xx4Gd7s+z8we2SiDtieEU2zBsNcivjnjw81lGNK+SsNPcroh5CH7MF4fVnefLM5XX7MQ
         d7r5aU0w/VSJhK8Moz85ZlGzlx7Ng93Hs4pHdqXtRYaM3xWE83tBYS007LWTkSW6Ftnf
         QihZFoNmkC+MN68dQSVe5A6WDKiyKTNSsIobB78wFo/2PO3U2k/Bf0LbiYLNYgeo6/ey
         8i6Q==
X-Gm-Message-State: AOAM533LZrqaZiVQXofkk/Gz0WOmTwqOwyEdMj/JVn3JPCt3wI5JWCXL
        Z7L9V5xA5HmKkOL5vnJSmF6Rgw==
X-Google-Smtp-Source: ABdhPJwjg0opGSoKtewwlFOjm78b0d7DDvpeAyXt6UXwgDTuiLpQh7c1iWsqFzjE1QFCAnDzNC1ubQ==
X-Received: by 2002:a05:6830:1643:: with SMTP id h3mr13127189otr.76.1623698688083;
        Mon, 14 Jun 2021 12:24:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l2sm3566873otn.32.2021.06.14.12.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 12:24:47 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/42] 4.9.273-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210614102642.700712386@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a1724860-a004-5044-11e4-ee6ce73acfad@linuxfoundation.org>
Date:   Mon, 14 Jun 2021 13:24:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614102642.700712386@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 4:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.273 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Jun 2021 10:26:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.273-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
