Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC23CF0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378912AbhGTAK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348511AbhGSXwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:52:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:32:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r80so8988230oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SBDr1BMfTKLG/QF9tGc6lz+RFPiqfPmPF2WpUh7uf3Y=;
        b=VlFu7oHBRFv0Ew7ZWXB5xboZCXr0LNInB0c5pbyESfXby/n6hrIlps3x5QccF/EnJo
         RXMAUB8CSxa1WQDFu3MreSmvkhcWmr8Ku36nh+mnz3w9S5V9VjGUnEuQEv5JpAYv3UiT
         bWdYaL05b2sQ0xHNpBfG91WUkkzHAgIDxrGEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SBDr1BMfTKLG/QF9tGc6lz+RFPiqfPmPF2WpUh7uf3Y=;
        b=AEPPJvLNdzWaL35m4DlR1pnZZBXpZvSrR/VTDzspaXkluO60wTi6HdF2vsA7MkWkA0
         mBVq9kAQHOjG7/5W1dpBsFKXZpGId2cehx2KU/tY8IHtCCgZmb1i+JpMDZ731/LPiAob
         ytB+/Jw8CAgZgLr9pH5GwBTRM6vMIlHZ5ArXbc9LWYk6hI/kHiO/3ygtJHRjpAKenw36
         nPdP6YCXemUWNfJdcu1K5Kee8XKG7Bdok/6qMcc7YQ+vRXxYBdoZwseB4bZ7B41h9a6r
         /sT8j8iopRvcBM3JxhkmB4usjJd3tAuzKx3pyEOgzI5QUcTo/8ofdt3BU6qrEz+ArUKP
         0N1Q==
X-Gm-Message-State: AOAM5334mkhSUW0NUkO+vFvh9x+MjcrQTeeUXeqAYsP7aLVXaW0TOizh
        nH8OFvYmOoF63064v8FCoL76lw==
X-Google-Smtp-Source: ABdhPJxW8oELQL/vw1mb7V/21K8rF1gyGJoepbgb86J4ExMA4fdD5tRbdotKYMgloPjmLhdkhTSp/Q==
X-Received: by 2002:a05:6808:5d4:: with SMTP id d20mr10777218oij.43.1626741159845;
        Mon, 19 Jul 2021 17:32:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j10sm3190695oog.47.2021.07.19.17.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 17:32:39 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/245] 4.9.276-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210719144940.288257948@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c4c03a6f-f862-0ca5-c9c3-0310e219fa4f@linuxfoundation.org>
Date:   Mon, 19 Jul 2021 18:32:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210719144940.288257948@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 8:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.276 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jul 2021 14:47:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.276-rc1.gz
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

